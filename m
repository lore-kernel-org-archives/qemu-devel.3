Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVu-00053Q-6z; Thu, 06 Mar 2025 10:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVR-0004U1-8q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUs-0006jM-W1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so7148085e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276251; x=1741881051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5B/bpSAszS/Z+RxXmZ3jyXxyW08tQFInocZVZ8QKZ0I=;
 b=HmFTfqA0nkb+dzMiJ+jzXBtoILyq9tNOrUktj3Vko1Kbd/D4LuRswRx9UEdF2MN2OO
 owAhjqtKEWGNqiZC1nqq5lnwPjW92bQHv67iA3FeH0xgCuvRIAkAtDckvWVO7KEpjqIO
 2cEzNHSkbE2+rfMx7f2sfV8DaQSias0CeO4wUB2j7XcYsSacox1UiVks8NWz95QM8b02
 TGfVzlLfmlZAh0Qrj0psUCvBQKBvIgHm1wmBKkc8MvHg8dKKMysB2N8z9BEcWhwN+AXB
 cQrFIHpAHKjiyHu6QG1J8NvErSf0pjQ+nBpIIqYbXGs7TuEZzbdortwNS0ZYoJ4ilr1Q
 1o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276251; x=1741881051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5B/bpSAszS/Z+RxXmZ3jyXxyW08tQFInocZVZ8QKZ0I=;
 b=pLEWw02ppT6WI38Ef8pZy6sXDDIPxECF5+PFN1ZkwcqHTUb4yLe1odmLQumSApXrru
 n5jeqsgKahvmxfjX3BViVOfJesi7o8imlOjP8JGwtaOcwRoaDWyMkvBKehahZGHkeicn
 aTpy/AKVU0/OsDmsm7EU1TWgbJzo9amsnISydzep2TmG0pDjvjqcpdDsMNdJVQiYBFKM
 65kweQaLEFPEWVrgG4MFUW9AAnLxRWW+xX0/0A/LrhfoWkIjoKN02J7Keh2he7yBfwWr
 jzVE2mu9o+33XIj23m+KvMgkhR5H6yKswiQagTukUVRheSkdsdCtM4Epb8LotGG1IWgc
 PW7A==
X-Gm-Message-State: AOJu0YwLjXj6yjE6/fnMKDKaAuUcuBfEUe1JSpfi4gizDHtl/0/S1Mkn
 p7VrDROzbX/BjRHOqet59UqnlUjGi6r5aykDbVSYGjHzgpqPLl4QAG2OUOGN24uNeUMRrmXuGWf
 LUOM=
X-Gm-Gg: ASbGncuWmKRYZBfcXxXV2373UvG0TOxyqSfIOd9o/rsbTIZoaF8Dsx1fmeki1omC9Fq
 vq/353f0djczMJyTLq6FahTz032vazdC2jsCF6/XiNEro22GmM0QZum/zDMKD0I8PJTd2boZIQc
 sFkCCqBbm91iGxY6T7Ro0Yea78rzF4xpi33wk5tTeR9vcQDfoy59P4R9ZX8ht+NWe5sEd/Mu5uK
 zIs1vn/Xz5Of8h78jzuigYVE/vZCRr6UkZb5fV+/iGz95DOy5FTTpqX3M6F0ZzFFykAIa9d2dBk
 0UegRWtX/teQCLpVOlNLIPLz1CCVvcwGtxkwGTf2PSnAE3+HhWDP2ezmB4BtAfuSTGYMFK/XYPz
 cc8lad2nCR3861rhnKj8=
X-Google-Smtp-Source: AGHT+IEg0uk/ZwIThl/zSvRqPKB8YctVuJLcbAB9JbYvMq4ztgAmVlRAdWMYGSqI60BAPs63y0g0Dg==
X-Received: by 2002:a05:600c:3544:b0:439:a1f2:50a3 with SMTP id
 5b1f17b1804b1-43bd29462e3mr61703515e9.4.1741276251519; 
 Thu, 06 Mar 2025 07:50:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da473sm23319515e9.18.2025.03.06.07.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/54] target/sh4: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:25 +0100
Message-ID: <20250306154737.70886-44-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-9-philmd@linaro.org>
---
 target/sh4/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 22cdf9b4e12..c2aaa40a037 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -143,6 +143,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                     : BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_sh4;
     info->print_insn = print_insn_sh;
 }
-- 
2.47.1


