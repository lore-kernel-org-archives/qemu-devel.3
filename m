Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9715BC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4c-0001PC-4Y; Wed, 22 Jan 2025 04:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4U-0001FV-Vz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:52 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4S-0003Da-3J
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:50 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so65653335e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538244; x=1738143044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSvw35u1c/GeD9pKIKqf6WHVcOBbPhJhoq/j5sOwl2I=;
 b=d5Kprf1hmbAcIK7tj2CBTj44Kwb1h2fIzgDGVgiZvPWesGLHtSQizNTS52iZyB/yqS
 sXdtZsvf4DH/mDJoyRJJGUqn+cmeFkrFS19xDN4SsDw+jTmV1AdRuwSaBI/3ix41kxtl
 1e42p+PHljs50DU8Alw/UyHpoclK9/iohldsy6XIgGHoFO+CcE/zSdk/90bpwkXotsIf
 F+UAluw5Yud6VTdTjgBq1rb6PcEERWZyVFF+N/xFzR/TzeNa0T+7ArvXiV28j8TldE49
 Y8sBhB5y/0n7ScZZ7IEur2RSHC8PWyHaVn2WyB6sd7+4Bkwmv0lc+dkf+jDZTT/4awzq
 YSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538244; x=1738143044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSvw35u1c/GeD9pKIKqf6WHVcOBbPhJhoq/j5sOwl2I=;
 b=oIxQqeQ5kh3ZVCKwcjykfeI9IWoamBUh/5zXdLNXfvwE6rV32YEzE5/ZF4VaArE84M
 1JVG4hCRPUgSiP/2124865QpWOXO512Lp+zN2Eir7aNpGd/MWeVq35sd3ElNMq+mINWS
 PyhTECY663KPlwdVEAqW+YzjhGjyhZgQ7zKch/mJO48rEGNb+EI1M0uFCIbFCeJs8wBd
 o8dnPSSQrFBPdO4TRB4t8fAs164jvyRdocROEr4/b/y79gsKIjKSjA5vlR7qMj2NfMM+
 aiE3ZKZZszT62qCg8jq/+6TS/lgOatSEuixEd94KeTw5c5Oe+aFwRzmwyxNaXm9FLbwq
 G9KQ==
X-Gm-Message-State: AOJu0YxYc7zFCob6UIQdYW76jdfQuqLnj7ugOVPkjeD0RdaFBVYZJD1L
 oqv8Y9eB+Yt5KamJ1+YvdE+5dV3pG4MxHzRW1sT4Da/yXSeLsKDNZiLODo6W6pn6nLdn6lWPeGK
 FEjI=
X-Gm-Gg: ASbGncuR5mlo3gjPCi/5zntcvX8411g9AR0DbyQS4O5hhthQGtutM59PlIGaxJj6ZfN
 fw5yf4lPRZop9LPnocfrktO4TNSkJ21dksnmW3BmV2KRpQxqoZLNa36fMbhW5faQfavtAkiORVh
 yK1NcKDmON2DAwAvVIxr7/Aw0Ey5IEbNkIfHvbq3uBMs8bDnvKTT1cFETmidSXO0MFbRnbRuMoi
 1akDfcEoa2G6hGvxk3XiKKuX57BbOgSej2t5ZMuZUvu4be5CcTQJ/zq9r5sWMpvsOb+F2H5BCcP
 Wb1svjJeDvWsv6klGsoW8Y8+5VvMfqfuCkkoFXNsJR+b
X-Google-Smtp-Source: AGHT+IHiUZIdO9A6w16zxh/DaE5cD8lYprARYeJQ+U96OYFnahGVEXjmjwj0vMVEtFkeOyFPL/1N+w==
X-Received: by 2002:a05:600c:3593:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4389144eed4mr166894525e9.25.1737538244298; 
 Wed, 22 Jan 2025 01:30:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31a1e7fsm17313825e9.10.2025.01.22.01.30.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/10] cpus: Cache CPUClass early in instance_init() handler
Date: Wed, 22 Jan 2025 10:30:21 +0100
Message-ID: <20250122093028.52416-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Cache CPUClass as early as possible, when the instance
is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-target.c         | 3 ---
 hw/core/cpu-common.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 667688332c9..89874496a41 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -134,9 +134,6 @@ const VMStateDescription vmstate_cpu_common = {
 
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    /* cache the cpu class for the hotpath */
-    cpu->cc = CPU_GET_CLASS(cpu);
-
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
     }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc51..ff605059c15 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -238,6 +238,9 @@ static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    /* cache the cpu class for the hotpath */
+    cpu->cc = CPU_GET_CLASS(cpu);
+
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
-- 
2.47.1


