Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD523C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Iv-0006iV-FF; Thu, 20 Feb 2025 11:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Is-0006hH-Do
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iq-0008AV-QS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso7345725e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068490; x=1740673290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vf4YUndZMxvxoHRU6RrVF40h30geuvboK5PZuXO0+iQ=;
 b=sz8J3kAo1EpGIlqhzjAQvAH9eXzk7PbcMQe42gH5Rf7KD6MFg4dVrannXhHkCO9cSk
 kqB8iM5l29mWDr72osKNhyAX7/JUQk6l5vdpaAYAhSQreX17TQ5ooFoyw+Ydi0jlKenV
 LXAtwyb1i5u5Pni842wu1mdSH7xV1QZ3P0IZz8K//aZVlHuK/cCsDSL8iorhATbh0zpd
 RRNlatKOXqTUw8HJdui2GvIeDEYc15x0MrZIu53+75IyHFmSD9La+KJqh+O3SlhEnPo1
 bLcfds1QzAY9v6UzHC4syGHivrWZBtPsFkOXGNqP0y45cfPAGw1xhO20UvX9cJI2XFQi
 nnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068490; x=1740673290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vf4YUndZMxvxoHRU6RrVF40h30geuvboK5PZuXO0+iQ=;
 b=Dc6j4xo4fBdhgSij53fxDmvJRI6UE7Nn3gWI3wAU2oCD49xVevpWlNSH+Mz3KqMZet
 juWJ07FYaKHdMT/o4EduQt7pKvDrCQNOq1Y8lqBSKPgqATK/Os79IvjXwc1kTRUYqnoI
 DaDShQYG931MsDiaHlEXGIVKFlXD4rFYMBPhO68CRl3g87q372HbzsJpoENuSQYRBVj5
 WNj9jp8DEHM9htTCtZwGDnz4Z3nh2bmyyyJnjqOyGor1GzRzpIjoZLviK+GSZhQauChe
 gaeNALBygENovVirIkZqEq3VYyhA/qyxaDTLgv1wpMHjpTuzCn51c003fIITq+dNAnaP
 0jlA==
X-Gm-Message-State: AOJu0Yzf69Gt9HV/SIl20o6MO7VgcOZWVZpdFCTdaJk3+8W5S07TdPe2
 y7/kmOgeW2f38fr2krsKv97YNwdO6SIt6h3YxGzKBbxchV545Zuy+6WlhvGoUQGAh9TcrFUGbnh
 z
X-Gm-Gg: ASbGncunV/8I23zhEBquNsVbN937+IQcbK8HSICprRO6nBHgumegsj4xQff4AHyi/yj
 l414Qj1VACuDmaRJv5J76D6Qq0XwKBrRzfwWB1bImsyilyI5/u8tZqmb2WIte4uW3Rkj5kA+dmJ
 Q55W2EOlBA3LR1I0UB7Xw7CwrBG/5v7q3EJx20DtzW8nOUd2CEk8nQoCngJPLlxG2FQVjQBlbj4
 Um+K07XHJ0NAlpajf+GRbOXWCxCYFlMh7QpUctAn0cc6TqhycP2FtOgZPS3JOvEECtEGk30lAeT
 bpMXpUe927qYLMYaWBPx2w==
X-Google-Smtp-Source: AGHT+IGkcxEAY7HJB8u85aRIs54yyhJ+s9KrmAYqMYXdnkzJSiBa4/tb+a3Xx4JqIPZF6VPm+05M+g==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c425 with SMTP id
 5b1f17b1804b1-4399828c633mr103612865e9.7.1740068490511; 
 Thu, 20 Feb 2025 08:21:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] target/arm: Report correct syndrome for UNDEFINED LOR
 sysregs when NS=0
Date: Thu, 20 Feb 2025 16:20:45 +0000
Message-ID: <20250220162123.626941-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The pseudocode for the accessors for the LOR sysregs says they
are UNDEFINED if SCR_EL3.NS is 0. We were reporting the wrong
syndrome value here; use CP_ACCESS_TRAP_UNCATEGORIZED.

Cc: qemu-stable@nongnu.org
Fixes: 2d7137c10faf ("target/arm: Implement the ARMv8.1-LOR extension")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f4af2d2de54..4a0db087dd0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6750,8 +6750,8 @@ static CPAccessResult access_lor_other(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
     if (arm_is_secure_below_el3(env)) {
-        /* Access denied in secure mode.  */
-        return CP_ACCESS_TRAP;
+        /* UNDEF if SCR_EL3.NS == 0 */
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return access_lor_ns(env, ri, isread);
 }
-- 
2.43.0


