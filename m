Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D31C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kT2-0002zz-5l; Thu, 10 Sep 2026 15:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQf-0002Kv-UA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:28 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQH-0004dg-KI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068353; x=1789673153; i=deller@gmx.de;
 bh=RTZKur3+S0/VPn8+xcJ2EVRpK0+XqSA4zDIUuQHBo+o=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VSFehA72PqGja3uYBLi3pgQLV5NFtnx7TH1zXv5ZtGg63xI/Bcw99NB5bGnSHOfK
 pVm8vDsHaj9F21vGCv2VtqWrbQ4RKRDRXxEqBetHeY8DEfx4lVko7tEjlCnx4k3Bq
 69pP/4NWH0uFU8D8IxsRNcmW2ssB5Sjkcs6mBG89a9Yh+EtM+m+AX/ZY7GRhuvSsm
 cjMqWX1H1t7fRvBBfISybdejWU+921yIKCU6T3xM+dB8n0H5pyfGJSZQAgmxzP8L7
 23d0BGdXdgX/6ufOq5pA8qTs8phuTgk2ynvJkpaonqN1ZCd2N1tccxTQJKmDK7VvL
 HCBnzbgl9ndQ6RfEcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1xNVi927c4-00KvEm; Thu, 10
 Sep 2026 21:25:53 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 7/7] linux-user/x86_64: write the floating-point registers to a
 core dump
Date: Thu, 10 Sep 2026 21:25:44 +0200
Message-ID: <20260910192545.768850-8-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:StP4vB5bUSDTCZhn5vTM9KVI/oylCNHf/p2fR4YyTNhHtUStDoI
 GkVlLUx+gNyML6+FIIWPQAujsLtfx8qeYF7PJtNoG18bxLrae/WT4iYcdCg/Klo5KlPlDnB
 K0yxU/arGh+g+T28YqiIRL7dnpdowOgkRqAJE+AAzYGVNOv8+AR0vBEhZUs3UnI+HW/ejMn
 qXEZgyqdJyTfxZ/pVFmVg==
UI-OutboundReport: notjunk:1;M01:P0:86RLEvSe9ig=;1/Qm8SOt0SzdelluIoZvl6Ob3ld
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

A guest core carried only the general-purpose registers, so a debugger
opening one reported the x87 stack and every SSE register as
unavailable.

Implement HAVE_ELF_CORE_FPREGS for x86_64: define target_elf_fpregset_t
to match the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
arch/x86/include/asm/user_64.h, which is the 512 byte FXSAVE image, and
fill it with the existing cpu_x86_fxsave(). As on the signal path, the
helper writes in target byte order, so there is nothing to swap.

QEMU's FXSAVE writes zero for the instruction and operand pointers and
never writes the opcode field, as it does everywhere else, so those
three fields are not recovered from a core.

Checked with gdb on a core from a program that faults with live values
on the x87 stack and in xmm0 and xmm1: "info float" reads back the stack
and the tag word, and the xmm registers and $mxcsr read correctly.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/x86_64/elfload.c    | 11 +++++++++++
 linux-user/x86_64/target_elf.h | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 121a8167ac..4560106faf 100644
=2D-- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -42,6 +42,17 @@ bool init_guest_commpage(void)
     return true;
 }
=20
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUX86State *en=
v)
+{
+    QEMU_BUILD_BUG_ON(sizeof(*r) !=3D sizeof(X86LegacyXSaveArea));
+    /*
+     * The helper stores the image in target byte order.  cpu_x86_fxsave(=
)
+     * folds the softfloat exception flags back into env->mxcsr, so the
+     * const has to go.
+     */
+    cpu_x86_fxsave((CPUX86State *)env, r, sizeof(*r));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->pt.r15 =3D tswapal(env->regs[15]);
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf=
.h
index 840bddf5ec..23f84f6a91 100644
=2D-- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -27,4 +27,24 @@ typedef struct target_elf_gregset_t {
     struct target_user_regs_struct pt;
 } target_elf_gregset_t;
=20
+/*
+ * Matches the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
+ * arch/x86/include/asm/user_64.h, which is the 512 byte FXSAVE image.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint16_t cwd;             /* FPU control word                   */
+    uint16_t swd;             /* FPU status word                    */
+    uint16_t twd;             /* abridged tag word, not the x87 one */
+    uint16_t fop;             /* last instruction opcode            */
+    uint64_t rip;             /* instruction pointer                */
+    uint64_t rdp;             /* data pointer                       */
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint32_t st_space[32];    /*  8 * 16 bytes for st0-st7          */
+    uint32_t xmm_space[64];   /* 16 * 16 bytes for xmm0-xmm15       */
+    uint32_t padding[24];
+} target_elf_fpregset_t;
+
 #endif
=2D-=20
2.55.0


