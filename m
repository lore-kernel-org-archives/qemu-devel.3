Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZL-0007FE-0u; Sun, 26 May 2024 20:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ3-00073c-5q
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYw-0003Zx-UY
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6fbbd937719so1507268b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771005; x=1717375805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRv9/cJI78XP3U2PIccw7jXbddClyYk+zoUNxwDaOdI=;
 b=I5oMJeDNl4JEUQ3/TjRV5w/WWYnX4SXc6ScOTfK+VrFiMPFmN4YyeovCv/vE5SHjW+
 iShB42JA0hcZ98fFV6k1oYwz9GjMmJGCcwKxo3KEIEDzZAJWY8ZwatRe9gMo5R34WZVC
 AbyLJA+QFvaIkSsPkOtMgV5enXu6OXxpei4prP/aSCwfYfxB4IqMbu1noZiSjqNOfvqW
 Q9DQbxmNC6cmMN7Nyn4zffcL/gjFurFPg0JLYQWxES6CP8EcmX9FRxIq9HUyi15x0BjC
 YnBBN7iZtmEVLz8h4Bb8DGkcKwTFu5kGyBPAkDAtHMBpoL71FaTm0uEdxxy99vWbognZ
 WOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771005; x=1717375805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRv9/cJI78XP3U2PIccw7jXbddClyYk+zoUNxwDaOdI=;
 b=dV8ULfMlTKn6DdTJzPvZ7k39rPZa9P/3vaYC+VL72WOm7D0lGJ+fUkBEZpYMQbPRVV
 QBQLqwFSeEmZgrHjrn7Hx1T1wTumHkayrOrrlweM6Kk7wrp9ZfVamEM+G+pD5KUJvR4V
 ilTHYqg/6+Rya1hexcDLZ1IUfGff5eMRU8RenKEAgBrGlROHo8k6jAkLHOahnqFQUwKi
 i+b09uayuCV6e1CSj8YIELZOpbwVnXeIPURsHKw1nfYQnihqwXS4lqmsyJXAUt1TaqUZ
 wCjdaK2KqZk3RiHl897OBQyQ3A+68uoBOU8TvqnepcINYhhUkqKoRyxjbzZmCYPpDb10
 6V/A==
X-Gm-Message-State: AOJu0YwSlTGx/Sh2T2fCi4l/1hds9SmRMk6PvX8KWgnzzbEktnVoX5Ul
 Js7Ei5+MtzM92uxos+GRGpxzfsI3l9jLk6C8ma+2IjTTcdunvG7kMhvYxC9wYIdSwvRRfCo/cU+
 S
X-Google-Smtp-Source: AGHT+IGMHIalIfhp9vTk6XTMMuLyBiEYA5HOnrW43s319awvR25zRNSeEgQ/65TT2zua/wMs1JLOWQ==
X-Received: by 2002:a05:6a20:9708:b0:1af:5195:d035 with SMTP id
 adf61e73a8af0-1b212df055cmr6633750637.45.1716771005608; 
 Sun, 26 May 2024 17:50:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/28] target/i386: Convert do_fldenv to X86Access
Date: Sun, 26 May 2024 17:49:37 -0700
Message-Id: <20240527005001.642825-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 6237cd8383..5ad6e04639 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2442,20 +2442,15 @@ static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
 #endif
 }
 
-static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_fldenv(X86Access *ac, target_ulong ptr, int data32)
 {
     int i, fpus, fptag;
+    CPUX86State *env = ac->env;
+
+    cpu_set_fpuc(env, access_ldw(ac, ptr));
+    fpus = access_ldw(ac, ptr + (2 << data32));
+    fptag = access_ldw(ac, ptr + (4 << data32));
 
-    if (data32) {
-        cpu_set_fpuc(env, cpu_lduw_data_ra(env, ptr, retaddr));
-        fpus = cpu_lduw_data_ra(env, ptr + 4, retaddr);
-        fptag = cpu_lduw_data_ra(env, ptr + 8, retaddr);
-    } else {
-        cpu_set_fpuc(env, cpu_lduw_data_ra(env, ptr, retaddr));
-        fpus = cpu_lduw_data_ra(env, ptr + 2, retaddr);
-        fptag = cpu_lduw_data_ra(env, ptr + 4, retaddr);
-    }
     cpu_set_fpus(env, fpus);
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag & 3) == 3);
@@ -2465,7 +2460,10 @@ static void do_fldenv(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fldenv(env, ptr, data32, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 14 << data32, MMU_DATA_STORE, GETPC());
+    do_fldenv(&ac, ptr, data32);
 }
 
 static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
@@ -2499,12 +2497,12 @@ static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
 {
     X86Access ac;
     floatx80 tmp;
-    int i;
+    int i, envsize = 14 << data32;
 
-    do_fldenv(env, ptr, data32, retaddr);
-    ptr += (target_ulong)14 << data32;
+    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_LOAD, retaddr);
 
-    access_prepare(&ac, env, ptr, 80, MMU_DATA_LOAD, retaddr);
+    do_fldenv(&ac, ptr, data32);
+    ptr += envsize;
 
     for (i = 0; i < 8; i++) {
         tmp = do_fldt(&ac, ptr);
-- 
2.34.1


