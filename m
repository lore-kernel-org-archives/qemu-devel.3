Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7109D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QKp-00017L-Da; Thu, 02 Apr 2026 18:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKM-0000sF-JY; Thu, 02 Apr 2026 18:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKK-0004qy-PJ; Thu, 02 Apr 2026 18:15:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632AE4rj3763981; Thu, 2 Apr 2026 22:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FoAsT8jt3Pe/QAvbh
 eyE/t0d2NTnkaPDFEy/Sv0Fq0g=; b=CkBhBVS7nnZx4HtOf/D3Fp2MpeONlA6oJ
 B1KVyfEMQFrXDuKlRqAlSpzv6rXrjEHFuoH8VOhpgWBMHw/sUZgeQNDOc/ITVUta
 K1fjdeBkbmKrHHYv5p+UfJ/Gn9vfQQc41eWivk00sYNBlTqLLS9AJOZEoif2CXbz
 VDhE/9JJq+OOKnclO21BvpwJeliq6NrUcDGaIdrMRa8HpknP4GajbyXpmhIp3ZvQ
 mYvm0VW/49h1txzSy+nIKsgW6w6NPUqRmjX4PZrJGVCsGtfqLRc2BepfAHHmr+of
 Ixa+Zw5AUHDeRP7ZwyFHBCjz9YWr6nptkvf1EsRgYf1uPrcaRsCYQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g26vdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632JqSAP005947;
 Thu, 2 Apr 2026 22:15:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyc10f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFgYH32965264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18C2758069;
 Thu,  2 Apr 2026 22:15:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B66BD58067;
 Thu,  2 Apr 2026 22:15:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 23/30] Add secure-boot to s390-ccw-virtio machine type
 option
Date: Thu,  2 Apr 2026 18:14:45 -0400
Message-ID: <20260402221453.1602899-24-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ceea90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uyvjcAWwEQu1yBn7KtoA:9
X-Proofpoint-ORIG-GUID: GasDZEs_BZw09xygFpCMJTf5nCP_96pg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX7cd1dbKf6kmc
 b2a1Nd79FfzfsBhoP8UzWV/5/dn5MpYfHzr8J3NomnTztU+Dg2lQrBot7RIbT6qSBRV+sJfNxYm
 APLwPaanhuZQ9CmdQY8nDQhNjhelLxDSnQb6hPHYGERkjr3pkmXu7TtNh1+PeO9QTEpRx0vojYj
 ASvUOEQDceFx200ir8+IKU40rnsd2HwKNwNuxrklRLcJfqB680S4kONvEK18a9tkzISBFMsY4ld
 2aabpqpEwIKZdca1OjwgBkH4IKOeStDn6EWtYQu6+7BSxhDO9MbA+mv9bnAOE3G6YA9jUra4Fmw
 7AhjHkKNp6dn2Tl4RMrS/ARAu4wuYdC0eqi3q8n6AMvVFuLfxjUpGapV81DHFcT0bzVUG4HozZO
 br46YUoeaCwW6qjNwPH+IQhGudlNFv7tY3q5tzozXARiRhMGHViVUfyPtr7cPFpE7ypxZ7WnMHr
 +BpQS4Ehb3tWb4C+hLA==
X-Proofpoint-GUID: GasDZEs_BZw09xygFpCMJTf5nCP_96pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add secure-boot as a parameter of s390-ccw-virtio machine type option.

The `secure-boot=on|off` parameter is implemented to enable secure IPL.

By default, secure-boot is set to false if not specified in
the command line.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/secure-ipl.rst   | 22 +++++++++++++++++-----
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  6 +++++-
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 3a19b72085..2465f8b26d 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -19,19 +19,31 @@ Note: certificate files must have a .pem extension.
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
 
+Enabling Secure IPL
+-------------------
+
+Secure IPL is enabled by explicitly setting ``secure-boot=on``; if not
+specified, secure boot is considered off.
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
+
 
 IPL Modes
 =========
 Multiple IPL modes are available to differentiate between the various IPL
-configurations. These modes are mutually exclusive and enabled based on the
-``boot-certs`` option on the QEMU command line.
+configurations. These modes are mutually exclusive and enabled based on specific
+combinations of the ``secure-boot`` and ``boot-certs`` options on the QEMU
+command line.
 
 Normal Mode
 -----------
 
-The absence of certificates will attempt to IPL a guest without secure IPL
-operations. No checks are performed, and no warnings/errors are reported.
-This is the default mode.
+The absence of both certificates and the ``secure-boot`` option will attempt to
+IPL a guest without secure IPL operations. No checks are performed, and no
+warnings/errors are reported.  This is the default mode, and can be explicitly
+enabled with ``secure-boot=off``.
 
 Configuration:
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a6f0fc4e00..a24cc14906 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -813,6 +813,21 @@ static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
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
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    ms->secure_boot = value;
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -871,6 +886,13 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
                               machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
     object_class_property_set_description(oc, "boot-certs",
             "provide paths to a directory and/or a certificate file for secure boot");
+
+    object_class_property_add_bool(oc, "secure-boot",
+                                   machine_get_secure_boot,
+                                   machine_set_secure_boot);
+    object_class_property_set_description(oc, "secure-boot",
+            "enable/disable secure boot");
+
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 5ad1ea2f24..93a4c0ccad 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 75e6c0f025..e82d78fbb7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -46,7 +46,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
     "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
     "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
-    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
+    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n"
+    "                secure-boot=on|off enable/disable secure boot (default=off) \n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -213,6 +214,9 @@ SRST
 
     ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
         Provide paths to a directory and/or a certificate file on the host [s390x only].
+
+    ``secure-boot=on|off``
+        Enables or disables secure boot on s390-ccw guest. The default is off.
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.53.0


