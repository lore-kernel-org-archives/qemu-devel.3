Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F3AC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kug-00005V-1M; Wed, 23 Apr 2025 20:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktQ-0005lI-AU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktN-00054w-RQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2264aefc45dso6732175ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456200; x=1746061000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMqpwELVZjRand5YykheI0qauU6tLGMgrXCPuO0m4X0=;
 b=VDAqTs1XFhRi2AyLPVdLTig/JkWk7rkD9cro2VvkmHyW6gAm5zR+Y+qMCIVIpZdM95
 miz6KZyu5uLQ4B7ttjH4g+/St525N0a5d0sIJSKn0RMq8e8OwH87B+ZDXLJUHZFQAlb+
 P2/5xEeovLky0yNlPEfCWAuNLs+csF3sezf7fkgrUqHuioawzdVAiVvt9WTwoS8u4qVj
 vHvcrXr9GifO10SVBIJwp+HFgo7qAGPoCm3sa/U1zu88t2P71bxmOD+iH3iGM48UuDzt
 iG2CUQv1zejAZO5RgC47uRKJqezLBxfaKcY2X96VDTqACvo45FnRHYZNsIwxw1Dn7udg
 M+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456200; x=1746061000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMqpwELVZjRand5YykheI0qauU6tLGMgrXCPuO0m4X0=;
 b=tjFJLbfcCWj7Hlna5loph2ffwwamgryp0hWyS/YCdhos8nyvbWho/1DACAipceDI/4
 n1lpXFC8FjNQ2SEo91nJR3Vz1sj/CtasGsAaqN25P/JvileCRX+9oWIB11o4QXmTHc+x
 my0t3IWYub7ORKXQ5bQ0ftZRl8tY8Cvw99gLgYN/mJKc3KDLbGC/wYB8GZB5xg3sWwDz
 jI8DF8q5MT4mxSnP3Zywd/RsSg6jp2pIkyQL4YPPaXjejfE1GkX+QwLfOOdhylOD55w6
 70VYQDueeS7I8AMQQlTHIPeoXS6oWZNUnG9B3k7dEcYYdmwG6vfvtRZHzEBqq/CavsvM
 w0qg==
X-Gm-Message-State: AOJu0YzF5EBvktUJc09eLCngv2kHqDSL39N9zEbPnkrWbReQ/aOMCPBv
 V8OitYP7Mtpr2rn/KyKQqJndlopKaUI9Fs2RwR9cMIzai6Jf5nKhvOKJnvWx2OWz61NeS7ZBo2B
 L
X-Gm-Gg: ASbGncuAvWydpE65SB82qeTKvYDkohrTYLKAUJ1pX6qlFrgyT8nWUjAJRJJyX9wa7NV
 Q1V8npC6OUfzRWOI2WE07obFlZJm0a+RUdgoXJWpwG3XOM7HZYX2KVIp8fZqpCgviDbzotcBKtL
 0L3n+NuAXvP5CkB7TRfMfhz5553KC37BqnAFPG30ympSOLX/NxWI0l30xwR8OHyG30qQ7Hdg7O6
 r/8/lMYTK9JZd6S28MaqUeuk/tef8QWI4sVh85SpkWLLEW792vNvJkcSyI2eSv/YLkZZw+GchjF
 NYndF2caG8I3NdgHWSoUoAXUc3YyhoQ08uARSF/aUPRABRv3b+z+a37sJ9azQBZMBalNZoclGpQ
 =
X-Google-Smtp-Source: AGHT+IHOzE4JUtwpS4mtwb6fOxb/QQl2DTZ1gDGkqU5D132JXcGg5H7nOw2EiMxZzECWn5LwcTwUlA==
X-Received: by 2002:a17:903:22d1:b0:223:536d:f67b with SMTP id
 d9443c01a7336-22db3db1585mr8602945ad.38.1745456199760; 
 Wed, 23 Apr 2025 17:56:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 088/148] target/rx: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:33 -0700
Message-ID: <20250424004934.598783-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-18-philmd@linaro.org>
---
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index a240b3b3ce..51743020d4 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -207,6 +207,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
+    .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
@@ -227,7 +228,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.43.0


