Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE91FFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9t-0006hj-8D; Wed, 29 Apr 2026 20:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9f-0006TZ-QS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9e-0006IO-4E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82f8892d4d6so155637b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508481; x=1778113281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=z8ZT14b/nfD7ezr/N2e8M1ZXaOLlC9hc09nfLZS8rOh7K6qRj8jeJWmbbCbSkKBR9Z
 h3aWFYj+IypQlIbZkFQMjkcghEpKHz4dGQKS3uBjPIp8IK1iWzw13OLURupbSF8we/83
 AG9oXRH5ci+WgNCWfwjE/ImchqyrE8Q5AuN1Uo7O7U1Z6yTjbSlLeyudW+LEQIISbhKE
 +UZ2PCb0g2yUw/RAFNb/QYQPkPQOQPvR4iq9aZfan9PcBGR3wfV+GzMEJfYK7AVb0jXD
 nXV8rOOxjv2s96wtIr2Gid8YXnNFiQubJU3Ge5/60TMXGDJ1HEwK/re6jEFJi89nGPHZ
 mRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508481; x=1778113281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=s25FgzZ53Nmer039jvd6bqahLdukq5jaE1R+3guYtbFEiN1YOPp+/OyYt4qAxAKMDD
 DH9x4MmyIqWEGLYn5cZUAv0+64R7QL/XGeFAJLj24nZpWrp44EqPRnlUTu8HxB5Vd/ck
 SLbDrZbzVZGH7Spr1GzBSczaVEmTYO7M1rpH6wrMU1zkx8zE4WuUlIfuV16evWhVHdkL
 b1xbRqYz10Z4w+w8o42EcgumMQjykKojkBh3fTND/03am1LR1JEv1slVSzwoDxF03JX0
 g0QWE9dikRo1NBxFhXIfsg0TVh7RcFZtIeipQ05HEkVRvgGL/HjSxD0IOYbOhCVT71Re
 pDBw==
X-Gm-Message-State: AOJu0YxgPiioJ4Ra8nHvyobTpEO2PdfiZGLeHciqMU0/mlbBIAoGWJz1
 CSrzZ+SxvXHisynD0cbBTJpCsVqNcwQrHoV8jbN9B3s18Yqdsga0bfqv30SESWhDLKaf1K5MDmL
 stUrh4FM=
X-Gm-Gg: AeBDievkFG1LGZ82BYN92bQ35ViQAeYeUOq7apYInnZVlw0vA7B+/VdJPVJYkY9RBL8
 pz4yE429Z3X8UUKnz2fcBb+SLuPKNTus3LgS6wNdv9AZh8+zXJdq4I/Iasl0Amqgwf2DPMDCOnd
 uYz92GsPTEtLfn8s/4VpdiXsdhqWryYMllpFK21637iQZBWvkTfRj9o/rUVjYNx/jmV8bA5Vkq8
 YtTC42PQniEzq2RGsAt6wBKEhQapk/W2/ylky0OrGyoRUWqwG5VQB3DFks10mG2y/7bXtixojrs
 yXfhc5RNG4uE/prXvZ+SkXOc1V96juLpl8KzSuo0i7h0ZTWx4RS9iqgzRaK6NCyckX/GRIrxUAS
 Zf4erqoOh9pn5RsGMoYf+tpAXLlQp6kWMcDInuhTWJALA9X8jlf6h2WhXa/hIMe9FxpBbMUQiaF
 rF13ITiuLr6f4EDCx8itLWv2Z5dGXoCUBHMh+USxv92pEM72meJXY=
X-Received: by 2002:aa7:88d6:0:b0:82f:316:31f6 with SMTP id
 d2e1a72fcca58-834fdc153f8mr791775b3a.26.1777508480705; 
 Wed, 29 Apr 2026 17:21:20 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 13/47] target/arm: Trap direct acceses to FPMR
Date: Thu, 30 Apr 2026 10:20:12 +1000
Message-ID: <20260430002046.59739-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b013dd51cb..d2a4b0fadc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


