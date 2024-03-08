Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDBEC54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYN6-00052w-Hs; Fri, 08 Mar 2024 06:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMg-0004yF-Qc; Fri, 08 Mar 2024 06:26:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMZ-0005OM-0L; Fri, 08 Mar 2024 06:26:09 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428BOQ2H004254; Fri, 8 Mar 2024 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PQ+LZrdkP6+zAGxZxkae1MjaoOv4moTvIyHWFgDyse8=;
 b=DAVimMqtD/556fsiclTyMg93Ma1yqPgAtShzYgwMz+MlpCi1+QMfHKg0H4FPmbrYfkbP
 sMAxQ5U/yXgaJnzZDRDeyrB03Rifjb6ZOTg7+ck1GgGzV9KR+9Ryb6787leGfWz6e12d
 s69lQDazVX5PnABz5hQ/ieRCSQR8Q6oF279bhUL3/uyiHmDm47R60zKYrXx3qfBnPZ9T
 SU7h4PvBYFf04nJxDGADwipONRaEIFSMGi2O/iw87fJHVIJBrqaMfh+FIpgXG9sb7obu
 TchPKBAKf4dpbougeIGJBhmnVKHeEKDf3ppx/cDJLLmOAlgah8uT7xr4e9BnXuqnKMV6 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1e08dsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:26:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BQ0Tc011498;
 Fri, 8 Mar 2024 11:26:00 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1e08dr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:26:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428AND5h031542; Fri, 8 Mar 2024 11:20:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkkq19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKrw350266430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 156612004B;
 Fri,  8 Mar 2024 11:20:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4AB20043;
 Fri,  8 Mar 2024 11:20:50 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 07/14] spapr: nested: Introduce H_GUEST_[CREATE|DELETE]
 hcalls.
Date: Fri,  8 Mar 2024 16:49:33 +0530
Message-Id: <20240308111940.1617660-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: smLBKky42P5zVktEvybKsZLTLcLDM8Ma
X-Proofpoint-ORIG-GUID: JcBGdYn181cq5KbViLDzpxZFbo8W6FrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=690 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce the nested PAPR hcalls:
    - H_GUEST_CREATE which is used to create and allocate resources for
nested guest being created.
    - H_GUEST_DELETE which is used to delete and deallocate resources
for the nested guest being deleted. It also supports deleting all nested
guests at once using a deleteAll flag.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/ppc/spapr_nested.h |   7 +++
 hw/ppc/spapr_nested.c         | 103 ++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2906d59137..13416fc3d7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -586,8 +586,10 @@ struct SpaprMachineState {
 #define H_WATCHDOG              0x45C
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
+#define H_GUEST_CREATE           0x470
+#define H_GUEST_DELETE           0x488
 
-#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
+#define MAX_HCALL_OPCODE         H_GUEST_DELETE
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 73687e03e4..56d43e540b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -9,8 +9,13 @@ typedef struct SpaprMachineStateNested {
 #define NESTED_API_KVM_HV  1
     bool capabilities_set;
     uint32_t pvr_base;
+    GHashTable *guests;
 } SpaprMachineStateNested;
 
+typedef struct SpaprMachineStateNestedGuest {
+    uint32_t pvr_logical;
+} SpaprMachineStateNestedGuest;
+
 /* Nested PAPR API related macros */
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
@@ -20,6 +25,8 @@ typedef struct SpaprMachineStateNested {
 #define H_GUEST_CAP_COPY_MEM_BMAP     0
 #define H_GUEST_CAP_P9_MODE_BMAP      1
 #define H_GUEST_CAP_P10_MODE_BMAP     2
+#define PAPR_NESTED_GUEST_MAX         4096
+#define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 601f669060..13674c0857 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -520,6 +520,105 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
     }
 }
 
+static void
+destroy_guest_helper(gpointer value)
+{
+    struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest);
+}
+
+static target_ulong h_guest_create(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong continue_token = args[1];
+    uint64_t guestid;
+    int nguests = 0;
+    struct SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    if (continue_token != -1) {
+        return H_P2;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        return H_STATE;
+    }
+
+    if (!spapr->nested.guests) {
+        spapr->nested.guests = g_hash_table_new_full(NULL,
+                                                     NULL,
+                                                     NULL,
+                                                     destroy_guest_helper);
+    }
+
+    nguests = g_hash_table_size(spapr->nested.guests);
+
+    if (nguests == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    /* Lookup for available guestid */
+    for (guestid = 1; guestid < PAPR_NESTED_GUEST_MAX; guestid++) {
+        if (!(g_hash_table_lookup(spapr->nested.guests,
+                                  GINT_TO_POINTER(guestid)))) {
+            break;
+        }
+    }
+
+    if (guestid == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    guest = g_try_new0(struct SpaprMachineStateNestedGuest, 1);
+    if (!guest) {
+        return H_NO_MEM;
+    }
+
+    guest->pvr_logical = spapr->nested.pvr_base;
+    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(guestid), guest);
+    env->gpr[4] = guestid;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_guest_delete(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    struct SpaprMachineStateNestedGuest *guest;
+
+    /*
+     * handle flag deleteAllGuests, if set:
+     * guestid is ignored and all guests are deleted
+     *
+     */
+    if (flags & ~H_GUEST_DELETE_ALL_FLAG) {
+        return H_UNSUPPORTED_FLAG; /* other flag bits reserved */
+    } else if (flags & H_GUEST_DELETE_ALL_FLAG) {
+        g_hash_table_destroy(spapr->nested.guests);
+        return H_SUCCESS;
+    }
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    if (!guest) {
+        return H_P2;
+    }
+
+    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(guestid));
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -540,12 +639,16 @@ void spapr_register_nested_papr(void)
 {
     spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
+    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
+    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
 }
 
 void spapr_unregister_nested_papr(void)
 {
     spapr_unregister_hypercall(H_GUEST_GET_CAPABILITIES);
     spapr_unregister_hypercall(H_GUEST_SET_CAPABILITIES);
+    spapr_unregister_hypercall(H_GUEST_CREATE);
+    spapr_unregister_hypercall(H_GUEST_DELETE);
 }
 
 #else
-- 
2.39.3


