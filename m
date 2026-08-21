Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4BAC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUo-0006JJ-LS; Fri, 21 Aug 2026 00:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUV-00067k-R4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUS-0003Ej-OP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:25 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso396374a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285063; x=1787889863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bhNir2CKcbFwxivO6W8m2We0DbEIiM40sRu7ky0424c=;
 b=EMUp1OqdwuKiN2vA+ZXwWtLdZRbFwzYAPN8NPEw5mYhHi/rvGxVPg2SqIMcs+rblmi
 jCbYtmVTIZI7rF9SC1hZvbM0Oqn+g5gVx3E1XAWBEiYc/O5BWDFxP3sYXtKoOdUBcYki
 Q69bSLZ8oDdWQ2jnIDr4IV56fDgwiBTDvolOj8Fdr7dYJTUzs0iQ+Gegdnz6w0vXFINI
 YEZyY4jl4MKZS5d+xRaXAphQ17R7uTb1kd6OUKh3znkMZX/TVZaUbB/viG1eEoCJX4rM
 BVFm7ph0ZLxbbqKzi2zl/bO5P1+2LI9QRyN/J8VVp/3Xah9pm8xInhlliaO5shJ8e/9f
 XAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285063; x=1787889863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bhNir2CKcbFwxivO6W8m2We0DbEIiM40sRu7ky0424c=;
 b=JaODCg6NAeMNq1YnDqHVc4SQD7RlZmJJPVowneZ6aUvVpExc7rr4mJf+qHR/NUaKDq
 cQdqsbw+o5qAdjAWSolMX1JNfIHruylus3nnV9UyozUdRmqfv4b3dG2A9+hadU3lpa0A
 A45BFn+buqxXrEnea0iFH9tfj81wHMPVqtbzFWqJpnfAB9ht/c20QTX6nOxnUfpqY6pU
 fMfh6QBFtOXJDRhReHOsz1BMG9Qv0AQaHzJ5911LP7jy+DosLnUphk/8C95NIJGkC8pA
 sE90Trawe9mMkDt/ut7efjqB3ImntotnPOv0tjMzedJu67ef1xWlzVyNH4Ay4A+k1mvb
 KG2A==
X-Gm-Message-State: AFuF++leji/J5z5nq88alrVu0nSbEOuIt+TqYXo1UQDHmvBvIg+Ycn3o
 3WvbkYzOzOusWKL3yo23FJQXZlpd2Ahhelg8Tc0RNL/QOmcgkcE/6l4+GJv+FjnHCLEnvUDWud7
 kL/ta
X-Gm-Gg: AR+sD12TQtI0i1ZIjEXbi428dBKcAPaLRKRA2Lq8drzYnwfw3Y2MUpXTcMduT0HpZLY
 frdXDWMwl4TLCficxQLU6xHfpa9gI9s2xCICl2WUBWOiEeMk7bAEKG/iv1L1eGX8955xBfjgLj0
 tlfAyim4hRp5/Mg0HVARaIfNkPQfgz/zNdAI8T1Y10N1uZl0obG2LolzOj9M1VhpO8V4KkhhWkN
 5s5RXCPtV4K3Uo02PR+u0MAICcfF5Yr37s0lIij4U8yD6DjXjWO6TKNURldzR+IslFSkVjSCG8Q
 POsaleLL7ANf5qFiSiqr0iQMhzFhBnoytEwcS97tJjf97CosnOkjkZWET1cNDMh/wYPrvdoREvA
 w3Bc0lZgfc00KOjg9yQ2PyLye5hgqTsgLnJcnkHZr8J3vGya/LuqnYz4CxXVtFzot/13HoO+3/l
 lV39VfHcNC9iUAnSyW/2zlH1I75YsaPN9ypAjJu0CmqLdsELuhXaMHYxG92ak71OVLAJEvVUrHv
 4fwew==
X-Received: by 2002:a17:90b:4c11:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-395c3878304mr5336109a91.10.1787285063205; 
 Thu, 20 Aug 2026 21:04:23 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 16/23] target/riscv: Build MemOpIdx to vext_ldff
Date: Thu, 20 Aug 2026 21:03:57 -0700
Message-ID: <20260821040404.268123-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Use mmu data passed in with VDATA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 9b0c3f70c2..98a0a5d025 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -711,7 +711,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
     target_ulong addr, last, last_in_page, page_split, elems;
-    int mmu_index = riscv_env_mmu_index(env, false);
+    MemOpIdx oi = vext_oi(desc, log2_esz);
+    int mmu_index = get_mmuidx(oi);
     bool first_active;
     int flags;
     void *host;
-- 
2.43.0


