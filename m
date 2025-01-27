Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23510C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNhY-0006TF-O9; Mon, 27 Jan 2025 06:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhW-0006RI-Us
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhU-0006sJ-M4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4368a293339so49782855e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978883; x=1738583683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmODB2YqiSgFfw6mNPswT7QwXij2cXKU42PdskrrlVY=;
 b=nJopVp7Gc8ludZpwD4BxQ8sutpItSjeKSfdjYi4I2VHJwGoQ4u1Ct49QRT/n+gmGsP
 ffjHeURqxJ9tnKSbixhvGytXMbcXrZkqEnzQbvaypw+1r+D98yZDQFTVGBm/ziFh5jKE
 RiGyAG7Or77NCuTCIcRqwW3chaZUuBc0NhFj7fR0VETYNi7qUwuVUL+02UIykKyKc1Kc
 jq35ZAw1Ibq9Zpn3RlYKeVun/Xlw7OEQZlOM4546xCffwgDwfToA+f192+mpQYEx35Ek
 j7VLQuQGjYaamu6NuQodAnY51MuK/CqaP9D+628ja3glAeliPS2aW+IYUVir1QEbkufD
 jFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978883; x=1738583683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmODB2YqiSgFfw6mNPswT7QwXij2cXKU42PdskrrlVY=;
 b=Kw9Sp1Wef5DkhUssT3SIjwvpp3Py9evkDG8HVYFfGT3OQgbMrbg9VTMjtVWnEKlBe7
 E0Qdtk/qdJv9WqT56UIof8LaoYlpW0pXffTVdo2HN4YbZHTt01x05nJrny5CElrRlTJW
 1socC63kn9MpGPVulWIAywoWu7/UCsi6+oN+dXLEq14FHzP1WNzRBHwJ8BMtrOy4d6rL
 g3LMOmzbqdE1hjxaC9XvPFFK+BG+8mhpbiKM2Zb9Fe3qUmZGshnLMv0lXQAiQ0tpDzwk
 LtKsOzNUKvNRlxC0jAw4lQ3iMffO7assJ6oQ7FC+QeT7f/b2b95EmPNjZH7hge9p15AI
 SWgg==
X-Gm-Message-State: AOJu0Yx6YyS0Ubp/QhCjQ4m6+RSYH7n2VUzDvGvA5bw+IdciTPPfvpgj
 zWMztryjIUoA3445uS/G9cSV6BFfKVDuhb2L5wQ6gKKCPP2GkBrRSns8D7+npsRlbWeFb8fwtHo
 OQZQ=
X-Gm-Gg: ASbGncsRkxt4/J8eisMNTz+6DBy858fnKDSwVsbAgQz8GcEWfaFeFwXi/f42zVAq1mt
 f6LV1GQiYWz41kFjzsHdUqtPktpMvp7uN5OuGIzBbwFmuOwm23ZRHgTMz6Xrk9SJJDZyxXmVK+H
 bzX+xCGpvpCmfhLcaYWEXRFa543qTDLyJJQD1qY5jTg5pjl+3dlsH3oZhcaTaetWfGchxNaluN0
 pRE5MfSqg3WBZliwZOBgrMGuhPfZwb0kdi0PwYTZfvXL4PqMVn5JQA+YKvViWcCwN8v+DtI+ROE
 HK3EQVq12Hev31XNIILpQMgXFq/hyoj6XnA7LLVFm37NOxh6ayHPIes=
X-Google-Smtp-Source: AGHT+IHfR9UBAxL5TKZlxz7d+HrYqLOdlINPy2KjaKBrQjBGU4MYj2SOphGtEV4tgHtMC3mTf1Ohow==
X-Received: by 2002:a05:6000:1849:b0:38a:8888:c0b6 with SMTP id
 ffacd0b85a97d-38bf57bfcf5mr42398725f8f.51.1737978882716; 
 Mon, 27 Jan 2025 03:54:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6f8sm10684291f8f.28.2025.01.27.03.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/10] target/arm: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 27 Jan 2025 12:54:19 +0100
Message-ID: <20250127115426.51355-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f9fdf708653..9de8c799c77 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1220,6 +1220,8 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #else
         info->endian = BFD_ENDIAN_BIG;
 #endif
+    } else {
+        info->endian = BFD_ENDIAN_LITTLE;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


