Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48248E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XW-0007DS-BJ; Fri, 13 Dec 2024 12:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wt-0006si-75
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wp-0001S1-FR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso14467305e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111156; x=1734715956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r9qMi3+MxVuBbaoTU6RRcHd4XcWUlSJWEHe6/FZDEjs=;
 b=Sl04onK2F1R/+CAO1WE4P86CyVebygATpUkLglWc/0DMAlVPVVpQ6vjSzZ2ooMhMwE
 e1OZ6JfXD6J/bnyjBlqMW0aY3Y69rDZ89LbmQ7BHhtqsREkHD19VonQrFQq4z5PK/rg3
 Wof9WYz9fkVgiW8mNNQWkH741lAoUMIJgWFfdTWRrVTbLSOX9A1mEF7seULN6FS03scz
 yV2wSOzqGfrPyZ0ZW7Z2cAN9fB07IYC2ZXp/bU296oPMP2QAcku/xX+JU37232TivD8t
 AEOojPlJuYVMD2EcWyThmDtbhIwt4JmX2kVShaIfgtjThJf5VO7w7ZzFx1eR2ejeS+Fi
 bdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111156; x=1734715956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9qMi3+MxVuBbaoTU6RRcHd4XcWUlSJWEHe6/FZDEjs=;
 b=mWUeMDK3s3YxYjduMIhp6eTMjC2tQhItHKRTnugke3820ms1U+IHAJwV3kdJD5JB04
 DZojxxO4OeoLCxIDjBXeIO+KkTnvVIXjWRcAfaXlIhkevLVHiSfM4oZZJ67rjmaQzRE4
 tJvrw/CGD/LhuXO4lOkX+d7VZf1LBd76TJOrDxtWqb7n3TNEAPMnJAuc32whLkT2gpga
 QM+bo+HT1sVplkC/GWhhpGeBkGGpjrJbcZM5odJAFzLAiDoahnu2QJHJJ3LSemIVTAEZ
 hUhKjDOCb8UjwNHjySt6hgfVuJwtUzz0jtNktM1W4hbra+mLdtydy5+Xz5bStVrBKW1E
 bc9Q==
X-Gm-Message-State: AOJu0YyxWzDNCBPaWi7xZQyTCZVU+EQNNjMQmugL3066daBGuHXuEgTd
 KlqKp7iM0OfuzXDRe9G/QDJCV8fjgNyouP0Gce/a4A9WbLI+CGUtwZHvBNMrQxNBxv+Qth20hIo
 i
X-Gm-Gg: ASbGncuL87dEXKgeKC4wVhbsnfIPAy0G09Xydf4IoRY3XNS+L7BOvPkPcx6dm9D0cRX
 WXdHdlbbyyWJfthpzQyhb7oT+8enhNzW0GjGQO3+NZAdrpGvnpT+VUjtX/SpiSB8JGRlOaDeJmV
 y2SCucoK7d1izv3Cue7m0RnnMUAFitWEk6JxP5RpIJDRrpWKdqy59Z7PSf4y7IWg2hANXxK/iF8
 w/brXLWLQMLM2tE80Qi5/47cfUeXe/nFm9Bl+srQgFi0doRWqiYU9Z5zLonqw==
X-Google-Smtp-Source: AGHT+IEz9ovonmsYBpoI6fqfMXpw473g47hLdzTAb949xDyjPW8tHcPvNQUQBeVwJ4P0LcI+iBJ99g==
X-Received: by 2002:a05:600c:468d:b0:434:feb1:adae with SMTP id
 5b1f17b1804b1-4362aa2e4d7mr34315235e9.3.1734111156282; 
 Fri, 13 Dec 2024 09:32:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/85] target/arm: Convert CRC32, CRC32C to decodetree
Date: Fri, 13 Dec 2024 17:31:08 +0000
Message-Id: <20241213173229.3308926-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  12 ++++
 target/arm/tcg/translate-a64.c | 101 +++++++++++++--------------------
 2 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3db55b78a65..1664f4793c1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -45,7 +45,9 @@
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 
+@rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
+@rrr_s          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=2
 @rrr_d          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=3
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
@@ -663,6 +665,16 @@ LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
 ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
 RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
 
