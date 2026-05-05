Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE065CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKG4l-0006QY-R9; Tue, 05 May 2026 09:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wKG4f-0006QE-TZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:44:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1wKG4b-0005Y9-CR
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:44:33 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260505134414epoutp028f7db25883de036b6454e6469c29723a~sr0Lh7Fmz1578915789epoutp02S
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 13:44:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260505134414epoutp028f7db25883de036b6454e6469c29723a~sr0Lh7Fmz1578915789epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1777988654;
 bh=taUaHAjbUiiqAmnsWoKPu2By+ZFYvXg2C9qYVBIpdZw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=rJ1nAM1HPWp48QDcDYhzilENKibt13D6tknk5rdji3frDcj91t5CB9yqrjm0tvSdA
 4rMNntF3l/FeNQsc1vsdfOxeYw97yWAAdRtFP9r30Fak6IdYp535XyuZW4cwztBMSq
 HGgt7/hYgpZpiVkpXwZMn7vLodSOEng48laYPX9o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260505134414epcas5p1b35ddc82e7dc19e2e4e83c2a0494e82b~sr0LDO73z1065610656epcas5p19;
 Tue,  5 May 2026 13:44:14 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4g909T1t7zz3hhT7; Tue,  5 May
 2026 13:44:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072~sr0JZ6uZR1065410654epcas5p15;
 Tue,  5 May 2026 13:44:12 +0000 (GMT)
Received: from test-System-Product-Name.samsungds.net (unknown
 [107.99.41.85]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260505134408epsmtip2bfd72c8cfe11ac308f509d6d515e37f7~sr0GA7R0f0069300693epsmtip2V;
 Tue,  5 May 2026 13:44:08 +0000 (GMT)
From: Ashish Anand <ashish.a6@samsung.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, clg@kaod.org, jamin_lin@aspeedtech.com,
 nabihestefan@google.com, saurabh@samsung.com, vishwa.mg@samsung.com,
 y.kaushal@samsung.com, ashish.anand202@gmail.com, Ashish Anand
 <ashish.a6@samsung.com>
Subject: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly
 during ENTDAA
Date: Tue,  5 May 2026 19:10:02 +0530
Message-ID: <20260505134002.509037-1-ashish.a6@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072
References: <CGME20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ashish.a6@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Fix by replacing the broken members with uint64_t d and extracting fields
per the I3C spec ENTDAA wire format.

Additionally, dw_i3c_update_char_table() incorrectly splits PID across
LOC1 and LOC2 at bit 32. Per the Linux kernel HCI driver
(drivers/i3c/master/mipi-i3c-hci/dct_v1.c), the DCT layout requires
LOC1 to hold pid[47:16] and LOC2 to hold pid[15:0]. Fix the split
accordingly.

Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
---

Changes from v1 :
1. Replaced broken union members with uint64_t d, added wire format comment.
2. Replaced loop with be64_to_cpu(target_info.d) >> 16.
3. Fixed LOC1/LOC2 split at bit 16 in dw_i3c_update_char_table.
4. Added comment to i3c.h clarifying how core.c transmits t->pid during ENTDAA.

Link to v1 - https://lore.kernel.org/qemu-devel/exdu52mug6fh3bwj7ofo3jlltyuwjfnddxobio4w3jhaq6uv7k@boxo3j5ocef2/T/#t

This bug was discovered during end-to-end ENTDAA testing where BCR and
DCR values observed in the char table register did not match the target's
actual BCR and DCR values.

 hw/i3c/dw-i3c.c      | 16 +++++++---------
 include/hw/i3c/i3c.h |  7 +++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index d87d42be89..17ff484c5d 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1459,11 +1459,10 @@ static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pid,
                                           P_DEV_CHAR_TABLE_START_ADDR) /
                                           sizeof(uint32_t)) +
                                           (offset * sizeof(uint32_t));
-    s->regs[dev_index] = pid & 0xffffffff;
-    pid >>= 32;
+    s->regs[dev_index] = (pid >> 16) & 0xffffffff;
     s->regs[dev_index + 1] = FIELD_DP32(s->regs[dev_index + 1],
                                         DEVICE_CHARACTERISTIC_TABLE_LOC2,
-                                        MSB_PID, pid);
+                                        MSB_PID, pid & 0xffff);
     s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
                                         DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR,
                                         dcr);
@@ -1507,10 +1506,9 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
     for (i = 0; i < cmd.dev_count; i++) {
         uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
         union {
-            uint64_t pid:48;
-            uint8_t bcr;
-            uint8_t dcr;
+            uint64_t d;
             uint32_t w[2];
+            /* Per I3C spec: b[0]=PID MSB, b[5]=PID LSB, b[6]=BCR, b[7]=DCR */
             uint8_t b[8];
         } target_info;
 
@@ -1544,9 +1542,9 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
             err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
             break;
         }
-        dw_i3c_update_char_table(s, cmd.dev_index + i,
-                                            target_info.pid, target_info.bcr,
-                                            target_info.dcr, addr);
+        uint64_t pid = be64_to_cpu(target_info.d) >> 16;
+        dw_i3c_update_char_table(s, cmd.dev_index + i, pid, target_info.b[6],
+                                 target_info.b[7], addr);
 
         /* Push the PID, BCR, and DCR to the RX queue. */
         dw_i3c_push_rx(s, target_info.w[0]);
diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h
index 6ba90793ad..dcf8d9b143 100644
--- a/include/hw/i3c/i3c.h
+++ b/include/hw/i3c/i3c.h
@@ -138,6 +138,13 @@ struct I3CTarget {
     uint8_t static_address;
     uint8_t dcr;
     uint8_t bcr;
+    /*
+     * Provisioned ID. Since core.c sends this LSB-first during ENTDAA
+     * via (pid >> (offset * 8)) & 0xff, targets must store it
+     * pre-reversed so that pid[47:40] goes on the wire first, as
+     * required by the I3C spec.
+     *  e.g. for a device with pid 0xAABBCCDDEEFF, store 0xFFEEDDCCBBAA.
+     */
     uint64_t pid;
 
     /* CCC State tracking. */
-- 
2.43.0


