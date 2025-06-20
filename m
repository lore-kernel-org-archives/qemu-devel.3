Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CEBC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfK3-0000cA-2j; Fri, 20 Jun 2025 13:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfK0-0000bS-9N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJy-0004EL-Ju
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so2023571f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439673; x=1751044473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlBAvJidlTd0lWKONZB4JfLwR/GbdHPA4nQcc8Yttvg=;
 b=BqGK7QmDwCCKMwxQqWD4yRAXMCvOs50aF3s7bA8pE1qWuDifVsLglFLhr5tPHhlAlb
 wQTGdR8s5vl1GL1uy6PQ6l5Dq/3YbbigvWwbZPL5M7xzTHnMHxs7zJy6Dd1/h575I2GN
 f3GvR6Uzjzx5W6D7/5/izeezZoI0lMb2traNoA20bg5Ex/aJ8PWd0wG0ZncBJBxj02tm
 SAcSjU6VHudXyZ65ZCnE5YOXbHQ1rluUzDr/T1i/iD1bHqWBuDbFogPO5wk4CUwuO0c9
 Fp5d9mS6br0gYy+1h2/CILDsx3OZstm6KrBMWg00nnGoPamN2BW74EFGT/qZdGdgfo/V
 y89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439673; x=1751044473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlBAvJidlTd0lWKONZB4JfLwR/GbdHPA4nQcc8Yttvg=;
 b=JwCSC3RYa2GO3jp7R1Keyhc6kugzahubfuB2dEXuTnApwGI30d19dku/T/hv6i/TgJ
 kQg+pNYnUrchw3GocHzgEUx2e6nuQUJIBkopmBKqi6MnpaOajhVhObTHCi0mhFAvVUf2
 Bw+R34ROF7SfTbgwwPtV9lbtIatxm6LmWePIxshhAvk3rran3qfWmcyqeuPA0JmVfMo7
 2GvVOIrjo9PVGLeR8cojf10n19PmltjWcrpN3s4Oh/kjZvwDkNxSlmiUDVU8UGqqOhoj
 CdNQdXg+tNxwCdpnG95g6de8hRR5sh/N7Y5LNLF+YQ8H5e/gqjxh3s+A94gqPVU/uroA
 4HfA==
X-Gm-Message-State: AOJu0YzKWdv+R+UayV1TqFloMSxsai5q1ceViBQ5zREAfquNJgGeNgCE
 cZvSHzGyx5kdQdrs26oR689nNEwkxyBwOUNkTsyHvmQzDtEGOBESfnR+vYOXWZm33Bj+qfgn8zW
 p6S+1jtQ=
X-Gm-Gg: ASbGncvS9ZkoKGfjVhQIASjaBcZAwEjoKBSvP6YAEg3x4DZRWJqVSTh+sz6PfhgarvR
 VkgiTEllOhN9Q0is8qqZpAC6TftsRF21VdwC5i3dP5vowSz61U6OhlCHiC1MD4Z9J0UCD6aJRUt
 OypdXV7rthGbf3wIqvJst3n2dabiaDWnZxUtQGD/3za5pd1LPOBHcflUpX0hluqEM+CLo0X/XTs
 JJB1MVpBPSsOXHvvNJl3bMt0aZC9E7YTW5uLRpUN7pqRyTyYyRLLj2IH/eDgAiGedO+4LYhaWjB
 7LIbjxz/az9LTeAq4Qaydr/c5waZ8mBJ26J3Mv5yPSn2Hpeh+0DdE7EN8Yf+a/ZgA/dIf3NGS70
 p2Pi487hjI/PfwgskHJ8bNHCH1ooDocbpnqHv
X-Google-Smtp-Source: AGHT+IG3TuoWXd+fjRa3Qw+J6xlLFzSR5o0eFDsfdGMj05AZ0OinwWxEMzGp4DHqdR84VhgVKrOaZA==
X-Received: by 2002:a05:6000:2308:b0:3a5:2f23:377d with SMTP id
 ffacd0b85a97d-3a6d1324f04mr2778464f8f.50.1750439672761; 
 Fri, 20 Jun 2025 10:14:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f17c35sm2663454f8f.31.2025.06.20.10.14.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 10/48] accel: Pass AccelState argument to
 gdbstub_supported_sstep_flags()
Date: Fri, 20 Jun 2025 19:13:03 +0200
Message-ID: <20250620171342.92678-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
---
 include/qemu/accel.h      | 2 +-
 accel/accel-common.c      | 2 +-
 accel/hvf/hvf-accel-ops.c | 2 +-
 accel/kvm/kvm-all.c       | 2 +-
 accel/tcg/tcg-all.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 39b52adc9cb..2831e61de08 100644
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
index 6a612599856..3797cab2bf6 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -353,7 +353,7 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
     return hvf_arch_init();
 }
 
-static inline int hvf_gdbstub_sstep_flags(void)
+static inline int hvf_gdbstub_sstep_flags(AccelState *as)
 {
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8f6c0bf3888..2a44d9eaabb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3974,7 +3974,7 @@ static void kvm_accel_instance_init(Object *obj)
  * Returns: SSTEP_* flags that KVM supports for guest debug. The
  * support is probed during kvm_init()
  */
-static int kvm_gdbstub_sstep_flags(void)
+static int kvm_gdbstub_sstep_flags(AccelState *as)
 {
     return kvm_sstep_flags;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 4b1238ed345..4eb49c6407d 100644
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


