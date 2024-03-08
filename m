Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03297C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYN5-00051v-A4; Fri, 08 Mar 2024 06:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMi-0004yh-Ne; Fri, 08 Mar 2024 06:26:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMa-0005Oq-Vz; Fri, 08 Mar 2024 06:26:14 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428ACLPP002815; Fri, 8 Mar 2024 11:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ICBPhBopecXA64/HvKaF3FX+pLpspyRAX0GLWCQMnp4=;
 b=UGvJsLp5QGHZOcbYszYC6qFTVdalQDtL56vWeKFQPU+qQB5T5CMdiLEh5qU/S0Qrxk8v
 Blc52et6za09hQQxT5hAG3B+Q03Ck53Srry2TNP1ifMil2JCjQueHX9SVGrWPqAYwKl0
 09YNpI9+/Cnh6uj8D5VSXgvVCOZq2eu6VHeA+vnvQ1LFA4t2DW3850A/SKpKdMr3+ooO
 0VmlQSVl8nqK24l3GC1ZwQJ+ew4G5iXtV2+FGirZrHbVYt2bGbfN/js7SZS8FG2MDNl7
 XShNoXHPN1CRHSjXSUBjMRkHFUPm7xldAhlEql3/0i8A+h9qq8M78d3WSv14pIF7Quyy Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdhb2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:26:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428BFcsh016278;
 Fri, 8 Mar 2024 11:26:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdhb09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:26:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428A86Pu024172; Fri, 8 Mar 2024 11:21:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsqamc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:21:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BL6a513435328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:21:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27EEC20040;
 Fri,  8 Mar 2024 11:21:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B52792004D;
 Fri,  8 Mar 2024 11:21:03 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:21:03 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 11/14] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
