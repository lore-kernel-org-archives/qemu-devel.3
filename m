Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F21C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1rK-0002KS-Vj; Tue, 27 Aug 2024 15:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rJ-0002Dd-8c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rH-0003BA-N6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724786882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLi0GBHmoRUxzImZ2geRrYkA43vgUrGGSmvb2Gypt2M=;
 b=IHYeeus/GuixqypfnZ6Bj9OnFG+zSBnLHCv1J5qnMnR1rzriwbjmRV6mJdZFXCxrzp+fYg
 cwyPx69pEFEg3HsdCT0OJ4jjkPeQYsKnMyz5Xt0I8pkexoQ3cpdjBh+nyWDT5Us6WbSixN
 XWqZwBLkB3ADazPh6IKesumD0GZJlnw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-FzomHrIiONC_MZeU5XzUnw-1; Tue,
 27 Aug 2024 15:27:58 -0400
X-MC-Unique: FzomHrIiONC_MZeU5XzUnw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB53A1955F08; Tue, 27 Aug 2024 19:27:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 339F01955D89; Tue, 27 Aug 2024 19:27:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 2/2] vl: use qmp_device_add() in qemu_create_cli_devices()
Date: Tue, 27 Aug 2024 15:27:51 -0400
Message-ID: <20240827192751.948633-3-stefanha@redhat.com>
In-Reply-To: <20240827192751.948633-1-stefanha@redhat.com>
References: <20240827192751.948633-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu_create_cli_devices() should use qmp_device_add() to match the
behavior of the QMP monitor. A comment explained that libvirt changes
implementing strict CLI syntax were needed.

Peter Krempa <pkrempa@redhat.com> has confirmed that modern libvirt uses
the same JSON for -device (CLI) and device_add (QMP). Go ahead and use
qmp_device_add().

Cc: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 system/vl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 01b8b8e77a..3db63af764 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2652,17 +2652,11 @@ static void qemu_create_cli_devices(void)
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
     QTAILQ_FOREACH(opt, &device_opts, next) {
-        DeviceState *dev;
+        QObject *ret_data = NULL;
+
         loc_push_restore(&opt->loc);
-        /*
-         * TODO Eventually we should call qmp_device_add() here to make sure it
-         * behaves the same, but QMP still has to accept incorrectly typed
-         * options until libvirt is fixed and we want to be strict on the CLI
-         * from the start, so call qdev_device_add_from_qdict() directly for
-         * now.
-         */
-        dev = qdev_device_add_from_qdict(opt->opts, true, &error_fatal);
-        object_unref(OBJECT(dev));
+        qmp_device_add(opt->opts, &ret_data, &error_fatal);
+        assert(ret_data == NULL); /* error_fatal aborts */
         loc_pop(&opt->loc);
     }
     rom_reset_order_override();
-- 
2.46.0


