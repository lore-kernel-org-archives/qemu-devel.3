Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46CBC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYe-00031t-Hx; Mon, 21 Jul 2025 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYQ-0001Eb-3r
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYN-0005ML-PC
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso44895355e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104458; x=1753709258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MoEzMO5OHtZV2L/g8fzIdtcYLVWoss+DNtjsQiRyRQs=;
 b=Oy20kCdZm8J2YshLQx5v0BMF7ZW2llUXolOskWqhCH82Yw8mn8s4Au111Pr98N+uDC
 O8a6mAiZF8nMWSywD3Eej7KWEM8UYdqQW6VB3n+kpIay21gi7oiZafdeLRMmGyeSqSqv
 6Lu5494oPeMIiAPy1DJf7IHthsJqPdb4qhratpQqYp/6ytHWyzW6zG+14fgD2T9ZW8Ko
 i7nNIUrmE4Q+5UkLW6HQGOP0wEDJc3viDOWDac8t9DDni3wsWUP2Y8QUcNwObqmFveAz
 cJpvShld+owJWL40e7SL8/rGe60RGp6tLokfO/a/rkoZoYlqOXO4sDILDSyYKcGkw82+
 RINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104458; x=1753709258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoEzMO5OHtZV2L/g8fzIdtcYLVWoss+DNtjsQiRyRQs=;
 b=S94GZXKmdSQr6IiAVmHsFo3fQ39nqliJxCT55ASDKTX//bIjDYMGOe35k91tqgGxiH
 d2qsALwuiZAG2jmlUhKQK2aglweXN12cUs/Sih6p55xpXHrUPtIeSZSOUPvRTBnD1Vm6
 Qyxi7SAIe/wIQw5wBJxK2E/nqZ9nKtbGzr3De+/ulOL9NdhbkOOTt4A2O7/Rx/t2GGBC
 XEfbJ+hJ91gr8zXJjZVhC2/p958pUPuimLPYmf0UFXKCjxNQWwh36d3hkGzt2rwPMcD+
 L5k9NmYXBy5Ho1LKzyZB5L7g3pzNd01i+OgTIbRQKF697GCGdp2aZdbx8XARmC2OWIe7
 V93g==
X-Gm-Message-State: AOJu0YyYsXoGIJPRC6qeQGG5d5c1wMfUEVtayl1bV4I7rvDSsfl2+kML
 iMFpuzYVcpoACoLYiX/5R0jnXEwlL5pgSVCal+ONIOuRbKRk5CLcmt98KvDMXvLujsmpSLhMIZ5
 Q3xg9
X-Gm-Gg: ASbGncs69l7w3/WAtPJwsK3tZQ7brvEyaV1YyQdv+RDQsstZpVfndW/68Nsk3xaozJq
 BHY6mSCL73XiA8VWNyc6tJ2yodp7ES4YSX2rZBxjTmHgTBH4+VJV2Z27Twu7Zosb+n+8z8/Rd63
 165mwFq25C/4pOY02X6XdP5vuteohAZMpPKqFMeZzkJqsuh8yklYpD8k7CQqE22MNIAw6wVUEFc
 Tm4kz88DNUy7+9623dwLV4inMitj0L3dAJ1CROowdCz4PBp/74yLfd2teh7F080ZLlTqy5rM7II
 ci0eaOtpO26llsPb2xT0my2E3SzEi4qSprZ5QYEjsnlzwydQEymUk7vFIsmWYtofGoQvxVPzYqx
 tMU5EYPkmdpVgHuxyXNGYKsbqphuP
X-Google-Smtp-Source: AGHT+IFdX5qa83gHMJcfCjiFYZyaz5s3Z73OVOGGqilYtTbZONjIA+wsh6Z7nZzYIoYgnvscrONAAg==
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id
 5b1f17b1804b1-4562e390d79mr209817725e9.15.1753104457889; 
 Mon, 21 Jul 2025 06:27:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
Date: Mon, 21 Jul 2025 14:27:16 +0100
Message-ID: <20250721132718.2835729-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
by implementing emulation for a few system registers. ICC_RPR_EL1 was
defined but not plugged in the sysreg handlers (for no good reason).

Fix it.

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250714160139.10404-3-zenghui.yu@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 861657df966..bd6b5d11de8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1361,6 +1361,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
@@ -1678,6 +1679,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
-- 
2.43.0


