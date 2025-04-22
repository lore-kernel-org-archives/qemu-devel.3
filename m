Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE9C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JO0-0003D0-74; Tue, 22 Apr 2025 15:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLq-000143-Jf
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLo-0006g3-1n
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227d6b530d8so58377845ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350331; x=1745955131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WONVWesSZ8uE3+nlVXH925QeCM8w4OWegE2KeFmY578=;
 b=l+ouB0RgIgQ6qW+ueN8D6UlcZw05Ie+uO5e3ASOdt7oNLgPy+6oDlf3+4/eVYgYa/C
 89JpStkXaEhcXHNX69rmYNml8c29fvIGv4eqVw7lKhwOkRzYlKM4lBfTyMQLL+z/EJnv
 jImRPb1AHyE/33ArTK+G0ATV6MG1FK6zewqTEtgHzEAfM4f9he8aXrBdf8ewvSKzEbZL
 O8xyPG/V0kmWlHU6JJXwRVlOjFLJpm3sQfbE2bKzT/sMgPrXLDfM8Zavwzmf6ogGVp8g
 j7+x7823T9X0UIVYOL+j0qwInKA8aYSBXI0pu0zxtXLKmZwxSY3yEbKCOwicqOams2vx
 MT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350331; x=1745955131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WONVWesSZ8uE3+nlVXH925QeCM8w4OWegE2KeFmY578=;
 b=JmhCrLqUt5vvy78r1RxsIFj7JyrtKslErBg5lps2I1J5OyGBMjFSd8IEmztFsCfiOn
 57sBkyd6hOWInrzEOSAvQL07dZMe8qUKlhUezcxSyAk1lUl7Dfr4qjTxbD7PB8TA/Pr3
 U+K6GRl5P4nqsJmkMhXhWPD4FnWJjDJU3a5AJRXo65s6N7TFdo+/U4yM1EmCHY82jQGa
 jY0ZgeLforwHkwhnOrFAFpNSnuEbbyEiPW4OF+U+RXbqz1kUD4en8IrIcs+KgSE4M3PD
 rJa70FvJJEydlw5JQALv5m2lsHODV3+TSZf9cNAaN9npyoUu4QeaTcORQDAZIKq9qfL8
 1qWA==
X-Gm-Message-State: AOJu0YzRrxaznJDqSQeiMIcqugc5g5FWmAMf7JyUCyLgvOhULi1vyVXd
 RhQItDqpV1mCPTqL1RTufXgUTCvtLENfIobNoMfH+QWRDjuHi28FzEXn8xnLscfJ9jDBuPTA6kZ
 v
X-Gm-Gg: ASbGnctfzR2AC50smc35NXCB1j5VrwH3czgbDnW+zEZXEiC/oVLWP/iD8a/gdiK3t/t
 wq+e2w6mGcIRSAMpEc34nTrPmUXBoyVZNlQkQl0dI/ltYutrzPXxzimjo1aeeAHg19y5NItjoQp
 YEMCOVDSI94n20CIG43Ehv8Mq3CkSdSiqC/dTclrdlupHDrzD/7dgDtFrzk5BylmjasOpA5Xaf9
 gO2V4jcKANwlxUJ91kNDPvWcx/4QLen0FV3zFX98dV89BBj6g+WOjsKFaMUiCKDGM4S/oM2GseP
 6gsHys7qZeRV7G360SyN/OIkh9MH7HmO9kO6YuaPv1au7py6HoSRR8zFfFv+LY5SFFpJol06ugY
 rhgE4XWAlzg==
X-Google-Smtp-Source: AGHT+IFwYBZ1oeWt8GE7VulNcweU8vSOj7sosQlTWWeP+66HNAxrcAjropyhfrEmFELQMxXKr3+MPg==
X-Received: by 2002:a17:902:c40b:b0:221:331:1d46 with SMTP id
 d9443c01a7336-22c5356e4a8mr207679925ad.2.1745350330615; 
 Tue, 22 Apr 2025 12:32:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 076/147] target/avr: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:05 -0700
Message-ID: <20250422192819.302784-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Message-ID: <20250401080938.32278-6-philmd@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 1121822470..feb73e722b 100644
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
2.43.0


