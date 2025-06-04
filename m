Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE726C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw6s-0002bZ-E3; Wed, 04 Jun 2025 17:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6o-0002aF-E2; Wed, 04 Jun 2025 17:57:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6m-0006vQ-GC; Wed, 04 Jun 2025 17:57:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Co04r024220;
 Wed, 4 Jun 2025 21:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FTSEqVa8PMLUQXcji
 niCuH3mMZmYcqBALUMhwl3sU5o=; b=MO1zztiiH+eKHo7qsOf/e2Gdqj2CvH9p8
 2YFbmP6DIG2L0JWRiSnVEvifPuAcOlRpNgS9kooMVTFw+KISvNVUZBrwHDkOtx6x
 iD1XuqBWf4fEhWjjlTLO/7Dh+L9OBH/7XUn7yFdFNCSNlHOZjpCHqUcrV+ajmLJq
 yPPtAgGfHSrRsT0hNG4D7zoHCFCpQ6Hv9+L63YDt0ByoaW1BDAHk49hmO+ujLGO1
 Q3XHw95l+BnIR+lAquBYO1QTWNNu5gZDD8XCr+KqDXNZRCe2lIYW6Z16Wt0JOOi6
 5P92kzOqWMDVCTBI/LebzEzHr0upMY7WPWufUacN4oDMqVRuMNVCg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geywcj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554J9l3m012518;
 Wed, 4 Jun 2025 21:57:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2hguf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvAkj32309972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C17FD58054;
 Wed,  4 Jun 2025 21:57:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BAB958045;
 Wed,  4 Jun 2025 21:57:08 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:08 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 01/28] Add boot-certificates to s390-ccw-virtio machine
 type option
Date: Wed,  4 Jun 2025 17:56:29 -0400
Message-ID: <20250604215657.528142-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=6840c139 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=YF4VPn2d9PPf8wNmfd8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX0n4yI+amZVRh
 gFiXDZB69tspANnyRBUxKp9Rh58aibcKW82f0Wfj+WGDwE6YQOBNloxAOkimE4atOUKUJUkuoMi
 vhRBCAu04DOuNx79zICLjpkyAuA2di/o/I7zea9m3gJD9yZWGBySIa3NqyoCh79qgNZSo+gZyeY
 7qg/pvZUHTEB9c7rsZjDerpDIPufkqCqijby7Y6VbSK6XKem9N+FQ3a2JqKn6/djiBC9hzRpnbF
 Q8cFkNayzuIFr5Yt06r3fKGpUPd5YZsknM4As0dHl5AQbR/33gsX+TnRsoBymMGRoBIRdIaUo2Y
 kfM1MQ1ZHybLvkpZlo8mwiRG/bkV5TVmVIi8b2VVUJnyYQF5wsg315p6n09oflYH6/GQKJfufrb
 cpYOls6Y1TBOnnxIi8xHUgybfJFOqur/Rk5XIDqA5mXwcid+K7ptaFfe1M5ESX2gU/DQV/S7
X-Proofpoint-GUID: uxqCVyRLjdi9R48qKAAETL8LlJ-b1MLD
X-Proofpoint-ORIG-GUID: uxqCVyRLjdi9R48qKAAETL8LlJ-b1MLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add boot-certificates as a parameter of s390-ccw-virtio machine type option.

The `boot-certificates=/path/dir:/path/file` parameter is implemented
to provide path to either a directory or a single certificate.

Multiple paths can be delineated using a colon.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  7 ++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f20e02de9f..144ef52f34 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -798,6 +798,22 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+static inline char *machine_get_boot_certificates(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return g_strdup(ms->boot_certificates);
+}
+
+static void machine_set_boot_certificates(Object *obj, const char *str,
+                                          Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    g_free(ms->boot_certificates);
+    ms->boot_certificates = g_strdup(str);
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -851,6 +867,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+
+    object_class_property_add_str(oc, "boot-certificates",
+                                  machine_get_boot_certificates,
+                                  machine_set_boot_certificates);
+    object_class_property_set_description(oc, "boot-certificates",
+            "provide path to a directory or a single certificate for secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 526078a4e2..45adc8bce6 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -31,6 +31,7 @@ struct S390CcwMachineState {
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
+    char *boot_certificates;
 
     SCLPDevice *sclp;
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..6d01f8c4b2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -200,6 +201,10 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certificates='/path/directory:/path/file'``
+        Provide a path to a directory or a boot certificate on the host [s390x only].
+        A colon may be used to delineate multiple paths.
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.49.0


