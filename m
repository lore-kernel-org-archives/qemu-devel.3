Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866EDC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ku9-00017m-93; Tue, 22 Apr 2025 17:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktu-0000zL-5I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Kts-0000PP-Cg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so7281633b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356287; x=1745961087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whE4tOIG14eY8JQ2gptqlrplDWnqt4RDL3Ybv6G0d7s=;
 b=oykMgZ7s1+X+Kjk3ivvlrbaeXIPnkM1A3nV8UWePaneAjcdYXX7EUJv/0CoksjwftV
 Wti3XPYY3zoO+28uX7puSI8X3Vlv6+kp8DLZ+tIGpED6S/jFx5EwWoUB1c1FgqqUXZsy
 IWmSX3x17INw2PJXeOeCiaud6JXXkyVVMG5cdOSOdV5Dmt2F8Ys7glXCQy1eLimtc3kg
 mFJACeVqmXFJKV/LdGJoADJuPcGrPCW+l6+iOECRfLLU2e3oJkiBbmXw0ht8abRF+uH6
 iZkQX7Bm8rSJWZzTyKfj5Z0q9E3QtRDm/XvmSeN13Wv33k0FocdkCIxzkco7Pxhzl+gH
 YC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356287; x=1745961087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whE4tOIG14eY8JQ2gptqlrplDWnqt4RDL3Ybv6G0d7s=;
 b=Q9uVcqlXVBqvn26XyYB55DFydMF+xjLiZOymSH+LHcMKMkejvylOUQYWrbfAY1DZNK
 0zgyhfp5OmPoKrxVhCW39DJo2gjVEN+7o9qQ4sEOHQ6y7nEusNu7iic4arnqZzo7r79O
 aewSEvp/RWeN3PdERjmwNXKQ/Z1aAJm0rjI5lZ+FLPp9QrF89qcz8tBM0UW07WUfmMIl
 hE2o3BcuAaV9YXdtuRy7aALZqCqM5sPBuRT06ygXyFNYlleRntBJOziTLrYPpOh4fDoY
 FckRk/UP9XkFOH0IWJJQ9cU+AXKQbIaTsfHcAEccpWGeSAU7HOS3SLo3bkfL1ip2vCDp
 iywA==
X-Gm-Message-State: AOJu0Yx7NKWl2YgcGVlw8BCyjglmO/MVTUaPCbaExMR6rS6QtGloKB+Y
 3MypFlW7nN382IvN7n3r7yDlh0CKGoJEk86pPyY/Dn3sHjYi+ANsQXUMB7GvYwdwmJiMOC7p88r
 I
X-Gm-Gg: ASbGncvbvWtLZqaPgsrAuw4vPZrHt9v7zo+0/W7FYmgfi79j02sXjmxkm2Ja9o4xDyy
 jbEfUNuYHV47I+csDJeIIujxFdFtmvB4RDAsDpt2k+HWZYd8Qhg19ynroS69phX8DOfKoMOjzlY
 pIGoltPnkD6fLkxc3tHFsbbtrfYRxMcgUnGHhmCHY41q+wgAMSucQ1RgeKa8vYHOd0Cj5Si5kIA
 zm4iqao9D3WZN1YY9GQ/1JZxq7LetbSYo6X9ywkBUKxlMgIUXNymUtQQbXIOeO98hlBAsYhn5Mm
 hpS9XKbMbnknZ2p7fs4fc7OGYzXFs/WKYZuvaYjVmFlLXXJTbOWkiAP1jYnOhsCOqz03u74xzBk
 =
X-Google-Smtp-Source: AGHT+IH9qSiAXZcopJmt9Ts2v+OixZtN39YpuSjs2Qqpn+fHwSoz8+AOs8nO8dyXbTccI7nFLEDXVg==
X-Received: by 2002:a05:6a20:158c:b0:1f5:84c8:5d03 with SMTP id
 adf61e73a8af0-203cbc2895cmr28215473637.3.1745356286707; 
 Tue, 22 Apr 2025 14:11:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 2/9] target/avr: Remove OFFSET_CPU_REGISTERS
Date: Tue, 22 Apr 2025 14:11:17 -0700
Message-ID: <20250422211124.305724-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This define isn't really used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h    | 2 --
 target/avr/helper.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 06f5ae4d1b..84a8f5cc8c 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -60,8 +60,6 @@
 #define OFFSET_CODE 0x00000000
 /* CPU registers, IO registers, and SRAM */
 #define OFFSET_DATA 0x00800000
-/* CPU registers specifically, these are mapped at the start of data */
-#define OFFSET_CPU_REGISTERS OFFSET_DATA
 /*
  * IO registers, including status register, stack pointer, and memory
  * mapped peripherals, mapped just after CPU registers
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 3412312ad5..e5bf16c6b7 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -340,8 +340,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
     env->fullacc = false;
 
     /* Following logic assumes this: */
-    assert(OFFSET_CPU_REGISTERS == OFFSET_DATA);
-    assert(OFFSET_IO_REGISTERS == OFFSET_CPU_REGISTERS +
+    assert(OFFSET_IO_REGISTERS == OFFSET_DATA +
                                   NUMBER_OF_CPU_REGISTERS);
 
     if (addr < NUMBER_OF_CPU_REGISTERS) {
-- 
2.43.0


