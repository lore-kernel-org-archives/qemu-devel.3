Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C47E77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw6-0001DN-QC; Sun, 15 Dec 2024 14:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw5-0001CQ-9u
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw3-0000xV-Mi
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29e65257182so1627808fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289546; x=1734894346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN3IZrOqRjyWRBAid7p/5COHeeEB3FN3k7Ao6MrzrI0=;
 b=dfiEW8+LbjU7s316B/SlwOS+ONQaohT8xlgbkQ2GXduOTj85PZ9XTWHGEDmeEW9CbH
 1Y+nENAWp3adITA8gz8UNDnwIjvlA0JCZVMdzQETtQ54s0/xRml3dOP7BZLXTtirUYeo
 WnWRLp09d60VdIAIa6NYbuybCQMad+w6kJ1DglX5+M2e5ViQLXZ4vvQ3C9FRLgcZqjDM
 823CwnJT8kfbzzX84SuNJQawJi2ysSv6Ghy+mVmLxHUF47amkjnYj/RiXtyreYoE69Z7
 ckgnDe0nZgm1WTsS7JM0w0J2oto08SgFN4sjzCtOA2yjKx1DqObxpHy9lydsEr8WQ0IH
 mwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289546; x=1734894346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sN3IZrOqRjyWRBAid7p/5COHeeEB3FN3k7Ao6MrzrI0=;
 b=NFcPDThhh251VAvE44qkHakXzIgRKsIRIUXiCZ95U/gh4l/m48N2yrHJKjo24O2gth
 Ckp1z3HUN1TURUK4ikW0QuURav5vAFL9e8vQxtfyPuRAURiHwyMI4BMWYvB/WnLlEN4W
 SrbTnP1J3e26/PEMXR7I+2ibsnlENi17Y0Kh0PPUBt/SNRrL4BiSlg5G0LBAxLXluR+Y
 E0UbWQmKQoh9FTivECYusGqRSxERs5ddjriB0H4l2ZUi3p7OA6MzX/ZQ3y6NM+0nv2U9
 R+sitvWqoJjw3mw5Lw9ZMUD2X6bVdOh6OYIn4/bKYIIdSeuVbPMq7KUYRNc5y2sjPvtC
 OAIA==
X-Gm-Message-State: AOJu0YxBBQ2qEEmQM28OuloSZPUDDu7aV1XHKEQDfrV0wH0A3eUjuVer
 6n0B95F8RICvqYQcHewObyg+nx/A5Zv6nG+Vxr+yCND3tbXzyqkNCpc5cZZ7/YBCwUV994rQADK
 K+etUS3Gt
X-Gm-Gg: ASbGnctmvF5f4E0mYu/FTum3DPJqMHKAMeVHV60kqlVUy1+WDfvCorevJClptOGzuAZ
 FzDoRFQBCzEG1rnP/7Entyj3K9D2wYiQ+ZyRSHEYRhyuwoqw01LFezw50UV0TTuXNGuaMX1FBcl
 mAJuFqxnFzfmjGKkAkUVcPijqStI5ee/pJCW+qCayQxjisU7cAoq1kz0cXUUcVq071YFR0h9v1O
 TRHRv9YZO1ajlddBM5BwtvcLDKIjFXU1qJwTujZuwnqsuefZot2s8PWwbhb3Qfwq3Fvk3eEWNkX
 PzI61eAik0PcXGICfSjVhwaS/JHTnyuK/UO3z3u5xbc=
X-Google-Smtp-Source: AGHT+IE7RnTYRyZWMiZrG1UmQ8uQCVxDaPBLU+Kn6OKbpSbV+Oj6wM1t3cEY2cfbnH3vcDQtmR5Ghw==
X-Received: by 2002:a05:6870:6128:b0:29e:547f:e1ec with SMTP id
 586e51a60fabf-2a3ac8c5f5cmr4722755fac.41.1734289546395; 
 Sun, 15 Dec 2024 11:05:46 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/67] target/i386: Constify all Property
Date: Sun, 15 Dec 2024 13:04:30 -0600
Message-ID: <20241215190533.3222854-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 305f2a41cf..5253399459 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5384,7 +5384,7 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     return v;
 }
 
-static Property max_x86_cpu_properties[] = {
+static const Property max_x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
     DEFINE_PROP_END_OF_LIST()
@@ -8407,7 +8407,7 @@ void x86_update_hflags(CPUX86State *env)
     env->hflags = hflags;
 }
 
-static Property x86_cpu_properties[] = {
+static const Property x86_cpu_properties[] = {
 #ifdef CONFIG_USER_ONLY
     /* apic_id = 0 by default for *-user, see commit 9886e834 */
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
-- 
2.43.0


