Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67388C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwR4-0007lp-Md; Sun, 27 Jul 2025 04:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPQ-00020x-OC
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPP-0004lP-0X
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24003ed822cso1924285ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603622; x=1754208422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7c+QA7GWNE6I5/69pcOioZrB3w1TEGpVruYf14/lg8=;
 b=rpPY6Yo1ZwLqGGSu7uNiGnBvy0tswb3kHhGw9z6u5DqIDt2TSPNhPrCOgN4gMKtmc1
 cBxlO/foOqhyEwON0feOP79GUvuA9GMqn+auWx0voiCRXRUu/g+yjF8py6vm1xbL7CtD
 3CF8uaMX7bj/JicMNoggDAiOEhqImt06+Z8raePWOd69JM8LZYT2pe1QYjzxM/QbzdkK
 Oi6FCirJiaQzmZsVqrKEgEFIbC3FaCVEOCjkEdeeWjPyjMkR5IVGlF6lsn9wBzGGiz8A
 AlmWpKAedwGhv+c77i6aWhOKgM+A1VC8voVZAhh/KnXDVA2Mn92fz1+255/JPNotXwgI
 mHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603622; x=1754208422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7c+QA7GWNE6I5/69pcOioZrB3w1TEGpVruYf14/lg8=;
 b=XpDhsYXvyfsJy+R8sv5joa72tLLV8AaN5jMBfMUChxz7a0jMbmSB/jmnSE+C7DVkrJ
 WwBszjQ0F8BHysB9p7y76qo8zgDBIwnAJNtVDlHYQNxzqCXTkuz5nBvUTuIcQ6MDcG7S
 OPfpCVOJ4RENuomOorh7oXKfg1nqaSGOT9/x12I8VqvfmxovZIdUUQzlF0Rj8pkyf1jq
 e5h0/xnhEr/LyaS3yQXjgqmtK9JmCm7thLzdNkXhWWfK8q1zULsFIAWDNDSWFpzCrqzy
 53RBEThOT29avxa6ePoKhSvgtIoQ1qVgFP6fyKffIUxOqrLrBfxbeMNp8XAxZg9EeZfo
 mNPQ==
X-Gm-Message-State: AOJu0YwBwupen4260gcOt1YPbBDZnDpHuVg7tnb4RDN28dI+trWSWI6D
 F4HaMGvgK3sU4Ljj5yqH5snIOlCNuLSG+KG2kNXiNJdf7Q+tCIsdezr+yKfl4sAnDq/Z4Gd2RpG
 +Sj1y
X-Gm-Gg: ASbGncsvClUmdIH6yTOWV9FW+FbEzAaWMp3f/HsQfojtuc6sTAXfuyT96C/IQBNxbcM
 JUQRvPNjJTLlzFotaLJ9h73k7OdyFBbtC6iN6HMy07Yg1DLTCFK2363SOa6WcwDeqPJYTMMz/eY
 8Gql7B3H5uUL7X/HtYZogHP3MXJNIsnjanU4t/eM3Qo5F4ebnb1ivMmnH1NEegWuiLuyrg8WQtb
 8VogXItYbukdy0QaIa4U0SLPj7c6UMwGjYa8aGi9tUXZrpSYl3NynLjZlSylxoEjCvd+24Z97Ab
 dxcVtI13uVc+TY6Wlt1tO7c7nnIlN8hg1x8J2bLkQZGdu4jynIl80c64YYs5g9JKci7qwALHa7r
 Ef/STWq6DoLOeXKyZr7n0rfNpacjdT9B5A4cUdS/Duj92juWGt3SO3m2bLKkggzKuhTNnx8d7Yo
 VE9oGGl9TSSg==
X-Google-Smtp-Source: AGHT+IEwyg9SGUhFgm30Es4mhpzpXYNuR+cmqe81WbPYpzx6AKQ8J1wJRZTvJjqL5jgrBSb0J7ZlCw==
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d455 with SMTP id
 d9443c01a7336-2401f25d734mr1628395ad.50.1753603621694; 
 Sun, 27 Jul 2025 01:07:01 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 53/82] target/arm: Emit v7m LTPSIZE exception out of line
Date: Sat, 26 Jul 2025 22:02:25 -1000
Message-ID: <20250727080254.83840-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f6fdfaa551..e787acfc66 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6885,11 +6885,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


