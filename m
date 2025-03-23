Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB8CC36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGY-0005r8-OC; Sun, 23 Mar 2025 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGW-0005pL-EJ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGU-0002tt-MT
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224100e9a5cso66342345ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751457; x=1743356257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA9BN8KH+TQHBF8y80g6NTHRuQA2RHpbRpcidozR5So=;
 b=mf1Z64jOULGRXw1/xLSETzXbYNLRj4w/bGhpiMPw/5kISuh4Bl4Ho3O8c7U/+d/QvR
 ykGZ/OuGgbto3AN5YJwBnWtrZzklHlAD0vaRDJ4XPKkvZTDuVUpZHN/ETfBPnJRB0LLm
 6rQAe9QHniUFzZ8YmcpPgneklmLrRNw3brdUysHrq5OgS4RoD7TFZSR92aadqiMEmYQC
 qSAZbYNTNIfka/qrEVVF5o3XVF+VaSi5/+UJYJbikwVeH12UO3LlOpF0xhaaFCBymPi3
 +tWG7uHCICObli1mtuaHn45pUOp4Y/LeT73lKVLTmisYG0/PP9rctsI95McS3NkggFdw
 NK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751457; x=1743356257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA9BN8KH+TQHBF8y80g6NTHRuQA2RHpbRpcidozR5So=;
 b=tuGy8u+48FZsYzoiUYizLHx/U6+pjn75IOhRvIXfaXTyHR9EgAxQF++5vt5f/lwuq1
 AyU53csQQZGYODBWYIlozLtoXmsGkKi4FPwZz7CtpL4VQhsNjNUmWi6IvgXGmwcRvlQv
 3I7GkG1iJANPQCtIR0n6Hvnx2XR6t3caiRqp1aAnPZRMaJ1rOGg6luWjYSzkHmcMg7gn
 3FaVXMDYpPQ7U+Yf9RhpD2BqvCwG+BGOcaWXVKeXFllyzr/XZBBa5MzAxHFnHSYUi2Gl
 bNsvY/sByG2zJl/8ZA8hZO3EgaXBigyBJR7WrVvAzihv5LtnqyQU2cJxfKBYuxBrV2nJ
 Jm1A==
X-Gm-Message-State: AOJu0YyRhRfJ8Nz4aA8KK1/FLv6XDf/btWxLMq4MVmiTLVRwndpTiAid
 hL76i84DyayTJKSX1uUoFfBT7k4Fr77zMTU69vPMAEE+E26jSALevMnpinobnA38bY5z5K03UlE
 U
X-Gm-Gg: ASbGncv9UDxAHvmkpxXmAhgShdG5EiW+7gOF9oWCiTj+eX+qnAkSZY57HXVeIw5gkif
 H1dYM/tFaxPl4Ae6ef9Wq/66GJ+mezdtw57pBFdjER+QzY80YrAuqP/fEVKA9inb84DIELBtUP5
 olJ5qQgu9P6z+KTw5rg+WUP2vM7RC8d8IK1Z47dRERbRtJ7q6VdXLNyTTsLYn1ivJ3CKZDqBuM3
 y3JMe8NdkWYkdFSDgwk2unnNZdBjSL8MXbIFRHSZPRdBFquka334hRrt0HqrFSkyz2GqcuCGwIM
 Glv2J5NDoZwuLhafIRzQ3vSZl3fSfPGkRKbrKHAaoUDikJlk8MejpMyHaHT1w1aIQwAQ6dGmAHs
 bE5AY9qw9snY=
X-Google-Smtp-Source: AGHT+IHkOjuzjmhJgV6JaV/SXtj5NUSPfXQWfBo5RzZy8Hq2cwFPpGSc09FzCDwtT/9LWFsMMcLYVw==
X-Received: by 2002:a17:903:1aac:b0:220:df73:b639 with SMTP id
 d9443c01a7336-22780e0b2efmr153799675ad.36.1742751457346; 
 Sun, 23 Mar 2025 10:37:37 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 08/17] target/avr: Add offset-io cpu property
Date: Sun, 23 Mar 2025 10:37:20 -0700
Message-ID: <20250323173730.3213964-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Communicate the offset of io within the first page between the
board, the cpu, and the translator.  So far this is always 0.
This will be used to optimize memory layout.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h       | 2 ++
 hw/avr/atmega.c        | 2 ++
 target/avr/cpu.c       | 1 +
 target/avr/translate.c | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index be27b0152b..0f5e1a53bc 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -148,6 +148,8 @@ struct ArchCPU {
 
     /* Initial value of stack pointer */
     uint32_t init_sp;
+    /* Offset of the beginning of I/O within the first page. */
+    uint32_t offset_io;
 };
 
 /**
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index f6844bf118..273582b8af 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -236,6 +236,8 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 
     object_property_set_uint(OBJECT(&s->cpu), "init-sp",
                              mc->io_size + mc->sram_size - 1, &error_abort);
+    object_property_set_uint(OBJECT(&s->cpu), "offset-io",
+                             0, &error_abort);
 
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 0b14b36c17..080f6f30d3 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -169,6 +169,7 @@ static void avr_cpu_initfn(Object *obj)
 
 static const Property avr_cpu_properties[] = {
     DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
+    DEFINE_PROP_UINT32("offset-io", AVRCPU, offset_io, 0),
 };
 
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 0490936cd5..e9fef1aaad 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -92,6 +92,7 @@ struct DisasContext {
 
     /* Routine used to access memory */
     int memidx;
+    uint32_t offset_io;
 
     /*
      * some AVR instructions can make the following instruction to be skipped
@@ -2664,6 +2665,7 @@ static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     ctx->env = cpu_env(cs);
     ctx->npc = ctx->base.pc_first / 2;
+    ctx->offset_io = env_archcpu(ctx->env)->offset_io;
 
     ctx->skip_cond = TCG_COND_NEVER;
     if (tb_flags & TB_FLAGS_SKIP) {
-- 
2.43.0


