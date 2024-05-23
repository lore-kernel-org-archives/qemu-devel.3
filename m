Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbM-0001tz-CR; Thu, 23 May 2024 19:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaq-0007Ne-JK; Thu, 23 May 2024 19:11:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHan-0006Kx-JB; Thu, 23 May 2024 19:11:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2bf5e09d500so156394a91.0; 
 Thu, 23 May 2024 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505883; x=1717110683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l5Oxtb4scXFPf0XSK90JMLVp8alCDCHcJpkV2cqisA=;
 b=cKVITXnrUvMpUXP1IBLWvChr8MmSBnbhwNcLMSsHw5Jk+1SyFtJp69PfmmahYmFEqG
 e8RLb/UhUv9ykG3W3fQ9STVBmJo5g0lrfu0FHddQ4FcX+/Doe+gR12Pfc7Om7AEtQXO8
 ctshYZ2i66UKgIdGnlJnceBTaYKBQn6A+ln+E5xxpbqD/9z5RVDHDqasqI2Pcr+ECwWT
 ygnuiFLwIh0qBMsHoyifCx+VeihQW3K3URQA9Waz12AA0GeVkHM3dSyhvw4uu+7ZtGIo
 3DsOJHsQBi02TvyVwFYqepNghNJW3e8o7nVe55N5VoPdR/GKjllew1xP8ysMllPuLdfh
 nz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505883; x=1717110683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4l5Oxtb4scXFPf0XSK90JMLVp8alCDCHcJpkV2cqisA=;
 b=cIr+A2Lrpdq1/1vMKlIzka5AUyIUtBjfZoGuMPyfkDaKeFL7dI8lIcPxCWC/hsPa4G
 qEN3VdjWY3E/HxMHkKfLxKv/xJ5dA3waf+CZn/jIPg1Nq28E42U1ctdzu0ukTU/ib0//
 7kBQ8z8iCa/I7JTfo2It1fdfmi3C6BZyTSSveE+u+p1wSVfaQoh3uYIZOco9g+LA6Ktz
 z5zC8/hRKDRDwV9rezv/6HSYhDkt6RPNEnOEOS7lMmYqmr4sJrZjbFhS8K5U96HLulKI
 iXgJuI6Ut3ekHv1tHko5N5u9/D5kyocrcorP4XDXVapa+q9+lVz9KKwWwjLj4VOn8YxK
 5Ohw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiwRSyRdef6F0uNcYIdMLtlpBCgACxMQcyeg0JNVe0iPbo5mQs/c5ZT4JsrmHSWZRsa2ICLrSdvgtXWy8HaTirrsBW
X-Gm-Message-State: AOJu0Yw31KoAMU6iWk0reuu7CteuzfyUnjROhR20FOdANaVDYMCW/hRA
 iF9B4F2aLiqgYp7fsPKGDNAN7tOxk/cYtYODoB45xu495QMCnfQFoi1ZzQ==
X-Google-Smtp-Source: AGHT+IHvJoJItppkRm2BA620MX8wCWz+h4z77XZAE34qqrcqBTTqPUYELKIChgLKeiwGYDi+rI3HiA==
X-Received: by 2002:a17:90a:cb90:b0:2bd:ef6b:c336 with SMTP id
 98e67ed59e1d1-2bf5bb0cbaemr1105903a91.11.1716505882965; 
 Thu, 23 May 2024 16:11:22 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 67/72] target/ppc: Split off common embedded TLB init
Date: Fri, 24 May 2024 09:07:40 +1000
Message-ID: <20240523230747.45703-68-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Several 4xx CPUs and e200 share the same TLB settings enclosed in an
ifdef. Split it off in a common function to reduce code duplication
and the number of ifdefs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 46 ++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9401eb28c3..b1ea301e22 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2127,18 +2127,22 @@ static int check_attn_hid0_power9(CPUPPCState *env)
 }
 #endif
 
+static void init_tlbs_emb(CPUPPCState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    env->nb_tlb = 64;
+    env->nb_ways = 1;
+    env->tlb_type = TLB_EMB;
+#endif
+}
+
 static void init_proc_405(CPUPPCState *env)
 {
     register_40x_sprs(env);
     register_405_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_4xx(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2206,12 +2210,8 @@ static void init_proc_440EP(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2305,12 +2305,7 @@ static void init_proc_440GP(CPUPPCState *env)
     register_440_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2379,12 +2374,8 @@ static void init_proc_440x5(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2747,11 +2738,8 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_e200(env, 0xFFFF0000UL);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
-- 
2.43.0


