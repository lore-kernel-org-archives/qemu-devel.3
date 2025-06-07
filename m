Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B40C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 11:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNrMC-00047M-2a; Sat, 07 Jun 2025 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrM9-00046H-5A; Sat, 07 Jun 2025 07:04:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrM7-0002Jy-FL; Sat, 07 Jun 2025 07:04:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557AFKAN027792;
 Sat, 7 Jun 2025 11:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2JGfp3
 ayf6gqF40MiWlnX7cN3J9tWvk4fnQV5SdohcQ=; b=L4FC1Lxg6lStojOFBWTmlE
 sVgmwHmANFXggjKtvfL1nAf5ZSRuwffHBjoctbS6FCb17YkfvkV0KVFGgG1p2mez
 7fqc/LJjqyM2lTeCFVAFPRaMGiOymH6ozTDHB786OvMZGNTtHF8yJTZbtNTQ6PKS
 X6+IaImMdn7b/69uA/fLAmdRfGJAqgUaMsAohZXn5HW2uzMYnzoo2Ng1GZem7Fg2
 B/tVyDCu7CV45mhWjNHIfBgpqT892nUkQU/BH/wUnb4n+sRZVATE2UoIauDVTTD2
 i17ZjBtHBD1r+FOCnFmpIOZanv+8429M6l/9zS+vBEIMeZ9EH8Qrf/9DxmOEC46Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7126f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 557B4i8c016190;
 Sat, 7 Jun 2025 11:04:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7126d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5576FA9g031750;
 Sat, 7 Jun 2025 11:04:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg0dr2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 557B4cUu46530878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Jun 2025 11:04:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D10120049;
 Sat,  7 Jun 2025 11:04:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D4D520040;
 Sat,  7 Jun 2025 11:04:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.13]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Jun 2025 11:04:35 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v7 1/2] target/ppc: Introduce macro for deprecating PowerPC
 CPUs
Date: Sat,  7 Jun 2025 16:34:11 +0530
Message-ID: <20250607110412.2342511-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607110412.2342511-1-adityag@linux.ibm.com>
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nEwJY479hAuZy_Nb_bsdKoPLLAB3R5eh
X-Proofpoint-GUID: iRvrEH_qjKKmBoU_-eqdNg4Dam_5iifa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA3NyBTYWx0ZWRfX0RRTY+WUsiSy
 AieCDlMTVnk1W6fPb0cAGBq/ev2C5WEwrNkbFFBgCGNj0Bu/5TFLlJKgKT6urmQUcPMUKPcApeP
 JH4kSsX5UOlO0qIFbpC+yrJmjAwS7bsWrFc2BSPTnBxTrqSql+MpxysBV6zif/Ktza3drRZwXQZ
 ttjY5dnF9nO9ESI5ahfUVbBMMfYqdjf4nGJxx2qCUXKOSAuQTFjy35oMdADghBdvAQ7c6yZ22r5
 fntZkVqwnzeqAjAq9w7UCTj/lK50jCl8513NjsGV/mJLgtMSC+NfRfVIFhZiOjC5k6EQtg31yBJ
 +XKUHDwsHBIQEO3UcHn4EHn4RNfoEXdapyZM0+akL6VeYtFL1oHAKn3de9l0NGIB491KyVhPGEM
 0GiQ8vSLeVcjq8EjJ4jzYCDbzGMj3/HFF436HAO03dPMkhiyDvkSDEm/Z0ajQ2MI22tfFDde
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=68441ccc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=tI4a-1GSuBuAjZxPa6cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
index ea86ea202abe..bc3f9586cb67 100644
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
     (ObjectClass *oc, const void *data)                                     \
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
index a0e77f2673e5..29b72a86576d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7143,6 +7143,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
     char *name;
@@ -7153,7 +7154,11 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
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


