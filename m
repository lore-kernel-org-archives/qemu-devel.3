Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB19C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCN-0003wW-GD; Thu, 30 Jan 2025 13:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCB-0003qk-2t
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC8-0000U5-0w
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so8512805e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261394; x=1738866194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HabG4XQXFtTl/vZ0C82NDKUjYubip/tkWdtm1VvavA=;
 b=A7S4BPxHi0hL7F4tib8FPyP6ETLSvBBdg14iA1nsFaJ9qSEhWH2vmeg/rvTqHQMMn5
 PS8dF+T1iypxancQY2Tn4HcZ0W7G39Qu/RaVuknWj9UK+gfTLpkt4Rva4hmAQRMstJEV
 xP4/L3gykq14K0/IeQYDaTjBKxOdmv48UC4nIDXfAOcjNHXNWMZsEJSXwmgJHi2pd9Qk
 MaEYVRmBhUJTO83W2rkd3eXOtCb/x/7KbN5UsDPmR+ZHQMp0SlXKhmcE0hVmrfcMfEdM
 y9IXWPzz4BjHNE92xQPnPm3KbNmA/h7exDwaLlzBXrYdRAzHlPwrrv6DZ42X0UK2SaK1
 P+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261394; x=1738866194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HabG4XQXFtTl/vZ0C82NDKUjYubip/tkWdtm1VvavA=;
 b=uBP0c2tkTxQR+cdmpOSBQzJNJTSlQNs5rvj/JIbchpsS8EVxhUvemWva9KaXPYVeIU
 ijMyw+W8FGAmyZEhr1COOMU89eFl9wH0CcuYEuTgb9rXhCsSJV4OsxQPKw/7IXGCi61U
 cJZM+iKLpNhRMfrQQNbDRcUTo6YgLFld87fKb3DC3iwXaAPcYdR6rc8mC+XNenz+80+e
 mAdHW5TmxLzxA6nIUV0Jj/qf7u2Jvsfcp5wH0tvO6e9qAuTzXxmqzMZDH9XLk22yb1B7
 CJs1LP9yfb+f39VP2od8MxDqbJwvo76aT9lR5JRsnVDwvC7M7qggnbs7HNN3/BT84I9e
 RmWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoDFZTh3IsFZxsxqLKUpSCPeAxlf7+WaWGjw+/CTgp8/VoMtrvW7MV0Axbc1DrKyGmcxo6Br2j1zNS@nongnu.org
X-Gm-Message-State: AOJu0Yw5cC3BZ4ZqjTR6a7heL1bMjuxf8DxUZT9iGPK3XLL/Lb1SUBzs
 EoasrU1oJLXKieA8vEavw/IbvMn5KnlgDLJYzx584Zu0dFcdgbfroHdhJljWLqY=
X-Gm-Gg: ASbGncuaQyYFp4GynEzrbwsFpv4n2b4VCkTA0yHl0ULin2UUMh2nt+sPaRNnwMAsSeo
 HVOuFlAshS0F4eZVf+3UDcmDDTpx4pZh86poq2YT3adLXJIujb8CSedsyDPfEKlVb1yk9TA87a/
 tXkums7752S3qZgTGf5x4xXUv79EULSWSJdpt5kDg5rIXPU9H8+t7mjBvn/T30mGUXJRya1ycEi
 sejl6t/2B6tb3WkV3NmQBx4rNd6Rx0WJ2KLcd7yrDTc/mm9NgqQ61ZORT0s0kcV08kZ9FJBn3ey
 RK2ExCsALzixyN+2N3dptA==
X-Google-Smtp-Source: AGHT+IGHWLRAr6UvyG5tkm3LNlD+rT9SlJQAJnIc0AxKJlDbszY93/3OUUNruL8dn9B3fuEhIAZdWA==
X-Received: by 2002:a5d:6d86:0:b0:38b:ef22:d8c3 with SMTP id
 ffacd0b85a97d-38c5209395cmr9473926f8f.35.1738261394371; 
 Thu, 30 Jan 2025 10:23:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 03/14] target/arm: Report correct syndrome for UNDEFINED S1E2
 AT ops at EL3
Date: Thu, 30 Jan 2025 18:22:58 +0000
Message-Id: <20250130182309.717346-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The pseudocode for AT S1E2R and AT S1E2W says that they should be
UNDEFINED if executed at EL3 when EL2 is not enabled. We were
incorrectly using CP_ACCESS_TRAP and reporting the wrong exception
syndrome as a result. Use CP_ACCESS_TRAP_UNCATEGORIZED.

Cc: qemu-stable@nongnu.org
Fixes: 2a47df953202e1 ("target-arm: Wire up AArch64 EL2 and EL3 address translation ops")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ddeed0283f..74b556b6766 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3611,7 +3611,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 3 &&
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return at_e012_access(env, ri, isread);
 }
-- 
2.34.1


