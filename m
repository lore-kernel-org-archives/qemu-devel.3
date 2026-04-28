Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC80FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfhG-0000lz-5K; Tue, 28 Apr 2026 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wHfh9-0000kd-Gf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:29:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wHfh5-00051r-1U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:29:35 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260428102919epoutp0487a7d53a093d40943995a2c5938e4c75~qfo-zrweB2250722507epoutp04J
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:29:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260428102919epoutp0487a7d53a093d40943995a2c5938e4c75~qfo-zrweB2250722507epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1777372159;
 bh=huQEJryrU0XmT5jl2BmzMNK7M+oZGFikG3TqCT2zfyA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=sKyFRG2T9qhBU+qwbug6YVcgXMUxQSFgk+iwXrKmPzPYrGYtTUXOOGVDdAOnMqv3K
 XowLIHsu8ba4f83hOayZg4tySv8WY43je7T8tXEpC36julTy7mtGeq1xLSgQ2mgTN8
 bLAsnQVP4UQnUaHkjp248fAl+GVe8OXwan6X0e5M=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260428102916epcas5p4f00f3709e58fc8763ce15a4f9f455691~qfo8htgYZ3028230282epcas5p4e;
 Tue, 28 Apr 2026 10:29:16 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4g4c9f6m4Zz2SSKj; Tue, 28 Apr
 2026 10:29:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260428102910epcas5p3980610701ef7374b681f74d75bc34f29~qfo3RN7cv0326803268epcas5p3c;
 Tue, 28 Apr 2026 10:29:10 +0000 (GMT)
Received: from test-System-Product-Name.samsungds.net (unknown
 [107.99.41.85]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260428102904epsmtip19017acd25f694c37cdc49e2d40f66647~qfox8gvke3268832688epsmtip1a;
 Tue, 28 Apr 2026 10:29:04 +0000 (GMT)
From: Ashish Anand <ashish.a6@samsung.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, clg@kaod.org, jamin_lin@aspeedtech.com,
 nabihestefan@google.com, saurabh@samsung.com, vishwa.mg@samsung.com,
 y.kaushal@samsung.com, ashish.anand202@gmail.com, Ashish Anand
 <ashish.a6@samsung.com>
Subject: [PATCH] hw/i3c/dw-i3c: Fix incorrect BCR/DCR extraction during ENTDAA
Date: Tue, 28 Apr 2026 15:55:03 +0530
Message-ID: <20260428102503.1641162-1-ashish.a6@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260428102910epcas5p3980610701ef7374b681f74d75bc34f29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260428102910epcas5p3980610701ef7374b681f74d75bc34f29
References: <CGME20260428102910epcas5p3980610701ef7374b681f74d75bc34f29@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ashish.a6@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The target_info union in dw_i3c_addr_assign_cmd() declares pid, bcr,
and dcr as separate union members, causing them to all alias b[0]
rather than their correct positions in the ENTDAA response buffer.
This results in dw_i3c_update_char_table() being called with BCR and
DCR both read from b[0] instead of b[6] and b[7] respectively,
corrupting the device characteristics table on every ENTDAA operation.

Fixed this by replacing the broken members with a nested struct using
uint8_t fields, matching the I3C spec wire format: six bytes of PID
followed by BCR and DCR.

Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
---

The nested struct approach avoids bitfields and __attribute__((packed)),
both of which introduce implementation-defined behavior for this layout.

This bug was discovered during end-to-end ENTDAA testing where BCR and
DCR values observed in the char table register did not match the target's
actual BCR and DCR values.

A follow-up patch adding a standalone DW I3C test machine and qtest
coverage for ENTDAA, private transfers, and IBI is planned.

 hw/i3c/dw-i3c.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index d87d42be89..1c5e09ccbb 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1507,9 +1507,11 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
     for (i = 0; i < cmd.dev_count; i++) {
         uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
         union {
-            uint64_t pid:48;
-            uint8_t bcr;
-            uint8_t dcr;
+            struct {
+                uint8_t pid[6];
+                uint8_t bcr;
+                uint8_t dcr;
+            };
             uint32_t w[2];
             uint8_t b[8];
         } target_info;
@@ -1544,9 +1546,12 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
             err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
             break;
         }
-        dw_i3c_update_char_table(s, cmd.dev_index + i,
-                                            target_info.pid, target_info.bcr,
-                                            target_info.dcr, addr);
+        uint64_t pid = 0;
+        for (int j = 0; j < 6; j++) {
+            pid |= (uint64_t)target_info.pid[j] << (j * 8);
+        }
+        dw_i3c_update_char_table(s, cmd.dev_index + i, pid, target_info.bcr,
+                                 target_info.dcr, addr);
 
         /* Push the PID, BCR, and DCR to the RX queue. */
         dw_i3c_push_rx(s, target_info.w[0]);
-- 
2.43.0


