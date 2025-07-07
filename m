Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E6C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpY0-0003ct-RD; Mon, 07 Jul 2025 13:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWo-0000wh-3G
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:21:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWk-0005CQ-Up
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:21:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so29957915e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908863; x=1752513663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqODDGmVZwWpLG85t5AjRhEjZXJgSLCLXmN69PZ4Bno=;
 b=zYT6tcE9nRHOtCk+jYfqKkZZ+8G6aPt22pNdoezSBiboDiQYRiqksYtmhvCUikolNP
 GLFCj1q754AzAOPSFs1FhSjSnY1Un8QBpPlt9Ys68b2W4g3EXes5aQtsirHvkuBsUUzc
 G6P2mAKXn/CzHwb5wNeo0DbJQiiWk0miFn60tVXC6XnP0A3jh+irRArmAgIh/dYFbZ7J
 zbEr0VMJ59ppcXeoVE3fvifa2cy68x5ABybjsz1Ip42w3oPfEOX2t7kxcl5jU3QADsVX
 EgvR1umfKKUSP/9W066kafJL/3Au7FkcvZZ+XqIomE5kTlQ++NKwRuZYEscnspUltgOJ
 b+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908863; x=1752513663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqODDGmVZwWpLG85t5AjRhEjZXJgSLCLXmN69PZ4Bno=;
 b=IMYZpcNzFgc60Q2pnnIw5lI3lTrFWVs7Q5P2LFpQ0LJehqaOxJTnR1Jx+jTl/H/7U5
 E+Y1pjqwouNhnuUo/VB14ZtJtt6KS6f1wX4msQS6XIlyfdNKfQin4cStgQVS91yhpLcJ
 86j8AGHVxEzL6PisQyPFYXAVlwICbY70JPLObGuFNq9Km2nk5FhEw7tGhbBMJJqGQYoh
 g+5K79SGxstWjQrk5EdZhnTiJwdbwli5a3w1hdh2s/kb2ezf7gP5DsjRdbfisbfjMN8N
 pseeCbLGJoNIDLuetKRkeFh7oyw4876TbNZbtxrQovn8t7lS3fQ0m+pwneu/Jgb5FAIk
 Au5g==
X-Gm-Message-State: AOJu0YzCJ+cG051nyvZuDXLMrqWMLNUaj4CIyfWgxb5Wcuo99Xq9szGe
 93kEBgD49Cp9L8TqIvhBQwq8LiIW+D0Ik4zwrds71zRsJ0Z8lM2Qgy0xJBRK2L250b8ad91Ffp8
 ndug0lZk=
X-Gm-Gg: ASbGncvrSbuVM5A1YvJsw480ROGzBsF4/uBQtWGmr4WYBs/MiNfaN+erx1pUX+XpakF
 NmXdSjA476uQKYT1zaatHtjmMqVAKGpifFnwm6QtQ8XMVIQRzDyl+VePVXIbBxXi2PrIlgJo78D
 8CYWzfvDJd7D3XA7TT5Bl41S8OYQF9t+CK3bEGNBJYJ2qsi3dLu8hJNygrj+ltJ0YB/q8k00aiR
 Adr0HEkMgSuV4VO97yjL0mGeTSSN2BqdHiMtvwajLAygLhY7z88pi7JlEUFRgTuCdxwBJhsf+nJ
 EmbhTcE3v0JEP6ZtM1ewrgyksPnUr7aPcHsDM3+ulcKw5pVcpwUIx5TO6wYh4+kXJymJiYFw75L
 ybNhygFYCfZ5oIQ97OEwr792bO/4eWx/u30b9
X-Google-Smtp-Source: AGHT+IH4AKONYKk8WayseeK6glA6RWMBLDwrfBPAg+NlginweazDCvf0XL2oKfGi1AQj0zCr2pB27w==
X-Received: by 2002:a05:600c:8885:b0:450:d5bf:6720 with SMTP id
 5b1f17b1804b1-454b5e9a2ffmr100958275e9.3.1751908863459; 
 Mon, 07 Jul 2025 10:21:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b161e8fcsm122271075e9.7.2025.07.07.10.21.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:21:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 v6 10/14] hw/core/null-machine: Define machine as
 generic QOM type
Date: Mon,  7 Jul 2025 19:20:04 +0200
Message-ID: <20250707172009.3884-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

While DEFINE_MACHINE() is a succinct macro, it doesn't
allow registering QOM interfaces to the defined machine.
Convert to the generic DEFINE_TYPES() in preparation to
register interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/null-machine.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a6e477a2d88..3e03771d570 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -42,8 +42,10 @@ static void machine_none_init(MachineState *mch)
     }
 }
 
-static void machine_none_machine_init(MachineClass *mc)
+static void null_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "empty machine";
     mc->init = machine_none_init;
     mc->max_cpus = 1;
@@ -55,4 +57,12 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+static const TypeInfo null_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("none"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = null_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(null_machine_types)
-- 
2.49.0


