Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9295C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YaY-000741-DL; Mon, 29 Apr 2024 17:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YaT-00073q-Mu
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YaS-0003J2-1y
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41a1d2a7b81so34337405e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426258; x=1715031058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHXjfEM2X45SFa7lWghHiE4FHLgxWSVxN2s67mkwDws=;
 b=rTNzqyOwA+JTel4VceyNXkVYa8q+BWHfOMLKG32Z0Nbx6OOnnwxCUDzmppDf89HCPR
 KSATUy46EJbh+Sc6go+I/2PW5GlWBjEuxYlS10eGYyQiIIkEHOhh8VZ3tkCTBVoP48wN
 TX2PoYtq8P1C6CB0uzN8M4w+RRAYcN2MYn5MmP1DvksXWEgg9LRMq2pL6RCSSlazpRX2
 grrxrXSHgtxRNoB3DxUqsY0v9N5WzUAFCB891nLf/WaRF+s4e2TiqLmrHCZmDqZ045JC
 7lNTQsa1PcF1eF6xTDhlS/mFQLh/WoJkkH+29yity2/7BW5QhvM3OW5++Vb5Y5USSW2Z
 tG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426258; x=1715031058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHXjfEM2X45SFa7lWghHiE4FHLgxWSVxN2s67mkwDws=;
 b=mUPVPiTNBnFm3HgP+hk2tURz0jnYktjARcNapeBooJsEql+mnLAK5mebVwtmYzbID7
 b7YgloiLwdaJDnaHhews4oG0AWconbH76AUd/00kIVCN7J1SgNm5LThZgE+6p+kETPz4
 5dahcuO3pI5fxDg16VITDIGJDOtu7bOqSxDHjTBNIcRp/U+91BeuVnXOsGtsOCxj//1m
 sojgVtrgCwQSaNu1ctu+QUmWVdFSdT+0iagGgm6Q01xqaNaGCUoHN3Gi4pdl3UUqmabb
 Ki0s0P0COect3/hrLrakUVKfMZd/u9huVfWzjSbK8PVw1DItk2O8sYLmspIM1D5h79Bc
 i79A==
X-Gm-Message-State: AOJu0YxjLrLTu4hhKcX8oOYKlTL1aR09sr/ROaYiYKpAA46xqmBXJImO
 zCDvXP4MlWSeabEK4owTPV77frydTXttfoiuGOB8usQd5d06ezOLYNDP6IxpNFC60gSAi9UxgLU
 XbRs=
X-Google-Smtp-Source: AGHT+IEebNNb8T8cp5a53tZTg85zv1qJF+UChbmSoueLTspfzLOHBF2ccMtw42dTNjUxjktG+NPiuQ==
X-Received: by 2002:a05:600c:19c9:b0:41b:f30a:4221 with SMTP id
 u9-20020a05600c19c900b0041bf30a4221mr821987wmq.15.1714426258171; 
 Mon, 29 Apr 2024 14:30:58 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 z6-20020adff1c6000000b00343ad4bca7dsm30431276wro.85.2024.04.29.14.30.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:30:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/13] accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to
 TCG plugins
Date: Mon, 29 Apr 2024 23:30:38 +0200
Message-ID: <20240429213050.55177-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 hw/core/cpu-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cbafc79033..f2826d0409 100644
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
@@ -226,9 +228,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
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


