Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBABC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJa3-0007KM-Tr; Sun, 11 May 2025 23:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJa1-0007JE-Gz; Sun, 11 May 2025 23:11:49 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZz-0006lk-UY; Sun, 11 May 2025 23:11:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74251cb4a05so1778828b3a.3; 
 Sun, 11 May 2025 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019506; x=1747624306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nx+HQJDiNx1aF7NVu8Wqyu2xz7XXeqctvXa/vpk1c+s=;
 b=eLIpdMtUV2/Brgly9TMSKVwcsL41rOMb66G1UNMg07R++dj3RLtIUsMbpbsqkofsrd
 QOh9V8QdFETKCP++8tLjO8J2wSWNWS239JnXubpJrJo2bZc5VeOOHWKJHHYAEQhphEyx
 QDbAmGe9k4ASoT8pa0MFPFpWLNCsnYS8tcGjAy0boxpzQoRF7+5WWucZCyjNH3yxAE+G
 1lVK4wKwnf0Baw4j70nA6ZlDjvQpwIS73o2FAGZCy16fQUlfvGrNmgt0dAgOymI1PSwp
 6bZ44mT0XQ8XB5nqbjdGW3Ox+R3sCmxNJXkFrHMgIb54EyJYeWFgBk3aS06Z+Kdbd89W
 KizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019506; x=1747624306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nx+HQJDiNx1aF7NVu8Wqyu2xz7XXeqctvXa/vpk1c+s=;
 b=qWSqwKMNPbnyx1QCYl7RbIjJKc8A8zjicKq4zELneyXvTTSSz8CVI2HpPymAtIBpdV
 izN8yPpZdeWDOrwbHc/nSt8WqOC0MzHxBZou0HImbcdZTsVHnafoIXtanaRwnUSb8rce
 y6s0Wlm9HWlrf2PkYE7OVBVvQDW86JHFIT4iJz9zleuB/gzTBtTKnnTsdI8vG5Rdn+iO
 XiaiywN1ZWSLIYzE/+gA2iHofTS9SylUgW9iJxnVUn4V/mYcIVTBtyuFwrPQDHzNP7F2
 MmhB4zu9j3sie0a7IPE2wqVOfnW2VaRkGWSs1Pvbc2LZX61snmlm1ugIMOFjZUjwlQIG
 hBlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULQw59nIFgYc3q0FRXbDWoj2uz2YVMgXIKUjvhTNuqT79jus9ebUEzWQvWig/1SKtl0pToFkHtXRRF@nongnu.org
X-Gm-Message-State: AOJu0Yyu/Klubr0fTq67DxxTJlo19Z4ixVmUqFtKIP3OpxcbOvXv7sjG
 MVrJn0CTP6KlVFcy92KQbX7mqnT98ill6TV0DgSrcHrky2uYHPdU7W3dZQ==
X-Gm-Gg: ASbGncuaFrqgfnb+UT4ta6tdHQenYhdGZ8NbSYLcAUStsNNPorwuOqPLnytw+SkYUzs
 h3gP1ONMsBvy75dm9e2HEkUz4nLaUxkBdtD9kNAfNcTK03gP3xKUU7EKJnwzPFD1k4b1mFa5KLA
 kxDEwsMwBvIblHxF1/Pw/VOZ2T9Eq4VWXoim4ZLcQ6S/Hl9DAbquBXe7nhi0LSy9ZD0BzAInnED
 D3L+y8xsVwEU7m3h8OtLNywKWDAVLjt/9Kh81gVzjqWEp1XTAmjLmbEUXQ0omrTq05mj/4kE+Cr
 azCvpwI28zK7RHGO1IjO7RhqmGDFZNm8MyUEseZqZW/mLgnr9WBYrcWqKw==
X-Google-Smtp-Source: AGHT+IG8DsCuzJ52EJu45oHN9CaMf1l6fOJoKtTyx1KaWihcNw8Xh6PrM0zUGrwarW6STqZmYwds7g==
X-Received: by 2002:a05:6a20:c896:b0:1f5:8622:5ed5 with SMTP id
 adf61e73a8af0-215ababa2a4mr17552562637.3.1747019505821; 
 Sun, 11 May 2025 20:11:45 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 10/50] ppc/xive2: Fix treatment of PIPR in CPPR update
Date: Mon, 12 May 2025 13:10:19 +1000
Message-ID: <20250512031100.439842-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

According to the XIVE spec, updating the CPPR should also update the
PIPR. The final value of the PIPR depends on other factors, but it
should never be set to a value that is above the CPPR.

Also added support for redistributing an active group interrupt when it
is precluded as a result of changing the CPPR value.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 2b4d0f51be..1971c05fa1 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -995,7 +995,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
             }
         }
     }
-    regs[TM_PIPR] = pipr_min;
+
+    /* PIPR should not be set to a value greater than CPPR */
+    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
 
     rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
     if (rc) {
-- 
2.47.1


