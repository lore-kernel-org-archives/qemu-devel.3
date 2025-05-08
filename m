Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429D6C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA62-0004sw-9j; Thu, 08 May 2025 18:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5x-0004kW-64; Thu, 08 May 2025 18:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5v-0006Zs-Cl; Thu, 08 May 2025 18:52:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548KD27Z015638;
 Thu, 8 May 2025 22:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ahr4bg0RNoviLNd0w
 bOt/WxD8XrurKIrzFLE31RIvoU=; b=oYaveJoKu5FUPKNgTzM9m6VJxY3+EqwrW
 HHZs0KUFK89T0PmjUrse07UD+8ljYo48WTzF/Q+RbQRHTJMrIFiARSMp5KtqLPN/
 tZKt7q7JkG9QzuzIup33QICTZLiv5ySKnLveojAKvxW817Qlm6gam65pfC7zlcaf
 OPPbK4E+LQ4uokJd6QLo56I2U2gk/U60rvdGAPU26p3T2LirQvIhI3R/Ix2bCayj
 gQ/7R5HI5zm11BkMtCQH0thbRb4syqHuDrPwdbM/5weRFdDmZIFDQVMyfQMp4JU4
 5u5fupxH7BqCGgbQW5bPlvmwQ995GapOm8GBJmbaEgWFypkfHI0uQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t3aup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548KROiv004221;
 Thu, 8 May 2025 22:51:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2crh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MptQO23790250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF8955804B;
 Thu,  8 May 2025 22:51:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43FBA58055;
 Thu,  8 May 2025 22:51:54 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:54 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 20/25] Add -secure-boot to s390-ccw-virtio machine type
 option
Date: Thu,  8 May 2025 18:50:36 -0400
Message-ID: <20250508225042.313672-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d358d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=lgP8yFKBHTcB7MVMZXgA:9
X-Proofpoint-ORIG-GUID: HWZYhFthipKR1r0ssfr0pYHkq-8OfVX4
X-Proofpoint-GUID: HWZYhFthipKR1r0ssfr0pYHkq-8OfVX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXxjEk0sq2cP4+
 u2yE4QtRiX+Vda6AB2STIxm8ZKUo9RMKSfJp2hSPLGQ6YFY8+eRPs1ZtOk1dS/P54aZL4Xwvp16
 NSTcszy/em8rc/tdo3T+EnNQ1oZnGO8pvjVI8mWaiXt+qv0/7Lhr/y/2N2MFZ+eXFw+VlJuqjSB
 Ee+O54tcdXdfyQFovzDSS1Hwkf++t44QTkOdLrKnfMgC4pHy5FJXM11FDq9K15l7ox67CMGoUB3
 Zpi0LIMsNQNdVn2oYFP3bBDk68kocKGjzQsq6T1SqQ7d9c8UDrxIVv4Z8LyaRA9mLWfU8Ah0215
 WTS59+WtRKgN6gLw2voZbXOGGAAwHazJJesCVBpzWdFtR7cPMyn6bQK/1vT+tUCW02m8dIdJbL5
 fZBiHB33qrNCQJZoDdaB31UgbWpqjST2MoL0UwE78tNJ6AdXvjlGrQt2VWf9O++W9FK6fbYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add -secure-boot as a parameter of s390-ccw-virtio machine type option.

The `-secure-boot on|off` command line option is implemented
to enable secure IPL.

By default, -secure-boot is set to false if not specified in
the command line.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  6 +++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f82f78255a..8486f19ece 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -840,6 +840,21 @@ static void machine_set_boot_certificates(Object *obj, const char *str,
     ms->boot_certificates = g_strdup(str);
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
@@ -900,6 +915,13 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
                                   machine_set_boot_certificates);
     object_class_property_set_description(oc, "boot-certificates",
             "provide path to a direcotry or a single certificate for secure boot");
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
index ed25939243..f4f5df010e 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -32,6 +32,7 @@ struct S390CcwMachineState {
     uint64_t memory_limit;
     uint64_t max_pagesize;
     char *boot_certificates;
+    bool secure_boot;
 
     SCLPDevice *sclp;
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index e592f6a757..498320ad21 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,7 +44,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
     "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
-    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
+    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n"
+    "                secure-boot=on|off enable/disable secure boot (default=off) \n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -205,6 +206,9 @@ SRST
     ``boot-certificates='/path/directory:/path/file'``
         Provide a path to a directory or a boot certificate on s390-ccw host.
         A colon may be used to delineate multiple paths.
+
+    ``secure-boot=on|off``
+        Enables or disables secure boot on s390-ccw guest. The default is off.
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.49.0


