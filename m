Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12792CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIAo-0005jg-Tz; Wed, 10 Jun 2026 08:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAn-0005X2-2B
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAl-0005U0-AG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781095002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq8vze3CmtqeKKZD2p38fn16joZk/OFqSqf7rJxOz7g=;
 b=YpeBwnckVo1u6iEWRRNA4g4kpZCHIK3B/DCeQuuRLK3/6yQuN3oSnfB3avL5+oDACszP/I
 jsrOO/OdJzTG+5AFqihFZLCETAl7AnGq87CFkkC1NoFcl+z52HQgtn8hQu1v/5/18APqUj
 LBfu+PcTnAyhA/c+TNAq6DKKaDiTUdU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-ningKoNVPvaotw9EFzZlNA-1; Wed,
 10 Jun 2026 08:36:38 -0400
X-MC-Unique: ningKoNVPvaotw9EFzZlNA-1
X-Mimecast-MFC-AGG-ID: ningKoNVPvaotw9EFzZlNA_1781094997
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08C6418DB428; Wed, 10 Jun 2026 12:36:37 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 715BF36535; Wed, 10 Jun 2026 12:36:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 34/35] tests: switch from -mon to -object monitor-qmp
Date: Wed, 10 Jun 2026 13:34:14 +0100
Message-ID: <20260610123415.2883603-35-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the new preferred low level option for configuring the
QMP service in libqtest and the python Machine class used
by tests. This will avoid triggering deprecation warnings
after the subsequent commit.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/machine/machine.py | 4 ++--
 tests/qtest/libqtest.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ebb58d5b68..5f4845f5fb 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -304,8 +304,8 @@ def _base_args(self) -> List[str]:
                 )
             else:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
-            args.extend(['-chardev', moncdev, '-mon',
-                         'chardev=mon,mode=control'])
+            args.extend(['-chardev', moncdev, '-object',
+                         'monitor-qmp,id=qmp,chardev=mon'])
 
         if self._machine is not None:
             args.extend(['-machine', self._machine])
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
-- 
2.54.0


