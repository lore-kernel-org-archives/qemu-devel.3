Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B1C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBfG-0000Hu-04; Wed, 29 May 2024 01:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfE-0000HT-7A
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:15:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfB-0005Oi-R7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:15:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-354c5b7fafaso1358586f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959747; x=1717564547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0RstI2ICQ48tpfxpm9VnXDf4J/IC9DIhxR/LxuqMVM=;
 b=dcMG9StpP6bqiiVZkfW6cFt9GugQyg6XK40RyQgcYFgTI3DUOnHQBykzP70t3DL5VZ
 TCdUHZBQFQNb3TmcWv/A4f29nF0sl2P2GisXUWXA5uvjZhvahftHWCrFn4/rhlxQ/DFK
 +AKn3cfGgIk2lwSYeqAh+uc78IQrLSoTVoOqAvxN8F4Aj1BizVSbCjRk+ihnTeDedBIg
 qyT2NGknYGBHeyTYk8eomKnIstmxo2WBlRTCKWGRE9D8gFOltODJ59X8uCrYd0hYI6sG
 +5n7ALqzSts//fl4nsXSGX2xLLVTZoBSxaN9tcKffMdWJMP54HXCy8yA3OeOv/X7TLJb
 N0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959747; x=1717564547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0RstI2ICQ48tpfxpm9VnXDf4J/IC9DIhxR/LxuqMVM=;
 b=F1spbYZb0Pv0g3G2vF3Z66Q5Vc/soH2/3pQXk4hRblOI3WYxnd4cxD1DvOXuX+FkH9
 npoVy4JOrKiA2lFGxVq69EnHGndulxJr32HgtXWS2X4okVq6pdryRegNnBwmw3D1/aqx
 ZJQECo1/CGmtmLZqZ49y5tZoRDjgZb6zd6KFpOk34fv2JEGX5s7+NjcjuXYXtFndEYgA
 g0NzDwLSWkUY1PnAgb3rJMXKWeijYY/ctSMKswovsuIYRGMB2vtwopUo1sK0YNaAgu3i
 mymFF7xB7gLaFV2roZnIhDXrpkwKPzVmh+ythvd+XWNp8FDEii6atW8Rh6u79z7YpK9i
 Z57Q==
X-Gm-Message-State: AOJu0YyFTE+wl0umdN1xQP/FncDnHIP1qVodMMlRuFy0+l5lYM0b1hZx
 TDVbRM2DI5NDHarCfvekzYKwa/4FBul1MV1IRb+SEcy90vQuXO/tND2b6x9fTQGAeHmz8RNbYqh
 b
X-Google-Smtp-Source: AGHT+IGQCdV5JgTtxsJqMalBsUI/5BYosFu1SFbKV8PngGRPz7N8etjGhzYITVORAB4TD8ku/EnBYg==
X-Received: by 2002:adf:f1c9:0:b0:351:c934:e9e6 with SMTP id
 ffacd0b85a97d-3552fdfa7a8mr9503971f8f.64.1716959747484; 
 Tue, 28 May 2024 22:15:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08acb4sm13592020f8f.38.2024.05.28.22.15.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 01/23] hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
Date: Wed, 29 May 2024 07:15:17 +0200
Message-ID: <20240529051539.71210-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Similarly to the commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated",
deprecate the 2.4 to 2.12 machines.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 4 ++--
 hw/i386/pc_piix.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 40585ca7d5..7ff52bdd8e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -228,8 +228,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ebb51de380..02878060d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -742,6 +742,7 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
@@ -847,7 +848,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
-    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0


