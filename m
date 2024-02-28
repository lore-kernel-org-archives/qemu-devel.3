Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CC7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIea-0005Km-D9; Wed, 28 Feb 2024 07:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeR-0004qn-MU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:09 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeP-000368-5B
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:07 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso1498901f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121783; x=1709726583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+CwTreRkCfrSZnPVcfTsMUgX3CVXEY/vFHik/E/mjA=;
 b=E6HXij9pDarR8WFjK7MfS2Ma8Lwak6J7kuk1KhJK9L4xrwj8K+6/xiF6ofPUYIveLM
 cdoV4p7xKKZRvS3OG2p5EZBbQ2uHUAAr0H5j7OwpNkHly4wKMw0EYMzAV/DpP0U/Qggf
 WwF4kO2VF1YO+nFop3VmIrqf3ittMgrrZnfL+f+2gStjIL/fNzxH0ZMU2AVA8HE8yH8O
 isf/5HiEJB36PI3Wmn0IekRV4bW/E0NsZRDjOV3tjRRRqHSvGJEcHSBUeFxlpc9EXiCi
 H83A+6TqYAp31iKcyMehcMX4R5ycf499JkT6UHxFJCXg7xWeufcf6Gmj8fmGbA7xqMqJ
 sRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121783; x=1709726583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+CwTreRkCfrSZnPVcfTsMUgX3CVXEY/vFHik/E/mjA=;
 b=vQImUcCoD2l/4RwgR1G4Lco0ejt80ESauCZRChzlyvEgWWsk+FBhHN49fSpiM2OdKq
 DskdBzxo14XV9P46m/+K4k9mPpgx1FWYRxKmTLym9sLHfd3K/IGMJLMHb4JlGQ0MZxEz
 ob7Prp7g3vLHgZ1uNX4WRt13y19iD0Uee7+ajDr1yLQckPDL8Tz+U+pEndiTJbsTjRPU
 3dNTR7tUG5pLCfcAr2pmjx8EhbDhApM60FEHWDNBVhJchw8bat3+pQFjx65cJ31W5DXv
 zHqZ+Vsk1qGBkpoOMqzk1lNM/+07nieRIUQTsk1O9WLLVVXE3U2qAQc++UdQmweqEXdu
 Jn6g==
X-Gm-Message-State: AOJu0Yy0CZPml2oIdoTFeKNl+iu9HueV5se4BpcRqu0zNIJj9eikFEuZ
 HVjaThbnvwxl7hkbVeTZ9G8WZ59wxOMpk8TUrSAYq36lR42eX8wYqg6O/vtwnnQ=
X-Google-Smtp-Source: AGHT+IFqmRJpIk0MEbGeH445WnhVyvek6ohJv4skkjMB8s+POhe5q51rTAe1t83K2uOBgEsBP13acQ==
X-Received: by 2002:a5d:6649:0:b0:33d:aa78:ed82 with SMTP id
 f9-20020a5d6649000000b0033daa78ed82mr9214879wrw.34.1709121783637; 
 Wed, 28 Feb 2024 04:03:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a10-20020a5d4d4a000000b0033d13530134sm14173688wru.106.2024.02.28.04.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5A4D5F923;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 19/29] cpu: call plugin init hook asynchronously
Date: Wed, 28 Feb 2024 11:56:51 +0000
Message-Id: <20240228115701.1416107-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This ensures we run during a cpu_exec, which allows to call start/end
exclusive from this init hook (needed for new scoreboard API introduced
later).

async work is run before any tb is translated/executed, so we can
guarantee plugin init will be called before any other hook.

The previous change made sure that any idle/resume cb call will not be
done before initializing plugin for a given vcpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240213094009.150349-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-20-alex.bennee@linaro.org>

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index fe16d0d9df8..68786360ea5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -194,6 +194,11 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
+{
+    qemu_plugin_vcpu_init_hook(cpu);
+}
+
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -217,9 +222,9 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu is fully realized. */
+    /* Plugin initialization must wait until the cpu start executing code */
     if (tcg_enabled()) {
-        qemu_plugin_vcpu_init_hook(cpu);
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
 
     /* NOTE: latest generic point where the cpu is fully realized */
-- 
2.39.2


