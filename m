Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD53C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXn-00078O-Q9; Sat, 25 Jan 2025 12:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXU-0006Xn-Fn
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:50 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXS-0000P0-Sb
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:44 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1671438f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824501; x=1738429301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YoTq/Kw8BFNJbd5udCtM6rehNhaZvqVSckhQj9fm84=;
 b=wZy8Owq52mP0TKE0CQlGHjgpraJ2htcoHyJPzXOfMa0W0zyRRN4pxX/NAVDsdeMJ56
 0JIH5aMiRyNjH9EU1CsjwdFuEcQuQ4w17wSM49S3IcbLkhd8jxKuv7t0yDDLJB3PCpmP
 2EEaU8TXlpfMm/DKbRat7tXra2HWpWZjeiWgW6mt2kFZexBAiBh7F6JjO9kz+rEykTX8
 6sNjs0y7ECLV/Ak9paw9FFpvq6iC2g0otCszUVNIav/6pMCiMyLyCCaBOzRgnPF3G6al
 M5JR3Xv0Hwtn5JrGOBLL+cltH0keQnyh9t936gWbL68KJb8yDBsv9xdzrvDCMLQGz8sM
 8VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824501; x=1738429301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YoTq/Kw8BFNJbd5udCtM6rehNhaZvqVSckhQj9fm84=;
 b=mpfTJ/rNl21/V5rU1ZPvPfoaVrHcK2JEScIKJwWYbkwWQk6S60fJSq7T/vA2vpKF8u
 DXf0pygaV9HNcJ+fJfEcgI9LTkrUV1OLUdZZ/fBG+9xLqQKh7Scba7dxz+Zg6Afma3eV
 1wf7D/IF9WWWeFfuZ/BwHi09T7dDmN3cm2DyhXocr/Xvjf3Vzo4DPQhMZoIJdVq6QF9t
 dSVToCOkGEhPJZSxv70hkIa3JPTmx7iBGebJMysit9TKtvk/ZJ1pCkR3HvvzqJJ539+q
 7pTK8T6fsKpdVxFnhHHclGL3kXTqnhlHFVU8wisElX74gTF/a7E4NitAYjRdkDFP2V0R
 Z1zg==
X-Gm-Message-State: AOJu0YxHCCmd79L4KylI6xDDSY/Jmuunim/Ty22rIyGw/Of6y03Uk9dk
 kYrp+UkluKVVhfd9rLL8G/ZvtIl1r8iN5rXCVN8hHQWxCHrU5AlwdKVoHZcxUdgk38iPBRn9zXg
 URug=
X-Gm-Gg: ASbGncslgkijGVYcEb2AedeSLqx30a/fvRLG4fZQvw7HHmoxxvPtCufRBLv1b6/05CX
 uCPwmefqQ612QHf39r83R3hFNf2wi8b0QWeU1x5imIiW6LScWJDYnzuQDVSRRzyw8LzE2OfnslT
 YBZUHVJbyfe6D0Ys+QI7fRfA7ZHH7NNsElx4XVSOcLsaecCS8iYIpI7MNz7M26HBSsJyrCXCWmG
 gJy9JIML298eUYFxfO78J/1pPozZl2e1ty0VrNPnJsGJhYNfTmWNvsgmeOW/SnnwfH0Tf09Tzwt
 k+Rh73vJm5R2Lzl8bX10jsBhtkDxIiHq+8tXuZxy8HTvZZxDT0IOiac=
X-Google-Smtp-Source: AGHT+IEWxtSw0zE9JkzzSMQx9HpaTSX6TtJa/alKuGXiX88iK3wWmB/adB9VTe3FozpMVzw4g+eGKw==
X-Received: by 2002:a05:6000:1faa:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-38bf57c034emr37672164f8f.48.1737824500973; 
 Sat, 25 Jan 2025 09:01:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad92sm5991266f8f.61.2025.01.25.09.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/24] cpus: Introduce SysemuCPUOps::has_work() handler
Date: Sat, 25 Jan 2025 18:01:04 +0100
Message-ID: <20250125170125.32855-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SysemuCPUOps::has_work() is similar to CPUClass::has_work(),
but only exposed on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++++
 include/hw/core/tcg-cpu-ops.h    | 2 +-
 hw/core/cpu-system.c             | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0df5b058f50..dee8a62ca98 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -16,6 +16,10 @@
  * struct SysemuCPUOps: System operations specific to a CPU class
  */
 typedef struct SysemuCPUOps {
+    /**
+     * @has_work: Callback for checking if there is work to do.
+     */
+    bool (*has_work)(CPUState *cpu);
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 2e3f1690f12..f60e5303f21 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -141,7 +141,7 @@ struct TCGCPUOps {
      *
      * This method must be provided. If the target does not need to
      * do anything special for halt, the same function used for its
-     * CPUClass::has_work method can be used here, as they have the
+     * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16d5efee12d..7b16bda2250 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,6 +25,10 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
+    if (cpu->cc->sysemu_ops->has_work) {
+        return cpu->cc->sysemu_ops->has_work(cpu);
+    }
+
     g_assert(cpu->cc->has_work);
     return cpu->cc->has_work(cpu);
 }
-- 
2.47.1


