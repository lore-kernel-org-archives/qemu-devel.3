Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC2CF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCM-0004Ba-1B; Tue, 08 Oct 2024 20:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCJ-0004A9-DY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:04:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCH-0002di-Ri
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:04:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c56b816faso12428875ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432296; x=1729037096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sM2rASXzZfAaByCSG4X7yOvvA/fFZaOvGmejFsljDo=;
 b=nZv6tFi4WdYRsBEvStKzqOAg0typjQrlacmlxt7xUML2/TmWLU4TibE5wB5SE9AW6W
 tZdhQRufXAw4yCGUhmXoE8A1DS4VhhGWoBaO3O2MoQclktPU0IGTgxm8NczbV+IVtYZ9
 aPtheu1Y0a2vJKnghysimaj454JmmclgNh09YYYF46U2TJUzc3LesvZeZtEctIWHMO/+
 8a+rbPkreTq81q490I24GMOp1NFzcsOdXXJPA0uGKe2PTm/AoO+iYGNfMrIAiFvN0wIk
 iRhi3ksOJYJibWJYSoXzvu7hP2ZNvnaN0EQiatWHJ93EvwyaTP1ZNVNag/3h9yauOCmg
 8q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432296; x=1729037096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sM2rASXzZfAaByCSG4X7yOvvA/fFZaOvGmejFsljDo=;
 b=jvCrEZi+pfAb2GWj22OA9GUDBUNq2tfnNJyP4hi+Hq3CrsztB160Q/sYyHH3Xqf1yX
 py1Y5mHIm9Q7MlvPU/hq0x6TeAo0iQ5Zh3l99gmb5Dp07ojtJMe8ln9BKg8AhCqyT85T
 mzX5odJgBD6zyRXXrRz0f9mP55dw3RQIybIHN5trVu0qO0Wy2KLwGeRCPZQOmmt8DXI6
 V383hPHSUa3k6YSuJijsc2fxT6STnR7A6+NETwa5kowzZAUB3JEp/0znAb19/4wNqvqP
 JxZiKC2yyeq2z75+ywMoSaCb2430IGEDk3jYY/uvDshzDseIZW+Q6LUGz0wqnYghLwAb
 wDrg==
X-Gm-Message-State: AOJu0Yx74jMig4UC4ZtszAscXRR9VKcF7HLPCIEe2N1N7kkEXmn8TPUi
 Nyy3fkq60M0aEMLS+XSdFpPFQYA4V3aluQfrYvKVfVLlSKHjkBFpz/BPja0k+5rElR8QeLfmlNU
 5
X-Google-Smtp-Source: AGHT+IH2ZvMU4bGuSg+tDG+ztb5xg61iiZPQqytdtvNBcTuZ+zmK3VvxDZbtlEMK7wthugBWGqHljQ==
X-Received: by 2002:a17:902:f685:b0:20c:5c37:e2c6 with SMTP id
 d9443c01a7336-20c6375b1ecmr12035995ad.11.1728432296270; 
 Tue, 08 Oct 2024 17:04:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 01/20] accel/tcg: Assert noreturn from write-only page for
 atomics
Date: Tue,  8 Oct 2024 17:04:34 -0700
Message-ID: <20241009000453.315652-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

There should be no "just in case"; the page is already
in the tlb, and known to be not readable.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..fd6459b695 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1852,10 +1852,9 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-         * write, this shouldn't ever return.  But just in case,
-         * handle via stop-the-world.
+         * write, this shouldn't ever return.
          */
-        goto stop_the_world;
+        g_assert_not_reached();
     }
     /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
-- 
2.43.0


