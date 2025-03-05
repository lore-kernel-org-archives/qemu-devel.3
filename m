Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253EBC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0Y-00023C-7O; Tue, 04 Mar 2025 19:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0W-00022i-H8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0U-0007V6-PR
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43996e95114so42360525e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135985; x=1741740785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4ACuYCqam8wBvbr9CPnjgFj0qVd0d3ZVp9SVoo31vs=;
 b=bfvpaNxgnzoXimRNGYRK/jwmFb1W+Zw8Zncq1IvUILgLcpc+WOxWX0ch5BZa8ScIU7
 q6fD6ZZwqY/7zM6oFh0adsJpNIjkGGtjuhtrm2RKR+H5OCm6MWRmT6dx+BdCX85nOzz3
 Fv+LEc6lBwYEGJN1Nf+MakqcX0ZQln2r7NvO/GuMt1DlcvIRvI8gjArEyfSa9CU+XoWQ
 9RDSh+XLlrXGvjX8NAS5Dvo988yx7NjHqADI9LkjeEP+Wjo3r30978f6APr1vkYCbExm
 SutTPxDspJFcBd2e9OcninKs0ZoK+yZ5Z57qLtSR5lgwlivEigWCGkcINdOO6gX0V4Tc
 N3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135985; x=1741740785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4ACuYCqam8wBvbr9CPnjgFj0qVd0d3ZVp9SVoo31vs=;
 b=hE2gegXHrTybNPgyrpr8BFFCTYp5UkNd9BlsxaxGmHMD/hP8SPQLjxqrVS2EW7izan
 ohFZDR1GlcNrz5F362jCz0ol45lzo+Nzm8/h3k7GTDVPNi1sG57qaog6G2/vU0Qkr9MX
 VdXlZok7XRUz2IouOkrO2c2Cg0DAeeq6nAcAdC57Nd3SSSuothaP31+VJEbO3Zct1F6Y
 rLrZz8GqF4oO7okQy1FVNIG/wP1Wz2gAAsn+FENVZz6dzarMWVMYIH0jutlQJKXIAE/K
 Gi0BM2KardK/tVJxRxhT0LxlpINThsj9bq8R9C1SA+lWAGpxuargB5nzpq/Blmm4f1wU
 wa2w==
X-Gm-Message-State: AOJu0YzXhQYKaP/7umdrjzXsn9k13wNReGAdG7FvMyAXZ7JnCjY22dWr
 E9hkodSUTbaS/1XVQoU0Ntfw2QWrDJ/RCCmVGBRG+Bz87cb6vEmmevhPD2ffctK9FS52y/sGUVX
 W71s=
X-Gm-Gg: ASbGncvIGpp4ajjx1FWQqHbcMs7uv6+T8ZwJOoiNmiDTpvgUj1Pu7gcyo/uPJ/QcqMq
 shuGmhnjKIGUsjvh9iqCGP2DC5Y7Tn8vnoNG+XwDh6Ng1gbsz98bU/2hjQgXcQij/ibtAgqhc1H
 7vtyuR4nJ/dqvJCk3mNAxh53IIl6cdruTPlQVJcvI0591B7lefEPOnbe04jtiY1Isrf2nddFAg+
 9UqxPf4rETB2j09c5dhDIKsgK3nVaaG0ZBgGtKSKlShGtgLxGLH49OAlrJMHkWG/MejIgAo6iTg
 /blSL9TACXxpU74qes6eXWnXzzwJP9HBsNKJfz4DXi8NYBSJKALobwIO9ALNoUKcibaxAKVUWfC
 yyVWhF5pgKXOyGaoP9lc=
X-Google-Smtp-Source: AGHT+IEefW2WBDmlXH1+AXHDBr1xDeUwcHJn4pfRv90OCogFE2mTqF8oU3YQSbzUUd8G44JT+yCVJw==
X-Received: by 2002:a05:600c:4e8b:b0:43b:c0fa:f9ce with SMTP id
 5b1f17b1804b1-43bd2955621mr5504105e9.14.1741135984903; 
 Tue, 04 Mar 2025 16:53:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292af0sm1523095e9.12.2025.03.04.16.53.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:53:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 07/11] plugins/loader: populate target_name with
 target_name()
Date: Wed,  5 Mar 2025 01:52:21 +0100
Message-ID: <20250305005225.95051-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We have a function we can call for this, lets not rely on macros that
stop us building once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 99686b54666..e56c1003c27 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,6 +29,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/plugin.h"
 #include "qemu/memalign.h"
+#include "qemu/arch_info.h"
 #include "hw/core/cpu.h"
 #include "exec/tb-flush.h"
 #ifndef CONFIG_USER_ONLY
@@ -297,7 +298,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
-    info->target_name = TARGET_NAME;
+    info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


