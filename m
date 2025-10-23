Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DCCCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmj4-0000ZO-Tz; Thu, 23 Oct 2025 00:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmj2-0000Yd-7D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:14:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmj0-00075r-Fw
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:14:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7a26ea3bf76so492833b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192892; x=1761797692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZLyqH7Fvcg+HojmfroD3Z/4L2yTHzsWHg7CTJ36+8Y=;
 b=l6r8D6/ylcaTpHjfKC8W6At8h5LJqMbRiBNqKBoPJdW+262l2JHTgeHaMwsCEVnssc
 uVyM4lwopAzq9//tPXeyzit45VNuBDHrqsXusyyYTBhU/YCyF3Ck4q3M2E8MGE/GRFPm
 MSk90PucKmdfqOJGUnZd6Fv7yPsAg964abQBqqDsKX6d7FeKZKCPZtHzLPzOhuC73mCB
 xnADQ4FsztSNEpEuzUnIazkQXgU3aYGlvjHAOiZolYWVV7b0RL7TaAY3IySsfRsryuWI
 Ctkfkwl5pQmcLjIzah31warKAF+uq9f9xFT+XTq2KU2p1Ml5To1kx7gyO0R0iiHWurPS
 MeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192892; x=1761797692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZLyqH7Fvcg+HojmfroD3Z/4L2yTHzsWHg7CTJ36+8Y=;
 b=fcyj8RQZtNHH9DSojIgMMo5oe6+e9+bEz7JjnV+h3aX0CepcPvTUxueH9BjZdnCF2t
 cDtC015EnOVxEVulitMj+bHfIW+qeaxCy3Fbe/JSMi7K7HnQUa3id+DWeX2NM92QwdkH
 OMbk4pLBCyEIVxUYAVLtpUMzJFObYE7hGjbN7RjoanEvEkNj0OWs8jy3fio1o2wo1XrH
 oUvqT1EeI75vuDioJ9e27ZO+83wpo7M84U1jPdpMIQpn3SnSmFMUXpSOMEVur4eFZZx9
 PGW9GAMFZTJe/JqfNbY/IASCWR3ZJ4XqbXUmBK0Tn3RIbXxZtLm7108j01qmO8NMT96N
 hDRg==
X-Gm-Message-State: AOJu0YyFZqBJogD20w87N44BV2cHX8A/h+uMP/8nYASgWDgOtjH3gEbR
 Rfa0twekZmjGZoeyOkKpNID4TKc54mz6Cp6JEe08GKZsJpCETk64YZUMUHcCwA==
X-Gm-Gg: ASbGncvDbtesD2ritS+kvR1n1jC0J56UTm8jQ0dA+XARq4w5HLjWTh2Ppl+y2m1iMMN
 9kvdNobe3jk8d65ncmdZF2o0zN59+ErGu0KCkVNuO6czN9eHMqSxGt3pYisaZ9pwwc/0QZMq4A2
 yQY/anoxgbrxDg7D6aRveSSr8S9ARvP8LdpzYZuYzzWNDVk7N9UEoUc927ev70pnzfpfHtMW/+J
 99v5rJYtsga2+bP8LrWldROxjtB4M/od6xQ77SnR4N8td6+8315eIvz2rC14QH15cSaPGaRj2zv
 b4cvKK46Kmp5JVtv9rfxMQwSm9OTuhxs00+qHhyu0+jzBASIKc9fndf0UtA7HQO6qxnJAeq5H1r
 zUV+Z9TmbLNKxMPy/q5e2MTNnl+2rKrLu4uBtLCGXHBJ/6WaPWtAQtBM2Pg5Fi3+XNAjT5ucOhi
 7bfh8heRou4PZrKYf8sjCrkSG0kpDonJXDK30TldtjIJUPRV/HKFIAEoGncfV1nAYheGBPCYYPl
 JRr2Whvug==
X-Google-Smtp-Source: AGHT+IEbHtFN2qNjOKXvewQPRvUxG1jhIPITg6L0VoOnDExU6Y6Yhp3O0rZY1+/6vTdIMink5uofBQ==
X-Received: by 2002:a05:6a00:1707:b0:7a2:7792:a47e with SMTP id
 d2e1a72fcca58-7a27792cff9mr697388b3a.8.1761192892476; 
 Wed, 22 Oct 2025 21:14:52 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:14:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zejun Zhao <jelly.zhao.42@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 01/37] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
Date: Thu, 23 Oct 2025 14:13:59 +1000
Message-ID: <20251023041435.1775208-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zejun Zhao <jelly.zhao.42@gmail.com>

Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
mode since it's the only supported SATP mode.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..3e1ed209ca 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             if (is_32_bit) {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
             } else {
-                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv39");
             }
             riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-- 
2.51.0


