Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35388C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0e-00030m-Jj; Tue, 25 Mar 2025 18:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0L-0001hd-34
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0G-00074n-TO
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22435603572so114894755ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942651; x=1743547451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUF+4Y4/PqO50T2IhlnvWA6B/DIxYokH9Y5du5vjVAo=;
 b=bgPB6yiFVH5jS42UV3b0FnAH686e/n5E9eZRTD8LuUTyESImhNy703ucuErOfWC35+
 /4Tqr+Y9pdRa+3/1bzp6rDR3GXfxv/7neBGJJvRvrQZA1HKE7qd4qIk9F/KnuVvU4aV2
 A51enqWaoWN2YA/CFVgIosiLnEyt98RgvJ7aaEhw5GC4yvXKk+EoXYB14DmChEcj+Y0B
 NVLE5hU7QcOWxGxEYKmmfAJV7HMxydpu1TYpTrK5xUsEo33tw11mvNaA2J6jDrNRGUUs
 FWkwRVkRiUUY19kEYNFOeisPwwlThPf1VzUxRGtG0K9s3KE8/ct+UAQ3h3P2sAjZvj5z
 2DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942651; x=1743547451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUF+4Y4/PqO50T2IhlnvWA6B/DIxYokH9Y5du5vjVAo=;
 b=dbgaLI2Y4JBj9ILEDlfLoDzlq0GYZsa4mZwO5WYMOrC5hVAOOEvBugwd6nc+dFCIVR
 8bn8vQcZHTPYBpVhBc1N9SlAkyv1QQGUfm6vz5LheESxklUvVLiq3qlvhHdG9kPUAYYb
 tHiwSlwiVHDegmSgrqTg+NV/XhOiQeg6yay3Kv5LSfDuUopA8Pb4nRNNRYCY8zAmu2o7
 M0I+Lxwwm9P5cfmrFjtDCBgH2/tJqJKYcM4BlI1/Ymr4+sJxP29dQujvmkmKliJoYlXj
 g1+Ql2KDRTa6ESSqWV3MIhSl8mSMOzi+D9lbUuTuoYqY2ohD15ZC+fQTkCizdhPBSINb
 Q/OQ==
X-Gm-Message-State: AOJu0YwzTYLdAWIoWxt/zUSmF7XPudVaDmOKtOVa3mvCkL9i3lhxk8ql
 XtyyX3q8rNSJ8AcoqepyI/RlWu73+cVizXa9EV9iDCUKvnQONPap0HjClnkbepHSqLWAf6JEus6
 b
X-Gm-Gg: ASbGncuiNSdGiYYUVZFnbspxZv+vsGtoYXuXNIPkMeCNVcfoo5aA8qskyRHNa6+gcu+
 9b4ebir+vPbYcyu+V6YcchBaq5ouUyWSW0+LAQR3jKAwKP48JrhJgkwE5q4VwD4sjxWPWpf/nPH
 u73IMOzm4VTrozZ7KhqOmtCg/kL9gag8gCMJ+edShOle9Ghvlt6L1xD7EGVa6M+KM6HbA9b73PP
 vHz0VBdO+VCojSZOy5g6f7qRiLtPg3tgf3HJtzQkqB4TIweBejTKGDaiSgllwdVz1BX8xDsqVhf
 I0HU21bzxn6TmjIcunbIbmgMBaX8Ae7EE2/DHvsdDwP7F3KfO+1uE9fLqhYL2F+A+SB4nts4uBr
 D
X-Google-Smtp-Source: AGHT+IF+O3jqSfhskRIrF/LYeAaFY9DjONIdRIEXeBM1gppUB3NNc4GfWGD4AezYeBzPHfXGTz9wcQ==
X-Received: by 2002:a05:6a00:3a1e:b0:736:3954:d78c with SMTP id
 d2e1a72fcca58-739059b3e40mr28359477b3a.6.1742942651220; 
 Tue, 25 Mar 2025 15:44:11 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 09/11] target/avr: Use do_stb in avr_cpu_do_interrupt
Date: Tue, 25 Mar 2025 15:44:01 -0700
Message-ID: <20250325224403.4011975-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 7d6954ec26..f23fa3e8ba 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -88,14 +88,14 @@ void avr_cpu_do_interrupt(CPUState *cs)
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
-        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
+        do_stb(env, env->sp--, ret >> 16, 0);
     } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
     } else {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        do_stb(env, env->sp--, ret, 0);
     }
 
     env->pc_w = base + vector * size;
-- 
2.43.0


