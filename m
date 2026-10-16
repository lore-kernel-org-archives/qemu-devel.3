Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C2ECCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaN-0007ea-UN; Fri, 16 Oct 2026 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kostas@chatzi.org>) id 1xHdcV-0007b4-1V
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:48:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kostas@chatzi.org>) id 1xHdcR-0001FW-MX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:48:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso25806555e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chatzi.org; s=google; t=1792140528; x=1792745328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1o0gCPAeLV88aY/vi1MiqwUhijzqHBxf1YsMgCHU1g=;
 b=BO1jiwq+Mc7lyTuQZl9EA18auYfLUpPuaeiOAPslM8ln3I2i+LaKyo1IZhs4A08bwQ
 0y52yI+PmYhyEBsbpRPcApiq53m3c4A3mo2+XM4JUgk0FmcPiYkFyg2GskbKpnwsjCEA
 zoded5kfd4ppgB7y1N23WXpALVfqk1zjVyo7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792140528; x=1792745328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1o0gCPAeLV88aY/vi1MiqwUhijzqHBxf1YsMgCHU1g=;
 b=q8in/wntDyVCuHmGkJPr4Z+LZqjiuHopFOXqwdA3Syxv3XN+3xSU2ixanEw1VvZqu1
 gG9g1jXykELOG8Yh2R+jmrOsa5e/2jbtpQShBuyGEzL6s5tuNTquDzk+j0FHNG8lf5Qg
 5tLlD/HKwBrsncVFOp+EqirV1+XcfTaKembMnkCFLkNvDB9yZXyCCmGqxJstvXMtPbop
 jiMz0UTZY5NMNbSdB6pujJ+jH0qRIcRsT22mJABdF7DcDxK5Rmqk4AANrEkOAZktQMIU
 4UlYT/L5yHF9CxBjPBXGrYcy9ni1iMldenqDu1v7N66h3AtbhBjCP5RojUHqPUnbv0Pa
 kPKQ==
X-Gm-Message-State: AFq9FYI4u1ZujqcMBtNe3dvEdQEcEfqKsOAxjnyWkerI1r42IucNrahG
 wgi5eRKFwfuR5gkN1F5hhkJpYV1M3PpZqYg0aa/VrbHTf58VmjME8mk27rMWJ36KK3Mr/soWF3Q
 qNuvB
X-Gm-Gg: AYBFou108gDjUqYrs/0AW1ihZ3e0/OfYeK0DUxu+u4Ic6m8bqfT3NTyNQH2+YEQIzyt
 mofZ91A9CezKvS6dfe+cmRv2OqXeeiIXl1B8luQAf8SW0jKenyNVvZypWX8uz1lhcD83quGXPP2
 NGpgvFXXBgXloA0fKjiktKPeQvFV2ES76Vo9NKPwVIzOdrRxzeFa8/p+VWwUbwOKunhRiHp2MHx
 dbIkWRT2PjVUpaRc/jK2mElNfkO92r+mpG/0qB/Cv/Z115IPUy8fy2Yu744YELyZAG2aJwa/PqD
 UFoGQM6hWk/mye913tObkGEeDidabdnAYXj+Qr813wXBU8oWgyiWj4Qi3I0IFV/mEFiGL6yuPla
 68vmo0V2YkG9I0/81Eb3qZ3Ol/ZiWb4uTn4nYpEDgyyol2lQR0lN2otS06/JiILYs66bBHmOQD4
 ma+NwTZBXcAP92sLHLwc+wqQQ+ez+4SQxY8/BzWJRwyClIoA1WV42Mr2v8lOTPIVS7Uq+om04Kt
 AYH5LktiSRM9laDMvDelBcCBItMHJkaFKwLoMwnh0516EhR626ZfngSL3E+hdwx2iqJZE46Lxca
 jzgJ7hI2DJ2aiJ6Iuh4HW/Gx
X-Received: by 2002:a05:600c:8b09:b0:4a1:6f78:842f with SMTP id
 5b1f17b1804b1-4a18e4987b8mr451888015e9.11.1792140528486; 
 Fri, 16 Oct 2026 01:48:48 -0700 (PDT)
Received: from brie.home.chatzi.org ([88.197.86.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8de7230sm40781015e9.14.2026.10.16.01.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:48:47 -0700 (PDT)
From: Kostas Chatzikokolakis <kostas@chatzi.org>
To: qemu-devel@nongnu.org
Cc: mohamed@unpredictable.fr, pbarbuda@microsoft.com, pbonzini@redhat.com,
 Kostas Chatzikokolakis <kostas@chatzi.org>
Subject: [PATCH] whpx: i386: forward the dynamic EBX of CPUID[0xD] sub-leaves
 0 and 1, not 1 and 2
Date: Fri, 16 Oct 2026 11:48:13 +0300
Message-ID: <20261016084813.755278-1-kostas@chatzi.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kostas@chatzi.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:17 -0400
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

CPUID[0xD,0].EBX is the size of the XSAVE area for the guest's current
XCR0, and CPUID[0xD,1].EBX the size for XCR0 | IA32_XSS: those are the
two values that depend on guest state. For sub-leaf 2 and up, EBX is the
component's offset in the standard format, a constant.

whpx_vcpu_run() forwards Hyper-V's DefaultResultRbx for sub-leaves 1 and
2 instead. Sub-leaf 2 is harmless: QEMU's own offset was read from
Hyper-V at vCPU init. Sub-leaf 0 is not: QEMU computes it from
env->xcr0, which WHPX refreshes only in whpx_get_registers(), never on
a CPUID exit, so after the guest's XSETBV the leaf still reports the
size for the reset XCR0, 576 bytes.

A Linux guest on a host without XSAVES takes that as its kernel XSAVE
size, fails the consistency check against the size it computed from the
component offsets, disables XSAVE and panics on the fallback path:

  XSAVE consistency problem: size 832 != kernel_size 576
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:638 fpu__init_system_xstate
  x86/fpu: XSAVE disabled
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:fpstate_reset+0x1a/0x90
  Kernel panic - not syncing: Attempted to kill the idle task!

Every CPU model with XSAVE is affected there (-cpu max, Haswell,
SandyBridge); models without it (Westmere, Nehalem, qemu64) boot. A host
with XSAVES boots because Linux takes the compacted size from sub-leaf 1,
which is forwarded; sub-leaf 0 is stale there too.

Reproduced on an Intel Core i5-4440 (Haswell) under Windows 11 Home
build 26300 with QEMU 11.1.2 (the code is unchanged on master), guest
Linux 6.18. With this patch the guest enables xstate 0x7 at 832 bytes
and boots with -cpu max. An AMD Ryzen 9 7900X under build 26100, not
affected before, still boots with the patch, enabling 0xe7 (compacted,
2432 bytes).

Fixes: 79b3cb1f0145 ("whpx: i386: introduce proper cpuid support")
Signed-off-by: Kostas Chatzikokolakis <kostas@chatzi.org>
---
 target/i386/whpx/whpx-all.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 113f79af..b51e9dfc 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2618,10 +2618,14 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
-            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            /*
+             * CPUID[0xD,{0,1}].EBX are dynamic: the XSAVE area size for the
+             * guest's current XCR0, resp. XCR0 | IA32_XSS. For sub-leaf >= 2,
+             * EBX is the component's fixed offset, which QEMU already reports.
+             */
             if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
-                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
-                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 0
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 1) {
                     reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                 }
             }
-- 
2.54.0


