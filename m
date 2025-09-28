Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7AECAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3w-0003GR-Q4; Sun, 28 Sep 2025 15:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3q-0003D3-Rq
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3d-0004Aj-D8
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SBo5cY023585;
 Sun, 28 Sep 2025 19:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wgrzQ0
 a/ju9r+p/+/4fsJxtVO5oUWWkREon+PHjox58=; b=SgkrC4w/VmzdvtYtxsGM6q
 As5fCThrDNnxdX5agUiffYkO5/0vLbycRG2oy+WjX49bPjGdt5eH5vUcQWxiK64y
 F9qNOjj+ePD36llrWoVV+Up1ayxOCpwqg9JW4CLY1tK1cv5UbaMAy5S5WRbEzZKA
 MmPlxT16RnomqspE3Bg+Pn11OeyxpnDAfBxOpQe4RKftwCbkwzi0DcOvJeE4Wm9r
 nrOemI/R7dotu99iEPeOrs1tv4oc4jvltYi+kfyltuQc7Q+NAC7FB/4OlsCV3fXg
 pazNJrEy61LUsKtrXsCmEUxwqegyPfEFdgmwDPZ+x65nZwavpDlCIN+Wx41TTXPg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6qcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH7oKV020074;
 Sun, 28 Sep 2025 19:27:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJRFRT53018950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0636620049;
 Sun, 28 Sep 2025 19:27:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9171820040;
 Sun, 28 Sep 2025 19:27:13 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PULL 25/27] target/ppc: Introduce macro for deprecating PowerPC CPUs
Date: Mon, 29 Sep 2025 00:56:27 +0530
Message-ID: <20250928192629.139822-26-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d98c17 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8 a=M8LiBw34HdRStUW-rpwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX8sh2GhSjIS2T
 Yvepj/GInqqByLDro/GTYy7AGSja/YrWphUZRC5hsntC0KDYmcckyDJHPPBcxLsk9PQikhR/+g7
 IHGFqVgTJYY0XvSAl3fwNp6GJ6zab9nlZ+a1agIyxgjCdTycl43yblouBV0X5m0/y1WhvAIYLMa
 zXxg3+xiGnZqjac/1SzCNL8dQzGaIHqjR5NtOXki/LDe7ERQ9wicZPTG8+SKozyCadu+kLrLBx1
 EDxYjo4FW/wak0NnFiLIymxi8s9MFvRkmy52hlRGvVMUUGRcTVuY+UmMuFYJI/qZIDU4igXTUiD
 aTJJwPGYa3bUy0knhJVV+/cwEWzHforYP2XNXLyy/Lxua8q7EPC4bLrTrAde0jxyRLRwAXTNR80
 Tbsj2Aw7qq483FS05TVn0kfrUXAHrA==
X-Proofpoint-GUID: rTkfoue605SVfd0w91J4EYPeYpq_-rpl
X-Proofpoint-ORIG-GUID: rTkfoue605SVfd0w91J4EYPeYpq_-rpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Aditya Gupta <adityag@linux.ibm.com>

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
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250607110412.2342511-2-adityag@linux.ibm.com
Message-ID: <20250607110412.2342511-2-adityag@linux.ibm.com>
---
 target/ppc/cpu-models.c | 12 +++++++++++-
 target/ppc/cpu_init.c   |  7 ++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 09f73e23a8..334b1d2ff3 100644
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
index 9e4ea8fd13..3aa3aefc13 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7298,6 +7298,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
     char *name;
@@ -7308,7 +7309,11 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
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
2.43.5