+CRC32           0 00 11010110 ..... 0100 00 ..... ..... @rrr_b
+CRC32           0 00 11010110 ..... 0100 01 ..... ..... @rrr_h
+CRC32           0 00 11010110 ..... 0100 10 ..... ..... @rrr_s
+CRC32           1 00 11010110 ..... 0100 11 ..... ..... @rrr_d
+
+CRC32C          0 00 11010110 ..... 0101 00 ..... ..... @rrr_b
+CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
+CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
+CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8b7ca2c68ad..22594a1149d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7592,6 +7592,39 @@ TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
 TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
 TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
 
+static bool do_crc32(DisasContext *s, arg_rrr_e *a, bool crc32c)
+{
+    TCGv_i64 tcg_acc, tcg_val, tcg_rd;
+    TCGv_i32 tcg_bytes;
+
+    switch (a->esz) {
+    case MO_8:
+    case MO_16:
+    case MO_32:
+        tcg_val = tcg_temp_new_i64();
+        tcg_gen_extract_i64(tcg_val, cpu_reg(s, a->rm), 0, 8 << a->esz);
+        break;
+    case MO_64:
+        tcg_val = cpu_reg(s, a->rm);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_acc = cpu_reg(s, a->rn);
+    tcg_bytes = tcg_constant_i32(1 << a->esz);
+    tcg_rd = cpu_reg(s, a->rd);
+
+    if (crc32c) {
+        gen_helper_crc32c_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
+    } else {
+        gen_helper_crc32_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
+    }
+    return true;
+}
+
+TRANS_FEAT(CRC32, aa64_crc32, do_crc32, a, false)
+TRANS_FEAT(CRC32C, aa64_crc32, do_crc32, a, true)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8473,52 +8506,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* CRC32[BHWX], CRC32C[BHWX] */
-static void handle_crc32(DisasContext *s,
-                         unsigned int sf, unsigned int sz, bool crc32c,
-                         unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_acc, tcg_val;
-    TCGv_i32 tcg_bytes;
-
-    if (!dc_isar_feature(aa64_crc32, s)
-        || (sf == 1 && sz != 3)
-        || (sf == 0 && sz == 3)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (sz == 3) {
-        tcg_val = cpu_reg(s, rm);
-    } else {
-        uint64_t mask;
-        switch (sz) {
-        case 0:
-            mask = 0xFF;
-            break;
-        case 1:
-            mask = 0xFFFF;
-            break;
-        case 2:
-            mask = 0xFFFFFFFF;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        tcg_val = tcg_temp_new_i64();
-        tcg_gen_andi_i64(tcg_val, cpu_reg(s, rm), mask);
-    }
-
-    tcg_acc = cpu_reg(s, rn);
-    tcg_bytes = tcg_constant_i32(1 << sz);
-
-    if (crc32c) {
-        gen_helper_crc32c_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
-    } else {
-        gen_helper_crc32_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
-    }
-}
-
 /* Data-processing (2 source)
  *   31   30  29 28             21 20  16 15    10 9    5 4    0
  * +----+---+---+-----------------+------+--------+------+------+
@@ -8590,20 +8577,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         gen_helper_pacga(cpu_reg(s, rd), tcg_env,
                          cpu_reg(s, rn), cpu_reg_sp(s, rm));
         break;
-    case 16:
-    case 17:
-    case 18:
-    case 19:
-    case 20:
-    case 21:
-    case 22:
-    case 23: /* CRC32 */
-    {
-        int sz = extract32(opcode, 0, 2);
-        bool crc32c = extract32(opcode, 2, 1);
-        handle_crc32(s, sf, sz, crc32c, rm, rn, rd);
-        break;
-    }
     default:
     do_unallocated:
     case 2: /* UDIV */
@@ -8612,6 +8585,14 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 9: /* LSRV */
     case 10: /* ASRV */
     case 11: /* RORV */
+    case 16:
+    case 17:
+    case 18:
+    case 19:
+    case 20:
+    case 21:
+    case 22:
+    case 23: /* CRC32 */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


