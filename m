Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C893C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSo-0001qF-6D; Fri, 11 Jul 2025 13:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSl-0001nX-0Y
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:07 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSj-00031e-Dx
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:06 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40b31468da3so742601b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254584; x=1752859384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVx2jKX8CzeoLD3wyy6xeP6kf7orExLEfbHtWwveu1s=;
 b=PfWUrxuMVRVRSNfdpT6g4m+evupNlOzm8bDVsKlPeUg7V5SkeqsMsEBfHJJnnKXWvd
 TXC+n11NNZESiW2/+itufdsEhexH7EYV2b5nLlYpn8AJW1fm6CclAjluojN6tVazStRJ
 mX/1AJ5+usJFg693i9oqYK6et/Req4Rs/Spw9Hpbywo+8M1GR7VdGN4OErJZvjOHtcdw
 vDNv+HRjH7YTqNH3myU9mLntRrNT34AnCiLNf9u7oYC9S3o+1iaQatENKpqf+IRnEblL
 WhJj1btrFO9K/3eIu/COkH9P5P/WB6+djeSC/6Vy4e7MdYVqXhF/ALntnBw/AGBAGH4P
 ng6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254584; x=1752859384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVx2jKX8CzeoLD3wyy6xeP6kf7orExLEfbHtWwveu1s=;
 b=gEL68ENj/K4TCFdMYUCo6RYKQdGKVstOkNPOApbKtCGc3A1Y6dpbIUvZSwTENxw1Tv
 I+yGJJdLS5VfwP9QxknTxtDXtSVIyOjTgsQ6BnY7knm4IbKJfRh14RqC4RyaoAbIJZL/
 PTHwD9yhWpP0TpF9EVMEe/4nl8hLz256hiaBoCaVisAySsoOnH55lcb4Tzs8fPN/dgdF
 QkH+otSnC4JOQt9QTVBECnjUr6uIYBCzhVrXb3d8e7oUaVDbXnlMZnFTycXoq01zzJi/
 QlUR/r/w5APwfH4BdCfCSSQxt6aGRiyNZtOrkIN3pHp277lFCD0p5Y3t8jydE/G/uJd9
 PUOA==
X-Gm-Message-State: AOJu0Yz3sa1CcnXHe7QbcZSMKrAHYT9u1tNqxd5GIIAtdtLiIAJY4bIJ
 oxTEtOBALpfcvK8i2TW1XyRVwnUAThUO3EaTc1vq2Ksk8P093LpAjXprcU/FCBi3JqFldH+93Jy
 CyyX9sC8=
X-Gm-Gg: ASbGnctDxqQ7oTfe5Kx/bJ0VvfZWAaHv2vhK12S2DiD0xaG15mV/eAFlwxvI3qSMaPf
 TOaYC2rWBW2lXW1MUHTSRiI4R4aguMOg+CknHpP9sfY4Qg6fkH7ze5ETsnaptpCy3HgEMk8Ydz5
 OxrDSiWkdm9fZGuRubKsAC2dnLzmmnt+LyVP+rh2VY8ngxKkedfuLDMFyC8VXff5XUi8G6zbia+
 PUcxYmec/kFn6n8bCnx3ZjhX4oPru3IMysO5IYZ0TI8uprVn3W70mY5tGk4svYd+LWeyK8pSghZ
 Qt2PoBlZn+FT3r5YJlXOyM4PuI+bgo3H48IwCiuNXUEezP5WKtgTuXYyYesfvgYDcyWbOQuXwA/
 IjWYoMDn0zS2wyfuj39Z5kjgHLOMnbPQb6COBJ3swreuN2/knigvauH6LvjTTbZJg54Vua4UKYq
 jeGYsb4dF5
X-Google-Smtp-Source: AGHT+IHx6iQNIDyK/HnjodRuXDdYKAXcrjhKyPGcm8Lia4QklcQUe9kuTwYI/JaOJmNjfvMcAVBhuA==
X-Received: by 2002:a05:6808:508d:b0:402:18a1:843f with SMTP id
 5614622812f47-4150f9a7c9amr3236179b6e.32.1752254584061; 
 Fri, 11 Jul 2025 10:23:04 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/9] linux-user/mips/o32: Drop sa_restorer functionality
Date: Fri, 11 Jul 2025 11:22:51 -0600
Message-ID: <20250711172254.229201-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The Linux kernel dropped support for sa_restorer on O32 MIPS in the
release 2.5.48 because it was unused. See the comment in
arch/mips/include/uapi/asm/signal.h.

Applications using the kernels UAPI headers will not reserve enough
space for qemu-user to copy the sigaction.sa_restorer field to.
Unrelated data may be overwritten.

Align qemu-user with the kernel by also dropping sa_restorer support.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250709-mips-sa-restorer-v1-1-fc17120e4afe@t-8ch.de>
---
 linux-user/mips/target_signal.h | 1 -
 linux-user/syscall_defs.h       | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index fa542c1f4e..4481426b99 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -64,7 +64,6 @@ typedef struct target_sigaltstack {
 #define TARGET_SA_NODEFER       0x40000000
 #define TARGET_SA_RESTART       0x10000000
 #define TARGET_SA_RESETHAND     0x80000000
-#define TARGET_SA_RESTORER      0x04000000      /* Only for O32 */
 
 #define TARGET_MINSIGSTKSZ    2048
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5d22759992..df26a2d28f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -515,10 +515,6 @@ struct target_sigaction {
     abi_ulong       _sa_handler;
 #endif
     target_sigset_t sa_mask;
-#ifdef TARGET_ARCH_HAS_SA_RESTORER
-    /* ??? This is always present, but ignored unless O32.  */
-    abi_ulong sa_restorer;
-#endif
 };
 #else
 struct target_old_sigaction {
-- 
2.43.0


