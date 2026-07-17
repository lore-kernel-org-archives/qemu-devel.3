Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24ADC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtu-0001YO-Dk; Fri, 17 Jul 2026 19:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrts-0001X9-Oc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtp-0006zX-KF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so3453858a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330600; x=1784935400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZTwqniLxRl1m+Mbcq6QdOuxrIA10SI062fGGhdr3eE=;
 b=C4lIwUMCm+LHM7FJ9yZAFzuPJIlIm781TOP0bDaz+GTi12KLeTc1TGjGpVSpdq5ve5
 BChw47oM5wzuhxvcFjhCPlprYzbPddOtTxGIokZocor8Q7HrKJmZ2KluOqBNnOBP0wHV
 2Moapuku5mnQYZFeiLJLg6sEEE/N/mEnmxZNSUop12Cnk5yB+hFXLS60uPltTsaEVN0p
 /YT8Kd/OgqeSV9D+DZNN+pATzltlvKhqVHU13l0IyTphDqDT0HA003MUNtPTQBVGu5Dn
 +nlG2z+n/KDoNmM35zo3PEqABqR6ueu5Pkhp27WeLPhne7BT/jwaoGOWB5D2bki8KDo0
 aNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330600; x=1784935400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZTwqniLxRl1m+Mbcq6QdOuxrIA10SI062fGGhdr3eE=;
 b=msTgRZX57uEZ4mwXKGOtN4JG2KzqsGmbnaT+ZUUnqFA0CNnk2IPjeirbP1eAEd9wOP
 phAcXa3f2ieV+0q7i52N9Arwv7yk5lkMWH/wKQlr+Z0k6ffR4TGtRvJQ5S1hPRNA2spR
 LI4EVWw7zfM9s655v3H5f8eCGO9PqZOFbu53xjLiYth+10HuCq8lNfq17UtdW1HJlT25
 QQ3fpGT1NEwP9Jzpd1w4oqAZkO0Vt3C8bl/o8AIeeR6B5BEn+EhUzcyEpdJdVKlTpbS3
 h01ny083HFT1Q9ait1UzN07bjh1PmgWxNSMBBbv1+t6833tN8FIOk73n93SUqsiqnkp9
 sn4w==
X-Gm-Message-State: AOJu0YyXpBF6DkJFs0eUj2jk7Z5BrTjOCIecNXpXY1PLrH94/t3fccLA
 aq5SL6roR4AlsdCfa+IGej07zsW2AbISqbfr11nUYI/uAYU8aaP+iVgL7lscazgppUBWC51tQH+
 465v9
X-Gm-Gg: AfdE7clYh9gZSAA7xo1zohDCaBLj0DgT73OdQPBIR3GSPLFnAWlt3z6tv+lybieBDFq
 9NglnoZrH8/v885Jv8XVoDiVwb2o3NuQXH36cWySlEqHpYPRfxoHO0JOnUKbkpKZtAR3CxlNCSu
 y6biijj1OnYplocWgpNiWY8D1aUJIU0iE8knbhduYZtX2PG3YV6OY/OBSKKHoD6BYzZGESQFWvm
 ujWbAe88ZFIJNhymVtsKNq8Zm9O8XfWh347Ah6mGK6AdvDtGT+iLZseekXiIWw+EFHmPi9TiCm1
 U/W6Ay+Ru7leS0rXKG5yf3eUScNOysxtQTib+4ZAO+BE3cyry23EeB/IjFc0UEPG1a6M6q6a1fI
 Alck41kkDeKWI0wTLvfUQk+DUltBavHVzZmj+Rd5Sa6S0L2xcp7q6RY9xmUa/U6MlAT9S3RLHGs
 J9V8rnNfs=
X-Received: by 2002:a17:90b:3ec7:b0:38e:cb1:8ec9 with SMTP id
 98e67ed59e1d1-38e4b585bfcmr4868782a91.42.1784330600120; 
 Fri, 17 Jul 2026 16:23:20 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/17] target/arm: Drop TLB_MMIO check in
 allocation_tag_mem_internal
Date: Fri, 17 Jul 2026 16:22:57 -0700
Message-ID: <20260717232306.378988-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

There is a memory_region_is_ram check later that
actually does that this was trying to do.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 997248bd57..6177dea842 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -181,17 +181,6 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
         goto fini;
     }
 
-    /*
-     * If not backed by host ram, there is no tag storage: access unchecked.
-     * This is probably a guest os bug though, so log it.
-     */
-    if (unlikely(ret.flags & TLB_MMIO)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
-                      "but is not backed by host ram\n", ptr);
-        goto fini;
-    }
-
     /*
      * Remember this across the second lookup below,
      * which may invalidate this pointer via tlb resize.
-- 
2.43.0


