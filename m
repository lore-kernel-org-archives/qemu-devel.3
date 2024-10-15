Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64607CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jkr-0001aO-65; Tue, 15 Oct 2024 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkI-0000nd-0v
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkF-0000ns-Db
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so1544699a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007157; x=1729611957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZLWKxN76C8sY7IOvNsANw/zHjCd07PTHy82cP8hbyw=;
 b=YIVWbctz/euO2msYVM+jEVt3Ne+kvsNrR7ofuLlTomoOs4FeAAG+AZM6h6Wu6x229t
 tEuD+8HhCRixK75sEyVr6KtIyZpKQVPQaGCOZKsv4fnyZdCd40R0ohK5z56xpOPIQ9rR
 34yfg10hqf+znlTOVwzpBgsI7DLMvLmzD+oqoiV9V6IQJsOEL83DOxnUV7dbNnj0ezIH
 KnZHCPhJuANmDjP5ZW1EDihqMoPJx/dhNqeZSpxEGF0YucNHSEN7BEiXrEvX1BR5PvFe
 yPXu8VPrUyiqhK5K4qvhUBeKidjoE7XubF3v1by91GkJMOSkQDw0393Z9HfF47+VNPko
 iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007157; x=1729611957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZLWKxN76C8sY7IOvNsANw/zHjCd07PTHy82cP8hbyw=;
 b=brj8+yq8Ogm+ktsNTnsSaaNqXC15jDtKqYcxvvfkuf3dq72q2cXb0diDDZy/jhsIqo
 iaJpbIgVz5M3ZVCF/RtXsz4WrJ3X5kX1LnXB1ixtZ2nV0dQIPzAjP6TcFqi1SxR1S1rg
 i5VvP5HV0P5B2k3H6o0lRe5JGleusgd2fT/RKv0ExkpQv9cQ0PhZj6RzQrORXGQzHBN+
 7LZ7HCa4f5IiDugSA/JAnijv9sjpuTJy4ZMuug760G++JqSWTRp4EFg2kfaGytdvl/4P
 Oq6pjvUiT9HwY6bN8L778nccKnURXKHprWhCJ1K0A3oQqO9MZvT9y+WUx/W/CwTQmPBi
 WA3w==
X-Gm-Message-State: AOJu0Yx0l5ZlR3NUOIy5+hca/nNe8xqY4NYYvrESvZ5F0VVi624coBSg
 nMbAijtNec51TPj76of90GhcCs66MWVyM+0eo8EGgTb1WFEmC7Ar3cpwLvS/T/722zqqYZUivUP
 h
X-Google-Smtp-Source: AGHT+IG06gqex6f9UGou6mQ13zmzsLysWsflt/rDmUAe3g7xPNTDKS3mnCwjLHCGRqfIdOumlSMZ3Q==
X-Received: by 2002:a05:6a21:1743:b0:1d8:aca7:912 with SMTP id
 adf61e73a8af0-1d8c95d5a38mr18109100637.28.1729007157463; 
 Tue, 15 Oct 2024 08:45:57 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774cf306sm1409704b3a.153.2024.10.15.08.45.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/33] target/avr: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:19 -0300
Message-ID: <20241015154443.71763-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The AVR architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/avr/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-11-philmd@linaro.org>
---
 target/avr/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
index d6d3c1479b3..aea71282a58 100644
--- a/target/avr/gdbstub.c
+++ b/target/avr/gdbstub.c
@@ -69,13 +69,13 @@ int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     /*  SP */
     if (n == 33) {
-        env->sp = lduw_p(mem_buf);
+        env->sp = lduw_le_p(mem_buf);
         return 2;
     }
 
     /*  PC */
     if (n == 34) {
-        env->pc_w = ldl_p(mem_buf) / 2;
+        env->pc_w = ldl_le_p(mem_buf) / 2;
         return 4;
     }
 
-- 
2.45.2


