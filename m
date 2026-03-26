Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F68910AB82E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uB8-00088I-Pr; Thu, 26 Mar 2026 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uB3-00087L-ML
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:49 -0400
Received: from ci-2002f-snip4-10.eps.apple.com ([57.103.88.190]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uB2-0003ph-06
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 EF6DB1800103; Thu, 26 Mar 2026 23:31:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774567905; x=1777159905;
 bh=9F76Cc23dABknhkRSAI7rbUjPIKVT+f9IPw6XaqJqx4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MbgqTUuFwmpe6R5dxEcaBHfEeDZTuD+AqaTVr80X/BLb6gLzftGBxZ0iwd88lWqrnHaADMyyc6zFGY7ryZIDYmqJb2sk07uYMzDkpStVbbzrnCbEurcHATkzJKjxoBvkFfMChi+EEBXCtBmB+nCMKu4mX64LXKPZ0/jNBqGL+SXyNHBP6aDKsiD/gu9coKIUK51tqGVZHj0ShM+V7xPvAtHikhLY80wtAHgchxeFVHDnYPbotY0POceIZ8BYbVV7kb7h+0qrXV6NrhdSae7lms1kbjOn5ybexCKQYgfwjp1xWjrSGjQGSqqsXqRxhbXvqwHROJvctT6nSp/PWkrk0A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 985011800224; Thu, 26 Mar 2026 23:31:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v5 4/6] target/i386/emulate, whpx, hvf,
 mshv: add read_segment_selector
Date: Fri, 27 Mar 2026 00:31:28 +0100
Message-ID: <20260326233130.59392-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326233130.59392-1-mohamed@unpredictable.fr>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fgbLqZLycrHx6-bghaemGGI_1oidSlaq
X-Authority-Info-Out: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=69c5c1e0
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iZGBPGrxHaysoRuNUwEA:9
X-Proofpoint-ORIG-GUID: fgbLqZLycrHx6-bghaemGGI_1oidSlaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NyBTYWx0ZWRfX3uxqfl7Wgvwl
 AEIQ6I7sqmnPzEDUMKCOy9mNilx5BGkWjHkA26kS59z0lxY+wr3W0V8n6rjEBfyu1b2DkzPJhKC
 A75jUnNk39B52ZzvM5SCqG1CRSv4kGRWdpZNV0WNw4PBgeRvmO9/i0mIAjjhqjR8KAZlSeNZZK2
 wcUSwp6fTCeFHkTLb3yakXqzbl3EI/pFA3syIBQ2y0f+E5mHA11dGYmxrEFJ9V/icok1CwTgdRm
 TRMqXTNUHYgNsU39Dbh8eFlF6G48v9HI+IhU7GfcYfzzxeMyYUE/hv4Lo88atvn8z39mj++WabQ
 +k3mSOLixbDeZlDB7kY8h3w/WNne6tdLCBnzxrHjQ87yvMIRChwOXQL6B9/cGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260167
Received-SPF: pass client-ip=57.103.88.190;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Opens the door to implement SLDT in the instruction emulator.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.h |  1 +
 target/i386/hvf/hvf.c         |  1 +
 target/i386/mshv/mshv-cpu.c   | 11 +++++++++++
 target/i386/whpx/whpx-all.c   | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a8d4c93098..2397c24200 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -28,6 +28,7 @@ struct x86_emul_ops {
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
+    x86_segment_selector (*read_segment_selector)(CPUState *cpu, enum X86Seg seg);
     target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c0d028b147..8fda4429b3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -254,6 +254,7 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
 
 static const struct x86_emul_ops hvf_x86_emul_ops = {
     .read_segment_descriptor = hvf_read_segment_descriptor,
+    .read_segment_selector = vmx_read_segment_selector,
     .handle_io = hvf_handle_io,
     .simulate_rdmsr = hvf_simulate_rdmsr,
     .simulate_wrmsr = hvf_simulate_wrmsr,
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb2..25e0de2eab 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1565,8 +1565,19 @@ static void read_segment_descriptor(CPUState *cpu,
     }
 }
 
+static x86_segment_selector read_segment_selector(CPUState *cpu, enum X86Seg seg_idx)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
+
+    return sel;
+}
+
 static const struct x86_emul_ops mshv_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
+    .read_segment_selector = read_segment_selector
 };
 
 void mshv_init_mmio_emu(void)
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e56ae2b343..9a405118c5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -998,6 +998,15 @@ static void read_segment_descriptor(CPUState *cpu,
     whpx_segment_to_x86_descriptor(cpu, &reg, desc);
 }
 
+static x86_segment_selector read_segment_selector(CPUState *cpu, enum X86Seg seg_idx)
+{
+    WHV_X64_SEGMENT_REGISTER reg;
+    x86_segment_selector sel;
+    whpx_read_segment_descriptor(cpu, &reg, seg_idx);
+    sel.sel = reg.Selector & 0xFFFF;
+    return sel;
+}
+
 static bool is_protected_mode(CPUState *cpu)
 {
     AccelCPUState *vcpu = cpu->accel;
@@ -1049,6 +1058,7 @@ static target_ulong read_cr(CPUState *cpu, int cr)
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
+    .read_segment_selector = read_segment_selector,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
-- 
2.50.1 (Apple Git-155)


