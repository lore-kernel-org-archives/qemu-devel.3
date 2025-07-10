Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CABC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvvD-00087h-6Y; Thu, 10 Jul 2025 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvFP-0004g6-7e
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:40:00 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvFN-000849-Bx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:39:50 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40a55314d06so418235b6e.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752169188; x=1752773988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V9CYZ9n5k9l7POoIDGNaUbl9BdeCS6jIWeYnafKn6NI=;
 b=XYuQqhTACKRpdNDeFQymHOAe2iTNkK4GBzRGKctbMeVc3PdvjVEuRIUYkcsnDqhCwf
 /onR+9KJVI9Or27kKaLR11SJUu5JBCgLcY9ADYSqC+2I5cJuUHiv1+ex7gV1NY++GM9B
 agaOFZ6i1wng7fMdUeKvdXn/RrVRKYV/HnlNvk1LXgrbFurJIttybXW4F5UsBHZIbyCv
 B1tLBfdg2HHMm1hbfafleVYD8xbNKD/lalhX4I4TYXBle/xtIpqLi8yIMxx4LVtGDOB9
 TrSSNWL9N4oLvgoDxsRrV7TjGMybb3X7MJ3JYT5OSIsT+prd/AmXqudqJ0FBKKV2MOqk
 nkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752169188; x=1752773988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9CYZ9n5k9l7POoIDGNaUbl9BdeCS6jIWeYnafKn6NI=;
 b=oc1gVtIYQ88npnoRoRaqz8Iu17c1YJVRCRQBzJU7ADo3RDcFyH6GxX4ukjo/LlgbC7
 hxHi4AngCcfdHf6Hwu3x56BDQHyVQnWkg7hR/mazE22/iYRcWkjJ83MKlGvFvNnXBaP4
 cqlzFuaZRmu96anBeZQaahaXCGIbIa/RFSHLGED332EV33wkt4b9FOjhtkDHYKKgqxxb
 0rXR28Y8210Hsi6k0Hpa6VqBcRJPAWNLpb0ANkwsuuRIk41m6y2a756x01hqy6HdKdjr
 nQKQMGm+/vyChOqlnpNG45l8ufzzAtQq1m/8jYzGNvcl+e9BUdgBlSunwGlNrEi4KK5J
 pByQ==
X-Gm-Message-State: AOJu0YzgXkE1rfsoc/WmBVfCXDeuMIWRXgtRW06hgYYejxkQSQmkKzDN
 1gLliUVWvDFu+TOcYPg1kzbwAtrhwLZICgPnA0NuDHdOq2iGsBGhg9R21lz9+n2xRa7Dxf/BuOB
 ZIHgPPdM=
X-Gm-Gg: ASbGnctUenfy2ceoc/RErIaxD1JnrtEaTrZohzWibl8w5WufZEiGoZUD8M3wAy+iw23
 aF0LRSsqmRRzxoTVsz541qrWTDNw1/IAuOeE+CVneyRmZN5Q3SwvGY9T1l58FlY6+oeSoX50mr6
 j3Pchy2H4nIYxPJtbFo+EUx5cLTyftDngdSsNnBrSMCGcytNXsNXsPFAL6Ehtovq6yWJpcZH7lk
 78MA4MAnSRs5LhBkeOdtjeoc9ZAKCZoLszM7MsuUzfNOWsfClKcbrFP/Cxbb8vwigIcal05ebOM
 dXNLlDIMZ8V4+KdhConOrAdGA7M5z/B5Pg0yHPOp3XCl8I94rKHTeyHjxrHfX73wJHyZqQ==
X-Google-Smtp-Source: AGHT+IF9slB041sEKJdWjcrPFPdMpXu/jbe0Mf/PbS4Tf66C8LlgbagREvVJ/bIEBxq2lt/pqmMc+Q==
X-Received: by 2002:a05:6808:4fc7:b0:406:3a0c:1801 with SMTP id
 5614622812f47-41511619648mr322601b6e.20.1752169187866; 
 Thu, 10 Jul 2025 10:39:47 -0700 (PDT)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b58fesm274539a34.59.2025.07.10.10.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:39:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH] target/arm: Remove helper_sme2_luti4_4b
Date: Thu, 10 Jul 2025 11:39:45 -0600
Message-ID: <20250710173945.115428-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

This function isn't used.

Resolves: Coverity CID 1612139
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h     | 1 -
 target/arm/tcg/vec_helper.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index d9565c8069..0a006d9514 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1209,6 +1209,5 @@ DEF_HELPER_FLAGS_4(sme2_luti4_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
-DEF_HELPER_FLAGS_4(sme2_luti4_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0603db0909..bae6165b50 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3526,7 +3526,6 @@ DO_SME2_LUT(4,1,s, 4)
 DO_SME2_LUT(4,2,b, 1)
 DO_SME2_LUT(4,2,h, 2)
 DO_SME2_LUT(4,2,s, 4)
-DO_SME2_LUT(4,4,b, 1)
 DO_SME2_LUT(4,4,h, 2)
 DO_SME2_LUT(4,4,s, 4)
 
-- 
2.43.0


