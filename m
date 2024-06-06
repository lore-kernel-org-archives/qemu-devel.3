Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643B6C3DA40
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCQ5-0001JW-E9; Thu, 06 Jun 2024 08:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPv-0001Ey-Lm
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPt-0002R0-Q3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3550134ef25so890087f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717677628; x=1718282428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpuRJxgqfBz76ap36ezT/qPPBflhAp2VI9pF8aWCMBk=;
 b=ZvszW2wq2cGkM0tF1CJvYA61pGIqaVQol2vGuTDTw2iSKCkbza3OtJSRKZM5gxMTVO
 XlYELAAykKP3LEacnDQGYIMdiIIzEKQ+0BBW1Ia5cL0yJsF6a6qpq3lmpVQHzRvKyBSn
 lUVEJMrk8ondOM7rwbOfuWZUZG42pmTSKXKvO7Z2pDH7VubF5/E/Nnl87SbVKRV85wBh
 wwBg4FuWo3tTlqe1u7KfDUoowdbHFFPm/ibSgB9SC/eDqDWonaEwLlR7drugsDDj2rTO
 PGlTa0ANXXBIaMYxyOdMVCxPQaO3O+JcERkni5day0nAkcjJ8j/kSvXx82b4+/7UmCV0
 pIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717677628; x=1718282428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpuRJxgqfBz76ap36ezT/qPPBflhAp2VI9pF8aWCMBk=;
 b=e4nj6BSignhZUvU5i7D6ks0heCCyp/EEF4jCbx4wUrtRey6VzlYsFSnuo/LOK4xD++
 7SS7Ka2BoYvzbWZmppRHHws8W/gB/LRE3bPTpYW3ZEZYwzblErzfVvZj0nZdM3UiJ1ix
 J/1fg//oR/iQ/6Hc17y6nWL5cQ8/N+O62jCQxuj14ehujNlkRPvnedM/2/rf3rMb6RNB
 3BA99Gs0by7Q+KQXkhpKOuacnrnnp5EfSTB3lw33Q7flJtDsAnbAYM1aNh5eotQk9LeL
 GBWSnwb+kmvUaTOuU0o8XnFZ7ln+68kRifoqO1Imyc0dLWdVbGigs8StO03MZq9F/ERf
 W+OA==
X-Gm-Message-State: AOJu0YxfKtONHH1UnAiEuVsTGj5u4CghvL8BRWOHDsu7e2ukw4EzHMIv
 HhX/ET7CNGzLfxtpC+0IZHzgjx8eksTaS4kNO4fqeuDD0ijmCaGGrOyy9PoLw5t6SB1VZlmjxPW
 m320=
X-Google-Smtp-Source: AGHT+IFuHw7E1VkMs4wnApDm1Dka1VqP/g9NpKqGxAapHKxEoAHRhUuhso9yeNtfYqmoIEr4ttBqZw==
X-Received: by 2002:a5d:59ad:0:b0:34d:990a:e4cb with SMTP id
 ffacd0b85a97d-35e8669bd34mr4615057f8f.36.1717677627792; 
 Thu, 06 Jun 2024 05:40:27 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d6985csm1461911f8f.60.2024.06.06.05.40.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 05:40:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/3] plugins: Free CPUPluginState before destroying vCPU state
Date: Thu,  6 Jun 2024 14:40:09 +0200
Message-ID: <20240606124010.2460-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606124010.2460-1-philmd@linaro.org>
References: <20240606124010.2460-1-philmd@linaro.org>
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

cpu::plugin_state is allocated in cpu_common_initfn() when
the vCPU state is created. Release it in cpu_common_finalize()
when we are done.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/plugin.h | 3 +++
 hw/core/cpu-common.c  | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc5aef979e..af5f9db469 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -149,6 +149,9 @@ struct CPUPluginState {
 
 /**
  * qemu_plugin_create_vcpu_state: allocate plugin state
+ *
+ * The returned data must be released with g_free()
+ * when no longer required.
  */
 CPUPluginState *qemu_plugin_create_vcpu_state(void);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index bf1a7b8892..cd15402552 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -283,6 +283,11 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+#ifdef CONFIG_PLUGIN
+    if (tcg_enabled()) {
+        g_free(cpu->plugin_state);
+    }
+#endif
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
-- 
2.41.0


