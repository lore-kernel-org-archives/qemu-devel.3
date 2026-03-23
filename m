Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B279EFC72D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrg-00061z-0L; Mon, 23 Mar 2026 18:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrd-00060j-JS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from qs-2007l-snip4-5.eps.apple.com ([57.103.84.246]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrb-00038h-8s
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 187A11800263; Mon, 23 Mar 2026 22:35:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305310; x=1776897310;
 bh=vl9gr3/Etwc2CL3Gr9sJC1zQGi6Rjmv81TXMHG3rpEg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HcNsL0N7Ocewwcz8ZgBs6Ge6arA5LouepaSITW3BHQdZmnGqnZXZdmZhzzOS/Pqqltr3y9RBmVwILmFWV6P1AHADX0SrYlknpJJOXcVmwKMnG/TQOKW88wpv35dGQ4h3Qz+VI19+B1pJgUatDyhLJwALUlR8nm/LfG6U1JZWHv/lPRK/46U/Cd9GfTm5ktHI88DG9fqqTDLztkA0sfpYRu3igA1GlyQnfAeMwY1uPPMjhIpIptfeVj/bCFh1xbMM8Uj4wWharUdxeyi/JcX2TUCo5NBnLMLackmMZPPwAg5dwwVg4sRA5UBTqByXjlGcyG/AZFPpAFTIsz33mc0Z2w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 D4E9C1800158; Mon, 23 Mar 2026 22:35:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 10/13] target/i386: emulate: segmentation rework
Date: Mon, 23 Mar 2026 23:34:31 +0100
Message-ID: <20260323223434.81780-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX55K1HUAf1m10
 SvEzJEzT4bUQre7SY4FLH96/tJ5jAwzLmP5JPX8WOZ8GktTVzICp9TXWW0qx650NpFDraHk4Dru
 o4buaWVM3f0jCjxiE3nNFVacet7I9yGeVKVPVl3WJU+EenVfwwCtMI8aajO2VI1mxphytT1xZjM
 PPmVZrEQEgRGV0vJrMWGI+/RiJa5bPLgPPwQXsu1ngJ2VCGX0wctnmshOlOSOB0RllDjUiroS1y
 B6Siwb2w0lzTr/Y/H/NCkXLPcBahVoyoBYpv4cigLV8TfSxVWPNizDb5C6ZoyyXvrsFMlGfuBkl
 6Mjx4v2G+geNnFeT2WXIZSWbUFart3kVeE6VSxpCQn1OFThA3T3shNhzwYxeNI=
X-Proofpoint-GUID: AqITrBAtcD1EHZYAnY9mQBi4mRRSIosM
X-Authority-Info-Out: v=2.4 cv=buxBxUai c=1 sm=1 tr=0 ts=69c1c01c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vJJf33RnEMvZLxG4ysEA:9
X-Proofpoint-ORIG-GUID: AqITrBAtcD1EHZYAnY9mQBi4mRRSIosM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0
 mlxlogscore=990 mlxscore=0 suspectscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.84.246;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make accesses to segments all go through read_segment_descriptor
to be able to fetch segment state on-demand.

Switch away from SegmentCache to the x86_segment_descriptor
that is already used by read_segment_descriptor.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_helpers.c | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index c817015ef9..63bae3582f 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -43,49 +43,37 @@ static CpuMode cpu_mode(CPUState *cpu)
     return m;
 }
 
-static bool segment_type_ro(const SegmentCache *seg)
+static bool segment_type_ro(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
     return (type_ & (~RWRX_SEGMENT_TYPE)) == 0;
 }
 
-static bool segment_type_code(const SegmentCache *seg)
+static bool segment_type_code(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
     return (type_ & CODE_SEGMENT_TYPE) != 0;
 }
 
-static bool segment_expands_down(const SegmentCache *seg)
+static bool segment_expands_down(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
 
-    if (segment_type_code(seg)) {
+    if (segment_type_code(desc)) {
         return false;
     }
 
     return (type_ & EXPAND_DOWN_SEGMENT_TYPE) != 0;
 }
 
-static uint32_t segment_limit(const SegmentCache *seg)
+static uint8_t segment_db(const x86_segment_descriptor desc)
 {
-    uint32_t limit = seg->limit;
-    uint32_t granularity = (seg->flags & DESC_G_MASK) != 0;
-
-    if (granularity != 0) {
-        limit = (limit << 12) | 0xFFF;
-    }
-
-    return limit;
+    return desc.db;
 }
 
-static uint8_t segment_db(const SegmentCache *seg)
+static uint32_t segment_max_limit(const x86_segment_descriptor desc)
 {
-    return (seg->flags >> DESC_B_SHIFT) & 1;
-}
-
-static uint32_t segment_max_limit(const SegmentCache *seg)
-{
-    if (segment_db(seg) != 0) {
+    if (segment_db(desc) != 0) {
         return 0xFFFFFFFF;
     }
     return 0xFFFF;
@@ -96,15 +84,15 @@ static int linearize(CPUState *cpu,
                      X86Seg seg_idx)
 {
     enum CpuMode mode;
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    SegmentCache *seg = &env->segs[seg_idx];
-    target_ulong base = seg->base;
+    struct x86_segment_descriptor desc;
+    target_ulong base;
     target_ulong logical_addr_32b;
     uint32_t limit;
     /* TODO: the emulator will not pass us "write" indicator yet */
     bool write = false;
 
+    emul_ops->read_segment_descriptor(cpu, &desc, seg_idx);
+    base = x86_segment_base(&desc);
     mode = cpu_mode(cpu);
 
     switch (mode) {
@@ -116,21 +104,21 @@ static int linearize(CPUState *cpu,
         break;
     case PROTECTED_MODE:
     case REAL_MODE:
-        if (segment_type_ro(seg) && write) {
+        if (segment_type_ro(desc) && write) {
             error_report("Cannot write to read-only segment");
             return -1;
         }
 
         logical_addr_32b = logical_addr & 0xFFFFFFFF;
-        limit = segment_limit(seg);
+        limit = x86_segment_limit(&desc);
 
-        if (segment_expands_down(seg)) {
+        if (segment_expands_down(desc)) {
             if (logical_addr_32b >= limit) {
                 error_report("Address exceeds limit (expands down)");
                 return -1;
             }
 
-            limit = segment_max_limit(seg);
+            limit = segment_max_limit(desc);
         }
 
         if (logical_addr_32b > limit) {
-- 
2.50.1 (Apple Git-155)


