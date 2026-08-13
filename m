Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EDFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuJev-0000g0-SZ; Wed, 12 Aug 2026 20:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeY-0000cT-Aq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeV-00040F-UV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so432596a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786582234; x=1787187034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NaQE6f2Pc9mTVAO9MpVP9WM3c+ia7jvor2cvLmY6xZY=;
 b=UIAARrgDF8MY1QcWv7Jc9pWLS5JceoeutFCsT1a0+Q/SP8v5xZKKS4LUz46Dv6AvK0
 ljt1I1b/LLPFFKBKz54Nt6+5GG4o/UQPK96nWC6K7evec3XL4VqAiPT677IMqiWqJZRo
 7db7PMe4zG29+rKStqlC0FRwjL0CDByf3KHP7E4jQ808qsgENGmE27Pn0lxpmULYcmbX
 dCv6bkg82ZlTzBMAqkKVNlDi73pmtjysyKI5orcNN7oDuGOlZ1P8BKDgIemAjy56yzux
 R/P3SM05Gm3CjRsBbZBlG+12p+K/h8Egw4bOjZ1wqfYDbTvZNSO6wF2wGhjPQEL0dD+R
 aSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786582234; x=1787187034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NaQE6f2Pc9mTVAO9MpVP9WM3c+ia7jvor2cvLmY6xZY=;
 b=Zb1Ty6f1B8c2N4DV4hX63BZCpBvisaSnvqFUl9GZpUZIL8KruYP12Y9CRUV30TsE0Y
 kLtzLsfw9qHAsoUjjttnuYhiv6yzmxsU4dYhbhD8oyLQaYLl4GE1p3e1osA1FMCET4kX
 JMIYqlrj0lz1aFOOahkG5BOy+KGBc7k/etX55PFIwWn2xHya4DIYTezmwt4rT8YWd1Pl
 x0IBT91CEec+u9XcdWc8M9aM1r/dqMFIvL7OtZD3iA4buxTtEWcYPWkitXOjpGUmA3hU
 6oRd8shMFFvYsCwV5bX2KObwOIGro2flmAdPkG3foGbALcF1LuWe/zvssQN8U20oq+cn
 hylg==
X-Gm-Message-State: AOJu0YwAA/PrDYBlZTwY+NIt31s8zJBhu0EMHQ3lPAwadYPGqiWfXYne
 A9dxGjE+bzUXCZ83FMlgoDqVY3opGMSPm20+MtQUP3G5NeHIDk712WOPbe9THnyr3uoy4dK7VMx
 fjd8L
X-Gm-Gg: AR+sD10pJ9yrfhHf9YTEO1JYzYfydlDqtviOoJMDDeH8Z93idh64ZuG1ImQ6O8g4gXg
 gzOlefaG7cE0K0lftR+m/rymiRnsuq7Ab+w2HoM0VjF3GzjK0y5pMm8zq9+Ys+bpMOE9FPjdb3Z
 TX+FQ+zemL6MuH4mOZN3Sd4aNySR22ykLGEtRp94MQs/8a+sDbCTH52vtK9mLd3ymSe6+3HX/Re
 WoYdcd8XCPMYBQV8AOetqZuMru+snEXlESZ24g6hwlIttIa/VK96+wLRZ4RzVxc9SfN34YWCbmY
 JMLygjd4fMDrgA65Ozgke5Qo/HkAew601ML9exknFZbW9ZCwGjoqeZoL0RbH7Pgl4fUNiZRDqzW
 gUj4gfD19ZxoTpAFXDCQg6h3W2bR0neRVQ07ZmNb3jglpjOzHJg7JRc+5RREZMJchWsT2H5e3oU
 +EA1D/IF4y/BAmthNmWHYm20xiRuY33lEo6jKifisjN170fWwO3PTgwx0VtVKRWKlj9Kowg9VXC
 /XwgF+6aiBcKYPQDXLIz6AGVj7X7q0=
X-Received: by 2002:a17:90b:1cc7:b0:386:ca4b:16a9 with SMTP id
 98e67ed59e1d1-3931f959a78mr705080a91.16.1786582234432; 
 Wed, 12 Aug 2026 17:50:34 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931ca612e7sm1259918a91.0.2026.08.12.17.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 17:50:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Subject: [PATCH v2 2/3] tcg: Return success from tcg_region_alloc
Date: Wed, 12 Aug 2026 17:50:30 -0700
Message-ID: <20260813005031.518387-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813005031.518387-1-richard.henderson@linaro.org>
References: <20260813005031.518387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Invert the sense of the boolean result from 'error' to 'success'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 2 +-
 tcg/tcg.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2161d961d9..8ee8c39c43 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -383,7 +383,7 @@ bool tcg_region_alloc(TCGContext *s)
         region.agg_size_full += size_full - TCG_HIGHWATER;
     }
     qemu_mutex_unlock(&region.lock);
-    return !ok;
+    return ok;
 }
 
 /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1e77f2365a..af15c3d63e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1835,7 +1835,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
 
     if (unlikely(next > s->code_gen_highwater)) {
-        if (tcg_region_alloc(s)) {
+        if (!tcg_region_alloc(s)) {
             return NULL;
         }
         goto retry;
-- 
2.43.0


