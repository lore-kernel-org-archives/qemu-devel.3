Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D9CC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTuQ-0000eb-Hk; Mon, 10 Feb 2025 08:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTt8-0008Dr-42
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:31:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTt6-00066R-5f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:31:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so29608635e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194306; x=1739799106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMveWtKIlfL6uuWpVkSZWRAB3s97sFlGFregYh5GkmE=;
 b=sK3Ov6hIvUKivO2/Qw2IRa2wLofil2fd8BKLFZyzSL6i6ZbeEjvJCeiA0OjkchDh3g
 2v2nctFqj/AQ8F+ewc6u3TteWi0VtsYhHneheQewAayT6qyQQ/JdR/Do2Ew7sslbLd/6
 9rxKIAWDS09ac7yo9+aHJpui1mMZLBFHb0Q1chh+HWZ+98Rx31z9+hmgADSWlHg/lrPs
 Lgm5De8PO2KLHwJhmBwDC3tFSGqn24R3ReQfagUGABjD9wDTyBEiN4h7XGpx8e0/1G0b
 pD6fhcJxc5Gf04e4qoHNJCrTbsDNUGOdq6LmIf2447CDYFRdy2nUO0lPkW7uTdnEiSkC
 XHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194306; x=1739799106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMveWtKIlfL6uuWpVkSZWRAB3s97sFlGFregYh5GkmE=;
 b=uiTFX0ddESKFCTfoAqmdrI4XxkYF++MK65JJZGGydckhNJ/4MpH5Wf5+K20+eSRNca
 E6tkZS7ISXjTfjv46QInYVW3KeGgF+3b5u7QPr4/9OxuwzVx8pkoLHBldlRdlFqkdclj
 MsWkLw5Hc0SnIwXrU3mZIq2T1ti739/R08rbMz1FvlWwDQ1wBLqapehcKECyHNFGOzU7
 Eo/mt5ahB7syZorWR+Cc0sl41iM1rZ4MPmeGUCMjHeaRB35W4lZ+ogDN7F8fH7U64MSY
 f8GiwR5MYDUUKXcnKioV/cbJ90CMePUsNna5ZfR8AkBJ1ny+z79uX2fpr5yP9PgPJFuZ
 EjHA==
X-Gm-Message-State: AOJu0YyBMQ3vv+teL7B/ZUhiYN6uV9sdWPoPrNxP9My0e7Q5TYU8KHB9
 vtL4NlmFxz8isvqEhQ/n7115Gg89hCvkPK9ejP4yqF/3wQ1Nn59EBBhNkKYCoAJfZJyDiBen8YT
 dENU=
X-Gm-Gg: ASbGncsThbovqnh1Kd0O8m+e14BJ7CXrVEphWDH7dBHy6YzPF0N5OpjHTSo2j/Ypmai
 CO7XBUeuNCupcjqOMa2wUSZ0FnIgBgio60rRZ+Y2MJ5o7jZ/ZX/bH7TCsTO6iKB1+RtINXs1QEm
 X0KSpxyVDFHJ7W2iXrsptCgHvNx7Zgp7N6leHqg+stjj7sHGwAj/f2Y9DWPT606Zk2LlLoamIQY
 dOpy+3SyiLBQiPZKqFglsR8xvwHBvvPwa7P6KXeetmBhWj4T/PiuR6d7MUqsxMc0qeboBGOeow1
 Vd8GV4AV3X8qVjuBZvGDLXRicduImef/66cqVlcmOdv7QexRplaor5kzxTMDoI9jxkrSVkY=
X-Google-Smtp-Source: AGHT+IFM4c6MIvFK1trMtyaxa6PeFUW3m90EoB5X/zpNv8gIHyo5FM6J7nuzDDk25Dzj7tqJfAEN7w==
X-Received: by 2002:adf:ea8e:0:b0:385:f47b:1501 with SMTP id
 ffacd0b85a97d-38dc90f0db9mr8900109f8f.32.1739194306284; 
 Mon, 10 Feb 2025 05:31:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcb88d5e6sm9212643f8f.1.2025.02.10.05.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:31:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/11] target/sparc: Constify SPARCCPUClass::cpu_def
Date: Mon, 10 Feb 2025 14:31:25 +0100
Message-ID: <20250210133134.90879-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dda811503b5..462bcb6c0e6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -574,7 +574,7 @@ struct SPARCCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    sparc_def_t *cpu_def;
+    const sparc_def_t *cpu_def;
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


