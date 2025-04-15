Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639ADC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mK1-0000If-GQ; Tue, 15 Apr 2025 15:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAo-00072P-LE
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:23 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAA-0007HD-NN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:17 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d5e68418b5so45526075ab.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746090; x=1745350890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PyhEgN0mIJGGiyzE5W2aicp1atbl6/eoYjpO/+ehjjo=;
 b=WchTmG0LZD9cq21cKDCvBjJgi7QLOgyY3YcuhULl7oA0WbsFVlucGuUvAPtaovQgDG
 wgam/zkarkOjMfLPrc510CUSTIGmRQn+R0K5QPpzIIxD29FhG0XQr0pVUR7bwa/LYtl6
 y67DaGaPDbIXNN0qjALL1Lpb0gblXv3wF+pmRvYNrcGmGoRy4eCCTu5DhA6s+6PesJQY
 4BJP8qCkB5zG8oCCM7xUgbtuV2LDjJzfZX772EtTzX7UXpmZjYfvfs2bAUH4eQvEoUWG
 RUkwWzNYmST4fXWbtEuE7q0mp7t6qeco4NjIvkoai/umk6Ch5XmkEdRo7CnLVkc9WYG0
 WpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746090; x=1745350890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyhEgN0mIJGGiyzE5W2aicp1atbl6/eoYjpO/+ehjjo=;
 b=Qt5cpuDKQtIzaPetiV67d0FetGzTGaEBbSV9mBzBvKg1hbaJwqvW9AXHKPNvUqqf8x
 YasZDb6rQ5rTKW5mmojNP7dRPLvacb40336ZuPaY2+B6wWpC3PKdNQZPhdkrYhrGa4np
 Kvl1jyjGw3WNxsYeQ8xpzbA/zvA41/cmx+diDXt2JT00win4eaitwdqrCYvC3dnpQjZH
 tX45jkjRkgHbASKALKSOim/5TJst3t16f1O2PDELN/TjDpYaGNNNinAIisQb/7z47hOS
 DQj4KMdE61APOHwlSwoWGNKlE94r/CSa46D85ue+T3EYp14P7RqO3P1vLxh0gQIr9Iy7
 FzZw==
X-Gm-Message-State: AOJu0YyrkRI2FH/T1LkvzBGEFID+m0vliPnVYdiTkRwjfCBvs9t+JScD
 hwh8Z6W3qcOmdz8CUWkkbRlV4XbfBtUpGziErkWE2IXoTeoyA24i5gxMltvOwmj6HVMuMl/+Npr
 8
X-Gm-Gg: ASbGncseAwk4q7u2tq4R0HGbuDmknEp0iHjtzAoVCrj9u0/TbzDkGt0599xHnRhif2m
 STDz9QA7cIdWnuMAZIW2f90XObDpIx4oR9rSErISzIkzb3cAKnB4k/mBKgt0/KXMnx/CHw7nI6A
 Qcbg4lCxkCkp5SevNfe1Ruqv7BfKpF8S6Q9/8m5u/ep9wDwf4J74mqSzG62aapzVyuww6YV5Tll
 4WLgtjVQer9W/pjIX7qWnz9LHczOwVkMxQHj4vO7iaU/XiqrwqZUmPwJAaS5OeOAGEiPL9W4dJg
 yc1zj/7AlSbPn03yJAuPEqmcSnrFdmZSQjglXcrP9j/PVn0Yhf8NyOpk5CH75p/TLCsnMu+g4nA
 =
X-Google-Smtp-Source: AGHT+IEgw6ebTL65Chlg7dQzB4jyPVVExZdemLIrQUklxz1Ir1l6D4ybFZWjkT0rIVrORJOGMeTYRw==
X-Received: by 2002:a05:6a00:3001:b0:736:32d2:aa8e with SMTP id
 d2e1a72fcca58-73c1f8f3b5dmr885547b3a.6.1744745766463; 
 Tue, 15 Apr 2025 12:36:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 131/163] target/sparc: Use tcg_gen_addcio_tl for
 gen_op_addcc_int
Date: Tue, 15 Apr 2025 12:24:42 -0700
Message-ID: <20250415192515.232910-132-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bfe63649db..392b51196a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -395,8 +395,7 @@ static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
     TCGv z = tcg_constant_tl(0);
 
     if (cin) {
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+        tcg_gen_addcio_tl(cpu_cc_N, cpu_cc_C, src1, src2, cin);
     } else {
         tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
     }
-- 
2.43.0


