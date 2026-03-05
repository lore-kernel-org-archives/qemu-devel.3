Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BAEF47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCxh-0008Kg-I8; Thu, 05 Mar 2026 12:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxO-0007fA-Oe
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxK-0003aD-G3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FafuM0kfPRdGgBBe2UUn28g5e/Q1yO3e0b8qE9HejYY=;
 b=I5RaUOquazVWHVVoS1IKYqe6dueZBjQdJMWPxt/IX/YsBxcBI6PNvWdndbAlAoGQVrdNU3
 MopyF2ndQ/wC9Zy3lssLBOGDsM4lyNEjXoKPjhI5mA8yznnOOPoHgaZkQYd+Ny6oRmftOd
 yDgTzTa+7UuK1DtwNe9GeDgI6twMXXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-pvRsxkgmPWOU_KbxLyf4cQ-1; Thu,
 05 Mar 2026 12:57:45 -0500
X-MC-Unique: pvRsxkgmPWOU_KbxLyf4cQ-1
X-Mimecast-MFC-AGG-ID: pvRsxkgmPWOU_KbxLyf4cQ_1772733462
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A16A195608F; Thu,  5 Mar 2026 17:57:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F3D53003E9E; Thu,  5 Mar 2026 17:57:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/38] hw/i3c/dw-i3c: Add register RO field masks
Date: Thu,  5 Mar 2026 18:56:43 +0100
Message-ID: <20260305175711.1119025-11-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Adds read-only register masks for the DwC I3C controller.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 28da6016a1ea..87c8f63da96d 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0x00000023,
 };
 
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
+    [R_DEVICE_CTRL]                 = 0x04fffe00,
+    [R_DEVICE_ADDR]                 = 0x7f807f80,
+    [R_HW_CAPABILITY]               = 0xffffffff,
+    [R_IBI_QUEUE_STATUS]            = 0xffffffff,
+    [R_DATA_BUFFER_THLD_CTRL]       = 0xf8f8f8f8,
+    [R_IBI_QUEUE_CTRL]              = 0xfffffff0,
+    [R_RESET_CTRL]                  = 0xffffffc0,
+    [R_SLV_EVENT_CTRL]              = 0xffffff3f,
+    [R_INTR_STATUS]                 = 0xffff809f,
+    [R_INTR_STATUS_EN]              = 0xffff8080,
+    [R_INTR_SIGNAL_EN]              = 0xffff8080,
+    [R_INTR_FORCE]                  = 0xffff8000,
+    [R_QUEUE_STATUS_LEVEL]          = 0xffffffff,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0xffffffff,
+    [R_PRESENT_STATE]               = 0xffffffff,
+    [R_CCC_DEVICE_STATUS]           = 0xffffffff,
+    [R_I3C_VER_ID]                  = 0xffffffff,
+    [R_I3C_VER_TYPE]                = 0xffffffff,
+    [R_DEVICE_ADDR_TABLE_POINTER]   = 0xffffffff,
+    [R_DEV_CHAR_TABLE_POINTER]      = 0xffcbffff,
+    [R_SLV_PID_VALUE]               = 0xffff0fff,
+    [R_SLV_CHAR_CTRL]               = 0xffffffff,
+    [A_VENDOR_SPECIFIC_REG_POINTER] = 0xffffffff,
+    [R_SLV_MAX_LEN]                 = 0xffffffff,
+    [R_MAX_READ_TURNAROUND]         = 0xffffffff,
+    [R_MAX_DATA_SPEED]              = 0xffffffff,
+    [R_SLV_INTR_REQ]                = 0xfffffff0,
+    [R_SLV_TSX_SYMBL_TIMING]        = 0xffffffc0,
+    [R_DEVICE_CTRL_EXTENDED]        = 0xfffffff8,
+    [R_SCL_I3C_OD_TIMING]           = 0xff00ff00,
+    [R_SCL_I3C_PP_TIMING]           = 0xff00ff00,
+    [R_SCL_I2C_FMP_TIMING]          = 0xff000000,
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   = 0x0000fff0,
+    [R_BUS_IDLE_TIMING]             = 0xfff00000,
+    [R_EXTENDED_CAPABILITY]         = 0xffffffff,
+    [R_SLAVE_CONFIG]                = 0xffffffff,
+};
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
 
     trace_dw_i3c_write(s->id, offset, value);
 
+    value &= ~dw_i3c_ro[addr];
     switch (addr) {
     case R_HW_CAPABILITY:
     case R_RESPONSE_QUEUE_PORT:
-- 
2.53.0


