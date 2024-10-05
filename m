Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A8CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2W-0006Gz-Rc; Sat, 05 Oct 2024 16:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2U-0006Ez-Nd
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2S-0001hr-0H
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b58f2e1f4so21812115ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158763; x=1728763563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpc+gtvz4QF2D7U7hwk6I/PwDTmOhNNc5A8A2G2CqV8=;
 b=J7ETou96MJsubgZ7bZXJ1Lpb2hWHSpxbRLjFp2u1d+wjN5yvudDHCgKssjd2UKt6Kl
 Mk3Ltpy1k9tWHj9KzZocGvPWT6Gdx732waYHFLHGPjdG22sP9zo2nF/DkuLAVN5KeZLa
 SIZFPwDhiEQwqt8GxnKFAh9kOR3dKbIjZyxA3G2j+1f+VciBOm4lqfYLe2Ug6p4JV/jN
 UApNsZXFs3KiIli88gNk0U1SwZpI6mXfXexRQwea2pULDHSjpZRnaiY5n0O6hVpw7CLF
 nKsH2yXvBjsZkdeWwaD1zWpR8jE0WeGeJaG5L5YmfyjtY/mqrDc8GjQU5uxRx5LCRcKq
 huAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158763; x=1728763563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qpc+gtvz4QF2D7U7hwk6I/PwDTmOhNNc5A8A2G2CqV8=;
 b=sy752RxiRO4zcick0KA55F/ygDBpdLm8lVPm3i0iT2D+qtXFjNzuDqrxdxRVSoKOif
 McIWheIjeAXHWep4J3g3fnMPu3PVlTkNz29wXUfras3mIrtkCGj5/WNxG91A5sx79cXL
 yhYtktEUeq/yewMoDhYF7MA7Nv+Fi2tljbgZyV92eWs42bEMC8qbl/pDqciuUq2cbOtn
 +CW4uvrDwbrAsEHNs/1f5l8bsdCGDeJOianaPxVQqSu3BJmjF3RoML8xMosTWjSIKKP3
 uvekFn7Py/ZH6cFUSTpg/0xF586c+4n9vX31V3mtGWWFu/7ivhGC7UqiA8t+csaJI+yx
 Zt5A==
X-Gm-Message-State: AOJu0YxLyq5CJ2LcGF0GC3etB3Bu5V80lQuwFKqjq7d4ibd/3x6wd4rt
 gQcMoJ9rfja3NWYgOdtUAtV9InfW8eLxH1YYkcxexby2FFt5+kERoSwad5tJ5O2CyUXgVbGCgFz
 O
X-Google-Smtp-Source: AGHT+IFmM8Oxp421B76h4UpAzO5VbLx+wqOrR4XfQnLhl5uTco5sEvRm26Oyl1URtBb3k58uPkW8Hg==
X-Received: by 2002:a17:902:f545:b0:20b:a576:1896 with SMTP id
 d9443c01a7336-20bff190668mr89398765ad.43.1728158762695; 
 Sat, 05 Oct 2024 13:06:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 01/21] accel/tcg: Assert noreturn from write-only page for
 atomics
Date: Sat,  5 Oct 2024 13:05:40 -0700
Message-ID: <20241005200600.493604-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


