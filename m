Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A8D58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nre-000618-1V; Mon, 23 Mar 2026 18:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrc-00060N-6U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:12 -0400
Received: from qs-2007i-snip4-1.eps.apple.com ([57.103.84.212]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nra-00038W-Mh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:11 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 9695B180022F; Mon, 23 Mar 2026 22:35:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305310; x=1776897310;
 bh=0vNiIT+PCcYtu/Inl07uABMaMXiwBMmsj+tnEV0u370=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Of9V7HHEXTByEvRSGan41MLQBeajQACUJ4UYnqbCR4YxVMdYNC0Qr6i5cEtXgEiozNEqcdYun305go4A5SWM+NBemM7DszQ/OOFMGY1T3IL7BLqVw8TtlFbrSs06553wW6a/ZzLhYtlBfmNDZtFeggGQyKg20UmAGFM/Fvkn6aamXO/NoRbwkznFqcnoK5J6++t8oAzkmS2BdyUSCT4xOHexc0VbeROvu+h0mrJKM0Q5gr7wRHtAVP4V+/izO8Wy+xGYFsR2kMfI4HqYoZOD3/UyFDJdBa7rgy9KztVkkFPn6y1qluOIJ5BqVeWRke1Ca0o3JLOELGv8L/8MGuGYBQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 9568118000B8; Mon, 23 Mar 2026 22:35:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 11/13] whpx: i386: fetch segments on-demand
Date: Mon, 23 Mar 2026 23:34:32 +0100
Message-ID: <20260323223434.81780-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rBq8JzKerwigtAN5cu_SjMQhIuSXw8P7
X-Proofpoint-ORIG-GUID: rBq8JzKerwigtAN5cu_SjMQhIuSXw8P7
X-Authority-Info-Out: v=2.4 cv=E67AZKdl c=1 sm=1 tr=0 ts=69c1c01b
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-8Qz9FHPj4oKPzLrWQ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX3wZqaP7Yo0Tx
 zsmwFEcn8x3Kiq3j2dOhEWTegIarBN+o9EKV/c9Wy9pnlhE+sYQ4nR9p/PY8myJr9cgWM3kU53q
 zHe1aTwvawptDYEXcJ7eKdSnwsbhh5BezJ69ploEI+T2bul5xPbwZ+hgUOXFonbG/cxWqv4xicy
 mhFk6KSZ0u2OBjLnEYZN/JwjdPTdT5JUsA2RXvRLChtX9i0qnDlkcpMUZVD9GRj26nL03HzzRBC
 T7uefuwOnrSFHf2nha68k8aQUe0Uz0EVHwnKsGTN5QRxyCF/UoPz2HRamG9Dj6+8ooR6nDDdiRi
 QjwR8NV5iOtgSZx99nqhjPcSUvMJl1VKlrWdZ9n13aBrsQA6tph+FN6qfm7Tno=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=856 lowpriorityscore=0 spamscore=0 clxscore=1030
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.84.212;
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

Instead of save/restore, fetch segments dynamically.

Rely on the fetched state instead of loading from memory.

Or, if available, on the VM exit context.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 55 +++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 71b33a632a..f278a52451 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -868,21 +868,54 @@ static int whpx_handle_portio(CPUState *cpu,
     return 0;
 }
 
+static void whpx_segment_to_x86_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg,
+                                   struct x86_segment_descriptor *desc)
+{
+    x86_set_segment_limit(desc, reg->Limit);
+    x86_set_segment_base(desc, reg->Base);
+
+    desc->type = reg->SegmentType;
+    desc->s = reg->NonSystemSegment;
+    desc->dpl = reg->DescriptorPrivilegeLevel;
+    desc->p = reg->Present;
+    desc->avl = reg->Available;
+    desc->l = reg->Long;
+    desc->db = reg->Default;
+    desc->g = reg->Granularity;
+}
+
+static void whpx_read_segment_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg,
+                                    X86Seg seg)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    WHV_REGISTER_NAME reg_name = WHvX64RegisterEs + seg;
+    WHV_REGISTER_VALUE val;
+
+    if (seg == R_CS) {
+        *reg = vcpu->exit_ctx.VpContext.Cs;
+        return;
+    }
+    if (vcpu->exit_ctx.ExitReason == WHvRunVpExitReasonX64IoPortAccess) {
+        if (seg == R_DS) {
+            *reg = vcpu->exit_ctx.IoPortAccess.Ds;
+            return;
+        } else if (seg == R_ES) {
+            *reg = vcpu->exit_ctx.IoPortAccess.Es;
+            return;
+        }
+    }
+
+    whpx_get_reg(cpu, reg_name, &val);
+    *reg = val.Segment;
+}
+
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
 {
-    bool ret;
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    SegmentCache *seg = &env->segs[seg_idx];
-    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
-
-    ret = x86_read_segment_descriptor(cpu, desc, sel);
-    if (ret == false) {
-        error_report("failed to read segment descriptor");
-        abort();
-    }
+    WHV_X64_SEGMENT_REGISTER reg;
+    whpx_read_segment_descriptor(cpu, &reg, seg_idx);
+    whpx_segment_to_x86_descriptor(cpu, &reg, desc);
 }
 
 static bool is_protected_mode(CPUState *cpu)
-- 
2.50.1 (Apple Git-155)


