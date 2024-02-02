Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9753EC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmT6-0002zw-FZ; Fri, 02 Feb 2024 00:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT3-0002ks-Um
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:01 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT2-00028J-4q
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:01 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ddc1fad6ddso1462886b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853119; x=1707457919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsEJ2g0LpvdUYy2sbV8u3yNlPUAlmvtjJu3b7/RUdbU=;
 b=sa/jom/Sl1nEyGR/1Rqq05zFugo2ObJAduqWhzQ5401X8H5UM7Zmslfy1T1HMw9HE3
 MD+655gITkh3ZePcTUY8aMAx9WvUv3xXt7OfDDh0vk/vH5/PTNgBbDqn/+I1hSu8vN5r
 e832zS9tvNyPRs93YuAj0WrA/VWAim2dZo9eQaAUkEJK2/QzMQQpPdazuFxph5n+7r+O
 5dY1Rb8ujo6FDd6TqL6n79EyZMPmZwnSfgygnfjzOKXGtM5O81xgOZn6aQL5kUJY2wC4
 IUIOMfcKLpiqVJlXx6FeBA+fEmgs53P4qPBksjZTlqIukwzd5gs0bhf9AK7ufptTQlsO
 p+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853119; x=1707457919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsEJ2g0LpvdUYy2sbV8u3yNlPUAlmvtjJu3b7/RUdbU=;
 b=b1CqAcZlCQMsEhMRYRBwg1U8o7+JKmI/UxLYH90t6poe5oGL6k6yl4trBXit2ZzO82
 9XzguV3zASa/SyiL/DYZwBZ7jkthgFXsKkEQBzNBONt4S/ZH2TjRjENyzrQVKIDCL1ed
 5QckRaVS3/b1jta68b0IAyPs1rHzjs2zCHMquTSwCZ2MIXW11GTW9XAmDJg3gyLNH31K
 W0jAECHBOvHr1upfOrETAKz2uIyZc3ksDQhHggeXi+UkivfmdGYIULukahH1g5gjhWXw
 yZWtdC/3Br4+43Jo2e5KsT0qypUlrQDMg5jq9PW3ZtHFSdO8kvj0dgUCvsGq8bmroAA+
 y3eQ==
X-Gm-Message-State: AOJu0Yw1Jqk8YkUSYprtZw6yidLa770W47XMx2YRIhGeRuJyw4Xy9FwB
 LLAzJYFJ3koKihrh8dSLBqfYcUIa0QCU+2VDCVM4eHh7PuoZCVkWM2P3VoF9eYLxgQfC2g+b5P3
 HTHw=
X-Google-Smtp-Source: AGHT+IGVWnMN0S7UWXe2NedOWawYsbLtQSlXWXKbcT6d7BLH7/obx2ckMvkk8sIqAFBbgnzGyz45gA==
X-Received: by 2002:a05:6a00:3cc9:b0:6dd:b12f:12ef with SMTP id
 ln9-20020a056a003cc900b006ddb12f12efmr5751673pfb.1.1706853118840; 
 Thu, 01 Feb 2024 21:51:58 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 36/57] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for ASI_M_BCOPY
Date: Fri,  2 Feb 2024 15:50:15 +1000
Message-Id: <20240202055036.684176-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Align the operation to the 32-byte cacheline.
Use 2 pair of i128 instead of 8 pair of i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-2-richard.henderson@linaro.org>
---
 target/sparc/translate.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 97184fa403..1082aabc14 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1727,28 +1727,35 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
 
     case GET_ASI_BCOPY:
         assert(TARGET_LONG_BITS == 32);
-        /* Copy 32 bytes from the address in SRC to ADDR.  */
-        /* ??? The original qemu code suggests 4-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
+        /*
+         * Copy 32 bytes from the address in SRC to ADDR.
+         *
+         * From Ross RT625 hyperSPARC manual, section 4.6:
+         * "Block Copy and Block Fill will work only on cache line boundaries."
+         *
+         * It does not specify if an unaliged address is truncated or trapped.
+         * Previous qemu behaviour was to truncate to 4 byte alignment, which
+         * is obviously wrong.  The only place I can see this used is in the
+         * Linux kernel which begins with page alignment, advancing by 32,
+         * so is always aligned.  Assume truncation as the simpler option.
+         *
+         * Since the loads and stores are paired, allow the copy to happen
+         * in the host endianness.  The copy need not be atomic.
+         */
         {
+            MemOp mop = MO_128 | MO_ATOM_IFALIGN_PAIR;
             TCGv saddr = tcg_temp_new();
             TCGv daddr = tcg_temp_new();
-            TCGv four = tcg_constant_tl(4);
-            TCGv_i32 tmp = tcg_temp_new_i32();
-            int i;
+            TCGv_i128 tmp = tcg_temp_new_i128();
 
-            tcg_gen_andi_tl(saddr, src, -4);
-            tcg_gen_andi_tl(daddr, addr, -4);
-            for (i = 0; i < 32; i += 4) {
-                /* Since the loads and stores are paired, allow the
-                   copy to happen in the host endianness.  */
-                tcg_gen_qemu_ld_i32(tmp, saddr, da->mem_idx, MO_UL);
-                tcg_gen_qemu_st_i32(tmp, daddr, da->mem_idx, MO_UL);
-                tcg_gen_add_tl(saddr, saddr, four);
-                tcg_gen_add_tl(daddr, daddr, four);
-            }
+            tcg_gen_andi_tl(saddr, src, -32);
+            tcg_gen_andi_tl(daddr, addr, -32);
+            tcg_gen_qemu_ld_i128(tmp, saddr, da->mem_idx, mop);
+            tcg_gen_qemu_st_i128(tmp, daddr, da->mem_idx, mop);
+            tcg_gen_addi_tl(saddr, saddr, 16);
+            tcg_gen_addi_tl(daddr, daddr, 16);
+            tcg_gen_qemu_ld_i128(tmp, saddr, da->mem_idx, mop);
+            tcg_gen_qemu_st_i128(tmp, daddr, da->mem_idx, mop);
         }
         break;
 
-- 
2.34.1


