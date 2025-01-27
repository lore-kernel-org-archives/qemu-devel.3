Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1869DC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMK8-0001ct-5P; Mon, 27 Jan 2025 05:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMK6-0001cW-0I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMK4-0001vx-KR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so43800505e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973587; x=1738578387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8IO10tm7cHN5fIAfICKPQ1+7FojlYdziCm/1tH9ciA=;
 b=YJ+6Pqce8Jb3tfFsDcf4FsGLJznVGxyXJr6CQDzHVZLT+zbxkasevT0DSY5WQkuJ9v
 pXR1TpCVfuRJ5Axm+4DbE+ry/dy9VLX3z+wK2QpbDKS08hxR6E21f5eqL3iZYwAm7Fom
 ElWYA51tuK3swEXwNsJKiAdhIyxAX0t7GCa8BwAViW718SQLtsOT+Uft9LrG+iOaO90r
 7cmFg0ktYJ/OgV6xlcml/1yJTeHCsDNhidYBDG1G5NDPB3Jmkp9ofYFnC1zHmQ43m9H2
 0KN+t6mRrvGjwCgLt47JbGW8QY6OY3lNDe/OO/+05Ypw6S7SZuFU6riSDapmMzWUSvoe
 L9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973587; x=1738578387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8IO10tm7cHN5fIAfICKPQ1+7FojlYdziCm/1tH9ciA=;
 b=FL5rTO9sdAPfpM1zqqLtim2+Zif928GkXThUVMBmLs+lHqNAHzqizzkyDwfyBi8V8V
 Teg/Pnrbk++4qvdIK6u21HWP532ROOvy1ia8ndq0HPKLwyKbm1mtGS0DnjHK1YCVNguT
 F/LYfbJYTkFXxVjra7OJfMKMX44iqKbVTXPXKn6lgd571hQd0XRI+8x+CxiC8lh8iSbb
 jlwyPq+kpt8g/o1bnbO1YbJMQa9QvEwQvsO1lEtHaRUzpv6f4F3iSnUFUEkpJdiHRcf+
 1JNHL8nLDPPUcku7b1NnNE/dhlWDCm4rhHfUZVarWbnr9Ir52fj0B0zqr2aggIwMqEoq
 puYQ==
X-Gm-Message-State: AOJu0YyTYRJwg2uKX7PXI0UCWWUl1rdwZ3ee3v90pV7PemmR2DNg7b9c
 +XY3HJuGZjBf4OeNxlhXg3bt7HGsw5Gys8NAPE9oZU7dRKd/vEdbFu5ITjaWO1CxBAW8qlo7SFa
 lVLs=
X-Gm-Gg: ASbGncuMZuklxPj2HxVulsasU9M+aZ0jkBnYopaLkWigjLKd/a1Tu/XxWFGDTNhpcWJ
 8tgdootqu6GQ3IQ9AvzzDVdj6QLGJNMimD8UJtd2AW8c+WunqZCOdDWNSPoH9c5ZRNlHiUxcLba
 MnbiYXsuHb8FgCJOWza1CyN+kK5CTveK6cy31oNbbx56pDAzZ5nInFS5d8fzKezoYyahwGoaV8a
 gNo84kHoEY4YOWcVzED+9nngbJIAv3ZX09KBMe7QgdHPNa2anyP8puxhVowkIssq9MrIviHqFgH
 FCTxS7h654UMgW+vEFpq4k/wVLN4VdWZOiFIcjQ72ECrEhxmnx4RKy8=
X-Google-Smtp-Source: AGHT+IF3KR2EB0CNbkIIpYCWXnl9kH/1wsRFCm1vZnDqdDBjLNlVtB9zLQrIYRGhDHa40ypZtMpsjA==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-438913bff57mr366945245e9.2.1737973586682; 
 Mon, 27 Jan 2025 02:26:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507dc9sm127885575e9.19.2025.01.27.02.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/15] hw/ppc/spapr: Restrict CONFER hypercall to TCG
Date: Mon, 27 Jan 2025 11:26:05 +0100
Message-ID: <20250127102620.39159-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


