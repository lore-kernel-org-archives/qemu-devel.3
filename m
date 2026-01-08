Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0671FD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdic5-0006pA-Bh; Thu, 08 Jan 2026 00:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic3-0006Y1-7g
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdic1-0005R5-A1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:10 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c0224fd2a92so1511474a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850268; x=1768455068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ufmR0dPfCVZ18+gpdaZ+da9JlZlcYMHfZUgCR+6mxMo=;
 b=nvGkf8sJRdOWwgJFeS2R8sP6KF4YXiQLh591tuuCBM8Gk33x7hIiTXI/SNmPHvc3Wc
 uN+NyrDeXpNTPPux+P3SNdiWNrC7X6DljnSU3632Xw+b2XF7drFkEVjHhjJ7H7JeiMYu
 lTwU6tRo5ZQ1aJHtKFHYOQQU8iHHbDEHi1RgHsz7HiIe0ieRN1+MBIavo6+B9wFY5YXG
 entXuXKiwq6q+7Qp7p5emQFAG3Ar3ASjlJasB0mVZfFPot0EGHlUuhOF8K9e+10frSOL
 WZE0VxfYwxWBC9p+yu1E7xfuDLv+ECUcEp/JWxhjm1qY/sSIw7PYKSc13KZIaZ1rS/tC
 9BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850268; x=1768455068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ufmR0dPfCVZ18+gpdaZ+da9JlZlcYMHfZUgCR+6mxMo=;
 b=dKM6S5A709Rfdq4VKYHj6HMuJjVIGqGmNn9iAX9zWSOVyEFg2Uk3R2rSAfa9utUZrw
 RUxiKQ9wCZu4Z3VXIY/nPc/uL98uGm28TVYOi6BUiQSMkhMwD+KPiA9nCLf6+p5rkjWt
 WQ7f5A1c41Jd4HV/qARKhTuTOIMUTUQ0QbxHbtyAapx+HRg/TMm9fgensm6MVH001UsJ
 bnPDeowXn/fLtVB/mnIh0Z2yvKkIuZ5Rkb247Bm5SKyrERNVtfx1NK3UJUQOi2YWBCSL
 /BgdBdsGeGZc1014Y52I/VxUZIjGpQoj8CovnAAlpkQYAArwVuomkU7qSmEvKY8v+BTS
 hxQw==
X-Gm-Message-State: AOJu0YwCztQ0OvlkVQOWE+CPYo//zhSXK4FEWlTNQ8zR9y/Nux+2p22y
 3cp2We1K1L2O7AK754l/LJlbV0sTn6Y//OlAAHy+0PbW1+/XuSPerSBmv0h9Fru0XJYCmUDv9g7
 gfLzJQ6g=
X-Gm-Gg: AY/fxX5WIKw+0QRyaEOFi3jHYEtYQb1Gb7eYqmm2eECzI/PrvUqBRSfKZhcIujwLog1
 Q0DkptsRx9/Es2Wvc7dK8/zxwWAL+FlJS42W+SxMRuBU4srjysYkZRl31gBP6Sijl+rMVrILqJh
 3z6XgJ+t9PA9ZtKQd5XQNeGtAn/zQmX8pgGlMFFLIWZCIhEjYBCo2F3wIhUoABK4DY64jzf1QQO
 Mkm5Y0sxWoQfYOd2bLQ8djGMH+8+ls60duK0CSVOhnRPze/ywnJXiXmU5knTKoEWMYpcgJs8Q5Y
 H2onmxRAMjHOvBS/DAZEoVcVYdT9RfhWQIPR71a/2PEOsOIU4U7vsyyzEG0hyxketTQXbiZp63D
 zKm0ZuIsZ4jjNRTjS3jUh7v6pEhSDg0P7af9rmgMUJ+/o4QdTH0ENLxbNtuNRIGBH8FJSn3k6Sx
 py1AstmeF9bV1VZZEQQA==
X-Google-Smtp-Source: AGHT+IG4NPzXYhs8tZ0mhbdhhONCwqNNl1KtiosLD88hjNGxnQuirXZPYl8QCd2QxLsdNQ4zf2mrIw==
X-Received: by 2002:a05:6a20:1583:b0:364:14f3:c536 with SMTP id
 adf61e73a8af0-3898f8f3b25mr5231819637.7.1767850267822; 
 Wed, 07 Jan 2026 21:31:07 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/50] tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
Date: Thu,  8 Jan 2026 16:29:51 +1100
Message-ID: <20260108053018.626690-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index f71993c287..29ecb39929 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -26,11 +26,6 @@
 #include <ffi.h>
 
 
-#define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
-#define deposit_tr  glue(deposit, TCG_TARGET_REG_BITS)
-#define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
-#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
-
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
  * Without assertions, the interpreter runs much faster.
@@ -525,7 +520,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_ctpop:
             tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop_tr(regs[r1]);
+            regs[r0] = ctpop64(regs[r1]);
             break;
         case INDEX_op_addco:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -639,15 +634,15 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
+            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
         case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract_tr(regs[r1], pos, len);
+            regs[r0] = extract64(regs[r1], pos, len);
             break;
         case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract_tr(regs[r1], pos, len);
+            regs[r0] = sextract64(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
-- 
2.43.0


