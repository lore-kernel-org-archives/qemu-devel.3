Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF877C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UL7-0003fd-3L; Thu, 03 Apr 2025 19:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UL4-0003SJ-AI
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UL2-0000q7-HH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1691082f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724271; x=1744329071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKGy8JhI6ob8SfyVJdxSCkVoOViZwD5dSl2Ral6vICI=;
 b=fCj6JkODrrWg6U3mAdAb/2LVvYNSZndTloORReq2PoHcyrTMLbVv+H/BAsR3AzqzpT
 hF3KVZm+00Jyo96zSm7Kd+fZS7jAjt6GwLDktgwFL6OfIs8GOjyoVcZUFDGGVNiX7PYV
 EnQwFG1tiVX5XZNiD+eIDoxNHTxNvhAMjVeDDFiGRceDlHJWUhORMifKxBaq7a0vaqx/
 flTsI5xmasPRH+18LbWsXob72wdpa/BRPRYLmL61Dr+w4lm2NJFgYRnfibZgKtJbTH0Z
 KYhCzjsfC8W3nI77TtNeo7fZSqKxrAC21nkAwL2rflpRY4KTNLhFSGNNiS2JbptsxnIw
 Z2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724271; x=1744329071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKGy8JhI6ob8SfyVJdxSCkVoOViZwD5dSl2Ral6vICI=;
 b=NKSwmOKTjoBK78ckuRnb44IW0dg7zHJj7EnSB3RZPgvxhPYyhiuBMerEU43cU+iUEl
 V3mlw39fG4j2xHALi0pVIRe4QG+4uNoFdOAEPoqiIxh6Jq+J5MqPJaCNCdu1xbDCg1a6
 zvb2UVoAMDsK1+R59/ip+UE+PyMAhcPObyfTybbBy5qCas3k9iU2cQW2IGmQLwuwZjmM
 7VmdT2ZAZClqbNGNvmy2VlV5OP28JvxMK8qa0Zf9RksrjusT0/bywmb2i5nTQGOkKK5x
 isfBpdwfN+wU13hGiCOqIcoN8H3l7QruEILLOexpbmvWE/46HTpvB9y5w5L0dFuATKlg
 Zk/Q==
X-Gm-Message-State: AOJu0YxD/OMfu6vRxJXEp8p8s/638weisjObHZDzSNFwaoBSImqhoVfl
 hGK2fmRXVxoOdCqbyZGpWpF8dZNfQZLcMxaHwlgeSu5NQPsgOVJm56Mt6Qh1BS0S671Ay6xsww3
 N
X-Gm-Gg: ASbGncuSEfuYn1atMmJdVWfx2FILaFR4j9lWTtWHzeFzaHiEZYHqgMz2VS24KpqiWr0
 3imXCJE+9LSxHKj5pZqfDYfOg/ayviv3krnpgZf2BTHyE9DNkLVKyycMZirnC7tTnbTTS8pYuO0
 HUZiftY3l2/+R/YuRkCxXKmTDn4noVLCEW45MOxOi+e8em5c4xxL+K0oktoh4cmXkZVRjAfDcmX
 yoNAF7+fjOvUCq3bDxyheetRkhx4S4p80nC3scoX4jwI7rRGsXr8nqb/+zlnqXqW/7XUTZ0l9+G
 xExAb03Y+POgzJhbgPC9nowmZUAPPUrSlDS0KoRDQjE1bHilzaiLGNa7A0HLep2MkOpijQSruua
 tFtk3V33uZyGwC92tL7A=
X-Google-Smtp-Source: AGHT+IH9pYQ/eycg0+3qeoIp0S8wBU4sHQanJq6spe9WlrHk4bgELL3vuGU3HHdx6sMTYfmyeV8ebA==
X-Received: by 2002:a05:6000:40c9:b0:391:48d4:bd02 with SMTP id
 ffacd0b85a97d-39cb35ac875mr821882f8f.29.1743724270746; 
 Thu, 03 Apr 2025 16:51:10 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3009680dsm2926099f8f.7.2025.04.03.16.51.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:51:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 18/19] qemu: Prepare per-binary QOM filter via
 TYPE_BINARY_PREFIX
Date: Fri,  4 Apr 2025 01:49:13 +0200
Message-ID: <20250403234914.9154-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                    |  1 +
 include/hw/boards.h            |  1 +
 include/qemu/target_info-qom.h | 14 ++++++++++++++
 target_info-qom.c              | 15 +++++++++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 include/qemu/target_info-qom.h
 create mode 100644 target_info-qom.c

diff --git a/meson.build b/meson.build
index de9c9dacd35..b93253166c8 100644
--- a/meson.build
+++ b/meson.build
@@ -3815,6 +3815,7 @@ specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 specific_ss.add(files('target_info-stub.c'))
 common_ss.add(files('target_info.c'))
+system_ss.add(files('target_info-qom.c'))
 
 subdir('backends')
 subdir('disas')
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f43ac5d4d..b1bbf3c34d4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -7,6 +7,7 @@
 #include "system/hostmem.h"
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
+#include "qemu/target_info-qom.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
diff --git a/include/qemu/target_info-qom.h b/include/qemu/target_info-qom.h
new file mode 100644
index 00000000000..c87d47acf66
--- /dev/null
+++ b/include/qemu/target_info-qom.h
@@ -0,0 +1,14 @@
+/*
+ * QEMU binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_QOM_H
+#define QEMU_TARGET_INFO_QOM_H
+
+#define TYPE_LEGACY_BINARY_PREFIX "legacy-binary-"
+
+#endif
diff --git a/target_info-qom.c b/target_info-qom.c
new file mode 100644
index 00000000000..6970b95ee0b
--- /dev/null
+++ b/target_info-qom.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-qom.h"
+
+static const TypeInfo target_info_types[] = {
+};
+
+DEFINE_TYPES(target_info_types)
-- 
2.47.1


