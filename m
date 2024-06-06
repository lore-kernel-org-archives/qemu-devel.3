Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC92C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCPq-00019r-9n; Thu, 06 Jun 2024 08:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPo-00015D-NI
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCPn-0002Ou-5W
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:40:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4215c65dca2so6555675e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717677621; x=1718282421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FuIkTOE+lXFH9ZydHNxhyvDKE3guv4TMSshNohbxYc=;
 b=ZqVemX23wE05crTxwnmLpiptzQpdi8ObnGfoeoBE9CkF0xjJeHOFbth9MSPwhPhznT
 btYI6ArAnix2VgvWaAX2SJUws5TSSgTjwxMO4cXiB13CCzvCv5AZiRLj1aavw9GoV6pS
 w3QVwPXf41wjp7Pvn9Wyf50AL7dgLVy05I9iBTFE6MHi464gqvUoJF7FqMDyrCbfZexg
 k5DvV7SJDcdEmL9iFaCf5LIdQv9spNipF0FO6rgUOWB3cMihDWIEButXZqDg5b8EjT3O
 fc5YWSGoMQ+fVhebrezCCUrXI6McptJztEotOe9oii4zOvJ+XxYcRJKKq9d+RCGXVjfX
 XghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717677621; x=1718282421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FuIkTOE+lXFH9ZydHNxhyvDKE3guv4TMSshNohbxYc=;
 b=Wz1dp3Loe5MJmtPg/JDG4wVDjUffNYMYOVIi99KEc133pPRvgSv8Sn89l7Etj9GwXs
 GeiIR+oeKaoxbgO2XKg2Ix3M2FBQgV69cZi6xtcLoktEc2U3RK9ATjNlm7FOWUrA31sK
 EjCtoXg0AEQXvA5lAosvQ0n2frXBO6BolPYE+VAzlcRvEJxu1Ne1VXnUvQG2Uf1saCvk
 hBMEHrHeftGe5W0VLWkHx52q5MFjYkEXApermSPSMQiVnI8fAaoStzX/ogmDS9ek9Cnt
 MYwZuF8oWAapRk24qcce/BBHljwo+mGGCfELlUVDDn/C8d24Unu1moNjZGpwtW3RipTC
 vlSQ==
X-Gm-Message-State: AOJu0YyS6sqPbEYKFQUgOOiI/YXEATvVGo40CRBh28zgysVZO8Ei3APr
 Vb+D9KZsR3pSj0U6zPveT5JFELcO/7KxiYy6bpo6qqkilC27Ha/B/l3uKyAeIOhRlktIf/E7EkZ
 MMvQ=
X-Google-Smtp-Source: AGHT+IEDstXo/HDf8fpDQCikdWZ23e7ubX1yPRDTwgGuIMMz65cEgHLVRDLe3BUj8Gfapldv+rtW+A==
X-Received: by 2002:a05:600c:a01:b0:421:5927:e8cb with SMTP id
 5b1f17b1804b1-4215927eb54mr34917445e9.18.1717677621165; 
 Thu, 06 Jun 2024 05:40:21 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215814f141sm54305615e9.42.2024.06.06.05.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 05:40:20 -0700 (PDT)
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
Subject: [PATCH 1/3] plugins: Ensure vCPU index is assigned in init/exit hooks
Date: Thu,  6 Jun 2024 14:40:08 +0200
Message-ID: <20240606124010.2460-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606124010.2460-1-philmd@linaro.org>
References: <20240606124010.2460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since vCPUs are hashed by their index, this index can't
be uninitialized (UNASSIGNED_CPU_INDEX).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index badede28cf..d339b3db4d 100644
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
2.41.0


