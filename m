Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C4F483E9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5S-0005rZ-Iw; Mon, 23 Mar 2026 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5O-0005oZ-5N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:15 -0400
Received: from p-west3-cluster3-host5-snip4-9.eps.apple.com ([57.103.72.140]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5L-0004YZ-LF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:13 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 75FE51800136; Mon, 23 Mar 2026 19:37:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294629; x=1776886629;
 bh=9Dqqk2yZAyABYphmGizHsmJzmxD2S1tNqnW1N8M6Mt4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Bm3UDZ3yk+Jxzn/NtExzJZhbkASHtNdgt5eir0/IehTNmdKZs+D3AEcxTNQaL0L+P48NuFl3AoDpri7ZvWCLZHkK5B4RfMgsKr/7FCl5XoQkeho6nF583lbD99rDNeRT2CWJaPkXywtQPVmpYDiGVVd26sjXaht/WQNnE0ndxF3erGRB82OzRoW4UH14CH6vTCZR/VzBq3KJeWReLnP7EvDBjNjV+kYoppNBTdGqe4Ni+f6CzyC3km/E/if1Xk4j8/1+7igr87kubIEF63Yre6RfXXyLXBqIOr2v0i10/UKZ1SI1LRuqhUUzkEdgrLVCm0CmbD5uvO48f7xdGXdnHg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 A81BA1800263; Mon, 23 Mar 2026 19:37:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 10/12] target/i386: emulate: segmentation rework
Date: Mon, 23 Mar 2026 20:36:43 +0100
Message-ID: <20260323193645.82602-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfXyYD1V9V6sn2R
 nrh67Cjq1RwqxboOWS7/IIRVuEaDUYc1LvzpcshsZm+5bO8Dcgic3Ci4S4gl1ML85lHA3QjcEw3
 0mZZ0CZUnadtSPRCnnIFcxZwZB4+oK6Dqm58VaGK8cS4s+e/H7drYWaSWKSIRMRZkNtKTgzO2XO
 BNhhHm7wUJOqdZpLiDf3gucw/HAsDQfyD/ZyvFF+DJdxxoRn0FOxF49cw0fOKDXKZptng+tfKcq
 yT2LIER8aVOcszp7mjUkU0At1nqyzQX2x9ePyPA3j95G9RnjqV2lG8UvkgD6SS+ix/qQG8mF9Fk
 J64/RpxE4vuWAy7u+z1DjN9oRI7bigygaN1tDR9VJHdSK32KgHOKzgtxCSr8h0=
X-Authority-Info-Out: v=2.4 cv=UZNciaSN c=1 sm=1 tr=0 ts=69c19664
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vJJf33RnEMvZLxG4ysEA:9
X-Proofpoint-ORIG-GUID: NopjLp_i2B5kAniknWkm0WSc8CctfmRi
X-Proofpoint-GUID: NopjLp_i2B5kAniknWkm0WSc8CctfmRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 clxscore=1030 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=991 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.140;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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
index 336862e2c4..d594af539b 100644
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


