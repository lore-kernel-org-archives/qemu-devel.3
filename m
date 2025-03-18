Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D78C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZZ-0003OS-In; Tue, 18 Mar 2025 17:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY3-0001JY-JC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY1-0000nB-If
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fd89d036so123813175ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333548; x=1742938348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=mEGl4lUubWV+UkXvoxvF+isLcKd3fBOr0OOHmlbzcNVhsehjMGX2eoYSLw+ozgiLPA
 WBSFbdV8pMF6OGMWIdH7Qx6RAT1vSbVs3B8E7EoNcgAu2wexoKnBmWtMJXx2ZHI177S9
 7jc5+ZNzckxp+9B+otiJVBGSnblBdLNRT4P+7k+gqTtawUCbsN560Z0Fk88a0J9c0ZnY
 loT4A2ZeMFdKVaJM3cY9h9m/+Wa2bO3bnobejEySJswwgYWM/5Kr6tkkxio76uu7fDva
 Nl9VM8MLs1grxlpC0ZYcx5jnvxAcJ6ZTQMlX7yK1aS4/JvRYgd1shJwosI56GHMwmCDv
 JwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333548; x=1742938348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=P+qkNOOD9K6xLhYOiOYLiFE3TVJMQWWpHyePIevml+U2HXWJHEKlNFe5hxTRo0LlHW
 HV8yBkrClbaeGlxsdkJVcBSf3F8rR8f+D2QCeOa935AnGZsXoH5hQzVVJFnJ9CQTeaMC
 mlNS150ihMGvLGsCVFkGR0qEQZeH+n5nO7GGG4ZMQFZpif/DDz/9Dvz+b/ZQnUERb2EV
 pl7aBCeicHqv4T6x9NHVyrD/dvXJ3Temkhbnq0xPj0lGGOD2reaIqkHsKGj4K4Bwfwtx
 dI22B8u1WNkP7laA6QcprHue2cjqh5NUxAgyPRirwB0fmTFYm5Jkw3Y//Ivm2S7LRypf
 BheA==
X-Gm-Message-State: AOJu0YyVCOKTc1Uzl6hzeWlINYczPqzOt6hm00iyNCg8VILbXXDIppXb
 SJdoZCa3GRj8u5rNEfcFyVvCdGrX0vKi15WJlyo0odwPVftuLvBpOYcpog/yoALQLAIU2PE4May
 /
X-Gm-Gg: ASbGncs/v8GouhyvtLoMybARNQCmi21bOX2tFFP7yotCkcExwMYiFAxa5jjRAnnoVKT
 9JQ6hBRHpxe4FPnih83GW8TE/9x/J2RIUfdnUhyODjI4EFjT5lquk4ET5lPe76LSjRPfQhJ7Lp4
 bFsh4wUnK1nKakI1cuqILnMVKrA0Zm9t7nSgI4pHFBK+9I3qA7rUwcUcGBwUihrj3r8TtAHMcSq
 sR4xL7vpTLt+ePoouqcVkgn1hMyuh23bHUaO/ygmIRKYSxTYYUOoq7HiImO7KYN2ZPnBPLNO6uk
 AteqK1c1PdF6QOAuJPMmbB50S803pyefUH00yMQX5vj+qFr/UQSpqAtaxK49jWp99adB05F0cry
 W
X-Google-Smtp-Source: AGHT+IFcBUWFL2YUfR5SZa8Gvy1HKBNjPn4LzA/nkJRXKcdG0X5o1CtaErCyV3+c+yOMxcthUSK6Og==
X-Received: by 2002:a05:6a20:12d5:b0:1f5:a3e8:64dd with SMTP id
 adf61e73a8af0-1fbe852bd0bmr445597637.0.1742333547926; 
 Tue, 18 Mar 2025 14:32:27 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 24/42] gdbstub: Move syscalls.c out of common_ss
Date: Tue, 18 Mar 2025 14:31:49 -0700
Message-ID: <20250318213209.2579218-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Copy to libuser_ss and libsystem_ss.
This file uses semihosting/semihost.h, which has separate
implementations with and without CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 0e8099ae9c..b25db86767 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -7,15 +7,15 @@
 # We build two versions of gdbstub, one for each mode
 libuser_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'user.c'
 ))
 
 libsystem_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'system.c'
 ))
 
-common_ss.add(files('syscalls.c'))
-
 # The user-target is specialised by the guest
 specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-target.c'))
-- 
2.43.0


