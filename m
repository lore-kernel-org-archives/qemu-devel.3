Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF9CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jH6-0001cU-R7; Fri, 03 Oct 2025 13:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jH4-0001c8-BY
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGU-0006Eu-22
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2681660d604so24821855ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511287; x=1760116087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVdjjmeNl369fORWFFYrAmuAxl5OexK+Goh2FzAHrEY=;
 b=cbn3Oo440JYyjLJNsXP0iezSlZde3jTjGksEezK16uWzlSBF72ocHIONJV7orTJoDz
 7oFjgbFVF1qzHXOyMeRAMeGmfgc8JKgjcEaTksQpoch46j9+TtKXhKjMaBmTX8eFMyNF
 ZGSGb0krxCvrQcfSiQQzZ9hff4oSA/fOrtfUrFs81ZAQJRwwZL71nz1svGSFPwWLWvmk
 Kf3wA81Ac3UqqOr5C8jZNqNZrywfFAhfhqGmJk/wNdTYigZHhL07KfOBKT9kEtCclWdO
 nwDr5svExr/+aiQxWKZ7BcNl/+uXkaBBpxy6P8tnwFstpKyivvLxVdJWxe19OTSl9xQ9
 TYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511287; x=1760116087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVdjjmeNl369fORWFFYrAmuAxl5OexK+Goh2FzAHrEY=;
 b=GyHZrvaa53GnYaUBn1Bws+T4UhgfENb0Oezzyf6FdVOtoI5Oy4ICjUEWYLUB4LzpGB
 YkZkrpQd3cDibZdhi8V9doBDc5H3uzSY6EKJZ16aQaaYehNfJQIa3DW/ob8qOiWye0iT
 HUEKvmu/MH6LrjhCdE7m1KeDTLs4Snob4PtX9Qu2yOgT1lJX0NnBXhKekVlOJ6yX01PW
 bGMs5l70h/D7mODhIQwrxB7wiKGoPZgHDWyJGFxkET03huV6UswWt0VsO1kqkfiDsDTi
 ZMqNwtiN7+aOoZYr+0fStFZ3tRlq1KXrKN901htd2bDsO4k/nex4pAWLDgHPR3+44/BV
 k6ow==
X-Gm-Message-State: AOJu0Yze5SE1BEK6fsW3yz6UjclboT5JT+HDuY+Zd/VczX8Kct8tap7r
 xV909b8r/5mFZ1n6z7LmpchFk7ArUZXv8BQLIVJSywddv7BGyrSmHaIO9A5YvjGLJ9OOq/GxR83
 svVOXTAw=
X-Gm-Gg: ASbGncu4eO2TBG06RH1QdBXkHY13arW8/PXABYZXe/Y8ApkwytDZB1oK8iSlD1k6YDL
 CDJW+KIGlCYfN9165Fb/9ZKhAqlVHA5QZiPvGC2f7/sIRcHVNk7AGeJikQxZZqD2+qgapJkqUxg
 YMA3uoFfZ+whObrQoVq/p6KgX46+asC68ahJeekifxl1wNHTpFDRnkRe+prIzZDkc6mib3jfh40
 GbMV8YvCc/Xkcv8yy5l5yrwp4x493UBdDt7NwTQzsU6oMgE9q0vGyIv95053zXj65Aok80soVAI
 nhoFNAtIRWhwzJtdjPFzCCqUUHWDJODWcyP8Lz7jqC4spDJ1mMOvQVcJ+UfRfTBnkhza+9pFS3+
 RM4h67c1AbKTPcwNQGgzIaCxl7ksecNPc7PzIH+HecNN3bvgX66J6C1XB
X-Google-Smtp-Source: AGHT+IHvfTNb+qoz9SMrc4TkGjPndigteGGKkkJLSqCpXhjbJGh/mCzNmDm5Sam6c9ztGxPza7fdhA==
X-Received: by 2002:a17:903:2f4b:b0:272:f27d:33c7 with SMTP id
 d9443c01a7336-28e9a2fe26emr41738785ad.0.1759511287286; 
 Fri, 03 Oct 2025 10:08:07 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 06/73] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Fri,  3 Oct 2025 10:06:53 -0700
Message-ID: <20251003170800.997167-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ebb260d54d..d6d704e2a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -76,6 +76,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1641,12 +1643,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
-static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
-{
-    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
-    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
-}
-
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1698,6 +1694,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /*
+         * Cache NV1 before we adjust ptw->in_space for NSTable.
+         * Note that this is only relevant for EL1&0, and that
+         * computing it would assert for ARMSS_Root.
+         */
+        if (el == 1) {
+            uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+            ptw->in_nv1 = (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+        }
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2073,7 +2079,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


