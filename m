Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F80CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgZ-00017H-Kr; Wed, 20 May 2026 00:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgT-00013p-7c
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgO-0003m5-Qa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:28 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dd73b7c757so2132729a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251841; x=1779856641; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iNGUkUQb5J29ukIe0u9qyTma9foPdK9x44s0U5JWP3E=;
 b=LkCyVf+COB5QTtc1waT4R/aZ+rx6nN1p66moMX4skVcv4z+i1r8gHQgtPBvrBImkov
 h46v+4qX/gbXh8sQ2+XcNoL9ZSd9qF7uOAAhWQqjVjwNfyj52KI7L/wnAfmvCGKWLowC
 Kv0oTcvRAHDeYFEMBsmobDxr09M7cCZOr+3cSzTsEklDWl9kZzNtUe4AkA9whyeq7I+V
 PsdOO2H/HaIyOjZSepl04BbgXftLE63l6tv75zKGN3MBADvo6jBXcIXuWK36BWC4xyJm
 qcb1LyeakAlDV5idAIuLvGdgUvttbT3hNuTM9Thko2lBGw0mSMBSUOvJ2GyAqOgeaEE/
 8BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251841; x=1779856641;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iNGUkUQb5J29ukIe0u9qyTma9foPdK9x44s0U5JWP3E=;
 b=O04nRr1pobyTMi65t5+WLecOzFEGfaIhb0y2V2ZTuZW/ADpD4JpvdFa84rHp9eFIa8
 r+fQBmBNgQkGvIiibVePY8XsiCDPX+vIdHHdKVM4kJk6jIXQbkpmZUNGts09yNEPk/TQ
 uhBbl+Qh7PUAUy+vRsYN4/Yu1iYtePPXL7GwGRm7UxFyDPE7Z0WrZDgqsPooZ9pjCOin
 6TOFGADHUIBw8tKsMG/mzsPZrlilLRQkxHfS8w9W5NXAEWEN9dR41tduCH4FwgISEIg0
 zW85XgUM+THBvR1sUjfqYOA2bQJQvB9YnLqDTFScVoJajH12OvGdZ9xjWbYZoXfCgNtj
 LQgg==
X-Gm-Message-State: AOJu0YyBaEwb5aHJC8F9oMAuG2sd1Jo9Bwe0GqFbG/Hyo6td+Jt0LPXB
 6NCEfVhEif5GDmp5RndP7K5dqj65v3CjwPcdi3vBOIj2mhE0Ztx6DRfS
X-Gm-Gg: Acq92OHGhbVwePqhtAAaX7tY1+wyHF1N0Csywd01oXHvy1cgm/a21slZos1KV52bYUb
 atWsZsiC0yzZj3Ygj68FOADnvGXoviI2ttfKSowXz2CPM17pg2fTTs8czIMKsUTPG4s3X1Wtcqk
 w2LzNpdW190jFeZGNMpjNVy0U+YkMGt7SEMG1b0aMd3BL8KYbBJTxZ6rp1ytjxEdPfuegVy/lND
 fjK5eEK4pFZml0vvOicIVIZvAWykYYlz8TiTH6xy4SWFMQ7AOMjRhdJfhnDoaVlz2OVVwDx2Sx1
 jAoOSm2WDeY7WTofOWF+q/eUSNoVE/9fSucCeJCFXQVMYT4VUWdgPym+JRwlifeqeaZURVILcNU
 o86j82jfbxABD995k4zz3m6Fp2tDqgjYvvIfmamAPQ256G6D0WVuSn/qK27xSGECAXJQFsaIshi
 M11W1hD9WJqWaPWmjVSjWIHH+kUnx7l2vItZbAaLTBqf2P5Tf4/nTCHPOu3U+Y2Q1n/7gemdgnf
 HhAM/lM1i7dwScBMJz4J9GKhsramAdQl0ZZdcNE769MLWetiGT8Wm6LTSNKnbK6d5Kt
X-Received: by 2002:a05:6830:a8d:b0:7e5:68c3:6246 with SMTP id
 46e09a7af769-7e568c3630fmr8921172a34.10.1779251841647; 
 Tue, 19 May 2026 21:37:21 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:00 -0600
Subject: [PATCH v10 06/45] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-6-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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

Decode the equality and inequality forms as explicit SEQ/SNE and
SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
entries.

The explicit decoder names match the architectural mnemonics, which makes
the translator entry points and trace/debug output easier to correlate
with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
    instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the decoded ne field now that the instructions are split.
  - Reuse @r3 for SEQ/SNE and pass the TCG condition into a shared
    translator helper.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  7 +++--
 target/mips/tcg/octeon_translate.c | 52 ++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860d..a2bfd0751d 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -30,6 +30,7 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SNEI rt, rs, immediate
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
+&cmpi        rs rt imm
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -38,8 +39,10 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
-SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+SEQ          011100 ..... ..... ..... 00000 101010 @r3
+SNE          011100 ..... ..... ..... 00000 101011 @r3
+SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
+SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b7531653e5..5497ddfb10 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -106,52 +106,54 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool do_seq_sne(DisasContext *ctx, const arg_decode_ext_octeon1 *a,
+                       TCGCond cond)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    if (a->ne) {
-        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
-    } else {
-        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
-    }
+    tcg_gen_setcond_i64(cond, t0, t1, t0);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
-static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
+static bool trans_SEQ(DisasContext *ctx, arg_SEQ *a)
 {
-    TCGv_i64 t0;
+    return do_seq_sne(ctx, a, TCG_COND_EQ);
+}
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_NE);
+}
 
-    t0 = tcg_temp_new_i64();
+static bool do_seqi_snei(DisasContext *ctx, const arg_cmpi *a, TCGCond cond)
+{
+    TCGv_i64 t0;
 
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
 
-    /* Sign-extend to 64 bit value */
-    target_ulong imm = a->imm;
-    if (a->ne) {
-        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
-    } else {
-        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
-    }
+    tcg_gen_setcondi_i64(cond, t0, t0, a->imm);
+    gen_store_gpr(t0, a->rt);
     return true;
 }
 
+static bool trans_SEQI(DisasContext *ctx, arg_SEQI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);

-- 
2.54.0


