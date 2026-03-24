Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4103F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53U4-00078V-T2; Tue, 24 Mar 2026 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sz-0005vI-6C
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:56 -0400
Received: from p-east2-cluster2-host1-snip4-8.eps.apple.com ([57.103.78.11]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53St-0005uX-Uv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:46 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 6D409183533B; Tue, 24 Mar 2026 15:14:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365281; x=1776957281;
 bh=eaxFbDbhOhjNq2FXCuR8YCCB4ResW+p9AOTyVZ7pRBM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TZLuxECwUf65dPtY/UeVvllu3dtO6qrTrkXk7jLTXD6jgzVJgHXWBPTS64dqZq1of/0wUjThr/tziRS5Y41233xjDGUTboBdip18yKr5xyYD0uXMXRKklIk0xNS20XSFWQ4gAakNhujppSwjbDOxuLACioI8CMPOFLGancA3sgmwhvTaN/CRt/wsWRSYPrOlqXZQsUDjJ8V6LBfFp8xVtEdG42wD7XK5bMuB2DBl3FqChOUQghz3WW3Co81cV1p6DnP+zMpRDPFLMHQsdSe7pqJrpKRdy3YCLe+9F8vCCr/mNDPd9ywUokTg3ZFRnI69zgtD8LwDkmYunhbts1He+g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 855C418014A9; Tue, 24 Mar 2026 15:13:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 11/12] whpx: i386: fetch segments on-demand
Date: Tue, 24 Mar 2026 16:13:22 +0100
Message-ID: <20260324151323.74473-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=cqWWUl4i c=1 sm=1 tr=0 ts=69c2aa5f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dLhstIsYVbaQZ-P_MTUA:9
X-Proofpoint-GUID: j9m_XXPfehx_MaDjj0qXH28n0o0_zWQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX7JJnZCx+eXMu
 GLHM7KPCjgQk+76KwLp37gpkDjwzdlZYlz2JGqT4L+qwCUwef4TV/3kT9aLmG6b8OlB84PFeIyG
 AJnTNwit9EXS6vpe6L5qy3EBg4GLqlxXkSf6giPKoOQ8Wt48Ysq3gYSPp6/GdvR2jO3UMABSjmX
 uHrn8DPjfHL6pkn8mmfcav5nNFZI14QSgoO4uCsFdMIuvEcw0NDpaBJU0dRSUUMD2CXOuJGvptY
 1Np6GjNS3eBcmeu9J2NKbba664w2WVw8vO/8yqcg2tTVSsZPXgB4ZglPI5usK/ZQ0sydhnd5rC+
 hFpC4sHXKswX87WogTr6WFSss5zRC4AjB8uBr2gTdqqNcvZKzpbGW1AhBDXsZE=
X-Proofpoint-ORIG-GUID: j9m_XXPfehx_MaDjj0qXH28n0o0_zWQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=883 malwarescore=0 adultscore=0 clxscore=1030
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.11;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Instead of save/restore, fetch segments dynamically.

Rely on the fetched state instead of loading from memory.

Or, if available, on the VM exit context.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 71 +++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 71b33a632a..6f23278642 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -868,21 +868,70 @@ static int whpx_handle_portio(CPUState *cpu,
     return 0;
 }
 
+static void whpx_segment_to_x86_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg,
+                                   struct x86_segment_descriptor *desc)
+{
+    uint32_t limit;
+    desc->g = reg->Granularity;
+
+    /*
+     * Hyper-V can return reg->Granularity == 0
+     * with a higher limit than 0xfffff.
+     *
+     * Detect that case and set desc->g
+     * with shifting the limit properly.
+     */
+    if (!desc->g && reg->Limit <= 0xfffff) {
+        limit = reg->Limit;
+    } else {
+        limit = (reg->Limit >> 12);
+        desc->g = 1;
+    }
+
+    x86_set_segment_limit(desc, limit);
+    x86_set_segment_base(desc, reg->Base);
+
+    desc->type = reg->SegmentType;
+    desc->s = reg->NonSystemSegment;
+    desc->dpl = reg->DescriptorPrivilegeLevel;
+    desc->p = reg->Present;
+    desc->avl = reg->Available;
+    desc->l = reg->Long;
+    desc->db = reg->Default;
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


