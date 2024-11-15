Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EC2D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8P-0001sc-E4; Fri, 15 Nov 2024 10:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8O-0001ru-1I
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:20 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8M-000467-HQ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so590172f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684076; x=1732288876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnuuZBWq4DxU5k19EAiGN+H/ymSE9dnfe0SjDUoaWnw=;
 b=NKdojp/n8YqKb99tZfKol2/ejbqDVmOXRt6LvJV1E3+O0C4zo96WosMZ6YoWP8HCdG
 1U7KJNH2TZ9ovKzRfi7P+L+MaonTciC7DtXZQvASwObLCP14eVaZV7xoc/QOEFQdNXoa
 OB6GxqdM/AZ31VqZPE1ny9wHAyvPdtE3IyKPSbsWe/J6XcgyKVhuGRaYzCSyIhr8rker
 MSIQsQTld3JUI6ZsnUF3ml68FgKtwpbrCoNYFHPUkJzkUkoAQYPYtJRuP/sdP8tyS8le
 QguEO2mkF6VI0cejgKiY0lL6oOKQ/sqCelW9Ivgcr04AwTUd9+4prRW5klQdkrzlB0+8
 8avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684076; x=1732288876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnuuZBWq4DxU5k19EAiGN+H/ymSE9dnfe0SjDUoaWnw=;
 b=mMunJWBjYI/G4rmFZcxujBQOVVcgXbolgxj4rS/sSs0NssqC8eMVEWW9xl7FHy1Tpq
 7+m8PNvbDz2Z8AwHCIjtbkOxL19db2Uj4pifY2p/ABu7DLZxJy7gEp9poXbmwh+g67/v
 kFsykFDGjc/1HJv1NJJJU362qp4NttdP8YTNPy7YZGg1LhbCC5VKEiWU/HWv9nggslFZ
 nL5XK9pFGAXt0viXyfuNatVQXQDbzRXBwccoj27lwsFpvJstFke4nHKalQdXjiiRtoxQ
 KWo0pWU6sxjs4MMRv2NdaaRlNrcxCUVbhtQZmdoI++Hg+5BvCMk/OpyoGdVNmlXIdI+L
 vuYw==
X-Gm-Message-State: AOJu0YwlUZAmEHTuI1zE/fx42P6v/SAKQfNTyoq8JBljHwi3X2Gpr+On
 tCc3CuPxoZJJZlYZ25FoCeCh42JMso8eo9q9TL5tMOQRQAP2LC+024b3jTfM/nsTn66YJfuDjL3
 0
X-Google-Smtp-Source: AGHT+IHJEK9nrCJnYKqpuOG3J0/aAbqkOzbkrvNzGWjvnnG1Ks0RAKBCfAD4a+3hIIUYR9iwy1i9ZA==
X-Received: by 2002:a5d:598e:0:b0:37c:cee0:96e6 with SMTP id
 ffacd0b85a97d-38225a0d457mr2875097f8f.27.1731684076105; 
 Fri, 15 Nov 2024 07:21:16 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae311fbsm4551060f8f.95.2024.11.15.07.21.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/10] accel/tcg: Ensure frontends define restore_state_to_opc
 handler
Date: Fri, 15 Nov 2024 16:20:47 +0100
Message-ID: <20241115152053.66442-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8163295f34..033f5fab10 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1074,11 +1074,15 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+        assert(tcg_ops->restore_state_to_opc);
 #ifndef CONFIG_USER_ONLY
-        assert(cpu->cc->tcg_ops->cpu_exec_halt);
-        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
+        assert(tcg_ops->cpu_exec_halt);
+        assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
-        cpu->cc->tcg_ops->initialize();
+
+        tcg_ops->initialize();
         tcg_target_initialized = true;
     }
 
-- 
2.45.2


