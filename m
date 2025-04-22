Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382EFC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76hA-0002h0-LH; Tue, 22 Apr 2025 02:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u76gz-0002Yf-Tw; Tue, 22 Apr 2025 02:01:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u76gx-0003Gr-UI; Tue, 22 Apr 2025 02:01:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M3bIRI010449;
 Tue, 22 Apr 2025 06:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AVg04r
 lXvsEp+y2WSs0A+UZjUhdyMesSzSDDGh+HHTY=; b=qs6B1i2u2+8CeYECJsw633
 8bC7qNAYGKEYJjN6+cgmMdvV9fIoesUp651hks9wgVQt74thblGpqgbhz6APXG5L
 X0alEPzJCzfcLeurGLytRLYjtjymyLDtX8D0Ys00x0Pw2mEdGzLhjGVOYYxL4tJE
 HlYXR4VkSw071bae8G1JM5S1NgXE8LHClr9eG9pv7pagjJb7HEh2MdJ7pcAG62D0
 XCL95yLpfIqbvirfmWTUYVtUDWbOmaRRMbjcwsFfSye84N8bX0q+dtQwAhc7rAoi
 UHP4btWy8U+H/BTv0jN2jrCLv5pMxy6jYdYJAkfDuUWw2wDr8uKFPAbvR6JPC8Ow
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663c40ew1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:01:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M60xt1016169;
 Tue, 22 Apr 2025 06:01:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663c40ew0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:01:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M42QSM028120;
 Tue, 22 Apr 2025 06:01:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv215we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 06:01:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M6101954985066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 06:01:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D63D92004D;
 Tue, 22 Apr 2025 06:01:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA77F2004B;
 Tue, 22 Apr 2025 06:00:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.215.117])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Apr 2025 06:00:57 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v6 1/2] target/ppc: Introduce macro for deprecating PowerPC
 CPUs
Date: Tue, 22 Apr 2025 11:30:49 +0530
Message-ID: <20250422060050.76094-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422060050.76094-1-adityag@linux.ibm.com>
References: <20250422060050.76094-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kXTk-GIEeMJIOu69KQs2nRsntHy-YopR
X-Proofpoint-ORIG-GUID: 6KW8m3mDu0WBTYxHcB1R9X6RLyl6tIgu
X-Authority-Analysis: v=2.4 cv=HeEUTjE8 c=1 sm=1 tr=0 ts=680730a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=tI4a-1GSuBuAjZxPa6cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220045
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

QEMU has a way to deprecate CPUs by setting the 'deprecation_note' in
CPUClass.

Currently PowerPC CPUs don't use this deprecation process.

Introduce 'POWERPC_DEPRECATED_CPU' macro to deprecate particular PowerPC
CPUs in future.

With the change, QEMU will print a warning like below when the
deprecated CPU/Chips are used (example output if power8nvl is deprecated):

    $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
    qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
    ...

Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
--cpu ?' (example output if power8nvl is deprecated):

    $ ./build/qemu-system-ppc64 --cpu help
      ...
      power8e          (alias for power8e_v2.1)
      power8nvl_v1.0   PVR 004c0100 (deprecated)
      power8nvl        (alias for power8nvl_v1.0)
      power8_v2.0      PVR 004d0200
      ...

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 target/ppc/cpu-models.c | 12 +++++++++++-
 target/ppc/cpu_init.c   |  7 ++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index ece348178188..78ef23b4c4b8 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -32,17 +32,20 @@
 /* PowerPC CPU definitions                                                 */
 #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
     glue(glue(glue(glue(pvr, _), svr), _), type)
-#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
+#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _deprecation_note) \
     static void                                                             \
     glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
     (ObjectClass *oc, void *data)                                           \
     {                                                                       \
         DeviceClass *dc = DEVICE_CLASS(oc);                                 \
+        CPUClass *cc    = CPU_CLASS(oc);                                    \
         PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
                                                                             \
         pcc->pvr          = _pvr;                                           \
         pcc->svr          = _svr;                                           \
         dc->desc          = _desc;                                          \
+                                                                            \
+        cc->deprecation_note = _deprecation_note;                           \
     }                                                                       \
                                                                             \
     static const TypeInfo                                                   \
@@ -63,6 +66,13 @@
     type_init(                                                              \
         glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
 
+#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
+    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, NULL)
+
+#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc, _deprecation_note)\
+    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type,       \
+            _deprecation_note)
+
 #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
     POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc38..78a25637ad4f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7144,6 +7144,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
     char *name;
@@ -7154,7 +7155,11 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     }
 
     name = cpu_model_from_type(typename);
-    qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
+    if (cc->deprecation_note) {
+        qemu_printf("  %-16s PVR %08x (deprecated)\n", name, pcc->pvr);
+    } else {
+        qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
+    }
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
-- 
2.49.0


