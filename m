Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4EBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aP-0002fp-LE; Tue, 07 Jul 2026 07:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3aB-0002OR-Mq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a5-000872-PS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOkN6Y0FacsZXaXjU7SnYJT6FoUMhFoU1KmIBkjXb3Y=;
 b=NEbioCRSz66BHEgCHIJO/a4wzN0c6o9pFfgtSGjbC2bqMyXTujTvup+pk6dCp+EUwGPe2r
 PlhysHPO+coj9ilwMtJtT9s4Mr+lXxLgJfGp6H57mcvTcQ5VTHWvhngG994o68JX1RW+Vh
 QGSuBfx6QVEF45DX8wa4224Zh8eqXcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-GzFs5Mb6NP2WERZSPjuK8g-1; Tue,
 07 Jul 2026 07:03:11 -0400
X-MC-Unique: GzFs5Mb6NP2WERZSPjuK8g-1
X-Mimecast-MFC-AGG-ID: GzFs5Mb6NP2WERZSPjuK8g_1783422190
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 321B8195411B
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF7419560AD
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2734B21E614C; Tue, 07 Jul 2026 13:03:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 33/35] tests: switch from -mon to -object monitor-qmp
Date: Tue,  7 Jul 2026 13:02:58 +0200
Message-ID: <20260707110300.1918153-34-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Use the new preferred low level option for configuring the
QMP service in libqtest and the python Machine class used
by tests. This will avoid triggering deprecation warnings
after the subsequent commit.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-34-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/libqtest.c         | 2 +-
 python/qemu/machine/machine.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 4e22c66b75..c33c799c92 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -460,7 +460,7 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-qtest unix:%s "
                       "-qtest-log %s "
                       "-chardev socket,path=%s,id=char0 "
-                      "-mon chardev=char0,mode=control "
+                      "-object monitor-qmp,id=qmp0,chardev=char0 "
                       "-display none "
                       "-audio none "
                       "%s "
diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 3670c8cd39..bfb59d4c0b 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -304,8 +304,8 @@ def _harness_args(self) -> List[str]:
                 )
             else:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
-            args.extend(['-chardev', moncdev, '-mon',
-                         'chardev=mon,mode=control'])
+            args.extend(['-chardev', moncdev, '-object',
+                         'monitor-qmp,id=qmp,chardev=mon'])
         return args
 
     def _console_args(self, interactive: bool = False) -> List[str]:
-- 
2.54.0


