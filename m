Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44688CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6n2f-0005u9-BL; Thu, 09 Oct 2025 05:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2b-0005rB-VD; Thu, 09 Oct 2025 05:34:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2W-0001l8-8v; Thu, 09 Oct 2025 05:34:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59962VI8031850;
 Thu, 9 Oct 2025 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bcZgkA
 2B7l0ubR6zJsm659M6fCSWFRvN7M+ZtYY+20A=; b=FWZ9a9hNz9nbZHMTUJFBXw
 s5DyZ+wv4yJd6JuCfaGB8UGeM0lyn7V2VreJbvAoQx3jONs170BHyBmKqLEUXClr
 BpUKKxpAlyVCQQuQE7FQiYuhSreqKhgotW+vj3TMyzy+L+F19fc2eYFRfyS17RDI
 O3M0o0hvuoXnYD0DHcNAnnOI131QlOnRCpIBDLynS+oHAiISFdhkCm7EyoQwQYi/
 wr/DhMICqOpwbrtqO0NKCbulSm/HVEQB4JAvnVd18FDmLlMWeN1q7wdJmwoLjrgi
 j1QAyzsNAATsj0vbWlKafq6dQknFm4M5ddD7G5ULqSwju5Ny2AUTS2HWzV0TQBIg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv823xxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5999YFkT026169;
 Thu, 9 Oct 2025 09:34:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv823xxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59987eig008363;
 Thu, 9 Oct 2025 09:34:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanurs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5999YBqf53739894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 09:34:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FA5D20082;
 Thu,  9 Oct 2025 09:34:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5959E20072;
 Thu,  9 Oct 2025 09:34:10 +0000 (GMT)
Received: from ltcfuji9aw-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 09:34:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, philmd@linaro.org
Cc: npiggin@gmail.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/5] ppc/spapr: remove deprecated machine pseries-4.0
Date: Thu,  9 Oct 2025 14:40:55 -0400
Message-ID: <20251009184057.19973-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009184057.19973-1-harshpb@linux.ibm.com>
References: <20251009184057.19973-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KrpAGGWN c=1 sm=1 tr=0 ts=68e78197 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=v6HMyaa53sa_SYkxinkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22 a=oH34dK2VZjykjzsv8OSz:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: Uy2lbuPEs51KFUE8t2Tx-kSd8t4aEim0
X-Proofpoint-ORIG-GUID: LXnNpwEonQku4CzHe9qhF7qW1OVBG4n5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5fnY52P94y0l
 gWQXbhGCTE2o3WEntz9fZqvoTEfmoXQfmeeDhItqDCf6Odx5fsiIhI2gGNrc7qo8rnetET6ynjA
 y1wTiwEzU0S/M8OrWAuWN+2q2dmbnCCaKIPiU05vDDyiWNy31pmiRX2aergpNvKVPL3nzKK3Ge3
 NLHG4E0AkDIVRpxA7125jd5btTdt2+uUgbYcgiy2szt9ZrS2Umrul4St+tubDfI10U52EXNX9HK
 Mf4RRxhyuswVRmbL6rJvFG6XPZuLAnWFImej8hxoyv15qUPOaA+FHfm38TbNCeklDfO4JwwzASk
 c3mvgZEVZ469cIibPlbuZW5H2TW13/IgGykPIB3GcZGOfVhUR231H6QRzujxEP8Quq4QFJP50Q9
 pzS5ciRBlVpczDIrl3ZnoZAB/ukiEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 27 ---------------------------
 hw/ppc/spapr_caps.c    | 12 +-----------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 02b66f7ffa..328681a585 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -144,7 +144,6 @@ struct SpaprMachineClass {
 
     /*< public >*/
     uint32_t nr_xirqs;
-    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 48526ad69c..b93015c335 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4976,33 +4976,6 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
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
2.51.0


