Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F157C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOZ-00045K-Ff; Tue, 22 Apr 2025 15:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLV-00006I-PJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLS-0006ae-FC
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c33ac23edso56322905ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350309; x=1745955109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=EB5sp5P5qPneKKX6qYyw27kSmlHIWZBm3fJLxvihJ0DOzTzY1Uix5ESv1pu4y+UCrY
 AiPw4yApGUrohp14eKrGsDqlGWUA/1B4wEe6PTM7PW5O7o5xb3zKVH6XVGxEZ0sdepkm
 Qrg2qOsXlJuQU9W+qc4KwLKb8OG4IzyRl1xjCWdVQNEdYyINlp286b770PqCGOUtrj3q
 P/V1uLO8oPohxuSQ4k0u38MpzncTvxH13IdT9dArU3FFtErzn97N+LpxjrRbUf4uG+Pp
 v8IP3yzrTfukkfeDG9vY2jOMFFF+ghtp4GQWxV0Olv0jBuKr1YoWu8Bm8vZPLAhS+Cx9
 ZtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350309; x=1745955109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=ZGap/OfvCu7mCobFBe0ljJplZhHyCGxc0bp5N2XzC94Eyu/1rSvnMDM9lxJjLfVO0m
 IGU0jsDzJxLxtDV3qz/9q1h7EqU1Yvr6rrlIR0NLYgtza/jfxOvGxCiaC4MoMC2gF3ob
 8qFjtrA87UNrqGmKEPhRNzFZui4hGmrBdCMb1BUbxl+qitu602UpQhup1aqX4EnhA72n
 /pUq54W4oftlqPcyJ0cXspQy8MsJ+qe7OJyY5P6o1uMMUFJbydALEUoXi+BNlGrWHNe0
 ue5UkJiHKN3Ln9EcLfNrGKbhTyVIcLDU6M7Pj67QFki+ly8NLmEmulCz3vAD5iEd6TbY
 zjjg==
X-Gm-Message-State: AOJu0YxAtYxppkR4y4QvaOgyB1Z8NpJxj/01aIYOYKa3bYwxh2oAAjiq
 UbqMs77Ox5feDl9Rr4mC/RqkSKLJcOU/n61/ouG+jsLUiAwmFgtKqiIbt6xs4hM8npAxLFvCEoV
 h
X-Gm-Gg: ASbGncsAYinsHHC0MN+Hhg3OZgxMJH0mHlwK1ePRKl3zw5r2UD1ojPtqfENPuYA0p7r
 BUKNUJYyoKQFasuO0y/e0olDs/KXftRZNfEedcGrZWXWExm+wDEmkyyaSJwtN6IBVDHosd5jzvt
 QrI0HlVnWUgCGf2Jp04CDHitUo7JJMtKJ0+BYof/bLnVy6GOmFeHxnp7F7oEwP+Wdtw4pj+fSRz
 RutmY4wS1q4mQT3TCM2uMqGbc4wgR/q6uygLMUCEEgOE42FPZvPtpvzJDJDXwhsektnkVG7AFtV
 0tFwHoqAmJb7Ja2XgGEndDXGbIFuVJUWWgdViQB7lHi1T+YHaXCYc41JZqE3zkR1vWLgBZRLkOU
 =
X-Google-Smtp-Source: AGHT+IHa+NTrT5AfGZC611pCgFCnqEOJc9c4lmIXbxY3ARZxxjLpeG47s+B2chQcu/p8b0yRffp2qQ==
X-Received: by 2002:a17:902:d488:b0:223:fbc7:25f4 with SMTP id
 d9443c01a7336-22c53596a3cmr231304775ad.14.1745350308924; 
 Tue, 22 Apr 2025 12:31:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 042/147] gdbstub: Move syscalls.c out of common_ss
Date: Tue, 22 Apr 2025 12:26:31 -0700
Message-ID: <20250422192819.302784-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


