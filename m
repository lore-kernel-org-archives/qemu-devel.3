Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF74AC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6d-0000pv-DU; Tue, 29 Apr 2025 01:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d50-0007bd-Oy
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4y-000606-NG
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224019ad9edso84177525ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902822; x=1746507622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amXX/THKLt9of3i5C6GzRyhvwR1vAr6wdZGYECnCXXM=;
 b=wB5c1W5563ERc7sKy3Td0m1tbrk2SUtH4sq9E1NF5ywAIhB6AvVT4rH8TeidHyDceB
 w/MWUDHg12etSQnxgE4bURezkrtjQgjnIvdC3FyNPyqhOdZt4palWcyl0p6smTE1wmak
 qp06nQq1W/Owuly722NeafIIndeAj/qV0ikjnDuwI/NhEtiRL0C2ehTxkH2rmkDoH9cE
 38QJO6d15sNNUanf0Ve1H1aTK+lBu4eJxTP4ohqOwAI5/ddddrgzF1zabDIef4Fde/dX
 ErL27AVQc5tyn+oE1qdhYVsmp4yzyvLqjt4OoovjeTIF4+K1Oe6Ksnzd7ym3kcFmxahU
 v/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902822; x=1746507622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amXX/THKLt9of3i5C6GzRyhvwR1vAr6wdZGYECnCXXM=;
 b=GGjMZ5bsN+2E++24hFgCwshmpvQIhKRkFqhrKjlMTSZbQtZ2S7Yqpcx66nVFb7v5Pv
 LtYnwPfJyNO2+nxk/AGRTuUhvp5NPNCM4U+jupW5S93p5f8K+7s+tpYtNz7xgmDzf5ky
 N5HRFL5yYjU+vKJfjrux0t4sjkrk1bYOCNH5H7XIH+TmbI51dkNx97V6eejkULXvcUEr
 kzqOjGRJjVn/5sjGG11wi64YL7qjLmDjSJ+68+dG4U53X3w5tVeo2DDHUxb3Blo/jZDD
 myv1zLY1ZnyUDisF6109KN0oM4jf7PgU5G+CfO3ezPqiAgb91R9l2r+CmexeTnaRzR5i
 OPNQ==
X-Gm-Message-State: AOJu0Yy0VD2sixIgYdl2cx6piQa4NmX7ILaT8mj5mlHYfYThJRqaq+UQ
 fA/lL3c7qKXmIjN3mhZ7xx/v2qSH0b1ewheS2qGeSHObcH9CoYHYsyhaHfP8lOQ2iUikoFFLU+7
 b
X-Gm-Gg: ASbGncuEHj0k24sfzu+W6VoVKg4ZdcoSxp1yGypcnK2LkuwiZSmy8n/T8O5ejS/qbp8
 tLg+EpG783iX17BC6lRaO+wQwUdn7F4xMjgRTK0zbtTH1LQZJmoMIXrYE2UOCqEAqQY1waC7BiL
 0T3vsvJMAPrJ+TtyvJKAQ3RGnDh2zM/QxHhznM5AfLMijUaX3E6FhKFve2nlVfr38GoeI8DtHMw
 yWD9l/omvbGOOO028hXqsfs7rhiSEi8fvQQNVTDYVJPc+FFG0KU6JFiemwuKbq1b9NKUlerkbkc
 iAd/ajZgNLs908XghXgUIUgMRyyUht25Zd0wPvsQ
X-Google-Smtp-Source: AGHT+IEPSmT/3UWE3bABefq+kerkvTIDMzjVefNcm7AcQNO/z374B5XjWls0wpsS4F9WSoqUM7jzug==
X-Received: by 2002:a17:902:da8b:b0:224:10a2:cad5 with SMTP id
 d9443c01a7336-22de6f7e6a9mr26233645ad.10.1745902822519; 
 Mon, 28 Apr 2025 22:00:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/13] target/arm/cpu: remove CONFIG_KVM from
 arm_cpu_kvm_set_irq
Date: Mon, 28 Apr 2025 22:00:04 -0700
Message-ID: <20250429050010.971128-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

This function is called only under kvm_enabled(), so this is safe.
Previous commit took care to add kvm_arm_set_irq stub if needed.

We need to keep a CONFIG_KVM_IS_POSSIBLE guard because
this function uses KVM_ARM_IRQ_CPU_IRQ, KVM_ARM_IRQ_CPU_FIQ and
KVM_ARM_IRQ_TYPE_CPU which are only available in this context.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c60..e7a15ade8b4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1101,7 +1101,7 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
 
 static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
 {
-#ifdef CONFIG_KVM
+#ifdef CONFIG_KVM_IS_POSSIBLE
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-- 
2.47.2


