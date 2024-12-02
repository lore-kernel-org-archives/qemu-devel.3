Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C19D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6MV-0000G8-W1; Mon, 02 Dec 2024 08:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GR-0002Ga-He
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:02 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003RY-9f
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:58 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so794206f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145285; x=1733750085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6b67TuxIIuUbvFPYapA8HgByL1UEo/kP+YGdKuHFudM=;
 b=E9BQ0oLvz5/haQwK9hYar3Z1aHHkAyCDYZYse6aG5RITR1UaActeclATxPah2u3avw
 jjeEnWo5Vb8c2g+OoKlC9eq1d4I1WzZNETqWghnhHNJ0N+iGzyf5/DwT4Hyj3RN87s+8
 HMq2m3JCVPebO65eK5r1e45EL0kHN6j/1LCFvRrdEfVNV8fybujp1g/j/zgyDqwgNHYT
 0b9b3sDhYE2Szq2NtZzany7pqd5lnaP1C+0g/X2/GF5Xvpq+W0Dg99dUsKp57UnkLHf0
 iaVRNLPUY/UUdOGNQ8KSZvUcehP0vugQ2NVCtOFcg4wezrUDWG1liryWZHNxE/ZnXDrk
 KcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145285; x=1733750085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6b67TuxIIuUbvFPYapA8HgByL1UEo/kP+YGdKuHFudM=;
 b=pzweqMWoAGeY/IEy6mJeTuCx9Jl1v96HkD0gzWAnOHZEUdk2tczQ8nWSJr8gjnJWKT
 sqmpgjaDsJNDKq3ilD4OhxLcpE4/edc1C2v/+RoDn2FvX7RTdCYxftkTi/tX2wK5twJ/
 cFW1s88Ns8FUKhcG9CWcBEhueT+/0YNGdWL8NKIaGiiibZTGxd1EfFVsUsVG2JjxruKK
 7dGcRmbAzJmRfnONfD4jWJhfhgaEUB9/YVRIijtRdQoo0GXpU4T9aS1Y9SzJ0rEE2DfI
 2OJVNBIwoEYKX2IBRrmOc2jeRcyRukGocFC78L2D63q8f+IhpbxPw+3HQCaroU23dpON
 Iaxw==
X-Gm-Message-State: AOJu0YziMiIvKakVnbl7xLOs0BeOO46KxSBX86RBt4lexrK9BiO2rlui
 3zgtugOS+H3NC3DJDCicdeAp2BTAQKIh0tgGRTqlco/QIqrernlLBJedkkePCvrjH0t5lMCPCtC
 G
X-Gm-Gg: ASbGnct/YeQ/og2FcrpjuF2bfFJ0O7z3o9wK6LQbyWqzZukmdRwdSEoaF1aOmqp+5XU
 Mg9Rd9pG1HjvAnwnw6SaVFbuXXtb5yFki1C9GCObOzorFmQ3PUSenE3mYIRfnLvycisDYPCfuN3
 jERmLwwcrC/ezY1jF6dutWJZq4AQnr1+wXtwbfS/pskIBiK3rZ0shsJeEmVh4NaAz8t2TZMVa/V
 IqW5eXm3qthQzmEWGxNf2n9Uxr+z43MnZzgKdfiZHoUj7/u5mE8yjQ=
X-Google-Smtp-Source: AGHT+IFPP/69/o/8stugJpVepC120rwI93xT8a4bCLYkdFLQeip4Au1UHJnxnRoTijQt5ciXEuHfUA==
X-Received: by 2002:a05:6000:186f:b0:382:319f:3abd with SMTP id
 ffacd0b85a97d-385c6edd338mr21552950f8f.36.1733145285219; 
 Mon, 02 Dec 2024 05:14:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:44 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 39/54] target/alpha: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:32 +0000
Message-Id: <20241202131347.498124-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Set the default NaN pattern explicitly for the alpha target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/alpha/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7a..70f67e6fd4e 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -199,6 +199,8 @@ static void alpha_cpu_initfn(Object *obj)
      * operand in Fa. That is float_2nan_prop_ba.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN: sign bit clear, msb frac bit set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
-- 
2.34.1


