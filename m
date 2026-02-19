Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5A3E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e1-0001m1-QW; Thu, 19 Feb 2026 14:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cm-00069m-2I
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cj-00005c-M1
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso9118865e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529020; x=1772133820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBuLvfP85gCUOH798HTLwu05Ru1+gPxj8663x7rElnw=;
 b=mQ/eElb1Evb4Zl5dquz7Y91TNdc7KbXIlo5Gjbkh9XorJ2TgSraGHoOEsPW8v9hi8m
 4NJI2S/cGn1mX5LTxWOHS0Tw5RrkcAVxVtUp/WH7qRkXYoWfs3E33sYWh4wpJ3JTCwis
 bsOTSxl+GSNCp4EtJ9X41lNwFnAe6pFT18XgpGZoD4f10jjtIbmab7Ls5iYs20LfRBkz
 PjBR80UYPY67P8B9J4xGrbihmfvmme9ZhaOPHCPsSOudCOVC2omGsSv/5yHamntLg6pr
 u88+xRjpi/pEVkUSAubrB83srWuebrFEsU82fUlx1FuV1t5GaoJMaSERWTgzOtzmTf1i
 RwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529020; x=1772133820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jBuLvfP85gCUOH798HTLwu05Ru1+gPxj8663x7rElnw=;
 b=ozskxQgZMryWpGinirQO+jVQJy3/IgpiY8/fWbpcX/uomkyc8U3QOkWOpGOn1lR78v
 +5YmdFZAauJRVyPhcmuaOHGBzEoASgdCtsF5pHQ43mIHcaQiX74qVgnxAQd02s42z6aS
 wR2OWfMrAOIW7yMBrEygYP9v5FMU06QIaUaldjQrPkVeDcNb+tz1ZRpD9Fpqa386gs0h
 tjI8meAnMdylpMRnX+DLADHTG0ye6HHl64JzrlfBo3Yp22Ek+sJokG/prypgwD7eTXtZ
 LMahvaDFAZh2idsF050+mVJ7+2JAE397Vq3GYsmOFFFKbNYQXScq4+EBGS0Ei7f2lADL
 gH3g==
X-Gm-Message-State: AOJu0YzU7996/GqXAHLU2VPkaYm4L855OBZRJrAhUssTIDKkbsevll75
 rUOBU1/rToSxpkfHD2sKfvWk4/WaVuz3JiX2IAn1KFmHRbLX1TJd4LlGeQUV4YEwATRsXkDCrgr
 hm40FWnEf+g==
X-Gm-Gg: AZuq6aJOxgQCgDH16udqtbNWftGwIg81OYJUV65yIFU8SIZSfgi1RZtqJ81tqweLDqv
 U2IJ56hVnuRGfQeVQiTDveq8JsR/aPl7BQ2aXyA5v8Bj4Gi6/S6sg73v94MewDHKSQw/q7hKs86
 EwN8kEvxgJfXkwmg3LBEZMN07nv6w6KQBVRzAUAXPNrIX9+30GWOMs2fHXqQt8CwRUsfR1BPdbS
 6IMZ5AeNGrmdr4FQJO9XrO5qk59MZQdVJminfNohfum7Oi+pEmEChb1c03EqNnZjkzS8YUrK6TP
 Id+WdAxS2GN3jY3PwbP20cmLWE4e4Ueyx3JRQh+2rrnhPRXEwpoY4GyDWTxpNTbHy2dEn+0cNfq
 uaDRVKoLBpDe5lTYBunN3tSuTV6UjhZzFf9ArA2l/xURjhzKuKuRvwRMv843Up8SSJhnqFNCZCo
 RbgJCdNtXIH3zE/NAoX8vQTm8BOnt7JFOsCsL4wa7zL4LSSAwr3KtGM4h4x07H102aX5x4zXeX
X-Received: by 2002:a05:600c:3b22:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-4839fe97501mr47832665e9.8.1771529019675; 
 Thu, 19 Feb 2026 11:23:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c048bsm22220285e9.7.2026.02.19.11.23.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 31/50] gdbstub: Remove ldtul*() macros
Date: Thu, 19 Feb 2026 20:19:33 +0100
Message-ID: <20260219191955.83815-32-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

These macros aren't used anymore, remove them to avoid
further uses creeping back in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 197592036bf..402514716d7 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -104,14 +104,8 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #ifdef COMPILING_PER_TARGET
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
-#define ldtul_p(addr) ldq_p(addr)
-#define ldtul_le_p(addr) ldq_le_p(addr)
-#define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
-#define ldtul_p(addr) ldl_p(addr)
-#define ldtul_le_p(addr) ldl_le_p(addr)
-#define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
 #endif /* COMPILING_PER_TARGET */
 
-- 
2.52.0


