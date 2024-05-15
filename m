Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1BAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFQ-0003sS-2a; Wed, 15 May 2024 11:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFO-0003r2-0w
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFK-0002ow-77
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42011507a57so30811435e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785724; x=1716390524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTjFqZGfIgyyuZashU0miJrDlkwdhgdcBxd/4Tmn0sc=;
 b=NnQb5Ztn0eg6ru4YzxlucVxjs6a5MXJwnDEfjeub82qsLSafsyaecMyPsNwMlM1FJx
 k59bZxwMWPTJ55wIR7s4IVwew4wAtOoyl8DIWefjjAyOfafAnu76j20layKEveM1tM4n
 gEXiLH4IUdAC28RdAqPTCv1mwoKHUdVUqacqq1vBINpppfdAiz1OPWFyHiXRVdzL4Ctg
 7j35ZSGLwmR+IhDKDDgklhHFcrfm/JoM6FbPxKAjeI/px1yJqFmZ0CJQfh30XHqrBAgf
 E84HJuNlr1obAyP7XUpXalVvz+Cre1nW/oMy0c0F0BE/Nu8sh01e7se8CZ81BDCeuWa4
 7blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785724; x=1716390524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTjFqZGfIgyyuZashU0miJrDlkwdhgdcBxd/4Tmn0sc=;
 b=LG4OA8MySxcYbGKXSBOGV1oV3B25gkouHz34vXZj8KKCKK+Gov3bM3XIjYfkPuFZQ3
 jWVUHpQ0IZzhDGYQ7tJ6sulWmfnEp6Rixxo20viDAsUVlboemepL8y6q6t282BAd5uqz
 r3rsNE6N98nwaPD3zNjU+gcajC20MWU0gv+YiP1CH5H7cEds1YBp7LiNHolDL4J9U8NH
 mLnCItKkmTvviH6IYe/rtnDKf3yDP67UhMaWHM14nLwTKJSqjh+kD3TmWpDaeACu7iB9
 XDY4szUdHwJulpqTaTOBBTq4xyXZpVwidsX4PlmMq3BIWS3v8P/0p0hZorfhLJ0t1wGa
 Zg7A==
X-Gm-Message-State: AOJu0Yz8Ry0bh1FfxPSCis7hkCwIddsP5N0FsfDzGeGAm8ZNjbcjUHie
 9gbvjgbFvFvM40mdkd+BZ2+ddchknuLpDlCS/WyfnTB2DgnNrxidCMSSmUNUmzaXUm4ANoChxDo
 ETaM=
X-Google-Smtp-Source: AGHT+IGrqux3s4GvXLdvq9nHojjPUe7Q1Iw7PMm7fNHUuqKFbEy5ThpG0H4nU1PNQgXNKjzJsgx2xg==
X-Received: by 2002:a05:600c:3544:b0:41a:b54a:9ad8 with SMTP id
 5b1f17b1804b1-41fea52e620mr119039445e9.0.1715785724377; 
 Wed, 15 May 2024 08:08:44 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 05/28] target/i386: Convert do_fstenv to X86Access
Date: Wed, 15 May 2024 17:08:14 +0200
Message-Id: <20240515150837.259747-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 target/i386/tcg/fpu_helper.c | 45 +++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 5ad6e04639..01e9a1fbbf 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2373,9 +2373,9 @@ void helper_fxam_ST0(CPUX86State *env)
     }
 }
 
-static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_fstenv(X86Access *ac, target_ulong ptr, int data32)
 {
+    CPUX86State *env = ac->env;
     int fpus, fptag, exp, i;
     uint64_t mant;
     CPU_LDoubleU tmp;
@@ -2402,28 +2402,31 @@ static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
     }
     if (data32) {
         /* 32 bit */
-        cpu_stl_data_ra(env, ptr, env->fpuc, retaddr);
-        cpu_stl_data_ra(env, ptr + 4, fpus, retaddr);
-        cpu_stl_data_ra(env, ptr + 8, fptag, retaddr);
-        cpu_stl_data_ra(env, ptr + 12, env->fpip, retaddr); /* fpip */
-        cpu_stl_data_ra(env, ptr + 16, env->fpcs, retaddr); /* fpcs */
-        cpu_stl_data_ra(env, ptr + 20, env->fpdp, retaddr); /* fpoo */
-        cpu_stl_data_ra(env, ptr + 24, env->fpds, retaddr); /* fpos */
+        access_stl(ac, ptr, env->fpuc);
+        access_stl(ac, ptr + 4, fpus);
+        access_stl(ac, ptr + 8, fptag);
+        access_stl(ac, ptr + 12, env->fpip); /* fpip */
+        access_stl(ac, ptr + 16, env->fpcs); /* fpcs */
+        access_stl(ac, ptr + 20, env->fpdp); /* fpoo */
+        access_stl(ac, ptr + 24, env->fpds); /* fpos */
     } else {
         /* 16 bit */
-        cpu_stw_data_ra(env, ptr, env->fpuc, retaddr);
-        cpu_stw_data_ra(env, ptr + 2, fpus, retaddr);
-        cpu_stw_data_ra(env, ptr + 4, fptag, retaddr);
-        cpu_stw_data_ra(env, ptr + 6, env->fpip, retaddr);
-        cpu_stw_data_ra(env, ptr + 8, env->fpcs, retaddr);
-        cpu_stw_data_ra(env, ptr + 10, env->fpdp, retaddr);
-        cpu_stw_data_ra(env, ptr + 12, env->fpds, retaddr);
+        access_stw(ac, ptr, env->fpuc);
+        access_stw(ac, ptr + 2, fpus);
+        access_stw(ac, ptr + 4, fptag);
+        access_stw(ac, ptr + 6, env->fpip);
+        access_stw(ac, ptr + 8, env->fpcs);
+        access_stw(ac, ptr + 10, env->fpdp);
+        access_stw(ac, ptr + 12, env->fpds);
     }
 }
 
 void helper_fstenv(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fstenv(env, ptr, data32, GETPC());
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, 14 << data32, MMU_DATA_STORE, GETPC());
+    do_fstenv(&ac, ptr, data32);
 }
 
 static void cpu_set_fpus(CPUX86State *env, uint16_t fpus)
@@ -2471,12 +2474,12 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 {
     X86Access ac;
     floatx80 tmp;
-    int i;
+    int i, envsize = 14 << data32;
 
-    do_fstenv(env, ptr, data32, retaddr);
+    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, retaddr);
 
-    ptr += (target_ulong)14 << data32;
-    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, retaddr);
+    do_fstenv(&ac, ptr, data32);
+    ptr += envsize;
 
     for (i = 0; i < 8; i++) {
         tmp = ST(i);
-- 
2.34.1


