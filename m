Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51373CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtO-0002iI-7O; Fri, 08 May 2026 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt7-0002el-91
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:14 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt4-0001gb-R8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:12 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-42c0b0ffac1so1216936fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253189; x=1778857989; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7+lYBCp3Rm8qO6ote7GQN5rQY0LcgGtx5r0KxlL36s4=;
 b=EoSVpMyD6rUW0BTq9RCD6l99RWdtEpps2khBLdSTCvwojnnicupHacbaejUV59Sgiz
 qD3t2CnUUIZjyaLQgTR0lBbu5ax/YkWm59QIyOYzb1uy7/PL/VHQYpjF8ISFf4K8NSCR
 Jc9vzRs4DKZlYI4YTogo8fOVAudVU/svg8Qgb+6Taq+mtHEKyCrceuK6whk5W4kTx/Gh
 qJUW/zGIM4xoj0tcGNWl2Ycj9OTIto+IfpsojlByBl0txdIhgZTnnAivSXKD7hmJnqib
 YMxokTxyOdkhQ7pf6Nm959kvjHrN3DNLOa8lgbh333OB6Lqnae/vuWFbk18ldt77ddDt
 zH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253189; x=1778857989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7+lYBCp3Rm8qO6ote7GQN5rQY0LcgGtx5r0KxlL36s4=;
 b=AoEyhNjOTQ4hhy/E+Wb4qBD3T7yJ1qhEP/ravji6B0X27NtriHn+WJgiLaa52qHl8F
 Qganrzji/T+/+6VFqmQRi9eDThsJLtoDbokfKNvzfpJ5WOxQrGl5/6oZYC9bpDeMmn3N
 lRPaZ/VXbNkmxm/AYn8WDdqK2kK2dlZ80mzFc/M1ekExOqNB8QMW7k5p4+z5xIMrAhqS
 whMqFSFkmk+dGWnnybKl56tEHqgsBYiuxT5vma8G4dxeVSWyx9gw1NE81eKHDOp7zf1v
 ZCY2j4uEx0T98TZFZLCKVQY8UBmuHXLHDdIkXDK+Eg5VgKoYksTA15g9WnTm37z61eWK
 +oRQ==
X-Gm-Message-State: AOJu0YznnAvjOI34zxCtiNcgTLqCCTsIN9sAVjny2nAOUtUoiY50XKEa
 RySRt3z2Nv66BfIS2/SVGyJyHcedXT9gRmV46u61KWDoQZfeVFToCJPES1XclA==
X-Gm-Gg: AeBDievFl7UmZ05giic5n2PSyOZZdxyMx1DgtAkCbX58OCmkCeD5FlqPOVW8KLgHMlZ
 1RKHEyXKfgQ3n0BNx6UM1L5qC2as9DnPGUmITc7ZlD7gE05LsPlpgGYPboLQmmbl1HWGNh66p+P
 7UKUVSJ9l/bGoQ2uIov9Mo4bQmMKF6jxnPYIiOAiqoimbQTZTzgHq0eYQMPeXGrujZRVEVYyFGf
 54CxOEdfId3ofX4lIbsmQKOqyQd0ofBoDs9v+ISDozNSvuqKd40NBbazc3OJhsPf1Mz7Z9gc5fz
 vgEEplwaqWogUjHTmGidT3RZ5WM8rtn/9+cl5qOn6ovcEQ1iFHlfom0lCo2MQuqCBhv/8z5GUfv
 VtpKiM9JnHSIRCYTBMNY/rF77qy2ZgKQsSJwBRnu/m+lhFA0ewPAdilS6qtv6RMZVShav00Jm03
 S0RjvH3+vYc0HlK9hl5NjKjoAiBP8UYqJLC3Ld5W1hIjNBgJwiIPzQ+vrT5JoC5TGJgKyyFC2Ms
 MiHpiCmzgrxQ5w5rQ1zFHG0Wf64+XFUCIOxfj/r0vi0pGu6v41Fy7DOhmerNGnjuvNQorV1dTiY
 grN2BvdaBy6lZrzkUjFgBX+thbNLpDzsrr+ZTFHI/jSWJH0OiVomVSSyCuYwpajp/UhFyxM=
X-Received: by 2002:a05:6808:181a:b0:479:faf5:ef4c with SMTP id
 5614622812f47-480424d65eemr7902619b6e.32.1778253189039; 
 Fri, 08 May 2026 08:13:09 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:11 -0600
Subject: [PATCH v3 11/32] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-11-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
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

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement it with TCG atomic_fetch_add_i32 using Octeon L2 transaction
alignment semantics.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAA out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0..d6b241de42 100644
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
index c93eff59a5..19535768d2 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,33 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    if (mop == MO_UQ) {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+
+        gen_load_gpr(value, a->rt);
+        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    } else {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old = tcg_temp_new_i32();
+
+        gen_load_gpr(value, a->rt);
+        tcg_gen_extrl_i64_i32(value32, value);
+        tcg_gen_atomic_fetch_add_i32(old, addr, value32, ctx->mem_idx, amo);
+    }
+
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_UL);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


