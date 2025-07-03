Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgV-0007qB-JJ; Thu, 03 Jul 2025 07:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcx-0004Ww-Q1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcw-0001ef-0L
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so536667f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540232; x=1752145032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7sqe5WieSfsWOfFniA97K4tiSwKm4bjRb1aMmtsHEE=;
 b=A/fqrTSGY3clPQO1tNXQfbX3OVadMYXcsm0ijzeqNLuW7/npfE2Q55dXL3mRCcMea8
 7fsDDJspl00daW+/EmDQq5ZPsYvXIgYJj6MM/ZScPYplp0sCd2Wo6dY0Mthq0DwDs5Rh
 tuAGkzz0vCJ/RSPNv3gWpS7WbjBg82R1iJdYcddPrOWMg/x6cZamf3Hxcdk520lQ2lQD
 IjcNzy1RKgrSq4MaUC/2YJpyeXCZUvEjJscgSfZPDIHvPa/5dVzXhyAn60fPM2iy7L8a
 VLjXKLjlOaMzV/55qce2+gNBL8yBcUnSQ479iyqBsptnH51hwU+XDCOZwo7d3jtewW49
 Yw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540232; x=1752145032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7sqe5WieSfsWOfFniA97K4tiSwKm4bjRb1aMmtsHEE=;
 b=IN3WAlOkq9mw0PlzH2lWeWdr15DQvdC+YBk31KANoZKHpVQFz8gxLjZO2/hvwVx8IH
 eTRr6/vULbJW7Hi2fbQ7hX9y43RP/jDo3PTsFpX7NI7wEpa8CoJ2S74Rh137Qm3ywSOh
 xaXFCP1l7c87/47jUkuvlXIk1tKgyd6/33d426ZeI3DdKjMHCdT856LkU/8DDwm0wiBi
 wEu4qCXbtXO76uci6HDWA5JxLB1abezGOjvbwYhjhjDsvzr1mCSpYMQm5VV0ZrqE0GVG
 8ULJ2jMLtfI1HRzaUbj5+FrwsSWJBbHbjyYM1x5kQlm1lHxtDfLgwAgOGAyv+gfnXQE/
 TtPg==
X-Gm-Message-State: AOJu0Yy4iAufgqsc5UcBWllT/qjB45fV1gxWDYvA7DvGkbqoqelOsfUG
 /hkjIr5KqN63/fWCsTm/smNrWxg4rtkeDRFDb8TIUe72kX9nToc5dsbCwXpH2P3IxnZ9eQ05wAl
 om2vwL8A=
X-Gm-Gg: ASbGncuueznxsidqx7MZKmGsxxH3V5LeIVuUlDzLsur+owuQhnOdXyj0Sl5i4RIwIIe
 V3LukZnJ23i90ujcGwKAgdHOmPFR7vxLOiyQPodCpunhJ3Vzubn3lu28ht4C4pkXUe1X09OKTe4
 QUq7gcZB+UUYqg7cUy7/ZdsyiJhkCq5Y9uz3nkHsbkojuLFUQeoOJfCS/Z933NqsOnt2c2CvR5J
 HatOaWPZ5KqddZIO8a+nvJD9jwJKqsTQ80LKKFRd3RytmrtnFz8pSkxosG6Qzalp3GLLQUut23C
 knritEXFFZ5p926ptjg6kVQPLyiNRjsF5e3BlY/3vUGwW4wXEVHlL4BPbfCTPOICrsUTiHTEgap
 6d7DHcU03Ig8=
X-Google-Smtp-Source: AGHT+IGRy6J9bSh2nCm/wWER+UpTUBFDN2Gq3tiv65nOglWjOb0sw7QVz7lMukD2pAC1YNJDsKOanw==
X-Received: by 2002:a05:6000:2484:b0:3a5:5136:bd25 with SMTP id
 ffacd0b85a97d-3b342440189mr2171036f8f.1.1751540232092; 
 Thu, 03 Jul 2025 03:57:12 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969f2asm24089165e9.8.2025.07.03.03.57.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 17/69] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Thu,  3 Jul 2025 12:54:43 +0200
Message-ID: <20250703105540.67664-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h      | 2 +-
 accel/accel-common.c      | 2 +-
 accel/hvf/hvf-accel-ops.c | 2 +-
 accel/kvm/kvm-all.c       | 2 +-
 accel/tcg/tcg-all.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index a6a95ff0bcd..1c097ac4dfb 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,7 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(void);
+    int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
     /*
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 55d21b63a48..1d04610f55e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -128,7 +128,7 @@ int accel_supported_gdbstub_sstep_flags(void)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
+        return acc->gdbstub_supported_sstep_flags(accel);
     }
     return 0;
 }
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c256cdceffb..640f41faa43 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -353,7 +353,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static inline int hvf_gdbstub_sstep_flags(void)
+static inline int hvf_gdbstub_sstep_flags(AccelState *as)
 {
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6f6f9ef69ba..45579f80fa5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3980,7 +3980,7 @@ static void kvm_accel_instance_init(Object *obj)
  * Returns: SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(void)
+static int kvm_gdbstub_sstep_flags(AccelState *as)
 {
     return kvm_sstep_flags;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c674d5bcf78..5904582a68d 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,7 +219,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static int tcg_gdbstub_supported_sstep_flags(void)
+static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
      * In replay mode all events will come from the log and can't be
-- 
2.49.0


