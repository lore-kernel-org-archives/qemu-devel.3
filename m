Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31988C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauM-0003ep-9n; Thu, 28 Aug 2025 07:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauG-0003XP-5W
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauE-0005s8-74
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7d497abaso1453885e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380900; x=1756985700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xf/g1rBN/QzXId5vJeGSeSFs029NiEx5BSVc/H9VkHA=;
 b=KV2WuOlK1x4bUYrzyxqTgG9ZaZrqO/UCMqyCJxJhoP7F0jfL/Q8VAQqkVb6Xa/hxas
 Uers9joO0VZpOhctIXwDxxUHlMvxbLPLYLrV25f1VXzfUpNTIUACfcBMCjjko3Zru1LE
 4ioKfqwbxt00lHB8xDCPUCwBZIsw1X/qr33qjOvfi1ivgsiCS5a8N2b1h4E9lKq4nXR1
 +/gWnPLkaqGPSgeGDyBYwwWfYNddCsozmFZ1T80Joq9jzk7p19tnUsdl5jDjkax3zCZS
 wYGfOafkMnbO96+8NdXlIP7be7k0JP6kboOheWUgsPslh9T7lx9+aXMc9Mj4AmxayGms
 ZXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380900; x=1756985700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xf/g1rBN/QzXId5vJeGSeSFs029NiEx5BSVc/H9VkHA=;
 b=YP/vk0S5cMDDe7F3RQia8GGor6hObPG2nFp77iSHWsvChqK959xvvowha1aD/JeCwW
 2MezVDYTq/pAQKzVQBpdr2gCwMF2mr/GbOOAXDmWUpIdMGKXy9UwXuSuCGe+5m+ieIZM
 OA5hUYyTn3yROxzZIqn3tenDcHQC4oao/28UDWd3IJGhzqiKcwxGc5V7BhCpBz7hU+EV
 JpBLtpIXqaxxgWtMS8tA4OypliqcoTaUWCYNSt2boqWmMt2jC+4TeZnITGQjYpkofsmZ
 PbV2snVVVU3+dzZeJo9WqUbTUeNhWdEGFkV3UiVd6FM4zKG/C1drOpLvxMb+mWrP+pMS
 5iFQ==
X-Gm-Message-State: AOJu0YzoEPthYmQWW5n+4/7t9gVPN4cyN0mCFoVuaM1g844cv/3JyvZA
 bE3iGzGruBVb8jDqDO0XT3A+68uoLOEj8EaIZjhSPHzf3RCyQR5bnniy5atq/wdEpFkKKgJK5wT
 sUtmR
X-Gm-Gg: ASbGncu6xpl6slg5VJKaH+cwFB5C1BK83zFr1sw6k8SxBLnH575wJUi0VAuOnkAhTOY
 CK4mAT4nhchqWwGyR+hroXnF8FUCOxHFLD2irbLiuXVPigndZ+Cz8JGUlvkfvhKRfWIHlVBGlL3
 CMtc4vp1KviNZmOiyxUzbyA9WSdbVfeupuYOHENoa9jZrfxzcWIKfsmNpt+sM2qKDTlsK2/18cS
 b1OjRmTpLrfMczjFjv9U44y+vV/W5dBMxYwLm7nPAgs7hf8GAcQ4IzWlhY3AbyFgrDy141UHFzS
 Qudq6Dd384uDkHn9exK4p52MZx5Zw4+oI98FW768QQ0MpqdV+bBt9rC05U7OCnWLl4o1ev65b62
 LG1pO7iLtvwh6CufPMp0kvCkeS+wMccAgG5u/f7Q=
X-Google-Smtp-Source: AGHT+IEg4fTcjln/+5puH6w3F2/Rt0XGxKp9UAwam34hO0g+e7MxHfxh1/plgF/1xed9MM2oUex8ww==
X-Received: by 2002:a05:600c:1d23:b0:45a:236a:23ba with SMTP id
 5b1f17b1804b1-45b648f7ddcmr92092915e9.22.1756380900129; 
 Thu, 28 Aug 2025 04:35:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] qemu/atomic: Finish renaming atomic128-cas.h headers
Date: Thu, 28 Aug 2025 12:34:22 +0100
Message-ID: <20250828113430.3214314-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The aarch64 header was not renamed with the others, meaning it
was skipped in favor of the generic version.

Cc: qemu-stable@nongnu.org
Fixes: 15606965400b ("qemu/atomic: Rename atomic128-cas.h headers using .h.inc suffix")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .../include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename host/include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h.inc
similarity index 100%
rename from host/include/aarch64/host/atomic128-cas.h
rename to host/include/aarch64/host/atomic128-cas.h.inc
-- 
2.43.0


