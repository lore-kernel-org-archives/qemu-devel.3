Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA0E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9ZY-0006Yh-HM; Fri, 13 Dec 2024 12:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xl-0007qj-Bn
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xj-0001gm-MW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1477481f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111214; x=1734716014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yw8Z6Ug2TOPFOe+QLKdpRyCukCn8vbWCtqZg4s/IelY=;
 b=K+w0xqNhe3p2PBQTRwt6CUC1/h8zrXVsEZ2kMpvtqvALbX4hCXLQQxdgoCq80Vj33z
 4xPt32tBLr+ikazfHGDbZ3Eh+pavaHh1s7QS5Nioh5YKE9oGQmrUIuGFv/W04CIs8GL0
 ZBsQ1AHZlKQv+Udv0wl6DRL+3ydoBnBCVkbJJUjjYQ5GozB1psS17pwyoqbxWZKp6vjy
 zpQLa1KZMSMWULLwSN7o0uyWKZH56ceDWTEjz0yDTeSn9Ua+1FK1pllc15VzHwPJlb0k
 cju0pn9YA9+rjelKTPsKJTFOTpoStE1TK4BO7iW3XPs/UQdoK7He9wsyehM2a3QyknMN
 KE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111214; x=1734716014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw8Z6Ug2TOPFOe+QLKdpRyCukCn8vbWCtqZg4s/IelY=;
 b=WhQv24RrD4217kEu2JgXGwIaa36ZWPykMal2/CX4ED780vo3wG29jn13Xcic6X/kCE
 f4T+fmGlmH0E+i/WkDRH4mg+rDXuYX8oUYWmFg3U2mE2jDGbX5ZL+NfTnZqUqyHGBj9X
 LAQD7+Ajb0FiRfqJSzUgViT8KXHddiIRdUK8beUgIr1dpUT+Dg5RuZG0fWmrWgMSBEFF
 pbGGVGWGHdRdUm1gts8IJDS1uCRjj+LvxZDceh9/78sfG6KFujxMCq1DEbciXCVlqOAB
 Ye6yIkTrBYCGbtF9ZAANwZtJ7iC+FW5KornN9Q4TutAXcVHjpLu2Zus1XVuXPAIfeekN
 3m3g==
X-Gm-Message-State: AOJu0Yz+iuCMoppKij2LwEI+FakmcfV5cCQWqJoar3j6PpDPlPhaj5Rk
 VenZwD9gFIAK8qgp/sx6t4BRtUWFiZJdWsGkSsbytzAfGK+bszDWalGrKtSsyx9zNB847B0aXwT
 p
X-Gm-Gg: ASbGncsqQNtEs4MiBxdZpc5IrTabRTIh2WTeSbvsbt8nQXaPidK9Mw2atqT4vwwrCXk
 YkbtvH/B0UnUPiu6LiTaRPpE5PeFjs7kKMc4eeJJQkcAYDODVF52FzvaxNdgYeP2iL8s0Ly50KM
 fZ0IFl6pt0BQ4IXoZ1JI2izpyrB6cptj0epQCTvpkEzT/tmJXYTM2zPna9BC7aMIFje+dyEI3zF
 gYKABxQ5VUmuQ0wTSh35O5fzWF2BdjC6JfDphJI9b6MdCfzDTTgKytcrqy33A==
X-Google-Smtp-Source: AGHT+IHN0etClYf4tkn6BDVph3IW6Otp20WWL4+alUfSPF3+ZaZrxpMrwFkNpwkN7M/QSI/6YAOCMg==
X-Received: by 2002:a05:6000:1842:b0:386:37bb:ddc1 with SMTP id
 ffacd0b85a97d-3888e0c1863mr2609674f8f.56.1734111214238; 
 Fri, 13 Dec 2024 09:33:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/85] target/arm: Convert [US]CVTF (vector,
 integer) scalar to decodetree
Date: Fri, 13 Dec 2024 17:32:03 +0000
Message-Id: <20241213173229.3308926-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-60-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++++
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f66f62da4f0..146500d9c4b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1657,6 +1657,12 @@ FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=%esz_sd shift=0
 
+SCVTF_f         0101 1110 011 11001 11011 0 ..... .....     @icvt_h
+SCVTF_f         0101 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
+UCVTF_f         0111 1110 011 11001 11011 0 ..... .....     @icvt_h
+UCVTF_f         0111 1110 0.1 00001 11011 0 ..... .....     @icvt_sd
+
 FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
 FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
 FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 894befef4dc..6e9d040ebfb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8599,6 +8599,29 @@ static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 TRANS(SCVTF_g, do_cvtf_g, a, true)
 TRANS(UCVTF_g, do_cvtf_g, a, false)
 
+/*
+ * [US]CVTF (vector), scalar version.
+ * Which sounds weird, but really just means input from fp register
+ * instead of input from general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN : 0));
+    return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
+}
+
+TRANS(SCVTF_f, do_cvtf_f, a, true)
+TRANS(UCVTF_f, do_cvtf_f, a, false)
+
 static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                            TCGv_i64 tcg_out, int shift, int rn,
                            ARMFPRounding rmode)
@@ -9838,16 +9861,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x6d: /* FCMLE (zero) */
             handle_2misc_fcmp_zero(s, opcode, true, u, true, size, rn, rd);
             return;
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        {
-            bool is_signed = (opcode == 0x1d);
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_simd_intfp_conv(s, rd, rn, 1, is_signed, 0, size);
-            return;
-        }
         case 0x3d: /* FRECPE */
         case 0x3f: /* FRECPX */
         case 0x7d: /* FRSQRTE */
@@ -9867,6 +9880,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x1d: /* SCVTF */
+        case 0x5d: /* UCVTF */
         default:
             unallocated_encoding(s);
             return;
-- 
2.34.1


