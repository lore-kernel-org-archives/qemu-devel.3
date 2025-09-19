Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B07CCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimS-0006nv-BN; Fri, 19 Sep 2025 17:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimM-0006mK-Ke
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimG-0002Yr-02
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:26 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoGu023213;
 Fri, 19 Sep 2025 21:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=lAhYz
 39Ef6apJEQ2HiOnQhNTG4BWaRdl2T6typlSKbs=; b=TS/UdcQN+8B6ZQ1Wgo7Fk
 ZGj0f3kju0uppDyVwqYEF54IiMvB66jw8rlcx4V9OxBojv078PaVgckxHKU1NvOK
 +wI0eX8kOtLwtKtjcQP9wwtB/U/dCkd+pbVELEWdD45cthCapv10McfAhtQuVMgz
 Z+ICypfZ2mohLOlKSCyMKr9xTQZfxFw/89zACeC0MTcuN/4Vkk21VzgAh9nPyPvB
 2l2t57zZ7bPy9AKPQaDFDJ0sbBEyV5aUKexo4KfUl8bvJrv5OOsF0p/as4nNMLac
 ZdMJdWlwjinHwX20EUuSQ9nAlMpUUVyGwTo09rF19H3uSPDq05w7ebRiuSNzxR5h
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JJL6Fb033686; Fri, 19 Sep 2025 21:36:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0f004301;
 Fri, 19 Sep 2025 21:36:09 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-22; Fri, 19 Sep 2025 21:36:09 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 21/22] i386/intel-iommu: Move dma_translation to x86-iommu
Date: Fri, 19 Sep 2025 21:35:14 +0000
Message-ID: <20250919213515.917111-22-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdcccb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=EvQfvFTUg0_r05Pt9eAA:9
X-Proofpoint-GUID: dv1Ya3lG8vuB3TG-IziVIgaMVywEhdhq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2/sr92aQDS+u
 UNMCDjyTuYgEl9kQiI0Tz1IvvRxo0wGl1jLLtmI+vcB7BZ+ZuG3sYwrOm5Odv17iMiMVrIs0LTL
 Y/qevg47EI5Lg8ag2B6kD0HqabtxmRuHb1Rbs5NSiBYtd343vROo5UbMTRTf5gxwM6lMa9wowqR
 RtRiWUFRB9b7sWIBImEMc4nqxgAsPXF/Pl5xIq0DXghEKm7eBUkJFf+d5dd2VlIELUk5gQP36PH
 o7hg9R7mM2HDYj4Vmdalhzu7Lc8Zg5z5lfE/PUBUe80vBVCQ3EBv2HAPKLrCDWnviBQh21iDO++
 WHA9XwzEq3bNK35ge48lsetzC5mypI2G3xuKm7zl6xWIR6y3ON0o8qahqw4L8ycxEy84lEAqBIa
 uXXh4b1l
X-Proofpoint-ORIG-GUID: dv1Ya3lG8vuB3TG-IziVIgaMVywEhdhq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

To be later reused by AMD, now that it shares similar property.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/intel_iommu.c       | 5 ++---
 hw/i386/x86-iommu.c         | 1 +
 include/hw/i386/x86-iommu.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83c5e444131a3..2b848d094cfb7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2701,7 +2701,7 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
     uint32_t changed = status ^ val;
 
     trace_vtd_reg_write_gcmd(status, val);
-    if ((changed & VTD_GCMD_TE) && s->dma_translation) {
+    if ((changed & VTD_GCMD_TE) && x86_iommu->dma_translation) {
         /* Translation enable/disable */
         vtd_handle_gcmd_te(s, val & VTD_GCMD_TE);
     }
@@ -3835,7 +3835,6 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
-    DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
 };
@@ -4553,7 +4552,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     if (s->dma_drain) {
         s->cap |= VTD_CAP_DRAIN;
     }
-    if (s->dma_translation) {
+    if (x86_iommu->dma_translation) {
             if (s->aw_bits >= VTD_HOST_AW_39BIT) {
                     s->cap |= VTD_CAP_SAGAW_39bit;
             }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index d34a6849f4ae9..c127a44bb4bc8 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -130,6 +130,7 @@ static const Property x86_iommu_properties[] = {
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
+    DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, true),
 };
 
 static void x86_iommu_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index bfd21649d0838..e89f55a5c215c 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -64,6 +64,7 @@ struct X86IOMMUState {
     OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
     bool pt_supported;          /* Whether vIOMMU supports pass-through */
+    bool dma_translation;       /* Whether vIOMMU supports DMA translation */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
 
-- 
2.43.5


