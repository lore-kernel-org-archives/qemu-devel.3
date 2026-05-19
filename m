Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F97ACD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDd-0006fj-4p; Tue, 19 May 2026 12:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDa-0006eK-Aq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:55 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDY-0000gz-JF
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:54 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43acf1694daso1313600fac.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207771; x=1779812571; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SEpaBN+Cf5DSQcUo9bhdwLJ6wNzQO70+KKi67N4ETPs=;
 b=rgwcZiOvP8BuuZDuqmSFfpCFg/fjRjvNguaP+DaVMSK9LDpQQ1bAR7zp1D2zUl6dxT
 mgARggcGIBJoaB2nHQ/JT8GZhAJhFeZ/nbknhOefw83zZMIsBfYIij/tJrXyz//v8egw
 PvFjELBPR5ctdjOu4rRPpBVEGKp9OPUA3vznLGlgyGIFSrAs9VkZK3OTo4S8f+8qRMkI
 XOOhDwWi+s2PpgbVbIm2oQxq78F9E1vDFiAJ58++1Qe1pt8tIsgK7JDtKvngjPlLmj9o
 wBQ98Mn82nObLpg/w4QDcX2hBNkQ33W31naSCec0rnh8WzTaz3tZUXEvsZy1bjTIVjRF
 QG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207771; x=1779812571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SEpaBN+Cf5DSQcUo9bhdwLJ6wNzQO70+KKi67N4ETPs=;
 b=eqaBdsuhkS6/YTCFgMaq7aBdQaURxc0nvE3/gjfKO//0YJCOMdc98c1mQCnQp6AMoY
 90CwlOQ03riZ64X+B7MuPGs/O6uQjbntf/X2elsR+hG8dJeOpqFlSXk5/fv/ZjNVEK1t
 1mhmZcC4fL8wbJDFtq4AULd/hvhgbnjd5ZGUH0e4nfnD2hPW/Pbkm7MfTpyMHwomvy+O
 zlh3iYECc0qzmTYK64jS60J+S9HcuRM5cPXUp7A7wVlgUw/rte3v4Vm8bYI51a/7ZCci
 1ITFDMKnsXU26cL0vIoUnIuYO2gs4InnJ35YDyobtYJnWn2ie/XsJM1gleLyKkRdDaMm
 VThA==
X-Gm-Message-State: AOJu0YzZ9Re2ybWXcHgffw3XDElacrtjxKlJ4SmWSfnHSX+qHJn2OMhw
 Dwn5jxSaf/k9Gs4NKGMBQYrerRjH24tkcihbEavtVA92k+QRm5Ijz8nu
X-Gm-Gg: Acq92OGcCa91VFJ+MwA8dX/iT6jQvNcm3pLy3QgdYoCeqvq5tVmuMIsRQqLSES/zmdQ
 d6quygZZm0QxAtjPpWG9Ogu2ciF3v6F5lqMxLUmcP9ioIzqBtrCxVCkeF4tEjiVQHf+BTtgD6d6
 Kzv5QklifeSWwJbE7/aR6efSTtQCRXVd6rRB3Gm7e0brOeflKy7mA9F4uDQXc0rTUzOIy36lWgK
 0WzNGPn692+RYrBkyTJuM5uw+1JWzpm8vcKdtVOS9oqP4CGZIlPMe44EYfsX8CogfSSCWk21nb5
 Ze6SIGifhKjA8U3Dwb59j3mObey8GtICxiBPY6x7zyucv3DNk3ucO5k326sREHnmyJPB5yOp3oc
 xvPvRHzPJKSmQ/8xjUlYde7NceIilpLSkHqiVplBJE96WerywfuecZN8G7E9516lehrf5G56Z8p
 sHTsvAuN1Lb1zxAfsTdhXWEO01Dd1FulnDdGRuhmahoQ80vBHoF0ggmjajMhNsJMspskkq03up/
 Objhij77P4ZLdAvGYj36kIlGPe8qS0/XRln5tD83x9qP3bFUsyOsIMr/+pTKS94vM76
X-Received: by 2002:a05:6870:891d:b0:417:5285:6c7b with SMTP id
 586e51a60fabf-43a2db4d89fmr13643328fac.8.1779207770900; 
 Tue, 19 May 2026 09:22:50 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:18 -0600
Subject: [PATCH v9 16/40] target/mips: add Octeon MTM instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-16-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
products. For MPL0, also set MPL[1] to zero for backward compatibility
with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTM encodings use rt == $zero.

Changes v5 -> v6:
  - Clarify the CN71XX-defined MPL1 zeroing after checking the
    register-state table and description.

Changes v7 -> v8:
  - Combine MTM0/MTM1/MTM2 in the v7.5 inline TCG translator form from
    Richard Henderson.
---
 target/mips/tcg/octeon.decode      |  7 +++++++
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50be..5139543b15 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,13 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&r2          rs rt
+@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
+
+MTM0         011100 ..... ..... 00000 00000 001000 @r2
+MTM1         011100 ..... ..... 00000 00000 001100 @r2
+MTM2         011100 ..... ..... 00000 00000 001101 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 721a9a8d9d..67d95423c1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -210,3 +210,35 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+
+static void octeon_zero_partial_product_state(void)
+{
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_mpl[index], a->rs);
+    gen_load_gpr(oct_mpl[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears MPL1 with MPL0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_mpl[1], 0);
+    }
+
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);

-- 
2.54.0


