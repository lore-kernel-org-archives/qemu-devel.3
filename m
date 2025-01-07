Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A158E7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 20:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGXw-0005xK-SJ; Tue, 07 Jan 2025 15:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tVGXp-0005vM-SJ; Tue, 07 Jan 2025 15:51:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tVGXl-0000aC-Vh; Tue, 07 Jan 2025 15:51:21 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Ipa6B007032;
 Tue, 7 Jan 2025 20:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sPG5FCazAknWXi/Ar
 0oakSM2z1yFKD74GBkRVr0HZDg=; b=Wdyygx+8Q0TXon/5xvUTcbay91R+MOeUo
 Zmx0rk0msl4GjpmsMlXGnGxEHzKeoOBRxxxbCDODKPNRjCONwG8D5CLRBatjnJrs
 RXURYMUsxKVaL02RjTUCUB6LSnc8j5dbYdvihZSM0TxysszkWmRBZY59I5A3NxHX
 oJ+T+VdGi+NWI0ocwWpeqDp0wv+QA8nZbYt4ik0880gK0LhvbdfFKF+fvxxV1brj
 B4J7HWS6vc7X7Xv3RENb/IprOrzv0RTm81aV/LBm2dRY36DaYCqOwk/N3vs/asee
 IF73uWXvu89n8EpxZGS/k4v6oPrG68pFVe9dxMfolMJSj3L5/SmyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4415r51x8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507Kmw2x024906;
 Tue, 7 Jan 2025 20:51:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4415r51x8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507Kjjdx015805;
 Tue, 7 Jan 2025 20:51:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkvap2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 20:51:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507KpBfO10092956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 20:51:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E1D158062;
 Tue,  7 Jan 2025 20:51:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 015B258051;
 Tue,  7 Jan 2025 20:51:11 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 20:51:10 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, dantan@linux.ibm.com
Subject: [PATCH v3 1/2] ppc/pnv: Add new PowerPC Special Purpose Registers
 (DAWR1, DAWRX1)
Date: Tue,  7 Jan 2025 14:51:01 -0600
Message-Id: <20250107205102.20242-2-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107205102.20242-1-dantan@linux.vnet.ibm.com>
References: <20250107205102.20242-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Y9eMixlU52X9b3S87HS5XfyPO_f8gcg
X-Proofpoint-GUID: kackC0Vkiq8Dk75sMmABSsq4qwujDAjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070163
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: dan tan <dantan@linux.ibm.com>

The handling of the following two registers are added to POWER10 -
- DAWR1  (0x0bd, 189) - Data Address Watchpoint 1
- DAWRX1 (0x0b5, 181) - Data Address Watchpoint Extension 1

Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
ver 3 no change

ver 2 summary:
    - spec reference: https://files.openpower.foundation/s/EgCy7C43p2NSRfR
    - corrected commit message format
    - combine DAWR(0/1) handling into a single function
    - add DAWR1 & DAWRX1 to init_proc_POWER10() only.
