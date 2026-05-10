Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1982CD37B7
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwn-00054t-6F; Sun, 10 May 2026 16:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwl-00054C-J8
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:19 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwj-000401-R8
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:19 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47bdee5bfc4so2610925b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445616; x=1779050416; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q1k/PKFzKTDVvPqGj4sjRRncSCPss6mvc/nvKoLhCeI=;
 b=NA+0cPBxa9NPXtcRaGHguKOfBJO81WVV52zjF11kxy3DfTYswlFloDXsAGjsFgXwhc
 jSiUfGcuk8dGj9yg+Voh9DyYFk4LBaMa2Ee6+rY6OfTzbA7tjWv//KcyatEiMxcG8o+X
 TUj1DSWcPvEXqdd1qRtLwMqI+X1iYd6L7HTrFqjMC9vRn3XFQETRmht6TDc5l0fenzGD
 GiGDaKxE75dmC1HjOCz54AFRilwnsBWqF/r9wvOnAS6cRKprM4HC7Q/g2W0yLk8znk+J
 J7/exMSex75rCM9l20OWtbjiLcDBo3Ghnb2PZyKzoanTjj8dEcwr8wqYC8iofqjh95P+
 WKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445616; x=1779050416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q1k/PKFzKTDVvPqGj4sjRRncSCPss6mvc/nvKoLhCeI=;
 b=ZA3bfWmNPC9vqjM0Y2D0YPJYSS6yseib+gaURjikJVLefQLVqtAX2osKJHkNzJVWSU
 qxBZSIBY1X7gc58DOgCbDAw9TNDlixJ1GZ4BeG/BBa2uJza0g3NPYtKTX5agN6ZqUx+x
 yXqNTMY/c9/7n3Rs6MsPQAh6JwTCYgOqZKC5NDXfPdkBYhRPI4MxPqBNJeZqp02QF9Nb
 +CGRSv9zMGXkcGixiInF1rR3pO12tW2nj82Ckos91h+ED6QFN3z1Pw+dY4HauPOy/GyP
 b5O3sScj/liODPyW9Lh+PdtG9nk8R64kGZxncqz7uasi3/DXBKlXvtDPgmI6tkPV93Vk
 89Fw==
X-Gm-Message-State: AOJu0Yx8i/+hNFMtdBDnGdsjDY0mUO8etPhKF9DWTZ49ThFP8glFb/mb
 zS/Hz6TC39eaM8EPb3nIU56yenP11yhErnkUgwMsmUKksByciN9yR0Jf
X-Gm-Gg: Acq92OGw1NcswDcc1KXVFDPXS/HHqKMZkjfM8rpA993tHAAn80Mjc1JuD/GlXIgU0KX
 cWTbyv9hodspslmp9V473cwmFiyQkKLM9Q0W4YgrSdNwJi9YR1OOi/kn0DNos+zZV5lkYrbRzc7
 F+JJk5qOyftaYgox/hKbZpLzI+6A9TAniHfN/AByY2b+VYGySIhXMEOOqwDMzFCjlXanNeLsq7K
 vkLHjUCUCvNMkXWekyRHIjiDzJEI4PCg85zUejBuwzj20r4sdQxNQrj3s3mGQyZcwgXJah/p5TZ
 LNf1Zv6cnUcToZ1thgg6MJ6aGDDdTEstFXw1ArnhmuQaLwpcDk9bmMlG5rIHKxIaiopDTj1h0S1
 UFRUnVbAbDW/2xQXAl4pA9qphw2uaFD6DHGT35X/nAxG7ER6s2o2uKB7pkgfJ3OSDDhKM6mDvf/
 dtQMS82looSSUyRHxe/npGgh/4E6nJbIpNzbUTMK1BShvnuWrUaeEORMKY2VgWhXO9Aoke3QVwj
 V3krilMQ8o0cd3akkrGrF7N8/pwRLOlWv1v2WfKHeQ=
X-Received: by 2002:a05:6808:1304:b0:47a:499:b616 with SMTP id
 5614622812f47-48061c2aaeemr7944006b6e.16.1778445616514; 
 Sun, 10 May 2026 13:40:16 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:43 -0600
Subject: [PATCH v5 13/32] target/mips: add Octeon ZCB instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-13-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

ZCB zeros the 128-byte cache block containing the base address.

Model the user-mode-visible effect by aligning the address down to a
128-byte line and storing sixteen zero doublewords to guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCB out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..d8a1bfce77 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index dc16a5935e..3373f4532c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -174,6 +174,30 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 16; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 8);
+        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
+    }
+
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


