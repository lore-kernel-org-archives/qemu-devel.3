Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26541CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnSs-0002aX-2R; Tue, 12 May 2026 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMnSq-0002Zy-HM
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:48:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMnSj-0000LC-R7
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:48:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0046078so46620755e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778593672; x=1779198472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wtlir2d27CqnUEFc37Jq3x9lDPJ+PuPEk9b4VuJO7ZY=;
 b=DipskvZyhbb5AlerMRODUGuQei9WL1jR63LbfpO2YlNJ+VZSgf4iSfqmOq2k7tjHUy
 c4Rt3QfpXmTmZr6dBMM2Aoom8U72NyaJtEoGUv68ibcLi2v5oaOO9EdiCDosxxxTzUH3
 CYgXo7n3ck4xkLC6AdlhOpmgQpMrctUagatIYDpova8Ik9t2Fzogmz6t4MFrhXjKfhG2
 Eaih+dbuZ4s9xj0r/WOvaeM4M4xTMckJrr3WBQRGUKh5jef4JswSh6CXnyG56KFaDkaT
 ZUP2RL661wBWJpdzKkSy8B4UHFpD5jhf4jcFatQZLt1oj/me47ws8w8qGCLHY5WZuTjI
 oX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778593672; x=1779198472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wtlir2d27CqnUEFc37Jq3x9lDPJ+PuPEk9b4VuJO7ZY=;
 b=LLPRGFa7NAQOHSTtAuVt7LchQUJ8m+URhBC8Vp/HNqBv44G+bw8UCIcfOAWqUBXfbt
 2Hj/gkX+zUkwWic3ywsVQA3MzRNvwQ5BL5Ukayk5wcBnepy1cdgIw9klRBpoAE2+oByK
 8DDgDbvRtVdsGu84UvBVw6gTwtWxIfiXvnd702r67UGdy0U74BlRnMDI63KlGoDy/G6S
 RxiiHvCCD7AUKMBS9uZdmWuGahgbCUgUfAiw4HHBUPpUNf2QGxkGwWDB5+IFV58QzZkc
 z2ZJdea/UJ+jTh1RZhmkrDUV6eQY0MNjWN33Cpq1ptJ3WWT2ZcL/ziCzQk5ZDFN8lqD5
 rRow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JJ3oEu8UD5SlbffFU00fBeXp1tYAQtjvd/CmdGkEtVc10dzeGqbjslXrKTwA/SFZB6NinQOxYMnha@nongnu.org
X-Gm-Message-State: AOJu0YwRfmMvC+HAVmJa0eWaO4w/t9mdp5bvBJVzI62ZyD5pA3UfI40z
 GdPxi+VpvK5bZxAZNVi/se1QvZ936Bczwb66oaEG2lm+TsMBXKn6oCJtB9+qm36Z5eM=
X-Gm-Gg: Acq92OGBmH/qOj85p+ktiCjwGRqj34lmiuhq1hF5Q7NHQFvCf8XjTubOdrLus08hhDk
 FhRU7OGLbNHZ8/Jkkm2cyGdISIWzXp4fZfYjpAk4X5oDuCLLy5nfrLy2VE5u2Cyuuuhdh0l0y6l
 d+bjwyA6fdlX8/wH0QHqSTLhXFLvbZ8mUNnIU+dKfXpwfP1CgwwHasbVAcAfHyUbQjm347OvNwA
 hXRWA7M/axOkI6s+Xtq3GQlO5D9D43vlEDS9nIPJWGqHEFai0CTVrfmCf2RIaNe6FJyJ58yxLmn
 FzMK+J9zHC9mCdsAOIe6gr0TJpUhOwYzmQhw2sZPvmQ2RTnNfQf/sbtFJmweH6e+h1Xx0wKDGgp
 ZVb6JhNSZAV3yG2lP1ML0BQ5cV4a8yf8Bd3bAVngx+3RXlK6bBgTp1oDVI49Blf2rEJmW3Yc2ot
 OR9bOIAnqGR0H8RYOvWqFxOaSdPxdQqLG10QvBFa4dLUewTLVhKIzNQW/ZBylaYRTH3Q7BrOrSa
 nrGtBtMqg/gZIdDkt7WdeYU6fwJE5Y=
X-Received: by 2002:a05:600c:698d:b0:489:1ba8:5be9 with SMTP id
 5b1f17b1804b1-48e706f0e53mr235890965e9.29.1778593672016; 
 Tue, 12 May 2026 06:47:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906ae8b5sm80737515e9.6.2026.05.12.06.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:47:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Subject: [PATCH] hw/timer/mss_timer: Remove dead code in timer_write()
Date: Tue, 12 May 2026 14:47:50 +0100
Message-ID: <20260512134750.3543639-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In timer_write(), we switch() on the address offset to handle
registers that need special-casing, with a default case that handles
both "unsupported (64-bit mode) register" and "can just write value
to st->regs[]".  However, as Coverity points out, every register is
covered by the special-casing, so the "write to st->regs[]" code path
is dead.  (timer_read() has a similar structure but there several
registers do go through the default code path.)

Replace the dead code with an assertion.

CID: 1613905
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/mss-timer.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index bd3f3e845f..25fcf42aa0 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -189,14 +189,11 @@ timer_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        if (addr < R_TIM1_MAX) {
-            st->regs[addr] = value;
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
-            return;
-        }
-        break;
+        /* All non-64-bit regs covered by the switch cases */
+        assert(addr >= R_TIM1_MAX);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      TYPE_MSS_TIMER": 64-bit mode not supported\n");
+        return;
     }
     timer_update_irq(st);
 }
-- 
2.43.0


