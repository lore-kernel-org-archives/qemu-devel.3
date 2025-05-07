Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51DC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPw-0000Db-3M; Wed, 07 May 2025 19:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPf-00089r-9w
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:55 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPd-0002Sg-Bk
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:54 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b061a06f127so198147a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661371; x=1747266171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeLa55SzX7Awe9dK4zRdJwFSzsCeJiaBfVkd4m0OHRI=;
 b=zCB58c4yjkpCGf7ABqodyASrLgzd0yE6EBbOZzZJhfZoQVnyyUxl9wIz1yDr1j/q+9
 0Q7zFCyQaQK089KEKLm03SIx+oSWMihQAqGp3FwkC+mRss9V7Z8/s8zXWRHapVqxtao0
 dU73CHAYcwGLHXVQynpRE5/mhwpmE2PMGzgEsZuzcJBxQrgRKUXP+l+fXkKduKpl5QF6
 dPe3sSvm1LhttL6iMymEukS2zR4s9iYlJ9ZUCbnloZaPgB5wo/8ZRhBijub6xZXVuIgk
 mak8pLYE9gfLrBCo7HMN7hViyrvYKd5zzf6WmpqIXJM9qe/roWRoEH3Uv+/vdyDZC9Rm
 nnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661371; x=1747266171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeLa55SzX7Awe9dK4zRdJwFSzsCeJiaBfVkd4m0OHRI=;
 b=k6WMlXiGpJVJkgjQwQSeIt145E380ungsltc8k6XT/samFtOWa9mIyUDmwy7RIWZ0b
 iA1cZdrXeu3Km/1BBtJoPU85HJ5niGFtquyllenz1RQVtmPIqajV6iQTQyO+Ss34JeN2
 qlyoi6z8lMKVkj5XWmCRrIFJkPK/IDd7FEzsZjXPCjr5rORz5y9TyATZhO15z7kSpCjL
 XB39a+8T3v8X+S7g6+aFFAaJmUYrSibKCupG0yXYYnADp1xIQ+yjzQ3AnyAX3k6Dmt5D
 fQDrQpRcWLNphq76Xz1seC1HxNJzuRTIWflP38ZRQWpZaJ4WJzjXFTDFlD5by601CGN6
 PmDw==
X-Gm-Message-State: AOJu0YyUucxxumLFMsJ+WnvC6JLRb2VDC011mIdGqQL+xpwkdOMdMW63
 fMeRXLWZyFqDhxloEEss2PIJ53Q5G2lvaDORF4bmE+v7bGt39cPyT5xRmiPV7KEBSP9l4aCqVM9
 PuOYl5Q==
X-Gm-Gg: ASbGncu1yBpp9eZpMKKL9QMlqwRKiCGgYWR2ZG7YaIRe560ePajeleKsBxWtDeevzd9
 wado9m+o32oX3KmH+oVU4+Xgo+P+Q0KitGgtdQ4cvalkhJgi2TH2YbmXp7nRGT7OldXGWv0j/Q1
 E1gTs3zMgxfVBABlEgzqJAR48ISn1FHfvcV9bbEKdMOAYUNRFcBgFBPBAFlqBPGpLzAdpwvByZX
 t3Hy0x2z1QSu3STT3doq0zcssCzcQUXncT90Oa9x9M9PYYQL1PPQcbxU4DdkfxuxAkP0/GZzNWM
 1QH7NO4K7iaRgCDnaBj0Ol3qNV4w4Z23YWPULWic
X-Google-Smtp-Source: AGHT+IEM99O2b2UnNUSxhoZQhjrZxHOh6vHDqf4IdMXmXOb8iZbwhEjpUUo/CTJ0GCRvuLSYmd0K2Q==
X-Received: by 2002:a17:90b:3dcd:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30b3a6e7b5amr1778610a91.33.1746661371246; 
 Wed, 07 May 2025 16:42:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 09/49] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Wed,  7 May 2025 16:42:00 -0700
Message-ID: <20250507234241.957746-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Call is guarded by is_a64(env), so it's safe to expose without needing
to assert anything.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b0eb02c88ba..b97746faa87 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1182,8 +1182,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1341,15 +1339,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


