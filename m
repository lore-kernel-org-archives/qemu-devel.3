Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31865CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCS8-0002oD-4u; Mon, 30 Sep 2024 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRs-0002Kc-Ri
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRr-0004dn-1y
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so39745145e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687525; x=1728292325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZ3s4BKBUIpf605yoFIcvuj2HOu5NdByFuIUuDf7Wlk=;
 b=kbNjyS7Art1bzFQ8q78iPqr0pPFkUBNtsOocIeDfsZhl7jRVgwfvTIHhHOJOEmH+Rk
 ilMrRyuN7oKVzRNapoi0iqsTGt99OpRfnJyc0UEVDHihuUvZx6v/h5LSbCKdiqnc6YaJ
 lPQ3dHn/i3utVcdGmKOBBYLoFiHS0SyZb2tvsshcyk3jDa+zhwslZGhx4QsBOOmsijYM
 8O1G75zjHGGPA8a0l/0Fe+0KHz0lx9zFK0OzJ83//PF27J/a8rP75KManXJaKDgitF2C
 hv/oOQyZemE/oWIXxBoZyq/7ad+PWsG4I10ZXIrx1qaeDprend74sR30vQxLdbgOiD66
 mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687525; x=1728292325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZ3s4BKBUIpf605yoFIcvuj2HOu5NdByFuIUuDf7Wlk=;
 b=Q6UxFvAmgx4T3tYqZsl/Gks4ua/RyqmYOPDu+3Ieskdidu8bXpUAGyPYTP9VS/3ORb
 aWcOi9KciFmcKk4YCozqcua/hkplyk2/PvFMUl3dEId2nepPa6v/m4VgsNLc7epJKtvF
 PmmQ6K0LgI16rz+ZnxqCZoBgRcagl3xZUDcJVtq5nbYNDBQnbmUzN7HnDRgubYkiuq6Z
 t+pV2XmovRXnWoa0SWofmSwSnU6hziy+ZRqZ9NFfK8jtyEHrNBiQBITh9qITOu9ZUP7K
 Nnt4h7uDTpw+y9gP2wQTPHDpBfUUc3bT+QeGODk0xVu+oqgy83rog63xPRrleEn2W16G
 9g1A==
X-Gm-Message-State: AOJu0Yyf2WApoiH4qDUvu3ByTIVY+BYLZjpDNU/ghtnt+D9emkAM/FvD
 Kooqac3ycet/V0Ycp4XuVth7ZRx/o6f5QPGT6egPIkaR7KXSOy4XdqgzBs2HrAwjtYJKpr/Tz9n
 e
X-Google-Smtp-Source: AGHT+IESSYBEffHZ9mn3SZL6r9LRgoZ2v0CCuUL5iPDughSA3ypcTq5hwUBQVEPDZiam+pOV48FEXA==
X-Received: by 2002:a05:600c:1ca2:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-42f58433166mr75603565e9.13.1727687525081; 
 Mon, 30 Sep 2024 02:12:05 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a362bcsm144722025e9.36.2024.09.30.02.12.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:12:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 08/12] target/mips: Expose MIPSCPU::is_big_endian property
Date: Mon, 30 Sep 2024 11:10:57 +0200
Message-ID: <20240930091101.40591-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add the "big-endian" property and set the CP0C0_BE bit in CP0_Config0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h | 3 +++
 target/mips/cpu.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3e906a175a..070e11fe0d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1209,6 +1209,9 @@ struct ArchCPU {
 
     Clock *clock;
     Clock *count_div; /* Divider for CP0_Count clock */
+
+    /* Properties */
+    bool is_big_endian;
 };
 
 /**
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 89655b1900..982f5bb4e2 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -200,7 +200,8 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 
     /* Reset registers to their default values */
     env->CP0_PRid = env->cpu_model->CP0_PRid;
-    env->CP0_Config0 = env->cpu_model->CP0_Config0;
+    env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
+                                 CP0C0_BE, 1, cpu->is_big_endian);
 #if TARGET_BIG_ENDIAN
     env->CP0_Config0 |= (1 << CP0C0_BE);
 #endif
@@ -541,6 +542,11 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 };
 #endif
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 /*
@@ -571,6 +577,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, mips_cpu_properties);
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, mips_cpu_reset_hold, NULL,
-- 
2.45.2


