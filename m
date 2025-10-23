Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180FFCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkT-0001Jm-3f; Thu, 23 Oct 2025 07:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkN-0001I2-PZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkL-0001ad-8A
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N0CwAm024633;
 Thu, 23 Oct 2025 11:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SkGLAI
 6wR3emVs7t6GIaXUPTfsowf3owzDMsV/QcsGw=; b=Z62gMKFGF0EcC2NNJc1mwp
 QUI1H9bTTPFMIIoNfBPMQF6/j0Ibs6q/dxE7Q8VH3GxCGecxB0Z9HJWIZuVkKUR8
 NSxCm28XnoaLx4RrDYBVZQOimLYti8HbBs/2dp0NWYDpV2lv3HZ4q5K1YbjjWDi3
 xFoCidZr0mV4HgmSqpXGdpEXQpNFY1zsq+aXLkeqE0SxAxcErZBFWcuuKzQtKiJz
 BbTRG7lnIlUknkogxrLLs9/1GNYrTHN4QOZSo8U48ZiuUwcpYZZmFkN8l6plfdJA
 F2wapu94oXbGpDbr5ssonCmH8FtC7gNty4oyYS5fmdUxx4RtpxAm6NT8RkzwJQCw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgj1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA8le5024690;
 Thu, 23 Oct 2025 11:44:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5ds3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBidsC7864602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F31420049;
 Thu, 23 Oct 2025 11:44:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40E4220040;
 Thu, 23 Oct 2025 11:44:38 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:38 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/32] ppc/spapr: remove deprecated machine pseries-4.0
Date: Thu, 23 Oct 2025 17:13:55 +0530
Message-ID: <20251023114422.3675018-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PuIBsfIsj6kvwEMUHdBw8hQJcdb-HEHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0StCdBkVjNzj
 /mtbUv6uhVGAtHPJ3XN5USncIRMkwvZciMGHoxxsecYbWJJdTIVcF1KZccegpASZ6zn3sqemtEI
 11OAV6hGYh1IFlFTFtXlxKTd+cZYHtZngQdUoWtOwNqOFqXiMfcrseZGTY02CV08n5rCKoKHhys
 Xep2WTDihFm/UrkuKREl9Fdw9b0xBENKQJF0aiArtbO8/+5EkeP7CMQsjxf7sx58u/CxCzb7VhQ
 5GbCLtkxroj9ddg5Us3+MRQCx86TwYSugh8inUdMfa8aXtBzcUcl40UwZT9vRtL2XTFJyh97r2E
 YBNFO0pWrGQH9snLwrbU+Fmh+/lZPTqXBW7M1B+ygdoyaBZK+kUNYaF68IoqiZDhOQh44tSdVkt
 s2D3WMX71Wq4mhQdS9bIKjyY1xUGgw==
X-Proofpoint-GUID: PuIBsfIsj6kvwEMUHdBw8hQJcdb-HEHf
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa152a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=VqWj-gOvcHZ2Xb4X8q8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

pseries-4.0 had been deprecated and due for removal now as per policy.
Also remove pre-4.1 migration hacks which were introduced for backward
compatibility.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
[PMD: Remove SpaprMachineClass::pre_4_1_migration field]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-9-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  3 ---
 hw/ppc/spapr.c         | 27 ---------------------------
 hw/ppc/spapr_caps.c    | 12 +-----------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1db67784de..58d31b096c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -139,11 +139,8 @@ struct SpaprCapabilities {
  * SpaprMachineClass:
  */
 struct SpaprMachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
-    /*< public >*/
-    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab46e3bd60..ea7d2a03aa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4969,33 +4969,6 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 1);
 
-/*
- * pseries-4.0
- */
-static bool phb_placement_4_0(SpaprMachineState *spapr, uint32_t index,
-                              uint64_t *buid, hwaddr *pio,
-                              hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    if (!spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma,
-                             liobns, errp)) {
-        return false;
-    }
-    return true;
-}
-static void spapr_machine_4_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    smc->phb_placement = phb_placement_4_0;
-    smc->irq = &spapr_irq_xics;
-    smc->pre_4_1_migration = true;
-}
-
-DEFINE_SPAPR_MACHINE(4, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0f94c192fd..170795ad6a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -66,7 +66,6 @@ typedef struct SpaprCapabilityInfo {
     void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
     void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
-    bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -336,11 +335,6 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
-static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
-{
-    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;
-}
-
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
                               uint32_t pshift)
 {
@@ -793,7 +787,6 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
-        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
@@ -982,11 +975,8 @@ int spapr_caps_post_migration(SpaprMachineState *spapr)
 static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
     SpaprMachineState *spapr = opaque;                  \
-    bool (*needed)(void *opaque) =                      \
-        capability_table[cap].migrate_needed;           \
                                                         \
-    return needed ? needed(opaque) : true &&            \
-           spapr->cmd_line_caps[cap] &&                 \
+    return spapr->cmd_line_caps[cap] &&                 \
            (spapr->eff.caps[cap] !=                     \
             spapr->def.caps[cap]);                      \
 }                                                       \
-- 
2.43.5


