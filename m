Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F89D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsaB-0001ed-W0; Wed, 17 Dec 2025 09:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZU-0001ZU-Ox
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZP-000733-Mp
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so41239245e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981921; x=1766586721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCPuc4QcdE6GiCVIeNAYDq7shfJ0MvEj0ABczq5KTuo=;
 b=p4Q7xiEWtlM0PEn4TiQpWFY6+E60Xq4uNPJLHjtEBiLKdufSPpFudDATHsho43Z7/D
 d9vzWgStL01cOQmpd5C3baBxmE4F9SckG06/9CVcGKZj5aniEo848w681dY1ilSwxT2E
 oetFf0Kv3yfVulqXoYpxn/O79mKbHOAWnQPkHWtsOdikmohjil+95Lp0rkRqvfIZ9Zpc
 lP9z+LJttr2NPzeNmdAb6dE38YGStOk1z1eakL3tj2MTvKot2qwf6OLOT1wUKiLhNbLe
 e06XdmcsHjfebNsUWH0+titeujjxXYNV4bNo/O4FvEpWK64VGFfAoIgTFa6atMgzWW9N
 4HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981921; x=1766586721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TCPuc4QcdE6GiCVIeNAYDq7shfJ0MvEj0ABczq5KTuo=;
 b=g+LuRX9hI7kTcVC5RH502IfAUqkimHL5Qy3yFteHzS4K2gJ0U8O3UOm/kAbtwsP0Vs
 +kw8aYYfaT5aoMIvcsSHhwRNcmbLKpebVERvTMNLPcVrck3c2KKfntia1xqZgO6DqUWy
 lQyHWjlfoUs/O5g6/gkXobOj2Vk/AwmoABRz0eWpMfOncfuxAJZa9RiOcQX3dAfW3r6O
 CDFIdTIKfI93QWXAK2HG3XG9nfTInlmjVUVHqoFSRkIqhPUmYmW7uqo+md+uvFLvmCJe
 EW4gVFibCEi+GGozPGJ7TW5wor622KkWTOSEuEdLCtKKRIkV0YT4JMxQ3fWmlaEjDJpZ
 k7yg==
X-Gm-Message-State: AOJu0YxHvf/JTxLujdfAkczFCuwpRLYOk6oL/SOb8rzW278tCJ1VEflK
 N9znxgHph9RJiZa1oytGTQ6AeXXwlpoF4DbsCN4ZvTbbtyIlw0LGoEgHGZZHGfBVgUT+pLK0gv3
 HUtknJuHsHg==
X-Gm-Gg: AY/fxX6NZLliBbwgo6PhjKy1SWau3sDgf9hauFEM3IYGsT8OaMsksO2KifJJG8j/Z9Q
 rR2gX9rk/tjImEFHlSEpg/soz1CIwopiJEHgENjFnq6+FSN5OBuf32W5hjfw1+MINlTQQFY60rZ
 YJ5NK4kTCakNLFLej3lNptMGLI/fj1c/tFDom5yc7FarymRZ685y6y59Y2YWbesVHruPyW97A6C
 HDVAg98mB1NNzeNDA6o7YukwnoIwyfjoiqFzBC01vhXFE0XpqtQt7qLB3hNTL9jCy4RolJzu8dH
 35Gl+NAPeZZ7DKANwq98ZF8CyhZl9lV/QuJdtREZNIhAt2tikktqNL+4YFg1NWhJj6JZHh2Tb3m
 3s+gPh3QdpvMPfBNrWm9QZyX/TdyBw1ImQovLsW9N/UxpEJO3lGMo3zmIBcuOyOZJ/2zWLoUWzR
 GnAAMPHwJmpd2C2rfAKGrkxH8y8NXTo+Qq6tVsaltO3Qx2ZquD0wQu9paFOf8x
X-Google-Smtp-Source: AGHT+IHtPK5F59Ai6OYigl+XGD/2e1KWSwOW9iwSmzj8g138QmguzhRd4e3qCseNG7m/FhMdj7FYtw==
X-Received: by 2002:a05:600c:6912:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-47a8f91dac4mr201159925e9.36.1765981921014; 
 Wed, 17 Dec 2025 06:32:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1edd26sm40165355e9.13.2025.12.17.06.31.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:31:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/14] target/i386: Remove x86_stl_phys_notdirty() leftover
Date: Wed, 17 Dec 2025 15:31:37 +0100
Message-ID: <20251217143150.94463-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
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

Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
("target/i386: Use atomic operations for pte updates"), let's remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h    |  1 -
 target/i386/helper.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c..4c0579a5678 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2623,7 +2623,6 @@ uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr);
 void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val);
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 72b2e195a31..d14f14e0d4d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -690,16 +690,6 @@ void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val)
     address_space_stb(as, addr, val, attrs, NULL);
 }
 
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    MemTxAttrs attrs = cpu_get_mem_attrs(env);
-    AddressSpace *as = cpu_addressspace(cs, attrs);
-
-    address_space_stl_notdirty(as, addr, val, attrs, NULL);
-}
-
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
2.52.0


