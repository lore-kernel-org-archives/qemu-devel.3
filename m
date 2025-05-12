Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD30C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXE-0002w4-L5; Mon, 12 May 2025 14:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWm-0002QI-Nf
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWj-0008Sq-3o
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b1fcb97d209so5162575a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073119; x=1747677919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeLa55SzX7Awe9dK4zRdJwFSzsCeJiaBfVkd4m0OHRI=;
 b=ynTurs3z/e2dIbYbS2KVOAR8GuwJHYNHWp0znEdi4+ktU7uQzkQ6SH4FtkUGWzMr10
 Xl1uww3yMrItvl9+wXSD9vbG44CipWTkzgjBwAhF3sDt/RmQnjVIyFSqrT6ZBfWi3BG8
 LHrBVsnVFP8uVES8TwHdpA7uTCj4erYEhiOMZ/U3vOC0rsakzKhnu95JWPuj9u8GtBJ2
 UmrHxztIvma3xMzwX34lxihUJkXdd/NXSHvwphKqCrqYvhuiirIIRmM9EeDjmTX/KVuP
 kwTScP+POO0Zz5Z2jQdg0J4TxEuGhdKi3E3KnILWG5f+uzz2xmPcuOdgmhgHXvUJ5hw7
 4Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073119; x=1747677919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeLa55SzX7Awe9dK4zRdJwFSzsCeJiaBfVkd4m0OHRI=;
 b=Bq+p1EEVSCevAUWxICLkmoQWMJESt/HV1c2UXO1mrTYmqdCt2Lmn/mh3McYm14YWOc
 Xsm/nVfUwQ6lH5pun4odM6pU7br5Kk4b/4Q/7iyL9Yspmp9xUNVCJDH38u0HWuw5vMqU
 MTV6TTobQSAtQsIjRqBhtk1zsQJjwHSe6zbD4q9HmVVSS1h3AyMgesOg1Wm0YZxi+CkJ
 DmLM94ruMkGhB43gG935UwSYazvqTH/BxluUWYZfgGuFtI24iVlBqK+8FlrX+AvmRbD6
 gaOza1sQ22KteazkhFSyvqpm/R09LtzRfwqlsFCgVbuWEygaujYYbmn4JWeK3qiHQRsT
 KU4g==
X-Gm-Message-State: AOJu0YxNXiHlkXQ+hIAruGlKHTj44/2JkJ2sTGcJuFb3Sv9BqQkbxpRZ
 U9Ul+JP9MaFccCEGJTFuxx7RWs/ldM59CeMw3raCJctJLRBZdn5WVUk+9m4iS+8nncQtSagE3qf
 F
X-Gm-Gg: ASbGncuczfuPA4DJyKB1E0lN5EidhhRTDPCQ7dxyK4b3wC2aRxgwdacGL76zKE9M3eO
 iu7dUTNE2jvXbwSeUgKkIiAR3/E81555zrZQv9nbEv2eg7KrvBgjDg5uxnbv6Ms/yAXmCpfY9At
 OOqChuCId5SyuCI070k4BXB6TKOgobJl+CAWnzOKt84lEJoueZbaSQtbW/t8WVk3W9tu0jpDoBV
 +5CU4HtmwYKPAbks3LPHr3VQhIQsN/8llCX89pQuZKk6FMp+CYKIT+LA4cJ0yMAJyKssgqIKpRv
 D2SL/KrT8nncGq5WzMfrLI8I4+C3JdcFbopOrKKhesBKoxujjQI=
X-Google-Smtp-Source: AGHT+IF87iJk/TA43x3Co0c2zSLHfscJBqgiiHN6Ikhb88yHzL0ezxJVCrI5abT+ctobEAvuJ/KsMg==
X-Received: by 2002:a17:902:d4d0:b0:221:1356:10c5 with SMTP id
 d9443c01a7336-2317caf3186mr6221335ad.9.1747073119092; 
 Mon, 12 May 2025 11:05:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 08/48] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Mon, 12 May 2025 11:04:22 -0700
Message-ID: <20250512180502.2395029-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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


