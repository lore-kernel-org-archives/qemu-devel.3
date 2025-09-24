Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0C6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnN-0007ub-LK; Wed, 24 Sep 2025 15:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ulu-0006v1-4P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujs-0007mx-4E
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f358c7b8fso1032845b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740469; x=1759345269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=updEquFTYNbXcHlBVDd6fTmOXTS+3MFAS45UOphconU=;
 b=Av5Xg3PphnbOWfKV1RXopwrwzz6aoatRzW/EdByRss3FvPByLo6QQXytfxUswbLQO8
 efA0QuMt3nVJlgJpHXf4RYhf90LpKURGkoONfxyr4JGfYJguRvecB6fSo69jHqjL1hPq
 4YHievs4hiYc7zXGFjf66SIJs5T9Vv033LptmhJi2OEIkGY8QM0H7RaVN2ak+VGE11Kp
 TpXmGEy64Y04KKMKJTu2xOk+IeyDS/J0hakKfHuerEfPWJqhKWRWrL98BBjk0tw8ZXL8
 JzNTXlXk0mpVmh8uMG45pGgVaA9Uk6Lx16sK6eKDpLJ7G+LmJdmZS7QTVlvNlQ1GyLKk
 3/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740469; x=1759345269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=updEquFTYNbXcHlBVDd6fTmOXTS+3MFAS45UOphconU=;
 b=Dk5kQuo1tQnx/1UKE1Pz92hcCuotO8eKYsGOGuGJaxPeUnDPlzTXmCuILs6kkMiKPQ
 FB8T6QwsT6jX0JDfqgL8jK/KkbIWVHF80HBRXhWkfg/MjbK9Qt6TReDP94UT9t+vgdxp
 zGTyjEUaRvfJp6FJ6HnYNdjc4fwdxXJNeSSOoETTzVcKuTu+7j/BIkVW3W4bnVsVvaFA
 +IT1/aAiLnVFKn47GSTSgLanhh1HZzP9eGt2P1s93FeAqZtEpsCPkxzd0IducASltdGC
 GJnWT7XMamaVC/1T5lyIUmxA2TOrGPCZeiFENJEhgTuDV+V+N4qhbYnxNEHzLmwnXWq4
 qXCQ==
X-Gm-Message-State: AOJu0YwGxc3P/VjkrxfWG8eDP1cXD3mjQDhUZM6+6IZFtwLbYivuW1GK
 kBnyayhxK/1xo3veXiXQw2l2C0mX8oKacrraqF/qNcJQyAIFYCX3Rq2MinEFLfpcEStJuHdYrGd
 /kh0p
X-Gm-Gg: ASbGncvUu1AR/FtQh1K4y17vOBzhXnACOUm5jNa37M15HFJwTqQbg24rl41Q+ByH7Wi
 bI9ZDn+XZuEWQGArPFhCWAQWw7A8QjbnCm/M658eoorVBNfJAyehur3T1rH+LlZMN62Q23do0gs
 hZkBsitQJXieekvrwx1gf5uoky7oJWXfdHxrZdsrmtwdGYDc+/Bo9XI8r0CGeVBhb+xND/nOaOU
 kKhf9bAwEV0hlBdsjX0AyZ2cZIb3nqOpy3sPIrGs1dKh1gWoGMs2qJsgTDeIxk8qIhCfZXittUb
 JcmH6NJFWZSXKPbrB7uo7YavOGG+pn/OdD4RARaC4Dnnl37KkmTuweOX9v91wDrFuCP9kbKG4vX
 rGUSY1ws2a8TOUsxikoplAD+tzQWV
X-Google-Smtp-Source: AGHT+IF5gvl0aCvzJf/u3LSvMWgxgK3Goh/PuvMPcYKyarwlCEvcZFl3an7C9bQ6SS8c5dz1zwcRCw==
X-Received: by 2002:a17:90b:1b50:b0:32e:dcc6:cd33 with SMTP id
 98e67ed59e1d1-3342a4b90e0mr567076a91.11.1758740468697; 
 Wed, 24 Sep 2025 12:01:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] linux-user: Populate sigreturn_region_{start,
 end} in all vdso.S
