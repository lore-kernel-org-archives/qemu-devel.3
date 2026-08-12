Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7D5C5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV7-0008U7-9b; Wed, 12 Aug 2026 18:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUm-0007b6-Hf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUj-00019S-B9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so20736005ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573940; x=1787178740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DKitjkoYhgdSAIR+S5TNnpYovdxplzR/60XnIoKY/IQ=;
 b=Oe59PjXvcZS09L5dOT4/oj5Lwbp5iftm17P74uVhOcoSFNj9KPQVmCTpynzAaiJDNM
 uKP/p4awxv8jirfQ22RLDL9mOMh6EgTj7G8SeXjwMexmXaMhV+UEay4ED5acqvH7MrPB
 4U+rLJA8ytDWw1pJruqWNj4Ir6vUSgIAmuaSi/b1LUvqTblY7fUakn3gnpsc6yOLQoG5
 ksIYW01CCH0RX7WIZ2XVyiY9tMM9x3TXq2MvlN/whbJF495DWYyvOGKEVWdSH7WUfoNa
 c7PXT7mEZOfSVbyLJ6DYYb0NA7wX7uFJcguj5q4Bgd8MzD9v7QeFwGRzqb6n6OZNcGh7
 Mzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573940; x=1787178740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DKitjkoYhgdSAIR+S5TNnpYovdxplzR/60XnIoKY/IQ=;
 b=KRTAbykpVa+7+U9qqDZTU+XcfGtnQIgcr9E8mwrmA4F17JydBhXMFMhikviVpXqlSg
 9UHJL/mdeRPTfAg2+aZP+A/DjILN23uO4Lvg4aPNXm1NPeyjdrKyLZylYCwkwAo59dPx
 lY5gwsRvc8zXLs7kfto5vV9bvxACQ+USZdiOl9QESCcHxkYmjJcCL7c42PD6dmefj1mK
 dMLKDjdF1d1NeQDVnBGm5N4thhYmjQ9oX2YqsgeGoklNOFQbuAYzu7zf9qkNkIvwCPs0
 sufSgOJlhvrJ6ZNFmMwf7hBA59gjEhEpyvmEOqbmilk0+86/io3uc5Mk70ah6bquHM45
 Cu1Q==
X-Gm-Message-State: AOJu0YxhMaSMKaxOJmwLYryvQOdmhCnCL2glJgJpRorJy/kPycq93EEc
 cvCWTntie8oMpuorRG4mgluhk0OQHTuzl57/MYfXLuOFb5QdMkoXefNyQ89uyNihNdXBoPGOn4b
 0Ej1k
X-Gm-Gg: AR+sD11cPmMNrEbRGhXqruA0cBLS6kQinF/uI3lh8KkMTGxtQAsjc/B+zJm0RzNaFdg
 BvUDjIvIKlozWw30EQQ78gCckBtMRo+ralhMtnHttv9DSjiMwpgK+C3RgL4gQlLjOTNnb0d44qc
 5/esKG4g7kEeaMGhM36O0OhD/YnVhksRMR2mFT6H3V61KCdwftyyzdNZw1BAOW61Abp6FKnK9Fc
 AsrX31OUqarEflYuE36AqUcx5pslaTfC41TkKOY7DVSv1YE2U44Kll6ZafzUM/nOM4fvZlkn7pk
 KxpB8PEK2tUM5zoabPUp0oo2zojmgzv4LVVbv9TAgzyOQJn842wkPWMQA0r8xYxVetW6Q2gWGKU
 xhyYrs+w7keT5//Wx9VZNAa9gO+Jqwgy+le06XajsgI3rarve9sjdTyhPEURJ3oWCOCn8jP2YpT
 /D2d6bc0H2PRqPOKnSh97oe7N5dmcQ4hfkcgDKGmhPF2Q6UC851kWIlflD5lgrstTzKnSGUqc0E
 ZO3XqdcVFVzDYLZlSJg
X-Received: by 2002:a05:6a21:1644:b0:3cb:eb06:ce09 with SMTP id
 adf61e73a8af0-3cc5535230dmr2206757637.25.1786573939538; 
 Wed, 12 Aug 2026 15:32:19 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 38/52] disas/riscv: Fix rv32 encoding of zext.h
Date: Wed, 12 Aug 2026 15:31:28 -0700
Message-ID: <20260812223142.349142-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For rv64, pack with rs2 = 0 does not encode zext.h.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e650ad7688..5624e7f60a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3506,9 +3506,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 14: op = rv_op_rem; break;
             case 15: op = rv_op_remu; break;
             case 36:
-                switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_pack; break;
+                if (isa == rv32 && !((inst >> 20) & 0b11111)) {
+                    op = rv_op_zext_h;
+                } else {
+                    op = rv_op_pack;
                 }
                 break;
             case 39: op = rv_op_packh; break;
-- 
2.43.0


