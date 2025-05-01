Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8696AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLc-0005Us-9Z; Thu, 01 May 2025 02:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0005ES-Rj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL9-0007Hk-3v
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso542075b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080649; x=1746685449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaxN1Wnwe73nlXtsILpKd8Zw9LObEA+fWJ9HYaRv6lM=;
 b=Xbqv2OmUHEPa6pfG8NDlsYaOasAEneC7887z6p0Ut7Ys7v6hRh6Ywjaagsjw7JVUHG
 b3ax1fjDYdwVIRiwf6EE6e3KBjdlPH/7bv3XEbIn3QOsm2xFH88QPT8Q97cTD8RkAo9R
 3yVnS0cEuH7x/5egf5hVUvn3xoc6ngZzhPzQyAAqzj5Z34KxEg/90JLBIH9cuISZXGaQ
 PvOdTKGfZrDfmaYn8LcOaZCIbYU/8/J6UM4P3dFIhaXvKrtBlM6LFeE3yRZB60C9U01i
 NA18lzssuKEZjd7rkrJKQJsve1cTgbxZKUwYWbGi4wk57Vgwqp4IeLzlUUsNlXNQpIIV
 4Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080649; x=1746685449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaxN1Wnwe73nlXtsILpKd8Zw9LObEA+fWJ9HYaRv6lM=;
 b=NmCeE72JUyrxXCawUy99pIjxBMGoFUAUPQ+o6gytGHM2zWAdBOwhryjTqIap0SvPdc
 Na2q2pMbZzDdpEEEumsvRSMz140VwhoqP4fKxemuP8myIHoljkubRLYMRZThntrloNFz
 4hR3DL3MfHM6lLI8lcWINMpFkhhGEoeX+etbXc7T5KJrsmpbG8AhXPTIAgzhME5RAMjd
 xAwtnTc2Hhy2BKW4vBu655h06ljK2u+noRAudYtK3TU6fpBbWEDAoI6J7c8OCEylDFh8
 +eHwbVLbbB+0paLYRm7VSz2UxDvo6LW0s3+u+61R00N9n5QRY9/Pbjm8bWhXtIxVTNjH
 QD4Q==
X-Gm-Message-State: AOJu0YwsMAhZiWh+zAdyXvhcrww8amiwB7Ckd9KC0sKZAPV4U4E4pzNK
 jznwESaKGviW/3yTjlXgw1RqH/gLoSqg1jtyI7PaOSrnpumSKojd3gqil06on5ZUfOTcNO5eRg7
 5
X-Gm-Gg: ASbGncsvQV/ftNDC9YfIqE/oGfaKTdeqmTeO23FnkOlZcre/YN6ZqpTHDU+OqWMLxnc
 xN+NrD3GbrfCtzj4i/+i8RbcqHoSAFOzsrDJlnfTpKAxz1xIpKSz4ub6C9gjXIMi9Wnt/ngE6ou
 inCbmZiY3edvvzVDn6oMqwisxqD802M1O46kN5WdFrtW7pBIBZK5NlcMKH4Ufkma30wGJekynlF
 iYswMzPinfgOk/VaCBGBUqC+jGmSZrSVddzVkcisrL04jZVyA6HVOhLk69BrpdS+Z63boli+M98
 I3iodAZDP0UG1Til3kphTguNmGs2qy0iowo3GxbT
X-Google-Smtp-Source: AGHT+IE4Xqp2t/vPNxcm9GHqM8zO2cSqpXtBFOyo1i51a7Px1LaEZe+L/FgMGOOkmgJ2scnA9wDOsQ==
X-Received: by 2002:a05:6a00:e8f:b0:740:6f6:7338 with SMTP id
 d2e1a72fcca58-7404917149cmr2440508b3a.3.1746080649301; 
 Wed, 30 Apr 2025 23:24:09 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 20/33] target/arm/helper: replace target_ulong by vaddr
Date: Wed, 30 Apr 2025 23:23:31 -0700
Message-ID: <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 085c1656027..595d9334977 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10641,7 +10641,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