---
 include/hw/ppc/spapr.h   |  2 +-
 target/ppc/cpu.h         |  7 ++--
 target/ppc/helper.h      |  4 +--
 target/ppc/spr_common.h  |  2 ++
 hw/ppc/spapr_hcall.c     | 24 ++++++++------
 target/ppc/cpu.c         | 69 ++++++++++++++++++++++++++--------------
 target/ppc/cpu_init.c    | 15 +++++++++
 target/ppc/excp_helper.c | 11 ++++++-
 target/ppc/machine.c     |  5 ++-
 target/ppc/misc_helper.c |  8 ++---
 target/ppc/translate.c   | 21 ++++++++++--
 11 files changed, 121 insertions(+), 47 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index af4aa1cb0f..8282136745 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -403,7 +403,7 @@ struct SpaprMachineState {
 
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR           1
-#define H_SET_MODE_RESOURCE_SET_DAWR0           2
+#define H_SET_MODE_RESOURCE_SET_DAWR            2
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE     3
 #define H_SET_MODE_RESOURCE_LE                  4
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2ffac2ed03..6d074e67dc 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1261,6 +1261,7 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
+    struct CPUWatchpoint *dawr1_watchpoint;
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1587,9 +1588,9 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_update_ciabr(CPUPPCState *env);
 void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
-void ppc_update_daw0(CPUPPCState *env);
-void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
-void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
+void ppc_update_daw(CPUPPCState *env, uint32_t daw);
+void ppc_store_dawr(CPUPPCState *env, target_ulong value, uint32_t dawr);
+void ppc_store_dawrx(CPUPPCState *env, uint32_t value, uint32_t dawrx);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a77e761bd..28d6bf1bde 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -26,8 +26,8 @@ DEF_HELPER_2(rfebb, void, env, tl)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
 DEF_HELPER_2(store_ciabr, void, env, tl)
-DEF_HELPER_2(store_dawr0, void, env, tl)
-DEF_HELPER_2(store_dawrx0, void, env, tl)
+DEF_HELPER_3(store_dawr, void, env, tl, i32)
+DEF_HELPER_3(store_dawrx, void, env, tl, i32)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
 DEF_HELPER_2(store_mmcrA, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 01aff449bc..ff67139ec1 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -164,7 +164,9 @@ void spr_read_cfar(DisasContext *ctx, int gprn, int sprn);
 void spr_write_cfar(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5e1d020e3d..e693e950a7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -818,11 +818,11 @@ static target_ulong h_set_mode_resource_set_ciabr(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong mflags,
-                                                  target_ulong value1,
-                                                  target_ulong value2)
+static target_ulong h_set_mode_resource_set_dawr(PowerPCCPU *cpu,
+                                                 SpaprMachineState *spapr,
+                                                 target_ulong mflags,
+                                                 target_ulong value1,
+                                                 target_ulong value2)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -835,8 +835,12 @@ static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
         return H_P4;
     }
 
-    ppc_store_dawr0(env, value1);
-    ppc_store_dawrx0(env, value2);
+    ppc_store_dawr(env, value1, SPR_DAWR0);
+    ppc_store_dawrx(env, value2, SPR_DAWRX0);
+    if (env->excp_model > POWERPC_EXCP_POWER10) {
+        ppc_store_dawr(env, value1, SPR_DAWR1);
+        ppc_store_dawrx(env, value2, SPR_DAWRX1);
+    }
 
     return H_SUCCESS;
 }
@@ -914,9 +918,9 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
         ret = h_set_mode_resource_set_ciabr(cpu, spapr, args[0], args[2],
                                             args[3]);
         break;
-    case H_SET_MODE_RESOURCE_SET_DAWR0:
-        ret = h_set_mode_resource_set_dawr0(cpu, spapr, args[0], args[2],
-                                            args[3]);
+    case H_SET_MODE_RESOURCE_SET_DAWR:
+        ret = h_set_mode_resource_set_dawr(cpu, spapr, args[0], args[2],
+                                           args[3]);
         break;
     case H_SET_MODE_RESOURCE_LE:
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index e3ad8e0c27..d6a58b5497 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -130,23 +130,45 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
     ppc_update_ciabr(env);
 }
 
-void ppc_update_daw0(CPUPPCState *env)
+void ppc_update_daw(CPUPPCState *env, uint32_t spr_daw)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
-    uint32_t dawrx = env->spr[SPR_DAWRX0];
-    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
-    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
-    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
-    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
-    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
-    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+    struct CPUWatchpoint **dawr_watchpt;
+    target_ulong deaw;
+    uint32_t dawrx;
+    int mrd, flags;
+    bool dw, dr, hv, sv, pr;
     vaddr len;
-    int flags;
 
-    if (env->dawr0_watchpoint) {
-        cpu_watchpoint_remove_by_ref(cs, env->dawr0_watchpoint);
-        env->dawr0_watchpoint = NULL;
+    switch (spr_daw) {
+    case SPR_DAWR0:
+    case SPR_DAWRX0:
+        dawr_watchpt = &env->dawr0_watchpoint;
+        deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
+        dawrx = env->spr[SPR_DAWRX0];
+        break;
+
+    case SPR_DAWR1:
+    case SPR_DAWRX1:
+        dawr_watchpt = &env->dawr1_watchpoint;
+        deaw = env->spr[SPR_DAWR1] & PPC_BITMASK(0, 60);
+        dawrx = env->spr[SPR_DAWRX1];
+        break;
+    default:
+        dawrx = 0;
+        *dawr_watchpt = NULL;
+        break;
+    }
+    mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
+    dw = extract32(dawrx, PPC_BIT_NR(57), 1);
+    dr = extract32(dawrx, PPC_BIT_NR(58), 1);
+    hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+
+    if (*dawr_watchpt) {
+        cpu_watchpoint_remove_by_ref(cs, *dawr_watchpt);
+        *dawr_watchpt = NULL;
     }
 
     if (!dr && !dw) {
@@ -166,30 +188,31 @@ void ppc_update_daw0(CPUPPCState *env)
         flags |= BP_MEM_WRITE;
     }
 
-    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr0_watchpoint);
+    cpu_watchpoint_insert(cs, deaw, len, flags, dawr_watchpt);
 }
 
