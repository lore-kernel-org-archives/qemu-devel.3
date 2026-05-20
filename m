Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE20CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg8-0006T1-6A; Wed, 20 May 2026 13:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfB-0005OU-MU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkf7-0003vd-Cl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso57419645e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297890; x=1779902690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJRK+fSA/YRc7Rps9zj3R+rtt3hX6PX40ovNPoweyOA=;
 b=AKb5wqwupRJTVWQdJGtjBn+wEherUoHJPbCaF2BZjHZY4XvgbBHFYSC66SqV7DPwAt
 c8UMnVlfehHigr6pZ92zXPZB7KMaLiAoNiukJDsO2dPjnLnPQVK1alIQXohKyBjoF+rO
 BnuM1PC/63AEgyo9LdLaiXtwfpfViFeUQPH/6887ZpOqdJP3Ezs2NPsnN0o7Y7yDXZdA
 qXkpVlCeOzRVRFdKw9L3tLza5zkQRfLBTLp7eM+o+EAHz/yfoeImS6i1IBdbDEb2YblI
 QODQaGd4tGW1eK0meD4iWbyyuM9Q2SUXZKpfMH/BB5jxFosxqvUFEBC9Cb1AG/w8SqQi
 qHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297890; x=1779902690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yJRK+fSA/YRc7Rps9zj3R+rtt3hX6PX40ovNPoweyOA=;
 b=r/JBH9GSaH2tQG4gP6VdXjMlJ6Rpn1a64xiJx1bqLBXYEd9niP4igSlPesTmGGVi4L
 uDIYmw/mxIgRVzyBOoeyBlBy+2t34Wvaqg5OAuB1qwr0cxBoAp0LWrNQS5OOp5xZUWrv
 YuIpJOqy5s1FmaCZQEQHgYredjk0wMi+fzz7qpzwsiRhXQsShHuJ52GuOAAd3QLFdBit
 KDbg38kNmxc+aia/uy/PH+7wUb4ZtiF6EbGuzuoFDwXRz5OJrKwcc0SKdTHc2LOFFC5o
 Mp1q/UpBtYOz5ksliT2lOHpEHfgL/hj9tUI+9u8CjivF8uRfrDbyucHDPWAXsEcbnxKJ
 Nm4w==
X-Gm-Message-State: AOJu0YyLC97p161ro6e1QCpbaREfNNrkWPg8pgIEsUdOgLr8qaVhX7ir
 cinH+g9OjDux6cEg7mp0+6reROPKQ0iMceBOw+wG8TuYdsFMImitMpu4rfa7eu57dH75w+KTfit
 1Dsib6r4=
X-Gm-Gg: Acq92OFr2bjKW31En/xmFKWWnw8rWcP3noDdYgAx8nsfFbYD4VAfgdSyF66XGtg27mq
 6yA+45i+RErYoJcvdd9Dr0CH59ojryhT6Jl22woaWcKXCyFxwkFN3BGH5gUHN+ZLamJLv26QueX
 eHD40M90+3SahYKG2WKT+6hpgi4q98YFDCwssgPI7eCuS1o3MBoISDPeUOEF1E085Mw5MHgT8wZ
 06yYg8FcC2iw50rMkbhj/TQpNSMKlrJjHOpcyF3rHVbR2KrMuburExDmF9Dmz40tuylzxdoJNZO
 ProboikVfAm0Qe+BOB5pEvpnISIxrpY3LeVHp/D5pPkj6sNZrF08hyi+0IUWPmuRyZnw/0DQV7U
 PbKh/L2Yl4hhkswDhye4YEoOodr9jHEx98kkxaChu5wppl/3YyaUc5apQ+v6M416QGQwxnld6Hg
 2yWtBeV1cKKrsAGrkqDfiV2KyRvDDcfYXMnLZuuu2TuQ9152WlnqqaDZw9Uu+h6cYiQHjwn8Wl
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-48fe60e7a13mr370256405e9.12.1779297890605; 
 Wed, 20 May 2026 10:24:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3f99csm10752625e9.6.2026.05.20.10.24.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 13/24] target/mips: add Octeon SAA instruction
Date: Wed, 20 May 2026 19:23:01 +0200
Message-ID: <20260520172313.23777-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

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
index 401c4bd14bb..33b45611f20 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -168,3 +168,18 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+
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
-- 
2.53.0


