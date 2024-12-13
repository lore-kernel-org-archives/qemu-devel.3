Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440D2E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2G-00033r-Cj; Fri, 13 Dec 2024 14:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1q-0002WJ-PB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:57 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1o-0006Z2-C3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:46 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f32de85789so388683eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116922; x=1734721722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2fQ0c2NIl1a5M4AWrVbc1wnQ6w0xGGZJojz6lR1rxs=;
 b=Sb6zc0JXs+KIhkH1aS4E3/gDPfzoS+AIUWKNFFubhsxCSW2En1bxKArLMke7cDvivQ
 uLdjrF+6pu0Megh5X/hw2dO3voMALcF0o1P6NbE8WryhSITPyy+OAE8MImSiVkO1qjPO
 kXn8DIO8hxgy6NpUWm0bI6+PtOrTYvKRZJq0oKb7Lhy6ora/ou1WJJwRuTKVUpccvXPU
 HpUqcKirLOwYP+auGU24jz/aa4yukx4/ZT1Bt4jHuOC8A0LeoCmBxtOc5tIyo135oT+f
 rReEiJ+D7iCp2dvhpmvxrEqGjyN6akhbfIhqUlJgA4978+TCE0pjQMxiUe9I1kEYN3yz
 QZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116922; x=1734721722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2fQ0c2NIl1a5M4AWrVbc1wnQ6w0xGGZJojz6lR1rxs=;
 b=L6Chaxn+RCttUKyTklitpaEAeaHJSsQhP16x10VKV0+RGCjOfHvyjTKXn8IJ74yF2D
 PT1ITjyoruLBiAfD+Jmf+9gTSZl4pngjCoU/W2Pb8eENZ6b1WvNP2wW5qAl5794l+6oc
 Ft8N+v0wi8xCgDIz/vR7Va7kZi84jx0fk3H8ZxYq8RzNzTyURIBAhxRGnEH9rrd983oC
 NB+BOIMkA1oe3kSAjDdH2mi2JuVs7lNMTRvZzCVF7I1RVBfCY++98XZfv1d6qtKD6X0m
 htj699z+34BkYuSQGxHDU0KxgvE9oHO65a3vkPFFgV07357028e9aG49kwajs5uSTQh+
 xvZg==
X-Gm-Message-State: AOJu0YxjWS9a3A7Kjcw1ZYZ1tndx/oW2A7Pg3pP5D/4Gld0tckiQCwjT
 e9xVNLokblM/vS8iexG1ClMH+VECdUDV+iExEdyPhN8psoyfxTtWPdXrzmcii4YZOJtWPl7eL0/
 NJTliL6cw
X-Gm-Gg: ASbGncuyLkdeXtToLFx4RLSpX1ELZ9TWPl8XNmZKNfYTFwdUudYbE6TzccEsqNFPY2F
 eb6kxhBs0yPbs8hxEfe9WdcMi6ipMZ4Ziwr3B1HzN2WQhfN17CEUQIZfqUQNfYgU/qaHBOoyzj3
 DBcevvP0YJtYMcMuUOh7w7ZFh0gdoz663BqGKt55SeNvKJUI1vRQKA5I/5xlF+VRaJzCwTQS3AK
 BAAKAbMmFfSL/Xegb69a5LGTNUf33qSVlx5IPOM05XLqXorL2K67LY1eHL/Fi9/
X-Google-Smtp-Source: AGHT+IHFh5nZ6gfgOuQi1f3wGPHIYnmSqtkPH0+wClGwyk8K4HQ4zySmO44hh40IMohvguE+kSoRCw==
X-Received: by 2002:a05:6820:2787:b0:5f2:c5e0:453f with SMTP id
 006d021491bc7-5f32b33c095mr1790797eaf.4.1734116922618; 
 Fri, 13 Dec 2024 11:08:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/71] cpu-target: Constify all Property
Date: Fri, 13 Dec 2024 13:06:45 -0600
Message-ID: <20241213190750.2513964-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index 499facf774..2ae07a779e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -183,7 +183,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
  * This can't go in hw/core/cpu.c because that file is compiled only
  * once for both user-mode and system builds.
  */
-static Property cpu_common_props[] = {
+static const Property cpu_common_props[] = {
 #ifdef CONFIG_USER_ONLY
     /*
      * Create a property for the user-only object, so users can
-- 
2.43.0


