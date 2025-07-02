Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0132C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2fD-0003Sq-QM; Wed, 02 Jul 2025 14:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2f7-0002sU-O5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:29 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ey-0002pk-Vd
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3954266f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482697; x=1752087497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=G5xbJxxSRJ+jrGaO1zZcPYBMp8mJ6ddNkVD/mU6o5/0YOxv3IgCauiWTbJLQHBOOY6
 0hu7GmDItXw1PXd1W1xaFGTD2LRCARvGx5pWvq/zIKR256/OlS3on8tDGR0EY1DyZxk0
 boS/6Z412hSS0n9Qw0EgxZt6gm+sYIxPBe4bsqtkMyVfIoBCxLNPWE2HYhyVPnkTqc5q
 nQBqCI5EmgzCkycuvLup2qjxZAz+8n9DjpnD0zF3aqQYVwGVbucspSseG3isw9/+1sJK
 Yx+qZU+67XP41qp+WZcUX/qh73WKmVbImidiv7VaLPj20sz0WbntfsEi2ai+Vyv3fT8b
 XBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482697; x=1752087497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=XeT6AVHEiNHUTtUKAJn8xARl/l9eA+BbWoxBUDVt3zqFNHJkRnHzoicXBz6YlWUM4M
 jwp49cRvdGEELd8Xwc80MMF9vdghMpj/b/9UVEwKC+N1FnN8AiQqow7oeCsjXpRvaEWL
 lMTonGIK0l2dJnaXq6uA7QHdguJFkJa0rt56jSsAUfn/Jcl75kYu/5cy8IljGBYKCnUu
 MGQMNEMqcvz39jCIkFt5zvy7VQAKv0h3ottTX0iZZnrua5iIDUoMXGTQ93KHJx81VKkW
 02pinUdYHCVCZ0UaH7IImtjX2S2AfJymgVLdJC6cREzBAmv81CS+fCUHGLth3Q5K/OHy
 f/1w==
X-Gm-Message-State: AOJu0Yz/+pH+Wyovhv1+XfvKfftWO0b9iv6FROEKMeTYhudgb3xh3TtG
 uUJk6Et4H8drwvMm3ZWgfe6e/kM3PxiXr+xKvD4cXW5vHOKg+sneWIPEoVoM8TgaJ2jsLBOFQcL
 Iz81W
X-Gm-Gg: ASbGncv40hXIVcYeC4+r9MCpoQSBTPL59gV/HAx7DD00Ou6paDcv4NUhaZNXrsONNdd
 YN8SyQzO5FS2gVwyIpNeqp1PcZhfKtD1QvDSOhjABrZBC/zRyhMlSTTMKMJ51YI6hlkD1dNtQFC
 Ec8RuQxaPh/WZhSuKMraLVhYX6O5WTxSzWJ+6/NSUkdew0znyD1mHIDzK+0hyzLMh7kJ0Jj25D7
 F3kDo8zYQfDYFBlt8cU/fcoyGpzL/L3vqKvcB4mbuKVNL+s638yMP/LNxWT5AR2YC8R7ZoSMaff
 qB1IwF59Db3aJL+opgsM5Ji3JeXVOnkXzbxdR3hiF7Hvq5juBVDqxzWv1UY0/labwhAQ0ktL9zz
 d/twjS8W3axYqVaeJ2ScvSp+SRhKpXUv5JtVW
X-Google-Smtp-Source: AGHT+IEcsxXMBUIACsgpBcHJn29ILj51paTxvpkvqfXZb0ZcInO2pdamIFHTyHwRL4J4flRJp+KVQw==
X-Received: by 2002:a5d:6f12:0:b0:3b2:fe46:9812 with SMTP id
 ffacd0b85a97d-3b2fe469879mr937452f8f.19.1751482697304; 
 Wed, 02 Jul 2025 11:58:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99c07fcsm5474355e9.35.2025.07.02.11.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v4 39/65] accel/nvmm: Expose nvmm_enabled() to common code
Date: Wed,  2 Jul 2025 20:53:01 +0200
Message-ID: <20250702185332.43650-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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

Currently nvmm_enabled() is restricted to target-specific code.
By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/nvmm.h       | 23 ++++++++++++-----------
 accel/stubs/nvmm-stub.c     | 12 ++++++++++++
 target/i386/nvmm/nvmm-all.c |  6 ------
 accel/stubs/meson.build     |  1 +
 4 files changed, 25 insertions(+), 17 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c

diff --git a/include/system/nvmm.h b/include/system/nvmm.h
index 6971ddb3a5a..7390def9adb 100644
--- a/include/system/nvmm.h
+++ b/include/system/nvmm.h
@@ -13,17 +13,18 @@
 #define QEMU_NVMM_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_NVMM
-
-int nvmm_enabled(void);
-
-#else /* CONFIG_NVMM */
-
-#define nvmm_enabled() (0)
-
-#endif /* CONFIG_NVMM */
-
+# ifdef CONFIG_NVMM
+#  define CONFIG_NVMM_IS_POSSIBLE
+# endif /* !CONFIG_NVMM */
+#else
+# define CONFIG_NVMM_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_NVMM_IS_POSSIBLE
+extern bool nvmm_allowed;
+#define nvmm_enabled() (nvmm_allowed)
+#else /* !CONFIG_NVMM_IS_POSSIBLE */
+#define nvmm_enabled() 0
+#endif /* !CONFIG_NVMM_IS_POSSIBLE */
+
 #endif /* QEMU_NVMM_H */
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 00000000000..cc58114ceb3
--- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,12 @@
+/*
+ * NVMM stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool nvmm_allowed;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f521c36dc53..a392d3fc232 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1192,12 +1192,6 @@ nvmm_accel_init(AccelState *as, MachineState *ms)
     return 0;
 }
 
-int
-nvmm_enabled(void)
-{
-    return nvmm_allowed;
-}
-
 static void
 nvmm_accel_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 8ca1a4529e2..4c34287215f 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,5 +3,6 @@ system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


