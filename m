Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4295CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPd-0006rh-JE; Tue, 22 Apr 2025 15:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLf-0000fh-Bx
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLd-0006dT-6X
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227b828de00so60223265ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350319; x=1745955119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=qArbqv9qhealEbU49rmICwASJDtX0nzy3OVOGPTGpKcmAfrN2cWYyVIm6vX3L5m2JM
 ZuN74IKRMkSUP6ECKihZ2R9D5dVflnfxejR+XSoFeBBbHC8BZB4Zci5NkBYQ6UGZ1Nto
 efmU/KLq1SyAjjeT/GIv7bHl+3T71SaOb9TM2xI56bdgvUgLObtQ9ZXf8Qen4Uh0Xv6H
 /0E0iwTijiPA5IMLwMhdbawGZdCaxrPHGKqdGag3VRZRW2cjxxgdEpgJ8/yKCK1fTq/W
 E2/zhEY8ajhP4QZzZQOZr2DQv18O4nX2OWfvm1l8hoyJKqGBkdXxhCj3Slw+vmTWiZD9
 L7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350319; x=1745955119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=dvqFqUMLBWsysns3FZss/pEwKBC6/84qpcTeXo8orKncCDqZPxHADyvHUrrcIUC0FP
 jUJ/EfPmuJa6mtr/b4UxztHT/KKBKOwqZRpHrHS8qwguLlBgHVPxeQOdxlGUnRkJObAM
 NmUpj88RGTR2+2Hp6eq/VtdTW8KTELhC3P6ZNKbn2TiuQsilTb3F3EOiyzZTsbMDN6BL
 NHgWc8qlhMSGXUAIXCAXl20FPMaRbIWHismim0PH8X7yqC+KAeCpkLOe9OVvBCOOw3e7
 ZXWtJofXRBi3rDe4zYtawvg5pOeRpOKv3cb1oxjT4h15gg/oUHml0Z1xf+/vN7PJfp8p
 30+g==
X-Gm-Message-State: AOJu0YwFhrDMOvhery9yUQCEKWQXKZq8//Xhr/m2dGPYwql6G+3lXDhi
 CcDafjihDLKt6jZONElaD0KfV0/xWjJXe2Xbdxuh7wtz6TayIhiPdjXgS7AZ1eW4Mjo1zLGQGs0
 j
X-Gm-Gg: ASbGncvQEg5WhJmGu0Lg2qbXG5WpxCM/XrBC2UIc0gAtOetI/AbU6T1Xt3Fo/y5DkID
 nmcJvwlN4O4rN1ME499IE8cm2wnqZrhmTMoBB8HjNwJL5mnHwsbfZTZEnNZzaeiiOfYYBRoRLiz
 9sElTqw8nZyVyzoguxm4x2NSDxqB0bLIlMrkctw0C5UXM3dYNSu3lFnq6ML8mZ10Ngo1I94WrVE
 vgiZ6LkARr/ZmIrVzdYq7jUkg4H68w7bRNdbwjtTqOpX3EqQtLA/OBGnZx0Kzl5sPqm/ZsUUiQ/
 vKgbomUMesuDkN2+trdZuMKG5C+Y3nFlJlz9s/cLZ0hDn/CRqhdD9A9c1ZzHq878dKEGutHTaec
 =
X-Google-Smtp-Source: AGHT+IHjnKRLmZUR+58ST303qB5aoXrghQNSd03NpNk6U2n/d5xrHPVsbrPkY1+RO/oXdbW4TkBUCw==
X-Received: by 2002:a17:903:2344:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22c535834bfmr267115525ad.22.1745350319573; 
 Tue, 22 Apr 2025 12:31:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 059/147] include/qemu: Remove ifndef CONFIG_USER_ONLY from
 accel.h
Date: Tue, 22 Apr 2025 12:26:48 -0700
Message-ID: <20250422192819.302784-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

While setup_post and has_memory will not be used for
CONFIG_USER_ONLY, let the struct have constant layout.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 972a849a2b..fbd3d897fe 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -38,13 +38,13 @@ typedef struct AccelClass {
 
     const char *name;
     int (*init_machine)(MachineState *ms);
-#ifndef CONFIG_USER_ONLY
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
+
+    /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
-#endif
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(void);
@@ -78,12 +78,10 @@ const char *current_accel_name(void);
 
 void accel_init_interfaces(AccelClass *ac);
 
-#ifndef CONFIG_USER_ONLY
 int accel_init_machine(AccelState *accel, MachineState *ms);
 
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
-#endif /* !CONFIG_USER_ONLY */
 
 /**
  * accel_cpu_instance_init:
-- 
2.43.0


