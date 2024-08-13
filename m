Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31210C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtKl-0005NB-J1; Tue, 13 Aug 2024 11:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKc-0004t8-7T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKY-0004dy-6J
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-36fe10ec0d1so1233192f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562458; x=1724167258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x85ykqFDZu8XaN2LTiNqxv27m2mGls/KZaM5tdOiodw=;
 b=rcW3STUoAQ29yy2unFgvHnSJOH+F2FL3/FzXXcHpyc0G69HvkKrLOLZ5LwF2WvN6aH
 RYI8MVD3MBOGVsSCt/VgVnTz3YUR/lRvLw4emnS9gYtu1HM4pk0Uwc9YfDuXhgISsBE3
 m/sEWj9L8lx+CJWO/7nzqIMAMysoBsgx/rdMB9MiJn6eBUT9B6uTuHROqdYEnLnkWoiI
 ObfNbr74pk5nDP/hkRj/Q5pN+FDJx9EuAvmXYttEVDOUFai7xovjX6O9gKEOFPr+13Z0
 2S9recCKp38nKn1nfCmTMRPI7+PMRDs7WW+jwxb/ffBvXMUv8BbrJ1z5LH7bBAmfYmuJ
 OpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562458; x=1724167258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x85ykqFDZu8XaN2LTiNqxv27m2mGls/KZaM5tdOiodw=;
 b=Iwy4XBv9rHZRmkBtf9QEtOZOQI+Oc8AioHQfNQIS+K6wNmTvuTdhxhRAiiXjTS4j6U
 UeIMKflQdIwSiWONLE8fc4LomSmE8DKDwvmop8MGHLmv/GkkWaMf4nWFlv65b50N4FeV
 eHIF1U01o7ctCTh5rX4wfCihSgWUxiyhGcWYCc/wKT3NLOBClc19EzFG+izir4nQkSfp
 fozdC2jDu7dkjC8RXrySsH584ZK54pND75lbsMEN40z8c5IRdpJ7FLYb5E+H+QSfM79U
 8osGNEQm8VwzYuVuV8j2Mjp3y/urUMVWiDYusXw5GoLLh5yxQJJH6zJGTeulvZ7bAQY2
 wtAw==
X-Gm-Message-State: AOJu0YyOkRpC6MeOohIrkvVD3iVaBwlTs0ZKiri/sgh67/3o3EKZoTq5
 xW3CnoB+WUD3ES9VVNoSImSZv3mqVTu2UcUUGvrEShVFG2J/s0Ar/8aWMb2x2JgnrmVGUM4sJ90
 A
X-Google-Smtp-Source: AGHT+IHtv4prgoV8trTiLnaf2KdHDhGBMndnIPqrIb+snl0cqPTPnUiDzI1Z93lzXI5VWAxmE2nEoA==
X-Received: by 2002:a5d:4342:0:b0:368:72c6:99c3 with SMTP id
 ffacd0b85a97d-3716ccf2a07mr2666987f8f.14.1723562458216; 
 Tue, 13 Aug 2024 08:20:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee676sm10654792f8f.49.2024.08.13.08.20.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:20:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] target/arm: Clear high SVE elements in
 handle_vec_simd_wshli
Date: Tue, 13 Aug 2024 16:20:52 +0100
Message-Id: <20240813152054.2445099-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813152054.2445099-1-peter.maydell@linaro.org>
References: <20240813152054.2445099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

AdvSIMD instructions are supposed to zero bits beyond 128.
Affects SSHLL, USHLL, SSHLL2, USHLL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240717060903.205098-15-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 28a10135032..bc2d64e8835 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10756,6 +10756,7 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
+    clear_vec_high(s, true, rd);
 }
 
 /* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-- 
2.34.1


