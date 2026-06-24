Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24ACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTl5-0005Y0-NO; Wed, 24 Jun 2026 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTkz-0005Ww-OS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTkx-00083S-Rv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEVKCc2701763; Wed, 24 Jun 2026 19:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=kxcVe
 vxi0wKQ/kmQccNPS48Jy2sKBGOPFWuf1+AGMkc=; b=jgbubEWJMQC64j+fr7hFX
 J5gNibvzJHJ+zVoX9n+ejSeO2u0yeayAEMjWAmmMEVHXj31n8qJg3aOo9Ntg8EXU
 yikW45dCq4OyJ+VnvNW9yAC8unoR9chylTaGcSa773bXjdiVdxTCcONi+dKo6Mcb
 tho7z6d8RHdGX6L8q6S7od8B2zfo5/vNBk5/tvkH+8ek5t+wj0AqyvOd/3Yu6NeE
 3nW83qlTcqHswhGJUWcqGWv5qF05/Uk+DsumnddI48VQ1XM5pM9/U4heBb0o/QpY
 YgbNDylxWW/32bKcuqoWfXyOdMyFbgX2muYM0qoZ3iEPiDZEU1xsMc7aUDCj/w+f
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwce503-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65OJwbLm008998; Wed, 24 Jun 2026 19:59:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas3kxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:28 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65OJuO8K004335;
 Wed, 24 Jun 2026 19:59:27 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhas3kwx-5; Wed, 24 Jun 2026 19:59:27 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 4/4] amd_iommu: Fix endianness handling for command buffer
 entries
Date: Wed, 24 Jun 2026 19:59:25 +0000
Message-ID: <20260624195925.1254462-5-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
References: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=768 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240167
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a3c3720 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=raE-tf0XYUPIjkF9jFQA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12312
X-Proofpoint-ORIG-GUID: rPegPwQNWk6mHP4DmpgrEpVcgjaGKbTq
X-Proofpoint-GUID: rPegPwQNWk6mHP4DmpgrEpVcgjaGKbTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX86SNiySSHadf
 prO7KPGOSUQqBJy1ymkU7fpf1BZwqH5/8ZToNUH/Mvu1WR5acw8LMcJjkgmtzXs7nB1chNW2gk5
 tIZxjryeLhdDSl6Y3Y/cAV6NphWH4ioh+r9WQ4qBPpJC0zlzDhklD7SynC5Be7u62zOi496Lel/
 HuCg2Hmk6YObV2TRKAhT+S1GfXeB4vXN2M4wSZ/reJf2gNeoPgCzj6W21wems8g9oSmBJhhQzVZ
 JeR33yW+yAeMZfHH5SYyTVFwKU5eybhRcx39shPMcBrmteKvN4xXliraprJEv1VTh9UwwJApCMj
 GOb594jDJyE4/j9TFNrv2PEv+oszKtoR8WXKNd/iJDdCbrsrqR5DIhNJ6ZxrISoCuwWG25PgmHs
 tpVl2TRkHbC3rLaIcW6JhFemSBQMB1fQTXZHk7fHXrJq9e7dhHQc7zCm7uyezNdC/XTOqZzVQ6C
 IWh9vmhyiLdKVnn9bQEzyRsq1eQ0FHhE+evQ10Bo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX00NnReL979Ld
 YGYEzw0Oj/AnzrwOOqDRDKsfv0TfuUgIQeWy7qm9sMgyqESqbbf9KM7lmPJ5WVRk/V6GgwE9O2q
 lemnFy3ErdVFWk4FwGyErU7SMEVuIwTHVILaQkWWfbPm+87IDICX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AMD IOMMU command buffer entries are stored in guest memory in little-endian
format. Convert command buffer with le64_to_cpu() after dma_memory_read(),
so that command handlers can all operate using host native endianness.

Remove the cpu_to_le*() conversions from command handlers, since the values
are used internally by device emulation and do not need translation.
Conversion is only necessary when reading or writing to guest memory e.g.
writing completion-wait data and event log entries.

The flow for command buffer handling is:

- Retrieve command buffer (cmd[]) from guest memory (via dma_memory_read())
- Convert command buffer to host endianness (via le64_to_cpu())
- All handlers decode fields from cmd[] in host-endian format
- All emulation code uses decoded values in host-endian format
- Use cpu_to_le*() when writing back data to guest memory

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index fdd05d9171..2821bf3260 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -278,6 +278,7 @@ static uint32_t get_next_eventlog_entry(AMDVIState *s)
 
 static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 {
+    uint64_t le_evt[2];
     uint32_t evtlog_tail_next;
 
     /* event logging not enabled */
@@ -298,8 +299,14 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         return;
     }
 
+    /*
+     * Convert event buffer to little-endian before writing it to guest memory.
+     */
+    le_evt[0] = cpu_to_le64(evt[0]);
+    le_evt[1] = cpu_to_le64(evt[1]);
+
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail,
-                         evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
+                         le_evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
@@ -545,15 +552,18 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
 static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
 {
     /* pad the last 3 bits */
-    hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
-    uint64_t data = cpu_to_le64(cmd[1]);
+    hwaddr addr = extract64(cmd[0], 3, 49) << 3;
+    uint64_t data = cmd[1];
+
+    /* Format the data to be written to guest memory as little-endian */
+    uint64_t le_data = cpu_to_le64(data);
 
     if (extract64(cmd[0], 52, 8)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
     if (extract64(cmd[0], 0, 1)) {
-        if (dma_memory_write(&address_space_memory, addr, &data,
+        if (dma_memory_write(&address_space_memory, addr, &le_data,
                              AMDVI_COMPLETION_DATA_SIZE,
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_amdvi_completion_wait_fail(addr);
@@ -1281,7 +1291,7 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
 
     trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
                              PCI_FUNC(devid));
@@ -1448,9 +1458,9 @@ static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
-    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
-    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
+    uint16_t domid = extract64(cmd[0], 32, 16);
+    uint64_t addr = extract64(cmd[1], 12, 52) << 12;
+    uint16_t flags = extract64(cmd[1], 0, 3);
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -1497,7 +1507,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -1509,7 +1519,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
         g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_devid,
                                     &devid);
     } else {
-        amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
+        amdvi_iotlb_remove_page(s, extract64(cmd[1], 12, 52) << 12,
                                 devid);
     }
     trace_amdvi_iotlb_inval();
@@ -1527,6 +1537,15 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         return;
     }
 
+    /*
+     * Commands in guest memory are little-endian. Convert once after reading
+     * so that command handlers can decode values in host native endianness.
+     * Convert back to little-endian only when writing data to guest memory via
+     * dma_memory_write().
+     */
+    cmd[0] = le64_to_cpu(cmd[0]);
+    cmd[1] = le64_to_cpu(cmd[1]);
+
     switch (extract64(cmd[0], 60, 4)) {
     case AMDVI_CMD_COMPLETION_WAIT:
         amdvi_completion_wait(s, cmd);
-- 
2.47.3


