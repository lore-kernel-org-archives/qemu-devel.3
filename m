Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D1DD7497F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdTw-0003bv-Gn; Fri, 19 Dec 2025 11:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTu-0003bm-UG
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTt-0000S0-Fk
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:30 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso988955f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162248; x=1766767048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCt5072MT4D8iFZ64nwix4KP4RCAdARcnrd2MW5vRvU=;
 b=pyPwbp/MMQkae5gT66xnaS3voGopHr3RQ2EMwB2fllYlsP136rj2LJfq/KtGCtKICo
 952gwZ93k2R4XiQxPHPm7koNP+e/9PmfSkSZyn6bIC9CUA8Gf4l3RhfbrgWVth0YGOpg
 kqAIKyPxXhit9sKss0u2MSC2eYpf1tw64gtH8ixv+q1rQmZWEzR075lar1yjN9Ug2EGx
 XUOQtGM8OJGjicL3il7GvX/5vD07c98SGfCWofluF5YFiEuSIZgeGomM6onHiFX1TaJU
 nm/KSc5y6UnQZ2xB2uJAq2A05O5NUH2j3d5p3npdUtbEQ2+7dqxSCjB22RMXDUyCogQz
 7BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162248; x=1766767048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCt5072MT4D8iFZ64nwix4KP4RCAdARcnrd2MW5vRvU=;
 b=B/cSCIvt2PDWQvUQofGhEVlI7odds14cha+Nwc6K/B7VA4KUH7MTnp1T/C8S3a7sTt
 wGVJqIeSJ6Ay+5onE+6AxQOxenjY3YKOA3LnoyeLMYP/aRoJ3zsHkeO5JncD1pNTGr1z
 LS14vTXjGqCBAO/4RuC/tHWBhm9ZN5hpvJZA6lCgt+Y/7Zd0YKkMQDfjCSNzT52/cJrC
 FGNZmNWsYmkEGtgIKoFLT+rxRP5JIMvDFc6gyIaJFSsCRTRo4HyrDkZUUAm7M3BbOI2A
 YLE/S0q3r1YTcZvxFHsqrsvrJoryUZ4XNE+5B7NMIJOdJjRRop+jo3kSPUR7A5jYwef3
 BL2A==
X-Gm-Message-State: AOJu0YxbSpFm/nSgk7Jfia2A5raoCRBmbFuPOup1uARxNW/0e3RueTlV
 t0JzlUwbvQnwUQTVtmyRRALhCsXq3T3GZefA70JLt8vP8zppapeFzpjfgXzXD24abO72Oo4TmvU
 JvRCGMKU=
X-Gm-Gg: AY/fxX7tZIQMqdeh/no0v7KlBi3c4KF9jmdUSpg+hnF3or2dO/m5/j6n8pvHvO4bcMg
 mzP7rEKXxV9jj1m8bit94DxI+gA7aEh76CbFUaFTWwTRJQD6D5K1rrKiLj0kMqqUCWbQB1i2FiT
 4FtJ4Y3aQWIUe2ABcrdrocxkfZGPKVHefOKdHETJI6U7B47ACsM2FyOnkRPEsIn8/Fy5PO0s5jF
 qKQYwk2B6oVhkdBoEVHUmxr4iMSZSVXMitXR7UT06xj/dhlNMpl6R13jyyQ6kH1nz8bxx4VEp/b
 UkFwDDFC4vGXRiLMdqB8Exmek4kqBC9J041USgb7rR6PY5mjCyRn6IAYD4TWIhIX1rUsAuiEJWK
 LnKDMxReG+/oHnMVAafImpvNk1mZVM/GGgwx5y73Qi0E+ykIj8M2yg4kKfzxN3LZ75egZCnsidS
 J4yxLCZuSQZ+WH6MuMDL8IX2zX+YQwqPxJfmLO7GO1m0gktdzqYfLl25iKm7Op
X-Google-Smtp-Source: AGHT+IH2/KwdCJjnVZ8WS/K+hnlCRy1ArMX7mZub37twLzNoXbZGIMlwCZKZP+cFSvUmc8YNGpMrvg==
X-Received: by 2002:a05:6000:24c9:b0:430:fc63:8d3 with SMTP id
 ffacd0b85a97d-4324e4fe005mr3763347f8f.30.1766162247653; 
 Fri, 19 Dec 2025 08:37:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm5622615f8f.8.2025.12.19.08.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
Date: Fri, 19 Dec 2025 17:36:45 +0100
Message-ID: <20251219163650.74303-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

We only build the SPARC targets using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 043711f11dc..d879ce4e262 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1194,13 +1194,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
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
2.52.0


