Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209ABC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhN-0006mW-Gn; Tue, 01 Apr 2025 04:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhI-0006lc-Tv
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhD-0005vL-SF
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so4321278f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495005; x=1744099805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfcvOAj6GV5G3ldirX7XsQaX70LEZxyBu8Djn/9K/DU=;
 b=ttQVAamIzjNngh9OvMZFLtRVT39JTwOkrqeE46Y2RCMi/t0mZ0qrL1pXt0wawoaaDu
 Ya1BkbpmnvAoR5KKKCJA+1pOXGh2wf7jchJauKXCvEZ0OcBTd8ilanjrjEabriruFR4j
 YXsc09LZSAhXJcdBR0Cqiz07ti3/VTN8yScBnwoGbvTwMK6s3sxkWTvyY/Q4YR9kC75c
 zBdmhpLCAVZ6hH81Or7UD21eyULSYo4WGt3Of3dm46/jxFj4isv0+JrikWH5aaKmW1k6
 bMELqP4JFmF6EXSEpbqyLN20QfF7igMyY8TiIJHUMAk934gLYWaEwRTH9gNbbctC6bM2
 aMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495005; x=1744099805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfcvOAj6GV5G3ldirX7XsQaX70LEZxyBu8Djn/9K/DU=;
 b=Dbt4e/4el6SZgYgO6JZyDuevymfiBgSKDfM8DG/TcUcbDnlYqE9kg1fc4VVG51BWzJ
 wAj3htmrK/Ww2g7erNZ6SvO5dB7l+oXvcDaFVe2Mg+AJ/UGVdvpC/rl6KQex7Yia8pcg
 VrB6eGzfqrx6SVpLzbNlf9GCdR7y4M2nYefQ7oy+d8iUJXAp+v9pbYMpNgX8nBLI0mby
 NS070/b6X82eNnWFN0GceT33bf8rX1Vxu4ziFZx5mZ8MpozLO0Zztw/Mu4GWNrFppXA1
 DahDLzPHHkOG7dOaA4Qk7pDlj99rJ2l4T9UxWFMKP5EvwuwWKwzFAmXe7VOoqpfddJHb
 N8Rw==
X-Gm-Message-State: AOJu0YxKiOvbdC46JNMmfSC62MvupC/OckOJTdW8QSEZqst/dQXiv9iZ
 0UIqoYDrTS160yJmyB6Js+1aEAmcrRWaQkQAXT+WvKqVhNJjidNpIslsx02wfKixVOtljo84M+o
 E
X-Gm-Gg: ASbGncuQtFJgyFBh2NjpYacsvhCEWTbDl4GzwkwQFWg2wCEe85VzomxrVCH0KU7zJV/
 YNjxvQ+Y7QjCwaClsizQ1yXdpuef8eCgQEu/v09lz8kmgA1TUnMEX6PIZP9yQQNya826s45qmVB
 ymZuK8sS0M17WMhi8aD3fVSNE3FRilC9pt8n8LD9bM5o/zIm2zvkvXHPGmP1vsU8JUZfYfHMBGD
 nULVi5RSS5YyiWzuzEFXSz4bWKi5Rm2JjWQyDHhRW0+t5IQzcEsY3p2fD16DXJeHzdyNJ4LMKLR
 BlFUmm8HogozWhlKSgRu/RoNKEwdRamCLiBiD9et7ciY/RYUceAJ2ECRc4b4QkMZESbjq0OZLRI
 lpQqAi95/TS3CqFGNZ2c=
X-Google-Smtp-Source: AGHT+IEOboWhSbNGNzAmlYR7B2bf83bg582vHG1VhyNedAg8v3uuqRAKXCGbtFCVvv/LeJ9/1W4CgQ==
X-Received: by 2002:a05:6000:1a85:b0:391:2d61:4561 with SMTP id
 ffacd0b85a97d-39c120cb57bmr9755645f8f.6.1743495005079; 
 Tue, 01 Apr 2025 01:10:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66277dsm13351147f8f.24.2025.04.01.01.10.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 05/24] target/avr: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:18 +0200
Message-ID: <20250401080938.32278-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


