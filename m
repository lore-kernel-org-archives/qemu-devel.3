Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46C9C98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Bv4-00032o-Le; Tue, 22 Sep 2026 21:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv2-00032I-Vc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:08 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv1-0003Bk-C1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:08 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43f9b11bso6464667b3.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790127426; x=1790732226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0W1rX6+rVhskPD49NMEDAzcroKEx61UOK5zJqNqWu3Y=;
 b=f7gt+/qpBTTRjPoJ+k+vIAunxpz7TrFsZUalE4wQAQdSKbBl61qdjRlXTkLPGA2yzJ
 mWe8AMqBO7V6Mc5JBxpn+BNO9CnANxL6UqjRcMxYmxfthF6qUEvwN4NEYubI04N96G6H
 11zspDTPMdsbWYzsApptTc51oXh3S0y/74v4NzzelfglWigVUAPNiZGsuWtCnVIf5MKa
 FrPOWB+2WBa51hODfkqSRBgpdaQlSVqgvL/iexRSp6K1Eg6M8WAk+JLTNdHRywy7/hyU
 hQ4G9h+5qW2N9qj9HFznh5s1eJZmx/c8wg0yKkPCllsgtYleyxzYZE4tVi5rTRDkxwcj
 r68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790127426; x=1790732226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0W1rX6+rVhskPD49NMEDAzcroKEx61UOK5zJqNqWu3Y=;
 b=XwQ4yaJBV3EtAWqoDmWsMRpS3R31biLPkk0dZDn3avMgBfi5+gS8jSXDJCmL6ErIsd
 UgSfSj7bNh4Cg/kCNaU/qAtJqO/K1O/NewXHHzYpQRM+fZ9fSfmDu0Y1L3F6HH6v8fJU
 PjmeUxtBpZcxHfMXbTYnH6nFF25NkkEt+Ipa6kCwhLU7Bu5yuIbk3rlrNIuCfYM30XuD
 RjRqjeK2x3PM+RmRk703xjxLNYjZJQS7X6NoBxY5Z92SsK1Amv9TxJFIapkeScoM5MSl
 WIQrkg4x1zJGXusOJjw/j6LdY51lb13TiLj1dvZizj0pLOxE6rZOrJy94ckRSc0eeJS4
 zgvw==
X-Gm-Message-State: AFuF++mTP+lCjsczas3tTZ/UCD+oRJK5lRG2HpvLKroexMjB4/BtZDYj
 OqhRONnHTmE4AwF4EaPDdSKqV0ji9/QBdcX8vo+Qx0Eabk2+SnyiWlL5ITDwjp+T
X-Gm-Gg: AYBFou0proSpC1XLoJcvLEPxyps1sCOcuic8jL+NcTsFXhfhiM2vmTngo8rHDhrIBb1
 AcwKHIMRsl7uFw1CO0/HTijt5lVyAlzRbW+S4E2oho4RfuBf6yvSlG4UddYGvPdFjiBTIn60vps
 39eTa6U+5rbefCc8+WEGhfGZDLF81laCnAIGzIOsK+VcaGhnB3UDdVc7QfcjW55MOkbSONvJ5gD
 nbTnzZtMIxTO2rtEXopVk/uS5/86fZtTKA6cuwuXvdhDBiGnuDagSRZJvjV4eA27Vba5F5xDD4r
 MFwrtsS4BdREH/HYXTf/4Y6oe3sSvbSQkpj1sbDelXsNA/wJp1mL9+D+ulzO8HclSh0Sq1MuPk8
 Pe2HNi3gzqnPBIPR2U/w6ClgMrza9aat90pEGRWyjDyGwQ49wSJuQSmtAlJzg85liF5nrrpUYp1
 acOgNDYDsTYZB4w62NXwrUscoUqXYT2sMH2eGmVDnjblyRt6GwqUcykSv6Ff/g2HaChfleu0oko
 NqTiKvVDA==
X-Received: by 2002:a05:690c:a5c4:b0:873:5ddf:d85b with SMTP id
 00721157ae682-8a4592205b0mr5196437b3.38.1790127426201; 
 Tue, 22 Sep 2026 18:37:06 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a465dc1f4csm4558937b3.22.2026.09.22.18.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 18:37:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/3] linux-user/sh4: use the kernel's sigreturn trampoline
 sequence in the vdso
Date: Tue, 22 Sep 2026 21:36:58 -0400
Message-ID: <20260923013700.1505113-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923013700.1505113-1-mattst88@gmail.com>
References: <20260923013700.1505113-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
zz`(=6z>on{_zXx3Y<|MHorzhA!E^FF77L}xtcL{@xM7f?9F4!0fpc;qqxj_iEDspJ
zO@6?d&k8nUatNC}AH?M3<fPC_&#I)&3)#|`8AB#>a49qXn5@I4&bVT72$#C(OrV`D
KKnw$nAO-+EPcbI|

delta 178
zcmZ1=Ize=TGNZsm6=&8L3=AwUCgxO#6if>*aPh9(e`{gllH+YV4J~=!giQQ#TaZhL
zfq{pCfguB^@BxtK*!+ZXI}@`AgWKeJEEYnS84n9Ea0124FEapH3=C^0Co+mp=4XAt
z_+s)0)_hj5p2;a}_IwbNl9P*~EF)9WH*aK1V`g-jEWxD=RB6Md&NyRo3YWTQC(w)*
KAcg@(5CZ@weJ@}D

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c41cb5831b9e5883a64564da8b2149a33e199f4f..c1ff560cc165413d7b07aa873225bd92afb8569e 100755
GIT binary patch
delta 202
zcmbOrx<GV-0;9r2MQ7F@EDQ`kCT3QP?EQGW?V6EbjpN0Ka-A|h8NXg^nl$mp4M710
z1_mJp9)=7c{S2sBVDm%9?M!S+KrVyl<asO>ima0b4s$EOU^xRSe=P&&<U~f%$$wZL
zFn*hSmo=XiY|7+7HhZ|)49Uqxo|eYOshbzFB{MUIOlIX$X8bW(lS`d(#pFOPb%~km
O3=AzG8=-&^N&^7FXEK5S

delta 184
zcmZ1=Ize=T0;9l0MQ7F*EDQ`UCT3QPl&)2g-L`IF)#Kt%zJj4I-B(^c;xzHc4M8pj
z1_mJp9)=7c{Q#(#WAj7C?M!SUKrVyZ<asO>{EU|c4s$Y;g9L!AwUZMW#V7NyK45$?
z`7LWcD_GCuL^gZ4Nes!!m0qS1VOg6uvL!P!x=a@3QU)rv<WgsxF*%V-U80knfuRLt
J9277@X#jFbFZTcd

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


