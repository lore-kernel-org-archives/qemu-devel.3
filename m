Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D8C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xco-0003hO-LH; Mon, 06 May 2024 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcI-00020D-4z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:54 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcF-00023T-Ku
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:49 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so27400131fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999125; x=1715603925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxHJc/1SpfLp2sqgCrwCIMC13iOcC35tqJ/KVJcg7HA=;
 b=yyg5AJny7xRj7kPEDDqstg1Ud7nzkoVP5YNIdJ8ktWJaNZqMvJTZPqM+cN3OIrQIZv
 TFAGPUBFc+lLfmu51DEh0rL9JuWZEMNVrE+J6ebmZeEjxBeoo+lk2R8krLMVgCHuEWf6
 ap2EI5xEp+GIrOxn/hdL0T7EpmacVBD2BPulX82lsqTTcf4YzkRNIvb9koXCC4QZBaNW
 K5QIOKk9oRIgRgrxlsXDE911hNF2p5jrdd6rZN+b5rSYvALJqJ9sdEfcPxPWElgZYocY
 GBuLh2Q+GcSYMUIFTBffD/kiWFJk1THOUb+mG35tjxv3alptPH8tQnXiG5/PVKo3ZIfp
 V9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999125; x=1715603925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxHJc/1SpfLp2sqgCrwCIMC13iOcC35tqJ/KVJcg7HA=;
 b=dOMA30NK5t6z4XVauOc883WzCcOuDzvMwpXt2m7k/9FwhgtmI+0fXGcDZwzPMPl0J+
 /ChQUuIJXVfHWQWM8LAHR9SWbx0+yeMmYCN19/jDvlDNJXdAKr30ZJqRYRpSjRYS2w8j
 cJLgtozQGJxQI39xx0DHW1htartcQhT1yPL41DQv+/kWYkl5zJuosVhqGM8j0AerwST9
 nstdMk70tfygnHmm5Cjlz+hImkt0jK5+kyJVAK8WBnxipR0sua5vYhYShMmVxY47E+PZ
 Pxe1QY1Ch1MHFwCxmtnb/BsioLzwkyO2fuWXTkvt8lHvBEfEgKHVJ0khCQeQUPyMRtYJ
 5Rnw==
X-Gm-Message-State: AOJu0Yxuez9+Zux9AqwJPKZuBzKMg9KwhwJ1xiCJKoJrijw+aOJNneer
 FCv5GgcZoVTIQCUSGtFCvsowQPv/CTG1u9XiYBw534pDWUQPu2h2i/EoAGAZbPHYEuWR/TPhNzK
 1
X-Google-Smtp-Source: AGHT+IFC0LPB4olsiT3y1Bh5ew7RgDQQfYf4Nemr/FJ1CeDUyos4obzEm2Rn5CajZ7hqSlUBvZD3xQ==
X-Received: by 2002:a2e:9006:0:b0:2dc:b964:b15 with SMTP id
 h6-20020a2e9006000000b002dcb9640b15mr6152525ljg.25.1714999125390; 
 Mon, 06 May 2024 05:38:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c4f4700b0041b434e5869sm19638255wmq.43.2024.05.06.05.38.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/28] accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to TCG
 plugins
Date: Mon,  6 May 2024 14:37:10 +0200
Message-ID: <20240506123728.65278-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

qemu_plugin_vcpu_exit_hook() is specific to TCG plugins,
so must be restricted to it in cpu_common_unrealizefn(),
similarly to how qemu_plugin_create_vcpu_state() is
restricted in the cpu_common_realizefn() counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429213050.55177-2-philmd@linaro.org>
---
 hw/core/cpu-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index a72d48d9e1..0f0a247f56 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -30,7 +30,9 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
+#ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
+#endif
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -236,9 +238,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
     CPUState *cpu = CPU(dev);
 
     /* Call the plugin hook before clearing the cpu is fully unrealized */
+#ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
         qemu_plugin_vcpu_exit_hook(cpu);
     }
+#endif
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
     cpu_exec_unrealizefn(cpu);
-- 
2.41.0


