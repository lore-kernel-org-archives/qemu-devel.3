Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E44DCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYS-00072y-C0; Mon, 18 May 2026 01:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vI-P8
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY1-0003Tv-TJ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:51 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d593a0c3so1599510b6e.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082174; x=1779686974; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4zXKkWES8qZhC3q3QrRolIAmTOGEqkkPCkIvVM774G0=;
 b=DSQH7gmAcZlEnS+bOFaWR9j+1MAkaoJjj6pWyseOG3DQ6TuHOBcqito00zDOQ6g+Qq
 +bBFbpFcQkdd1AoswM0NE4q5Q2dDLoMadGX37eplNnXz+cA1XlFvwu3IAUSbSPDU4xH1
 k9f9PxfdJJ9398lFoC7hRPsnkCAHMK4UPUfIOvVOd+doCiZXZxf5/hIU2p0tjWxQCa3g
 aOuV96krB/Cc//HpUsVTxoQJrbtzSwRht5HpxKF+H2LspJpvFtfV+wdxb7zlh/t/riwc
 6OE+tU6dMWvx71/CzFjCJeu+urhQuPWGv12kyTLD0cdcDewbVjLnsSuGQ5FchEN5dRP0
 60/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082174; x=1779686974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4zXKkWES8qZhC3q3QrRolIAmTOGEqkkPCkIvVM774G0=;
 b=NM3zFdFk4uR6qGVY/RvGY+E0P//tr4dDHAIYiBpiZlaBPA9pLOt/NJtViMk3wNdyr9
 QUgcPEmXMa9mK8zYQKJudsVYlj8ISmnEmNxnhRy1ZJZ+SQIC6Enq21fnvekCDSoOvFCs
 ZbGXFNMx6yTBhcdchJYf/ydYdfqNWg73vrLkHJb4530Bc0qjRhKqyTpSNengn92JSk8N
 JVOSEU9RtOCA1m/Tmj8lSnO+qtP/YP9LwmfcnEU6T6YJwin2OMxCW4y64DhnlxcW/QT9
 vaBdT1MvFo3yjIUH7R88xHz7b4Xr2/Bpu3eKfFXAinZbtRkt1DUdST4rBMoTNY7qodJR
 e29w==
X-Gm-Message-State: AOJu0YxU16hXEXkc6tlI4aSlqfQ00OS2dBjwk7heT/0yFzcy2AOa+qJn
 0DA7VPCIlt1y3Hcsm8OzkZnGQvrHGeF4oZEiugDDcTZwav3ePvfbh73K
X-Gm-Gg: Acq92OEgsS07riZu+NlquScHXtE/dDz9XUDcD4UWjj0octg7bvnnAkHVyQ5LH1tWcm6
 kZWjYtv+oUWbcYEZhNY1zA3vFFgOGrHiu7or2f8JIfOz96pwWni3f5rI7kY/OQ2cvY6C2Iv4d2f
 1mp1Dg3Jm2f3gGubH06L3ty0BglzyLwYijxzIlOwn7RwcTI5U9B01L5CIUgOYEeWUx/e0MJpw1s
 4lqJ7eZCBSstnn6hZYopdU4FnOpJ126ZrIXDrzbUkEorCDMMqck960d1IjhAPBtSg9j25Vqztxl
 C1ETgKl2Y2MEN3ZtfoiLzE7DMDLrC2wKcfRcVn0tzrx+Qvp3+EWXtj+MVVStAJq0OeanJNNYkwW
 jhDjifZAyqF/sulMi8bu8y3ULVWrW6kyWFgAQSGSoJzNqkl/U3JPBnUrmdbjYxTIG6wF5c91gxb
 tqxLjjV+8pGaQyt9/eVd6ZiYCAM6oa+c06oKS2rUDJ18/dvISaMV/0Tu+a8yTj+2Vmt4lYqmBqW
 TJZUuoUg+0g+qVboHVV80XXxaA08MKKU3n6xkGcNq95CKh69TxrXB+zuhIa4QP1W9xgmVSaaDOy
 pnPVr+9lifqEmtRb
X-Received: by 2002:a05:6808:1798:b0:479:d674:dcca with SMTP id
 5614622812f47-482cb71ea38mr10052658b6e.4.1779082174403; 
 Sun, 17 May 2026 22:29:34 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:09 -0600
Subject: [PATCH v8 12/35] target/mips: add Octeon ZCB and ZCBT instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-12-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
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

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v7 -> v8:
  - Fold the ZCBT wildcard decode into the ZCB patch so the series does not
    add a ZCB-only decode and rewrite it in the next patch.

Changes v6 -> v7:
  - Use 128-bit zero stores with MO_128 instead of sixteen 64-bit stores.
    (suggested by Philippe Mathieu-Daudé)
  - Fold ZCB and ZCBT into a single decodetree wildcard entry instead of
    using a duplicate entry with a selector comment.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split ZCB/ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..01ed3b50be 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d3dfef2e0c..d89e53045e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero64 = tcg_constant_i64(0);
+    TCGv_i128 zero128 = tcg_temp_new_i128();
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 8; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 16);
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
+                             mo_endian(ctx) | MO_128);
+    }
+
+    return true;
+}
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


