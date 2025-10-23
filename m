Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7998CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw4v-0005po-Fm; Thu, 23 Oct 2025 10:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4q-0005oh-Pw
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4k-0007Na-JK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso684008f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228836; x=1761833636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq0durEu5s44u22O42W1RyuWwO721rs5WZGhnt3B+SU=;
 b=d4BZtO+HsqMkhWpabsJloHcSh7f7RNK+M9tWIdfdyVATk2xYet8yKuEu53a1hTONEz
 RXMFQ/SDCxgPkE2ZLkdb+I6lwxOneYbLmEswQrvmBSeeaoCJscBKY8o+aulDPAl+3B/j
 V/su+x/r1nDEMNHSGjEQjWSKgBXrzilrvqT4XqobULotg4Lk0iomNuaoLTNX2pPKzP6w
 pBWdTX6NRgR40hL/cuQXvY63w7p5d71EPb5Jq4aMb1JV9PEgBbqy8TLxChgxNCXXUS6l
 fm4sSAJFSklo+MwmvI9Ft0JS2CG0oXWE0duoTG1BgUx2IY+fojt7T7iAFqMhoCiu/WC0
 XH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228836; x=1761833636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jq0durEu5s44u22O42W1RyuWwO721rs5WZGhnt3B+SU=;
 b=kCddpP4Ouemyuh/2YmnvupeOnUCdkKhwoOUhgMUQ1DSFOYbo/1+uRvuPmpQ/3CDmvc
 kCLgajtrfIaEGYFtxvchODb7UxipLThDe8q4bIZkUoNymTcuj1Rh0o4a6UZQGq5V4cjd
 h5/vPPQlotJD8EFxz+zc3J5/qQRIii4S8IqRJCTU82UrBT0+2hegU5W9T5vNCqBeefPa
 gQ4ibmqpjgzAxxuUj3PCrXvS/67PHi0L8kE030n5XjfPZE4ZfY2kylT01YWxJclOoX3l
 kjMILOBlBAa+elwqGYhfBhvKfqa5Ox8/m261v8NWP1RTw/TMyMS7sNuvr+gsY9KhaocJ
 nDLg==
X-Gm-Message-State: AOJu0YzqufxM6n65y9I1ikHdBU+jP2TUDsDSMgUygnUb9x6m2kKF9kkV
 LTGzkG6uazZj9suj/PBrVsdMmu5edf1E3d7niRZzVStw77+G+wGzf4JMyyugEa35T8V7dCT0TgA
 EVBn0mzY=
X-Gm-Gg: ASbGncvSXBzvsO8wwZRpQadFZrA6Tiy84c2t2z8IUU5BUcKPOdPNT8KeuHzCOO7Tg5p
 kkAZLzdnC4qmIQoCscNpY+oAQwLHlE7DQ6w1PmWLvxuymvuUxRjXU9dWBmElZM2oHHfU7fIA43R
 KiJIJBCYF2kmC1PmAgYfeMJwrQDafAZPL+H99Iz5BJfaCOHMLD8zgKjWKyKt8SF4Oj4iTZcgFez
 GmkrLloPeYEKxa2xrxR1O+0tioTC8A5fggbf8MDjvypOAajnq9Y93yrz7nAFOrFqa7zpZ2ZYbyW
 q5CYlvia5wxJ9FyVVsw4eExoUz34Ndlus9XCQ8dmCdWOonOyCCiN2C0W7Vp7GrakJhKUpKs2jcl
 boct9Vb29OQO7IdUdnai9e9MFHoXef1Yn6syIsgrVqcMzxXmVG+wxoNgijWYfr8EPeD9HjUFIyG
 vinWsK2wWD+94+Hi5lLpY53KThAZUmcte03e1fk6Pbve7YMwGZBDIXkYmvKGcD
X-Google-Smtp-Source: AGHT+IFd5QpIfAz1QuuANrs1jEzRB66EFhYBVTdort4wT4SE9A4CJ36I4Dp4JRxBv8X+cyfFmMLM2w==
X-Received: by 2002:a05:6000:420c:b0:429:8a71:d57 with SMTP id
 ffacd0b85a97d-4298a711154mr2198314f8f.27.1761228836427; 
 Thu, 23 Oct 2025 07:13:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898eac60sm4121873f8f.39.2025.10.23.07.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:13:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 13/58] accel/hvf: Implement hvf_arch_vcpu_destroy()
Date: Thu, 23 Oct 2025 16:13:32 +0200
Message-ID: <20251023141339.10143-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


