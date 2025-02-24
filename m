Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85247C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXDI-00066B-ET; Mon, 24 Feb 2025 07:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDD-00064k-Tl; Mon, 24 Feb 2025 07:05:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tmXDA-000309-3f; Mon, 24 Feb 2025 07:05:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2D9lA020157;
 Mon, 24 Feb 2025 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=V973l+jL/IeCkEmsxHvsA0NfAna1vje/9/kbNpJsd
 gw=; b=ozBPZD+8FVLzT+fgypfo/L+1A59Sq+31ozRS851a82Cf39cU82ze5tb0M
 IxqmlfvVugAGrRE1yCuCBqKbEMQHPVy0YFQpfJQR5dRbIBV8zYNVAntNAJk31yK9
 x1TCKLfDSQ4T5WJqeHO4Y8nFLlikLeEUh/DSzKoEv+o5Wkcun+E3L58Gl5XY7BLq
 e9p2dSfpe96bD1SubK+a5rDZB+ZJFoxYCQS2vWkty05xMSCeuCmd/GnD9KiLY2uX
 F1eX3BDe80WGsM0zGZK/7wANBGvkdpivCY+7mZaXuRfb2XbYBq80tCod/KW0DzCB
 SCyzvErHCG5DgKTXEMgF1Kp0GoJVA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta2sty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9YljI002588;
 Mon, 24 Feb 2025 12:05:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jepss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:05:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OC5DX619727082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 12:05:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F26520049;
 Mon, 24 Feb 2025 12:05:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F49820040;
 Mon, 24 Feb 2025 12:05:13 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 12:05:13 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
Date: Mon, 24 Feb 2025 13:04:47 +0100
Message-ID: <20250224120449.1764114-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gDdrKPdj9zwJA0OsSTOWzUvCbj9rP5o7
X-Proofpoint-ORIG-GUID: gDdrKPdj9zwJA0OsSTOWzUvCbj9rP5o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add Control-Program Identification (CPI) to the QEMU Object
Model (QOM). The CPI identifiers provide information about
the guest operating system. The CPI identifiers are:
system type, system name, system level and sysplex name.

The system type provides the OS type of the guest (e.g. LINUX).
The system name provides the name of the guest (e.g. TESTVM).
The system level provides the distribution and kernel version
of the guest OS (e.g. 0x50e00).
The sysplex name provides the sysplex name of the guest
(e.g. SYSPLEX).

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
 qapi/machine.json                  | 24 ++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 51ae0c133d..13ea8db1b0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -50,6 +50,7 @@
 #include "hw/s390x/virtio-ccw-md.h"
 #include "system/replay.h"
 #include CONFIG_DEVICES
+#include "qapi/qapi-visit-machine.h"
 
 static Error *pv_mig_blocker;
 
@@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
 }
 
+static void machine_get_control_program_id(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    S390ControlProgramId *cpi;
+    cpi = &(S390ControlProgramId){
+        .system_type = g_strndup((char *) ms->cpi.system_type,
+                       sizeof(ms->cpi.system_type)),
+        .system_name = g_strndup((char *) ms->cpi.system_name,
+                       sizeof(ms->cpi.system_name)),
+        .system_level = g_strdup_printf("0x%lx", ms->cpi.system_level),
+        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
+                        sizeof(ms->cpi.sysplex_name)),
+        .timestamp = ms->cpi.timestamp
+    };
+
+    visit_type_S390ControlProgramId(v, name, &cpi, &error_abort);
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -854,6 +875,14 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+    object_class_property_add(oc, "s390-control-program-id",
+                              "S390ControlProgramId",
+                              machine_get_control_program_id,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(oc, "s390-control-program-id",
+        "Control-progam identifiers provide data about the guest "
+        "operating system");
+
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 686d9497d2..6872f7a176 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -19,6 +19,13 @@
 
 OBJECT_DECLARE_TYPE(S390CcwMachineState, S390CcwMachineClass, S390_CCW_MACHINE)
 
+typedef struct ControlProgramId {
+    uint8_t system_type[8];
+    uint8_t system_name[8];
+    uint64_t system_level;
+    uint8_t sysplex_name[8];
+    uint64_t timestamp;
+} QEMU_PACKED ControlProgramId;
 
 struct S390CcwMachineState {
     /*< private >*/
@@ -33,6 +40,7 @@ struct S390CcwMachineState {
     uint64_t max_pagesize;
 
     SCLPDevice *sclp;
+    ControlProgramId cpi;
 };
 
 static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09..c6cbad87e1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,27 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @S390ControlProgramId:
+#
+# Control-program identifiers provide data about Linux instance.
+#
+# @system-type: operating system of Linux instance
+#
+# @system-name: system name of Linux instance
+#
+# @system-level: distribution and kernel version of Linux instance
+#
+# @sysplex-name: sysplex name of Linux instance
+#
+# @timestamp: latest update of CPI data
+#
+# Since: 9.2
+##
+{ 'struct': 'S390ControlProgramId', 'data': {
+     'system-type': 'str',
+     'system-name': 'str',
+     'system-level': 'str',
+     'sysplex-name': 'str',
+     'timestamp': 'uint64' } }
-- 
2.47.0


