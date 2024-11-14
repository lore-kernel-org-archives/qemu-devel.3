Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC57D68B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdA2-0000Cd-TI; Thu, 14 Nov 2024 11:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9q-0008Vv-LP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9p-0002dC-5n
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM0oP4uYaxWqpfihOrRXw+G4JgNWK9m48rCXi/c32Qk=;
 b=TL/YTw/wtK+KCxBqOsgwXmVOP3v6GRRgPQpaXKypQXaIN+if++YP3MDFkbc5br/6gi+bos
 z9dSnM2p/l1vsIZ7ts/Xh07HnNM/asxqxdcYmsiCmXyVSqqneqTRe7nBeKw5R4TWWUiqLP
 R+8OF5MrOAZeYt+eTJPH0awcU5vv2vE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-q_aedtBNM3iGbOuD7hKhsQ-1; Thu,
 14 Nov 2024 11:57:19 -0500
X-MC-Unique: q_aedtBNM3iGbOuD7hKhsQ-1
X-Mimecast-MFC-AGG-ID: q_aedtBNM3iGbOuD7hKhsQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B285B1955BFC; Thu, 14 Nov 2024 16:57:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FFC51955F43; Thu, 14 Nov 2024 16:57:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 8/8] vl: use qmp_device_add() in qemu_create_cli_devices()
Date: Thu, 14 Nov 2024 17:56:57 +0100
Message-ID: <20241114165657.254256-9-kwolf@redhat.com>
In-Reply-To: <20241114165657.254256-1-kwolf@redhat.com>
References: <20241114165657.254256-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

qemu_create_cli_devices() should use qmp_device_add() to match the
behavior of the QMP monitor. A comment explained that libvirt changes
implementing strict CLI syntax were needed.

Peter Krempa <pkrempa@redhat.com> has confirmed that modern libvirt uses
the same JSON for -device (CLI) and device_add (QMP). Go ahead and use
qmp_device_add().

Cc: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240827192751.948633-3-stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 system/vl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index d217b3d64d..e3f7d3a156 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2653,17 +2653,11 @@ static void qemu_create_cli_devices(void)
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
2.47.0


