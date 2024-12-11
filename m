Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C5AE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSc-00016t-2f; Wed, 11 Dec 2024 11:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSX-00014r-Hj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSW-0007pn-01
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso5563285e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934067; x=1734538867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ugtcp/+++sWtSJ1G0yYLp/YnlSvG52c5wPGIqMMfBnk=;
 b=EI5pQMr1/4+fc9qL2TtV9PbfCHi2k1xWzOsv0CW0zdx7QbBeugroDHhLvXKAjSlsiM
 9AR4vtiVm1pslW15XLpjAxdKpNAU+tYGaj9sZmn142n0iHzq0qHJ4y4nhbU3DhpG6+To
 CTXbJQp/TXQ5i9kLuxNFRNDnUCBqYo7X81T88zWKK890u07EWaUiIIP78OlODEtQCGt4
 pdp6yVGCAkd+zCE220NhdVkTcde9tsSecx31qoOv56wPFC20vNrBaxA53H3vC+jrZ2Fa
 zw2xNMSmpVJXardY07qkN40Ub3SBrvTRbA69HKQXsl9WumVzMd231Vr8XtMZEPVcU/B8
 CwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934067; x=1734538867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugtcp/+++sWtSJ1G0yYLp/YnlSvG52c5wPGIqMMfBnk=;
 b=r8504lJycQL/uyhpflgJWDsfS33yzQqnDVEq9olv0rziii+RwJY6VLOpueG0hgYkDm
 UusQd2Y+U7rt3KJuSFrbWCyD13+L0egwy7iIpeQpH3mWI9TmKsGeTjHgOOsU4gED/A3Z
 Ey4rXJ/QJlOp5pMYz2Vf4pwEFYUNyQJawAjkW3dRVWfAuh1j23U1EF9Y9I2k7H8sg23O
 fC/wTDnlwN/KcP3FsWMolR4orHAPZWFJndELS4C/gyXd09jbphUnxlUPX/AtxkHdXllb
 o9rbsfJlQe05K7l+5CVaNcq/EZeHJhudchsixLX23HbAQGCcusGyfSU9Fskdetvt614Y
 gpOA==
X-Gm-Message-State: AOJu0YwYoRmzO7e0ilPnMoeHvKkWUfO8XB7Ff52ZHJGewEIgYvVbgAYb
 OsMqRfQwceT2a89AOTAsKVboil5KKBuvviAHwqZroU3enmcsTf0l2HDcpzEJv2g86Ngiqk2wvia
 6
X-Gm-Gg: ASbGncuDfgKyC+MyZ6qO+agGEbkvHtIXwSeFsurIdzuBBeOPG6ADnrSw8iC+eb3Hup/
 6qSPEy2b81wF604llfFeffpfR1OFWW7NEdplh9Gn91aaBZlYEXyrx5TBgurb5oXG7g8MF9AOBxx
 9bRcAY9g4BtCCJFbWgecvbUnYBfsXySY+eUApMJUGHjzTbkFnLEcxvRcac0PgYXr5cyPtGNYeJS
 Sh6+ruX4brCU3Ryq/Jlow9+J8GY5aXH7rcsBV0ojeqcryhlF1A8hjPnaqF3
X-Google-Smtp-Source: AGHT+IHMmrNjBQKmiT5rg7Y2Wbnn06mxx+QvUxc4VYq53zXyRFnP5NZ/S/65803KHQGUC7v3KzuuLg==
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-4361c387b63mr28773025e9.18.1733934066682; 
 Wed, 11 Dec 2024 08:21:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/72] target/sh4: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:44 +0000
Message-Id: <20241211162004.2795499-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly for sh4. Note that sh4
is one of the only three targets (the others being HPPA and
sometimes MIPS) that has snan_bit_is_one set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-47-peter.maydell@linaro.org
---
 target/sh4/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcfd..d5008859b8e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -127,6 +127,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
+    /* sign bit clear, set all frac bits other than msb */
+    set_float_default_nan_pattern(0b00111111, &env->fp_status);
 }
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.34.1