Date: Fri,  8 Mar 2024 16:49:37 +0530
Message-Id: <20240308111940.1617660-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: phixfCv8UDX2oBvKJ8A3G_x7KDA93H8o
X-Proofpoint-GUID: z6x2gSf8scywVJcJEtf9AoscoY3rrXBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080090
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
    - H_GUEST_GET_STATE which is used to get state of a nested guest or
      a guest VCPU. The value field for each element in the request is
      destination to be updated to reflect current state on success.
    - H_GUEST_SET_STATE which is used to modify the state of a guest or
      a guest VCPU. On success, guest (or its VCPU) state shall be
      updated as per the value field for the requested element(s).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |   3 +
 include/hw/ppc/spapr_nested.h |  23 +++
 hw/ppc/spapr_nested.c         | 268 ++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 070135793a..6223873641 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -366,6 +366,7 @@ struct SpaprMachineState {
 #define H_OVERLAP         -68
 #define H_STATE           -75
 #define H_IN_USE          -77
+#define H_INVALID_ELEMENT_VALUE            -81
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -589,6 +590,8 @@ struct SpaprMachineState {
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
 #define H_GUEST_CREATE_VCPU      0x474
+#define H_GUEST_GET_STATE        0x478
+#define H_GUEST_SET_STATE        0x47C
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 433d93c480..bd43c6b6ef 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -224,6 +224,10 @@ typedef struct SpaprMachineStateNestedGuest {
 #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
 #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
 #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
+#define GSB_MAX_BUF_SIZE              (1024 * 1024)
+#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
+#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
+#define GUEST_STATE_REQUEST_SET              0x2
 
 /* As per ISA v3.1B, following bits are reserved:
  *      0:2
@@ -321,6 +325,25 @@ typedef struct SpaprMachineStateNestedGuest {
 #define GSE_ENV_DWM(i, f, m) \
     GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
 
+struct guest_state_element {
+    uint16_t id;
+    uint16_t size;
+    uint8_t value[];
+} QEMU_PACKED;
+
+struct guest_state_buffer {
+    uint32_t num_elements;
+    struct guest_state_element elements[];
+} QEMU_PACKED;
+
+/* Actual buffer plus some metadata about the request */
+struct guest_state_request {
+    struct guest_state_buffer *gsb;
+    int64_t buf;
+    int64_t len;
+    uint16_t flags;
+};
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 07dc294c5a..ca99805ce8 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1028,6 +1028,140 @@ void spapr_nested_gsb_init(void)
     }
 }
 
+static struct guest_state_element *guest_state_element_next(
+    struct guest_state_element *element,
+    int64_t *len,
+    int64_t *num_elements)
+{
+    uint16_t size;
+
+    /* size is of element->value[] only. Not whole guest_state_element */
+    size = be16_to_cpu(element->size);
+
+    if (len) {
+        *len -= size + offsetof(struct guest_state_element, value);
+    }
+
+    if (num_elements) {
+        *num_elements -= 1;
+    }
+
+    return (struct guest_state_element *)(element->value + size);
+}
+
+static
+struct guest_state_element_type *guest_state_element_type_find(uint16_t id)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++)
+        if (id == guest_state_element_types[i].id) {
+            return &guest_state_element_types[i];
+        }
+
+    return NULL;
+}
+
+static void log_element(struct guest_state_element *element,
+                        struct guest_state_request *gsr)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state id:0x%04x size:0x%04x",
+                  gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get",
+                  be16_to_cpu(element->id), be16_to_cpu(element->size));
+    qemu_log_mask(LOG_GUEST_ERROR, "buf:0x%016lx ...\n",
+                  be64_to_cpu(*(uint64_t *)element->value));
+}
+
+static bool guest_state_request_check(struct guest_state_request *gsr)
+{
+    int64_t num_elements, len = gsr->len;
+    struct guest_state_buffer *gsb = gsr->gsb;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    uint16_t id, size;
+
+    /* gsb->num_elements = 0 == 32 bits long */
+    assert(len >= 4);
+
+    num_elements = be32_to_cpu(gsb->num_elements);
+    element = gsb->elements;
+    len -= sizeof(gsb->num_elements);
+
+    /* Walk the buffer to validate the length */
+    while (num_elements) {
+
+        id = be16_to_cpu(element->id);
+        size = be16_to_cpu(element->size);
+
+        if (false) {
+            log_element(element, gsr);
+        }
+        /* buffer size too small */
+        if (len < 0) {
+            return false;
+        }
+
+        type = guest_state_element_type_find(id);
+        if (!type) {
+            qemu_log_mask(LOG_GUEST_ERROR,"Element ID %04x unknown\n", id);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        if (size != type->size) {
+            qemu_log_mask(LOG_GUEST_ERROR,"Size mismatch. Element ID:%04x."
+                          "Size Exp:%i Got:%i\n", id, type->size, size);
+            log_element(element, gsr);
+            return false;
+        }
+
+        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
+            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
+            qemu_log_mask(LOG_GUEST_ERROR,"trying to set a read-only Element "
+                          "ID:%04x.\n", id);
+            return false;
+        }
+
+        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
+            /* guest wide element type */
+            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        } else {
+            /* thread wide element type */
+            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
+                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
+                              "Element ID:%04x.\n", id);
+                return false;
+            }
+        }
+next_element:
+        element = guest_state_element_next(element, &len, &num_elements);
+
+    }
+    return true;
+}
+
+static bool is_gsr_invalid(struct guest_state_request *gsr,
+                                   struct guest_state_element *element,
+                                   struct guest_state_element_type *type)
+{
+    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
+        (*(uint64_t *)(element->value) & ~(type->mask))) {
+        log_element(element, gsr);
+        qemu_log_mask(LOG_GUEST_ERROR, "L1 can't set reserved bits i"
+                      "(allowed mask: 0x%08lx)\n", type->mask);
+        return true;
+    }
+    return false;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -1261,6 +1395,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
+                                 uint64_t vcpuid,
+                                 struct guest_state_request *gsr)
+{
+    void *ptr;
+    uint16_t id;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    int64_t lenleft, num_elements;
+
+    lenleft = gsr->len;
+
+    if (!guest_state_request_check(gsr)) {
+        return H_P3;
+    }
+
+    num_elements = be32_to_cpu(gsr->gsb->num_elements);
+    element = gsr->gsb->elements;
+    /* Process the elements */
+    while (num_elements) {
+        type = NULL;
+        /* log_element(element, gsr); */
+
+        id = be16_to_cpu(element->id);
+        if (id == GSB_HV_VCPU_IGNORED_ID) {
+            goto next_element;
+        }
+
+        type = guest_state_element_type_find(id);
+        assert(type);
+
+        /* Get pointer to guest data to get/set */
+        if (type->location && type->copy) {
+            ptr = type->location(guest, vcpuid);
+            assert(ptr);
+            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
+                return H_INVALID_ELEMENT_VALUE;
+            }
+            type->copy(ptr + type->offset, element->value,
+                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : false);
+        }
+
+next_element:
+        element = guest_state_element_next(element, &lenleft, &num_elements);
+    }
+
+    return H_SUCCESS;
+}
+
+static target_ulong map_and_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineStateNestedGuest *guest,
+                                         uint64_t vcpuid,
+                                         struct guest_state_request *gsr)
+{
+    target_ulong rc;
+    int64_t len;
+    bool is_write;
+
+    len = gsr->len;
+    /* only get_state would require write access to the provided buffer */
+    is_write = (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
+    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
+                                 is_write, MEMTXATTRS_UNSPECIFIED);
+    if (!gsr->gsb) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    if (len != gsr->len) {
+        rc = H_P3;
+        goto out1;
+    }
+
+    rc = getset_state(guest, vcpuid, gsr);
+
+out1:
+    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
+    return rc;
+}
+
+static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong *args,
+                                         bool set)
+{
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    target_ulong buf = args[3];
+    target_ulong buflen = args[4];
+    struct guest_state_request gsr;
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+    gsr.buf = buf;
+    assert(buflen <= GSB_MAX_BUF_SIZE);
+    gsr.len = buflen;
+    gsr.flags = 0;
+    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
+    }
+    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
+        return H_PARAMETER; /* flag not supported yet */
+    }
+
+    if (set) {
+        gsr.flags |= GUEST_STATE_REQUEST_SET;
+    }
+    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
+}
+
+static target_ulong h_guest_set_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, true);
+}
+
+static target_ulong h_guest_get_state(PowerPCCPU *cpu,
+                                      SpaprMachineState *spapr,
+                                      target_ulong opcode,
+                                      target_ulong *args)
+{
+    return h_guest_getset_state(cpu, spapr, args, false);
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1284,6 +1548,8 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
     spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
+    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
+    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
 }
 
 void spapr_unregister_nested_papr(void)
@@ -1293,6 +1559,8 @@ void spapr_unregister_nested_papr(void)
     spapr_unregister_hypercall(H_GUEST_CREATE);
     spapr_unregister_hypercall(H_GUEST_DELETE);
     spapr_unregister_hypercall(H_GUEST_CREATE_VCPU);
+    spapr_unregister_hypercall(H_GUEST_SET_STATE);
+    spapr_unregister_hypercall(H_GUEST_GET_STATE);
 }
 
 #else
-- 
2.39.3


