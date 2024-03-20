Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F975C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 01:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rml6v-0001m4-6O; Tue, 19 Mar 2024 21:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1rml6p-0001kU-GE; Tue, 19 Mar 2024 21:51:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bgray@linux.ibm.com>)
 id 1rml6n-0003ZQ-Np; Tue, 19 Mar 2024 21:51:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42K1m1EY000815; Wed, 20 Mar 2024 01:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=arIDBPpYPV6z8dhAwKHfGFKXPQMbpwYcJJrTRca4nSM=;
 b=an5esHVsVotxyGuPHc2EYV9tyvMDMZ+ilZZNSqWZZ71EbjpEhsOkPgf3rQdcyIjdQoio
 lr1dA/yBh4DrYKzSUPkV7WHmfseD1UwHZKto206bYDnskno5RB+OZ1rSYRheQF/VaC7a
 DMg3RkaqsMILt4qH1mByQ9KHcqTJtlltQieKJa1x6Cj3v513Vp69zyCYuH1xVG5YdofS
 uXgVsl3RecKrMQ7iY0Iq+91yPSoi1Sebdux1vcckoO3Vcaks1IA5/AlmEOiTe6DddwhJ
 0eiKNpLgG+2r8UJICZ4i4KfT76m6jJwYY63rnF98L+eucYNeASBrDRiQtBW1nTPMuDwU nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wym3fg6uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:51:11 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K1pBNP006291;
 Wed, 20 Mar 2024 01:51:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wym3fg6u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:51:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42K16Vkn015829; Wed, 20 Mar 2024 01:50:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp503jwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 01:50:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42K1ogNV16253264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 01:50:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AE9520043;
 Wed, 20 Mar 2024 01:50:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BCAE20040;
 Wed, 20 Mar 2024 01:50:41 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 01:50:41 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com
 [9.192.254.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AC48C6033D;
 Wed, 20 Mar 2024 12:50:38 +1100 (AEDT)
From: Benjamin Gray <bgray@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 2/2] target/ppc: Fix GDB register indexing on secondary CPUs
Date: Wed, 20 Mar 2024 12:50:25 +1100
Message-ID: <20240320015025.372056-2-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320015025.372056-1-bgray@linux.ibm.com>
References: <20240320015025.372056-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5aPjemQht95ZJEFYb8dYpyhXUEFBFE0N
X-Proofpoint-GUID: FljCP_p8WGCL-biEScPSa43-Lhvb7PW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200012
Received-SPF: pass client-ip=148.163.156.1; envelope-from=bgray@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The GDB server protocol assigns an arbitrary numbering of the SPRs.
We track this correspondence on each SPR with gdb_id, using it to
resolve any SPR requests GDB makes.

Early on we generate an XML representation of the SPRs to give GDB,
including this numbering. However the XML is cached globally, and we
skip setting the SPR gdb_id values on subsequent threads if we detect
it is cached. This causes QEMU to fail to resolve SPR requests against
secondary CPUs because it cannot find the matching gdb_id value on that
thread's SPRs.

This is a minimal fix to first assign the gdb_id values, then return
early if the XML is cached. Otherwise we generate the XML using the
now already initialised gdb_id values.

Fixes: 1b53948ff8f7 ("target/ppc: Use GDBFeature for dynamic XML")
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 target/ppc/gdbstub.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3f1e61bdb7..3b28d4e21c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -305,14 +305,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
     unsigned int num_regs = 0;
     int i;
 
-    if (pcc->gdb_spr.xml) {
-        return;
-    }
-
-    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
-                             "org.qemu.power.spr", "power-spr.xml",
-                             cs->gdb_num_regs);
-
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
@@ -320,9 +312,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
             continue;
         }
 
-        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
-                                       TARGET_LONG_BITS, num_regs,
-                                       "int", "spr");
         /*
          * GDB identifies registers based on the order they are
          * presented in the XML. These ids will not match QEMU's
@@ -335,6 +324,26 @@ static void gdb_gen_spr_feature(CPUState *cs)
         num_regs++;
     }
 
+    if (pcc->gdb_spr.xml) {
+        return;
+    }
+
+    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
+                             "org.qemu.power.spr", "power-spr.xml",
+                             cs->gdb_num_regs);
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
+                                       TARGET_LONG_BITS, spr->gdb_id,
+                                       "int", "spr");
+    }
+
     gdb_feature_builder_end(&builder);
 }
 #endif
-- 
2.44.0


