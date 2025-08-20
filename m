Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524FCA0EF5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojhJ-000455-0Y; Wed, 20 Aug 2025 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojhE-00043U-97
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojh9-0006vK-Hp
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a28ff47a0so20291005e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755699690; x=1756304490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTVEFWP0rG0yPttwcQLTQbA0y7Ht9HpAvtAti5sHVks=;
 b=uCQiJY49HZaiz2unH+D7rtbNcUwYG2WTN8NDWcUbDEe4l2QPc+hBXgSUbiMIuON5AU
 0AcJpqtEkBrvdbeLEXzhblFd2WhONolV1Jkbai+Jz7saW5s3+UvjmqjqDV3TpRe3jQp+
 WYiMBDCh0B8JEIoPi5MxkLrtclbMX9Qb9CMIIapAb5XcQyz05grwSQWN+I4YwRPBBB48
 7iECf21vmA6CFDhNS50Uyuzt9NPraYc2/u6AUMLiliqQUQgqpU0kcvRFHO1H11iBKpho
 oKIQUbyRAPSCJQRswBjxz8POc6Z/64K/9LoU7UadtELCi82B+92m+O1rHBSiypKKmxDc
 89xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755699690; x=1756304490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTVEFWP0rG0yPttwcQLTQbA0y7Ht9HpAvtAti5sHVks=;
 b=scRcwLoecIP2U8YHT0WnEmoyWM3vHTToXiaLowMFLOOjoWTVXBXfPKkBRlTZtcusEs
 r2FtJcn/fAscYIxraCDz4aLPwCkkuSVgh2rQMNeVZCTmB5iKq7ENZF4KceTtUbSP4q08
 JDP//eBLz7bTNlT58ujnWZOQWinI2knjLjSNjvm6jfP3yS/XomAUst3ODF4A4xA3U//E
 mD53JVNU1UVnCm4jN0dDnXYzy5GtZAzC7fWn7dKNfizkGKFxDJeGHAX4CKj34MUQ7u0X
 QNvAEr3/kpggLcEL0rB0fIPoHO/wT5Y8dJpoVme949iZ6F0t1DS9tOqvr2M+TE8UTb0C
 TPYw==
X-Gm-Message-State: AOJu0Yz0gGuBXoaqOXbp3o6qKKOGvzJbxmvuqCC+hqKkEznNiq1ZH8mk
 4hGHmFSq5mACnq3p3hyQ9GWRiy0A5RHqdj0xXOLSkNiTJQz8bH7MtUOFe1/cVepHv/g6/hRfKDm
 suTqP
X-Gm-Gg: ASbGncsoe1T0kIaru9069Zpy0BFCdgxogPbzuu0ESNJrS4XT57w5Ocw59Fg3HrS9018
 mfqGr8vSrPuUJkMS/0OWizraQAuL5afBHs19WIwEIKXanJSkzLjTkItYoDgJvkUjo2iouf2Mjgp
 FkegQ0m/BgQEFXXIMoKrKAjJ6xWwPoxDPiPQe32sStHxX5G1R+HwJnw51p7/KlI3pOzo+z6U44r
 Mw5ut+ZRq7RvagtIblBNZkfzQqEEQyNkrcyZNwByf4Bx7PebGCFosPn/Qn6j16YsG2WBri9pw/c
 APyM02DfnO/FbnGGgs7h9k8qMim/6qCrjenFY0DmPYxrjCU8qsx91ARlo6K0x96SqpifJMfkcTy
 ybuUGTlL7OJYf11eqjo32hBjqa2d+Kz2MO+uZyaXps4MnBMEDv1GD2tSVOtuYkKKRlqgunEXQav
 sjFw==
X-Google-Smtp-Source: AGHT+IEaa/Aa0jQv0ed5wog+TEFIFk2ve/5BZYKXuTmBPUCJwJbl6qn4FYaD6IcswKzNbcoQv9alFA==
X-Received: by 2002:a5d:64e7:0:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3c32d59d143mr2153308f8f.3.1755699689931; 
 Wed, 20 Aug 2025 07:21:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3c85efc57sm1943245f8f.40.2025.08.20.07.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 07:21:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/5] tcg/mips: Check O32/N32/64 ABI definitions actually exist
Date: Wed, 20 Aug 2025 16:21:07 +0200
Message-ID: <20250820142108.46639-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820142108.46639-1-philmd@linaro.org>
References: <20250820142108.46639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Similarly noted in libunwind: https://reviews.llvm.org/D38110#895887,
when _ABIO32 / _ABIN32 / _ABI64 are not defined (like on OpenBSD) we
get:

  [666/1234] Compiling C object libsystem.a.p/tcg_tcg-common.c.o
  In file included from ../tcg/tcg-common.c:26:
  In file included from include/tcg/tcg.h:34:
  tcg/mips/tcg-target-reg-bits.h:10:18: warning: '_ABIO32' is not defined, evaluates to 0 [-Wundef]
  #if _MIPS_SIM == _ABIO32
                   ^
  tcg/mips/tcg-target-reg-bits.h:12:20: warning: '_ABIN32' is not defined, evaluates to 0 [-Wundef]
  #elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
                     ^
  2 warnings generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/mips/tcg-target-reg-bits.h           | 5 +++--
 tcg/mips/tcg-target.c.inc                | 5 +++--
 common-user/host/mips/safe-syscall.inc.S | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
index 56fe0a725e9..a957d2312f3 100644
--- a/tcg/mips/tcg-target-reg-bits.h
+++ b/tcg/mips/tcg-target-reg-bits.h
@@ -7,9 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if _MIPS_SIM == _ABIO32
+#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
 # define TCG_TARGET_REG_BITS 32
-#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
+#elif (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
+       || (defined(_ABI64) && _MIPS_SIM == _ABI64)
 # define TCG_TARGET_REG_BITS 64
 #else
 # error "Unknown ABI"
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 400eafbab4b..5cdaaaa9286 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -26,7 +26,7 @@
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
-#if _MIPS_SIM == _ABIO32
+#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
 # define TCG_TARGET_CALL_STACK_OFFSET 16
 # define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
 # define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
@@ -135,7 +135,8 @@ static const TCGReg tcg_target_call_iarg_regs[] = {
     TCG_REG_A1,
     TCG_REG_A2,
     TCG_REG_A3,
-#if _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
+#if (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
+     || (defined(_ABI64) && _MIPS_SIM == _ABI64)
     TCG_REG_T0,
     TCG_REG_T1,
     TCG_REG_T2,
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips/safe-syscall.inc.S
index 6a446149704..8857d708dae 100644
--- a/common-user/host/mips/safe-syscall.inc.S
+++ b/common-user/host/mips/safe-syscall.inc.S
@@ -30,7 +30,7 @@
          * arguments being syscall arguments (also 'long').
          */
 
-#if _MIPS_SIM == _ABIO32
+#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
 /* 8 * 4 = 32 for outgoing parameters; 1 * 4 for s0 save; 1 * 4 for align. */
 #define FRAME    40
 #define OFS_S0   32
@@ -47,7 +47,7 @@ NESTED(safe_syscall_base, FRAME, ra)
         .cfi_adjust_cfa_offset FRAME
         REG_S   s0, OFS_S0(sp)
         .cfi_rel_offset s0, OFS_S0
-#if _MIPS_SIM == _ABIO32
+#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
         /*
          * The syscall calling convention is nearly the same as C:
          * we enter with a0 == &signal_pending
-- 
2.51.0


