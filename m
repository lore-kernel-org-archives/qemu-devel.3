Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E74ECCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDccu-0002Sp-H7; Tue, 28 Oct 2025 01:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDccp-0002Rr-4o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:52:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcch-0004c9-9o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:52:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-427084a641aso4023037f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630717; x=1762235517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq0durEu5s44u22O42W1RyuWwO721rs5WZGhnt3B+SU=;
 b=ykC+htf39983KkUPG654TAVr7zoMc6/01ABqVBG3vcyIGDfDFntjXfddWdmYh52NQS
 +sr/J9Pr9o2fxIfh1dlt+Gi3LMLTblp+aXkXmd5SgrKqViREwA2IxSgqwjLnsTYb7GbZ
 ofnkaa49fUqBpyKjWFM/TzUwTWOztGAwnM6zI7ZUau80FlX0XAfXmGur62MJGqGD62+D
 qg32UUVGyKNb1K2l5+L14HfxZ5E6P+DCYSCf2lS+2HaN9uFBUqLkzVlk4oVqLxVWxx6I
 CXHd8rhvpDGYHConnf/cpnIsvIrVWh3ze/SAOGSyHCLvNDCnA4h/lNC3hDQbRtKHOMT3
 aVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630717; x=1762235517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jq0durEu5s44u22O42W1RyuWwO721rs5WZGhnt3B+SU=;
 b=MHDF4S/mVXbiey2zvNvWAI36G6tGaw79BGG62vs7NgsUirVPN06siLuZOOJrJGlzv+
 3rlgvGYxoZSi6hfbPbfB1RGg82mcNIBMZUd91qsN2pRFwDLjc/SonPwzDfg2Qh6shAPa
 Cr09rmlv/20J/vEz4UiR1Y9YO+sULgmUd138Q2NpsbSk3wEpOFfqXgq3Cm/7hNjmy9EV
 1vcCdhpSUmMRkE3v9fC6DH+eUqfP5psmsCAPOkVCCBdqnvfMmkPzzz/dghsM+mozVy2b
 6GZqPH515VAILZ6fi8EPwmVkrZSYoAT03YXmuZg9a7tWMGRtbczYqKarDtxJOPXC5gtJ
 fjRQ==
X-Gm-Message-State: AOJu0Yw3Yxp8uQOy5hU+c3EbGpa/0Aaoe582QCPAy+LCNlNARgDXAtim
 RZjU5rRBrSya7Top67X8XMq/xRYt5weolQuTCx0rQMymi94dWvzR8/HbiDhYbFm4IuuszSsUO2N
 KLHUtf/M=
X-Gm-Gg: ASbGncvsQMtyP1gZHIXo9cXjxi7DavZvA6Y5/85nN4NThnGtQHZwINCY59tgJwYVSB8
 Ve//RVloANYErjtwZof1kwIxDKh/XgF5VEboXMH9NEI1lgJzGjjSH+5NCu5p6zI6mxxOUh3Bn9a
 pgqpD2iyPMgzt+Od0ZYwadl9YO5C/BMh9KaA50qTxxYmB+tdkElqarnl6ssQy6zVswlc8fpsdBu
 iXSFndTe3C8SgdGXInRbYDwpgLXFRsvhJkNo8LoQJdO9KE50z19WmoR3ZbZM8sUApskc6LstRov
 yybWT5DyAri6b8Z2NS9ycu87RXg/NiYeGJab+1mLArgMh5fIDSaZ3LQdlbjlaZocQwiySlHzUVs
 QSUCu5LQpd9+GurAd0PiVrcXE3BTRlKdyyIO/hDSs82UHDNGJhW5xPKemkgFA44+92mOmUz15H9
 iOgcBudbCuZjJjYM525RpCUnTxOK+Bt1PmXCUm+FQwsbLN1QBmBU86Ok4=
X-Google-Smtp-Source: AGHT+IEt3QGZKpeUZj+YqINC8k2iAUonIPVk0UMdTxMT7no1zRYMV2EzFBPJGKG/osoJCgy5mo5ofw==
X-Received: by 2002:a05:6000:2203:b0:428:4004:8241 with SMTP id
 ffacd0b85a97d-429a7e7a0cfmr1877762f8f.40.1761630716726; 
 Mon, 27 Oct 2025 22:51:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb20sm18202547f8f.18.2025.10.27.22.51.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:51:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/59] accel/hvf: Implement hvf_arch_vcpu_destroy()
Date: Tue, 28 Oct 2025 06:41:49 +0100
Message-ID: <20251028054238.14949-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Call hv_vcpu_destroy() to destroy our vCPU context.

As hv_vcpu_destroy() must be called by the owning thread,
document hvf_arch_vcpu_destroy() also does.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 include/system/hvf_int.h | 3 ++-
 target/arm/hvf/hvf.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 241c668795e..195d64dcf18 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,13 +71,14 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
 int hvf_arch_init_vcpu(CPUState *cpu);
 /* Must be called by the owning thread */
+void hvf_arch_vcpu_destroy(CPUState *cpu);
+/* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
 /* Must be called by the owning thread */
 int hvf_arch_put_registers(CPUState *);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0d8ff49ae15..d13ccf5508c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -868,6 +868,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
+    hv_return_t ret;
+
+    ret = hv_vcpu_destroy(cpu->accel->fd);
+    assert_hvf_ok(ret);
 }
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
-- 
2.51.0