Date: Wed, 24 Sep 2025 12:00:35 -0700
Message-ID: <20250924190106.7089-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark the regions which contain sigreturn syscalls within
each vdso.  Rebuild the shared objects.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/vdso-be.so  | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso-le.so  | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso.S      |   2 ++
 linux-user/arm/vdso-be32.so    | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-be8.so     | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-le.so      | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso.S          |   2 ++
 linux-user/hppa/vdso.S         |   2 ++
 linux-user/hppa/vdso.so        | Bin 2104 -> 2224 bytes
 linux-user/i386/vdso.S         |   2 ++
 linux-user/i386/vdso.so        | Bin 2672 -> 2792 bytes
 linux-user/loongarch64/vdso.S  |   2 ++
 linux-user/loongarch64/vdso.so | Bin 3560 -> 3712 bytes
 linux-user/ppc/vdso-32.so      | Bin 3020 -> 3140 bytes
 linux-user/ppc/vdso-64.so      | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso-64le.so    | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso.S          |   2 ++
 linux-user/riscv/vdso-32.so    | Bin 2980 -> 3124 bytes
 linux-user/riscv/vdso-64.so    | Bin 3944 -> 4104 bytes
 linux-user/riscv/vdso.S        |   2 ++
 linux-user/s390x/vdso.S        |   2 ++
 linux-user/s390x/vdso.so       | Bin 3464 -> 3616 bytes
 22 files changed, 16 insertions(+)

diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index d43c3b19cdf6588757f2039f2308a8bce21aed9c..4089838b30535738e89252a146a039af54ed8be1 100755
GIT binary patch
delta 372
zcmbOs`9pGoKI4y#1`&)RyJD|o>HWC-e5%<G*&9N6e2+fgx7<93@ji>H5Ca1P4-f+Z
z%LfPzCN+U1O#I8_0yb-3J4S~8A0a9j7eHt*=?)~hAbgezB=IPOdS(wK@d81hITIU&
z>uZ5_!>qUgRUiPQCnJf!fr@hg>6J+0JCM}xM-o2)7f(($@JUXqDAdbmP)T7>sbDD1
zOfO0;DJ{y2FG@|%%+HgKFD^+eD!~wsPt8l&T*;oqIB^2Y=Gz=9%$y5=hVlWi_+$<q
Yea;zBE3Qp;;4$aSgYsG?H*iS+0NrRve*gdg

delta 303
zcmew%IYV-SKI4py1`&)RPZQU!U8Q??61%0t;jr&#CkKX#p4vQz@jlDs)ocd7LW~Um
zKQe#;;{pf`CZ&NS7lhAJfh4YnP|xgvB<>;zG-qO?aDAW<0|O6K;|-_+0U(`@B>n~}
z&H<!rk;Hc(sh^A_egZC@oLuf=;8hT&m(QS*!k|*Y5bqM{=jiL{%n%>%?iU*Gy7?J<
qAme6hP8DX(0-!EFAQqjR!K2Ta0X1XQ<OMwDoIu0Dpk?v{E(rh&zBJna

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index aaedc9d85e568d5dadc9c394e9c4459f1f0c8c88..240802821c32943170f7de64f8a0b3ab2a21cd13 100755
GIT binary patch
delta 284
zcmbOs`9pGo2IG&7n(>SxE{t}Xmv61yy2m1;okeN+zms!1<2TP?yu+d>!~g<33?Ep)
z3^<_)X7Mn5nViXHFKGwlF*1Dozkm_00L*Zoe2`6CG72i|!Hg<fF!>{!IA<+TPzY$l
zjmeJe;*)PM2{5jl%*ZUxxPNjWyOdRaibY7VlU_c9N(zHY1w(OWdQoagX;EH$QEGZ-
zeqMZWNn%k6rf_Or%H~S;c*cnnST^6_P+;a=zyz_I4@ikmX64c5oWTwexi<MDlknsM
QW|qkTJPM3?lM8v&0bT`1PXGV_

delta 217
zcmew%IYV-S2IGv4n(>SxrfSl257}AgzHD2Uk@GeFM#i?fJDcY)-eH-%g3Uluh=GBD
zk>TV21&lxj5|Ez!kxg7u4=4hX^<YMl0y14DE3%7A1_D_^3_J`sSRk?jP(|sJFEWWU
z)=p+*7M~oz&M~=zU6{`?vZyG`MK7O0C51tyV)Iq@c*e~ZoC?gm1xyfKd_YQcaw?BD
dX9hb&WYy%4Ou~~3m{}%o;89={ntYK*9RMCZFsuLo

diff --git a/linux-user/aarch64/vdso.S b/linux-user/aarch64/vdso.S
index a0ac1487b0..59dd94dc8f 100644
--- a/linux-user/aarch64/vdso.S
+++ b/linux-user/aarch64/vdso.S
@@ -71,5 +71,7 @@ vdso_syscall __kernel_clock_getres, __NR_clock_getres
 __kernel_rt_sigreturn:
 	/* No BTI C insn here -- we arrive via RET. */
 	mov	x8, #__NR_rt_sigreturn
+sigreturn_region_start:
 	svc	#0
+sigreturn_region_end:
 endf	__kernel_rt_sigreturn
diff --git a/linux-user/arm/vdso-be32.so b/linux-user/arm/vdso-be32.so
index b896d3d545ebf91942038831a9535b023137a86b..6d71cd9c36d185e48810140d6b1b12a1c8f95900 100755
GIT binary patch
delta 322
zcmca1vP5)(GUK0#DhEXNi816dstG5g=$qZlvG_W5!PJ@GH~u)rBFECe00BHeN{xYm
zWdRc3dh#At`FcB`$PbVxBg6lXK*}Acsu4&lFflNIbcHi8FoETPY%U<q0;;?Lq+#kC
zKx_~Ygy`=A>dyyqIfNkk=K=YtKt30gzX`~XM({ltP67o2;R4CYRh3x*p%!}i3@RlI
z#hK|vsU@XFdGST5>6!U?@x>*HMOcJW^HMgKu{APtUH}@z55y9axTIM-fQ);S6}Xf|
O(}1igKnw$nAO-;P2tZ~4

delta 232
zcmZ1?dP8J_GUJAcDhEV9iF@2Qn5bfLZGwFE!TAAV%KxoCZv1hKW%4~%*?J)c28JI%
z%)rR-|09r+W?*1x1kwsj3=BL#TAP7^2`mp}a{;j(P~{CE4O1TiVuOGnM1LGme?E}Q
z0W=t-zX-@r1=3tlejAV<jo`~L%moSr!Ud9(10wR1Epzqq8B|I(A7X1{=G*|3<OgE0
Y$v#}ttQkPorpY;6%8XKzCvb@X036{g_W%F@

diff --git a/linux-user/arm/vdso-be8.so b/linux-user/arm/vdso-be8.so
index 784b7bdb2a9308671bbc4c1e38ab4eac568ea6f7..6446a96fcf63747f1c171a1bc99210d2268d971a 100755
GIT binary patch
delta 322
zcmca1vP5)(GUK0#DhEX5v@5rDpV-zdaE;R<z_ZbM!hvTqH~u)rBFECe00BHeN{xYm
zWdRc3dh#At`FcB`$PbVxBg6lXK*}Acsu4&lFflNIbcHi8FoETPY%U<q0;;?Lq+#kC
zKx_~Ygy`=A>dyyqIfNkk=K=YtKt30gzX`~XM({ltP67o2;R4CYsV*V8W`=tC3@RlI
z#hK|vsU@XFdGST5>6!U?@x>*HMOcJW^HMgKu{APtUH}@z55y9axTIM-fQ);S6}Xf|
O(}1igKnw$nAO-;BYCz-w

delta 232
zcmZ1?dP8J_GUJAcDhEW2jvP6cAn`ta_SEXT7Yg+lW8zuPZ2WPIW%4~%*?J)c28JI%
z%)rR-|09r+W?*1x1kwsj3=BL#TAP7^2`mp}a{;j(P~{CE4O1TiVuOGnM1LGme?E}Q
z0W=t-zX-@r1=3tlejAV<jo`~L%moSr!Ud9(&2t<BJc9J{8B|I(A7X1{=G*|3<OgE0
Y$v#}ttQkPorpY;6%8XKzCvb@X05^>+%m4rY

diff --git a/linux-user/arm/vdso-le.so b/linux-user/arm/vdso-le.so
index 38d3d51047372391b3125c3f9f6ea5401f04bba1..d34e577b69e6cb22a90982570d5e66a1fa22e195 100755
GIT binary patch
delta 309
zcmca1vP5)(0^^^Fiibto-btLS^tfAl`qJz2U8lY?Z_Q&mz46Bp7TE?C1}NZRPy@0S
zAn~my?_`y)w*!j)fU03+`1s!)$ZiCxQUKCS3_J|sK>7z0kN^WNhAbd`gAu|5sc(QV
z!K5IN-vwml1NCzNX(6Egc|bZ9$mfFcHv#Er1mBzCBv2p_A;7?poNQne6;a`(m(QS5
z!cd%<UX)r=T9g-Gl$xHIpBG<Tl30XAI5jV2a~WG5Gv@`M<M@GQN=*LCDb3o!#=vlI
OvMiS}W7=d#E^z=!FhsKe

delta 239
zcmZ1?dP8J_0^^2>iibs{A2M=DJTKY)!fEEqs*sO2HQxVB+W6xL%j7$(GW9|X3=BVj
z7z7v@KK_>m(v2((3<^M+iGhbf8%Y0P0uo@r#b5`dZ!ki5AoU>-CYTfi^5cN4e4u^~
zAT0#cUj(F6fqX6~zYR!7Blz+RbAbYZ2muC$<m61R;M}xKy?h3hlFf(M>X<n<04?MP
fsuP>+$tBI2!N$O_Y4Sua;mI{z0*q3Vd%45`Chsqh

diff --git a/linux-user/arm/vdso.S b/linux-user/arm/vdso.S
index b3bb6491dc..d84d964730 100644
--- a/linux-user/arm/vdso.S
+++ b/linux-user/arm/vdso.S
@@ -140,6 +140,7 @@ SYSCALL __vdso_gettimeofday, __NR_gettimeofday
 
 	.balign	16
 sigreturn_codes:
+sigreturn_region_start:
 	/* [EO]ABI sigreturn */
 	slot	0
 	raw_syscall __NR_sigreturn
@@ -172,3 +173,4 @@ sigreturn_codes:
 
 	.balign	16
 endf sigreturn_codes
+sigreturn_region_end:
diff --git a/linux-user/hppa/vdso.S b/linux-user/hppa/vdso.S
index 5be14d2f70..a6f8da2981 100644
--- a/linux-user/hppa/vdso.S
+++ b/linux-user/hppa/vdso.S
@@ -156,8 +156,10 @@
 __kernel_sigtramp_rt:
 	ldi	0, %r25
 	ldi	__NR_rt_sigreturn, %r20
+sigreturn_region_start:
 	be,l	0x100(%sr2, %r0), %sr0, %r31
 	nop
+sigreturn_region_end:
 
 	.cfi_endproc
 	.size	__kernel_sigtramp_rt, . - __kernel_sigtramp_rt
diff --git a/linux-user/hppa/vdso.so b/linux-user/hppa/vdso.so
index e1ddd70c37e9eb6871c21d538dcce0a1e736a918..68baf80fd3943cc2d847744f13637810788fafc1 100755
GIT binary patch
delta 287
zcmdlXut9Kw5)+%jM3n;~wM-GFSH2~uzvW>xy0IuFLc1|}=f)rNnd=!qfQ8}zM<B(+
zz`#5KEC6ORC<FO3koZt0T)hQQ;0H*M5u)Fbfq@Am1_E3_90Jte0i*?(Am(KPRW1PX
zVd{aF1GRvFAjp8^WN&ASB<~cxe1_u8^rF;~(xSZhqSW-v{Ji+$lEk7COyShLl+6!V
rm>D-eV*Sd<nE*724~Ru4KVX+)V^sh$yC!ici>?APT7Vb^7(omG-<v%*

delta 189
zcmdlWxI<uq5)<o=i7E#~rvH6#AjIVmuSc*(c0!xlbp5Snr5k_DXZHNT00fK-|33mL
zE(QiB3lJX&fNTa?1_tI1AT7Yez`z5fjesf_0BM+d4-gv!1cCZDhqE#>ZjNUA!l<bL
q6ygI5Gcd3KX#pVS1Y%|&h60ucKt}N73JzsaV<4*qDh#3+K?DH%5g+>i

diff --git a/linux-user/i386/vdso.S b/linux-user/i386/vdso.S
index e7a1f333a1..8df77b5a94 100644
--- a/linux-user/i386/vdso.S
+++ b/linux-user/i386/vdso.S
@@ -114,6 +114,7 @@ vdso_syscall3 __vdso_getcpu, __NR_gettimeofday
  */
 	nop
 
+sigreturn_region_start:
 __kernel_sigreturn:
 	popl	%eax	/* pop sig */
 	.cfi_adjust_cfa_offset -4
@@ -128,6 +129,7 @@ __kernel_rt_sigreturn:
 	movl	$__NR_rt_sigreturn, %eax
 	int	$0x80
 endf	__kernel_rt_sigreturn
+sigreturn_region_end:
 
 	.cfi_endproc
 
diff --git a/linux-user/i386/vdso.so b/linux-user/i386/vdso.so
index bdece5dfcf8da036d013262d4e37208350283cfa..e01c3818d0d2e4871cf39b2ddd21043d0695d07e 100755
GIT binary patch
delta 444
zcmew$@<Mci0^@{<iibs3xp}^6>=kzJ5{@jp{@LTJl;I7NjX(ad)H6T<3&Y3%JV5q2
zR+tDkgEEkL4~Y+x0ns4!7C`z3RFIK@iNO)b=3s#eFmN)2z?eW<5U4&5NQVH;V+PVf
z4BQL_3=H)QlYs&vP=OX8y&cFGgYqW<X&3+*FbBxF4wPpH(jWsi0qJ@q{l|d(Y$X0&
zAU_<5{|U$kd5{B0gY>g9x-u{<2MP#41sIZ(!&1}2ybbm88HzL0i&9HUi}K=&Qqwc@
z^Wuw35{pVOg;VoVHXmSXVBBoaah6d_fsuiM7ib#DiJ+hWnal~qAV0$aP*RX_vKg0>
Rgdor<b#QS82B2;*008EUMTY<Y

delta 302
zcmaDM`axuZ0;9x4#ls?<CqE_{P2YA{=Ej`0AMPhV{I5Od%*G#oSn7W;Kma2H69X5J
z$-x2@VBlnsg)xD&Aj8N1>OeY#m4Sg7NDDD=Ggt!Y$w0mcl<y0qw*&cNP<}L!h5?ZN
zR3PU%P@Ww~gY;K3F!(amBN@;Sl*mTnF9Y(!k@&lT{BuA)2h@ObKzcclF979lHfL{O
t+`NP13?t_Qpb#$*Gf(d2l4d)=#=vlkVe&dIC5c%;+v|W5Fu(|9003zeFOUEL

diff --git a/linux-user/loongarch64/vdso.S b/linux-user/loongarch64/vdso.S
index 780a5fda12..2409d95476 100644
--- a/linux-user/loongarch64/vdso.S
+++ b/linux-user/loongarch64/vdso.S
@@ -125,6 +125,8 @@ vdso_syscall __vdso_getcpu, __NR_getcpu
 
 __vdso_rt_sigreturn:
 	li.w	$a7, __NR_rt_sigreturn
+sigreturn_region_start:
 	syscall	0
+sigreturn_region_end:
 	.cfi_endproc
 endf __vdso_rt_sigreturn
diff --git a/linux-user/loongarch64/vdso.so b/linux-user/loongarch64/vdso.so
index 7c2de6c50e706164225e82f652d4becc04c71ff0..3704834f0d5d4439a5f1020e06d9a52c0a740555 100755
GIT binary patch
delta 358
zcmaDM-5@(bgQ<aQqm~_`i0-YcC$ne2ny5DIdBUo>Yp!s=SQWathS7noo`vD#e+D$b
z1LpHE)UcsSC_}{?(8NK)*vzp2iZcSuZ(sy#gcFW1aW;m@x7m3mqroy<3?EqFO2CY~
z$&4K0j4hJ|nZ+4rOfCeH%O*Pl$z78ZIm9K;0o4dG@Gt~GT?2771H<FV6FDTzl9Nr!
zl3X+W^zs>sGt-MwOG=CK;)_z#GxPJ}i%SxVN-%{}^HMgi;Amjntj?v#%-g{PaSR`j
a5}h2%tIf&52@!cWxs%tN@!RBsyy^hfi%Eb0

delta 205
zcmZpWeIY$TgXsn5MlCx=5mA9%)#h=o$th|*U-GxV_f~Om__Vo((Sc2rk>TV221W)H
zz%|*BLtIh?EXKv~fdxg9!F+Nehd86}WI<+e#>B~mKr(-_Bam#Kd=RK>I#96?0}n$0
z8$=fmRP&n2A2}p8J8;%BZa%=Jz|5<`1d-qaQi7A;@@jLg;DCs1pRCAd&Kb`M;k8Uo
H<dFveCI=^o

diff --git a/linux-user/ppc/vdso-32.so b/linux-user/ppc/vdso-32.so
index 0dc55e0dddff618b954dbb939335e99956daf64a..03476052fbeb13b7d54651ff9d2447a07ceca251 100755
GIT binary patch
delta 438
zcmX>jenet|GUJhnDhEWA#S8BnzBO%iakv;8rJgEnt>YiE@dr0sJp%}^F#P`rq<9z@
z*d)LLU^as?kgtQphce;nEr0?)K!S`63`{`Ek%58v4Tui}TtFNG6xIN7fbuLrDhtF0
z0YQj;<qQn<tRM|MLJ$kv85md}Ao1q{9iRf_b3o-c0{I|=VCqi+)t^A(KLE-L0QoFX
z_1}PekcXi98F_)~K@NuMXOw1eVqm=j7f4PvNz3(5E7Z$pD9%hTN-ZfZ%8M^bP0!5F
zi!UxoEGoeiPR&c%e1?5B<K{BXuZ)@xfJX5Fu?P@@+zE0EClE6OF%)nB1DVli@)T|*
SF-|+6SPM)7NCSh3fdK%|KS6c?

delta 281
zcmX>iaYlTCGNaE#l>;J~u3G}Hz1nkb!uCykg)t8^X6|Be-uQ!?t^NlC5HK<@Faaqp
z1_tIgAU+TP*$lEkVGR%mD9-|<j6rM=5M=oO5lA^OFtCEu^9TVkkPZOyA0YA57#P@8
zfP4<9d=-!nG6$x9G6RDb>j@-*l|TgoKt2mp!+s!N0?B}DKnp+)h8ge#$iD*PZ+7Nb
o&A9nJ=NCrK1wb)AAQqVXhFgk_{S1)#domA?5);Sq$p$<k0B1NXbN~PV

diff --git a/linux-user/ppc/vdso-64.so b/linux-user/ppc/vdso-64.so
index ac1ab2582e4675979ffca3ce90dce17df579ab2a..b89f2a0e018a7bb6923db267a746006d341f6bb1 100755
GIT binary patch
delta 436
zcmdlXcR_xFKI4Ur1{RDWTs14(R3|H4uzIPrn<4t+7Q5Ac<(q35C$O`yF#P{Gu~FER
zhk=0sgn@wl1cU~Y%0Ln(egR3G0jAM{k%55;BEi^zq`(o#=7R89ULc8w2tsVEPZU6y
zyaK8KWK$uM_#7nhb|mo@B=NaO;s>DOEI@iQk~qvq96<3?5b;=$QuZw%5(q#R-$2qZ
z0W1m<PfpG*H7QI@*UM)p&P*>#Eh#O^i!Vw|&&<z@FD^+eD!~*^%}d$*gR_}&a}~EL
lGiL|TC_W$-p1gujkBch;YV!NZ5BSWuxZR=LmdOgd5&*x7NI(Dp

delta 307
zcmca0ze8?<KBL7(0}Dox#cn4o*9x#KHrQ%*NT0FR@ARH07dO{1PGC1-WME)o00YJb
z2n{B=fFuY50m};r4JKs;8UBBq*eG1DCBVSI1Cd}~0aXCvTOo<hK@tx@5^q5gPeT$v
z02OBe(ltopC!pdSKzcGnTn!||z6B})vUnkqh6yn7&HY@>jGKjdRG2w6fMR?=%s<(I
YUyqCP2UN+9$rb!&Ok5i#Z{Sw|0MvRWxBvhE

diff --git a/linux-user/ppc/vdso-64le.so b/linux-user/ppc/vdso-64le.so
index 424abb4290b7d3100e9dede2f3059483608ba703..22499d2701530ee2aa003ae5fecce695441a5f77 100755
GIT binary patch
delta 383
zcmdlXcR_xF2IGZ|n)Zw$d#8TmX85vf$%g!(v+1T^wTi0NT-{v5IDx&Mh2i6W1~k9}
z=JPO|U`LfuhKgT669)-nGsglb&d9*T(7*`R2qzrDEG~u@EDV#iIe8^RfP6tL?ns>c
zkx5*#5GX6az{4;HYAeKb3=Hj)6`92)=R#!<KxJ9LW-~Bsp1hG$oblA;gG}O#Hzo%%
zOPD1m8~At`n&j%`GZbg07p0bz7UjhkrKV@*=fxM7Bo>um3a93!Z2rO7z__`bTalT!
kg9&0bACMBByp&IyGlB~u@_zD7K66fYZV0bsvLvrO0GX9Yi2wiq

delta 220
zcmca0ze8?<2BXDBO?yU>es=TCa!<lv%$)wF@KG}h)9a^|6F1i|PGA>hWME=wU}Qi6
zT$39)#U*8dVuB1G|D#9&Ia-rHGKouC0a*eJJPdQ#A@V#>WdV~FnZ+g3pt1*`vMf;9
zn#qD(;*66gA7qlA9KtNRc>-5G<7NRK1!i6iCWsO~AjLn~mS3Cm2PZ^i$K*nObIuK1
L5MImVjlA*zt)(a1

diff --git a/linux-user/ppc/vdso.S b/linux-user/ppc/vdso.S
index 2e79ea9808..e9256a2dea 100644
--- a/linux-user/ppc/vdso.S
+++ b/linux-user/ppc/vdso.S
@@ -220,6 +220,7 @@ endf	__kernel_sync_dicache
 
 	nop
 
+sigreturn_region_start:
 __kernel_sigtramp_rt:
 	raw_syscall __NR_rt_sigreturn
 endf	__kernel_sigtramp_rt
@@ -235,5 +236,6 @@ __kernel_sigtramp32:
 	raw_syscall __NR_sigreturn
 endf	__kernel_sigtramp32
 #endif
+sigreturn_region_end:
 
 	.cfi_endproc
diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
index c2ce2a4757900a16b891bb98f7a027ac30c47a5f..4818a994f0394d83ca5e8213f6e2d2d3ee2f504c 100755
GIT binary patch
delta 447
zcmZ1?zC~h!0#gs?L?tIipNXmSMas5*X}YtK&*i=K5rz{7_FXjfZHe71!C1(`<ITXp
zP?TAmT*koYIC(0oDQA3DZf<FgVS&NqMn=)e4_M#Sdjgd-umTA%;9*Dr(j7>Ah&Y5~
zVfgsJ6v&idgzy=G{5l|W0#rSSKLg00!3>dSVBlg{4P-hnLHHo~gD@!|Ey(b({{I;u
zqXcLG2apzG;9+<Gq<^q5FhoH4Ux0K5P@V_MX98LdaxhH27?2->B(DYJ2O#kol9OHh
zi$k)E^zs>0DvHXCjWUf24C8Z+3Jl^CjV7;TRWyZ%3PW*bdQoagX;EH$QEGZ-eqMZW
zNn%k6rf_Or%H~<@U5uNRIKMG6`b?h4Ej(F=TY&cp(BcO`2k-+OD?ZtiTbgYPI|G9~
P<K!%ECC1N_d%48{U%FzB

delta 322
zcmdlYu|#}=0@ELkiAqk4&J$DTi!jW8dws_KY9IfGb=Q{hIhCuqgj#KuU@T<eabjR#
zD9S8OE@NP{m^_u$bn<0Z(aFzQ-%kF*CQ#20l$2lu5<tMn@bSL{ke<K_=7RY~K;{f)
z2%mw0i@_DhbYMcrN5iCmv>;G_8jvml>gNE`LJT|%RY3X&3j;$0l-~!WGl23u5WYRb
z93Z0sNy7#pKL(+I;Rui)fW&7=PEO1*3&{4=%V$uj*sQ_P#khG3=NCps=gEpZ!jt!K
m3-F!+Dn9`96Uc9(lW%fMv-YqvFx&*o^Y92TrcRdS5eESNR6iB~

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index ae49f5b043b5941b9d304a056c2b50c185f413b0..cc6f7e974be67bd08ed412eccb9af22138385e56 100755
GIT binary patch
delta 453
zcmaDM*P$>$gYm>f&3s0mjWgL9MZUOZ%%7)STEdup@5PH(j}Av>WiW2u!l=l~<ITXp
zP?TAmT*koYIQb!)DQA3DZf<FgVS&NqiA=JaP1sWy<voFF7#MgM&ai<Qa3TTB;+a@4
zI(ZI<2xIBwjU3{VbwEKzhL8Urpedd)`5{ntHB|NhGgvR2I5=65Q=IY4<cZAUj1ML|
za*Ee~0m=yhE!_e&hX<;bi4h_Wa|{PmTns9{0!_UZRD2GaI74!Bl1Xx+VT4{jgGxnF
znVCtZQGsE6u2F$Oe4<go<Zo;Wrtq*}D9%hTN-ZfZ%8M^bP0!5Fi!UxoEGoeiPR&c%
ze2jAu<K{GOC1ysS$(?-Wq6+K~CthHJ(ELD3eDYO3ZLSZT5D|OE$z1$qoci1l?zG9A
Gyz&4^o?@H;

delta 329
zcmeBBcp*1IgHdCmW<I0y<U|hPiEF-ytaVNHbN5=kU~#zA*KgM@2P~MlaogrCjEby0
zP7DkTMVZCPWekiKlOM8~PM*jlx7mh0g>mu)4hczqpe!T9$NxJRfea)dF`1E5T+#?E
z!o{G#iX;VOx=uC(%0>fOf<V2fatsV<lP5BZOI87eg&24kCa^)|d7#SrCQsxPXPh%R
zky)H^!(>BdakV2*m2=QkG9)Kwn!34I1nK27s8noD;abGFnS)1x8RF~7HvB5066_FD
m7cfC+kat8Um-1_K?%;%o+ysTt<URZ<oD;bqBGVuuygUE^OF*#z

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index c37275233a..1d780db771 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -181,7 +181,9 @@ endf __vdso_flush_icache
 	nop
 
 __vdso_rt_sigreturn:
+sigreturn_region_start:
 	raw_syscall __NR_rt_sigreturn
+sigreturn_region_end:
 endf __vdso_rt_sigreturn
 
 	.cfi_endproc
diff --git a/linux-user/s390x/vdso.S b/linux-user/s390x/vdso.S
index 3332492477..c60e9ed086 100644
--- a/linux-user/s390x/vdso.S
+++ b/linux-user/s390x/vdso.S
@@ -52,6 +52,7 @@ vdso_syscall __kernel_getcpu, __NR_getcpu
  * by all users.  Without it we get the fallback signal frame handling.
  */
 
+sigreturn_region_start:
 __kernel_sigreturn:
 	raw_syscall __NR_sigreturn
 endf	__kernel_sigreturn
@@ -59,3 +60,4 @@ endf	__kernel_sigreturn
 __kernel_rt_sigreturn:
 	raw_syscall __NR_rt_sigreturn
 endf	__kernel_rt_sigreturn
+sigreturn_region_end:
diff --git a/linux-user/s390x/vdso.so b/linux-user/s390x/vdso.so
index 64130f6f335269b03291653d006225b365be9cd9..a669a6b7dda7b60bb8aa125bd70c8ed3384da841 100755
GIT binary patch
delta 435
zcmeB>ULZ3;kBLiRqk#pZh})fO-I~!HOHa>f*qfa!daD0cMEm9%#s{n{EDZlYPHYr5
z<zZl80AV0tlY!7+QW;3X#1)Xl8K4^LEf|3&KqMF&kQ6uq*<27l%L^p&5QKVW2PE+<
zA%sORVUR<r5aO&)pb{YQ2@r8TkPw?3RDuaeFGJF>0V*y5r1uCyyqa<np#bhxkj6U*
zan=)1jWP_$$ze`ufq|xa`3%LG=|!m}rA2x1MXBkT`FZihC5c5Pn8K-fDVsewni)5r
m;#6hk>;M|Y2gD+ifAHvYu7Dc+d9neoIp=IBuVr!pw*&xqqDfc)

delta 305
zcmZ1=(;+=UkBPHmqk#pZ$eP<0^W+mAZmVidw^)#U>fWD6>!)n4VSK<^&&crqBLf&P
zHb7`F$ps`q7zkKiKxi;2i%`$(fFy1##K6D<;j_VnWq=H4ggEOHs02tn5-P3>WV6XZ
zC76J8K9YtFP;m($-6{xl=)^{0-AM=qY#@_B0Hkp#LY(ykSd@W5X7hcHX2#9QTq?|*
d8bC2VAQqTBfmff?1FB-r<P*H+j4YG*6acdvD)ayV

-- 
2.43.0


