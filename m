Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B60C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b8-0001jR-Ky; Mon, 17 Feb 2025 07:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ae-0001cb-KF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0aa-0002GH-M8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43971025798so10034155e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796665; x=1740401465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6pbiMjKPNJA8EY4vkWYZrebB7w+9UsObWGKtAK8Oy4=;
 b=m7ZtQflq7BQOsUxROjKdyeXwZaeP2a9dxZmK8qXnWXd88zZPHhrvGSlH9KuxdJKw+x
 EYfgacfo6ZBphJovHZkQNwCNtyqYUM73uVclC4/ilw+YH2IpsV095NJ+muTVMCZtVYnD
 y+pQVCsY0vLc3TFgywbdb7x1XMJCTXIMXNblXQHkA/wgB+llXSFMMRMyb1bZ/NChBDjD
 X6lvZuXXApw+6fhf/LY6VXnmPcWnZOQmgC5pUPrbwCo9voxfifFGB91T50ba66qp9ja9
 uL5B9ts01mE/Lm94+hC4iLWO5DZOkHja8GxTW6C5b1qQSVa8DaYgl2A9L3h8/D+6Rq3h
 0wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796665; x=1740401465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6pbiMjKPNJA8EY4vkWYZrebB7w+9UsObWGKtAK8Oy4=;
 b=Py35JLVsOwea1FZbGN8cFZ2ANld8RVvPeJy9uspx4nlD4ElX8lglo9spPMEuVAiaAe
 TxvnxrLAdXNYxMMzlewZ7dd0bLJ1OFOTwmB6tbrtDI9HnacoUivsHbOADzMmZluDA+zz
 U7d4kHDNg8U/eoKcjK+voAd9WYlYJRUzgPo15dtH3GLyeOiNwO79YiJ2QNZfBJWhW9Kt
 m7UmXyOzLVT/aGf6AiXwHNrYcekd/1upae75t0S3WROJIBQFySk/3EKggT3BC1zQSv2P
 0LUMvc9ustrnVRCefKHE4ZldOrIcCOZDWCkqzvP43KqE8eHB9loYG2OyjKx0q/WG7LNl
 52xQ==
X-Gm-Message-State: AOJu0YxNQmJmXC8s+yMkGXumm05S+6EOtlzxm5sDB2NpSMb2As5a4Mjd
 X2evbmNjtth94PQzYYLfQ0RUzudDgKCJ+DX6qArEbnwzdo9riL8oA+/32TshpB6Ix4u0VxvXDZA
 g
X-Gm-Gg: ASbGncuLqLzrhbUc9KtlRZRUGm9LQ/iviYrMEkJRadmA4FZaLfuxziSc6Q+vyyQzVyc
 ITfuQCBGI2vzUGrHpFRnJFrUT4J1uo0G6pJWsfy+mnUi+qoEJWd1KBbfAu7A7UhuJqIWa0L5Sk2
 4b19+S86iDZNMD//qH94f0p7gGHFZBO0ShZn00NKLOzIQ4BYa1YEYwS/fW+VAmrtyWrdOomoqXu
 ggHl9XLBKqIc06ZEJvCVrISwKeFaruTOc/MtaeWdI8Dsb2kijKq5eBk0SdP+wrvoxCuyuagVPDY
 iO633/GKHVCVMKU+0wJJfg==
X-Google-Smtp-Source: AGHT+IH2L2SuPhxfMIs7Wox6D4haTaYCW3+CL6ncu5iRZgoIorEvoqkI69CXNLDagmAMvvntxvcxvg==
X-Received: by 2002:a05:600c:3ba5:b0:439:3e90:c535 with SMTP id
 5b1f17b1804b1-4396e5bbc42mr100989695e9.0.1739796664819; 
 Mon, 17 Feb 2025 04:51:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 07/10] fpu: Always decide no_signaling_nans() at runtime
Date: Mon, 17 Feb 2025 12:50:52 +0000
Message-ID: <20250217125055.160887-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Currently we have a compile-time shortcut where we
return false from no_signaling_nans() on everything except
Xtensa, because we know that's the only target that
might ever set status->no_signaling_nans.

Remove the ifdef, so we always look at the status flag;
this has no behavioural change, but will be necessary
if we want to build softfloat once for all targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-specialize.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8327f727861..a2c6afad5da 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -85,11 +85,7 @@ this code that are retained.
  */
 static inline bool no_signaling_nans(float_status *status)
 {
-#if defined(TARGET_XTENSA)
     return status->no_signaling_nans;
-#else
-    return false;
-#endif
 }
 
 /* Define how the architecture discriminates signaling NaNs.
-- 
2.43.0


