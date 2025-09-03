Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064C8CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkVw-0007ek-5M; Wed, 03 Sep 2025 06:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkVt-0007Wj-GI
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:14:49 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkVq-0001O7-Ph
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:14:49 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61cbfa1d820so12646914a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894484; x=1757499284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yf4kdomIxvqW13orl0RD2fI/Yew6aBRirZc6xfkUNAY=;
 b=euFLi2Rl6bGdQ+TlfY/+Irb984M8dd/SWxoHEtMhJfQogGDW/Z5hdmkJsYT4UGgbNi
 pgUt3n4WUO/w2pNS72/gvhLSQbWikxsPV0F83Gj09XpJas12Ts/P1kw3DXAREnU00bf3
 /sIm3yq9VD2KaXs+jEN/ZEBDg+D6V3ikzQ3JiK5YOSptMqYRjaIeVBLO0evRs2p2XE8Z
 8RSWBgYvr46tnaChlzhXbXaVf+h25AyETcK3VgPx0RB9dPPu7JMi5nVZT5UfkYSCzgNH
 8ChidUNpZZtLRuDXZ+A0w/GWnmGYOUmazFBi0jGv86DQixx4x0BXPDtnyPN2u1cs0p/c
 ouNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894484; x=1757499284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yf4kdomIxvqW13orl0RD2fI/Yew6aBRirZc6xfkUNAY=;
 b=Cr8JMEYMz2Alt/cV1WpfFqLUEV4pBoXPOPuLz5IO633O3pE14VWNcDAZIlUJKNIXmh
 0hjaI6GRvjMumk77ZhKx7lNo4Dq2440OSMS37AFiTWu7nhjpi0YomUYlbcFJemB08xVB
 YuDA/Fs0wqObp9CVYkKwHB1Q5p7Moe5YL7GCZgaOh4X0AHpk6vOErHmDBfWqv7qV/oF8
 17yiH9VN37AFOYcmSNE2sSma+4qbg0Pipoeco4XXHxQziyoTEJh6+7w5PEckpRENC9Eh
 nO+HafU5g8V7vLwHDNSWXLINQITnfJ8VipDGdhcxHYWCqUFplsAp663do231DcvtxKpB
 MKJQ==
X-Gm-Message-State: AOJu0YxpcIrgHPwDCmaJMuk8WIHZEnQJgedP+Zf1KOzejEoeteF7QI2c
 7o8fsndBx/DOQElSaRjAaNfWJdED22Q/ozkD4/PLNPDZe6DqBsMQcRwporGSykEaJ+fXgUQM+Pu
 QSo/estw=
X-Gm-Gg: ASbGnctefbqlZiKHs9wPNTNzUCdYIcMonoTayk4+0cYTybx/Xm6bykZp1InUhna4pqZ
 on0iufFOaoHfIUrNZi350jcDN3T05IYmpbWRikxZRVtBPICVr/vqvf70Nh5zrHvfZyaIef/+HoM
 rW5ALWH+D/+QA9sF91keZHM9W7Wpq7bsV4vrl3kK54rj93wYbTZDeoOnUKsoZyxxxbBQn6S6G2l
 sTO9+CL9jf1IQyJV44nt+MsWe8MJ1AuBEGimv/sFL2nG4Lx/qFGz6XqYKfZYIYYGTnB/GVbceSX
 u3viMFE5C2lbRmqugjtjVmw78uorLaC0dVEFKEpAQMp2kjPpNWi/Cot0ytCCUjBGoMuw2eZ95VI
 MQu0uYOLQg4Dcu0/EikBlLiVcWwHPHo73gkCdxCMV/qG3jbRAKfd/zJwMdpRiecu1EjhwIojTKv
 0e2MjV5TlIplfszcMd
X-Google-Smtp-Source: AGHT+IHQOgMwHD6oDDKECAt5zmKDDOUqxGnAqaTm4KCbQto5aqr8CIpnQHtWWtxQVCkwUEfEsfRmDQ==
X-Received: by 2002:a5d:584b:0:b0:3cd:4ff9:c4a3 with SMTP id
 ffacd0b85a97d-3d1dfa191d4mr12271536f8f.35.1756894075252; 
 Wed, 03 Sep 2025 03:07:55 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d60d93b949sm12824030f8f.2.2025.09.03.03.07.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:07:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/24] target/arm/hvf: Check hv_vcpus_exit() returned value
Date: Wed,  3 Sep 2025 12:06:38 +0200
Message-ID: <20250903100702.16726-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

hv_vcpus_exit() returns a hv_return_t enum type (defined
in <Hypervisor/hv_error.h>). Assert we succeeded, as we
are not ready to handle any error path.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 5 ++++-
 target/arm/hvf/trace-events | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d67372218de..65ac0bd71aa 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1086,8 +1086,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    hv_return_t ret;
+    trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
-    hv_vcpus_exit(&cpu->accel->fd, 1);
+    ret = hv_vcpus_exit(&cpu->accel->fd, 1);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b29a995f3d3..538af6e0707 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -12,3 +12,4 @@ hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
+hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.51.0


