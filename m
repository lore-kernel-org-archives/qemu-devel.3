Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18359C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxL-0006NT-JV; Sun, 16 Feb 2025 18:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwW-00045g-Kn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:00 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwT-0006Qv-R8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:55 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2211cd4463cso11978775ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748051; x=1740352851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZXXB5wevT7oKXRhgPjTjZda3nE8gH1g/3tqsd3logyA=;
 b=xNVOixpTktRq/pC70pVETH0nKCQgvBM6wziV/QT4IGYJCkzhOzTWjDJa1JYxG8AkmJ
 RecCt4lJexFdkvWTTASCgv3waTMlpOgyOH1ICTni3flrRTpo5tB2dxsXeCJefOaaWu1t
 Ormh40CUpKyON7/Is/bJkwV1t+2vAiqnyBMj5bK9s9OZ5v3QK17gLH9G3P8JpEaPYu1b
 +hRpx1ycM4YjnKD6Ah/54MbeHqZ25+SgVYQyFZBdhTdViKYLio6msUjEAj0xprhsDlAC
 s/Ct/zwhboGZPUkq7umwLYAvdzqf3M81iDOqjQ3U8VIA1Ft00/iC6eMulALuGD6D/um4
 l5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748051; x=1740352851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXXB5wevT7oKXRhgPjTjZda3nE8gH1g/3tqsd3logyA=;
 b=snnkj4LmzzXiZDoTEvojANRnAaLbu2Q3RY6KKiab2sY732ujf7j1B6PepG+FXMmW9E
 Ngb0PfgAtnbmAwbiNirdplNtkQpQ35NSSbjzjfekT8enD0fA0mq6q5ldiyIHrPZPQYUN
 upflEd1zbePD+0yWjkA7fHA7JwKOgy+9zYrUCf/eWIT/DiDYqytUO/lnzEfZswvCFpAb
 aitKvHlUNcgETgg+4xb71Crs9SWyFuVODskCNmuov/cNJ3ZgYcYCoMksj8mKhVTafcn1
 tbRHzexSWHRPv9IYe68PAGtIQo4ezVS9Zz8KXgabmLUOv0hEKTZ9N/5SVmHKcx7LBkpZ
 TBKQ==
X-Gm-Message-State: AOJu0YzP4bJ4tPhTGAB5BEldbtgUwD1xjWzgcRe0Nxz4GHCLZ2n9xNW8
 C18hwKPIMO9YHDFIcI/F4su6zFEBOlKNAHB90gSst3zzYy6zOxlbH+Vrk1nonZcfjz+zftN2rwy
 K
X-Gm-Gg: ASbGncsnBbUgKFmmatSjqR/X2x/xRapxEdnCq2yBrYjeaS5c9GJoOKQmdqSfBZk9jfd
 BmmZZpw+bo61hkLeiZyl03+IxiaOEmAzUXed29yMVHyq37rDgXB3evypuDEItQzVWFTmxRPvigX
 7V6TaC9Uj0DpMZRs1fCVEVnnBu1102bKDxAheu6Gon6E1DqGYaMtbpAYhJtIj82YTZKN05jQ7wY
 HaRtDUldBDJ+b0zVRsazgb2MeHbZx7Q6fA9GyL1GNZHmk52Jiv56MtCICTVfswFrAFVmHfrzSAJ
 NlCjTT6WSk2NCZp1y8WRiHIDM90J13sgcsOvB5OQBVkeHsA=
X-Google-Smtp-Source: AGHT+IGagOeEgraYVqOh1SCyG6OuHv6GBgFJfcIcOb9D8ZyaDev0K1y1rV4+ztELzEQXkz4aTQnQSw==
X-Received: by 2002:a17:903:22c7:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22104034f22mr123591065ad.15.1739748051146; 
 Sun, 16 Feb 2025 15:20:51 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 128/162] target/s390x: Use tcg_gen_addcio_i64 for op_addc64
Date: Sun, 16 Feb 2025 15:09:37 -0800
Message-ID: <20250216231012.2808572-129-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/s390x/tcg/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 00073c5560..a714f9c0c2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1250,11 +1250,7 @@ static DisasJumpType op_addc32(DisasContext *s, DisasOps *o)
 static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
 {
     compute_carry(s);
-
-    TCGv_i64 zero = tcg_constant_i64(0);
-    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
-    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
-
+    tcg_gen_addcio_i64(o->out, cc_src, o->in1, o->in2, cc_src);
     return DISAS_NEXT;
 }
 
-- 
2.43.0


