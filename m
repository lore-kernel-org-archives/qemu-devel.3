Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEFDD78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6YZ-0000tQ-Tf; Mon, 02 Dec 2024 08:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gv-0002lE-Kn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003My-Ho
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1912366f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145277; x=1733750077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFtiFfBBznBZexAeUlFNfBbsHlolyVwbUxMya82sU1M=;
 b=atwcCUNsmOBDsC+M+FRdwBqZuSxxilKsxhyx5LOt69Q7s8YaHAoFxWhy/Bsr1nmR0b
 BrKqXH5OfJZ1cLtkBgomZ8FCTi5Eu9C/Wwx3qC/4vqtD/yyDKnzP7juQhqG3YxoYNSZM
 CeBXUeesd89xBO43byd1Gk2Wico5Y8WqX9AIMxuXeIg9J4YexPHZyXTZsHWdiefizjr6
 /VExT/T4E1/tXt7p/wz9+qvmkHWWm305+pJ523HjHxI3Mlg+0IJiEcgVPDwqcUYLL4qz
 yoQQEb+ZDGozAHDnlMsrW+OJg8CZdWqvsuePIm2Zz0KPI31n7zEZOdPKwf2GKnmU3bM1
 8RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145277; x=1733750077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFtiFfBBznBZexAeUlFNfBbsHlolyVwbUxMya82sU1M=;
 b=CfrnItUHRMUgjOTadW6KLrefFL+7wxD9DnrRhv4SlwOU7uVA8DzcT8cMbJDvhifjgp
 2fKQjxTZiTl45d80fZguai3KL/oX39xXoLzF9PY13daL4mJvXri6eIeSmP/8uEAK375O
 9ovuCVTnsdDHcajWQjTfzU/QnHqNsY9WkNXOnhvZDaTsLdYFNQN/89An9aIorN1CybHK
 UyRvr0bELTjs3jgBJ1lMTtmjua19jDIo0y5hLqde9ebqlo0pzQn8u+Z1t6jZXbbEQncV
 MAGpLtIuslzITZ/5LkTgcyJQoH4Wty7WdOTZNfWJFBuaf+a9UXzwz6+8wUjw6LsSBme0
 wTjA==
X-Gm-Message-State: AOJu0YwT4tm5wJloGQ9HTZaV3MaUD3ChbCc9VuzDetVkdCh0Lxoq5FSy
 36dsVMygbDKeEVBVGPC/OAhmUQbXbG5w2JoK93m1IJPNJlA/lM1MA0LD9UEC2x42JDIMvi4bL86
 7
X-Gm-Gg: ASbGncvF7Ervm/lKte+33xDeN2KmpM0+A+/vKl/fmz9YTNN2b40YI/iHlV/YG8vNCFG
 tW30wcuiyaGfq48Idb/QPzgfYgrIlNHcTVFbB21o9u0Z0N5iVpNrHpzFH+FfUH4FN8N9YudpZM1
 40LdJIeJL+YOpgpzAyS6ji1R8q2J1N0K2WuAJEn/Q/JpX//kveD9PEZOidhTOUDGuTPt2642jT5
 hUoaPYgiqnzyviTwl0imlp0LcFdjuYL1jylPB1QIGCfaBCXWm0A2RY=
X-Google-Smtp-Source: AGHT+IGjX11e3JO3ZTyjG7BP/tYm806Bq6OhPURR2FI+K91cwS7FWrHu5iiVUqs5CI0AS29PsM5q0A==
X-Received: by 2002:a5d:64ed:0:b0:382:444f:4eb0 with SMTP id
 ffacd0b85a97d-385cbd7c36fmr16352829f8f.13.1733145276812; 
 Mon, 02 Dec 2024 05:14:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:36 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 30/54] target/m68k: In frem helper,
 initialize local float_status from env->fp_status
Date: Mon,  2 Dec 2024 13:13:23 +0000
Message-Id: <20241202131347.498124-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In the frem helper, we have a local float_status because we want to
execute the floatx80_div() with a custom rounding mode.  Instead of
zero-initializing the local float_status and then having to set it up
with the m68k standard behaviour (including the NaN propagation rule
and copying the rounding precision from env->fp_status), initialize
it as a complete copy of env->fp_status. This will avoid our having
to add new code in this function for every new config knob we add
to fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index a605162b71f..e3f4a188501 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -615,15 +615,13 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
     fp_rem = floatx80_rem(val1->d, val0->d, &env->fp_status);
     if (!floatx80_is_any_nan(fp_rem)) {
-        float_status fp_status = { };
+        /* Use local temporary fp_status to set different rounding mode */
+        float_status fp_status = env->fp_status;
         uint32_t quotient;
         int sign;
 
         /* Calculate quotient directly using round to nearest mode */
-        set_float_2nan_prop_rule(float_2nan_prop_ab, &fp_status);
         set_float_rounding_mode(float_round_nearest_even, &fp_status);
-        set_floatx80_rounding_precision(
-            get_floatx80_rounding_precision(&env->fp_status), &fp_status);
         fp_quot.d = floatx80_div(val1->d, val0->d, &fp_status);
 
         sign = extractFloatx80Sign(fp_quot.d);
-- 
2.34.1


