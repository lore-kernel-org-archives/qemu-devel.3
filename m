Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVop-0007kv-UH; Thu, 15 May 2025 06:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnc-0005Oa-Qy
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnV-0008FV-2N
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso7720095e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304799; x=1747909599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VzUYeVehWBpH/+74MDsuZXiS92S2Pkyo2cNDX9duuiI=;
 b=J6qYBCN2jpHNjf6A2qYlIowzteap/W8apVEM02YKaAA6beXwlV8CXBbJS8GcWi8IuD
 xY3Tyz/s0nVz6YZlHL0TlFmXNgPYfd5fPCQmkBYIf2JI+rMWIT9uvo4bF3weu6NcHK9+
 EY5XA8SkUZFMDJ0fjYVBK51j4rMREl7Ln2Z4rVIAOqRJaSO0Ej/6DqZ5NBJz3uLomXRW
 JN4yBtGYKDg5DE5kRElFZ5CAwk9nnkB0quA2twSWNLtG2nEli3UkTBjHI9Pts1zTPaW2
 2Ia52GzOZVmjELnL5ofGA5ZCKi1ZcAqYB+BU5F9JQ8A0Y6NsMdG0G4T7/zeQKZ4ks92o
 6lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304799; x=1747909599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzUYeVehWBpH/+74MDsuZXiS92S2Pkyo2cNDX9duuiI=;
 b=cqRZ+Ti6IRD5Sf69XIcDJ/MC1usjzdIOts0HISnTuxncD9sIvATBmcfygPT4y4Xfze
 40GWBA61+OgY9ED73hcnzEEZnO6fpzTtOjwoDM9F3EXSZXlox+z+X2Z9rvIpyy1YSzps
 AXalFwcIKmjFFx4a+WkwczDIrQeWbAM8mD97KykY94QxaNuglK3TtxSIgPZl7btIBPTC
 cHWwRf9NtVSOQFFQX3PN/3adNLJCkWc3SIbZpskyg2OQIp5rygWeSxTolxbp1LscuQtn
 Li3M8ZUIz8ah2MDFsYaLgjCQy7jQjiLyuSM+n3znAku7sG6KP1wl61v6ctcGJd5aev2J
 luTw==
X-Gm-Message-State: AOJu0Yzhl2EOen4JCYOLJvyDwWa7hv5swqBa1MJUsI4vqjdjsWvXS7lt
 aT2ZpdDqo4bukjLkoFU1YNEhoBlJec2I1txh3y8zY0O7hOD26mT4euXw1dATyCkFQ72RR1snt79
 7w98=
X-Gm-Gg: ASbGncs924lGvKxd2NKNLQoe/jgaLNBBoccuhDFnFHEvDN+75qZJ5slwHysssM9kIWL
 QvRfpbMTxJx5FHSCMuste9ow2eLdJ16bzIHsMtm2ETUyaII5xk1axKJGy3WDGr4kREK54gkRq/w
 hvNq7m/tML58X8TN9kEa7Y48bsGrY5HZA2PU85ug95NcckVv5u6Myw8fim9SNFcMKZ2BUTigtsZ
 M9HXSuGh+Zj80InF3OE1LFaaH2GUY1qJDo8W9bpfmfDPz/YaAf1rd4Wc9exgTsSgpQ7+7d8QwnK
 LDsTJipvkac7cuLRn5x5mDrVArxMB0Vz+0KDyek47rEAaXhTa2JhVCLxkw==
X-Google-Smtp-Source: AGHT+IHj86quehy7uUCSTP1drMRgGpqVxcQYPmv2Q14xcvUbXJnPftSLe9d+r7XYMYph7DWngbDXag==
X-Received: by 2002:a05:600c:8411:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-442f20e93eemr68286735e9.13.1747304798681; 
 Thu, 15 May 2025 03:26:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/58] target/arm/ptw: replace target_ulong with int64_t
Date: Thu, 15 May 2025 11:25:27 +0100
Message-ID: <20250515102546.2149601-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-30-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 89979c07e5a..68ec3f5e755 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.43.0


