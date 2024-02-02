Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EFC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRr-000124-Op; Fri, 02 Feb 2024 00:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRp-00011l-Nr
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:45 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRo-0001aA-5t
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:45 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3be6ff4f660so1016763b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853043; x=1707457843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PumilLrArPZLdXkeLrIHmsOcHqv6B2J+77pEclyDIK0=;
 b=mHeK0vW7SeG8bGL4TCIaLkRjZpA1J6cqgtRKNOCopJ8UsPmpe1y4bSlXG3ONzYhfVX
 99M8yeuzulnov4Xv4s7OoIOrQofevMLO3dg7/4iiyFf4uwrTmjQH4HCzT/VJA0BY8h2A
 g/iJaXQVXcVGnsALy0V/PIVcO8F5Zh9rO91E5+XjNx9euAm/sci1M08F97TP/ggOWJS5
 HkPQydM0rA400wO2AxRi6e+JZ2tMNmYzwrPbhJcU/yAfHqIqWbMsk8gL2f9N2puj0BDn
 38GXkNHGAzOnelTpZBmCZubhfFqCxxCbUhEjHUuZBHmnW3DBaTRE5Ep4iC7gzhZzTigt
 kLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853043; x=1707457843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PumilLrArPZLdXkeLrIHmsOcHqv6B2J+77pEclyDIK0=;
 b=KIz6OXBUw0D7n4h+AzPGoGhOZuFZ5CKU8nOhiZhJGbG4P4IMgqB45qilZ+AEwtl4Ia
 1MPrZPlPVAYeTzey1VMVOqirK7mqdFUqsIiJgq9fB1nd6Z4wtpCPg9jADKZPcGjiaSCw
 6m6dyq7WvmPAwbqD8wYHnxuhvCOl11f3T3cs8wpzdNje4P3MuNy+4jbZzQtW9L2oo1XS
 JKdwzcokcKKLkY64pKng5W/3t+xqNPtuWQBKZ2GwEd0bruQMQtSXwjeGsivojl8c3a/n
 iKWrOW977CWiUadxoTXuADm2mCukkmYoXdEOCi5HU6O16x5tszXIciHeMOKC1toQUHe2
 wxdg==
X-Gm-Message-State: AOJu0Yw2aAXgN1400DUNCh1lWFy9+tQ2aqCqfruBaHsvwqHoYCG8tbZS
 rQu1vMDTLqA3R8Mw+MUCOx2D9AelezTJBAQMGkewLzW170GRssgQqyAOj2Z6IkPAvT1go9kzfpj
 /KRU=
X-Google-Smtp-Source: AGHT+IGt9MSIOmTnSEMnO5y+U1uG5LUD6cC88TAg/GGOpyBEn6suXyGW4OBxpAnuc8ZvFRxZvXvTxw==
X-Received: by 2002:a05:6808:4493:b0:3bd:e392:fab9 with SMTP id
 eq19-20020a056808449300b003bde392fab9mr1737515oib.38.1706853042852; 
 Thu, 01 Feb 2024 21:50:42 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/57] include/hw/core: Add mmu_index to CPUClass
Date: Fri,  2 Feb 2024 15:49:39 +1000
Message-Id: <20240202055036.684176-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To be used after all targets have populated the hook.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2c284d6397..4385ce54c9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -103,6 +103,8 @@ struct SysemuCPUOps;
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
+ * @mmu_index: Callback for choosing softmmu mmu index;
+ *       may be used internally by memory_rw_debug without TCG.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -150,6 +152,7 @@ struct CPUClass {
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     bool (*has_work)(CPUState *cpu);
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
-- 
2.34.1


