Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCEECD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqhm-0007xj-M7; Tue, 12 May 2026 13:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgf-0006p9-JY
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgb-00011r-Kf
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9ykP7jfFb11PT8krRVFcMmjBsX/sC3umQNq9cH46G0=;
 b=B05chAaCPWpWUHdl/JrhlcgmZxtMboCizPbYCs6dzLUWG907GIbpKY+uK1+HuG9DiOIfUF
 SgJ5li+Fc0wMO81ThHu+Lwoxsa51ZQnWOQaPtJIY0Pv7USg+/vScNhhgq1zdV1M4qLN67c
 rPYsDilKnADLmqdb8ta0tA2iZ1lk128=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-dWQR3lZfNZK9B3ybnmSuTA-1; Tue,
 12 May 2026 13:14:20 -0400
X-MC-Unique: dWQR3lZfNZK9B3ybnmSuTA-1
X-Mimecast-MFC-AGG-ID: dWQR3lZfNZK9B3ybnmSuTA_1778606058
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5A441800451; Tue, 12 May 2026 17:14:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED2271953947; Tue, 12 May 2026 17:14:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Ashish Anand <ashish.a6@samsung.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 9/9] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly
 during ENTDAA
Date: Tue, 12 May 2026 19:13:54 +0200
Message-ID: <20260512171354.4183887-10-clg@redhat.com>
In-Reply-To: <20260512171354.4183887-1-clg@redhat.com>
References: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ashish Anand <ashish.a6@samsung.com>

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
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260505134002.509037-1-ashish.a6@samsung.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/i3c.h |  7 +++++++
 hw/i3c/dw-i3c.c      | 16 +++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h
index 6ba90793ad01..dcf8d9b1435b 100644
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
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index d87d42be8914..17ff484c5df1 100644
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
-- 
2.54.0


