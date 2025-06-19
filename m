Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98586C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5X-0003bI-UP; Thu, 19 Jun 2025 09:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5W-0003az-KY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5T-0003uA-T5
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so498959f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338829; x=1750943629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koI7CnNYm2D9lEvcJSA5oXP0UBqqfZr7o8MD1iUlpkk=;
 b=rpY9D9/NtOxnELq5OePeWR1SWivWzLLPOzApNF/yiveONjyt/r2L8tV0PP1BwWGUXQ
 LGUrxCnPkGbyNRU+TYVCR1Cezcy1IG6XwHJVJJQI9hqPOKV4duidzi45qXG9MHde8yon
 JvxReAI92DYeJ7FdZ7Chk5actS8M1BUtHXmcobQ/MiDwRyMixHodSWpK5tdwDBFa8e2O
 gaVJw21le13BJdbNBSmzUWEovNeKybC82GzibF3NABSxmOGz0Zdj3o2uiWfyvElhGPvO
 5oHaZbWmpIwJRR6zl1xKL+nhlMMkbd4bHRr/8MEeQrWb8SHrYvgVSXlTvA6KbHU3vpev
 qtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338829; x=1750943629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koI7CnNYm2D9lEvcJSA5oXP0UBqqfZr7o8MD1iUlpkk=;
 b=vDHZ++nReo3bdD9o5NfvPYYqNkDATSAZFo5QzTyllQs3VQlEs/f9PE4jVGdGlzoo6x
 0SD3XvdEowTV9gY3uxhEt/MG6aDvC4+aAb9+wFrHZkIjSaInsyyirSdMhUn898U593CC
 XGoCSig3I+HPKImWgddODvDhDOp6RJVvaxAk793hhJb0vCl5xLG67qoEBwSZZNkLscbQ
 XQZd6LbBbhD5i2FGLEXih94thrA2yGrNJXAwDAJWp4ZTSc4Yoy6Fv2o70nVkmhi9aIDR
 a6ReOpfQNZg0V8TTsh20EhDRBuNw3ZQUjUbebZi1A8iEk9lxf36JKMl1l2lPAefJ6IM4
 xB1A==
X-Gm-Message-State: AOJu0YxjR89W3rKYlmPYab2rVLIqhZsmePPKfp/BxmPb8MbMrIAqDElH
 PcriccOs7fjoEO04eIUiLGey0Kb28CdOtxLq1Nb3hdnDhGr4GOTjZnSTgIuvZPUif440lono2z5
 IxCmEGwI=
X-Gm-Gg: ASbGncuG8SCnr5qduZUnMJqcDYTLUhma+7vpq/mApLsiIgCW1T6SsZsk7JnGi9C6ZNG
 MZgN6zukDlBdBpP9ZUZu+/GrzDo5yv8PcDtY10qAZLPsmra2KYD3G26LgqLhpN69e3i19mT7B0Y
 UULRO634I3p97mVpUN7DtPQflPsIwpossNdvHBHbrfAUeZTpaG4mp0YCo2ixT5HPBHm0vXFZaXt
 hUUNzAX6oP86/EBNeYL7XO7tsQkIRmM+Ck58VB7vUzNq3huSzuNJcZ1tJ9cxLEU31KfwxMkmdaJ
 KcHHc6+5qvybyuWF27nRUE/vmxpTCLPQGYldxv4bIDN2udiAmgZgmTVDaaacpDkwjVj8iPFHL9w
 E7WQEQkvhgcGMjRUfY+Lq03DSSkDp3S/JrqqL
X-Google-Smtp-Source: AGHT+IHJrzY26z4C7tz2r1whofL/rZErrzZAlc3mqjpoocixPuSsJt3B+u9kOmz8CAv44XQRwKEYAw==
X-Received: by 2002:a05:6000:4b03:b0:3a4:eac6:e320 with SMTP id
 ffacd0b85a97d-3a5723993bfmr17703990f8f.3.1750338829465; 
 Thu, 19 Jun 2025 06:13:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54d98sm19334475f8f.7.2025.06.19.06.13.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:48 -0700 (PDT)
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
Subject: [PATCH 05/20] target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
Date: Thu, 19 Jun 2025 15:13:04 +0200
Message-ID: <20250619131319.47301-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
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

Keep bql_unlock() / bql_lock() close.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 06cfb7ba253..30dfd97bebf 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1912,7 +1912,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
-    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    assert_hvf_ok(r);
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
@@ -1920,7 +1922,6 @@ int hvf_vcpu_exec(CPUState *cpu)
     uint32_t ec = syn_get_ec(syndrome);
 
     ret = 0;
-    bql_lock();
     switch (exit_reason) {
     case HV_EXIT_REASON_EXCEPTION:
         /* This is the main one, handle below. */
-- 
2.49.0


