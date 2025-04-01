Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3062BC36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhF-0006kN-JZ; Tue, 01 Apr 2025 04:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhD-0006iP-30
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWh3-0005j4-KT
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso53003685e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743494996; x=1744099796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNXbkOwvuq2QN9fW+1tUFXQARVhg5/MHeMsjkrPZFlI=;
 b=lwuBmsfE7jggVx4hNFrQ07xl5ldZi6kBVTGY6TZpf43FaYwAciVUD+vO38J69nHnXy
 YZLBC/Fonc/39TD3hRWKQdL0D2jvEymLrGZ4eLMMu2DIxWZzOcvCQSGL+kRrvBxVruCR
 oCkqfbTRuvTRm0UuuSxXrxBk8AcXumj1rZtJIQ2c6tsTg8ZuHCnrhSqLSNqWtQEDbPzu
 /YhA6jnPJYcI6awSCOTa6Yfz1OhdM9WyVakvW51eDdaYakPRv6aygrrVHNqADhDIGyAH
 1kEXwB2Vq300Iy7QAf1GKPJOtkVvTc5cDDkO/6KIBTPtbZyhjVL2DC5+yeCw7V8YdsTq
 Wz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494996; x=1744099796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNXbkOwvuq2QN9fW+1tUFXQARVhg5/MHeMsjkrPZFlI=;
 b=mGB2cxiplQd31VfEZUFBaQ2P1xxOWd4n6WH4B1E4Bq5kflj02DgKVD1XRv4dN+hMhy
 QKw4Z+f4gG/U70DmDdL1rPjULMwy9UP1Z+ECqF6/fRPyUnjiMcjGSAkC4kvK74D6iUlF
 eDTIXb9EtD4+UCnnU0X4ZaNJr+k9J7NejdAhZbJEjdZ+vLcdPsHt59391iTmL4FFAUbd
 Sd7932McV6V/0aUWE3hkOIncgFyWQwS8ZRIKWQeGxByP/81vkUfbbwdT8lUvavg9/0cX
 nBeF67H35Cj8/O4oHb86Mfgno86UbezB28rUBzXJ9DsxPlEywlkRLnZ11tzNMYS/FPDQ
 NTEw==
X-Gm-Message-State: AOJu0Yw5HW1FeSlQD1JT71EinwuSAwl+lbFnZ3hygNvUYER6iER30RYE
 eIO5HQb+XuKWl0DrHGFnSc1pB81ElZAHwaseqrU5zWIJ8WEqw7+iG+KcEvutU9KlSr0hbWWEihK
 d
X-Gm-Gg: ASbGnctOX8SW9HangclWTX/zpk+T6GUpFsfVbsAOtEYGFbeaN9eZCNgOJ4iwqXfqfZX
 YzEnBoJI1eTfo19eozhzDj7/z8h8DPNf0amp6iDbs1fU3z2N1409pOHpcVSa0c2sW1FcPL7H28x
 fTKYfZBkAC3tM1oXoHckFTYSuSvWW+/cmvhDDvaGUsXdTnLDmJSWGTPcWSWl0yh+4ZqJT4WlHUs
 CZUDJZZYRxDdkojKi169iaE2e72p0oe2jFKEnrFrzkpfFKX+MtMprpe/XUA+pbw6AtdSlXBy8bO
 tURwyxEqaxqK5/f2bndcxpllYCLeY+yJAxBJMYuRm+WI82oGooFt6FzFx4UnmAB6f+yzo8ZoMQe
 4qRUaOflGXEFRImIiwkk=
X-Google-Smtp-Source: AGHT+IFtEW3DeI/hzpgUESKtYEKLKhgs6Mbr4tNYHRbNrvP9VQs+/qC7Wlw0T19hyf3l73d3vWcCRw==
X-Received: by 2002:a05:600c:458b:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-43db624b447mr106880205e9.16.1743494995720; 
 Tue, 01 Apr 2025 01:09:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10f7sm149580475e9.14.2025.04.01.01.09.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:09:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 03/24] target/alpha: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:16 +0200
Message-ID: <20250401080938.32278-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
---
 target/alpha/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 935ad2ee1ae..99d839a2792 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,6 +239,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
+    .mmu_index = alpha_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
@@ -263,7 +264,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.47.1


