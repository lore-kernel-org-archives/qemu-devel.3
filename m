Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928AAE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1P-0002T2-O4; Fri, 13 Dec 2024 14:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1N-0002Sf-VK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:17 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1H-0006Tf-5q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:17 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2dcfc426bso502547eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116888; x=1734721688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDQV5UPQrrUTmFDcWju1X4JKAdBtmrkzDO3G5qiLKzA=;
 b=LS2yUeqTeX16QzZV2wsB8bwAIoalGZGbTWO1Xb6ZG4qmlQmCnR9NzmTR3CZAK2NPil
 t3UYaXpW7bppYIiL9vVkNgadojM0HSjkMT0eMfXHZepYsqpotFEXcl+yHUEw1N7goAqs
 tFLspprv7o/Pq53ve/YZ7pUzfOMb96GPtfHo53rZAu6HdNp+OkkeJpCZf5tzn+y4teO+
 TOMF8cU5GO8BOhHVDs9ANPGElLbH7tRzTj09KMkMXrTLrXs4spjent8Tb1/X/H6nWJJP
 PGgYkzh6tJwcpa6AhXBLnEgdwZUJFqAuJG0P87VR89PwfjdjT/+vsDPg51Egfv/fa7dS
 3Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116888; x=1734721688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDQV5UPQrrUTmFDcWju1X4JKAdBtmrkzDO3G5qiLKzA=;
 b=k4DW2JMUJCJ+elD72tRG00axCm857FW4qiNeBif/s/kAOnUWMKdDHmMFAyMbIG+mUz
 UEcUYQxnguyspOeuEffweu6NQBvI5AHL+3+EoHl7rHid8EZCq20scCsg+tHYrQMhN5A4
 PS/ORGmQk/kRomryP4UIpJdETPGmarrBHmsMjg0+1VDbKvSobEVgo9UzE0MbTaQzAAGL
 cGIPeFfVIyK1z5FwrXUtRNSxmHl/2GDjW8P9nh/uOrx06malQu7BLC9tr9oXKnVOj7fQ
 XOa/KU0LjsAU9+Td8l7NrQaPYMkMIyYvh1yD6V5Zw910h7oXSVvBJopxN8fseDBGMPTU
 zfJw==
X-Gm-Message-State: AOJu0YwEyzV3WNoyjGFxhlVEj8zeDpcS45hmTgZmu5sUoMvtXG2hqzx/
 rZ9Hf+WKt7NqnOr323Qa9HoevQcQjdAzJopW5OXPWFej3brZ27cs1XFmfmsADOKIEkZjwzY1I7g
 CV1w+PS4Y
X-Gm-Gg: ASbGncuJdPGEYdnBNPFn5SvKB0lsm2Fxxn1QXyGqMZSb2UNCm/I+hNovJEl8LYdphzm
 KjRVMNy7rcRj0B1aV9Xq7VBFXvp+APGnhpQAmjFEVR8vlNny2HpPEBIC6p2cYMASNIReFZaeZyr
 ZszNm9KvabZKK+OOtJH4F8J2horD1SKG6zhC2onR0ss9d0h6FIizmWggcdZiSGLKUwEUJkXHXa0
 BL1JruxSUTWkgmIJwrnytkT05zSAUWxYcfjk9iR/bbStl4dZLiIhHZbUN7GkoWs
X-Google-Smtp-Source: AGHT+IEkPLk5k0h+n05UqVoZMdKMSHDE8u8kiQgc62Pq6y9ubDgZs70scPMgC/wOsqX+pYSAiQK8Ow==
X-Received: by 2002:a05:6820:1612:b0:5f2:b301:e918 with SMTP id
 006d021491bc7-5f3295eacb8mr1947943eaf.2.1734116888359; 
 Fri, 13 Dec 2024 11:08:08 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/71] target/i386: Constify all Property
Date: Fri, 13 Dec 2024 13:06:37 -0600
Message-ID: <20241213190750.2513964-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


