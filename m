Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7F0C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kUB-0003Pq-0Z; Thu, 10 Sep 2026 15:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQy-0002Mp-Fp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:47 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQc-0004e2-PY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068353; x=1789673153; i=deller@gmx.de;
 bh=Ff/kuujdCxaeULvfSpYUXLMMvycEKNujf3jneAJSaqs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HwRiiQo4eJ+4gR8JJnG3UPK5ajqxED+AFqWEL1txEpQiln/ARrmXzunKoMdOnMtx
 T7Uf+hd4jBf/HZ2rIuBtNUUlHgBywlHe1/ZMRdmejlivytjDRAtIT3n2roYq+k+DG
 adyjqnNtlLNsV4OeAW7mXaEMPku5Uatztga4CI5qUyfCd+7jCkMKfCp8UEuJGSUVF
 1bZ3C+DznusG7+vVBhHnlIbs8eeweZHs8kbh25Xtx9wqysb7vcEpXyD6Jch4f6koJ
 b3JYjeJifIwTeu8W9fndyFu4QVIMA2Ov17rDJrUY9wp4qfp30nPGFE802GM0me1tp
 qhjsegc4fCgNKXHfoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1wwFxn33Xr-00D38d; Thu, 10
 Sep 2026 21:25:52 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 6/7] linux-user/i386: write the floating-point registers to a
 core dump
Date: Thu, 10 Sep 2026 21:25:43 +0200
Message-ID: <20260910192545.768850-7-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3j+ix3NyVhkPMHDHlVyGNqJ3Iat/oDmHN7ZgROYvv8YaxjnbsZw
 ck4oaM+0FPTqVsK7/af4+dBZOj1VDuv6lcRKNrF4HJQ58dnijwAHbGhsOv2929Ry8JEFGAb
 nNOzmIInF6FFYh1SynYzdyRKFpZkTYTpn7rW8RlVRxcLh8bk/0qLCqZVRW+YetH9PD10avN
 KpogomzPfg0f8Ph3yk8aw==
UI-OutboundReport: notjunk:1;M01:P0:QTutdPiuaP4=;bAx1cTQbTl5RYYXTCPUTZnFEU6R
 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
 K/oY
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
opening one reported the x87 stack as unavailable.

Implement HAVE_ELF_CORE_FPREGS for i386: define target_elf_fpregset_t to
match the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
arch/x86/include/asm/user_32.h, which is the legacy FSAVE image without
the trailing software status word that FSAVE does not write either.
cpu_x86_fsave_noinit() produces exactly that, already in target byte
order.

The SSE registers are still absent: the kernel dumps those in a separate
NT_PRXFPREG note, which the generic core dump code has no support for.

Checked with gdb on a core from a program that faults with 1.5 and 2.25
live on the x87 stack: "info float" reads both back, along with the tag
word and the instruction and operand pointers.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/i386/elfload.c    |  7 +++++++
 linux-user/i386/target_elf.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 2e10f38a41..3c8a65e35c 100644
=2D-- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -25,6 +25,13 @@ const char *get_elf_platform(CPUState *cs)
     return elf_platform[family - 3];
 }
=20
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUX86State *en=
v)
+{
+    /* The FSAVE image exactly, stored in target byte order. */
+    QEMU_BUILD_BUG_ON(sizeof(*r) !=3D 4 * 7 + 8 * 10);
+    cpu_x86_fsave_noinit((CPUX86State *)env, r, sizeof(*r));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->pt.bx =3D tswapal(env->regs[R_EBX]);
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index eafac8f382..931ea23ffa 100644
=2D-- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -27,6 +27,24 @@ typedef struct target_elf_gregset_t {
     struct target_user_regs_struct pt;
 } target_elf_gregset_t;
=20
+/*
+ * Matches the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
+ * arch/x86/include/asm/user_32.h.  This is the legacy FSAVE image withou=
t
+ * the trailing software status word, which FSAVE does not write either.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint32_t cwd;             /* FPU control word                 */
+    uint32_t swd;             /* FPU status word                  */
+    uint32_t twd;             /* FPU tag word                     */
+    uint32_t fip;             /* FPU IP offset                    */
+    uint32_t fcs;             /* FPU IP selector                  */
+    uint32_t foo;             /* FPU operand pointer offset       */
+    uint32_t fos;             /* FPU operand pointer selector     */
+    uint32_t st_space[20];    /* 8 * 10 bytes for st0-st7         */
+} target_elf_fpregset_t;
+
 /*
  * This is used to ensure we don't load something for the wrong architect=
ure.
  */
=2D-=20
2.55.0


