Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4607ACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1TF-0005UC-SJ; Wed, 17 Sep 2025 19:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1T5-0005Pw-Pe; Wed, 17 Sep 2025 19:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1T3-0002M6-EN; Wed, 17 Sep 2025 19:21:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HJq7KB011526;
 Wed, 17 Sep 2025 23:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HI2dOT3ByAVc/B/jk
 6yDX+plq0qVvsBfrkLmgYHOCHw=; b=NwrIeUcckgnWOzwwIQMhIOSPkDrgZCbzB
 rRgWsBU6oae6N+jmiJJ9KRsSYl+0cMBYWOs8KC1MNK6GjXL/QgB4xmEIgXb3Zy/e
 9olhN2+lw7K8wNQmgNuw1XqBeYDBvL6NbTG3IRVcS96dYhXVSHBBRro7d3pp0LK4
 feJcLDOPRz576UNfOl5v/BLKZiluUAs6Lf6y6woQXzqJlixhIKLTcTE1b1YUOwtC
 CgyL5L376VzR8lpmxERPtJs/MDiqVHt2Ru53jMtOT1QmyYvWMuuU0rTWmK6tAuM6
 QkB1towN6UVTpLHXEHvC6iS9ENaADBYVurgAZ/36JMBpgDvlcHLpA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j6usv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMcvYN009486;
 Wed, 17 Sep 2025 23:21:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3kghd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLXVR31588826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2065805A;
 Wed, 17 Sep 2025 23:21:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C7F05805C;
 Wed, 17 Sep 2025 23:21:32 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:32 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type option
Date: Wed, 17 Sep 2025 19:21:03 -0400
Message-ID: <20250917232131.495848-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cb4280 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=51CbwtZII9I6y_JNZ0sA:9
X-Proofpoint-ORIG-GUID: tVZFKx-cJ3ipWlAMqmJX99MK0FvJKfGP
X-Proofpoint-GUID: tVZFKx-cJ3ipWlAMqmJX99MK0FvJKfGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+uCz3a/6CAfe
 QEyifrDOLwEOFgoiEVMRXaGzSizIaFaD851MTd//KC6LJ8pf6xZf+qvAUTru2UCC30VSl6zIiJz
 FVZFNFtH9saCALSu1EfLzuSxg3aj+XFre5YK1tTkEVKhFWmMg/WrlD5Qr7OplNVKRccTAPY56VD
 YvkGSl/4fUq2zIODqaYYbNcIpE/EtfMArxvs+PkZWl/bpp2Eyib9JjKzKrAZLDnt9e4R3O7PgR0
 kp8v2iTAeFQ40EYNQ2CS9l4miLHLeWr6QDJ+XIKBLyeZ39cEiDrV/xmEyF4Wfqiyn7FDYqBOt++
 sR5CSlsH49cA7eg3UEAWLMGNn32kYJpkdZtIMfNoWZHGfHyb0oqHbguNwKTrIcPwsxVqJCiirsR
 BuM6Mkxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
---
 docs/system/s390x/secure-ipl.rst   | 21 +++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  2 ++
 qapi/machine-s390x.json            | 22 ++++++++++++++++++++++
 qapi/pragma.json                   |  1 +
 qemu-options.hx                    |  6 +++++-
 6 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/s390x/secure-ipl.rst

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
new file mode 100644
index 0000000000..92c1bb2153
--- /dev/null
+++ b/docs/system/s390x/secure-ipl.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Secure IPL Command Line Options
+===============================
+
+The s390-ccw-virtio machine type supports secure IPL. These parameters allow users
+to provide certificates and enable secure IPL directly via the command line.
+
+Providing Certificates
+----------------------
+
+The certificate store can be populated by supplying a list of X.509 certificate file
+paths or directories containing certificate files on the command-line:
+
+Note: certificate files must have a .pem extension.
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio, \
+                               boot-certs.0.path=/.../qemu/certs, \
+                               boot-certs.1.path=/another/path/cert.pem ...
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b1dc52807a..b825f4cce1 100644
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
@@ -798,6 +799,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+static void machine_get_boot_certs(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertificateList **certs = &ms->boot_certs;
+
+    visit_type_BootCertificateList(v, name, certs, errp);
+}
+
+static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+    BootCertificateList *cert_list = NULL;
+
+    visit_type_BootCertificateList(v, name, &cert_list, errp);
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
@@ -851,6 +876,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+
+    object_class_property_add(oc, "boot-certs", "BootCertificateList",
+                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
+    object_class_property_set_description(oc, "boot-certs",
+            "provide paths to a directory and/or a certificate file for secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 526078a4e2..334b67ef05 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -14,6 +14,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 #include "hw/s390x/sclp.h"
+#include "qapi/qapi-types-machine-s390x.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
 
@@ -31,6 +32,7 @@ struct S390CcwMachineState {
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
+    BootCertificateList *boot_certs;
 
     SCLPDevice *sclp;
 };
diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 966dbd61d2..51bf791fe6 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -119,3 +119,25 @@
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
   'features': [ 'unstable' ]
 }
+
+##
+# @BootCertificate:
+#
+# Boot certificate for secure IPL.
+#
+# @path: path to an X.509 certificate file or a directory containing certificate files.
+#
+# Since: 10.2
+##
+{ 'struct': 'BootCertificate',
+  'data': {'path': 'str'} }
+
+##
+# @DummyBootCertificates:
+#
+# Not used by QMP; hack to let us use BootCertificateList internally.
+#
+# Since: 10.2
+##
+{ 'struct': 'DummyBootCertificates',
+  'data': {'unused-boot-certs': ['BootCertificate'] } }
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 023a2ef7bc..66401837ad 100644
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
index ab23f14d21..ac497eb3a0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,7 +44,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -205,6 +206,9 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
+        Provide paths to a directory and/or a certificate file on the host [s390x only].
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.50.1


