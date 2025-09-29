Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C3FCCA46F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8s-0004ca-UT; Mon, 29 Sep 2025 12:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7d-0002uc-Vv
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7V-0002mm-EH
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg3AXUFQQdYzEBTwL4tKiMBUpbnLVkwVjUCuTxAaa8I=;
 b=ReYwA/2sp/PZd5q6sgvZYdBBGh7sVO7bvnNLBcH49CtK52pnuuXQPHMjnR+Uqdz6pshCE7
 AaLzyFshRctp0HF0cYE/pqFsH7oysBbCDoUdmK7whzYYWwuwIf4Jp6T3ozIcbgZ+hUV6Jf
 2hqJFCHyjUMk+un+tu/RCMuEk4AD0pE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-V8su02_aPHOIFSjg_1ineg-1; Mon,
 29 Sep 2025 12:52:54 -0400
X-MC-Unique: V8su02_aPHOIFSjg_1ineg-1
X-Mimecast-MFC-AGG-ID: V8su02_aPHOIFSjg_1ineg_1759164773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F92D1800289; Mon, 29 Sep 2025 16:52:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACD84180047F; Mon, 29 Sep 2025 16:52:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/32] hw/misc/aspeed_sbc: Add CAMP2 support for OTP data reads
Date: Mon, 29 Sep 2025 18:52:05 +0200
Message-ID: <20250929165230.797471-8-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

The OTP space contains three types of entries: data, conf, and strap.
Data entries consist of two DWORDs, while the other types contain
only one DWORD. This change adds the R_CAMP2 register (0x024 / 4) to
store the second DWORD when reading from the OTP data region.

With this enhancement, OTP reads now correctly return both DWORDs for
data entries via the CAMP registers, along with improved address
validation and error handling.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-8-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sbc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 052c70fd422f..787e2d048997 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -22,6 +22,7 @@
 #define R_ADDR          (0x010 / 4)
 #define R_STATUS        (0x014 / 4)
 #define R_CAMP1         (0x020 / 4)
+#define R_CAMP2         (0x024 / 4)
 #define R_QSR           (0x040 / 4)
 
 /* R_STATUS */
@@ -50,6 +51,8 @@
 #define SBC_OTP_CMD_READ 0x23b1e361
 #define SBC_OTP_CMD_PROG 0x23b1e364
 
+#define OTP_DATA_DWORD_COUNT        (0x800)
+#define OTP_TOTAL_DWORD_COUNT       (0x1000)
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -72,6 +75,16 @@ static bool aspeed_sbc_otp_read(AspeedSBCState *s,
     MemTxResult ret;
     AspeedOTPState *otp = &s->otp;
     uint32_t value, otp_offset;
+    bool is_data = false;
+
+    if (otp_addr < OTP_DATA_DWORD_COUNT) {
+        is_data = true;
+    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid OTP addr 0x%x\n",
+                      otp_addr);
+        return false;
+    }
 
     otp_offset = otp_addr << 2;
     ret = address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
@@ -85,6 +98,20 @@ static bool aspeed_sbc_otp_read(AspeedSBCState *s,
     s->regs[R_CAMP1] = value;
     trace_aspeed_sbc_otp_read(otp_addr, value);
 
+    if (is_data) {
+        ret = address_space_read(&otp->as, otp_offset + 4,
+                                 MEMTXATTRS_UNSPECIFIED,
+                                 &value, sizeof(value));
+        if (ret != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Failed to read OTP memory, addr = %x\n",
+                          otp_addr);
+            return false;
+        }
+        s->regs[R_CAMP2] = value;
+        trace_aspeed_sbc_otp_read(otp_addr + 1, value);
+    }
+
     return true;
 }
 
-- 
2.51.0