-void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
+void ppc_store_dawr(CPUPPCState *env, target_ulong val, uint32_t dawr)
 {
-    env->spr[SPR_DAWR0] = val;
-    ppc_update_daw0(env);
+    env->spr[dawr] = val;
+    ppc_update_daw(env, dawr);
 }
 
-void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
+void ppc_store_dawrx(CPUPPCState *env, uint32_t val, uint32_t dawrx)
 {
     int hrammc = extract32(val, PPC_BIT_NR(56), 1);
 
     if (hrammc) {
         /* This might be done with a second watchpoint at the xor of DEAW[0] */
-        qemu_log_mask(LOG_UNIMP, "%s: DAWRX0[HRAMMC] is unimplemented\n",
+        qemu_log_mask(LOG_UNIMP, "%s: DAWRX[HRAMMC] is unimplemented\n",
                       __func__);
     }
 
-    env->spr[SPR_DAWRX0] = val;
-    ppc_update_daw0(env);
+    env->spr[dawrx] = val;
+    ppc_update_daw(env, dawrx);
 }
-#endif
-#endif
+
+#endif /* TARGET_PPC64 */
+#endif /* !CONFIG_USER_ONLY */
 
 static inline void fpscr_set_rounding_mode(CPUPPCState *env)
 {
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622..7844e16ea5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5910,6 +5910,20 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             0);
 }
 
+static void register_power10_dbg_sprs(CPUPPCState *env)
+{
+    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawr1,
+                        KVM_REG_PPC_DAWR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawrx1,
+                        KVM_REG_PPC_DAWRX, 0x00000000);
+}
+
 /*
  * Initialize PMU counter overflow timers for Power8 and
  * newer Power chips when using TCG.
@@ -6568,6 +6582,7 @@ static void init_proc_POWER10(CPUPPCState *env)
 {
     register_power9_common_sprs(env);
     register_HEIR64_spr(env);
+    register_power10_dbg_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9f811af0a4..9512525e52 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3279,10 +3279,19 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
+    bool match = false;
+    uint32_t dawrx;
 
     if (env->insns_flags2 & PPC2_ISA207S) {
         if (wp == env->dawr0_watchpoint) {
-            uint32_t dawrx = env->spr[SPR_DAWRX0];
+            dawrx = env->spr[SPR_DAWRX0];
+            match = true;
+        } else if (wp == env->dawr1_watchpoint) {
+            dawrx = env->spr[SPR_DAWRX1];
+            match = true;
+        }
+
+        if (match == true) {
             bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
             bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
             bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 717bf93e88..4c510e6fed 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -264,7 +264,10 @@ static int cpu_post_load(void *opaque, int version_id)
         /* Re-set breaks based on regs */
 #if defined(TARGET_PPC64)
         ppc_update_ciabr(env);
-        ppc_update_daw0(env);
+        ppc_update_daw(env, SPR_DAWR0);
+        if (env->excp_model > POWERPC_EXCP_POWER10) {
+            ppc_update_daw(env, SPR_DAWR1);
+        }
 #endif
         /*
          * TCG needs to re-start the decrementer timer and/or raise the
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b..1bebb5a8a7 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -223,14 +223,14 @@ void helper_store_ciabr(CPUPPCState *env, target_ulong value)
     ppc_store_ciabr(env, value);
 }
 
-void helper_store_dawr0(CPUPPCState *env, target_ulong value)
+void helper_store_dawr(CPUPPCState *env, target_ulong value, uint32_t dawr)
 {
-    ppc_store_dawr0(env, value);
+    ppc_store_dawr(env, value, dawr);
 }
 
-void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
+void helper_store_dawrx(CPUPPCState *env, target_ulong value, uint32_t dawrx)
 {
-    ppc_store_dawrx0(env, value);
+    ppc_store_dawrx(env, value, dawrx);
 }
 
 /*
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 47ca50a064..0187b5ab2f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -628,14 +628,31 @@ void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn)
 void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
-    gen_helper_store_dawr0(tcg_env, cpu_gpr[gprn]);
+    gen_helper_store_dawr(tcg_env, cpu_gpr[gprn],
+                          tcg_constant_i32(SPR_DAWR0));
 }
 
 void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
-    gen_helper_store_dawrx0(tcg_env, cpu_gpr[gprn]);
+    gen_helper_store_dawrx(tcg_env, cpu_gpr[gprn],
+                           tcg_constant_i32(SPR_DAWRX0));
 }
+
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawr(tcg_env, cpu_gpr[gprn],
+                          tcg_constant_i32(SPR_DAWR1));
+}
+
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawrx(tcg_env, cpu_gpr[gprn],
+                          tcg_constant_i32(SPR_DAWRX1));
+}
+
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */
-- 
2.39.5


