Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E240C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXDX-00076x-6c; Wed, 07 May 2025 01:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDQ-00070B-HT; Wed, 07 May 2025 01:21:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDL-0001aS-0J; Wed, 07 May 2025 01:21:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546J3oOa011770;
 Wed, 7 May 2025 05:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XdT90U
 52+j2IljeO0wsAuAEINZzEMpZvfLriRWMvneo=; b=OrtzdJYgF3hZnMwbR6LNsJ
 j9fMRHs9b4p1uFqUJ7N3+2Nef03TKACG6lyldPYXVlwpIxyH8uysXfXjDfZ+Ep5A
 ylkePD34kWT9kWAyz5oHMm1P1aGUgEyJNlWsg6h3XoL1N+fzAbwAGEYGCtPqFmAv
 4yqzB/8JfJoyIZ4Om33ZcETQmRyNQQZTJZogZsGGvxZl73inTKzlgT71IT406DRO
 E6TBH6I1soy42jqazqijyzOEDif9jNQ2nctj+EALC9mX2LU0HUeMJe0i7zUCZw0p
 EgFS4c1izA/PPWiVNq4XHAreHwmsSYoAN78HnZHVU31RD7fsXUvL7d6BRlmMfJfw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsmm6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5475Kx4o015982;
 Wed, 7 May 2025 05:20:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsmm6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5471e9jB014137;
 Wed, 7 May 2025 05:20:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkpw2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5475KvcT41288050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 05:20:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12D2F2007B;
 Wed,  7 May 2025 05:20:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D72620040;
 Wed,  7 May 2025 05:20:56 +0000 (GMT)
Received: from ltcblue8v9-lp2.aus.stglabs.ibm.com (unknown [9.40.192.95])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 May 2025 05:20:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH 3/3] ppc/spapr: remove deprecated machine pseries-4.0
Date: Wed,  7 May 2025 01:20:48 -0400
Message-ID: <20250507052048.90559-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507052048.90559-1-harshpb@linux.ibm.com>
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CLAqXQrD c=1 sm=1 tr=0 ts=681aedbb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=v6HMyaa53sa_SYkxinkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: vMXZeUUzWcLWwZpAGqnslx5_9_DVYvHq
X-Proofpoint-ORIG-GUID: 6Ozufvx8uI0oX_zdmZV8Ipt7LUSw1xBd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA0NSBTYWx0ZWRfX3D+CHp1O2gZB
 nABz7hgd/ehBcWSeT8/b5W2aivwi3uKZYf9ENXRY7YYMna/l0HiBKQXOgBva6ZRpywK4cxvUWyQ
 zhyjh1d/Gj1bJQltD0f6ecXZ713LtkFeXvoUsMObUZ0d/23JbvbuPb4/HImGT7Lvfs4/3/ioU9+
 S6wGe1CcBl9/Xfdc2B41Mix0P4xlfk27iR9wBJTjNKVu3Oqe+oWOczexli2XtBh5YV/bp8OGc8O
 6+Mvnw6v4SejsB5bNK+RXiwAvTdCUEbJOynHIOPGRYOND33E6ln1voZ7m+RSMZBQHX3hDfskjWw
 RIh2QZ+FQv85mUWKw/GX0B3PzLTunXyppy8do7AVQVsC+fRdYB81cPiMH+OXLGrCl7yPVLMVbkN
 lNEPJSCegd+qkq3fshGf1YVRZKyfXqomBjHyT229yC2JEXGWl+G+Nb7+OhU0vFhqrCVFoD9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=699 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 44b9fc3ab6..a11e18ff74 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4968,33 +4968,6 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
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
index f2f5722d8a..d643591e25 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -67,7 +67,6 @@ typedef struct SpaprCapabilityInfo {
     void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
     void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
-    bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -337,11 +336,6 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
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
@@ -794,7 +788,6 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
-        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
@@ -983,11 +976,8 @@ int spapr_caps_post_migration(SpaprMachineState *spapr)
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
2.49.0


