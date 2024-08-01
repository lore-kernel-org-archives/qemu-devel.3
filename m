Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A600C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWRh-00060o-SL; Thu, 01 Aug 2024 10:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sZWRa-0005lD-Uy
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sZWRZ-0006pt-FI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722521172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CA2Cbh21PJW83tA6MUfWk+6l8XsWIRz9klDdAGGv+XI=;
 b=UOl59FRMB9anMfIMK4/f6ObaQNEmzIlvUQcBg1Ni5XOd6667hVV/7BDTop9mcMsmAbEFUW
 Zpb0uwXSqGxuMngd4bRMhVoN4Gkyg2WCSEZ4H41Sk5/4Zpl+atT4ZffLRUqqY2zuTUwJdr
 RrcaeXBT7iIrHi922wu6Tk0/8XWIS00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-DfrT91rnNEGEdwbMrHe-5Q-1; Thu,
 01 Aug 2024 10:06:10 -0400
X-MC-Unique: DfrT91rnNEGEdwbMrHe-5Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F4CA1955D4A; Thu,  1 Aug 2024 14:06:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FB6C19560AE; Thu,  1 Aug 2024 14:06:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 armbru@redhat.com, pkrempa@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/2] vl: use qmp_device_add() in qemu_create_cli_devices()
Date: Thu,  1 Aug 2024 10:05:52 -0400
Message-ID: <20240801140552.1021693-3-stefanha@redhat.com>
In-Reply-To: <20240801140552.1021693-1-stefanha@redhat.com>
References: <20240801140552.1021693-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 system/vl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 9e8f16f155..0beb8bfb57 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2651,17 +2651,11 @@ static void qemu_create_cli_devices(void)
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
2.45.2


