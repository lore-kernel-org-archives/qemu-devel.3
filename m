Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6168CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsme-0000eG-H3; Tue, 26 May 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmQ-0008Np-QO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmO-0001GC-V3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6261534f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805751; x=1780410551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3zQXLZYl6qwt75DWKw3a5+VHMvKIFQLtBVHOyUPis6M=;
 b=P5ek/QEJZ/H+ES6wWhyOVbkUG+Yj1w9Oq++M2PRXZQ2x+ZuO3lKlci3WUpmBKEyND2
 mlN7INwlgSSJJYIMSOv1o6fhcezJqd+EXjbpQe9Cvm1xv5A/ecKSkKmv2Ze4YtbxDdCO
 g+K0oSh0imyj8tiwcsvvcEhiq58AahdJ9cWmb8RabF9szs27vKgAn8f0U0em7iRR39/p
 E333VPI58Q32yMCVZPYwW1kRzUlccyz23MxX5dodID4VEWRfk+MXFALee8txpjmulF50
 q3mdLE20bTgmOmnjPeaXXKEVctytfAIhBdgD5uFO2ZeVnWfLSyawDrvqc+/+TIEgizL6
 eZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805751; x=1780410551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3zQXLZYl6qwt75DWKw3a5+VHMvKIFQLtBVHOyUPis6M=;
 b=pe/MiBwUPYx/sUrQKqXO0+3ZiFdiihs5DRu00MqdJSCo082jfN78UsXN56gjBEVFtQ
 5/bM7nPu43IaEZzNEWggk7ZMwcPxnYQGmLVz4HcdXj1Io+tEzqJvZg2CT58elphEyAUY
 Bi1VTVn9qEoSsZkd8cPKC2M3cjvZKQbnewyFHLguqNdKHjz7PdA1Hr0Wma1co5LCAgcO
 CDPMdQxecDmtpCpMMXifLw6ymx83Ed/4UUnh19XO/wLv4R30oVX7SHspAgLsHb0J8zli
 2N8/jOZumJjAxYHosySiYJOPzJ/ohXvIZy6jGzZpXpYfpjPlIe65KSGkUIyxGCWITdUz
 0dAQ==
X-Gm-Message-State: AOJu0Yx4CEna5lBFskmmGz8GhYRRyYeH3+K6yBp/OgvdFuLlk3xZ07hx
 CwmE/HEV2JbId2HUgD9lf/mc84pfPcQxK+YOHyCrAriyEmGh6juzsB4GhazVyGSRgbWY9Nc+u5c
 LvlDT
X-Gm-Gg: Acq92OEbd//jRc8lLDiLUTepfNedbY3yE79LRQ8zdquWTqT6JWEsfFC8JYzJ+ALgOWh
 T7+ocvg58OGbc11fSiVzyRmkLASMJOqetVzUyQygOzdpzaG5fcbvvB/ObSC4iLOe2enEMDasG9M
 gbOwIwXCRYuFlb9jhSgfJ/LIOthh0dZx2clEA9BFZZEEFL3w1x+4+MHJVOpsjhssrXLse5Ep1gw
 CLU9yGzwlw6Anid7CE39TpVxiJYI7psb06L8wqxRse2kxbQ9vX3LH4k0YydgS0hDzWWtBb1R06z
 bOSX7IghLIqCj55on5nivX6hzCpXcK3+TZbQMKdjOmbTpqWqoqxwKj8y9YawK2u48hM/DIWcoWe
 m86ZlZc0UQ0wgLo2ZUY5iVORpQqtXYy6J2YwvRk1pzrvsYR79IQf0Ge2KHHdlXxaf574bjWnUb4
 2Vy2JHBybHRcmBxglmDmCXeQB6nwP0vH0xYlBHnFmk1ts5avjhNhSoNgrgc82BjxpejE6CiWf1f
 cUV/0Pi/GUwcsepDm3Mys1WFKcc04M=
X-Received: by 2002:a05:6000:4b04:b0:449:9aee:4581 with SMTP id
 ffacd0b85a97d-45eb38b04d0mr32629503f8f.12.1779805751346; 
 Tue, 26 May 2026 07:29:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/54] target/arm/ptw: Flip sense of get_phys_addr_pmsav8
 return value
Date: Tue, 26 May 2026 15:28:16 +0100
Message-ID: <20260526142850.2326589-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-8-peter.maydell@linaro.org
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5777747a98..91aacfb814 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3191,7 +3191,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
                 result->f.lg_page_size = sattrs.subpage ? 0 : TARGET_PAGE_BITS;
                 result->f.phys_addr = address;
                 result->f.prot = 0;
-                return true;
+                return false;
             }
         } else {
             /*
@@ -3217,12 +3217,12 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
                 result->f.lg_page_size = sattrs.subpage ? 0 : TARGET_PAGE_BITS;
                 result->f.phys_addr = address;
                 result->f.prot = 0;
-                return true;
+                return false;
             }
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
+    ret = !pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
     /*
      * For two-stage PMSA translations, s2prot holds the stage 2
@@ -3755,7 +3755,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
+            ret = !get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-- 
2.43.0


