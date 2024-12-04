Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E215E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwC6-0004yz-T4; Wed, 04 Dec 2024 15:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwC5-0004yr-9T
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:41:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwC3-0003Mw-Pd
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:41:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so2486505e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344913; x=1733949713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eTSqZg5f9w+u/Eg5cV2Wnwe+yck0r0M9eA1Muy9l3TA=;
 b=C6WGMa5CxGXRjedhuukpQXZznh2iwN8EOmTs8llXUG57hfZ+kX0F226NUr7myXmET7
 fnLLvBwuzaM6pVDgvA39NFO/+nGmqI+F+XUSZafGq5o1cCm2fMt1RiAX7UgB3JQnD6Lf
 zr+niRSLw9QvBW35o/nOeuHUhXsSWH6UW1w86LdShpSgHsX78zfjx7San2WaszNyHXsL
 hGauZiX0Zop93t1m0Z2OKAOTWDRl5bo+LFTa6fx7YGOQCjeavG9BPfjmJfOt8zoqU3cm
 r1uoDdAbvDhH6WhFmX12xxpRw15DEJ53Ump/WedopIOrZW6qdoIh3vXYWlORJjueR7cc
 I1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344913; x=1733949713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTSqZg5f9w+u/Eg5cV2Wnwe+yck0r0M9eA1Muy9l3TA=;
 b=OhImfOzjwj/aaOUkzV/aRTJTL6khcqawgyogRNB/4Pyd+E7RKfNqG3IVySpx9XSFQa
 EIyXeNW2ES3x0CeUfAFJsoPqCfBR9JehFApRMIh2FcsZGp6gLaLOv1tcStlIP4gDwcX/
 ddXUUxJMSrRrx3jdemtRbcKMdn8BGwj0lVjoH6GtBusMdKCkJT2qTNrG0aB5bkEprLWr
 WO3+XDdMuNwfuEqYiYp0pD0A5LSifkghWNJbbdUBn+bd0t68bx+B/VJHBVbkFLjgNZF8
 flToNXFhNgQWNJ8GQLEqsbQz7wfIigIJmpBS8ubsNA68/t8SNEHI5FF6Lgll+wlfHn4O
 zUNw==
X-Gm-Message-State: AOJu0Yw54u4AmCqv3K97pkoZj8oI4iLYJdvnxNE5SJBJIXzKRLD//lQb
 f2rNC0yg+lG/ClMvETrIyElH/A9K2wmOcpnbpvFwhhNza+sqVAv8RdLnaVl1xNmWTVN01FN3Tmm
 5
X-Gm-Gg: ASbGnct572iKj5S8TTHriTYfjdqzglMeWmGYCCkH2XV6MU3tFFnE7JbPnl9sroFIpmA
 /aysGKLJWwF7qaMBqGFDrNr498mif16Pe6VcoyG6fQGW3L+/8gvKIgBCtON1074Xhbj/X/Hs+3a
 VDyEJY0z628sMHLyxYrDXOPTCnGyo/evUGastp2dqcSMBzMlZsgewbmqHrOrYbdYJwxkXzwnQV2
 DvwGSJofyjLcdLWuTRk7zKebf0j9x8W9A1oVmzLLq2oEcqS2Vw/IN2IEIahEG9dWcHzNuqNdPxQ
 H1SCnDB9sDSNYVolQbDCP6+0
X-Google-Smtp-Source: AGHT+IHiMK3pRU38Umy1iD15UtgotNAK5KFiNw6qpV6o5zFaknRcRgy83mlqKD8zKP+xuPkvwqscgg==
X-Received: by 2002:a05:600c:a06:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-434d0a0e3b9mr72969065e9.22.1733344913618; 
 Wed, 04 Dec 2024 12:41:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52b71f6sm35032885e9.41.2024.12.04.12.41.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:41:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/sparc: Use memcpy() in memcpy32()
Date: Wed,  4 Dec 2024 21:41:51 +0100
Message-ID: <20241204204151.61221-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Rather than manually copying each register, use
the libc memcpy(), which is well optimized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Worth renaming as reg8cpy()?
---
 target/sparc/win_helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index b53fc9ce940..dab0ff00ccc 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -26,14 +26,7 @@
 
 static inline void memcpy32(target_ulong *dst, const target_ulong *src)
 {
-    dst[0] = src[0];
-    dst[1] = src[1];
-    dst[2] = src[2];
-    dst[3] = src[3];
-    dst[4] = src[4];
-    dst[5] = src[5];
-    dst[6] = src[6];
-    dst[7] = src[7];
+    memcpy(dst, src, 8 * sizeof(target_ulong));
 }
 
 void cpu_set_cwp(CPUSPARCState *env, int new_cwp)
-- 
2.45.2


