Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C8C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPK-0007HR-CR; Mon, 29 Jan 2024 10:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPG-00074d-6j
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPD-0007QQ-JF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so855215e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541518; x=1707146318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiohzvoKQkqdcbtLDUjaO0ftHSX88xmuo15mOgH42V4=;
 b=GV1Thag2jowJxNoR0Ucdjqkn6n5HzSZ461t5w2PRS1UF83J170gzO87dzjKLdlGmYj
 BetKva+mwTJVvzWUV+JKcz2CalxWfjoHbUAvxRnpgOLaVKNEne/q88DLefUDmc5UYZFz
 XS+Lwkogir2QeTgJecYb93tfOdy41P71Qf1UfE8nAmGmAA5lem+ihJKxZALqax6Q6Tyg
 AijzGNJTZV8Mfr96TsodzkodScsgq+l0+x+kIBjL85juXHRi74qmSluCopUXL/6m3saM
 TOQM36VVh+8DnH15xMbHRw9nrGlr2yP3HzV0QHlMcBaDFoE+kzaqSFs07cCHVwLyD180
 h3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541518; x=1707146318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiohzvoKQkqdcbtLDUjaO0ftHSX88xmuo15mOgH42V4=;
 b=Rlwonbu+tRW7BpVeqsMGFDOvhHW99LtXNaITmqSkPDVZIDl2MgAAUuLuf0/8pdaIG0
 cNMnQhwzQqIoVxf1lo10HnkltJaH+sc+fHIjHEnuIccOqPl7GnpfsRKPUbY9znv4uSoq
 eEcPpBeyNMuoTWPq7l+IQDHWNAAt+fTwRwHRhUwSsJfubpDFUWrz3HuKS1rh7YWAu9Ql
 QTgzTQix17jylUQAafb3Ron1UGeERLnd5kcJMfTaXsiD4Pp7HvXXC47sirjkmcFqbFjR
 NksWr7wZVLEx2lx4B4SOrMEXtXwixpuZnurQPCGZTILgzAltrUP3a1Cn6wJj0rrAZcYq
 FeLw==
X-Gm-Message-State: AOJu0Yz3PpGC8GrYKZm6a81BywrjW5kW18wOyu6uuJXMZomcjhJK6TMX
 +R62yfU8vlpTWhgXYFaUaXMWsAqo+x7nazjSn2hFDItaKayq7O5CBHNjQB+ZqsBEDyqC0ZDPVzD
 B
X-Google-Smtp-Source: AGHT+IHv6RQ2c65BDR/u3gUcz2HCR15z2MQ/JL9wJfViyb/nctPqS5QwlFFCSXyiMuqmIM9c3k9BZw==
X-Received: by 2002:a5d:49d1:0:b0:33a:e756:bd21 with SMTP id
 t17-20020a5d49d1000000b0033ae756bd21mr3058604wrs.43.1706541517878; 
 Mon, 29 Jan 2024 07:18:37 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 ba1-20020a0560001c0100b0033ae593e830sm5764355wrb.23.2024.01.29.07.18.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:18:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 1/9] hw/arm/exynos: Add missing QOM parent for CPU cores
Date: Mon, 29 Jan 2024 16:18:20 +0100
Message-ID: <20240129151828.59544-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/exynos4210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 6c428d8eeb..57c77b140c 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -556,6 +556,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
         Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
 
+        object_property_add_child(OBJECT(s), "cpu[*]", cpuobj);
         /* By default A9 CPUs have EL3 enabled.  This board does not currently
          * support EL3 so the CPU EL3 property is disabled before realization.
          */
-- 
2.41.0


