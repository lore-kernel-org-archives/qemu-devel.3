Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FB4E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKR-0001Hg-GW; Wed, 18 Dec 2024 08:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKN-0001DZ-IY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:03 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKL-0005e2-9r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:03 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ebb2d8dac4so2576658b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529379; x=1735134179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bp/oRY40UFC3tdQVPiyIpJHiv7h6gPdhenpcH06yx70=;
 b=N9YgPBuJFb9eK593NYv0y9VQ7CRFGaUKe+rGoo/z5GYbjRj25qa7iL1Uovfo9zQYK7
 qyuceYZqZrflhBRWj2zTNTF8HMWyvHq8XrrucReWwXGHjiLrj/PtXsbiU0/miZ7VvCpY
 3AMgUyd9WApJDn9gJtv5rFIiIdJlYU+9EnyPO95n2Y5TzDpttrXvP1yrK58CFX8TDn5e
 ppVJ3ch6fu64Do3+k9ZDtsdDMAUbiayP8JeXJZUGo0ceDwvJUrPoEEVa9PO7VNuoR1ZS
 GeK3LVTLW0hqfLbgVwqXTkCXowJtOFtvPSybDdWpiQ/Ry0oH0UTz4ZO9TXHCADw1qLSx
 Fu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529379; x=1735134179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bp/oRY40UFC3tdQVPiyIpJHiv7h6gPdhenpcH06yx70=;
 b=Xl9SYSSf1GGPD8ba4Ae0BvP93b8V+wziJo4GFy+U8lQB3w/mTnEV8+evI2MI+f7g0N
 kyYYCjmjr/TGF1gMbu2HQ5K5u2EKa9OhXqlPViDdDKKdiXo2OM5hjD4hlaCofZ5eS9A0
 b+VfkwyH+a/5qtrcGCcq0VP91tVcFANvZ5nsyfmEGf90WeBuvyhZ9avomAK1s7NNyGvt
 W2AbbWRD2HVVfdGJeq06DXL8tVn2m+vQlT4whQPdvmZozjb4+ksDEK+B+ERSi0BGuW9m
 i5iryddLL2f4D1Enp9iGH6ICWTe+o2Y096ruzukeaEDtsNQtAxBnj7SMXkXKBH8TvJhD
 TPGg==
X-Gm-Message-State: AOJu0Yz4muiKeYHsGSrQWZ+ovv9EFIHsTBIqcS97a6KQaLn3xc/VuPoz
 VsXiOgxeSOxEpc6k1paLeQe+mi01C/s8cWEkhD77acIkJhGTWOQscU+8Ol+qj/DMOMtBVsQwn2j
 xZYXRkt2H
X-Gm-Gg: ASbGncvBagh8eifPZCKEbB2JWQM9hYWuKlA7DnStSd9iyyigJc534sv7a18jjUR1DS/
 IH/MnyC+7mayN6fHwDZJEhf5Rc88UGLVXK0FxrKpzXPCvv/15kTiA5JkuTkJXK7lKGDG1YoEbLl
 FXfs/GfIVSvnk23/Eyr0ZcC5bx0+7NgUm8bQpI+0liJ/rMosPZznSupY4Cr4JQWqam7NfdwwzSD
 pMRBUL5ETECu/wdcTuXWT99vYYewXvPX6pHjAixcm2kWGX34vzansQD1nytGpcc
X-Google-Smtp-Source: AGHT+IHV0W+3ly8Xsm/UZtoDMgYER5DMGx2Fd0rh3/PEJgad/nyRQRp4/vyy/WuqLpgNo2NSCF2gZw==
X-Received: by 2002:a05:6808:13c2:b0:3ea:3db5:ffd4 with SMTP id
 5614622812f47-3eccc1b652amr1803909b6e.32.1734529379159; 
 Wed, 18 Dec 2024 05:42:59 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 04/24] target/s390x: Use s390x_cpu_properties for system
 mode only
Date: Wed, 18 Dec 2024 07:42:31 -0600
Message-ID: <20241218134251.4724-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Avoid the empty property list for user-only mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4702761ca3..263f9e84ed 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,8 +309,8 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
     return "s390:64-bit";
 }
 
+#ifndef CONFIG_USER_ONLY
 static const Property s390x_cpu_properties[] = {
-#if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
     DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
     DEFINE_PROP_INT32("book-id", S390CPU, env.book_id, -1),
@@ -318,9 +318,9 @@ static const Property s390x_cpu_properties[] = {
     DEFINE_PROP_BOOL("dedicated", S390CPU, env.dedicated, false),
     DEFINE_PROP_CPUS390ENTITLEMENT("entitlement", S390CPU, env.entitlement,
                                    S390_CPU_ENTITLEMENT_AUTO),
-#endif
     DEFINE_PROP_END_OF_LIST()
 };
+#endif
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
@@ -388,7 +388,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
-    device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
     resettable_class_set_parent_phases(rc, NULL, s390_cpu_reset_hold, NULL,
@@ -404,6 +403,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    device_class_set_props(dc, s390x_cpu_properties);
     s390_cpu_class_init_sysemu(cc);
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
-- 
2.43.0


