Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451BAC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fo-0004Mg-Ca; Wed, 02 Apr 2025 17:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fm-0004MH-Ef
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fk-00068p-Qt
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso1594955e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627843; x=1744232643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=08SXN1fUCjpXHJ223CXHH4cvus8DoM7fkq/vvlk3VKM=;
 b=to7z0EdHMmO79za3xw61IqL3iu5Yl4wDE8FfPswlN1sYsHc2gqXlLBUsQ02oPMve6S
 922HZHtF4HrUW6wuAq6Mj/b0NT64X1TGsB24Mv84PEMOezofkHksVnn7IfjmpgfQSHvJ
 V9dQhn113LHu037BCH12S8PJ4z9TEtEZzmRasUWYMtcfo3rydkOjEeBL5dBLN+MRztwn
 zHZujvZv2dgZHmC/3B6wbux7l7WekReCL8z//Rgv27BMuxFbLTJEV7MdbZqzMCnfM9E5
 6pb70f4Gpvv9Tee0/pmb+kiHbq1GMbtjNyt0PSO5kbeSBwneWrxGcQyfdDloeid3kMgX
 haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627843; x=1744232643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08SXN1fUCjpXHJ223CXHH4cvus8DoM7fkq/vvlk3VKM=;
 b=H/6L5nPa8E4Se7AC7yKR1yqxOb54sg9VGLit28MFq84SswUu+afjtdwlsbM+nWI9rz
 mzX1mzEuRyggvYmiEJUQWKJSadiU52Cce5wAvAUoQznhDZ1AOi1Fhe+9wlF0F2DRi9xJ
 o/qQepp9RviEn25QLMLkjit42pJ64E7eByUxSiw5DYhaNZz9ffhoE1b/hi7LvEFE3M1w
 bOINU3XusmkiV3zTAJB41kyZFdPB1p0I4aDHx68tCVlA4BEgoHVxSXIhCFUPQfgbsGns
 OoJZQj13qSAiigq8q2O1Uz00VWVcGGYtkMCzM7DAUrw6F7CWzFCnxabzowvA0gudFTsi
 InFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVy8OBGQQhtCGz3tu7CTsH1w2llK+kiSMGRvN05rbbJ4ieJqcXwCYHir9ML2ynGkj+OQc6+Wx+tCxP@nongnu.org
X-Gm-Message-State: AOJu0Yx9BCbG3IIl2sk2vCJv0Cmonvlq4Hfg+RBiMQf3UaYeJsRwfEIt
 +Hive3zH8om1wIi26u3hHYjZZSNvwJ9wKqmT3kbUkf7kS8jqlP6BfidTXfqCkhqHcmX27pfUi4z
 +
X-Gm-Gg: ASbGncunOFUQlVElrSZik8VDgpDeM7StvY5T4difATUI3wMXvbBOkKYBdluhyTy8GUD
 aZz/Thblp1tZczBaE7BT0esbPCuuW/87hx76M7vqXG8KTcUc6OMC+Bbm9ISJwnMvkBmwXqSdMWb
 Qf8HyMamXdejjDJD36dyTfooI5DFXunLK3lnIvBjne1ZIzhcUMYpj4ZGM7Zj025gNAewaLwhgyG
 RGgrd75TFWLt09RaeARNEdpKxqTmjLbEfVaneAnPaxVL65oN6mKs15vJNva3KizVNuODqNJknT6
 3vFnrmqqkDhuGB6q/3k+xd/xq/NUDcuoka0uoSPTPgCgAJIhBkPgaN9mRkL+AypfjpRO2e9i5j+
 v5sM4RABnmIiG9kT/O1Y=
X-Google-Smtp-Source: AGHT+IHxWwtA1F44jKsMZN9eZQdAu3AT/oxcz0LjqNkd6/eSYnkRv+CsyhY0nxlK4pWr7n24FoxA3A==
X-Received: by 2002:a05:6000:2706:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-39c1257ccccmr10156623f8f.57.1743627843438; 
 Wed, 02 Apr 2025 14:04:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658a32sm18183139f8f.19.2025.04.02.14.04.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 07/43] target/avr: Restrict SoftMMU mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:02:52 +0200
Message-ID: <20250402210328.52897-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 11218224704..feb73e722b3 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -228,6 +228,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
+    .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
@@ -250,7 +251,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->get_pc = avr_cpu_get_pc;
-- 
2.47.1


