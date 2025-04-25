Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873F7C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0j-0007Eo-9q; Fri, 25 Apr 2025 17:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0f-0007Cn-BT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0c-0000ID-2A
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736a72220edso2826925b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618096; x=1746222896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ49qOggxaOALZDDdCCbdOb8Gq8YmHGfvvakgW39fM8=;
 b=cTRXWon8vVWyS+dSzwBy5jHQ1zDCbDjdeKIRssqeNq4mK6cYlzS7TNMZjddv8U3uA9
 /gv8fMLhFiXSLSuz61hd7iw9mU/5l5N9vBLL5FR+GFVs6oU5KPmEI5vJj2oSE7ioSxra
 vBLOd4taX7JInkKirqpXNuvm52K7Oz27kTo18+3Ubzeh+5aTYw5DxDX0/LxxZDcbH8dG
 HfeCXDSvbO/Iw5T6lTIsjeAz1NoktM178fh74n40N+Z/e2Nvcq6hfdZRtFd2/WdCYMcu
 NXJp1vRRErELIgU16gnNO9Owx4C/LFTN5nMW7JGhkpTCnRnaZ5IEyov1rfMNxF4JYXts
 aukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618096; x=1746222896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ49qOggxaOALZDDdCCbdOb8Gq8YmHGfvvakgW39fM8=;
 b=JhBFvMua0Oh0rNt4Je1y4qB38deu4IpNUqHvEYUOQT4jd1cRBjBhUV3pcgf6LMKaXC
 zMqsG9jcL1OM4n3Gc0GDo+yJinTdRjGjw5bsnvVLFRRLWgby8DiSiPznmGa38EoBlTYk
 7LLfDBALC7IwlpVw5d2OndpCRfygnTOxJ2Uqnedz0Clk9qpbkHbQDPZQ+dEeYeBc51rw
 7I1A7Lja0/1iP40oZPYg1/InHdgth8FvV6Oy6TAFTuC1j47MZcbCD2iDChvN71KDVUZF
 ksvsK1zynbIU8SZGozve8COqpjABXBiit4vY0ht+DtMil3BvGaFozB6FeL3SKZqvg0m6
 mV6A==
X-Gm-Message-State: AOJu0Yx4RGLqRa1+3Ad6huLDnFswVTZr6SQVkUGIq3wXdMuVtjZTqM2N
 FasfOBHREef3A0+V6MFEQoXKDzhagS7F895VkBbq9ZdsNCpzwds56mN2txv09mEss+wtw8I3vfN
 A
X-Gm-Gg: ASbGncukjUYgcngBAN7L10IMq6DlIP9A2NinNzw2mWyqdOcyAgbzBUeTWbfsFVVDEOw
 PCYHo3WCeWGkCQOyiNW1SK9gcDtHw+gwKjKoJZDZKedyF4XbQDCn2+gTv9XrKAi/XVdBYrj3q/q
 bRMBFpC1ULBUNKqhs8zYelXMFhzXGpKCrBZh0wM+A7tyVCZzwD8BcRibrSK8wiPVOzoB9kGPihM
 H2lWW0qWFMfxLbzIcz5Rvl59UBK8UPy0c46RbvfiScqf22u4P5OMJ3hqcS//poT9lbZdOCH8JFE
 U6n3YKVsGJttFFBbj+QAMVa87SNWXcXXeEWAYtFb7QlGWQpl6M2zHRTviPG2UkvIt4ywgvm6EDa
 G6AtpMFh3Ow==
X-Google-Smtp-Source: AGHT+IFvRoutYGHp3ByYkJo6r/sq3rrzy0R9Cey7CucyA5bRhJfU1v7sd+gM3G2Dc/baBZ/wGoK+hg==
X-Received: by 2002:a05:6a00:2382:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-73fd6fdd3aemr4716462b3a.6.1745618096351; 
 Fri, 25 Apr 2025 14:54:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 002/159] tcg/loongarch64: Improve constraints for
 TCG_CT_CONST_VCMP
Date: Fri, 25 Apr 2025 14:52:16 -0700
Message-ID: <20250425215454.886111-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Use the TCGCond given to tcg_target_const_match to exactly match
the supported constant.  Adjust the code generation to assume this
has been done -- recall that encode_*_insn contain assertions that
the constants are valid.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 38 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 740b7c264d..879f66f255 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -213,8 +213,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
     if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
         int64_t vec_val = sextract64(val, 0, 8 << vece);
-        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-            return true;
+        if (ct & TCG_CT_CONST_VCMP) {
+            switch (cond) {
+            case TCG_COND_EQ:
+            case TCG_COND_LE:
+            case TCG_COND_LT:
+                return -0x10 <= vec_val && vec_val <= 0x0f;
+            case TCG_COND_LEU:
+            case TCG_COND_LTU:
+                return 0x00 <= vec_val && vec_val <= 0x1f;
+            default:
+                return false;
+            }
         }
         if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
             return true;
@@ -2029,28 +2039,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                  * Try vseqi/vslei/vslti
                  */
                 int64_t value = sextract64(a2, 0, 8 << vece);
-                if ((cond == TCG_COND_EQ ||
-                     cond == TCG_COND_LE ||
-                     cond == TCG_COND_LT) &&
-                    (-0x10 <= value && value <= 0x0f)) {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LT:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
                     break;
-                } else if ((cond == TCG_COND_LEU ||
-                            cond == TCG_COND_LTU) &&
-                           (0x00 <= value && value <= 0x1f)) {
+                case TCG_COND_LEU:
+                case TCG_COND_LTU:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
                     break;
+                default:
+                    g_assert_not_reached();
                 }
-
-                /*
-                 * Fallback to:
-                 * dupi_vec temp, a2
-                 * cmp_vec a0, a1, temp, cond
-                 */
-                tcg_out_dupi_vec(s, type, vece, TCG_VEC_TMP0, a2);
-                a2 = TCG_VEC_TMP0;
+                break;
             }
 
             insn = cmp_vec_insn[cond][lasx][vece];
-- 
2.43.0


