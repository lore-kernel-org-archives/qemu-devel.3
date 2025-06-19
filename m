Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B50AC7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5k-0003eZ-91; Thu, 19 Jun 2025 09:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5a-0003bm-9v
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5Y-0003us-J8
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453426170b6so11657685e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338835; x=1750943635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyPjw/EICSj11C7UIftsbx9d+1RqLVuFlx6cdDbkp90=;
 b=gr6+GD5+OH3NlGnZnhU47urC5+DZB3m5ANhI7H5Ie6P1oBz64tpfPjizGD56sO49wb
 V08g53PAVJUduO29g3NmvLYwzlSOUq4aKph9ByjYn1lBcMWk2Am3RynaVVCFgCcXVhX6
 bWKYl7K3hBINvku/pSvgiWOuKS9Z3FhmeVlOmwp2y/ZwNS+TD6WGdKxT74ZZEXX/3Pn1
 3j7gP5ZhrvssGtW5QCa0SbXG7gD1oFx3SeFYoHVckl12olUSBVvAtApvXwwVfDYL176Z
 PUtvPLeJh0L6MttbAdD+pizk78iXNXrstKW/Cb/rPkdWWZW9MzDSOyT+PwjvmSyJJNfc
 /B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338835; x=1750943635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyPjw/EICSj11C7UIftsbx9d+1RqLVuFlx6cdDbkp90=;
 b=OElqdxpnMvQQoopYs3+V1rUfUJBdLzvfUZgoSwDKt+wAO4yHaFjd3R0cypAw8qISUm
 2Dvb7Kx8PcYsVfHlxt1mbL93ib/OMdN/bcDF6FxI4JU9nCauzUQUHWCHJ/84E0iS7Bk6
 LtFhXh40q+JqlndrKz8dMHgNSc+RHrfljXUSqWtzKGgDIHUaXZG0t70cj2tlJKkMrMLn
 fFjPGIQzzUoW8hLxVrUDOVRA/cYx2oyyx5Xsl8COfCFcQWySsduUKjb3b1yB5bMQtxFC
 O+U8S6gBx3fEggtIo9QcM1WQwOnv5U8C/n9ueX7U8zoXaQKZVCLzvvXe54t47RAAedAK
 zp5g==
X-Gm-Message-State: AOJu0Yxz3ng2H40ssaQHP3svFkiiFPn9JUbWVflnnwaX6eBX1DBmhto8
 gphi2EIJrNXehWVEjL2vicNr42CIQLDVwor2ENYO0wpMPErJKyTkClbAnhgriuR6qisx6uME+YB
 6yX2YCVw=
X-Gm-Gg: ASbGncuYxy8i6zti0l18IpxFF9Rmy5SGNv3yjHNOVmRLSZC+9rPtHCTeEJZnoyVIBQk
 e1cFvShkYchNj//b1+QHbikembxl5otfj4e2JMnvhl+sxpA+hPj1qZlquTtYzo1VtT0BaGVY62z
 9tpKMynyJXDYhO5ENeKcY5Ptu84BhgZPKwt0sfqyERDXa9KGz9zbw2qT9oNv0WoD/lUu0tle4MC
 hyz0CjrkUEywu4ukDUQCbEs0LvoHk70sTd8hdrXqUGDM5pehpx1NoMtwVt0LiJmDCL8mqUDJmr+
 DDQHc1lqggh02rpxZlvur8bx8sIM2q7h4TlAtUvhRysFcvI8hivlGwcE0Y5mfhetLetk+JarSCy
 Jhrw67N4WcdJkOoBmezlwNg6i7LOyJYHm6IUq
X-Google-Smtp-Source: AGHT+IEjodew1p2iOcXaxxRKozUpoGn7RLSDtMkNBt9kEo1h6AALkAFYm4aB/mN1Eoyo1pNh3qgXcA==
X-Received: by 2002:a05:6000:2210:b0:3a5:1241:afde with SMTP id
 ffacd0b85a97d-3a6c9692af0mr3671381f8f.9.1750338834779; 
 Thu, 19 Jun 2025 06:13:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08c7csm19792341f8f.50.2025.06.19.06.13.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 06/20] target/arm/hvf: Trace hv_vcpu_run() failures
Date: Thu, 19 Jun 2025 15:13:05 +0200
Message-ID: <20250619131319.47301-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 10 +++++++++-
 target/arm/hvf/trace-events |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 30dfd97bebf..1ff3ff7b91a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1914,7 +1914,15 @@ int hvf_vcpu_exec(CPUState *cpu)
     bql_unlock();
     r = hv_vcpu_run(cpu->accel->fd);
     bql_lock();
-    assert_hvf_ok(r);
+    switch (r) {
+    case HV_SUCCESS:
+        break;
+    case HV_ILLEGAL_GUEST_STATE:
+        trace_hvf_illegal_guest_state();
+        /* fall through */
+    default:
+        g_assert_not_reached();
+    }
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 4fbbe4b45ec..a4870e0a5c4 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -11,3 +11,4 @@ hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.49.0


