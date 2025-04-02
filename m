Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81803C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Gf-0005K8-6l; Wed, 02 Apr 2025 17:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GP-0004wI-7e
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GN-0006DZ-8q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso157664f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627880; x=1744232680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oCRUFkqM/Rgx+/W/gq7YM+VaIF//T308QqEYlAAN1Rs=;
 b=bvr3+p7dg14DK+IxCCjSGumZw0V26quk28jjc2valVyQEPBy2uO4U9zr7QgI7cNBTE
 BBegD+SxxexWmD2Fs+AgdFQnVORWJnqp36KQQtJj/XxHlshzHymFC9WbS9UR5iA4I1Ou
 ayWgLF7IGguUgkg4eHV2OY6N7GokfdBiZXplhAlPBdwmsLZ4bAIuKzwZ0Q9TED+Slnui
 yn86QSwTJT/WHrhS/3e6BWEkEL0XzAmLnMhuFMaBlps9eZaN9r/djp5oTRnYf25+Es7f
 BRDAU+VsaxtvtJHNWLlq0222vdyi5+LQzAAK9DuQWNhCpGUspwz1KMluDFgQhfTrJQZS
 rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627880; x=1744232680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCRUFkqM/Rgx+/W/gq7YM+VaIF//T308QqEYlAAN1Rs=;
 b=EpLgADgb1K/vduzW9djWGMg5uUpBFCY88oFvw5UHkQzeJ2e2IQQdaFKji5UEVtOp0v
 wJ92pArzP1VBPxQ4hDeDFChIrKTGDnEWeGj72EJ1f+nE+JWhdugEQMREa9eCe+lABWiF
 sne/rLJ0e5BYOj0qCWcx0GjNhdrEglG69IYfLio1MICWwnAPTBHbfzgzc0nPLaxDFwHj
 dge0jqpfBklXD/2f6iLj5NNWYWHNuvlW1a2AtXtqe3BJMCpmHCaqkqm9b503E6GANzqI
 zbNd05ZnDxnsJ3+jHVTFfIJ+DqJ9ci3R7KoqPCVeEe2DXBBdGQSRgrKavHR8yO2Pj1+A
 0iOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5BEy4AJNX/UbrEXvbCN/67bwAZFXA/vWiwJiCfdExw5e9gZKdIKi+zbgFlUw3HiTcMmrGzsUE7CUN@nongnu.org
X-Gm-Message-State: AOJu0YxCLWpVDMkwXwINYulJUCmNi2xRvuTCX4XYFstNQiHfnHI9UnYf
 JQrkpx26fg/Svzeb4lTrDqSwdOk55E1ufC46NDW8mbDHWlexutKYUJrKJZdg+51v57rMJFfAe39
 8
X-Gm-Gg: ASbGncvJphy7kDDRGmmC+DqsbZ7T0RNFUDzmbpnatonIG7Mh4XA4JhFK7rdtkdDRfv2
 lXCV3fXJrfFMNlVH2EUojYkqqiXuOW0oWhzYQLr5msR+XvaI8DEBxIeftR97wyDbkxfFCdc3XZe
 riXeS4aVH5cwTi3MPDZdiOqU9CpAc4Vr9diReL12CVa6d2UJDVl6KqoSyV3EJIS8F8WSghH401m
 emBcQn2AAtlkGbtwLAqEhIqE+hEtIXS55xER+EDlcUDYKVygPOvV8snC9CCYABuTMX5fELi9rkj
 lFYHJhydcAViJJKIdFzuvj2pwxb8X+xrA+wOdf/6CeDQbfaO3b2TOr6COxX31zMsbmMKkayNjZj
 eC9yLMthtFf/blHNE+CA=
X-Google-Smtp-Source: AGHT+IHsZsdrORCUW7qgAoT6e9Hea7kjRx5yeTm+aiQc0mwWerTDcNFxXx5e+z/OnXAuoOhi/eqiIA==
X-Received: by 2002:a05:6000:210d:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-39c1257dd00mr11036487f8f.59.1743627880565; 
 Wed, 02 Apr 2025 14:04:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4200sm18186745f8f.96.2025.04.02.14.04.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 15/43] target/mips: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:03:00 +0200
Message-ID: <20250402210328.52897-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47df563e123..269d3d69bd5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,6 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
+    .mmu_index = mips_cpu_mmu_index,
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
@@ -581,7 +582,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.47.1


