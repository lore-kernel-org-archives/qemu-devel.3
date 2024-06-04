Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8168C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvh-0001wo-0O; Tue, 04 Jun 2024 05:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvW-0001Sx-8y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvU-0002H4-La
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29704055e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495075; x=1718099875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aye1K/Rd4o81X/8PhiFbSTR8xpOCjIohLrumKVTvmK4=;
 b=Nzb4Zdns0rmVXzwrbPLG2/nJmXMbfxA+mYgr0GvxlzqBdY9c7kOm6/tA9/oQH+0a34
 CP1uCPOq5iaSz42n3JagGZBQ8s4HnojaqV/kRSzbHdo5E4iw7DXSC8FTkJuEaJIozP6O
 oZPRT1rpaXFdaM/FEfulCPwLijPcDqskU8Zybb9smRJwUW4zuT7TUzaSLK2wM2Wzffon
 YjupyKrZJnoPMj+gms+wcil3hUULi/fXOotOnZDTIFpFlNTSoBJgHU0z89Dfn0fzeUOa
 rHHha1uZ4zqs8vxFMZV5Qt6KPW53sGNfGPzXiHzvyjQTMRH5CIH18sOBuEDNEGEJhYAU
 5JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495075; x=1718099875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aye1K/Rd4o81X/8PhiFbSTR8xpOCjIohLrumKVTvmK4=;
 b=M4wYdWg+EN8cp0kKVRYBgHbp0DvabMSIew3RX+a4yN8zggQ7nS6C05lciby9AwmasC
 7AG08Sth79OF1ZGRQhckQEbkzn3LLSRjF3DjbtilxtzoevthlPu76h4JD5f2UrdNx344
 Qi3PmOd7/fgBwJCWd6+KD3LsRVNPQslY6ta1vQ6M8QemMbi2vm2Zz3lmaVuvWrT2XLfQ
 /Cwwi0I/i+BM5Qn+aH1RQCbFWyaSk2NQQJtAmIgaEeAUUrsKuroZAZzgd/bNPCWicikc
 FZg6Z/WPRrVcGKsNRxEEfpB7e+FNADd6h3EdvxSwJ6m1+tKa66v5A/lyf+zmmekuaWUe
 Hf4g==
X-Gm-Message-State: AOJu0YzS2ul7KREjOEnO/h3SRePMkQV9UTv2X7E+6gLC/i+AKjLBseAq
 /NYQGpWhrlJw0F1Ke/6jzZPiVC9DXoaxlgTElofFP/iwGMjVIIpFGXBigtWmKbrIKAWCESI3XkL
 8
X-Google-Smtp-Source: AGHT+IH820FPTAz8jhvDdJDxTB8ZEN2lFP7D9uhU+IKV7jKFduNrJ2Uvl4Ln9Dhh1pFrnhLo8ktBqg==
X-Received: by 2002:a05:600c:1d1a:b0:41a:1b3f:b465 with SMTP id
 5b1f17b1804b1-4212e0ae724mr95394855e9.26.1717495074888; 
 Tue, 04 Jun 2024 02:57:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421535bc543sm8948085e9.43.2024.06.04.02.57.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/32] core/cpu-common: initialise plugin state before thread
 creation
Date: Tue,  4 Jun 2024 11:55:55 +0200
Message-ID: <20240604095609.12285-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Originally I tried to move where vCPU thread initialisation to later
in realize. However pulling that thread (sic) got gnarly really
quickly. It turns out some steps of CPU realization need values that
can only be determined from the running vCPU thread.

However having moved enough out of the thread creation we can now
queue work before the thread starts (at least for TCG guests) and
avoid the race between vcpu_init and other vcpu states a plugin might
subscribe to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240530194250.1801701-6-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-common.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 6cfc01593a..bf1a7b8892 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -222,14 +222,6 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu start executing code */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
-    }
-#endif
-
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -273,6 +265,18 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->watchpoints);
 
     cpu_exec_initfn(cpu);
+
+    /*
+     * Plugin initialization must wait until the cpu start executing
+     * code, but we must queue this work before the threads are
+     * created to ensure we don't race.
+     */
+#ifdef CONFIG_PLUGIN
+    if (tcg_enabled()) {
+        cpu->plugin_state = qemu_plugin_create_vcpu_state();
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+    }
+#endif
 }
 
 static void cpu_common_finalize(Object *obj)
-- 
2.41.0


