Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65141C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqr7-00005o-Ri; Wed, 05 Mar 2025 10:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqr5-0008Tg-Ct
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqr3-0002XU-FM
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso45795595e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189215; x=1741794015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm6pJ8fvWIoYf16fHvVGbN/phK9k4HNSdSWeslgNhR4=;
 b=Q4jbc19sjQr5hko3qHpe2APNeLFTCPO8Qxi66cWV+cKcTn0xf/RTXKc2p3b1QN3VQG
 nu4QfDfGxWu6D/9qQ1NBEAzL9VgtYBLaLed8mvfGCDfWTb1Id618cL8snIskq/ssH5oW
 U30f2bEiCeFpz4qqlVLZIlKX9ULn1jBs4hCGFWSLKmSxJHgKgAQle58O0TJlA1PrphPA
 3JW0uBmrKBylRxg2rJvjWt8NrH+w70ZFi/OCYgmmuIhi5m2g9feNjjeB3pYKXnzT6V//
 Bkskv14Kv1ItpJ/Kj8IwZVyWEqbNGYeeLudYd3KTTQKgggtAKQeSxm6PHn9X8RE7/s8y
 vEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189215; x=1741794015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tm6pJ8fvWIoYf16fHvVGbN/phK9k4HNSdSWeslgNhR4=;
 b=B4OclVK/unT65JvQtr8W1TceOCt4RQJ36A+ewr8fekJToCTjUVUxWv+ymcuhEK+aui
 +2KL9SoceU5n+vFrXYIaR5S4XWbvzSkYVi/UK4DoQOy5MhtkRkqeFinih4ZJJMSeJ6gk
 kDdiPAJ6wanBKhu/LbKyYGm5BqmlRsxzeYzY/e5whPbD5PfqlIK4UHQVKzyIQomBv/sq
 LVdBY0sKeF3HgmsiHmeSDDuKvDsrzgvJkgGApSY3oU7ad7X4WML6+OqVqzKa8zoird86
 g+WEqb9mau3vWpp7dp51OZTHh2AAl9QP/JuCWEjco8HRIdCiJ/YzxkIJ2vSKtptVUNFa
 wikQ==
X-Gm-Message-State: AOJu0Yzxaz6UumBPDzAPgDIC1qU1xU3wYspodj5ofNBubJM98c2Zapeg
 ExF3C4+kvwsa2ZyKOrqN4tzy2Z3wUIEY528vxnS5t/XSHjLR6DzpKJzK7vJHdfT3bBDvFqTg9Gr
 Eoec=
X-Gm-Gg: ASbGncuVoZVLc/Kps0dPIJX6kv5ESz+jpUP9CDsUk5bgSZLL3amBBcTcXjXmu9CQJav
 QPZOXN90iZUz04Y6It6Z8eUfr5ASegYQ8AY4PKgbOQbIorz0AY31csSjs9JsDI+PA40Rs4MAN2R
 vRFiHIE5gaigsYsQnTRmG9V+cx/NzMPQEF9bhpIrAQvU6BAXPAhdw2G2+Aq1WU/SigUk5j2hLz4
 7glpHVVb+0WAZzMhC9mXnNFliUDQDw9MKvRcbhZwr+Ya62VDR6th9XX3kz0w6XNJ6gWbrvlA4h8
 LyMQMS6e8qv7IPD9guZxf7mhl3B37WyyciT97SAcv8LWL02Z0k8iZVAe15IFXYM9sjdBpAFDDR5
 hcHogBnbWKBb+WnfS9hA=
X-Google-Smtp-Source: AGHT+IEpmqmnKdMSOtUJeLzOByuvT5O+r8pr7oNhVOjKYGTHuuYcRPHjLHAdaBSWCJiLUmWhQvS0Cw==
X-Received: by 2002:a05:600c:444c:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-43bd29c6a29mr32248475e9.11.1741189215238; 
 Wed, 05 Mar 2025 07:40:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42e51e8sm20650775e9.26.2025.03.05.07.40.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 09/18] hw/ppc/mac: Replace TARGET_PPC64 by
 legacy_binary_is_64bit()
Date: Wed,  5 Mar 2025 16:39:19 +0100
Message-ID: <20250305153929.43687-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
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

For legacy PowerPC binaries, legacy_binary_is_64bit() is
equivalent of the compile time TARGET_PPC64 definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c | 9 ++++-----
 hw/ppc/mac_oldworld.c | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..60cca313b10 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -49,6 +49,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
@@ -581,11 +582,9 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sungem";
     mc->kvm_type = core99_kvm_type;
-#ifdef TARGET_PPC64
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
-#else
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
-#endif
+    mc->default_cpu_type = legacy_binary_is_64bit()
+                           ? POWERPC_CPU_TYPE_NAME("970fx_v3.1")
+                           : POWERPC_CPU_TYPE_NAME("7400_v2.9");
     mc->default_ram_id = "ppc_core99.ram";
     mc->ignore_boot_device_suffixes = true;
     fwc->get_dev_path = core99_fw_dev_path;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..a8515778e2d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
@@ -416,9 +417,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
     mc->max_cpus = 1;
-#ifndef TARGET_PPC64
-    mc->is_default = true;
-#endif
+    mc->is_default = !legacy_binary_is_64bit();
     /* TOFIX "cad" when Mac floppy is implemented */
     mc->default_boot_order = "cd";
     mc->kvm_type = heathrow_kvm_type;
-- 
2.47.1


