Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8163C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec5Y-0001du-AR; Tue, 30 Jun 2026 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5U-0001dK-Oj; Tue, 30 Jun 2026 13:17:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5S-0004YD-2o; Tue, 30 Jun 2026 13:17:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIYde2170781; Tue, 30 Jun 2026 17:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lfFBYIHo9TzmqcBS8
 wib4VyBpMm4/gMIItYwcx93teM=; b=TnkGcpfsn22BjeDt/MH4k+f7rPrxmw/Cc
 3c4Daq9rY4N4yILwMbtfy51zQbBHX0Qmzd2H50ozvfdqaGivyDeyhQ+fiVR/oxm0
 btrHh5Lq4hSz4xGE6qIdj5JLxfqwvPqWXusfEl08BFCdyIKxqOpdmjqgPH6UjnwI
 QvJQ8ReIsdCokLPItpPRy2sGLGcy8O06KTgFjIWTSLCjJpL+GXBI6h3KN0oBZnes
 xsaMFPJy6w0z1gVK/bdY1JpI83lLWMCXN8Oief8kCnNCdQsg0+sq4lJMhMHH3M/W
 EHfWDhXQjRGgDnWi35QZtd5oqL4k6qWXoNNHV/5sQ/tFNy1NF7PuQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26reytwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UH4a7H020802;
 Tue, 30 Jun 2026 17:17:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w3fry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UHHIEg49480000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 17:17:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53BCE20043;
 Tue, 30 Jun 2026 17:17:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 655F420040;
 Tue, 30 Jun 2026 17:17:12 +0000 (GMT)
Received: from shivang.com (unknown [9.39.22.216])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 17:17:12 +0000 (GMT)
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
Subject: [RFC PATCH 1/2] accel/tcg: use GTree for faster breakpoint lookups
Date: Tue, 30 Jun 2026 22:45:54 +0530
Message-ID: <20260630171555.114844-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630171555.114844-1-shivangu@linux.ibm.com>
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a43fa23 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=iDKDPV86eBtUCdapeCAA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: yD-VwyoDOgfbU44FLfhL1LftlD5sEPiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXxs3pA6vz9GT6
 QiUwyzriGGS0LKmyyEhgo+G2t80WthyGVInduYxirD9RFJUfMUiv1yY2n0y35tKIdWloQZcGgM5
 WCGLe7bb5PciFx1qj1Vnjuf2ukewYP+zKV2UpXNMDd0mSWEXqHIbjp5sakkTnCKQbltNDh2A/V0
 DBs1efF9UwShf23jd8cKRpkYiIfIaSRMUe7+ID9y3YiIWK54jOh4MDxyIke4kUQ7EagfaTdKXvD
 WBh0YPss6Sy6RkwbTNjUK4CGD82Ek1D98EkaaCshJR6d1KLfdOGSEn2exkLNBsOsyLxNDRODxZs
 4FQKtACLNhB4ZM7wlMWtd84vDob8BWadj1D6PoQngq67KCy4jIIJ216ihm44ih5D5Ggc8EXz6Hi
 v3U7SXll0Gl8wZGaeKj1G5F+CpHRJYcvUtbSj0C79lRXks90u0vZq8OkDNQQx0H/jHKkQV+OrWq
 8FTdS0elbix3px9VwBg==
X-Proofpoint-GUID: SROVQ4IAHspX2RkvYZabgVOBfNiJ4us6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXyT7W4ikcdXvE
 xBKbK6jGkkZIGNVhLqtcu4sw99eMRbHnkA1+mK+zBDEJXpBcNNn3MH4wvmG7jyXQHLua/0z7k0m
 HeCz5qAWVxWGGARwdj/cugnqDcUL8qY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160
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

check_for_breakpoints_slow() currently performs a linear scan of
cpu->breakpoints on every breakpoint check. As the number of
breakpoints grows, this increases the cost of each lookup.

Replace cpu->breakpoints with a GTree to provide efficient lookups by
address.

Additionally, maintain a second GTree, cpu->page_breakpoints, containing
the guest page numbers of all installed breakpoints. This detaches, pc
lookup and page lookup, into 2 different Gtrees.

