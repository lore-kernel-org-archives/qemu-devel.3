Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBAEC25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPG-00030t-36; Sun, 28 Apr 2024 17:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPE-000300-Cw
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:56 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CP9-00015m-3y
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:56 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51967f75763so4438899e87.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340988; x=1714945788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flj95bEjqay534/2K5egl4Am1nZLayMjsiqLpMI/BnA=;
 b=b7kl/U1EuhGPukfW4k3k/JB0LI2qISs1sfTDKAExxXnQKwT9YiFUlExEjCYnEHb65q
 7cHG5Fxqyr51NYDxOm43QU/lYP5IKEd8/s0i/SXOXv8g9uHHh+iA21ZlhFz0gN8vxBSX
 WXwWFagzbXiI+aJXYYT6c+dX6Ht4rEipqvdX5DLG8y37uT7pazh/sjmgd6cLIpSkZSoL
 qtI30tfSzwm+Mz/txpmJnBYrdjRPTS4YvI4GiaXNdCghgjvbuyNYXg8AYORq+IDMfpaK
 I1+CVZtLqbKQl/ReZpH33MdESBW3kMJF7xYz4vVF6EuMwp0o8cXJEyXHXJjL/0LLwh+k
 L5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340988; x=1714945788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flj95bEjqay534/2K5egl4Am1nZLayMjsiqLpMI/BnA=;
 b=Y/L7Yd2iVQpsfFsfIAcrNrKooG8srMU0HvSW9pVHPSxNPwpupR6Jzd8qE5gH1tZI74
 TvjRiM1mQdNi8kv19hkNeFcGShglGfRiq3J8vqoQNj4U6+CD0blLuOXhTIKYA9sk3V8o
 7GQ+QOzgORFRgYAZ1CV5Hx1xdK9PHSMVkDCFcd+5UqJ705dCeu1KadWSRbz5Wh6m/n1Q
 fN5dxVluY8LUT1g5etdeDPLm8oFbA4CIM+X6jIAXDzQ2jsyCF5jD4IYQBxqBoSEqGNlr
 AQJXalZ8YCfD2iCqXSW98TAP0Wz7mwt2qM3kf3rbtnQDiLCZMP0uvBbG0xhJrdP+DJTT
 PaAw==
X-Gm-Message-State: AOJu0Yy0/a0NZRj9t76ICvZQnETuZNCXmbG/SwgTGMK4CFl7mkFVtsqc
 GpPIQ/NUJAEaEGhAw8xE82Z920ROVlpYLlU9F98v8iD+ODc1NqmOkMKdn68EBUp96RW46gvcONL
 A
X-Google-Smtp-Source: AGHT+IHeXZy3OU4szf47JvKCE66PYpGqtqdHaP2ktrcgN2SDcEsuVSEz5vlKtUZMGVeXhF3UPLtikQ==
X-Received: by 2002:a05:6512:3983:b0:518:d5c5:7276 with SMTP id
 j3-20020a056512398300b00518d5c57276mr6934870lfu.58.1714340987787; 
 Sun, 28 Apr 2024 14:49:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 wk14-20020a170907054e00b00a55bd88c98esm8111076ejb.208.2024.04.28.14.49.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/12] exec/cpu: Remove obsolete PAGE_RESERVED definition
Date: Sun, 28 Apr 2024 23:49:08 +0200
Message-ID: <20240428214915.10339-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

We stopped using the PAGE_RESERVED definition in commit
50d25c8aec ("accel/tcg: Drop PAGE_RESERVED for CONFIG_BSD").
This completes commit 2e9a5713f0 ("Remove PAGE_RESERVED").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-7-philmd@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index eaa59a5cc1..5ea8c4d3ef 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,10 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-#if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
-/* FIXME: Code that sets/uses this is broken and needs to go away.  */
-#define PAGE_RESERVED  0x0100
-#endif
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
-- 
2.41.0


