Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E300BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pj-0002ML-2Q; Wed, 19 Jun 2024 17:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Ph-0002L9-1r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pf-0000h9-6e
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so1749825ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830813; x=1719435613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWCrz2KU8h744vxLguDhIrWWg2q5qa6M3b4q4pYmIRw=;
 b=mBXKUZ1I4lHVSJcaHvCDDCIQZSzQXEttWhrRkuewz7fa3Sm2YPMBPJ7QE9bfH9BudY
 /j1+KHwKZYRdUEozPD+926N5OGM9UDNkIy2U4OQ8opPXUkSYDOftftzWJu8MFgoY+lOo
 BFyekneKM2DG5en86zduLVmBoJxOLsbjo73mLn5r59KFTx3rOtj094QUTnOb0D2gOIH+
 KI7wJMBZJOByEsYSuig1mNSO8QDCW+A5kTw5g/HmaRejv+eL5PEs96+gg6vaN+Q2mc5X
 1Li6IorUHOnWKw1EAokqp32fl8xBqfMK9b9XvRIlN18RcThA7+RrvGyu4PZbsbb6fFDE
 chJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830813; x=1719435613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWCrz2KU8h744vxLguDhIrWWg2q5qa6M3b4q4pYmIRw=;
 b=TB9KTh3vxC+RcefLNsWuO4dpbQ70mubqW8KqddP0ZIPbbMPIJJhaVOv9bV/NAIa4PZ
 WFbh/sZ3QP+EA5cgDeFo97f6iWk950qtt6F+7OmN5Z8VVeOWZAOkJy7YoZYL9bk24+Qy
 AzpB0ZVB9yNpeLYuiuTj/K4jym6ckXNPK5XsuhX/EQuqNxTE0B6WtKs81NUCKlfCOmps
 E7GHj9Kk/gsAD7q0PP36nSgB97rSbHtKiNAX8ofnGwxy9YWxYwZYZOn4equQ3k/uSor/
 6bpnuz2+Fstog55uOTvtngPn3HOtdRHiQY9xquT59eCJq24SVcZ9TZ3DsJEU5FfqUhxJ
 n1Ug==
X-Gm-Message-State: AOJu0YyKe8T828iTOnflt566cjKj2bJ83R0mKLE3Vsh0ULTc1gXDfLbE
 WElK/OwimO6YvnTxxqqI0PCocpekPh+19TSe7rQu2J3s9PZ0ealG6nW9snYhoQlbOmzdiAgBfV4
 s
X-Google-Smtp-Source: AGHT+IGsiVlC5/n5NReTTVEIOzbQqsdsBwGfWiaK9qRMzHpJGy/7oKRzdKfzOhqluMUmiAAetxhPag==
X-Received: by 2002:a17:902:fc4e:b0:1f9:c661:7b9 with SMTP id
 d9443c01a7336-1f9c661092amr6024045ad.42.1718830813126; 
 Wed, 19 Jun 2024 14:00:13 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 21/24] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
Date: Wed, 19 Jun 2024 13:59:49 -0700
Message-Id: <20240619205952.235946-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Anton Johansson <anjo@rev.ng>

For TBs crossing page boundaries, the 2nd page will never be
recorded/removed, as the index of the 2nd page is computed from the
address of the 1st page. This is due to a typo, fix it.

Cc: qemu-stable@nongnu.org
Fixes: deba78709a ("accel/tcg: Always lock pages before translation")
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240612133031.15298-1-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 19ae6793f3..cc0f5afd47 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -713,7 +713,7 @@ static void tb_record(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
@@ -745,7 +745,7 @@ static void tb_remove(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
-- 
2.34.1