Both trees are kept in sync when breakpoints are inserted or removed.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 accel/tcg/cpu-exec.c      |  26 +++++----
 cpu-common.c              | 108 +++++++++++++++++++++++++++++++-------
 hw/core/cpu-common.c      |   1 -
 include/exec/breakpoint.h |   1 -
 include/hw/core/cpu.h     |  14 ++---
 linux-user/main.c         |  13 +++--
 6 files changed, 118 insertions(+), 45 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9c754b0365..008919a108 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -296,8 +296,14 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
 static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
                                        uint32_t *cflags)
 {
-    CPUBreakpoint *bp;
+    /* GTree key for cpu->breakpoints
+     */
+    CPUBreakpoint key = {
+        .pc = pc,
+        .flags = 0, /* not required */
+    };
     bool match_page = false;
+    uint64_t pb;
 
     /*
      * Singlestep overrides breakpoints.
@@ -312,12 +318,8 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
         return false;
     }
 
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        /*
-         * If we have an exact pc match, trigger the breakpoint.
-         * Otherwise, note matches within the page.
-         */
-        if (pc == bp->pc) {
+    CPUBreakpoint *bp = g_tree_lookup(cpu->breakpoints, &key);
+    if (bp) {
             bool match_bp = false;
 
             if (bp->flags & BP_GDB) {
@@ -336,9 +338,11 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
                 cpu->exception_index = EXCP_DEBUG;
                 return true;
             }
-        } else if (((pc ^ bp->pc) & TARGET_PAGE_MASK) == 0) {
-            match_page = true;
-        }
+    }
+
+    pb = pc & TARGET_PAGE_MASK;
+    if (g_tree_lookup(cpu->page_breakpoints, &pb)) {
+        match_page = true;
     }
 
     /*
@@ -362,7 +366,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
 static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
                                          uint32_t *cflags)
 {
-    return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
+    return cpu->breakpoints && g_tree_nnodes(cpu->breakpoints) &&
         check_for_breakpoints_slow(cpu, pc, cflags);
 }
 
diff --git a/cpu-common.c b/cpu-common.c
index 988d057d84..1488d63921 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
+#include "exec/target_page.h"
 
 QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -388,28 +389,77 @@ void process_queued_cpu_work(CPUState *cpu)
     qemu_cond_broadcast(&qemu_work_cond);
 }
 
+/* Comparator for breakpoints, used by cpu->breakpoints.
+ * we just care for order of pc's. flags values
+ * are unused.
+ */
+static gint compare_breakpoints(gconstpointer _a,
+                                gconstpointer _b,
+                                gpointer user_data)
+{
+    CPUBreakpoint a = *(const CPUBreakpoint*)_a;
+    CPUBreakpoint b = *(const CPUBreakpoint*)_b;
+
+    if (a.pc < b.pc) {
+        return -1;
+    } else if (a.pc > b.pc) {
+        return 1;
+    }
+    return 0;
+}
+
+/* Comparator for page numbers, used by cpu->page_breakpoints.
+ */
+static gint compare_page_breakpoints(gconstpointer _a,
+                                     gconstpointer _b,
+                                     gpointer user_data)
+{
+    uint64_t a = *(const uint64_t*)_a;
+    uint64_t b = *(const uint64_t*)_b;
+
+    if (a < b) {
+        return -1;
+    } else if (a > b) {
+        return 1;
+    }
+    return 0;
+}
+
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
 {
     CPUBreakpoint *bp;
+    uint64_t *pbp;
 
     if (cpu->cc->gdb_adjust_breakpoint) {
         pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
     bp = g_malloc(sizeof(*bp));
+    pbp = g_malloc(sizeof(*pbp));
 
     bp->pc = pc;
     bp->flags = flags;
-
-    /* keep all GDB-injected breakpoints in front */
-    if (flags & BP_GDB) {
-        QTAILQ_INSERT_HEAD(&cpu->breakpoints, bp, entry);
-    } else {
-        QTAILQ_INSERT_TAIL(&cpu->breakpoints, bp, entry);
+    *pbp = pc & TARGET_PAGE_MASK;
+
+    if (!cpu->breakpoints) {
+        /*
+         * Inserting same value as the key, and the value.
+         * freeing only value removal from tree.
+         */
+        cpu->breakpoints = g_tree_new_full(compare_breakpoints, NULL, g_free, NULL);
+        cpu->page_breakpoints = g_tree_new_full(compare_page_breakpoints, NULL, g_free, NULL);
     }
 
+    /*
+     * For each breakpoint, we insert the breakpoint as well as
+     * its page number. Duplicate pages are fine, as we remove one
+     * page per each match.
+     */
+    g_tree_insert(cpu->breakpoints, bp, bp);
+    g_tree_insert(cpu->page_breakpoints, pbp, pbp);
+
     if (breakpoint) {
         *breakpoint = bp;
     }
@@ -421,38 +471,56 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 /* Remove a specific breakpoint.  */
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
 {
-    CPUBreakpoint *bp;
+    /* Keys for GTree lookup */
+    CPUBreakpoint bp_key = {.pc = pc}, *bp;
+    uint64_t pbp_key = pc & TARGET_PAGE_MASK, *pbp;
 
     if (cpu->cc->gdb_adjust_breakpoint) {
         pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        if (bp->pc == pc && bp->flags == flags) {
-            cpu_breakpoint_remove_by_ref(cpu, bp);
-            return 0;
-        }
+    if (cpu->breakpoints) {
+        bp = g_tree_lookup(cpu->breakpoints, &bp_key);
+        if (bp) {
+            g_tree_remove(cpu->breakpoints, bp);
+            pbp = g_tree_lookup(cpu->page_breakpoints, &pbp_key);
+            if (pbp)
+                g_tree_remove(cpu->page_breakpoints, pbp);
+            else {
+
+                /* because we added one page number per breakpoint
+                 * we shouldn't end up with a case where we dont
+                 * find the same page number in page_breakpoints.
+                 */
+
+                g_assert_not_reached();
+            }
+        } 
+        return 0;
     }
+
     return -ENOENT;
 }
 
 /* Remove a specific breakpoint by reference.  */
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
 {
-    QTAILQ_REMOVE(&cpu->breakpoints, bp, entry);
+    uint64_t pbp = bp->pc & TARGET_PAGE_MASK;
 
     trace_breakpoint_remove(cpu->cpu_index, bp->pc, bp->flags);
-    g_free(bp);
+
+    if(cpu->breakpoints) {
+        g_tree_remove(cpu->breakpoints, g_tree_lookup(cpu->breakpoints, &bp));
+        g_tree_remove(cpu->page_breakpoints, g_tree_lookup(cpu->page_breakpoints, &pbp));
+    }
+
 }
 
 /* Remove all matching breakpoints. */
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
 {
-    CPUBreakpoint *bp, *next;
-
-    QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
-        if (bp->flags & mask) {
-            cpu_breakpoint_remove_by_ref(cpu, bp);
-        }
+    if (cpu->breakpoints) {
+        g_tree_destroy(cpu->breakpoints);
+        g_tree_destroy(cpu->page_breakpoints);
     }
 }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f8..5c2d7ed42c 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -322,7 +322,6 @@ static void cpu_common_initfn(Object *obj)
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
     QSIMPLEQ_INIT(&cpu->work_list);
-    QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
     cpu_exec_initfn(cpu);
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d..f6a6826d05 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -15,7 +15,6 @@
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
 typedef struct CPUWatchpoint {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 59d601465b..be4d502621 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -526,7 +526,8 @@ struct CPUState {
     QTAILQ_ENTRY(CPUState) node;
 
     /* ice debug support */
-    QTAILQ_HEAD(, CPUBreakpoint) breakpoints;
+    GTree *breakpoints;
+    GTree *page_breakpoints;
 
     QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
     CPUWatchpoint *watchpoint_hit;
@@ -1161,13 +1162,12 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
 /* Return true if PC matches an installed breakpoint.  */
 static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
 {
-    CPUBreakpoint *bp;
+    CPUBreakpoint bp = {.pc = pc};
 
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
+    if (cpu->breakpoints) {
+        CPUBreakpoint *a = g_tree_lookup(cpu->breakpoints, &bp);
+        if (a && (a->flags & mask)) {
+            return true;
         }
     }
     return false;
diff --git a/linux-user/main.c b/linux-user/main.c
index c08c73fd80..6f8016d20b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -234,12 +234,18 @@ void init_task_state(TaskState *ts)
     ts->sys_dispatch_len = -1;
 }
 
+static gboolean cpu_copy_breakpoint(gpointer key, gpointer value, gpointer cpustate) {
+    CPUState *newcpu = (CPUState*)cpustate;
+    CPUBreakpoint* bp = (CPUBreakpoint*)value;
+    cpu_breakpoint_insert(newcpu, bp->pc, bp->flags, NULL);
+    return true;
+}
+
 CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
     CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = cpu_env(new_cpu);
-    CPUBreakpoint *bp;
 
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
@@ -258,10 +264,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
     /* Clone all break/watchpoints.
        Note: Once we support ptrace with hw-debug register access, make sure
        BP_CPU break/watchpoints are handled correctly on clone. */
-    QTAILQ_INIT(&new_cpu->breakpoints);
-    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
-    }
+    g_tree_foreach(cpu->breakpoints, cpu_copy_breakpoint, new_cpu);
 
     return new_env;
 }
-- 
2.54.0


