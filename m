Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CEFE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9Za-00082o-GS; Thu, 19 Feb 2026 14:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZW-00081e-Na
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZV-0007cF-6T
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so13860145e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528819; x=1772133619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DW4Sqm9now/2mzpdS1Uy9RLM6aBUgmF2xVJR1NJyKY=;
 b=INBBwybjbwHpzc+OOmqCtwBF7fF6llODMVjohz1lA5dIJrWEIDYECO2Ll7FMa6lpwm
 n55Zyvi8/dXZfipiq2z0z/aDMX1ooSbhEyEwp3akBt3+ehZfQUY6sxLIEcULSNo19cH9
 qaR450+rPP+kZaWoqZv0bZI/8kbAJuyBOT/M6Qd4wakF7Ts3Zb5t2Ip3Or2mHASO718c
 6ahJYo7Kn1kqqVOSEauAWS9QLwuLY4iFUUREvNOnkHn91XTQhelWswxv+rHnnPFCN/0Z
 JKp9X0Umbnw2rhiESBuhOtEjVqEe+3YZn0llGcMVtV8H4XKsJJtnEkp4D0lZVAqH0UhF
 0Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528819; x=1772133619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4DW4Sqm9now/2mzpdS1Uy9RLM6aBUgmF2xVJR1NJyKY=;
 b=vNDrIzlgLBHo4tvGLbHQfgRbHpTrJXzJX2n14Lf8i0nj4MWlC9qO4hzpnG8tZgr+4z
 xGVJ6kIWOaIC5ziTy5NGf093gtNKoQveAB+d84TXLvPT0/RpgLsHaZFmFOH+bqgt1AtP
 MRMu7t1v7EWYfg7C/dj5RwudiZzkHy55GpbO3/Wr8dfW9SdIK/rYdN1N322TBg8Td7a3
 QuNhUcU5orYSZmzKA/Kad5GxD9h0ooSEmFpRr8rd0yVV6GrYwUJ5QwZsvR9gt0oGd/Ee
 2/pp2oRd7YGI2SusLeXWT5LKcnWOK0wJeRuPq+sxfDPLrIfIlZbXTqqQBlZn89/oHpZY
 0gkg==
X-Gm-Message-State: AOJu0Yy/KaA6WySeCIEuWPTt7grAdxCw48SqX25xIRgVpkfbDHqSkRTK
 BTO2P8DqSsWK+n6fwmyhZAajbeC2E2RVfwCPoisO46eCsmSyV5DidUAEB9T14ptZ3xwnBOpMPVU
 h66RaZtH0kg==
X-Gm-Gg: AZuq6aIdtUVDuduJODJTJ0HKrQtAkts4kb/9vDbn70ORWPf/dXWj//2h4KG6XnHUp6O
 deSUipYqqkuVIxHFzckwJn1N69d2ItV6gknBgfU24OQywY6fXlQmBjnsDFWtgfnBMgOR3CYUxV+
 29PchpG4YPzOdL4WSZfr+llEdo4W6LAfdtWLg9fpr+y+vqh27mssSwPhvbMeHKjQS/sO4dT6GhT
 xECS7ZgoQ4ji6dR6qJTWMFkseavI5ZHE5OnytSZ3Kz0cJ+UUkmDwgt40zZLJeeoBY6QCLYvwVBq
 VcoONDV9Hm5A8ajYVlfZe1xjOCvCujY1V9yy+NMVnghPA1DUbLx1ateMUR9KLAZult4ajiU93T2
 7ZCrjASmisH8YGRIVHxrLcz+ddtMUjvRiTNwHcOdlA8R/rfbXODwhPDQKp1hXZjNSmzgAQS3MOi
 kElRche18WuvN/SFfcK63joy/xKyszOtvNCZAkG8kUDWqci5HnoGwNwyW6knmUEs42WuVVE6cS
X-Received: by 2002:a05:6000:1a8c:b0:435:8f1b:bb32 with SMTP id
 ffacd0b85a97d-43796aefc5cmr44207122f8f.32.1771528819465; 
 Thu, 19 Feb 2026 11:20:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac92sm50716590f8f.1.2026.02.19.11.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/50] target/i386: Inline GDB_FORCE_64 definition
Date: Thu, 19 Feb 2026 20:19:05 +0100
Message-ID: <20260219191955.83815-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Directly checking TARGET_LONG_BITS allows to remove GDB_FORCE_64.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index be41601cffc..291d56b8e13 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -79,15 +79,9 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
 #define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
 
-#ifdef TARGET_X86_64
-#define GDB_FORCE_64 1
-#else
-#define GDB_FORCE_64 0
-#endif
-
 static int gdb_read_reg_cs64(uint32_t hflags, GByteArray *buf, target_ulong val)
 {
-    if ((hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+    if ((hflags & HF_CS64_MASK) || TARGET_LONG_BITS == 64) {
         return gdb_get_reg64(buf, val);
     }
     return gdb_get_reg32(buf, val);
-- 
2.52.0


