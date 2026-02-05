Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B14EA7959
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnphR-0002y3-Dj; Wed, 04 Feb 2026 22:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphP-0002xe-Vc
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphO-0001DV-EK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:31 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso396036b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260789; x=1770865589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zN2FSZ+HWZIZRavC3cfAUoOiJ5/G+crgj0rWlDhhdOc=;
 b=T1mmjLV9kthXoMsKjmo8en4xmDRKebEQR+IwcM4pnylI4UvXqW4+UH0amHyBmq/BOA
 AVnUQH+zTHvVW92ZRzZD20/MK8F36UrvGfwlPeQhG2j4qicGAFS9Q0QZh7UQUKqhECC0
 BdvB1c6g2tr092Lgc/s0V5SeWfJF0IDrGLRG1+Oam0cvJpxFLVJBpPP0VGer7H0PwxjP
 oP2yF0URjlEgyXProQ0WOWR9Y2UIM40YmgyDg8FG3AtzLi8UGKJm4262a7oKAjxXqzvd
 EQU5PPQpCteAs7co8HCVQTAfHeuHWPsqeHMfd5FQ2c+6/cjf7XuH+toEn8soxZgxY9TP
 8X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260789; x=1770865589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zN2FSZ+HWZIZRavC3cfAUoOiJ5/G+crgj0rWlDhhdOc=;
 b=jaKDu+BYCCTo+BphRxN4mBQAPwZ5zQ7uaIxgqfw5r1KyIeFBU0Gnt6Vtqybxm+M2da
 64tMz5JuMKorELy24CFQ7s/g3cFY5vfi5zdnREPBqdu+l9i/FnoR39GDPYymym+gxBos
 1KPUPD8B3T8HiPoEy5JiKeqRB43FW1xUcFRsLoFq6IARhdAnOIlHrXxSTG87gfd5V6Pt
 tni0aaPFM6bvjh4PizynZILjuO/Kq87xNoTv8zv9Yfm0OnLftgVIfoJkcNbgQVm9hoQv
 DPR7HkDkg+7BlbLgTsE0EmbkN2hfNheLq1t607UJ4ap4WTPRnGcinok/Pw7MYTcLx7XA
 az/A==
X-Gm-Message-State: AOJu0YxiJ9RCuNufYmQniLGRRXSgrqWe2sUxYurezx9pSYqaBmoq7fGb
 44Ez7ghLP6LGXbwkWgxQcHa17iJ8o7JgrdujXEIDNSOJ7V9Yk+DdsXiGbt7isrQlHrx20DZ4RKR
 K3q5o5Nmf6w==
X-Gm-Gg: AZuq6aKfcVTbmJXoPwdoDxtiVUYSjY/1RtRvO5AC8V5eUfySAHJyTBADxnzX4/RaGo9
 H8gxfE44qyBi9/FHLtfhsOcD/51ktEbTZUvNXUl/H5lPr5iwZ6gMkjcyTX1vmH/fRim+9Qd4JuE
 OHz0BDUtFrtqg0WlBJ89efJQxympmA3N88WSJCfMgbpXr6VzpipAY33hSsbrPG9TaeKP61C3llQ
 2AC8KerecMUwhKzgANjxh60IXe7aG1RISOiiVEBp6R4Eyt5AYW9DZZRyWBvjL+tsR5gBzYdAdwY
 INrYMd1aL+vohbDk6A6Mw3kmie9VXnB6awvZIy+7Bx4TLqI2RemsgKhLsEtlk7qNQgL3xbqhOZo
 RzRPaxYwnU0R9sScVkZQEZAf4eWYVbkgCqh62HWgMxCVLagChHqebKpMC3zE9J6XISTdhOtnvdr
 +78CGV0p1W0/rJkBByLgzS+RpK87R5U/hzQAIblKTkJpH5xfueCdYUo+mZKS2G8w==
X-Received: by 2002:a05:6a00:23d2:b0:81d:f938:800b with SMTP id
 d2e1a72fcca58-8241c683cf6mr5244274b3a.61.1770260788945; 
 Wed, 04 Feb 2026 19:06:28 -0800 (PST)
Received: from stoup.. (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1694c8sm4003544b3a.8.2026.02.04.19.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:06:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target-info: Statically initialize target_arch
Date: Thu,  5 Feb 2026 13:06:17 +1000
Message-ID: <20260205030617.266625-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030617.266625-1-richard.henderson@linaro.org>
References: <20260205030617.266625-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use TARGET_ARCH and token pasting to initialize
target_arch from SYS_EMU_TARGET_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target-info-stub.c | 2 +-
 target-info.c      | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index 8392d81e8f..65220cc782 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -18,7 +18,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = SYS_EMU_TARGET__MAX,
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 5a6d728252..a26532f660 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,13 +24,7 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    SysEmuTarget arch = target_info()->target_arch;
-
-    if (arch == SYS_EMU_TARGET__MAX) {
-        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                               &error_abort);
-    }
-    return arch;
+    return target_info()->target_arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.43.0


