Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5AFC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2ON-0000NS-GY; Fri, 25 Sep 2026 05:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OL-0000N2-8i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:53 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OJ-0006DJ-Gi
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3FFC6022F;
 Fri, 25 Sep 2026 09:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5941F000FF;
 Fri, 25 Sep 2026 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329129;
 bh=8KJX0LVS8OgRm4BbSc6yg63cQQ7Z2QXdlX7Ny7+uvEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S6a6IK6i1FmNznuLcPObG6FDRnf1fvHWE75W4sg0JRkn0ZJ3PvRUszqIM3SMCmIWh
 FFgGHjy5pCQKkGEz2F9mPPL/H3rFtshIoe42N141sPTT8+8tLSmiwI8sVpvJkIPItz
 UnCS/XQB5wCCbGEjEuNBItoXF0MfcKEO3DsvBxM8aRmx9Cyu3+rsi8UuKsPcUQiyUK
 fsT7VtjFhg8F6xa7Wb6PVC58bN+cZIRHtRI8H3y46bVQtCsAl6TOcTEYi4VDaINez5
 RJsWdDhKbXmoOwafC6CfL+yJTixEE7v4O5s1wERAoJq8D6/Ixt7kT6wASPWGOstFbk
 ar0y1ygk81iyA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 1/8] linux-user/sh4: use the kernel's sigreturn trampoline
 sequence in the vdso
Date: Fri, 25 Sep 2026 11:38:37 +0200
Message-ID: <20260925093844.5685-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

With the vdso, default_sigreturn and default_rt_sigreturn point at
__kernel_sigreturn and __kernel_rt_sigreturn and setup_sigtramp() is no
longer used. The vdso trampolines load the syscall number with mov.l
instead of the kernel's mov.w/trapa/or r0,r0 sequence, which undoes
commit 9ac5aa7227 ("linux-user/sh4: Fix setup_sigtramp to match Linux
kernel trampoline pattern"): libunwind's unw_is_signal_frame() no longer
recognizes the signal frame, so unwinding through a signal handler stops
there.

Use the sequence from the kernel's own vdso,
arch/sh/kernel/vsyscall/vsyscall-sigreturn.S.

Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/vdso-be.so | Bin 2704 -> 2720 bytes
 linux-user/sh4/vdso-le.so | Bin 2704 -> 2720 bytes
 linux-user/sh4/vdso.S     |  26 ++++++++++++++++++--------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index 4f50143f8284ab63693c1117e68f3efa886155e3..bc1fb37e1089b7aa5612da0039e24193b156b3d8 100755
GIT binary patch
delta 194
zcmbOrx<GV-GNZyo6=&8T3=AwkCgxO#v^^7IdSMZuBqF1%9rYmk#g%V{*C+nCEhr$w
zz`(=6z>vYf!19cNfk9yN6UOaK%t{QNljpHmC{1QPETF&*gAC<p{Iv|6lM@-mC;w-8
z!1!(Q1J-<2uo;s>*zEZrCMPE+g;si2C2d~Fmd4B&GMR%*neoSD9WHgo6_Z1_)J119
NFfg<*AOItX2>?A$F(&{3

delta 178
zcmZ1=Ize=TGNZsm6=&8L3=AwUCgxO#6if>*aPh9(e`{gllH+YV4J~=!giQQ#TaZhL
zfq{pCfgyu|f#m@M0|UqACyd*fm_-=eCeLHB5W38GSb%|(fq|j?GQ(j31_p+;lM@-m
zC-bvDV0<z818Y7jSkL4XHhVsZNy*7YQI?S@>6<sQr7<(QOqSqMW_&T(hD)7s#^e+(
Qb<s`+28I>}1YiU)0VjPgU;qFB

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c41cb5831b9e5883a64564da8b2149a33e199f4f..c1ff560cc165413d7b07aa873225bd92afb8569e 100755
GIT binary patch
delta 202
zcmbOrx<GV-0;9r2MQ7F@EDQ`kCT3QP?EQGW?V6EbjpN0Ka-A|h8NXg^nl$mp4M710
z1_mJp9)=7C28L%W3=9IBA2M!dVpC#ZU|{f^Jdedfk#(}bVQvK&EN4LFuVvtzoX99T
z`47tj#&47FvgWgbO_?0XW)C-;AvxK|)6&>Db@M{DWM;;Y$*f$;j6Wu8a;Y<}m>kHZ
RE-{mxfuRLtBNQ+~834g&GJ*gA

delta 184
zcmZ1=Ize=T0;9l0MQ7F*EDQ`UCT3QPl&)2g-L`IF)#Kt%zJj4I-B(^c;xzHc4M8pj
z1_mJp9)=7C28IVL3=ABbA2M!dViRFtU|?{YJdeeKpYgK5VNQl}kicbu!)qreGKx>;
zVST{(V)9$od{(fY$%$<CaFZC4lPkSUBf_#aZ)8hmW^|b>%B9TsVzMQdI^&GViCpRu
Qo$L$@Eg<8dfDy_70CGt$_W%F@

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 4fb5ee9d31..1faa665774 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -43,6 +43,22 @@ vdso_syscall __vdso_clock_gettime64, __NR_clock_gettime64
 vdso_syscall __vdso_clock_getres, __NR_clock_getres
 vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 
+/*
+ * Same instruction sequence as the kernel's
+ * arch/sh/kernel/vsyscall/vsyscall-sigreturn.S. libunwind matches these
+ * bytes to recognize a signal frame.
+ */
+.macro sigreturn_tramp nr
+	mov.w	1f, r3
+	trapa	#0x10
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+	or	r0, r0
+1:	.word	\nr
+.endm
+
 /*
  * Signal return trampolines.
  *
@@ -122,20 +138,14 @@ vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 
 sigreturn_region_start:
 __kernel_sigreturn:
-	mov.l	1f, r3
-	trapa	#0x10
-	.align	2
-1:	.long	__NR_sigreturn
+	sigreturn_tramp __NR_sigreturn
 endf __kernel_sigreturn
 
 	/* Update CFA base for the rt_sigreturn frame layout. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
 
 __kernel_rt_sigreturn:
-	mov.l	2f, r3
-	trapa	#0x10
-	.align	2
-2:	.long	__NR_rt_sigreturn
+	sigreturn_tramp __NR_rt_sigreturn
 endf __kernel_rt_sigreturn
 sigreturn_region_end:
 
-- 
2.54.0


