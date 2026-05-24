Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897DCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8jp-0006cL-0o; Sun, 24 May 2026 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jn-0006bt-Cf
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:27 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wR8jk-0005b0-Mb
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:19:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA956439BB;
 Sun, 24 May 2026 13:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1841F000E9;
 Sun, 24 May 2026 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779628763;
 bh=3hTlR2HXTg4t6KJwyF7+/pZQRaoeKdmU/Dmqul6G4Zc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M9vQl9gwAigHgXnZ/0YuRTVcDUFgiNW0RwKql6u0BhGppuWAuwrMyxpXtlx2SZKit
 fRA9pcAXawHxinJj3XuTpF62S2dnpkxHO0CWH35xeiuO/bWfBfAjPdcuihXYqLRWy1
 bXX8FnZHzTGYGvODc+N1GKdLgqeTCG+jzfIHQDVXKSVlJcNTz9MzbZpV67V5iR4c85
 /7i9xkRFT/fYbR/wgrqTYm2KsdvO+3NmN1lazhFpMjjX3h2goXHqXGWTrUi5o5ZPiO
 cm9aYIMtsXADMntKc+yYfh7pa4Lz84ZKsRn5UWEu4gu+YECq9esc8cjBdDLuqZf8LU
 KEKcO3Y+Caimg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 6/6] linux-user/sh4: add VDSO support for sh4 and sh4eb
Date: Sun, 24 May 2026 15:19:08 +0200
Message-ID: <20260524131909.162990-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524131909.162990-1-deller@kernel.org>
References: <20260524131909.162990-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Provides replacement VDSO with sigreturn trampolines
(__kernel_sigreturn, __kernel_rt_sigreturn) and syscall stubs
(clock_gettime, clock_gettime64, clock_getres, gettimeofday).

Both LE and BE blobs are committed and selected at compile time via
TARGET_BIG_ENDIAN. The BE variant requires an sh4eb-unknown-linux-gnu
toolchain; sh4-unknown-linux-gnu does not support -mb.

CFI register numbers follow GCC's SH_DEBUGGER_REGNO:
PR=17, GBR=18, MACH=20, MACL=21, FPUL=23, FPSCR=24, FR0-15=25-40.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/Makefile.vdso    |  18 ++++
 linux-user/sh4/elfload.c        |  14 ++++
 linux-user/sh4/meson.build      |  12 +++
 linux-user/sh4/target_elf.h     |   1 +
 linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
 linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
 linux-user/sh4/vdso.S           | 142 ++++++++++++++++++++++++++++++++
 linux-user/sh4/vdso.ld          |  67 +++++++++++++++
 9 files changed, 299 insertions(+)
 create mode 100644 linux-user/sh4/Makefile.vdso
 create mode 100644 linux-user/sh4/vdso-asmoffset.h
 create mode 100755 linux-user/sh4/vdso-be.so
 create mode 100755 linux-user/sh4/vdso-le.so
 create mode 100644 linux-user/sh4/vdso.S
 create mode 100644 linux-user/sh4/vdso.ld

diff --git a/linux-user/sh4/Makefile.vdso b/linux-user/sh4/Makefile.vdso
new file mode 100644
index 0000000000..272c5d262d
--- /dev/null
+++ b/linux-user/sh4/Makefile.vdso
@@ -0,0 +1,18 @@
+include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/sh4
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
+
+LDFLAGS = -nostdlib -shared -Wl,-h,linux-gate.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-T,$(SUBDIR)/vdso.ld
+
+$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -ml $<
+
+CC_BE = sh4eb-unknown-linux-gnu-gcc
+
+$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC_BE) -o $@ $(LDFLAGS) $<
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index ddf2aaaed7..f03ce49e7d 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -5,6 +5,20 @@
 #include "loader.h"
 #include "target_elf.h"
 
