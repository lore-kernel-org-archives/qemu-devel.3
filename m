Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC4D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Te-0007BJ-8b; Mon, 02 Dec 2024 08:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0002IW-Ba
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:08 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GQ-0003Wo-R4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385df8815fcso1791969f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145293; x=1733750093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iti77Qpa/qys0505SaJu0EETHGjGdf7P6zBWbzXMDlw=;
 b=DcxT71KadiYrZA3OjC5S22Mpvd+hH7sBtNVtwdgprGBSojU0KUGqtCGEX07fCicFGA
 V4WUlVtRDFl5vUu7pRcb2CoCCv5LY50oGAhH1ugl+dgPcbr7eSQvsu7dPNnCbm4BSReb
 DpMwa7+MJOTBh7fISpnvgeQngMRezm0ayG/j4+qMXyUWQOePFlNHXh9DoEs43ZqQQEsL
 SwfhvP/r5JXElzCzoPq40clRR0w+fUDFVuxNqWegqb3XaWDKuDAaUNcyvPpcL3oztPYA
 GX+tf7J5pxJZsOF1ugBgY1T99iOTSdWSGPU3kPs4NyRNWhHUTSH9LYthAwFZHqIc9P12
 gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145293; x=1733750093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iti77Qpa/qys0505SaJu0EETHGjGdf7P6zBWbzXMDlw=;
 b=SFQxLcwfT0cCrOMDs7+oofhA1iMSd0yYqdF/OPI05iJPutkBzQs87cRa8Er+BcxriX
 oPBB/KbwxiCoFW+mRwFMXXwCLK7dOGSouCRRqpjvbvrkqdXHXxhx2+ZgpAwIqdMxm2hW
 q7WeHTpKlaXZmn11k7Dg+aI7PAgl4ZTZoDhyaUpX/0UacY6swWi7HS3vPlEHphvxhwnb
 jRLv52C6RdlTX0S9lXy6KdXstC+EIWcMRVRlRJSkjYyNe5v5EHixS8TY2/cyshpR+rm+
 m0i0OKmqL8Xl2CoSMCE7VaMWTGaCNQ0yJbo/Z9sfTRBcCusH5IhvCmliKjjyY1nM8Rjg
 vHLg==
X-Gm-Message-State: AOJu0YwGsonPuk5uEwZCzXPPyop7YSzoznTCklwD+/iuK8ATh6psQbsV
 EOw8r1WmNiGzNXziB1LbzMDofyyZk2lPwWrj/+93Z4vG7fbkWf0ngeoLosMJPOCMUeyqTNs5qI5
 E
X-Gm-Gg: ASbGnctiRJZ7zWjCj+8Wd22+GsCqpV2Ol2jxnEmvSiKqGvJvqr/dtyAYabriOWzeCk3
 sN5uiN06awVTYVZHkGrA2JPIdLYsiWJeC9ieSIE5nQ/7NukypT4oPc+6FKS5wzdocD2obvtwqXs
 zLiFrVpGaFjZuF+QdqntuYil2bAWGZxX4J9sIpwDPUasEHXZKySd32AaRRVAMbXZ6x+CIh3Uc7x
 Ri7u14IvmoCW29EXfXVV3OOypaN5mewFHFKDO+TaiPix1+ca0GkspM=
X-Google-Smtp-Source: AGHT+IE7hvtFuGrEg0mz+bBatZd0DfKZl20t+3wAaC7jG2Nq+5wvLqiyfB/3feAoQtSqJOeAf6PZeA==
X-Received: by 2002:a5d:59ab:0:b0:385:f560:7911 with SMTP id
 ffacd0b85a97d-385f5607b0cmr2206242f8f.10.1733145292619; 
 Mon, 02 Dec 2024 05:14:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 46/54] target/sh4: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:39 +0000
Message-Id: <20241202131347.498124-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set the default NaN pattern explicitly for sh4. Note that sh4
is one of the only three targets (the others being HPPA and
sometimes MIPS) that has snan_bit_is_one set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sh4/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcfd..d5008859b8e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -127,6 +127,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
+    /* sign bit clear, set all frac bits other than msb */
+    set_float_default_nan_pattern(0b00111111, &env->fp_status);
 }
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.34.1


