Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C70EFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuN-00045l-C0; Fri, 01 May 2026 06:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuG-00041C-08
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuD-0000CT-9w
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483487335c2so19479185e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630532; x=1778235332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Jd4Bv7gDeHF4Ecup4fCdp7ybRRPNHud/bLTRm6ZvJg=;
 b=s8SdvKWv1EJqiJLs1M4/TtKgmdbIpJXGDrQnP0nQod0LJMv8bIXchuKxE9ASw9b3Br
 +wMsIt+bMCi7Fc2LWKj4YDK7J0vMrT7bqnsR8QHp94LGzAMriYjN4g0pB5lNi/y7q6If
 /X8QG+BQnPvJJ5bqz1eM+2cf5dOqBMdL1/6fBcVUwxoT7oPMLL39dWOb/zeDwnDiOJf8
 gO79eZdGhW4bqUsOXaJC1Sa9S51eO7XzaGdoEq8GV/f+KIYfKYHb57GlSZ6Usp1eeBgg
 7r1BI54lX0oLT9i1vTLl5jyS9OWASGF5T6wq5qKj+sL0n57nRDKMEsIPw+6GSpYjOHr4
 z1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630532; x=1778235332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2Jd4Bv7gDeHF4Ecup4fCdp7ybRRPNHud/bLTRm6ZvJg=;
 b=Kzi3BLb4NPz/Tk/Dx4ZiX0WAxnpW0X5KBH6ofgFr9dU+L60Oag5GysFLvz+sbBZGOb
 HCg+uYBwHrs7SBx8p48kfR0Y3PudVwjbP6U+KHRqU32AAV2H3FTEfiKGt2ne6R04+25J
 pkpl2G2f9o6qSTt34q+9rU+fonBOWxIJGsYuuLb1bhe35qEhLPnlX+kv0yFHILJijZGO
 /a7DalFBohV1r9pgI1iudMn1/Xy3ZPuIWvnuNAyLlXLptX72+5YRF8qYz3MMFt87CVKz
 PlAY7tVzTO8hASrC79PeeoZorVmM+y6T2EZlupLxe66ajNzCkkOgvr63dGh6sVCGAmIi
 NvAA==
X-Gm-Message-State: AOJu0YwEQneTHcCjIMosypmhE9uRlmWgVRf61zzingjpZx7OgEzXBoaS
 tFtTfDVjgbJxBjYvq3WQbZkQ96wgJFPGELmyz/PwwzPpUEG9z66oUHiD1RcXz/vc0WXbeO/wpPT
 WsJwp
X-Gm-Gg: AeBDiev30Vhzax5BX2d7XDXFHIic2LRErDE3ABzEDLhXumxm3T31i/xfikyyBCHnX5C
 7WDPyYgbF3zrgc/uAcF/l5WVsSFMwoTQUO94xU3qowsaNc/FimQuutDwrgCNGW0OZYugTVy7zAL
 hAClA/qaFJclanHqOUV/pNRBAJB6iBMszrFNTd0uuOaEWsliJeBDtT8dTmsxJohIGzab/4hb+H3
 M2TKaTAL3TEKRTJk+hdIZxRx+Y6aOsVQa/d/WdqEctffVTV6fyFE7brHP2FhH/Dr5w1sPo0rUIT
 gjqe/tmICUD9QTiCTKwP8IPzmyNZPngb7A+2otRFM2TOs3VXxiIP7kpX7HdiRuk7QhemuEUt9SN
 N5rD/qS4pCp3Fwm+MKfuDeEmdXmrLH9jr6raoY1BjKTSwGPHT9fUNwRQ9hMd49Q8kVaPBj3qXbk
 kLiILPnf5408rwDk8N5jR5thI/ewnw0jlXMHqr0nnfPDu/7fxvJZdPEm6LK3YiOcWzC4CWFgY2J
 mEhOu9cH0z0zMxyXn/PWbRLkvZG8xX5L7ywTavLtOSM9m/nDTLH
X-Received: by 2002:a05:600d:c:b0:489:fec9:a17e with SMTP id
 5b1f17b1804b1-48a844f4fd9mr83236095e9.12.1777630531792; 
 Fri, 01 May 2026 03:15:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/28] hvf: only call hvf_sync_vtimer() when running without
 the platform vGIC
Date: Fri,  1 May 2026 11:14:56 +0100
Message-ID: <20260501101505.3485916-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-7-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 09f41094e5..fa0a22fdc3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2368,7 +2368,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.43.0


