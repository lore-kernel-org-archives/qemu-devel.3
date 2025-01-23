Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D83C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5BV-0004pQ-DD; Thu, 23 Jan 2025 16:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BT-0004os-C6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5BR-0002iJ-Uf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1388581f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669376; x=1738274176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycsjGlBlHbu4fIwJ8eBiUHF+eH/dzlIjpqCh9RpatQY=;
 b=V1XoC5FmU/XuUuuVeZ9X439SJzKMH2/jz8q+RQPCzJ0EPjc1zSxWVphbZ9futE/Iqe
 lKYLUyz/CZvG3eBAc6AQIz/3Oldn/olEeovF9KZzNK7WUNY4XSBGRHmqszolDsxHsp2z
 JRZLPioTH1MZqh4sW5nu1Rk8VqBhtNrxVGJTLedwM1P36JtegCSy2zooDCOkK11AVVo7
 m7LqbVF7EBMXA14Yczmy+D0x1TcPXU0T0mOn+WSV+dC3Ry17hhXEwH6Bu0w0UzD0a2E7
 HOjwmcqR4txMLctz1z4zbszFtsMgY2zZbXVW90plXoCUOymaj3+eY/f/hPeFNUMozwK2
 76pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669376; x=1738274176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycsjGlBlHbu4fIwJ8eBiUHF+eH/dzlIjpqCh9RpatQY=;
 b=wWHfarM2uUnOtXo2+OStyDxwz96e/YdbxMzzih8qH3vDC9iSbGebrB95vlxwxhaX46
 M5dtOCMaIl5LmgBKix604dGY41VBiEZTlZaba7NYahNjjJyq8rcVFzedHS7mrjcMB7jJ
 dVE85+v46M46o7CWLt9g+7nN5LfwyYk3zXs6NxV98s+PzCVSEFjXLikBvxLC8mF5wEWr
 PvJMCADVB+EtsU/yy2io3W7d39DSzVJNXnVnuV1OjDAZJthMfZe+pg6BFOuTD+uQ5jF+
 Iqytc3Dinf2hcdBOe94ExRUeR/fOHj7DM3CrUNq2KyQscxnMqmYpJxVO/SGJ6PT6xxgC
 JFgQ==
X-Gm-Message-State: AOJu0Yy8gCwKJxjymitq3W1QG/MQtjhJ3eu4L3vKeGEQYKnadFytHyiu
 gxA7ZFxj/uvULeQGcF67p9BSln//cbs7vZJMvRhiuEyImO2/pLi7uBqcA3EaUJHptK2b/yaGkW4
 cvO8=
X-Gm-Gg: ASbGncuZfCNe2/qiI853/xfyauewQrHhr4XJqULWzzfcF3WWPFMMrqf5PdKzAUu1SQe
 zJLFozl/U90bno2wMmICcBpaORlNBIj8WNJD2eTgivR8ojshmWX7w0QvcwrEZBo7JSzEwTdAXbk
 xOh6b00CL/IsmqfMxorELp49k5CYq6hhyeEIYJDwWSSbQ5KP+ZXKQFkOCCAqmFithfUKNy+Jo79
 yqb4d349KVrZPZSWKIz7aXakJXlbJ8xTeCxDyixFLs4IKcFDhbFBFiwBIc5+zyR7LhSYDsOqEr6
 LHyDho2swbW6cqbGD/UYiwVYZ97MZQxtw+FXefb5uBI7J7a0TCr6c3A=
X-Google-Smtp-Source: AGHT+IHSDshZcdAuExEjrtTmP5u0w6XR7kak9SjCVOACkNTzDEbogZ0T74bFO5Y4pX12LmUKvyzYJQ==
X-Received: by 2002:a5d:5f8c:0:b0:386:3329:6a04 with SMTP id
 ffacd0b85a97d-38bf57a957cmr32823500f8f.39.1737669376244; 
 Thu, 23 Jan 2025 13:56:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c42fcsm791958f8f.96.2025.01.23.13.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 01/15] hw/ppc/spapr: Restrict CONFER hypercall to TCG
Date: Thu, 23 Jan 2025 22:55:55 +0100
Message-ID: <20250123215609.30432-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TODO: Add PPC folks why :)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Missing appropriate commit description...

 hw/ppc/spapr_hcall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f8ab7670630..dbf30358a1a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -578,6 +578,8 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     CPUState *cs = CPU(cpu);
     SpaprCpuState *spapr_cpu;
 
+    assert(tcg_enabled()); /* KVM will have handled this */
+
     /*
      * -1 means confer to all other CPUs without dispatch counter check,
      *  otherwise it's a targeted confer.
-- 
2.47.1


