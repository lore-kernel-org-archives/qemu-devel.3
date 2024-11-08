Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CC3D64099
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 23:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Y1u-0006W7-Cr; Fri, 08 Nov 2024 18:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1t9Y1s-0006Vg-An
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:04:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1t9Y1q-0005nG-Gh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731107073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fr0chihLg4q6bM75HZcn2k9d55afs0+ROd3dApFxS+Q=;
 b=f26Lis17K/3HV9kojYQm226MSDw4IzP/kBu5/rzIa2XwsVtwrNJV/EOEfzcOAgr3fnX8fZ
 zaT90R2hB8jivXgniS8AUlcB9mWj7c/f41OT/dw/tkzson0dxoO0jNu7mwSjUTNObFoHvp
 DLcYjB+1tW05k0/DRMXq6O13YAax330=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-NXg-fQDqP-GoFX_CNPA-yg-1; Fri,
 08 Nov 2024 18:03:22 -0500
X-MC-Unique: NXg-fQDqP-GoFX_CNPA-yg-1
X-Mimecast-MFC-AGG-ID: NXg-fQDqP-GoFX_CNPA-yg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B9CD1956048; Fri,  8 Nov 2024 23:03:21 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.39.192.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AF211956054; Fri,  8 Nov 2024 23:03:17 +0000 (UTC)
From: slp@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [PATCH] hw/i386/elfboot: allocate "header" in heap
Date: Sat,  9 Nov 2024 00:03:14 +0100
Message-ID: <20241108230314.1980-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sergio Lopez <slp@redhat.com>

In x86_load_linux(), we were using a stack-allocated array as data for
fw_cfg_add_bytes(). Since the latter just takes a reference to the
pointer instead of copying the data, it can happen that the contents
have been overridden by the time the guest attempts to access them.

Instead of using the stack-allocated array, allocate some memory from
the heap, copy the contents of the array, and use it for fw_cfg.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/x86-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index bc360a9ea4..d51ebad4d6 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -697,9 +697,12 @@ void x86_load_linux(X86MachineState *x86ms,
                 strlen(kernel_cmdline) + 1);
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
 
+            setup = g_malloc(sizeof(header));
+            memcpy(setup, header, sizeof(header));
+
             fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
             fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
-                             header, sizeof(header));
+                             setup, sizeof(header));
 
             /* load initrd */
             if (initrd_filename) {
-- 
2.45.2


