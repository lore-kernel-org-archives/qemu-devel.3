Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876A4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfCO-0001ez-P6; Wed, 20 May 2026 07:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfBw-0001Pu-ST
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:34:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfBp-0005hu-Qe
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:34:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so11290480a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276855; x=1779881655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MP9Eubi2xnvBgezazT8hi6Ivropv6xfMAd7GXHZ/QQI=;
 b=GRL5pgWGuDLwoRaY2UGV6iM5sb+udUQnwU8LnKgTUAjwmaC5DJ56TTygIk6CqAoHn1
 ZrLuPrGQDWB1fk4C9DgvrDr85q/R6hJ1urlrnhfRHpsee4aMu3dHkbhnHsdQccn9L3MO
 cw5VNonaHfgQnYoVV7ootKsdXIcbbTOz3p645a4kS9jPIwrMPkVDkWqynMuX2z3sn0kw
 mz+hRKSFtRmwTNsHn5shgWv3mxj+D+n/eu+Z56nCI1P4Vp6jEp8tohN1dTNRHat+dMeW
 9skSOAj2hee5nroGJtvUI+pn3DLrhR75v7eldSAMlusCr+RZUchtETO9XC+JLUtRqQi3
 FWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276855; x=1779881655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MP9Eubi2xnvBgezazT8hi6Ivropv6xfMAd7GXHZ/QQI=;
 b=O2HsyHmjdr6+Om0QZTk1DcG7O8hGGdbwuOs+NuEaNdeJMXtANiC3I6FVQFWCmk2bKr
 3+XVRGwzufDceL33rSf0cDCqBKqJRxcj0o1D/J2sm8qXjRJyDBl5A9t1NHVts6nfcn5v
 SVIY49y3Hsvk9Gcy0UWQZUcyuqX6giahlnNL7jPbbZ/jmyfkmJvnCNAmF5lFG/M6v8b+
 WzfDQYVZ23DgLYoaeeRfRwpXi9ZGHTzWSw6u7lE7h5P5dXlgYe0mbtBT3Ap2/P24QuQB
 Pjl4UlR/xoPEN3KQCdTEACCL6okCdC/PhvBXPnuQoJBhl4HNeHbCR5WTgidtKjZ4yEO5
 WKWg==
X-Gm-Message-State: AOJu0YxS66AH8SZNfjiO8yM9I0SRxRwMKiVgtk+VWFvPtglfIn479wAB
 UFoGF84BV++D6g21gNMoHSiOrYMEumF38Su++mqYYhs7ELuZ4I31ottJAMHiSXmTpo5kmYsmTNk
 RXrtFa3I=
X-Gm-Gg: Acq92OHA5UKNbT1d0lgN2IfOrGJ29imFRXgUlcwCX/XDPYK4f+IKgYfpcMc4iTAKiUY
 H8qoHpi4Q9cWQMFXskLfPYfY6tQEPsBpuZwmHjbHWG1YQ1E/mchHrcXkfLPKZ1VauJImU0E+mKV
 l0K6kgXYDaJuKHU3ZNiZEMJJkBQLlUWwbhlQaUHLgAak4tJVNQSISD5+kXz++ZUru3dQ1sJ0FeG
 V3FkNygPvMDIkqwcfHdiIE0YFjmqO9XmO3SZEwrxBcDbgjSPaE8IhQFx1J/s3rmY3gaKjMixp5X
 hFex+JcHbSLQohcGGPhogjrwW6QSDwXRX7wfEyEcmTw+PRJNGUO1f6L8fm45A740ATX6XDjZ6oJ
 jd4rO0WtViGv64FHIFHevs758eyvQ1a0+BJszEhzJ6N1C96L6REgPy2S4T6IUTUCEmWADs680gM
 0ANLTfuG0A3awEn/+boNAR4y2J4AsoqvCdpug5kxkzsQfprjYs4z4Pnrgg1FLaOLYP21jQU6s/B
 hOiqg==
X-Received: by 2002:a5d:5d13:0:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-45e5c5879d9mr38194613f8f.20.1779272387600; 
 Wed, 20 May 2026 03:19:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm57237655f8f.13.2026.05.20.03.19.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 13/24] target/mips: add Octeon SAA instruction
Date: Wed, 20 May 2026 12:17:54 +0200
Message-ID: <20260520101807.9971-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: James Hilliard <james.hilliard1@gmail.com>

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
The MemOp selects the word or doubleword transaction size.  QEMU only has
one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
instruction feature bucket instead of adding a finer-grained Octeon+
feature bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0a..d6b241de421 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 401c4bd14bb..f00692830a9 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,20 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->rt);
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_32);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
-- 
2.53.0


