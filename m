Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2588DC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1C-0002fh-S6; Fri, 25 Apr 2025 11:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0S-0001Ph-Jo
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0Q-0003sc-IE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so2393896f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595020; x=1746199820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tdaCutKNbWjwRJoEcpP09xW3NZqg9gznU+SDrDZ8GM=;
 b=oqxobJKBn6xb5HPisWXjC8x5jkTHqf1nDM7jDUomMNo7o25zfkS/jIL4bkZBaBT+IJ
 n4d+eSpiMnFgaS3AthNH2WWU5mofLjWlJYOAv8mLG5XRAlgsYW1c5LCd7RtKgafnRjdN
 QJ5KKIaBcSXqckB0ec9BmTaCOLaTEjhPsRRqtiaIZIvaYmhM6Cga1MFjh4WZmMYUx5bJ
 VEfoL1A7EW4dfiN7Goq3RfNNyBP/Og3LjIGaLg88XtviF7UDGKNFJtmTfcWAjY023xxM
 VcpjjgjKeoEMaBUd9KwUbvDObzLS5pPiJ9z2YjivJOvtgrGawZKbbTShRNUXkrecBJZe
 ntWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595020; x=1746199820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tdaCutKNbWjwRJoEcpP09xW3NZqg9gznU+SDrDZ8GM=;
 b=jR1U2NFOn9ZN0S+Z4OD0ptObuZKlf3QombDF8t36eQWpKuCwhDipNnFoK/YciYZgZy
 xcuRh2O0c53y3YA+GIuLMyMQGqB7CUoPEr9aISr6DxkfYgu4DEDi5KWPg+Cb7xOl/332
 PE3B5GeDVlBXX2/+itGmp9T6LhLZoxk43ufqlCEVK2xmQaeB2tobSprRAOKw7BvYA0Pq
 EOHanIx4VKmXd7XDOeLl3NKS5R3tTE0Ndwm+3vJZ2M1cW9xOPFQh98NNnRwg/523HrJj
 nPRUZ4XmqkxEP8/ON8SD4MAf2OxdS6EbSIXY5GzPgxG9bssl54wZv2E2AT1u+6qXYAce
 ofIg==
X-Gm-Message-State: AOJu0Ywu//MyKTGms4tMqNQ3oSo7g76oM8p9Zaom3WWumrhsJfyD7w+2
 1FAaitzEmOaLOCFuO0C/9B/XBaIigEJvZRzxbeewcWxuJvkUGynIO0yZrAqhv/Z8N5GAMePQd2t
 7
X-Gm-Gg: ASbGncunlKtTLVfv6V2bolbkz886Qush1o00CWYcxdI7h5rgpKy2P/0SxqzY9k8WupY
 p0NaJG/+GaBaCk/8RMb2MJSdHjZzgiMxX7FiLmD5cw9dvlNm+o0BGcPKwGoPJ+yEWF142GEHNl6
 S8uEJ97L4xjJ89kb19KPa4E/90qxc9Fgpjou3/C/hpKziZEnSDorHzLUHgnxwj67V9u7qZO/eeh
 KZfxWyFX5yzNhzOZSaV7BY/kbDkPpsENviVQBFyP148W+dXk0rf/y3HmUhzPqUTj6ydy0GYLMCb
 zpVhUwunAkb045K9VfrIScw5qdDAw038NnKZvlDe9g8UeJse0h4zvolGgDFlHdI06sl42RwjKOp
 8a3srnGdsDWyvHmo=
X-Google-Smtp-Source: AGHT+IFKaTfq4TzRSTnWwOKFip/CyFeLU5gtWkVvWjGOazF4hDoxMmhtYqC8fvGXPa7zUuwHNQtbGg==
X-Received: by 2002:a05:6000:430d:b0:399:7f43:b3a4 with SMTP id
 ffacd0b85a97d-3a074e2f3b3mr2232479f8f.24.1745595019708; 
 Fri, 25 Apr 2025 08:30:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccf44csm2715073f8f.60.2025.04.25.08.30.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/58] hw/core/cpu: gdb_arch_name string should not be freed
Date: Fri, 25 Apr 2025 17:28:03 +0200
Message-ID: <20250425152843.69638-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The documentation for the CPUClass::gdb_arch_name method claims that
the returned string should be freed with g_free().  This is not
correct: in commit a650683871ba728 we changed this method to
instead return a simple constant string, but forgot to update
the documentation.

Make the documentation match the new semantics.

Fixes: a650683871ba728 ("hw/core/cpu: Return static value with gdb_arch_name()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250317142819.900029-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b645df59f5..6ea246514ea 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -134,7 +134,8 @@ struct SysemuCPUOps;
  * @gdb_stop_before_watchpoint: Indicates whether GDB expects the CPU to stop
  *           before the insn which triggers a watchpoint rather than after it.
  * @gdb_arch_name: Optional callback that returns the architecture name known
- * to GDB. The caller must free the returned string with g_free.
+ * to GDB. The returned value is expected to be a simple constant string:
+ * the caller will not g_free() it.
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
-- 
2.47.1


