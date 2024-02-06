Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CAC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNaA-0003lI-D1; Tue, 06 Feb 2024 10:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXNa8-0003ku-MH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:41:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXNa6-000117-E7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:41:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40f033c2e30so51610305e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707234113; x=1707838913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DShOABjLgoNKehmygkQQdNi6GSDp/6k2qhj3W7w/OeQ=;
 b=O36rVKOILLC6RyUeU9e0qSwqb5+OJz1Ua44lAy8lscEOVh1J0ZMDeSNgh3pg3kLhCY
 Q4bxR4FcbJ0bpze8AWEHSpvsS+/850wEOLh2sm7q6A1nene8VFL+582s1DanHKqGm87U
 cN0fCYm2Ecl3hk0rp5uRFD5EyMC8lyU+ilv8oEZC74UT9C0wy0taU70HEyJL8bSAOt1G
 q/6FQFVU/RxN/fBPbOzV3WkpsWpo+3XWG15VAcNo8aCv8TxsRhW/5afpLQqKn2qagS+7
 XofUbMEeUh4uWsfyERFtYJLFhrllO338m/xr35l99Bpsoo3lW8/BUm3Bgo8DaS9BAmAi
 +kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707234113; x=1707838913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DShOABjLgoNKehmygkQQdNi6GSDp/6k2qhj3W7w/OeQ=;
 b=qjvw4HfxkOKiedqWYba0/Utl4xmk01wVUFHC6DYHhxzoaHki1vjV6pTEExKHOOgQtN
 WT+CdbPNsSFM+G8QLVodVroV6WroRjgD0aVqGgpErlqOhJjQqXYyiUZhKoGFsXBE3iMU
 cSpfoV6wOUH7sWh0i6hx/Ze/YP8R3cwt3FxY+lfT8jr57uKB500G6S+NipDajCJqN0oY
 6px5wL01b0Uoe/Lq7buLRtfbXkGaQmz+PZUFcP1LyXmd16OoIBiHPqU9ZE1sBYMwzBu/
 ZeZGQ1y7OCOZEaAD377lc2FVXov0lqtZHIw9gKYZ1Rp8adsxs+BSDOSEm5JitUmgXMT2
 ftTA==
X-Gm-Message-State: AOJu0Yz3dNlrPVxeKwQTLBCOiS/PnaQNx8h3afFh0TdqEGr3VPbLH5K8
 ksXkuRQz0dYxOVjK8qYxPaqEkLWQrJU6uUTe5ulqxQCnQkYyO7S7dE3L1N4M1fjvAS0VJhjmaWz
 U
X-Google-Smtp-Source: AGHT+IFwTv/+qNAULFkixNPRx3sEXfyjDZJxFKQY2K+VSpgSu0Du7WiKrwRSVadz8vz5Ij66cRKD+A==
X-Received: by 2002:a05:6000:711:b0:33b:4a71:6b69 with SMTP id
 bs17-20020a056000071100b0033b4a716b69mr1137884wrb.49.1707234112725; 
 Tue, 06 Feb 2024 07:41:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d4044000000b0033b3cd4ad89sm2364904wrp.59.2024.02.06.07.41.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 07:41:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/tc58128: Don't emit deprecation warning under qtest
Date: Tue,  6 Feb 2024 15:41:51 +0000
Message-Id: <20240206154151.155620-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Suppress the deprecation warning when we're running under qtest,
to avoid "make check" including warning messages in its output.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/tc58128.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 6944cf58fa4..0984e37417b 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -202,7 +202,9 @@ static sh7750_io_device tc58128 = {
 
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
 {
-    warn_report_once("The TC58128 flash device is deprecated");
+    if (!qtest_enabled()) {
+        warn_report_once("The TC58128 flash device is deprecated");
+    }
     init_dev(&tc58128_devs[0], zone1);
     init_dev(&tc58128_devs[1], zone2);
     return sh7750_register_io_device(s, &tc58128);
-- 
2.34.1


