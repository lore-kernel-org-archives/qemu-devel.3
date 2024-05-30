Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF230C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClg1-0005eR-1n; Thu, 30 May 2024 15:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfy-0005dR-Sj
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:02 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClft-0006HV-05
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:02 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a621cb07d8fso134150066b.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098174; x=1717702974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSiuGXiCgmtxSxVezOHytC/a0n/fTNdw2YFzo1KJ2YY=;
 b=kWm70oz+mNRpjlcqKQl0qYPZ750I7cW5ssBh14uVBcA422l9x+6ilKeP+yiv1lCbBI
 N0o9BgporXvCFTBw3XRlzEqUYGd40fzMPoy3ohEHfABaNoE2Q8+EKkqrmejriksZICQo
 pofVzAGXV3rLRLwyJFiVqS/Y5mOc1amzpnGbHFXXF/AoMLnnofbj/FoUPbgYlAnVihrl
 Z0u0bGSIhzz0b8wCAzaKgHEUoQyQ90omkMKa/VJpE/cgOrGAVX25WNQ2E/HdEaaJSB9Y
 A174yqrjc1K7TtomQVyENjCswjQtkjre8wkcmVcvSxVCLPVCGxx1oDaT/mk5GwWZMVlA
 UHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098174; x=1717702974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSiuGXiCgmtxSxVezOHytC/a0n/fTNdw2YFzo1KJ2YY=;
 b=loUqKIXFGSGJOkkYW4v8uoR8JA4nY5s9iezbVebOWygMrG9KfdmQKrwbcOc+t4oNnD
 i1RI2WvKUhy4Yiqsric6whKUJenAT1cpTiE3cQzQSiZwoFjNAuEDGBV85MwjwqyANm1v
 o48um6qwOHiYpxlXDH4A9NHvyUw6OA14u/vv1EtTsi52gjrh7N1aGvgg6ykfKF83Etia
 8Tep2rXvZm7XvZSevVwZGVHBSKOixHdxjSqOP+IX7n1s91gDOKAWi3h86CSI+6sQabST
 Ud78pMzC+9Q9yJzxYVUpVac53HSgDgPkEHFdmhKvDs6VY5noS6kir3POE1bqnuWgp9Q5
 fUGg==
X-Gm-Message-State: AOJu0YxhguhVPgbhLtC6ejMvcWDz6k7Jxa/8Xx+C39Twd++Csol/j1e8
 NtLArRNtKc58261tUTp4r8dy/c24jDHNoFnISK2Ks7t7kQsa3MvnJcj5EXqWU18=
X-Google-Smtp-Source: AGHT+IGCaRuVtIWhRyQ8FoN38Rt6/VkrlKQU/oJb9EQPlJPnpazA4r4xUC8i+X5fKyvCMARa5tUTRQ==
X-Received: by 2002:a17:907:1dd3:b0:a59:ad15:6142 with SMTP id
 a640c23a62f3a-a65e92304eemr189379466b.77.1717098173472; 
 Thu, 30 May 2024 12:42:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab85f32sm7774166b.180.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F38205F8E7;
 Thu, 30 May 2024 20:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 4/5] plugins: remove special casing for cpu->realized
Date: Thu, 30 May 2024 20:42:49 +0100
Message-Id: <20240530194250.1801701-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now the condition variable is initialised early on we don't need to go
through hoops to avoid calling async_run_on_cpu.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 0726bc7f25..badede28cf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -65,11 +65,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
-    if (DEVICE(cpu)->realized) {
-        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
-    } else {
-        plugin_cpu_update__async(cpu, mask);
-    }
+    async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
 }
 
 void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
-- 
2.39.2


