Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C2CC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYbM-0003vI-Fu; Thu, 30 Jul 2026 17:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbF-0003BY-2K; Thu, 30 Jul 2026 17:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbD-0002Ri-7h; Thu, 30 Jul 2026 17:47:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlhYQ3942086; Thu, 30 Jul 2026 21:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A/RXkjZIi8GjJ3RbG
 63mVtQcLeXErdwTdJ7lFuXxXoA=; b=ZEMCNHypID47fztp8UhaFaTxWzSHqkLoX
 7riyKo+q5f7TL8Acdy9WpaJp5/Jrc/t9v3yFKrTlSX3kGk9eXYWNQBdj/Hgu+zYK
 ANicSOnuATkGxE/GGURUlZSQKqAkay16u0dnmSS0xk9BXrGIiSiaIbCeMX8XXT4B
 VDVamznONvxAifWrOWRnet2dxElUfDVnKe5UeVay/BWuVhTCAGsdHc0x0ysY7jDc
 WuA5VU7gqy2t4Q3lfiyQDpj1xya2BoUzotBfUxeJ+8ND5jr9YGyY19R6xXxKL85i
 9GidIFBLqUr/Fh/nJrzFbR3dqJRrkLBrvlD1Ao1Cuwfj8CddA/+Dw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7t25m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfIte005443;
 Thu, 30 Jul 2026 21:47:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwde1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULlPD831982314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5F9E58068;
 Thu, 30 Jul 2026 21:47:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F9CE58053;
 Thu, 30 Jul 2026 21:47:23 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 27/34] Add secure-boot to s390-ccw-virtio machine type
 option
Date: Thu, 30 Jul 2026 17:46:16 -0400
Message-ID: <20260730214624.2328883-28-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: icfHGulTLz56igtdXraFx0bQOpJYGPtB
X-Proofpoint-ORIG-GUID: icfHGulTLz56igtdXraFx0bQOpJYGPtB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX3MfcpYi9ol0w
 onN9rZhFG9V/SfW24FPSOVrKKFdSJqpAjF1NyUunjqksdtwoGBCL/H/dknCowzWMWg2eUO+563m
 KuU5zB+CV2g3liVydDi4uZKxGaqlWTYSToICk6z32RzUPFktSbQlHaYf8z2NqC9B0B0JFYUSUbR
 V69dUoqK3jVQrJ2Gs3KDgJrK+F6FhKi1EJ1IC7B10Tkd1XgjeKhpiIOfDPXFNJyN9yNitYbbMxL
 CCCTpyboCtz9G8L685qabBuBAhjnZL5mGK4slahsCKLfz81SiTbI52PBwfAFpwPEn6hFZOZhD5o
 niWFiQtjj4DoLYmu9MrU09HdRrzawEyOUiGWdx4VLmD5byt+fijOvvwMdETM/WJsEbx/4CZmPcP
 m0pqQ/oX0d2N5ePRa8+PdWVHHloQJeZu1Y0EB7ouIPyHkjr8Y/q/ioAi1RrCDohTIUeTGqESnuc
 lftkLdJgNlco+cTzAyQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bc66f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ZvnaDWGK54Hqr3b-QrcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX77mqzFseEiBV
 cW1xahLARpkKcHLhH7Lbc0ET0XRY3JwH9+0NLmhsgCaiPmef69ZFOOEpXENDkjNzy17yX5lDStZ
 lfFd4RN1tmqexX8nxyr9j6a+5/XaGfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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
index b69cd49418..bf86b6b00b 100644
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
@@ -981,6 +1009,7 @@ static void ccw_machine_11_1_class_options(MachineClass *mc)
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
     s390mc->use_certs = false;
+    s390mc->use_secure = false;
 
     ccw_machine_11_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
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
index 107f74aeb5..562c4c2b03 100644
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
2.55.0


