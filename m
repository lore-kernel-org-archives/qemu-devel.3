Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CFDC3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Gu-0005vt-Uy; Wed, 02 Apr 2025 17:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gn-0005hz-3Q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gl-0006Rp-3p
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso1603405e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627905; x=1744232705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bhQz8qnl3GjozkFzAQJFkCTCn+/bGKdmYx7WhVKhHmk=;
 b=b6Oapszj1GDikATfl5Buj0uYklF0D2LiaGMO3Qgh0R6UlqhN0UJ5Ptcp2rmU6QLAAN
 F10TjzW9Ng9aj0tkJDCQAj2zb7XZXwPHVOd+cCbQdP63Nr5cPzvvFI7tbDJthGUCSDA9
 9vSObunEri4U6VkPclFbiIQR3oGDHbE/HDwGu5sDpWfZlQ+3vsKVBgISwpgyqflkxDel
 myy0iT1vIO5O15W4zMW9iOhNrwRbDGDuBI5MvwgawyU33Sva//yprlSXWwqNdUeLvwWj
 THllRHtmrEwzvhzuRHYLb76Qu2+jFz86QRf87yYA8nm/bzpcPZQ1gGBU9h6Wx9PzAZhq
 ++pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627905; x=1744232705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhQz8qnl3GjozkFzAQJFkCTCn+/bGKdmYx7WhVKhHmk=;
 b=wskp9eE4Z2UvjRslwAp97SldvT2lZOt29YPexK5CY01FPVTGz8JTA1IN5RagwvpmNn
 j9QnWbcOuQSBnEyARoue9gs6YE6R7bqADaky/I2yOg2UzbWAGS0JPNgwcrx2W7KtqLYg
 HooddRQl+ApaoU5a/Lt4Mg3KAwFqkaKf30+UibzEhtILNRDOfm4x1TsiS7nO/AsKomSh
 R71IY5nDoGXAkyZ1v/TrS4RrS9Rwoq3gOwmRzzfjrrlG3t2seNsOPCiTmz8E2mPpBtnG
 VnNvbTmhQL6OpvPL+6BFyFjjTm88jywpeZov3StrKMuXHE1hMlyTSvIcb9vd0xFk6ZWN
 fQVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQLujAapDb1cWfm0O2T8GByQtDbRabpFXwMwMoc2/2KP8LLpXC544osH24qR+fbvTOa6uR2w8pPnE@nongnu.org
X-Gm-Message-State: AOJu0YxW0vR3l5zmUm4ICc4hYPqxdn5UxA7eoxpqZeBFP7CwEM88AW5Y
 D04XQFoTokFlAigBmR8gUKKBiN+h+dgHoteJMn+gpEihrOkIK5YI9x7+ZsqFv0M=
X-Gm-Gg: ASbGncuK7oYtyNoIPh1/WDY6XrjsTxmJr/4xMLhJuLsjn4HZjPv99VSUOWsafvYuLG/
 KUX8t/r6iRDbedu+AM3/qKafT+vfgAsjcjPKMzKc9Amd+6okLj4n+hUifkEtyawaZGzBjQSPmEC
 6DE8t6jEeXu44Qb7uUZaf7jfjtVovb+Mg5hlOZaC+4SYdzAqLfvEXPl5WK2OkCC6F+6gno8XNxm
 xbKH6DRSPUjubxEOuS3yExiJ6BN5gh961aQfILlQbkZlQS19yTfJZYbg8He/nTi8Perl32QDW0G
 4Ln/By3R2I0OmzHyHAYGLRFJyQgwDxo0a3qsw1CYwN1UrCe7Z1Vg0zQzIA0gz/uR2LZ0CXzhlSP
 xrBdRCPl/VDfXlUDnv3HIJGMlNN5azw==
X-Google-Smtp-Source: AGHT+IGhY4X0JUyC7lG+BPC0Wdk/COECvZbOF/MREXD2fw/yw37+GVnZ6yIbDE5u7bwoazfqcpuw6g==
X-Received: by 2002:a05:600c:5486:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-43db6249aefmr164738695e9.17.1743627905357; 
 Wed, 02 Apr 2025 14:05:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163156asm2106555e9.7.2025.04.02.14.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 20/43] target/rx: Restrict SoftMMU mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:03:05 +0200
Message-ID: <20250402210328.52897-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 723262f4b54..e14d9cbef93 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -208,6 +208,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .translate_code = rx_translate_code,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
+    .mmu_index = rx_cpu_mmu_index,
     .tlb_fill = rx_cpu_tlb_fill,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
@@ -228,7 +229,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.47.1


