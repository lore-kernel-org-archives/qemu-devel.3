Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3BC7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yz-00052x-Hv; Sat, 21 Jun 2025 19:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yx-00051n-NR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yw-0004Rd-9Q
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2344646b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549845; x=1751154645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CsLZ2KxjXlt8jxUohmaQA9098QuUDZClEdB7ktNppFs=;
 b=pvGPLr05joExvS9Wl98LBJMxLv0LgRaIpVKZYverfksCqG4phx1WtdD3JaNBOJ0Pz8
 tf8ouNRrPBHrcf6zijGEKCuZO+veK0OwSZWoyaSmUSwdu+shLxl3QioxfwWMur5SpZqR
 CxePkU+UGSTOopoSup63W/I4ub2LhJTqRmtzCTf9QXxW6lAfn5MEi87H3MLp+FE1ucLC
 kGzkvOHZ6y+BidNmqDUBzBaCo6674eOZakPppARQpix4yS81yvrfw/8HMx/0kG//KOAJ
 3yyXPCIGInTdRrG/08vApqQw7Gz8vgV1hICSt5obtUMve5Zq355DjETNKw2GpWCm4orl
 cF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549845; x=1751154645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsLZ2KxjXlt8jxUohmaQA9098QuUDZClEdB7ktNppFs=;
 b=tHjFfbzT8VVeOOo/vtPkxmN1ZCQYqRzdN8PnuCn+pm9cp8jQvLuHl0Kn5ZpXHnYl9u
 CGEEMSXH3onNlFa3XgxwAT9/vcX6A34ARMK86aLfHaZmz1ABVHJVPAt348wtkIxjy+L3
 MiYTkw9wv3ZSuCvjBDAUtqWeUYLhQmFoTaDWhT9bfrHxg7kus4oB5fKak9YtF3kHbR6G
 mRHKx2U2j6o0YZivr1xQGXARSKDzssJ3Aya9p20xvgfofyfKHg4DW9mfscNCXxXMrOtq
 1w/rqUNMOFkyvFEfrZg5CQNpSgvCX497JkH1rHNJgofG5Wv7fgLywINZtmLSm8I2Ut84
 1+Cw==
X-Gm-Message-State: AOJu0Yz+1MOzR7CqPuafa55o9viagceSCudVuhfbMhqfBibxgYqyDQLB
 FhdRsNgj6qLO0wMFnj0p1JmeiLICBBUZ8B0qAY/wvOflVxF4oJV+7wPEk5eIiFoYlHjjRZNX5et
 1orkn
X-Gm-Gg: ASbGncu/PrVbLiwNKaNkmf7/hCTurmUVFySl+sSZnUPLgDSIiqhtnc8HWlN+n6+J19I
 NxbjV6jcbfJ+HnOS2BqGAi95dNyXiD0clqw3Yn2b6HLxAIxNfuAC7s5bW3WB0eceqkFnEhTYsEQ
 NTnnyu7dDCUQP3Jk9oEXnhy0W8d38nFA9F3dnCVZtduDqDphTJU6uNcqB3yjsdQUys7HKq/B20Y
 jSz0HiEFvBx5IUTdArq2zlW8rSBQL9DIcMAcPZgyDLxHoaxxo17ekFdJP0xup0uVekZxz+4OnzP
 ZNeDtyBTQYNzwTfMpOD4Rtd7QiZYO0NIievh0Dp5YSnaD3AU3/sceSFb6lPP7d0aJRlYq6/4oTy
 ZT13wo2cKFL9+U3LEI78/
X-Google-Smtp-Source: AGHT+IG3XIFbuJzNWrY03X2hL7oWKk/7z1Bj0WIr2V9UNpZjJHsG8m8KVUbWPEM1Kipz/W5W/eTkZA==
X-Received: by 2002:a05:6a00:2e86:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-7490f47fa1cmr11436024b3a.6.1750549844970; 
 Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 009/101] tcg: Split out tcg_gen_gvec_dup_imm_var
Date: Sat, 21 Jun 2025 16:49:05 -0700
Message-ID: <20250621235037.74091-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 include/tcg/tcg-op-gvec-common.h |  3 +++
 tcg/tcg-op-gvec.c                | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index fbe5a68a7e..7cc998cdfd 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -356,6 +356,9 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
+void tcg_gen_gvec_dup_imm_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                              uint32_t oprsz, uint32_t maxsz, uint64_t imm);
+
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index d5fbd4e885..c9ea8eafb9 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1892,11 +1892,17 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_gvec_dup_imm_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                              uint32_t oprsz, uint32_t maxsz, uint64_t x)
+{
+    check_size_align(oprsz, maxsz, dofs);
+    do_dup(vece, dbase, dofs, oprsz, maxsz, NULL, NULL, x);
+}
+
 void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, NULL, x);
+    tcg_gen_gvec_dup_imm_var(vece, tcg_env, dofs, oprsz, maxsz, x);
 }
 
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
-- 
2.43.0


