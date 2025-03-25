Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF1C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0X-0002cJ-T2; Tue, 25 Mar 2025 18:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0F-0001Mg-GZ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0B-00072Q-Nq
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22423adf751so116948005ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942646; x=1743547446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEoa5+P2s+dvjQMF6oUGcAe5STudghf85RD71OkQiHw=;
 b=mdYuAJBb6nUkpq0aI58jwcnu0xk5zG2VDx7w6Qpn7KwfgEXPQ5t3M7KIdevOoo6QIa
 yCL9GyYldenr1SSrmBgvwnsdxSCAn6Ri4KhJbdPIDVQGUQu4+CkhyI9IK2GlKBtFHXez
 1i32lZc1pwHUI9klrf40IPV6T+hBRHBp0MtQ/vEdQI7bAmmVh/21Nt20BtAfZPfY9Yhv
 b1s0XSvxwy92WDJx0XLSsMiSg4sRCUXaXzPaJh4XiOKJxrhyLNrh4YG9Y2/DzVUsf0bC
 +wc5P/AvJusE8sI2yJp7e85HHtd1hLWfjuhX5zpDqzYY8MMKNV0tqQyEY7A7KsyI9FhE
 lxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942646; x=1743547446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEoa5+P2s+dvjQMF6oUGcAe5STudghf85RD71OkQiHw=;
 b=kpHhoxpsl3D8/Rb5duqYJuNisA8NOzFW1XBa3gSvn6C5WKbRMrZt4b5itKP7ke5N8W
 1rS8bElQBlCbnjARUx0Zl+8BpdAZUspdjLVd6upQ0v1ZzEHSydbiuXolDYX0N5hEKf73
 FGbGPYzE7+pvNJSGjSVUsUJMcWJMLdzBATnpvt/HApRFqqpSzgLIiUFPk3S4TioFEODO
 EJp5YFceH3YNnqDt47hGUY3rcweYi4pNmH1RHi1Kex1wSL/c8tC7EdGYjdQaxhdrnNpC
 M/SgIpDgO1jvx8fImvQM/hfCE/xHjkk0MkUh1uewraTWYyFeLLZySACv3DEgVB8G1+hD
 d2Xw==
X-Gm-Message-State: AOJu0YzQ+ZvifebEVzaH2EeCfmH3GjNKU1XdYPqU+jfYDU3x1FA41DkS
 wwWtjw7nPdgfklHsUnLyEehReQpnz9Eo+bh4R6VxtUTa/9e+Wm0evjTQ355YfAisRQ3k9XcoHwR
 N
X-Gm-Gg: ASbGnctGc9EgO4HXLy8abp+w/PJO4f43YHfYHBTCp27dWWA0bzygHXIfUciIvGf3Kvo
 GOC/l7UyoGUB7Iucfos9JuJThxX566PfjcPNKhryUujmaPMAvKx3vQiarKYCKWBSL6lb10+Ue5N
 qgNx9BjHoITvQvr8tgOWYS8LZezvvFc/IeVqASPIlkuyvMwaGPErVDsWJFtiMIAw3pDpLLzOT64
 yO+st8P1R/BVg0E5Jz3o77Twu2gBxf1DfztdGTQhoCs+F4mzUc1PoRx7Zqp4c87hSFX/pThwBpa
 PT08YQ4JUZJupomovgdW5RO5csivvv0lj6nAo5WHBeijEmCcsDoqxuAoQr7CrjmI6nVVa93IG0c
 T
X-Google-Smtp-Source: AGHT+IFnjpLQqFskCkmRthOCUw2WWZMAB8rTHZgfcwPMPqwOhf4H/UfSI+lZ3iEOB2qttPWlZdM+/g==
X-Received: by 2002:a05:6a21:9188:b0:1f5:64fd:68eb with SMTP id
 adf61e73a8af0-1fe42f07ba9mr32640081637.7.1742942646156; 
 Tue, 25 Mar 2025 15:44:06 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH v2 02/11] target/avr: Improve decode of LDS, STS
Date: Tue, 25 Mar 2025 15:43:54 -0700
Message-ID: <20250325224403.4011975-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The comment about not being able to define a field with
zero bits is out of date since 94597b6146f3
("decodetree: Allow !function with no input bits").

This fixes the missing load of imm in the disassembler.

Cc: qemu-stable@nongnu.org
Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 2 --
 target/avr/insn.decode | 7 ++-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4ab71d8138..e7f8ced9b3 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -1578,7 +1578,6 @@ static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
@@ -1783,7 +1782,6 @@ static bool trans_STS(DisasContext *ctx, arg_STS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 482c23ad0c..cc302249db 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -118,11 +118,8 @@ BRBC            1111 01 ....... ...         @op_bit_imm
 @io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
 @ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
 
-# The 16-bit immediate is completely in the next word.
-# Fields cannot be defined with no bits, so we cannot play
-# the same trick and append to a zero-bit value.
-# Defer reading the immediate until trans_{LDS,STS}.
-@ldst_s         .... ... rd:5 ....          imm=0
+%ldst_imm       !function=next_word
+@ldst_s         .... ... rd:5 ....          imm=%ldst_imm
 
 MOV             0010 11 . ..... ....        @op_rd_rr
 MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
-- 
2.43.0


