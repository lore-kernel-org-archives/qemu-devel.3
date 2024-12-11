Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F265E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPcN-0003tE-R5; Wed, 11 Dec 2024 11:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcC-0003Iu-1d
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:08 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcA-00019N-Ar
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:07 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4678f681608so6617361cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934665; x=1734539465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s63N5H1NJdR8gVUhJ6lBSzQfPRwDYdjmVxlruA0DAg4=;
 b=KapA97snaboMbk1DHeCZw3RxEwoDQyqqGS1uwAGAiOLRP65VVyhrCTTUPA75ALe9cs
 FgGIYzvfTlPxGoJkBWUVqUydjeT2TCzNX+7NFQ7lPTbUhvQRfm2CUpc+e9fG4jvpvbeD
 RAF8wcQk9ln5oEYbdgSwl80w+n0DZ2ehnmOcRrN1Mzh3GqWbMdk76pr4VX5WAUyVZvKd
 kIIyjC+INvCsRFRxkiQ++F1eNhKoikkp3kwHKOxvugyyqVGtmJaSUgcFj627KYbNZW0o
 IdNbJ7ASAldcpSGevTfgLI2TcGlVt2f8Y6GA+Q+Oa9QhvxawiKMGDdffYqYlPnYQEMvn
 ohYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934665; x=1734539465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s63N5H1NJdR8gVUhJ6lBSzQfPRwDYdjmVxlruA0DAg4=;
 b=LGeURszGwkERWC7whXNXuDk1bJmT7+351yKdff692yLSx/1fq5agJ00gGvox/Cqi22
 iTXh8GehDaEWZrR9gm0fWd+/vI/pHKwbludX01j+sduITvrbGk4SmVPcOfwuqmnBm0+u
 jjRQUE9gsjyP6JGaDr9PtnzROTlCHTJBJ2voLMzhFqrE9Aue4c0EiRMQeHz1CCc1CZiY
 cFXUmlHoAjbItMyFsOqprwQ62NhHDOq/sdG2eosfWel90mRUYyusX+OXlImm673su/Ew
 7n5433V1QLBDz27EFvu8cUE9q3gkDXOBoaGyjJkzmy4OaajKGmzhHQ1pm+Yg41PtqsvK
 9fdg==
X-Gm-Message-State: AOJu0YxwDMMZQRDg2x9U0zeOoBXVglVGNwFyCe/wQgAJZ4X49xxYUOj7
 kfB0yUA/kcsQ8CDrI88mXpyAUE/3aVhLKfKemVt+/QJ1kR5vt6jcw9atPOiX1W9Akcea6dPseAd
 TrBTvnTWe
X-Gm-Gg: ASbGncsRaEeaHBbh3wonL2UwD2kkKqhMwA1tEUpF0AOBQGAQFJvLw7b+ZB/9bGcPB2R
 zr7I3e77CH37WZVGaDZ4GwI7Wsg83jBd9gKuTJMjaKE/+S0m+8AzdCBLeVezgCSd0ZjHo3sxKxZ
 q5Nw/qmwmhmrhiS8aHi4vFAQ4w8IO/L8KjiDKCS5tzvjVgdGUUlMzEffTcvE8M7AjSvpcQwjRB5
 A04gLVXp4RR6EKyDlesakM0feYNJq3/T55wE8ywEIhUy8AvGHGujOiMPBPIfQ==
X-Google-Smtp-Source: AGHT+IE5T8wTyTf4MDMl+oGcotgQGxu+YGmdLudMdt8KcyKvi5pPKsLrXjraUpx7GmX03nlB2vSWSQ==
X-Received: by 2002:a05:622a:15d4:b0:467:6b59:423 with SMTP id
 d75a77b69052e-467954a2d88mr6898901cf.55.1733934665346; 
 Wed, 11 Dec 2024 08:31:05 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/69] target/arm: Convert LSLV, LSRV, ASRV,
 RORV to decodetree
Date: Wed, 11 Dec 2024 10:29:30 -0600
Message-ID: <20241211163036.2297116-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 46 ++++++++++++++++------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9f687ba840..8b7ca2c68a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7575,6 +7575,23 @@ static void shift_reg_imm(TCGv_i64 dst, TCGv_i64 src, int sf,
     }
 }
 
+static bool do_shift_reg(DisasContext *s, arg_rrr_sf *a,
+                         enum a64_shift_type shift_type)
+{
+    TCGv_i64 tcg_shift = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = read_cpu_reg(s, a->rn, a->sf);
+
+    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, a->rm), a->sf ? 63 : 31);
+    shift_reg(tcg_rd, tcg_rn, a->sf, shift_type, tcg_shift);
+    return true;
+}
+
+TRANS(LSLV, do_shift_reg, a, A64_SHIFT_TYPE_LSL)
+TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
+TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
+TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8456,19 +8473,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* LSLV, LSRV, ASRV, RORV */
-static void handle_shift_reg(DisasContext *s,
-                             enum a64_shift_type shift_type, unsigned int sf,
-                             unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_shift = tcg_temp_new_i64();
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-
-    tcg_gen_andi_i64(tcg_shift, cpu_reg(s, rm), sf ? 63 : 31);
-    shift_reg(tcg_rd, tcg_rn, sf, shift_type, tcg_shift);
-}
-
 /* CRC32[BHWX], CRC32C[BHWX] */
 static void handle_crc32(DisasContext *s,
                          unsigned int sf, unsigned int sz, bool crc32c,
@@ -8579,18 +8583,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
             tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t);
         }
         break;
-    case 8: /* LSLV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
-        break;
-    case 9: /* LSRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_LSR, sf, rm, rn, rd);
-        break;
-    case 10: /* ASRV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ASR, sf, rm, rn, rd);
-        break;
-    case 11: /* RORV */
-        handle_shift_reg(s, A64_SHIFT_TYPE_ROR, sf, rm, rn, rd);
-        break;
     case 12: /* PACGA */
         if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
@@ -8616,6 +8608,10 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     do_unallocated:
     case 2: /* UDIV */
     case 3: /* SDIV */
+    case 8: /* LSLV */
+    case 9: /* LSRV */
+    case 10: /* ASRV */
+    case 11: /* RORV */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c218f6afbc..3db55b78a6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -658,6 +658,10 @@ CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
 UDIV            . 00 11010110 ..... 00001 0 ..... ..... @rrr_sf
 SDIV            . 00 11010110 ..... 00001 1 ..... ..... @rrr_sf
+LSLV            . 00 11010110 ..... 00100 0 ..... ..... @rrr_sf
+LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
+ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
+RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
 
 # Data Processing (1-source)
 # Logical (shifted reg)
-- 
2.43.0


