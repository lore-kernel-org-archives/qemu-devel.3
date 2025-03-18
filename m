Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuebB-0007zb-Qs; Tue, 18 Mar 2025 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueb8-0007g1-DQ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueb6-0001PM-GY
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2243803b776so4601655ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333739; x=1742938539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=d6HSaOLQj+ygTdqD3c8qhBMsGu8c0ZWWsFJVnlWPhTflDMoYcQRKyL55jN0GwwT5xv
 2/mZCv1Vm/P1jXukmGqxa8WJGWYjpYMJz20a3rhhGnJgkeVQh01ped9nd53BgPY7H5SZ
 8XhZ5p11sXZX+ba3KpykE2xl0KYDyzxqbMMs8sI25bGko1ERBY34a/t30ru4ss9EHthH
 S5QMuYcqIIt1ajr+hma6t4+5oSckmYY4L2UsJTBuHGfpC92BsxN4aCt5CK7tOslr1hnu
 1GARnQKu93iyltZ6iRhkqJcPIuer/5bVTe8E9mlelXqP2BeWXPOTzTeowkvKtbcYDKjI
 T3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333739; x=1742938539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=YC5tv9+ep5RgTr9TUhcdX2Ey74UzaxlE0LGGXnvyAKVzfq8A8xnFqhxDCNb8Pi27Ji
 yPnkZ2osejq9Er9ihBpuS4Q9A3RVX7YD3JOn+k44HsTZLrZ1HWaURUg/aVzjUtcwHMe4
 bUHOy9i2ASs28Xxj+NcRQfpvn1ePh14f631ubugr6UTBveQ1a4Vve73F7cn4egcMBOnx
 DZGr5xKq2dhUFGzum78hOZ2Cjnzt94x7bxRFg5NwZdnLAeQuwL7WNCp5i9ENfqFtBXYL
 +X23zhpDxntP51Vw5ukEcmyQSx4AKo3oULdU1vu98XZgI9upacq1wRUGYy8tmF4jx4W7
 dL3Q==
X-Gm-Message-State: AOJu0Yyhs+7eYs+yUgdY72riZd3ff1Q4yfFHerlizTpw+8i2lUh9dFP/
 MQrZnGHKmSeppw7PZ/cdrq8GUlJtozMRa36evLWnk0ktbBnUjPghPy/IUuUiTT0S7gMn7gVew3z
 f
X-Gm-Gg: ASbGncvHOBmbGmDLN2JXun52ExDI6CjpilTUVkpxE4KTiLkJWtiMAtDZ1hZy5LGGqkL
 8DIkhsunzMt3SjuxQPr6cEWlZeUdiYF5WLofiIlIzqdPV4nKz3W71d6yLh85UHyHfDrqvPPPdmQ
 drMlw8aUinoRFn7YUmE/GklqGi8hKRTQFGZQCNzEMyj6UJEJnpHIXmkKzYSs6raz9B1XMJkdb86
 +3wC8J78OMzI7GBFEQsH0+B5KlKMATjc8+D5e+VBtRuTz3PE48GupsnLes3yvXCbjHsaJexzHWa
 9JTzjWU3HaWeL+ojmO3qRGt6nFBsIlMhqLefbxw780ZVQxZJldAui5LWu2iFptzA9VBCLC3PnUV
 9
X-Google-Smtp-Source: AGHT+IHWmJa0nRJlEHGOnokeGXpVrJ7JmO7O8UI+w/WsnfQCAwzfcvGPY/PS5ngATsmX/oyLRtkojg==
X-Received: by 2002:a17:902:d509:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-226495a62cfmr3719615ad.0.1742333738937; 
 Tue, 18 Mar 2025 14:35:38 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539e9ab7sm8678072a91.11.2025.03.18.14.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 40/42] include/qemu: Remove ifndef CONFIG_USER_ONLY from
 accel.h
Date: Tue, 18 Mar 2025 14:32:05 -0700
Message-ID: <20250318213209.2579218-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


