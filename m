Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308EC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0C-0002rS-EF; Fri, 05 Jul 2024 11:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl04-0002ea-2w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl02-0001Ja-5Y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:27 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so26647591fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193843; x=1720798643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHcDwGWcAEdZtrzAOVXBblsUbX47TAsskA5aGzhGobA=;
 b=PoFJPeD0JgXi7RFumxc/DUaJralHHwJhNJxHJhu801DR4fP9nkssClfFNoU0DiJUqG
 l53Bv9pPGliTuoszMXazvlG/MN6c0MSw3dJi5Im9P8Lb/u+DAX7bKKtDV8VG3a8wklGt
 lMeXcylpnJs5h3irekQo9ooTbx1vfgt1IBpztNSkOPRZx8aM6Bbyd7Ye7bjDwPQHRna7
 ratuOqIrqd9If6RgokddrNN5HTABQOSuytc/INt13ZEXICB0EIVQJMfTnKQY+PxDEjMb
 1HIn493DlvGYYBxA+YbHIJAj7eAH7Qo6iIornp0/AhqdmS+vRt3PVJrN+47uuo5/YKxa
 fysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193843; x=1720798643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHcDwGWcAEdZtrzAOVXBblsUbX47TAsskA5aGzhGobA=;
 b=i5hFrCiHKxkhmnNGCBSe7RF+kC81cFhr55rRjzMnJ7dzDjHO/TqiWOp5BFjnIJ7F3t
 N7sHFFm1gPgIJKaYk2z2TFgnPFOYayGh8LEq7JjoVwDIxjnslq2fHJdKoIw6aeTnDWUS
 OUB/IR12FQDgaejC+HuiHUxkRI2K9fvdHSwI1ftBcSMt2GpZsNX/23GppttjuxGghOaS
 3swOPoN9793xeLKwE3dHPvgmffMnDuLHKfBK5kcFyWAtPmk0IOQnCoolUONxf1c/Fhh0
 1mE87bPKXE1THEPt9orteZDoWgCqE1obv9LAYbEGv6fdw1/3W0ZZ+8/piVHv0uqZ4OGf
 veEg==
X-Gm-Message-State: AOJu0YzDGy2DjsVIWSxkCReD9H752Cu4kANGVuBhCZTz2ZG5tYOYiokr
 XzLCRtXy1raZRbCuTilbNA1dwm5gmKou3kJ6gS4o53+Ue5dN+9B7qM0W/rMLO6A=
X-Google-Smtp-Source: AGHT+IHE4Hx2qnBGa0yjQGxGqK2+IHmHvdTnqeukx+ZK7/mErmC5np0DIHi3FPEdrALxmuNCXC2+QQ==
X-Received: by 2002:a2e:730a:0:b0:2ec:4093:ec7 with SMTP id
 38308e7fff4ca-2ee8eda81femr41880451fa.30.1720193842507; 
 Fri, 05 Jul 2024 08:37:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d0e7sm688192866b.165.2024.07.05.08.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A11D262155;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 28/40] plugins: Free CPUPluginState before destroying vCPU state
Date: Fri,  5 Jul 2024 16:30:40 +0100
Message-Id: <20240705153052.1219696-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu::plugin_state is allocated in cpu_common_initfn() when
the vCPU state is created. Release it in cpu_common_finalize()
when we are done.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-29-alex.bennee@linaro.org>

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
index f131cde2c0..8f6cb64da3 100644
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
2.39.2


