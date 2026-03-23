Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360BF483E9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5X-0005v4-IZ; Mon, 23 Mar 2026 15:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5R-0005qd-B2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:17 -0400
Received: from p-west3-cluster3-host2-snip4-9.eps.apple.com ([57.103.72.170]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5N-0004Yg-SJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:17 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 12A841800135; Mon, 23 Mar 2026 19:37:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294631; x=1776886631;
 bh=MqpqpdUGs8CctxdR49DovRlSwoA+XzDCB5guol14wf0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bG/beMTvvUWaCmZXxDee1cr6dAhj/9H1sBy+2UQmqyhq3cD/FIWoljLRyMHKuNcrA4pxKvnI1nY0U+9EwRjBaErxjbNhwWy1M6d23F+NWvnxRgxe2dP17jC3D6EWuNG8Pq9qF31inyfeZZU73G/pVjpcWhMjuhG8It0WaZrjWj5JCbbTbPWvTjeyFrZZW4NaJHljQswbQ4ig1HuYIWLttKWSvS2UpDP8u7p+LPkkQKNoVZC9wQPfgmQKXthKcz7+4DCsQryzNc8ffrQCvZuzRiZQDRgWZXziaowsd56ybSTl1Fph+n7hORiT917gnrA3XJac8Cy17L93h9HgX1gnoQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 47EFB18000AC; Mon, 23 Mar 2026 19:37:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 11/12] whpx: i386: fetch segments on-demand
Date: Mon, 23 Mar 2026 20:36:44 +0100
Message-ID: <20260323193645.82602-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX77acICzGfKkV
 fvmFNmS6WwAlUm6fnRIazudPMpeDnkS/l6PFBpywBxABk0+dAVCEirS7Sjrbim9U+drAcBhOVke
 M1RQd3cnWat24/VeySqugeubot5RwRxNgQdoxAC/zp5ZvY+YGVe/NXsT0rRNo7gtNvMyJKVueXc
 glkhmcDMAZE+BvtwBom8GBMWAWZlxPN87Ru46ljVSr+Bb/z7R8srU75NvVbSaEuhkKxFwM9N0Vn
 C5Z7So5H+C6THm2FXpt84THYTnW/UzaleaF7g0L/nm29rNTw1TDe9qQrq43EUfoS5ELXTQfQwIS
 +3wB17k/J67MT8cMh+irJgLLUcWpz3cHsqrGdyqJ70Wpskrusok/iY85BH5C8A=
X-Authority-Info-Out: v=2.4 cv=Os5CCi/t c=1 sm=1 tr=0 ts=69c19666
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-8Qz9FHPj4oKPzLrWQ0A:9
X-Proofpoint-ORIG-GUID: zNwv9ktW4ncmOXClGmXu6-57Mp8Jmg8-
X-Proofpoint-GUID: zNwv9ktW4ncmOXClGmXu6-57Mp8Jmg8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1030 mlxlogscore=858 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.170;
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

Instead of save/restore, fetch segments dynamically.

Rely on the fetched state instead of loading from memory.

Or, if available, on the VM exit context.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 54 +++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 32f01682c1..623bfb0105 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -868,21 +868,53 @@ static int whpx_handle_portio(CPUState *cpu,
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
+static void whpx_read_segment_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg, X86Seg seg)
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


