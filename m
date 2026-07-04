Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDD9C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg872-0000jg-4i; Sat, 04 Jul 2026 17:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86z-0000aC-HQ; Sat, 04 Jul 2026 17:41:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86x-0008WU-K2; Sat, 04 Jul 2026 17:41:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmKVU2457433; Sat, 4 Jul 2026 21:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MA+k9kiIc2sdIoHjO
 jG2e6kKXih+U/hh/xHyPnHpzJs=; b=IsL46MRKfuMrXIurJYveeq5jrJd7Y2RL6
 SlJeqBxjkM0H5jvvvgDWpWs820wg5pKXFIWZ4GnDBe2lsxnFxb4Pw5sTsTw61PL8
 BkaYg2gzBO/y9Ocx/sxCF2zOr8VkKmVHaNCnqPE40pp4GsX9GyiR7QJKIuAAqanV
 6L/WNkMjJ4GPAl8UmltZN0WSbfBlteLHFcp1UtHzwWF4KrIoOO/Y70RqPGD0NsRB
 XgNXe7NTqyTWZPqaEg5KvvyHwSP7CyzIMAsjn4k1YkoH7doRatxWv9mH5dHK3QTC
 rrcq1VjxnyGMSdzOmqgjBV5JnCEIi9q053s/tLvK8n3FinHUk7W6Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn3hn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYZDx011754;
 Sat, 4 Jul 2026 21:40:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukpgnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664Lerui28443208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4294858054;
 Sat,  4 Jul 2026 21:40:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A39B5805E;
 Sat,  4 Jul 2026 21:40:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 27/33] Add secure-boot to s390-ccw-virtio machine type
 option
Date: Sat,  4 Jul 2026 17:39:43 -0400
Message-ID: <20260704213950.2118823-28-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a497de7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ZvnaDWGK54Hqr3b-QrcA:9
X-Proofpoint-GUID: _-fhp3rBJ5unZnZ5af_HvJzEPTWpupS2
X-Proofpoint-ORIG-GUID: _-fhp3rBJ5unZnZ5af_HvJzEPTWpupS2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX9vZHkgbhMiLq
 DGIJak7Vx7ZOgSg/gtKnn82gfQ3jSl6VhTaBm1SXYxjBWAvoy7BbQM1lOkj3fR+V1khPi2Xq9Jf
 jJHlPpIf+SOx/47GX6rtbV4qeudu8Kw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX+O75h2Va+V4J
 hry5OzeVXh3M/z1QOc1SYLl8J8TF1hHKatDRj8hpG8jqi7toVATvY7Nprc7S4Wf9sots9Tkl21h
 AtcnUJkXm+yl1N87N8fqv4H4zaphjIEgK86jSypY4n8MGl9FjlAes6l/IMOdQQUw28RkWxMk1CR
 NBxIdXStxvDTyBXbxNFZ3oOzu1pobqoW0gb5JwlAwI6CoQLRRnHAuXtk0LI3etaFKmB6P/AU73I
 KD048q9CFIt49UY3mq2OJ4U3f8vUynwmCaHSoW0f3xM/1Wh5/A6jZQOsCNoAiQLifH2jph224ue
 otNn2vS4GLwFthGt4BA+/deq2q0ePC5vPxMfyD6Dn7zjojQxtyt4u1DwK1GxAwZSB308PPK7wxN
 czjhHPbB4P9abbKg/QIGd63EeFUyry1ISQKEUZHsFlR/ucl+D3BPg9ytB8jZh1rcl/GK7P4iyjQ
 oA8WR4yAxg0agOuLUUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
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


