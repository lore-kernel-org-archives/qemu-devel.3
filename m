Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYX-0002Io-7D; Thu, 14 Aug 2025 08:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXY4-0001kt-6I
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:16 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXY1-0004KL-CW
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:15 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32326e66dbaso658941a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176349; x=1755781149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIk54x6Ar31mjPJaW9KswvmHAxIEFie35EtC6Q/lqj0=;
 b=uYSPIyQfp8P732Biz37FbgYE2jb8rY0MjwxbWagudgW16nafQdCKpcs7fC0ZKp3J9n
 4/1Bam2yGc2/gkb+5AukY6SgAVaHZlLBIciamKySXwTzSAI+ssrob9vH+luFwT6pnmBm
 la8/D2arYq2N3J1zIu6CPI7jtNkpfl61uAMFcdb660wuXBOcGeSR7MkaNtTgr8ix2Rcp
 lTBnERhC+gehV29NkxBmYEXOM8Gb8V0ro4OEIXKs5XbwEy6/KnoHQxbcPuA1L1chCUfR
 qfEIZXNoOP6kuHQf42sW5O6a0QYrorHgLSW9kegnoMj38z10ieZ9YXsDbE1PzgSxzb1h
 g84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176349; x=1755781149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIk54x6Ar31mjPJaW9KswvmHAxIEFie35EtC6Q/lqj0=;
 b=xUR+YRM6QUQ8sONZgQUreyIOtkvTAdeLTpNIwNJ0zEbQlbunpHG8YxqUgtppm2kGHj
 5EqMBzPzOd3TyQTXg4AnKStwHPJTd8cdVdSU/MNxh1V6bysgTw6PzY+0YCs8x3iF3hAA
 14z0fXxQYSBHs7J/bfwjW/qykMhBhhCk1Ch7TU3l/Oxb2DV+SQFXzclsshdncnl5D+df
 dw64i0ja74PYttuRkmqhnbx1OFv48I6xOpAa0RuNun/bfZz2O2KQcrsAtyX4NsC4IIRg
 2Z2DqCHMpcsG0HQ+AqdGljEF8onPUv0uUWZTMUK5CVtUnJFU/vrT31nXR1GN8g2hkq2x
 jrNg==
X-Gm-Message-State: AOJu0YzL3YZxyL+hEzzm8p9VkAIC0WbOUPL9geEq4HPLOMNKb2zWNaST
 nlyO2INF1R0NQoVKlLCiHAoTfqp7QOPaYNlbd9DWDFidqH8M5L09itLjqFKIGw/+mo2C3Hdej1L
 2l0QHu0k=
X-Gm-Gg: ASbGncsrwmsD4FjAcWgIVy0e7ym4rdVSCVIKC0ZA5NABTOpgsqfDDL7bihqHUPF9Uw5
 DjFwrxlpyJjtaEiwIgWJ5bRt64+677U6c3ZS5lBwOPXE+cRNfNjF7Pe9+u9Zuz2A6/UhKP2juBH
 nE+LTzIVV7vmamjJFltsZmpk8bY3F8FlBkp1gKdoTyqgC4GWPdEoDG3JuglVypnnZvoAhOVjoLr
 7mNjnFS+Hfd8/dmVToHgZAm479QsJWjSSF2WpWBQWHAhXvokxMOWGArvT9yAixRO0uVzpoSjIpe
 d0vhTq3mnPfGNMLz1cC9+rGnakgVXkb1ufD4UQucGYqR1T50yaHUI6KSexEDKpNkVfBis6Haoi7
 iZ3Ay7Na67kFM0cfLrK6yzDAZn2EqeoqUmSKx7PC1tqH/T+Y=
X-Google-Smtp-Source: AGHT+IH2SrOCJcXzbfqJwesiJLb3orJdB4G6FVXiprlTyjYZ62LJwGuryXI0P0o/jCpZgCnUL/Oxtw==
X-Received: by 2002:a17:90b:2882:b0:321:c9e7:d9ef with SMTP id
 98e67ed59e1d1-32327a3e51cmr5119106a91.21.1755176349165; 
 Thu, 14 Aug 2025 05:59:09 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 21/85] target/arm: Do not migrate env->exception
Date: Thu, 14 Aug 2025 22:56:48 +1000
Message-ID: <20250814125752.164107-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

These are not architectural state, only placeholders
between identifying the exception and delivering it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6986915bee..8dbeca2867 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1085,9 +1085,9 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT64(env.exclusive_val, ARMCPU),
         VMSTATE_UINT64(env.exclusive_high, ARMCPU),
         VMSTATE_UNUSED(sizeof(uint64_t)),
-        VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
-        VMSTATE_UINT32(env.exception.fsr, ARMCPU),
-        VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
+        VMSTATE_UNUSED(sizeof(uint64_t)),
         VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
         VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
         {
-- 
2.43.0


