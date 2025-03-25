Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9494EC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6PF-0003tj-P2; Tue, 25 Mar 2025 11:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PF-0003tX-0c
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PD-00049W-9m
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso36567505e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917289; x=1743522089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbsjfiae9VyxIEcsSbXzqvelTNR2Rg0DAwfeG/N1/LM=;
 b=uv0ogjUGV2YGEVr+J+xmvqKVXylDPitAqr1iLAsFGIuVbw07UIsUurGzA8g3z1r0kF
 R7Ux/rX38+j2tFGFDa2rCyzbndaub3rhxul4+UANuIY6+JcfE+t4HwJoqG2RX71wvFKN
 MOZ2NdY6jsb9VBO8jElaM0xXviSTqzkssq1d69VVLcdvrkiLPdg/dVmotr+rp5MThiLp
 9c6W0kTZD4t4HQoFnuuutrMTdQ4UA+Z2ftECtLTAq9ZUIVjZVbMF5umIGYUcn09oXN21
 vZf8zLVm5rFGZkum66hAGXdSDNlDrk4+6QJgwpMoPBs4P211FAdBJ+1OJnGvIQSlRRmW
 xxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917289; x=1743522089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbsjfiae9VyxIEcsSbXzqvelTNR2Rg0DAwfeG/N1/LM=;
 b=h86HpQKLsYqH4Wsn28ux0Jmo7hVzI5ew1F/vXNOP0YKxNkfZotaivh1UPmUSHCuVjf
 xsKaelvuxn7U+E6vPenbIhEBi4cXZpr/EoaMMKZl8ltZgxVPXRu2FzzhGYzBr+oHJdev
 3D+cPTtpSDK5KgmaqkH/z5sjlWoumEFo2HR2zsDwmg6r6XGi3PQ1UiIQ/ccBhprTLj7N
 vowpvC8wnP8VCwuHbWotwWdMocaXWtrIrtb1+KTj+44gk/pW5rRtbMlAK5Isn8Dv3MCi
 bYkDHaPJZ77zRwc9D2ESKX7kFmXEFJIqO9b1YQPO5DDfFEsIeSXcV4t14Iu7X6+pFpp3
 OcGQ==
X-Gm-Message-State: AOJu0YyIKIC72cT5Hq0ONaqV7xwA73okfePryqIq2srZ01Tmaj5D0fFz
 NQnH/9NAyxwuHOQ0whB7OFmH+p9WYwSa3P0atR+J4Cq72Z7AmA6DRyT89r2E8v3hphH6wRa5s9n
 g
X-Gm-Gg: ASbGncvuB4+a4Eslgk6W1fueqRa9QjT7TZmZD875MZDBPW3dpnshGW2nYZq2064v/8l
 MIYJQ4Vfza1AlamVMETTrKHCPGbXcczyi7F+82GLiqEzUeFfvRiBKYK6hhJGl49lWuVKqXExaA+
 jPe9qLnzhdniwp/NFsbc+WyHvWIGgnKUHz3IgmM5KImNgQDG2YDVnor3mY3VbnhxtnqvOecyva0
 0PyhRH/idLJc+/H/5w2ghZcWIsnuYpM5gyE3aAtMtbBTEVMu7DVsnIE0W9nOy4UaQfYeS8YoJ6U
 xHbA6u9pBpU8gN6BhQBF566+6GDgfdsK5BdnBtLycZpCaUUZLYfIMyZwornkBpUj//8AphfKjFw
 lQPeQpSNqF7xVI+kM8ng=
X-Google-Smtp-Source: AGHT+IGzrJZT8OMx1lcnFFHIzm46ghGtZisQBO1aoJGnup+W4UKLnn8r8P8qr+Kq5QmjjZTw16tr1g==
X-Received: by 2002:a05:600c:1c1f:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43d775fad8emr3318805e9.7.1742917289277; 
 Tue, 25 Mar 2025 08:41:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4ce9sm14213513f8f.53.2025.03.25.08.41.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 6/8] target/mips: Introduce mips_cpu_is_64bit() helper
Date: Tue, 25 Mar 2025 16:40:56 +0100
Message-ID: <20250325154058.92735-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

mips_cpu_is_64bit() returns whether the CPU is a
32-bit or a 64-bit one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-qom.h | 2 ++
 target/mips/cpu.c     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 9acf647420c..52996e7c354 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -33,4 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
 
+bool mips_cpu_is_64bit(MIPSCPU *cpu);
+
 #endif
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d8930468b7d..05b3ce42af5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -516,6 +516,12 @@ static void mips_cpu_initfn(Object *obj)
 #endif
 }
 
+bool mips_cpu_is_64bit(MIPSCPU *cpu)
+{
+    return !!object_class_dynamic_cast(OBJECT_CLASS(CPU(cpu)->cc),
+                                       TYPE_MIPS64_CPU);
+}
+
 static char *mips_cpu_type_name(const char *cpu_model)
 {
     return g_strdup_printf(MIPS_CPU_TYPE_NAME("%s"), cpu_model);
-- 
2.47.1


