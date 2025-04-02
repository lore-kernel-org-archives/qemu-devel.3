Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8E0C3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05GB-0004hi-1U; Wed, 02 Apr 2025 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05G9-0004hH-OV
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05G8-0006Br-9F
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so155269f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627867; x=1744232667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WavpzRms8h7j5LV9e9nhpkQTFnjrVk7Zh9VvhVcZJdk=;
 b=X13S6P6duo4hpxqaUQiCL1Nvso7YIWJL7Zqq4GUxn88RUYlDRr3+oKd+rWnGQrKWj6
 GaS1iHIR9tVsKVW1WGc+zL1csEPXT5uzswD3ePi3faUe4LE8beXSvWmOpxeWfDxcN3Ty
 LYayCUlJ9BiizmUDTb7yZwgdg1axMKmdDhY7LOw9gUOuIx1plZIjEb+VE7v6eCUKKMI9
 mTxEk6gNpvlv4yv/ko+923jhDTCXJWBO/JkgoJpjtsHOz/go8c3KD9xbn0FYdkSUjgqW
 YS3L7yT6CLOk8RZGS1u26t1wfhLwT+5eXN6Dbrx/RIcvqfKEQMZ7OSiYKn2xf+jE/I40
 vkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627867; x=1744232667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WavpzRms8h7j5LV9e9nhpkQTFnjrVk7Zh9VvhVcZJdk=;
 b=QM14a4XRfGuutLbrlhSHAtoQr6d/4+oWL+yQV36tL8jENifzWW/giMVLc/i6KpQUQd
 l1t+kxQRvECE6hn1nTSlpCybD/t/mpqrM5lTOLJ8CHfpEA8Mfx31gjm9mKOMkIeHQYiU
 2ceCu5ElOotzQ0pD8jbQfkahovvc2DJmTBYapU2txqNC5YWvpyfFWsPs7jUOiIlr9K5v
 JsWBeWk3bxHHOHF+fJjx1Tu0b679zuyF6fCliawj6xO/bH5g/8OwFH6t17AvXFkRw38f
 p/7JdXqEN1x7rIxpW0HlYr2SlN56u8wETrgtfRCHEjOHtXtdVcETD/jMN9edqNhENIyW
 CGKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzR4HhmnH8z86PhYmN+fs0uMTTpTmFTd+YqkqLfGyyb8Ku1RwDyoSPibM4vqXLU7ZTNctEZ8UuK6nW@nongnu.org
X-Gm-Message-State: AOJu0YwnG7vJ1bQzAuTQs/ca7Zv16nz1ChHq/yKU2WwE2aVhjzdnIEIp
 Npy7J4F9edv0FBXGOKzrbybQTQd8lHEj7i0+DzFaeODutH/kTfbcfM9G/pr+zvfs3EP2/o1CEx+
 w
X-Gm-Gg: ASbGncuseiZpY74c+zDqOBIJb4Xf2TWUYQ/m1osmZcBfbwUGJkUTg4wqIlpqSDlUzdf
 uT8/3eHTrtcq1WZTnw8EY1uAFMAAyImpyag3TQh72mF43uY3NHNxKxGn6BEwHFmNzmndnykCCjk
 n1ExnPcNlp2jTOK5jTcU308ZnfygwJ7jwJz3HMUq27LOoQONcjGrOtd9spXorJxF4UwELdz25S4
 5SGRtBBhYfm0DeW6oP4x6vunqKRSioOmDiiHuA3gHgaLF4T3XQqj9pnrePPobN2S8S2VJ0RZJeu
 /0aGQe7w/VOofU/5PANvB00gzC7ZQbz93yG5UbhycUjxN+qsGbcVR4KPuZgmyAMJTmxZftniIVp
 J2jJkxajDB6hlhfnZM2k=
X-Google-Smtp-Source: AGHT+IHeik0Ovn68NHpB5KjCxEmHSKTiuzF8cVIWv41obRu83FRKlEVqGTsyrTgJEIbItsZsaUQfxA==
X-Received: by 2002:a05:6000:40e0:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-39c1211d5b0mr14674119f8f.53.1743627866731; 
 Wed, 02 Apr 2025 14:04:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658ac5sm17568480f8f.1.2025.04.02.14.04.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 12/43] target/loongarch: Restrict SoftMMU mmu_index()
 to TCG
Date: Wed,  2 Apr 2025 23:02:57 +0200
Message-ID: <20250402210328.52897-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e2705..cb96b17911a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -868,6 +868,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .mmu_index = loongarch_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
@@ -919,7 +920,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-- 
2.47.1


