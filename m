Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15723C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFPf-0002Ug-7R; Tue, 07 Jul 2026 19:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPc-0002TU-Ri; Tue, 07 Jul 2026 19:41:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPb-0006Fc-0w; Tue, 07 Jul 2026 19:41:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmaEK1572082; Tue, 7 Jul 2026 23:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MA+k9kiIc2sdIoHjO
 jG2e6kKXih+U/hh/xHyPnHpzJs=; b=F0GuQrGsJitWZ0EPEalCVbH6Hpk5MZo0+
 idQxnku+PLGGO28UOeH5XV+RiYEg9C8ZcQjKqNFIgFbKK4sijf/NRHrcAip+9HIx
 w4B+3S4hFUA8UypDuvsNiE6OvHNMV7P9WD1LdJeT9un/7XQhzAbYQ1KAeuG7eGaY
 T4Q1ugIheeTxWcmdsyVxX3sdlRN3WEGXx2VovasQwuQp78g3UuFby7lSEacPPSar
 iFS7DjNDJ+WPOax+eFvcV80FXrjKIi2flANDTeN53TwvBbxsNx97GP2Di1MCETY0
 ROQwD1GpxyD1+OqIgyvmwx4c9bKCGKk7/oaJhRbz85GWhkwC8KnQA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknhdn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NYk24015266;
 Tue, 7 Jul 2026 23:41:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk5589-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667Nf5Lk31457814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:41:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C5FB58069;
 Tue,  7 Jul 2026 23:41:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82EB958056;
 Tue,  7 Jul 2026 23:41:03 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:41:03 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 27/33] Add secure-boot to s390-ccw-virtio machine type
 option
Date: Tue,  7 Jul 2026 19:40:40 -0400
Message-ID: <20260707234047.2499921-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707234047.2499921-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d8e93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ZvnaDWGK54Hqr3b-QrcA:9
X-Proofpoint-GUID: BOJAg_7LZiwGAazkvNkxoGMC_KI3UjlM
X-Proofpoint-ORIG-GUID: BOJAg_7LZiwGAazkvNkxoGMC_KI3UjlM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX1mcwHJfibwch
 InaQ21CypwZYSRK/tC7QcxtWOrp5EyeQPOxpznoEmG17gljuitwTdevIwvc71ZGwFNispgYNZdR
 +UOI06Yw1LhSNLgOt8bQo1V9MGgWToo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfXzQgGs7vKXLr+
 vGh9ZikuFwDqVparbqlKd6gRtpcpxtoYq08xb0ZJ1d2L3HwzmXW/Q9bOz6oxnjsPvSJFi0/yYbe
 oSOLh0mPIZAJbbaOuGJLzbkSg2gTid92ko3JHLviB82xkiXnqNIbwaDpyigrr/V6O0MuYRcp632
 cktl9+NHbYe34SRCUy96nwv/mD9HQQTgasSaZbCrHNlLw7Dsec7PkGjXa1nl8ozPlfw2U4DVkgS
 OGdqMohz6fPXFGKcoXRuyP/CDG1z2ee1TzLuG5OxukA20WCuyc4FbzRKTWKF3pszShPjIEB6R2+
 kqBJ5et0Myk/zEuYQBiWDsHNOB9947kd+EpE5AANGrjbXPvdm5i8uxq9ODtIACk0kv/JUXvEaz/
 61tjfnRYjVFOdAa7DrV3vrBAQVQuB3jeLjpQd/HFxP8pZRMs16jYKCXvJV8dxMnMAVfVGh5m+R/
 QvjB9yW8pGp4kDjVanA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070229
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add secure-boot as a parameter of s390-ccw-virtio machine type option.

The `secure-boot=on|off` parameter is implemented to enable secure IPL.

By default, secure-boot is set to false if not specified in
the command line.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst   | 22 +++++++++++++++++-----
 hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  2 ++
 qemu-options.hx                    |  6 +++++-
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index cf6ccf5d57..9e3955f8fc 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -19,20 +19,32 @@ Note: certificate files must have a .pem extension.
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
 
+Enabling Secure IPL
+^^^^^^^^^^^^^^^^^^^
+
+Secure IPL is enabled by explicitly setting ``secure-boot=on``; if not
+specified, secure boot is considered off.
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
+
 
 IPL Modes
 ---------
 
 Multiple IPL modes are available to differentiate between the various IPL
-configurations. These modes are mutually exclusive and enabled based on the
-``boot-certs`` option on the QEMU command line.
+configurations. These modes are mutually exclusive and enabled based on specific
+combinations of the ``secure-boot`` and ``boot-certs`` options on the QEMU
+command line.
 
 Normal Mode
 ^^^^^^^^^^^
 
-The absence of certificates will attempt to IPL a guest without secure IPL
-operations. No checks are performed, and no warnings/errors are reported.
-This is the default mode.
+The absence of both certificates and the ``secure-boot`` option will attempt to
+IPL a guest without secure IPL operations. No checks are performed, and no
+warnings/errors are reported.  This is the default mode, and can be explicitly
+enabled with ``secure-boot=off``.
 
 Configuration:
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c68a760f75..662fb44e16 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -819,6 +819,27 @@ static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
     ms->boot_certs = cert_list;
 }
 
+static inline bool machine_get_secure_boot(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return ms->secure_boot;
+}
+
+static inline void machine_set_secure_boot(Object *obj, bool value,
+                                            Error **errp)
+{
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_GET_CLASS(obj);
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    if (!s390mc->use_secure) {
+        error_setg(errp, "secure-boot is not supported by this machine version");
+        return;
+    }
+
+    ms->secure_boot = value;
+}
+
  /*
   * S390x-specific global compatibility properties.
   *
@@ -845,6 +866,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     s390mc->max_threads = 1;
     s390mc->use_cpi = true;
     s390mc->use_certs = true;
+    s390mc->use_secure = true;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
@@ -893,6 +915,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
                               machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
     object_class_property_set_description(oc, "boot-certs",
             "provide paths to a directory and/or a certificate file for secure boot");
+
+    object_class_property_add_bool(oc, "secure-boot",
+                                   machine_get_secure_boot,
+                                   machine_set_secure_boot);
+    object_class_property_set_description(oc, "secure-boot",
+            "enable/disable secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
@@ -981,6 +1009,7 @@ static void ccw_machine_11_0_class_options(MachineClass *mc)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
     s390mc->use_certs = false;
+    s390mc->use_secure = false;
     /*
      * Preserve v11.0 and older version behavior:
      * keep legacy virtio-pci enabled.
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index d30f1fcc4c..dcac486bc4 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -29,6 +29,7 @@ struct S390CcwMachineState {
     bool aes_key_wrap;
     bool dea_key_wrap;
     bool pv;
+    bool secure_boot;
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
@@ -58,6 +59,7 @@ struct S390CcwMachineClass {
     int max_threads;
     bool use_cpi;
     bool use_certs;
+    bool use_secure;
 };
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 83915bd7ef..f6eee518cf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -47,7 +47,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
     "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
     "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
-    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n"
+    "                secure-boot=on|off enable/disable secure boot (default=off)\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -218,6 +219,9 @@ SRST
 
     ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
         Provide paths to a directory and/or a certificate file on the host [s390x only].
+
+    ``secure-boot=on|off``
+        Enables or disables secure boot on s390-ccw guest. The default is off.
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.54.0


