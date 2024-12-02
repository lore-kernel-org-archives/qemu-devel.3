Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D9AD78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ye-0001Ja-Ce; Mon, 02 Dec 2024 08:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002yJ-A0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003c4-NC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1783126f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145298; x=1733750098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt3T9iHPBG+FHbTn0HSdShbMUsPPH/sHv7Ur12KBxlg=;
 b=L8IwldFaHBni8J3drazU6wTZ3Hk40g4rU1C8KSS8P47zDdDNFUqhG9Nxv2ETN8GfKJ
 75t5QZDGTub2L4sjkHF73AvXhWJyYPaD8taGBU50wlbOmbw9lGgwdeKI3bM/iOFEubje
 tqVmbWe+L9B5NRDr1u1pjfJ92YLGEFJjtzCFmHd3OZqUo3ibcpKPNSGyqIi3euNiGWRu
 nSAIU5ILoyslXL/AB1K4JkAxDE1TMV7vH6Kt9m/JX1D3ptbdmqASutDWTF7nS+3vzIqt
 LKd/rSgO+fcLy6b1soiDc3T4KxfucfQYfNRwKX08V13CDS8mS/e0obJkRL+HQ0wTZ4Lw
 ktsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145298; x=1733750098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nt3T9iHPBG+FHbTn0HSdShbMUsPPH/sHv7Ur12KBxlg=;
 b=CdWl/zqoMPobEomtWC4al45F1kGuoybmRpwrCy+k1+uZmxMN2TuyQo/JQ6libDd7Uq
 5OzdtLrtBvAaDeXC5zGHZu71AY3ySRHcny4OOksCb4CdKc0hJcnHhKz4uquSoVZ2Y/X4
 E4n7YTTn/zjRHID8DR3DizbYkdQ2SDqUqXh/0r/7a31Zh6hR6gCaRFzG8gZOWZY+6GDX
 SZE0n/XQmGMYXW423tyxrFd3/uucT9FA8uvuZkFdQrsghi/4GsmcWzBYhoGTRov0loze
 yUrIPsd/Fa6EfKkePDf5nYo9Kd6SRobIanzKHs6mmWtyQQQ3I0Hn+sCujY1diy8VT8QF
 B9aQ==
X-Gm-Message-State: AOJu0YxjkCRLaLDj9V4HN0rKB3t6KHU/iRX/Gu0MLFjsoF8AZ+k17HZL
 ma0iaNor+r0O+/afr2KWZ2NjMg6RHlsmQ4HTWrCG1ydTlbbYWVhPdx9ULZnhLp/K7LrxAfDnZJS
 d
X-Gm-Gg: ASbGncvDroppP/LfEtmQBwppHEoUB66piDJNx0R5M3pb4qeM6mGro0PhPteTQfT1IFJ
 F+7yDrGz48Iyi0yNwCzziGvfTIDXihOsTwGN5co81yIQ/SDmjYkUBikAL1nUTPneOYKqaiCmHX/
 X84HAfoBQc3WFm8kZCQZ43B1yW0ZMofIN1j+/4O7bJTXNLfwwzPHtiH8zjuj2DZhfNK9jFaAmhv
 iXca9REZ5ri4OckmuI5c5SaRPnC4mClO+ZsvlGOIABgbKM1p07xOYw=
X-Google-Smtp-Source: AGHT+IE7hA5L/kdfOrXZwx6rchjyvu0rnQhZYrqgT7fhKReK3S5N/rvDY7kE0Sn6w9k2hiQ4e9zeaA==
X-Received: by 2002:a5d:64a3:0:b0:385:f9db:3c4b with SMTP id
 ffacd0b85a97d-385f9db4370mr798479f8f.10.1733145298343; 
 Mon, 02 Dec 2024 05:14:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 52/54] target/riscv: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:45 +0000
Message-Id: <20241202131347.498124-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set the default NaN pattern explicitly for riscv.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b52..80b09952e78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
+    /* Default NaN value: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


