Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879F6C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFQ-0003sg-Cq; Wed, 15 May 2024 11:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFO-0003r5-1h
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:50 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFK-0002op-FS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:47 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e4b90b03a9so76895971fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785723; x=1716390523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRv9/cJI78XP3U2PIccw7jXbddClyYk+zoUNxwDaOdI=;
 b=Yp/eAH+SVAlZuNlbNNKadAfDh6IierKcj3vOfJdR0reNDmp5eduEbllEb5gGziOZOh
 ThSDoxMCqtMoOQMVH8qdKZNKFfawhY0EF98rvplA8IzJzBkNYtYnh8kGvjw+hj59o3Vi
 Oo3HS9dfLERg8LwQkajubTGnd/lHRa8TZ2QO/Uto+KtN5MWDC/FnzXwutJ4t/dzFajFq
 ktKEH+V3brFRqvcNeELtPptWje8+cYufqcyBHwwE1QiU+kLHk7Otl0KtTEVuMBd7ojYq
 6zLeXw8mDwF4ABJaYgI6vdnNOlvk05qUpPh0R7CigdQOeGC58fYtQtTp9DuHDz3Mt71V
 u9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785724; x=1716390524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRv9/cJI78XP3U2PIccw7jXbddClyYk+zoUNxwDaOdI=;
 b=WfreH2LfsKbGjrStOBN1yRBUwZtncgeKch/yoSf6seM6fFhBQszpNldEBBIWSZ1sRM
 Hs+rubDEFEX/PTsdpplOoaeHEJNlTWGNbDRGdm03VLPCBMDDJeFF3XiogpzChQ++hDHS
 AudYy54vOO9n7J3cfg04jKsAgyFwQoJst+8JJmm7XyDV6VZqCAGhuEK6MxAusJleaFLJ
 C1Fb6vm+oTpFS0YUrbn5G6iA5FrioUAST6hONcWSlPZ6djk85zgIPjUFA0esUAEzunLg
 gEFhPlxE7He5Cvs7A5fyafhpozOSnJwdxqjPeYfIK0WYPW4Xtg8mMQ75OEvey80aNXP4
 enJA==
X-Gm-Message-State: AOJu0YylmYqmVTk2ODKGMc0/iIbirieggKxP3aSTcsa5Rk6d6NuL7fcF
 RLKxCadOtBp+hLgqN8p3UzTVf9js6VkLnhzf9wvULGT8CR8Ngn71n/ip6cU+Lwk0Q3BkbY26nT7
 WEMY=
X-Google-Smtp-Source: AGHT+IFyYQPvWT8t2VMj++xI+MOUiXkEy6pOrG+v4GSOJZ+KIKPSn1MJ5F4PouLCV3fCPtZ+VNsmJA==
X-Received: by 2002:a2e:b0f6:0:b0:2e3:5ec2:fdc4 with SMTP id
 38308e7fff4ca-2e5205ec225mr95489721fa.53.1715785721688; 
 Wed, 15 May 2024 08:08:41 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 04/28] target/i386: Convert do_fldenv to X86Access
Date: Wed, 15 May 2024 17:08:13 +0200
Message-Id: <20240515150837.259747-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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


