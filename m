Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDBFE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSP-0000bI-3E; Wed, 11 Dec 2024 11:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSN-0000aF-3A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSL-0007nE-G1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so77595415e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934055; x=1734538855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4qjVm9wsFk96NgmHYl7UvnBuTY0x8lduv0VcruWM9xQ=;
 b=qDeQ7qr+7szISgsljrDUW5V9BUyHehs6fu4XIL10gfVAQ/j41mVyH0tdobXK10MjKF
 ouMT/m0es+6IV22jilnVZfx46BUObRXxIsABCxic7aZ+UkC0IxjZtShJ0XbZSuN2wKIO
 iXUYTxNYk8hOFo91C4Yx82EELQrqqGNq6NtOf7faHj1dzU1R8gmDD6lpPLxY6dw+BHtl
 YbDsjt4BWDhN+S70hZIFwxNu5Ctt3HGNjuheI8eEGrzFd781+goGgmfahYiKUc2f7bVU
 pZa8YSBXehcfLz004sxHJdnYY3EbyV3HRWA0E37pRGuSGchgjPk3MHp9G/ma1rO03/Yp
 4qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934055; x=1734538855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qjVm9wsFk96NgmHYl7UvnBuTY0x8lduv0VcruWM9xQ=;
 b=EUQru39h8F54A75g8HJJbfiq92u3lznfWMdeo6qInfvPA9kgC0ydanWtR8ddlzfYhu
 HY6RfQC/CoYjS2pjHrohxNaX3BA46muuqFenafvUCsURRYyTNTkiTIQYNvyokG8F1QOk
 5J3Z0slok2LDX43JrZXo8P2RuBfxyTzmwdBZRAkthS4QTNYXl6yfEaYHzGGiovH4X/XU
 P0o5/yNhg5HcDMP50/ycJuH4kYOu/zGvwwUHG8sqV5PZHhokWEjTf/N+/Cou9icPYFZ/
 pxuk0IhoKF/QnRUiTKbghh8NyC6IbxBkgChfMbfUPHLFTkclIVF4u4kdq4Q4vgfWU4+i
 dN/w==
X-Gm-Message-State: AOJu0YzA69dBLm8E9r3/zQrRVZwePHOeLaE3goTQh5XHJ8BdKBJMKJrw
 IAYEuyaB2sboQpXqx5S7iK4eHDplTzE+LlOPc9mfi9PtUIYUnpcX7WoTlIR/yEiIVWSORujQbgR
 h
X-Gm-Gg: ASbGncvbc6lPs9sizFYGOJqOCS+2daCiB8bYGse7MHtHkWy/uM8R5YaFvwDIyL4UWQq
 mUpyUbMq//S7MFuvtvWqVe1bb5021i82Yv2456oOXfmrkNSOwv9IBUiH7sEX54FgvTRkGRc9trE
 z/8VAqQjRaZjEYFypdu/xgnwq0H33AyFrczxKoMOhyPxLUVQlUutADFJt2tHaoPc03k0ua8DUZT
 Cw1z5XehPF7l1IpUnkP6Fi2iI8/5rG7fbfhhB3H7NaBqzMzDZ2/wZ7DV4tR
X-Google-Smtp-Source: AGHT+IEvyWoj17AR9rExSz9MHUgdCKYjEHMcjnmVfcBjxquXXLrBHPdhfoNEx5FBahj9KaLVf6SeZw==
X-Received: by 2002:a05:600c:35c9:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-4361c3c500amr34819145e9.15.1733934055585; 
 Wed, 11 Dec 2024 08:20:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/72] target/microblaze: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:34 +0000
Message-Id: <20241211162004.2795499-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-37-peter.maydell@linaro.org
---
 target/microblaze/cpu.c        | 2 ++
 fpu/softfloat-specialize.c.inc | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c1..0e1e22d1e8e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
      * this architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN: sign bit set, most significant frac bit set */
+    set_float_default_nan_pattern(0b11000000, &env->fp_status);
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b1ec534983c..d77404f0c47 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,8 +139,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_I386) || defined(TARGET_X86_64)    \
-    || defined(TARGET_MICROBLAZE)
+#elif defined(TARGET_I386) || defined(TARGET_X86_64)
         /* Sign bit set, most significant frac bit set */
         dnan_pattern = 0b11000000;
 #elif defined(TARGET_HPPA)
-- 
2.34.1


