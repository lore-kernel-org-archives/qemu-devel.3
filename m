Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38648C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 18:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyaYA-0003RV-3a; Sat, 29 Mar 2025 14:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyaY7-0003RC-Dd
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 14:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyaY5-0002tX-Kn
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 14:04:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52THBjB0008949;
 Sat, 29 Mar 2025 18:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Vb0X5ARUySmELMGO74KK61VzhBGi
 xZKzpOZ/xcqFgqs=; b=iJLjrrF7pfaKGeLcTk7YzshDL4i9bJ6+28+pupIOq3qD
 OplxJkPA0QtNvZMAb3KiVKLzt6OXLpggHAyAlBCkl3RPvoEWR1kEuZC6jTYu973G
 dJ5fdORZQ1wbaRGgiiMhw667BmkfUHecmZJwfJ9Gvb7rTGqlkWbgr3y3gkpqdr90
 tjcfhnCQoEo7PuXY3h0EKO704G6Ewp3lRausGgvyjwBCOIbz+vaV/pzckxo51iAc
 nmRJRLcozvdp657uEhnfrDMB6hH5Hch2VR+aqnSHBGblVNuOO1t6hvW/LLOLO0bW
 tWccP4fE3HKDtrRcWfCG+To0vF/LTZAR9Paf1XVnAQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45pn1w85ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 18:04:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52TI4jBO009391;
 Sat, 29 Mar 2025 18:04:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45pn1w85mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 18:04:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52TDAfse020082;
 Sat, 29 Mar 2025 18:04:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hpggsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 18:04:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52TI4fGT28115570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 18:04:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E518A20043;
 Sat, 29 Mar 2025 18:04:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B93A20040;
 Sat, 29 Mar 2025 18:04:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.16.183]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 29 Mar 2025 18:04:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v3] target/ppc: Deprecate Power8E and Power8NVL
Date: Sat, 29 Mar 2025 23:34:27 +0530
Message-ID: <20250329180427.2566964-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hziLba-mvO25iDDX1aVCxPdtWeMH0fuB
X-Proofpoint-GUID: l4o_N5u5hGJarhRI31myZ-1onytkPy8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503290130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Power8E and Power8NVL variants are not of much use in QEMU now, and not
being maintained either.

Newer skiboot might not be able to boot Power8NVL since skiboot v7.0

Deprecate the 8E and 8NVL variants.

After deprecation, QEMU will print a warning like below when the
CPU/Chips are used:

    $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
    qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
    ...
    $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
    qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
    ...
    $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
    qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
    ...

Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
--cpu ?':

    $ ./build/qemu-system-ppc64 --cpu help
      ...
      power8e_v2.1     PVR 004b0201 (deprecated)
      power8e          (alias for power8e_v2.1)
      power8nvl_v1.0   PVR 004c0100 (deprecated)
      power8nvl        (alias for power8nvl_v1.0)
      power8_v2.0      PVR 004d0200
      power8           (alias for power8_v2.0)
      power9_v2.0      PVR 004e1200
      power9_v2.2      PVR 004e1202
      ...

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Cover Letter
============

Power8E and Power8NVL are not maintained, and not useful to qemu, and
upstream skiboot also has removed support till Power8 DD1.
Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
to be exact:

    commit c5424f683ee3 ("Remove support for POWER8 DD1")

No direct way to deprecate the pnv chips, a field like deprecation_note
could be added, but felt not needed as the chip will only get used if
the user requests corresponding 8E / 8NVL CPU, which will print
deprecation warning.

Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
which will throw the deprecation warning. So just deprecating CPUs should
be enough.

Changelog
=========
v3:
  + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
v2:
  + add mention to docs/about/deprecated.rst
  + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
---
---
 docs/about/deprecated.rst |  9 +++++++++
 target/ppc/cpu-models.c   | 22 +++++++++++++++++-----
 target/ppc/cpu_init.c     |  7 ++++++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e2b4f077d453..d6b39db2aaca 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -275,6 +275,15 @@ embedded 405 for power management (OCC) and other internal tasks, it
 is theoretically possible to use QEMU to model them. Let's keep the
 CPU implementation for a while before removing all support.
 
+Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Power8E and Power8NVL variants of Power8 are not really useful anymore
+in qemu, and are old and unmaintained now.
+
+The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
+be considered deprecated.
+
 System emulator machines
 ------------------------
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index ece348178188..0a2227802c06 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -32,17 +32,22 @@
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
+        if (_deprecation_note) {                                            \
+            cc->deprecation_note = _deprecation_note;                       \
+        }                                                                   \
     }                                                                       \
                                                                             \
     static const TypeInfo                                                   \
@@ -63,6 +68,13 @@
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
 
@@ -722,12 +734,12 @@
                 "POWER7 v2.3")
     POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
                 "POWER7+ v2.1")
-    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
-                "POWER8E v2.1")
+    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
+                "POWER8E v2.1", "CPU is unmaintained.")
     POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
                 "POWER8 v2.0")
-    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
-                "POWER8NVL v1.0")
+    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
+                "POWER8NVL v1.0", "CPU is unmaintained.")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
     POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7decc09aec8f..fade53f7e2d6 100644
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


