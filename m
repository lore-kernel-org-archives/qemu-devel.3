Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv296-0003Oc-QZ; Thu, 11 Apr 2024 17:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv296-0003OU-3z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv294-0004mR-2Q
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:39:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-346b146199eso181626f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712871584; x=1713476384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrhzeMzxNuIZGu7VGzskxIOg/oIQUJqRCAaEjVEOSZ4=;
 b=mUy2uOPkLEF8rszY7JedBItwmrbtrdmFYDD7JC2pLbqRzV5uIiSwyhslz/4SaPO8ZU
 mAZDWUrEcb3/2+7r3/V/ORtEebPRFFluXQdVpBAwDFIZLkP3VcsSdNASFLHYqwtY5EVb
 J5yWAq3WBmQyAeBEI73CRnD2YJmLXZYm5Va6vK8/jaxP95J06x9HfqK9ZIBzNyAF+/R0
 J9LvAMqxbPQj+rSSVayM2HXoZGaG/pNujjjZxp/DdUlEzQd9HS/pmg4kdtQrX0LQaJ3q
 K7gSKQ8Di5F4tKNO7yxR9n8SDbhB3PK9UBjKYmUbscOZQBzm/iaE4dkyfl/rLvdSQJY6
 Eqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712871584; x=1713476384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrhzeMzxNuIZGu7VGzskxIOg/oIQUJqRCAaEjVEOSZ4=;
 b=CB03zyx53JBLSlDPXFWn+Hj49acW7xzietfYPOoV02EwKNkUnFnG7YzMIo0aRK/0/W
 2+upip/2yl0RC/mwaSVmQtp2epYCtS54jU4BgxssfSF6jpWTkMJkIIPCl4B5ij5iMHiN
 utWsy/9SS7TTFrIJR8bz2d/CFz2NJjc4AmCfqVWuK9vzaEoxPeLEy1/m8vyXRpyniz5u
 palno3QAs3D8YazIvBmyMlhMOAtLW/5HGGMRiy6dhx+ao2YOOYwmVfT386K+k3dKxYGe
 OmKP7OPTotMollKnjjuT2bLDfWTbjEu0srY65jN5r5Fh6fcWu67FfFEd4+WEoEg+dacm
 +eXw==
X-Gm-Message-State: AOJu0YxbxOw8aSI38pVaGEbRMpSLcG18JAa+uQapasa9Lt/fJh+pLjlf
 kU0JbTNMzNTwL+78QilSEJbN62oF9q+GigTAfLT47tduNpQTWnYLHaKxoWQ9YSX0s4B3nPCz6M1
 QW5Q=
X-Google-Smtp-Source: AGHT+IG6Q0gnfj6jMf36tSDGoDoq1L78JcjoTdtATXPa0/ycJEhGSMJbE39xa11I+X96xuIiXAwEpg==
X-Received: by 2002:a5d:68c3:0:b0:343:7f4b:6d9d with SMTP id
 p3-20020a5d68c3000000b003437f4b6d9dmr463738wrw.53.1712871584250; 
 Thu, 11 Apr 2024 14:39:44 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 d15-20020a056000114f00b00346d3a626b8sm1745217wrx.3.2024.04.11.14.39.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 14:39:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/m68k: Remove sprintf() calls
Date: Thu, 11 Apr 2024 23:39:33 +0200
Message-ID: <20240411213933.36548-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411213933.36548-1-philmd@linaro.org>
References: <20240411213933.36548-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Since they are very few register names, use const arrays instead
of trying to be clever generating the names. This silences:

  [2/8] Compiling C object libqemu-m68k-softmmu.fa.p/target_m68k_translate.c.o
  target/m68k/translate.c:92:9: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
        sprintf(p, "D%d", i);
        ^
        sprintf(p, "A%d", i);
        ^
        sprintf(p, "ACC%d", i);
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/translate.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8a194f2f21..d0561c18fe 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -48,7 +48,6 @@
 static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
-static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
 static TCGv_i64 cpu_macc[4];
@@ -66,7 +65,15 @@ static TCGv store_dummy;
 
 void m68k_tcg_init(void)
 {
-    char *p;
+    static const char dreg_names[8][3] = {
+        "D0", "D1", "D2", "D3", "D4", "D5", "D6", "D7"
+    };
+    static const char areg_names[8][3] = {
+        "A0", "A1", "A2", "A3", "A4", "A5", "A6", "A7"
+    };
+    static const char macc_names[4][5] = {
+        "ACC0", "ACC1", "ACC2", "ACC3"
+    };
     int i;
 
 #define DEFO32(name, offset) \
@@ -87,22 +94,18 @@ void m68k_tcg_init(void)
                                                  offsetof(CPUState, exception_index),
                                                  "EXCEPTION");
 
-    p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
-        sprintf(p, "D%d", i);
         cpu_dregs[i] = tcg_global_mem_new(tcg_env,
-                                          offsetof(CPUM68KState, dregs[i]), p);
-        p += 3;
-        sprintf(p, "A%d", i);
+                                          offsetof(CPUM68KState, dregs[i]),
+                                          dreg_names[i]);
         cpu_aregs[i] = tcg_global_mem_new(tcg_env,
-                                          offsetof(CPUM68KState, aregs[i]), p);
-        p += 3;
+                                          offsetof(CPUM68KState, aregs[i]),
+                                          areg_names[i]);
     }
     for (i = 0; i < 4; i++) {
-        sprintf(p, "ACC%d", i);
         cpu_macc[i] = tcg_global_mem_new_i64(tcg_env,
-                                         offsetof(CPUM68KState, macc[i]), p);
-        p += 5;
+                                         offsetof(CPUM68KState, macc[i]),
+                                         macc_names[i]);
     }
 
     NULL_QREG = tcg_global_mem_new(tcg_env, -4, "NULL");
-- 
2.41.0