+#if TARGET_BIG_ENDIAN
+# include "vdso-be.c.inc"
+#else
+# include "vdso-le.c.inc"
+#endif
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags G_GNUC_UNUSED)
+{
+#if TARGET_BIG_ENDIAN
+    return &vdso_be_image_info;
+#else
+    return &vdso_le_image_info;
+#endif
+}
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
diff --git a/linux-user/sh4/meson.build b/linux-user/sh4/meson.build
index 3bc3a6924a..611bce050b 100644
--- a/linux-user/sh4/meson.build
+++ b/linux-user/sh4/meson.build
@@ -3,3 +3,15 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+vdso_le_inc = gen_vdso.process('vdso-le.so',
+                               extra_args: ['-s', '__kernel_sigreturn',
+                                            '-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_le'])
+
+vdso_be_inc = gen_vdso.process('vdso-be.so',
+                               extra_args: ['-s', '__kernel_sigreturn',
+                                            '-r', '__kernel_rt_sigreturn',
+                                            '-p', 'vdso_be'])
+
+linux_user_ss.add(when: 'TARGET_SH4', if_true: [vdso_le_inc, vdso_be_inc])
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index d9e253d425..3fcb63d409 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -15,6 +15,7 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_VDSO_IMAGE_INFO    1
 
 /*
  * See linux kernel: arch/sh/include/asm/elf.h, where
diff --git a/linux-user/sh4/vdso-asmoffset.h b/linux-user/sh4/vdso-asmoffset.h
new file mode 100644
index 0000000000..8ca96dce16
--- /dev/null
+++ b/linux-user/sh4/vdso-asmoffset.h
@@ -0,0 +1,45 @@
+/*
+ * Offsets into target signal frames for sh4 vdso.
+ *
+ * From linux-user/sh4/signal.c:
+ *
+ * struct target_sigcontext {
+ *     target_ulong oldmask;           //   0
+ *     target_ulong sc_gregs[16];      //   4
+ *     target_ulong sc_pc;             //  68
+ *     target_ulong sc_pr;             //  72
+ *     target_ulong sc_sr;             //  76
+ *     target_ulong sc_gbr;            //  80
+ *     target_ulong sc_mach;           //  84
+ *     target_ulong sc_macl;           //  88
+ *     target_ulong sc_fpregs[16];     //  92
+ *     target_ulong sc_xfpregs[16];    // 156
+ *     unsigned int sc_fpscr;          // 220
+ *     unsigned int sc_fpul;           // 224
+ *     unsigned int sc_ownedfp;        // 228
+ * };                                  // sizeof = 232
+ *
+ * struct sigframe    { sigcontext sc; ... }
+ * struct rt_sigframe { siginfo info[128]; ucontext uc; }
+ *   ucontext = { flags[4], link[4], stack[12], sigcontext mcontext; ... }
+ *   => mcontext at rt_sigframe + 128 + 20 = rt_sigframe + 148
+ */
+
+/* Offset of sigcontext within sigframe (CFA base for sigreturn). */
+#define SIGFRAME_SC_OFFSET      0
+
+/* Offset of tuc_mcontext within rt_sigframe (CFA base for rt_sigreturn). */
+#define RT_SIGFRAME_SC_OFFSET   148
+
+/* Offsets within struct sigcontext. */
+#define SC_GREGS    4
+#define SC_PC       68
+#define SC_PR       72
+#define SC_SR       76
+#define SC_GBR      80
+#define SC_MACH     84
+#define SC_MACL     88
+#define SC_FPREGS   92
+#define SC_XFPREGS  156
+#define SC_FPSCR    220
+#define SC_FPUL     224
diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..4f50143f8284ab63693c1117e68f3efa886155e3
GIT binary patch
literal 2704
zcmbtWU1%It6#iy*limF9EvdGq*2LCYiXGAtN{c?YX?`_LB~7TU)#-M3vb#;P6K5xB
zw#GIOA`!t_74e~nVqcZwlY-zw!9PTViVq^<gQ7?u>VqQqGxFWJcQd=mgWwr1Gw0kh
z_vhU6efL}(92+uB167G(4*+fG1ClAJ_n{jN*o_oA05k&ZtF|`)+2Vj~`hO+ypCKC(
zs>cNIN2I+7$R_{K`9D4a#0qPzI*%To@2?_lCm>t2zY{=gczg=;uO6Qtc)0T6H*aRH
ze*EnF`wq3;oCMGg;6k`wv(pX!`3*2f05kyRYPd&(?`8n60cZh`a)aP6AlB;!!QX(~
z$94coHwgY@oZKL|1;o1b&i{v`f%qo?S~mf$0QLg$4<h<)K>S)np911vbG^#H0K~uN
z+LUep@v9O47xdZ$f?w5HXo>MZb(R#KHzlERgXc#dN`rb+=ee`5u_w7Xv64(asBH8}
zT<iJ_h2BdOZSQ^A|I*6mKV4qB^h@dRTU&R1wC8!)_F}H=+Syq*J7eb^-!INN8yXMv
ztuuR0S=-c~?sP6wfo;z?UdfrY%f-Cs_zPZX&E)wJ>uj;Ku(UUy@g1w|TKh0IIzIKN
zz27>(t(i5C5k4JX+`0_N9NVVyNblZ=y|eJU>Z8aw8(p#c0rZCPG9Cah0vOD<Q-HyI
zoCl240G<JiS-@aU6MHbuPrzIjMprALCv95*+~irx8A98A0Dh>mG5+7y**F)mqyJ@&
zbB<#$ms4^Qfs4YpAk3#lY+1yg5)J1?V?`vEMDm<yS`^I-qQw`jWzpt|_9sQhyhyo1
zl*Fc4(K#bFpA}n+;*Nso%8PB&;!a0w&xyOTqWg^K$%wm8iygMu`GmOVak1-^xc4!!
z`=q#iL~I$AJ0WJt1zdM0hT30YLftT~r_h2Xz-Wqmza05)Ui-#4La!zO=WgISWB9g;
zQ@t<_OkB-Z<Rt3MVMay9CRWXLlbE1Ro?&Wmz0?&3B!5s>c#%9pow%W=<b_y>E$Yk%
z>Rc<o3Q8yEP`{#dau4B1{L-Iir`L>lh~HL)e+v6|D9+V-Rh0ihjd>&dKdt9ioHq%z
zU)6tB51{zMuj8lHI=*?mj<4RW<Eu~W_~^SD{>o;(lZQ^^@|KG#dTr0i7u}Lw_A{Qp
z-t3feum?_zr;m&thHVdzPuYVb_RvK7$e=wkFadjb>}Y>_%sx6abZl_ao=o?T4cZZ`
zD+=0}LTdP;o~$ASR6}4JaFyb<b;Ja#T$%GTXJD0mFMJpDSIPAqSh-3mGgr*Yk8))W
zRxaabVC72-Rv}X^gm&KxEsKs<F1n=}#m>QU3ih;@nRDzy&Rf%9`OcEB&-Xt{m%0y#
z6@3?zv$QCTphw*wydU(PPmC)}NI&9=bqDj@3~?v1w-UK?I3BUQU*$ewnp8Qexs0M~
z0CFsGX@)qJSY^$k?=9_j&<z6eHT_0Z4M6^>_v=?S`mL%OfpvivjmL-FAPB<oh<Ay3
zu3L}Cc(EN{t0Bk(k_(7Q#)bVle$#5dW?em`Mf>smxCZ)N37aALN{RMk%|pM&5Py<W
w2DDRTUNx2$)^G;v4c1NMJ&wnHk-PNXI4onrdP0kii>UQWJQv<|Rgr%G0%o^*^#A|>

literal 0
HcmV?d00001

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..c41cb5831b9e5883a64564da8b2149a33e199f4f
GIT binary patch
literal 2704
zcmbtWU1%It6#iy+lk6sGvbUt#nzkl3))MRxODuwYXwv*_N|H*NXw~X;yF1z4{Or`(
z*)$ttn+G2vg0<>HA4C*=@u4O7AU^n35fu@k>XV3|;txJFf<^FW<ePhMGTG!o@EZ;@
z=iHw;=iYO^doT764;Y34jVL;ywQc~(I0C&JZK%NkB+-moAZTMd<#i=7AP_xX<EIz`
zsS6ASA^`pf$%{ZBdi+B_c-edu(4zmN+xh+?BppB?;r12)Q2>LZ6DVKp*z@kSHx|At
z{Wc;deja@L%MW^+09;W1wnTv6|M8tv1gHV996=D{vH{csxB{SoYXRUd-*>vAz~8>_
zFpj+d;sE~ieTQ-1^nIs|KmMQS0q{`_XaukwjW`J4{g8eefR&Iw0pP2c^q2kf0KSb$
z->B2Kw?h422>B<l>T^Fd=ssiOdJ^1kg8RpL7`G0Q>qSu4ZR}sSBi?>A9$%u3eS*FJ
zq;+NNQdhqB^Y^y>`03J1zg(KXyz9+l#pgRe+z-o|%a$A~Gvj2Yt(@(7g;{$`<Kga2
zX4fuhn;Pj%X44f|*0k*w?HQ|7$ho#xc8lvK*9%!^3dQpL!Ccz2&5~o@hvA{oiBr}g
z^KcMtB=i{SxqS1pX6D##l}Ch(-@vW%wJ6&Nz0O8!^uaE*7Do&q1t4VrrvZ!`z&QYC
z4B%M+GX~IM$b2J=g)u}Hh0)sB9OU3m0KY=!2En|%7r^&bwxa;PuCk4*x?x@s%j#_`
zjGaVeF&X?s;G!@th{!V{x+r2#i<$*dTM>2hB7R;Z=0ts2G<c%1B(}Mt=_%2CP9z;6
ziemeWXqgr}ro^s-xFauGb7J?T*kg;mS#f7Zw4D|0X>r#XvCk46Pl~&r5c^Mydma}D
z9uv2x#LgiEHA^m_-@*C~G`+$#HEtxYHz0w8vHtyX=(|4jJqjQZj7Z=-W4n>OepSU-
z4RQz(4R%g)lGK^u2<l(zGTY<QjHs#%@`h}eRY3lbx~v%Th}0$XX<mp1)di48WP2ib
zlkcQX)&X8!)5$)veu=26XN?$EeeNggU!oEFAURj-VX*%Lp?D3f`s5q^f3gVkM90ha
zsn7)E3$Kcwm`7p0d98}C-l^iNkE{6Tn=1Z7CQ~_n|EY(kOb2V#Yq@r=;1sQrmv+6)
zX1kb$)%WOV&&bd*Sk~a^gw>z22F7|u`mI#o7_7nJ6TLmd)`@|Ell|k?cu((ezZI%=
zML}Cr$OgWsCaVwuZ6L5MxJvQbCSrnFs?2)nvoK4ZE8ltjRdhTXX0}pH&lWPlN2xLk
zGn@9(FmuJSnNOGU((bv^GH1J`f>Yd}SXr2M-kNmNv$mDby6YND&z|R&{%5o*PG^ei
zvzX_whEBzHb$&3F^_kBamlYw;7@jqq>Wt-lJa;KesvkLk^O5HcDW2tg%ukBuGJ^dm
zM-<m`KGrFP_Xt%|YyDUUx71nA`lXP6s{8dSTi{<r-Vt~&(4ddRaR9!WkM&NW-+Dfd
zr#yo7I|O-vLSMKpY}e~IxpuB>ybo#Ue%w5H{z%>+cf_?*q4{{{p_vTD`v9d+PZsK@
q=hEOEZp8q2Zz4DIzl@8_rDG$m)B>w|kop%Ps`@=wC(k+!?drcIxqF)c

literal 0
HcmV?d00001

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
new file mode 100644
index 0000000000..4fb5ee9d31
--- /dev/null
+++ b/linux-user/sh4/vdso.S
@@ -0,0 +1,142 @@
+/*
+ * sh4 linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include "vdso-asmoffset.h"
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+/*
+ * SH4 syscall convention:
+ *   Syscall number in r3 (caller-saved, so no save/restore needed)
+ *   Arguments in r4-r7
+ *   Return value in r0
+ *   Syscall instruction: trapa #0x10
+ */
+
+.macro vdso_syscall name, nr
+\name:
+	.cfi_startproc
+	mov.l	1f, r3
+	trapa	#0x10
+	rts
+	nop
+	.align	2
+1:	.long	\nr
+	.cfi_endproc
+endf \name
+.endm
+
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime
+vdso_syscall __vdso_clock_gettime64, __NR_clock_gettime64
+vdso_syscall __vdso_clock_getres, __NR_clock_getres
+vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
+
+/*
+ * Signal return trampolines.
+ *
+ * For sigreturn: r15 points to struct sigframe; sigcontext is at
+ *   offset SIGFRAME_SC_OFFSET (0).
+ * For rt_sigreturn: r15 points to struct rt_sigframe; sigcontext is at
+ *   offset RT_SIGFRAME_SC_OFFSET (148).
+ *
+ * A single CFI region covers both trampolines.  The CFA is set to the
+ * start of the relevant sigcontext; all register offsets are then
+ * identical for both trampolines.  Between the two trampolines we use
+ * .cfi_def_cfa_offset to update the CFA base for the different layout.
+ */
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+	.cfi_startproc simple
+	.cfi_signal_frame
+	.cfi_return_column 16		/* return column is PC */
+
+	/* CFA = r15 + SIGFRAME_SC_OFFSET = r15 (sigcontext base, sigreturn). */
+	.cfi_def_cfa		15, SIGFRAME_SC_OFFSET
+
+	/* Integer registers r0-r15: sc_gregs[n] at sigcontext + SC_GREGS + n*4. */
+	.cfi_offset		0,  SC_GREGS + 0  * 4
+	.cfi_offset		1,  SC_GREGS + 1  * 4
+	.cfi_offset		2,  SC_GREGS + 2  * 4
+	.cfi_offset		3,  SC_GREGS + 3  * 4
+	.cfi_offset		4,  SC_GREGS + 4  * 4
+	.cfi_offset		5,  SC_GREGS + 5  * 4
+	.cfi_offset		6,  SC_GREGS + 6  * 4
+	.cfi_offset		7,  SC_GREGS + 7  * 4
+	.cfi_offset		8,  SC_GREGS + 8  * 4
+	.cfi_offset		9,  SC_GREGS + 9  * 4
+	.cfi_offset		10, SC_GREGS + 10 * 4
+	.cfi_offset		11, SC_GREGS + 11 * 4
+	.cfi_offset		12, SC_GREGS + 12 * 4
+	.cfi_offset		13, SC_GREGS + 13 * 4
+	.cfi_offset		14, SC_GREGS + 14 * 4
+	.cfi_offset		15, SC_GREGS + 15 * 4
+
+	/* PC (return column). */
+	.cfi_offset		16, SC_PC
+
+	/* Control registers. */
+	.cfi_offset		17, SC_PR
+	.cfi_offset		18, SC_GBR
+	.cfi_offset		20, SC_MACH
+	.cfi_offset		21, SC_MACL
+
+	/* FP registers fr0-fr15: sc_fpregs[n] at sigcontext + SC_FPREGS + n*4. */
+	.cfi_offset		25, SC_FPREGS + 0  * 4
+	.cfi_offset		26, SC_FPREGS + 1  * 4
+	.cfi_offset		27, SC_FPREGS + 2  * 4
+	.cfi_offset		28, SC_FPREGS + 3  * 4
+	.cfi_offset		29, SC_FPREGS + 4  * 4
+	.cfi_offset		30, SC_FPREGS + 5  * 4
+	.cfi_offset		31, SC_FPREGS + 6  * 4
+	.cfi_offset		32, SC_FPREGS + 7  * 4
+	.cfi_offset		33, SC_FPREGS + 8  * 4
+	.cfi_offset		34, SC_FPREGS + 9  * 4
+	.cfi_offset		35, SC_FPREGS + 10 * 4
+	.cfi_offset		36, SC_FPREGS + 11 * 4
+	.cfi_offset		37, SC_FPREGS + 12 * 4
+	.cfi_offset		38, SC_FPREGS + 13 * 4
+	.cfi_offset		39, SC_FPREGS + 14 * 4
+	.cfi_offset		40, SC_FPREGS + 15 * 4
+
+	/* FPUL, FPSCR. */
+	.cfi_offset		23, SC_FPUL
+	.cfi_offset		24, SC_FPSCR
+
+	nop
+
+sigreturn_region_start:
+__kernel_sigreturn:
+	mov.l	1f, r3
+	trapa	#0x10
+	.align	2
+1:	.long	__NR_sigreturn
+endf __kernel_sigreturn
+
+	/* Update CFA base for the rt_sigreturn frame layout. */
+	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
+
+__kernel_rt_sigreturn:
+	mov.l	2f, r3
+	trapa	#0x10
+	.align	2
+2:	.long	__NR_rt_sigreturn
+endf __kernel_rt_sigreturn
+sigreturn_region_end:
+
+	.cfi_endproc
diff --git a/linux-user/sh4/vdso.ld b/linux-user/sh4/vdso.ld
new file mode 100644
index 0000000000..3a6cb65d08
--- /dev/null
+++ b/linux-user/sh4/vdso.ld
@@ -0,0 +1,67 @@
+/*
+ * Linker script for linux sh4 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_clock_gettime64;
+		__vdso_clock_getres;
+		__vdso_gettimeofday;
+		__kernel_sigreturn;
+		__kernel_rt_sigreturn;
+	local: *;
+	};
+}
+
+PHDRS {
+	phdr		PT_PHDR		FLAGS(4) PHDRS;
+	load		PT_LOAD		FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
+	dynamic		PT_DYNAMIC	FLAGS(4);
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+	note		PT_NOTE		FLAGS(4);
+}
+
+SECTIONS {
+	. = SIZEOF_HEADERS;
+
+	/*
+	 * The following, including the FILEHDRS and PHDRS, are modified
+	 * when we relocate the binary.  We want them to be initially
+	 * writable for the relocation; we'll force them read-only after.
+	 */
+	.note		: { *(.note*) }		:load :note
+	.dynamic	: { *(.dynamic) }	:load :dynamic
+	.dynsym		: { *(.dynsym) }	:load
+	.data		: {
+		/*
+		 * There ought not be any real read-write data.
+		 * But since we manipulated the segment layout,
+		 * we have to put these sections somewhere.
+		 */
+		*(.data*)
+		*(.sdata*)
+		*(.got.plt) *(.got)
+		*(.gnu.linkonce.d.*)
+		*(.bss*)
+		*(.dynbss*)
+		*(.gnu.linkonce.b.*)
+	}
+
+	.rodata		: { *(.rodata*) }
+	.hash		: { *(.hash) }
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }	:load :eh_frame_hdr
+	.eh_frame	: { *(.eh_frame) }	:load
+
+	.text		: { *(.text*) }		:load
+}
-- 
2.54.0


