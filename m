Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5BD0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3x-00049J-Uq; Fri, 25 Oct 2024 10:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3s-00044O-Uq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3n-0007ns-GW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:08 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e63c8678so2266633e87.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865582; x=1730470382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zz8dlKtWuutyQ/7iCySTdzhMOZ3Vcdo7OJOwt3HomLY=;
 b=LmZoURKWsnnKWlhyHsn/ezI3dpOfdDbZFr1rMDgWbM8ukch1WWE6mcQ5SlQhGTOtkU
 smjeDVTHfMzLWv3qIR5XK+LcKCDuGZB0aucXO3qzNV/Z/AAaoiH/2uJTh1dpl6BBNn5n
 lKz3CL/dngeQMjRpuux5Sh8t0uems5lHeWxB0Mc1+W1ZKeYl+zAC7hLkPuwUNetZHlS7
 oQUp9vscMh3AFAasKjisuPNmcX53CyoyZFoY4S+7QcpyWISP6InVhRtdFcbCJd0/SqvX
 eqpZc4O1PeSE26gy4ilwV9IgERpZYjnrxemtRyUP+1sjDLj4R1B5zj63Y51sRmo+MLMP
 SMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865582; x=1730470382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zz8dlKtWuutyQ/7iCySTdzhMOZ3Vcdo7OJOwt3HomLY=;
 b=GJ4sUNRKqEKc00KGO3vc8+GivWG3Cw/q0D7dfkCQ+RLKs24+5j1ANcISSMjhzASeLt
 5vR4sZDq5iIGV18k1XMIMj0Z34FSVzoh7hggfzoDM1f1SpOSMR28J410c8vmYL4FUVjn
 Xn6wab3bw/b2yMcGdybQdD6lPzXeLDAAf4o7hLt9dFT94Hz2rcPd9VB3Rgxg0iiDKjUj
 kiMy+S1gG/W3pq5jLHF//no7+1ffE5heZNDaZKg3+8UNG6hkW9AyWLq3URi8sLeqxJ6z
 Bd5q7TVOj8r8mYWdmoF+20TyGSbx+XuiOQ0Hojchh66eLHLP6sXFs6EsEKXz+TCGDpbA
 MQkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQc3lIPkfU4NYD77R1dzN3OSofX9z3LUIC/XBRxPrOlC6GFnB6q1YgFvVxNAk4IdMD2aFRy6NIQjPg@nongnu.org
X-Gm-Message-State: AOJu0YwB0BndqXO3EZq83SRM2r74KO9Hm+ZeJZ1HYvh+ZgyRp87JGXBa
 kmcEuvycjMlXe/4Lg1veQx4MS2W4LUGzrReUxh66Zx8ApxM7S6C87RDYEFjPeMU=
X-Google-Smtp-Source: AGHT+IGLCvNrSlGLRK4tTQGeAufx9cVAlqWidYJfC1pDKzhqcf51xyMqLj7Hu7WTPTDCJTjWqk7VCg==
X-Received: by 2002:a05:6512:3f13:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-53b1a2f5445mr5904378e87.5.1729865581703; 
 Fri, 25 Oct 2024 07:13:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 06/21] target/hppa: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:39 +0100
Message-Id: <20241025141254.2141506-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

Set the 2-NaN propagation rule explicitly in env->fp_status.

Really we only need to do this at CPU reset (after reset has zeroed
out most of the CPU state struct, which typically includes fp_status
fields).  However target/hppa does not currently implement CPU reset
at all, so leave a TODO comment to note that this could be moved if
we ever do implement reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c       | 6 ++++++
 fpu/softfloat-specialize.c.inc | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index deaed2b65d1..0e44074ba82 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -49,6 +49,12 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     d = FIELD_EX32(shadow, FPSR, D);
     set_flush_to_zero(d, &env->fp_status);
     set_flush_inputs_to_zero(d, &env->fp_status);
+
+    /*
+     * TODO: we only need to do this at CPU reset, but currently
+     * HPPA does note implement a CPU reset method at all...
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index bbc3b70fa9d..4e51cf8d083 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -403,9 +403,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA)
         g_assert_not_reached();
-#elif defined(TARGET_HPPA) || defined(TARGET_S390X)
+#elif defined(TARGET_S390X)
         rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
-- 
2.34.1


