Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0E8C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7G-0007Yh-MN; Wed, 26 Aug 2026 08:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7C-0007Vl-6p; Wed, 26 Aug 2026 08:52:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD79-0002Pk-QT; Wed, 26 Aug 2026 08:52:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCWUYY4003966; Wed, 26 Aug 2026 12:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wHYEaBxFh0/mbQVsX
 a6DUoo01RuP/VvJMdDPd3mCDjg=; b=XYK2BqDBdhFtZNoX0ErcH22I4i+xKMc9z
 TVnEfpI39DG85Ig66g/tCMKRoH+unEZHxlcDA6WhG+vmDYeEguL6Jupv8MRnK9di
 5+RYlFgzih4WEqU0e1s/mmmPzMlmG2U30NLnqMUZwikDdyllbZOm8aeNSnOE/nSJ
 mB1/czrttgx5/GYR25y4yN9h4HZycB4p3nvSrsUucksFO3ZnZgUj2vEFNmSU7vnK
 s4FT4TdbXNFxOK6Ol9x88ccHeKmwZwazd0GEGJP8RNbXYXb0e4kvxbfO7dDiQFtw
 3U/drYFJBnjPmtWgKD0bupldAcNojznRxfTlLSMoV/DOMEzmy/Qgg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4xpc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfVXs032736;
 Wed, 26 Aug 2026 12:52:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh9vkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqJkV30212634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C975805C;
 Wed, 26 Aug 2026 12:52:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 749755805B;
 Wed, 26 Aug 2026 12:52:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:18 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/37] Add boot-certs to s390-ccw-virtio machine type option
Date: Wed, 26 Aug 2026 08:51:38 -0400
Message-ID: <20260826125213.1901252-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e4R-QozNRmFSEZ2Dl-iZOZ93BI3Y13-T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXw8DDBuFnNbGZ
 Ui8BwQC2iyAHdNkQBROIzCzcHoXAe4qMJPrZsh9pYaflV55TbHQzUWVV8IQBvAf88K6Nq3PFFDo
 8FGy3KG4w2uVACVZVI3vKAtHZ9iNPj8=
X-Proofpoint-GUID: e4R-QozNRmFSEZ2Dl-iZOZ93BI3Y13-T
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ee185 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=wzXgNLvc2PBhCEj-crYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2QRsTWUErHbe
 rHvgfKFys/nBndXE9l/kW6IINk65E4BG6BJWHKA1ZdZaCqTSf4oVgnFOM9D08qvNnrhrW7VfZD0
 x8oSjiZnNFMO7UVQnGUhtM+o8N7EbxO5356cEvXQUQwMj6NCmj2xTPH59jEFZnicwzulWmUTJx8
 De49YGsynfbnCt6zKIZSRMLVDoCeP+0GyadGf5sAtKOmaCJud645wNxK7eAMM7uz7lHAkCk7L/6
 5jtZiQ10CDumtNYRcGp0HPekAFV3al1GKu9COOZ2bQhwK/ppI3Hn0Kcu29v7iNvMDUA6A8cnSeY
 gsvS87s+HKBhHAR04ncFLj4swLa23rQlVg2/mp3l+ZgIklhPu21JO1Vwj890oIzZbBrnRiD+HoS
 S12rtnZs3gPX9dEmLLyQvu7omiPt8k1RDWOaEfrZPF8r+MoVjLzNbK+BV8qnxG8WUPb+NnKTlUY
 GhMY3ENYVAFA4A78cFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhuoying Cai <zycai@linux.ibm.com>

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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-2-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst   | 20 +++++++++++++++
 docs/system/target-s390x.rst       |  1 +
 hw/s390x/s390-virtio-ccw.c         | 41 ++++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 qapi/machine-s390x.json            | 23 +++++++++++++++++
 qapi/pragma.json                   |  1 +
 qemu-options.hx                    |  6 ++++-
 7 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/s390x/secure-ipl.rst

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
new file mode 100644
index 0000000000..88df52ce2f
--- /dev/null
+++ b/docs/system/s390x/secure-ipl.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Secure IPL Command Line Options
+-------------------------------
+
+The s390-ccw-virtio machine type supports secure IPL. These parameters allow
+users to provide certificates and enable secure IPL directly via the command
+line.
+
+Providing Certificates
+^^^^^^^^^^^^^^^^^^^^^^
+
+The certificate store can be populated by supplying a list of X.509 certificate
+file paths or directories containing certificate files on the command-line:
+
+Note: certificate files must have a .pem extension.
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 94c981e732..8938a13d10 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -35,3 +35,4 @@ Architectural features
    s390x/bootdevices
    s390x/protvirt
    s390x/cpu-topology
+   s390x/secure-ipl
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 06e5def909..fe3a84f238 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -44,6 +44,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
+#include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
 #include "kvm/kvm_s390x.h"
 #include "hw/virtio/virtio-md-pci.h"
@@ -786,6 +787,36 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
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
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_GET_CLASS(obj);
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertificatesList *cert_list = NULL;
+
+    if (!s390mc->use_certs) {
+        error_setg(errp, "boot-certs is not supported by this machine version");
+        return;
+    }
+
+    visit_type_BootCertificatesList(v, name, &cert_list, errp);
+    if (!cert_list) {
+        return;
+    }
+
+    ms->boot_certs = cert_list;
+}
+
  /*
   * S390x-specific global compatibility properties.
   *
@@ -811,6 +842,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 
     s390mc->max_threads = 1;
     s390mc->use_cpi = true;
+    s390mc->use_certs = true;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
@@ -854,6 +886,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -939,6 +976,10 @@ static void ccw_machine_11_1_instance_options(MachineState *machine)
 
 static void ccw_machine_11_1_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+
+    s390mc->use_certs = false;
+
     ccw_machine_11_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
 }
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index f1f06119d6..d30f1fcc4c 100644
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
@@ -55,6 +57,7 @@ struct S390CcwMachineClass {
     /*< public >*/
     int max_threads;
     bool use_cpi;
+    bool use_certs;
 };
 
 #endif
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index ea430e1b88..f79864f417 100644
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
+# Boot certificates for secure IPL.
+#
+# @path: path to an X.509 certificate file or a directory containing
+#      certificate files.
+#
+# Since: 11.2
+##
+{ 'struct': 'BootCertificates',
+  'data': {'path': 'str'} }
+
+##
+# @DummyBootCertificates:
+#
+# Not used by QMP; hack to let us use BootCertificatesList internally.
+#
+# Since: 11.2
+##
+{ 'struct': 'DummyBootCertificates',
+  'data': {'unused-boot-certs': ['BootCertificates'] } }
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 24aebbe8f5..342cedc42e 100644
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
index 34970fffc9..107f74aeb5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -46,7 +46,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
     "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -214,6 +215,9 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
+        Provide paths to a directory and/or a certificate file on the host [s390x only].
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.55.0


