Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A6CC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec5c-0001f4-Lm; Tue, 30 Jun 2026 13:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5a-0001eX-GR; Tue, 30 Jun 2026 13:17:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5Y-0004bf-RG; Tue, 30 Jun 2026 13:17:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIebM2171842; Tue, 30 Jun 2026 17:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1rmn527b6e8Tjf3Ey
 RjfOKn7w7BJDC1lA+U+oMyVsFE=; b=sNSsk5ThQCMXjXpBFNwmPsmpMYv+Ob6Kb
 I4u0bD91KwJy/sCRtc2ounT8014lYPRv2/esI9Bls9BqSDVuwVpbx7fSgSvkGMT/
 DoD1r75hERyK8wCx2AQjgxIRnMdYFGhWPDJ9+HUo3IH0Ylbyk6S0sF+4OsQegPKc
 QB/aHg8DxXmon/7Zl2ot8ZlXX9bLqiQxAV9JT23F4eulZ2XVqpAXgsEpaSnYS34B
 z+X13R3XoIvoM0BFUjZSdCxbhufEfN5ZZ6jkq9aCN4UW1uog95nmV0pVQADzmUBL
 4ZCqEhJasZKBqrYssKVP8sssjk+zhykCt9EpKeyHQX9zHFwSH86Ug==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9yvpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UH4dSZ008058;
 Tue, 30 Jun 2026 17:17:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqbjum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UHHOY947120800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 17:17:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FCAE2004B;
 Tue, 30 Jun 2026 17:17:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8BD220040;
 Tue, 30 Jun 2026 17:17:18 +0000 (GMT)
Received: from shivang.com (unknown [9.39.22.216])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 17:17:18 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [RFC PATCH 2/2] riscv/debug: migrate debug_check_breakpoint to use
 GTree breakpoints
Date: Tue, 30 Jun 2026 22:45:55 +0530
Message-ID: <20260630171555.114844-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630171555.114844-1-shivangu@linux.ibm.com>
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX1Je4GLXrNvY8
 uKs1iZdOkJoS28EDC7LQcFIAlVaPp7ZqyhMIN1Tq47WyqrIGYFLQIKXFFKBBgLodWdet/IEdjDo
 CWbN1y5TRt5jAMjaYbyBW4ebn22x8uaYAkYA4FZJpl4E9Ls9CPrW+A58L5JJd3EwoE4yVqftWT0
 Gn6fp5byD4ti4mIH7oI8WzJFrLHxLfu3TOtOmFVXunLZozf29kBxCAE6bVuSn+z61FR4M2MT+el
 VpRh41WZBK5pOUAipx7yYs8JqVxJDlefkrs+35MGd2PwjHabSfNdfVWoSUFfLDXYZkopXFRk2eZ
 z5U2zGLxaIOnIZeArZx+eKraQtXw5YRXmZXGjNLEmgdaAs9fuip1TfqMlGilC5pNT9VElY6JboZ
 VBHR8032PjqmrsMcr1joMXuhN7aRfqyLBJRkHytfXeZPT8plfnK+QKwOsTO4wL0q4ZssPxNC4Ok
 iJoD5q0rr1IEEpKsYVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX2P9IIedbmubn
 edKylFQFnTgc57v3mgHo06jVVWVC8/t0HxZ5p4FKGJwC3bWYWt3lvXi/RLFORy3xYzkZ9T93zNY
 fSvT4u3Rokm2ASoo/0/h6Hq8yzh8IYg=
X-Proofpoint-GUID: WS07LyX1sXXQvvVAHWNe8t6Sqi-e47HY
X-Proofpoint-ORIG-GUID: 7vcSwfmW4PMCAyjLI47cmqnnk05oRqxG
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43fa29 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=G2-L6CbUqf7O2AX1nyAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300160
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

as cpu->breakpoints is migrated to GTree, change the breakpoint
looping from QTAILQ_FOREACH to g_tree_foreach.
---
 target/riscv/debug.c | 71 +++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 30d39ee5cd..6b2ffd08db 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -939,53 +939,64 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     }
 }
 
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
+static bool bp_found;
+
+static gboolean check_breakpoints(gpointer key, gpointer value, gpointer cpu_state)
 {
+    CPUState *cs = (CPUState*)cpu_state;
+    CPUBreakpoint *bp = (CPUBreakpoint*)value;
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    CPUBreakpoint *bp;
+    int trigger_type;
     target_ulong ctrl;
     target_ulong pc;
-    int trigger_type;
     int i;
 
-    QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-            trigger_type = get_trigger_type(env, i);
+    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        trigger_type = get_trigger_type(env, i);
+
+        if (!trigger_common_match(env, trigger_type, i)) {
+            continue;
+        }
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            ctrl = env->tdata1[i];
+            pc = env->tdata2[i];
 
-            if (!trigger_common_match(env, trigger_type, i)) {
-                continue;
+            if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
+                env->badaddr = pc;
+                bp_found = true;
+                return true;
             }
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            ctrl = env->tdata1[i];
+            pc = env->tdata2[i];
 
-            switch (trigger_type) {
-            case TRIGGER_TYPE_AD_MATCH:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            default:
-                /* other trigger types are not supported or irrelevant */
-                break;
+            if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
+                env->badaddr = pc;
+                bp_found = true;
+                return true;
             }
+            break;
+        default:
+            /* other trigger types are not supported or irrelevant */
+            break;
         }
     }
 
     return false;
 }
 
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
+{
+    bp_found = false;
+    g_tree_foreach(cs->breakpoints, check_breakpoints, cs);
+
+    return bp_found;
+}
+
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-- 
2.54.0


