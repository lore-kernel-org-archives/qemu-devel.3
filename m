Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9043EC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPkzw-0002b6-Gu; Fri, 05 Jul 2024 11:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzs-0002Zq-F2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzp-0001GP-Id
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b5f7bf3edso1118672a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193832; x=1720798632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua23xrZ298Q42RDQyaYLhWTnQd77z5dPlxT8bKsVuUY=;
 b=T9OaeGVBYQU0WVa+fs/1TSFsI2Ra0XfWN6SmbU2MCwsrwBM9Nd1NUlnHgpNVo3HMZU
 /KvfSlU7pS69DQwacEeFvsNy2MnzesDOqMfSwX9N1XZ8oACPR1bYcu9nyHRT80z0TwlB
 fEtNv9IWOAYg2hve9mKiLVhvIWoN+cDejvStI+rVwzXWQmu+Jg+kBrj5Dw5lrC+55DT3
 m5QXW3lkoEP+tyQrvm0lHnQ2FwdhLMSgZLMC+vGSkOm0HvQ/72Ja/bKAwhV1mMdHiYfq
 cAjZRWnMIl5QSOuHBm79sFDE06VN5YdlbWfGhQ3/hR/Hvgui8YOr+DKps2Bn7S3iexD5
 Zu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193832; x=1720798632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ua23xrZ298Q42RDQyaYLhWTnQd77z5dPlxT8bKsVuUY=;
 b=p4D6qxljGzmHviwGs6cfIIXTFv97hXYpOz+JElLpqNZ/5QVgWiX//VxmCXGei7pC18
 EiQnG686TeN3p+ORE8OUcUZlVoQ97KuQp9JJsq+HvP/0wjG+Qd8cS2FtntMK557VSGFv
 6Rle/titkftRyBSd3NioLQ6vcRFzI/l1i+sUc27GcrDUt5SMUyuv46opGyFUcCtrzcXQ
 7SRLuMnj2iyOQYh4pQd9ud0rYGmPCTZFVge7QrDYR+nR3r9driEDtGVyzkLzgRjKZkvl
 YioO8fs6eO8wQTE/bGujc4MA+v7a5gxGZZ+yl26tvzabIDCOxEVaP71sgt5zGSkR4L2E
 ucqA==
X-Gm-Message-State: AOJu0YzcGPUcChp5U+uH4HLehFfquFbqaRPVhYGWnkkUKWWMa0YaMvHv
 W1OiAOlFZhpCHg5Z2QDjYJx4Nx6SbZSUspqL5OaA9NfcO4kCFI7bWIrvKgnLMDE=
X-Google-Smtp-Source: AGHT+IFZccrel+TFP0JVYkHmWdVeZ5dXJTaanWcRPzpZB2PkqoX9Q4At3wMRE6ZwNXLYT2CNqZAgog==
X-Received: by 2002:a05:6402:1ece:b0:57d:496:209a with SMTP id
 4fb4d7f45d1cf-58e5994eb84mr4943921a12.6.1720193831410; 
 Fri, 05 Jul 2024 08:37:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5907e4d79ddsm212536a12.59.2024.07.05.08.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 896355F876;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 27/40] plugins: Ensure vCPU index is assigned in init/exit hooks
Date: Fri,  5 Jul 2024 16:30:39 +0100
Message-Id: <20240705153052.1219696-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Since vCPUs are hashed by their index, this index can't
be uninitialized (UNASSIGNED_CPU_INDEX).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-28-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index 9d737d8278..a864275ae7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -245,6 +245,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
 
+    assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
     plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
@@ -263,6 +264,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
 
+    assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
     success = g_hash_table_remove(plugin.cpu_ht, &cpu->cpu_index);
     g_assert(success);
-- 
2.39.2


