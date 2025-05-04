Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEFC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvI-0002O1-6R; Sun, 04 May 2025 01:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvC-0002Gt-Jc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvA-0004R6-TE
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so3108106b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336587; x=1746941387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoA0Kgl2rygvKGIkAwhDx+FIBh00kPrYN/3sfHQDQ5M=;
 b=EZhejwzKcWUG2eqcSzlqOOPFY5fpfrR3+EZF5xjL/+gp3Ww6ZOl+3d2watJt8pWN/k
 GxpdDFX5FWK3/YZFQORLh8qi0n+Ph1UmbjeM/XE9HcaxLCE9kf2gVaTSzdReJ3IaSPOL
 ULSgQDHtP7zk4SaCeaBQiodxkahyv+/ZrVAn6ZS5+jgNDjlQd6WQMXUFQboOv258ngPG
 rmfwNYpcvSKk19wg/RK4YYl3PWk2miuURLeRjUS5lwxflwdoaSVEbPKUkzEoSaOqkS+k
 Ry4+IRw2BUf7rNtSTT/YzKUa1tRIc+tUsumBV/claDjcTizPHk0aRnC4OY4P/+rNyd4y
 bZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336587; x=1746941387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoA0Kgl2rygvKGIkAwhDx+FIBh00kPrYN/3sfHQDQ5M=;
 b=JHdAbdax3LfjmU/an9cTPVr0r6/jAjcQ3wyMl3w6KJ7ONFMBFZTnnZGGfbrsUo8x/J
 HwpW+OiQq9X7nQ34k52qPFr0n/Dg0ZlmRykHzBZe0msf0M01mczoTX/5GHq+DZPEGEix
 acJjOw9jrqnmrWhaau/q7EUsBX6l79G3Jso91td1aN0lE1hZvbr7xIsoqbHz6s8lVyda
 RaHy3ZCe18TEuXwZJA99RS9KZeYhHuAqEmxhRtc5TSY5qRsVA+5optnio/bun28ooKkI
 qriRju8EVQRk/lBsnjfCmxtXTPDX3rCETdocnsnc13soSqBoEAKXmgEW0lG4XkaUvWUU
 JvvA==
X-Gm-Message-State: AOJu0YxfYdvWViWX5FIFwXXdQMEsm/qmN3JYTWdy/wo2Xbv9lawC+CCF
 bEG+JmUOcGCgqq6IPyDQ7nh98eveBWEucHeTMSiffzIiPcvsmOFcxxeX2os+9ADeF9UFd9qeomy
 wVoE=
X-Gm-Gg: ASbGncsUqVt03f89UyRTkyVZL/gl2C2+DlftGSYSspZ1Sy2EZ0v1uz841k/PY37RN8Q
 23hLZSSnDUrd570AkNSxQ5saCoVhU8m2xRYBt+MKZvr7nuakRPgnttOueqdw8PgKxmn6cxeckB6
 aWs4GImskDPvOON0xobw6C0N4zj9JHyvtvx5btT7201L5Ip3mf8pbOkr+xvhQQEG6Isg+wE8gBL
 cdhmO7K2YZMWA73nGqAAA7vwtTqjpsRM3L6Rc3fxjowmkNG/ZQvOZVuQlAw773Zu96zbNyQY+lL
 29c9wK6oHRenijgiZVB8jjtYRXTiJSMx20qKFoEJ
X-Google-Smtp-Source: AGHT+IH3vm9MpG2MZs9UPMSWDERbKRH/7rBr8oV4iU4Hz/r/vqw8nSgxVg2rOHV0XUqnb0ez/kKhKg==
X-Received: by 2002:a05:6a20:c90a:b0:1f5:5b77:3818 with SMTP id
 adf61e73a8af0-20e97abe098mr4252718637.27.1746336587445; 
 Sat, 03 May 2025 22:29:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 31/40] target/arm/ptw: replace target_ulong with int64_t
Date: Sat,  3 May 2025 22:29:05 -0700
Message-ID: <20250504052914.3525365-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d0a53d0987f..424d1b54275 100644
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
2.47.2


