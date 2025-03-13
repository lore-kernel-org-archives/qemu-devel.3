Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C1DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWZ-0004p8-W5; Wed, 12 Mar 2025 23:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWN-0004iX-Co
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW8-0007qM-E5
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225a28a511eso8806875ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837554; x=1742442354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDxtX6D4zsMFCwMH3zB+SYS9h1ncZfk00z3dcZ1T9dQ=;
 b=J+wv6ejLlOf5Fk8NhxhKC7XLzg1SCXUHgvaJSgiOOz/VSN9kWlAr5UuW8hTXyG11o7
 ueXUSJeP52JR2ux5loY/Vw9MBRPuyfgxBdUPIAs67i8Kd1VDIHlBk4wN6jDOlEqQbc/F
 +L7hRaHux9v8web0XuxkojhM9m2tlxAzxqCPH/rmA1s8VO3ObhV+q7X2yAUuo7AXvRMO
 S1ECFmLnJuEqHYSzE7ZM8/VePAbEQEs/HS1nZFt6ncMVhars4DmT6W8G3wtypSWJ1INt
 zG5dGvdfDEbPK1u9Kg1sd2eyucJIscWiZb5c5o1nWWs7frXaHlh9idLW2JUlRjmHXHdT
 R4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837554; x=1742442354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDxtX6D4zsMFCwMH3zB+SYS9h1ncZfk00z3dcZ1T9dQ=;
 b=JlSQfWtYzdVFSKAFgPJYli/Pb5iWQhYb+D+eBR2BHK28dBgK9sAid+R5G8+o1ZOEOW
 vvhuq7H4HqsSDaZPc5NuV26MSwf6H21/Qfixc+GYX5M4062dqBIaM9h6zdMEMAqJNUay
 cHcqIkAfJa4NGZ/6uorvanxh5RuzVi8dNsUU6VvzECpXJ5YUP9b9cYEh/PM640Z7xxk4
 uHz7Ame7/dP2rSZKl8Cqy/eGf/PKbBkkL43GJjquWBo0OjpSViEh26pKaOtQmTtops5q
 WYKg/ErjPnJ1j68AzWQjHUa7aAVdxxeDa3BoI9j/yXCPA+saItWYqPVh6nvXxsSfhQSg
 jmMw==
X-Gm-Message-State: AOJu0YwB83MAW3Z40/p8wVoID5v/VTy0pESirvgnAbwAnPXLm/S1DEXq
 RPE5kJBaFK6+RnqVJ+7ERMPL2UlUB8Xw5r4XMTmU0SqV2ezEEQKDWxk2nE9wo32/KKgr2qPfwnT
 r
X-Gm-Gg: ASbGnctnjeGJZLkxXaPOqodm9R/qqoIxV4uD7PEX7FqjOUnhXOAxyLgwzsr1Kyz1Shu
 nZOrINPzRTA6rpEHFR1V3JiGSP99qFaI8KVQXoRTWr7cE0qHGXoilcJooafyCQ8qIPNHIhRgQmF
 z6MboK/vgShgPbce5fgNiCzsFGF1Xu64P/zZ+oIRG2rcRBNu6tYZ5K5hWDoQP5Df7OBeSEdWYUJ
 fvZNO6+flNwc2GO1zkMp7pnlgg7aVIYNSNchKVKi/M+VKV9T4NM0jcv2wphcvjS/ZaWDgU2Qcad
 j+0+FBKR/7DAg1cyIIfNNFfY9XBG6QDBQ9nSVT2aqu96HGo1pQXSZqsGtOKyER2HMFrCf+kZ/yI
 8
X-Google-Smtp-Source: AGHT+IEG6AuTp0wFUuWhNBmR0l5NwLvL7paNWoTWt/RiPzt6aYdPCUo0/c91D/HeJ7MLxwDgbDPV5Q==
X-Received: by 2002:a05:6a00:2351:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-736aab02cbdmr35333772b3a.20.1741837554485; 
 Wed, 12 Mar 2025 20:45:54 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 35/37] include/qemu: Remove ifndef CONFIG_USER_ONLY from
 accel.h
Date: Wed, 12 Mar 2025 20:45:15 -0700
Message-ID: <20250313034524.3069690-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


