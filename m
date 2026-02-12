Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2191EEA84F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdXn-0000bH-RH; Thu, 12 Feb 2026 15:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXk-0000Zb-Oy; Thu, 12 Feb 2026 15:44:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXi-0007HA-M6; Thu, 12 Feb 2026 15:44:08 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CK3ETP362336; Thu, 12 Feb 2026 20:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VP5AOMsPis+nCO3sX
 PP93OEr/qyE3WqOVfQLpO2uvas=; b=VSePIJpcEF6nCTwqC+7wnNc6oIHKuA5z7
 7XcIBRgQyqJ+i/jeOZBZUBzJtYLwvVIyLZEHok5N/YhdVxDN+j6YGVWhHPfNF+mu
 SqwZdoOfzG9SkPx2AwzSI+pF/yOtxVbJZGvcTUp4T1niLy6z2cRMrhQ1TgbJsHIx
 rQNNZm1q17CtCSyBow7ZJOOOsnGLldo/XaS7ulw4lhKnRsyz/RApAKYhkFR4+RMg
 rGnuGdT1kvIju6f+pKqa0ghsqtmiVp3Dt7XBv+O7wTSYM5BguZLBCxBFwmsRyz4L
 yal2NcaekKCHelGnats6lehdrFirwzozYGbbLYjBy+fiOR99iwAzw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wg4ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:43:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CHR6mh019251;
 Thu, 12 Feb 2026 20:43:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxkbyuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:43:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKhvIa31392280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:43:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3C425804E;
 Thu, 12 Feb 2026 20:43:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A7DE58054;
 Thu, 12 Feb 2026 20:43:55 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:43:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 01/30] Add boot-certs to s390-ccw-virtio machine type option
Date: Thu, 12 Feb 2026 15:43:22 -0500
Message-ID: <20260212204352.1044699-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e3b8f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=45xdXbyIuVMhCIclKDQA:9
X-Proofpoint-GUID: PnE8eG49yYBciIhEzQ9JL5bustqAe11X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX9EZT/ewm0dsW
 S7K/o/pa2ytf/hM5L5AT0YCbHdkqeQfajv3SjCBA1JWP9bTCNqhb8PqJsRGUoA5XoPkXuCXQvs6
 cFmMGU2BOxpbWGTbm2CIolhIcENepfPRcz3ZVHuo6d/DgKHEeo25cJya2TgRWH0eohQZ+L4fL7n
 lZmYWrrI4N3gqQh9shvsV3LcfpR9FBE9E9sjcYWXJ+mLrShr/rdl7Y8d/BsHll0JHCDElvKw3RN
 a8OJ9pSBIW7zFqgYd6giF2Ma5KyGXmbTmhFinOrgCvPdomJnLc0Dii9d7cR74IaAtdh1P9XEj6B
 EplKy4/r+W+mlDlyOYrKx1gotW8kLT5uQ0Ym8EZTMC+3J2CGfvXTIgyGbfupq9Hr9E6KdQNhcjO
 qFMarKEnMCt2tlai5uIiO/AtjabHWNvPIr37BpsZLbo83HroRv/W+ZVrqIhwS8oNoevCe1owTLh
 Vs3HWzp4zexWkQPfU/w==
X-Proofpoint-ORIG-GUID: PnE8eG49yYBciIhEzQ9JL5bustqAe11X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
machine. This allows users to specify one or more certificate file paths
or directories to be used during secure boot.

Each entry is specified using the syntax:
	boot-certs.<index>.path=/path/to/cert.pem

Multiple paths can be specify using array properties:
	boot-certs.0.path=/path/to/cert.pem,
	boot-certs.1.path=/path/to/cert-dir,
	boot-certs.2.path=/path/to/another-dir...

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  2 ++
 qapi/machine-s390x.json            | 23 +++++++++++++++++++++++
 qapi/pragma.json                   |  1 +
 qemu-options.hx                    |  6 +++++-
 6 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/s390x/secure-ipl.rst

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
new file mode 100644
index 0000000000..0a02f171b4
--- /dev/null
+++ b/docs/system/s390x/secure-ipl.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Secure IPL Command Line Options
+===============================
+
+The s390-ccw-virtio machine type supports secure IPL. These parameters allow
+users to provide certificates and enable secure IPL directly via the command
+line.
+
+Providing Certificates
+----------------------
+
+The certificate store can be populated by supplying a list of X.509 certificate
+file paths or directories containing certificate files on the command-line:
+
+Note: certificate files must have a .pem extension.
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index eb135a515d..9267563cbe 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
+#include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
 #include "hw/virtio/virtio-md-pci.h"
@@ -795,6 +796,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+static void machine_get_boot_certs(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertificatesList **certs = &ms->boot_certs;
+
+    visit_type_BootCertificatesList(v, name, certs, errp);
+}
+
+static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertificatesList *cert_list = NULL;
+
+    visit_type_BootCertificatesList(v, name, &cert_list, errp);
+    if (!cert_list) {
+        return;
+    }
+
+    ms->boot_certs = cert_list;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -848,6 +873,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+
+    object_class_property_add(oc, "boot-certs", "BootCertificatesList",
+                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
+    object_class_property_set_description(oc, "boot-certs",
+            "provide paths to a directory and/or a certificate file for secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index f1f06119d6..5ad1ea2f24 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -14,6 +14,7 @@
 #include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/s390x/sclp.h"
+#include "qapi/qapi-types-machine-s390x.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
 
@@ -31,6 +32,7 @@ struct S390CcwMachineState {
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
+    BootCertificatesList *boot_certs;
 
     SCLPDevice *sclp;
 };
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index ea430e1b88..0e0f4fdfb0 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -140,3 +140,26 @@
 { 'event': 'SCLP_CPI_INFO_AVAILABLE',
   'features': [ 'unstable' ]
 }
+
+##
+# @BootCertificates:
+#
+# Boot certificate for secure IPL.
+#
+# @path: path to an X.509 certificate file or a directory containing
+# certificate files.
+#
+# Since: 11.0
+##
+{ 'struct': 'BootCertificates',
+  'data': {'path': 'str'} }
+
+##
+# @DummyBootCertificates:
+#
+# Not used by QMP; hack to let us use BootCertificatesList internally.
+#
+# Since: 11.0
+##
+{ 'struct': 'DummyBootCertificates',
+  'data': {'unused-boot-certs': ['BootCertificates'] } }
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 193bc39059..aad270402f 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -49,6 +49,7 @@
         'DisplayProtocol',
         'DriveBackupWrapper',
         'DummyBlockCoreForceArrays',
+        'DummyBootCertificates',
         'DummyForceArrays',
         'DummyVirtioForceArrays',
         'HotKeyMod',
diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..7c02220a5c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -45,7 +45,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
     "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -209,6 +210,9 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
+        Provide paths to a directory and/or a certificate file on the host [s390x only].
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.52.0


