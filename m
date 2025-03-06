Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A03C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDW0-0005E3-EA; Thu, 06 Mar 2025 10:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVe-0004ZP-3A
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVX-0006mc-5n
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39127512371so630910f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276293; x=1741881093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8iAMOsd7yhgOQOkZMNXOMWl45bAeyqtgN6CSQKPbqzQ=;
 b=QtUAL6MIgsiVYwYRVlsUXwafygnWQ8QkxL0nBB7haHd4LD7TGrRCZjhVVfsAk5vRT6
 +G2nYIjS6yAaPJc9C84lEaw8McV/a3fi6JG+bxZ5UtEppjmTKMIacu2iBl4Rdqz2WkBK
 Ym9gZe+tzmTndyycy6jAh6f7u/RgVlUxwBfmYt5Kwu+MCTqPLh95Cu1owNvwgZTduJMr
 17nSodLdJ6BM1YPBQxvZ7CNoLBkIxXOCWzIPtKoY6q9a+9MFeVjay6U3Kq94F59UrpPn
 3ZW2LGo2xZ44HLTXGm35jBQkg6PzpFz9ZWjpNQfEz5K3LoDS5qV/2x+g0Z+U1o5D2099
 FiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276293; x=1741881093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iAMOsd7yhgOQOkZMNXOMWl45bAeyqtgN6CSQKPbqzQ=;
 b=uEfSncPq79KihvszHNuO5Di3C7ZqQMjZwJZenBrpkCgCISEruyhmloEMhkZz6/amXQ
 BFYY5RInP6wsmuxALTDWFvGlamy/QCJRoDiIljiSsqb2+LdWrRDr6odYeZVkkWmbhu6A
 yR/8ZTiwvWvFEaDczCu9FvG2Bx5wJwNXuJY/hc42NE6No7o8Ha9JUlX2Km6U2K7dviXk
 0unjwEoHW5dZDyHZXoGBs3zNUg3uq00w0XzCh1vAyqUpssOVtURKX3RoltFM7YAL/8FG
 FFuGEc2ufwL0kek3PUlcCwF0BpYk7mLG9UO0M5qcF8QU4ihpCW7b++T2OMW10tcgJA5e
 RGgQ==
X-Gm-Message-State: AOJu0YxJJ1DzqXOV4vZznW/ebh0r4T1oq9/X2oOtVaBA9unw6IzF93Nk
 phY8R1AhEk7R4iu64u9QOPw1QKnNF7DXeXFduVAVk3i7fxLaANute5dBh9Vg20GsaIrZySvWZej
 Xcrw=
X-Gm-Gg: ASbGncv638T/II4gz5qJiUbNEPonCcvuEcMYl4xaNggVt+cGRzJDzMZIHjrNGyQWv83
 2bOY0XD6OWHDUMorP5togj/QU/YkIF8nzRVemBudBJuwQtArvX7dgf3W/d4K2fiPhW9MYdjETMs
 JkVlsNRqXC5qsUQmY8j5z+zGh6JtTgGtt8QV4o/aO2ujAJp3ZfNy342vSvnLVUAcxJCT7b5hL0X
 RxEYl2zUAMw1uv4tk/+EdH37MtXBxc8lcVgNxWwYiBFNV/4FGlKIqZdu4hid/lRrrVFQ+6h+B5m
 4840Rx/4S3rg9ROO8wKOrm7Z4w5tYGq0VrsASM2K9xdnujO4PNwjIBR5/4d6hgBHBHAR9czKizT
 s2gllY7VasMmRydtpjhI=
X-Google-Smtp-Source: AGHT+IFfU6FQV9Lj5NaK+MWlGh1nIjCTFYb3BmaFRFUZYNuw1YriS+rY5v1o6f+Pr2eL8yRSWtAm3w==
X-Received: by 2002:a05:6000:1844:b0:391:306f:57d1 with SMTP id
 ffacd0b85a97d-391306f5a44mr873346f8f.35.1741276293277; 
 Thu, 06 Mar 2025 07:51:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195bfsm2411546f8f.48.2025.03.06.07.51.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/54] target/i386: Mark WHPX APIC region as little-endian
Date: Thu,  6 Mar 2025 16:47:34 +0100
Message-ID: <20250306154737.70886-53-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

This device is only used by the x86 targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250212113938.38692-6-philmd@linaro.org>
---
 target/i386/whpx/whpx-apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 4245ab68a27..630a9616d71 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -231,7 +231,7 @@ static void whpx_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps whpx_apic_io_ops = {
     .read = whpx_apic_mem_read,
     .write = whpx_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void whpx_apic_reset(APICCommonState *s)
-- 
2.47.1


