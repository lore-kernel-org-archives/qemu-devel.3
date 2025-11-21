Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F12CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdJ0-0002W0-Ep; Fri, 21 Nov 2025 21:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMdIx-0002Ru-2o
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:24:51 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMdI3-0005Ny-Bh
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:24:47 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5957e017378so2718486e87.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 18:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763778213; x=1764383013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJnvThjS80O1Eon7AqXWBK1cOL1m23OMM4urIwDftzk=;
 b=EXfv9c8RAV69L2BEi3Mjdcab2MA4LBn2TJ3Uhd6sZF8a4mci/TSRTi5Lg3qBg9S5ia
 5SDvVnPcSZrmFetkM7n9sALnS5/0LC+cW3VNsojAkjHRTj2gWZM6/wWvDFO1YLd52JvR
 4VEAWPSZs33s4uHQQKCs35wMGr+bjrwWoIDwWUA2KYWe/7KpczjjCcrVoqvZxz+XpxAi
 +up7vB9hXlb+xxg33zEh6u4ayAWwLA0DKpyNtMSnbxp+ezRPGTTFVZgt4gQke+Z1WRv8
 VAu2F3iYlv0JVyj/048GJJedB4QmnrFQJvPc0ymoZvGMAaUO71s0PZS4+IEehWu/s7b6
 0wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763778213; x=1764383013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJnvThjS80O1Eon7AqXWBK1cOL1m23OMM4urIwDftzk=;
 b=RkV3lwVTmy02mZuMQwLz3GREwDIyelcrk1R2d+IP9Ny1O3v8qvAlVG4M32XQZgLHtZ
 J6EHb3jDLC9M8SJMHfSw+3QG6fCq/htAe8vTrQu+2xPhlUa8NvsteXJ8h8/VO5sSqM0t
 6l4Vce2bQVge+UpfCQiZzf5TNuw0RT75I6eob5GniwTolf+a5IN5LlDhSLuhWQzidGhr
 L829fFdz4w+GGpTHqkeWssYpaKrr1vecVaK7mNKQqaSInOS5/llC4jmx2/uTfcmBT6ji
 4qkfj21in2Q3mjh/QVIB7Umm98rw9ZIzhz+gWdpCLtrsYk1psVROZTgIAxAYsGyX9m61
 sDFA==
X-Gm-Message-State: AOJu0YyoRl+uFipUbwO7JNmTrY1Zsere3P/kSZfdtPNknsBCJeziDdXF
 IK2v2Qtg/tWhMtllU7HC5CqAXZIdBaqLpj/ubWSxqd8WreoMuRIOSkDFDjvKyICGbr3qEzr7L3N
 pifWfRjJfiA==
X-Gm-Gg: ASbGncuggRTD1vrEpICP/9gjIrSb054MVmA+rt+0NQEJNyNd3zsjGEut3ZdedFKuSHz
 F9QgaYhUXd4TIsru9vETUuy7AgjGlhayWu3mUliZx+kdXhAdGt1SAWpnD+JNGXsz/2PEiCEO9lc
 R994jG8322c5n/z+h+wH+7VE7CLyWncnfi9pJSxxoRRhXPxUCNY8+lE08eWEAtTdemaO5nldQWw
 LRj4VzeALoy25AB4kN4qRLxBhjHkjIWph+xqm+CKOj3WK+BxY4CO9FtFNmmtOdFHNiE6uKG4ML0
 H+/Fmtps+V/sVnvyLO4urHfIPcDdYSvo1KAGkgZDS8L99YwU1GprwXyx7HitQGEUYLYanWPhmiJ
 r3VAHlUubbT/a05Zl2Gskxl0tCDTzUEmjDBWbxUbfxn1bMJpr9jIH4yG1B5f1BAhXC8k1o07iQd
 7yvw/0aUz3LCfN0KZUOtnn56IZC5gMhlzwilk5VgkkjuL5ju1tDReZy8xD89BL
X-Google-Smtp-Source: AGHT+IFqYpf7OzTRpcxxvO5Bao2UxERjKsBecu9gO/aVZFFnry2vwOoVXaYFKsCpYeCfbQtJbrWpIA==
X-Received: by 2002:a05:6000:1447:b0:42b:3131:5434 with SMTP id
 ffacd0b85a97d-42cc1d0cfefmr2555882f8f.38.1763732805378; 
 Fri, 21 Nov 2025 05:46:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9190sm11433070f8f.33.2025.11.21.05.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 15/21] target/sparc: Use little-endian variant
 of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:57 +0100
Message-ID: <20251121134503.30914-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
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

We only build the SPARC targets using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=sparc; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..bd0257d313a 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = cpu_ldub_data(env, addr);
             break;
         case 2:
-            ret = cpu_lduw_data(env, addr);
+            ret = cpu_lduw_be_data(env, addr);
             break;
         case 4:
-            ret = cpu_ldl_data(env, addr);
+            ret = cpu_ldl_be_data(env, addr);
             break;
         case 8:
-            ret = cpu_ldq_data(env, addr);
+            ret = cpu_ldq_be_data(env, addr);
             break;
         default:
             g_assert_not_reached();
-- 
2.51.0


