Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B75C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUz-0007Ms-N5; Thu, 03 Apr 2025 20:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUv-0006zU-Ju
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUt-00038W-Io
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso14616165e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724881; x=1744329681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZohGBH8WrXshSWsn5wc6ro/iTiq6n2ZD0DIVPZOhv8=;
 b=nruoqF7CZvE8qnJ95Nr1Nzu+obHGlZ32jQ8c8Ze1mFRyRI5EMfiiRatb6wGY6JZzzh
 9ns0HJkPV5zKBm6H0y2rTH18IkOO/LPtlQjU9KQsZqMx3C7gpI2aslUlrtVjxGL4STt4
 ue3tgFHh1Q5G9t/6NvehaEdLY0NZb6hDm6l43L/tpleAJusspwiGgALBa4xi/neM4BVR
 Pq5JfPgfo71ZJIs7W5hBdJ1FrASu+7zLeHpVh7REyUe9v2qH4ID+gWdrZ0nHf2ORvMm8
 OihCMpI3DRjNuz1lZ6JffdKK3THn00iZkNhM1S6JPKBESljvRYPEvqMa0NDSD7qY9uLr
 3lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724881; x=1744329681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZohGBH8WrXshSWsn5wc6ro/iTiq6n2ZD0DIVPZOhv8=;
 b=eOgSRnn7iRRBj8xtfb1QSVZPp/fqgfiF6ygVTCqnSdZNLgSlUTUENyxd41UeV5NrQi
 DW+mFiuDM24vv38ENXtmohFCJK5KaXfW3KgAjMPqM/lVVMbZTNDZHy3ZUXJlFSBL8IUF
 iDlELBbAYAKDoiUoJK+iKmVsW71+ESdyBIhNuscuDms5TrpD9UaO8z62RmGEvxMZTend
 QhMD1+UbSdsB7eV+RiqRYOJLkFxRhl10D2W/QhKYHPq5iGn1SkcH7Yq+iKg6Bshcoy4A
 jGQVLfVqW4QAjhQX+b5Q3ugF3VgJnRF335dCQiJdlYp731EosEMg+IaESWi28VC6kyL7
 hnag==
X-Gm-Message-State: AOJu0Yww1c0quTUCS/fQcNG7iWHIn/wyysSsD5I9GdFnhBev5URnZNbJ
 lh1YM9wOIybudF8hjswZ/VrL85KlF3Bm3JV5zxdGyC/yfdy4Z7VV4vPSM0czEaw7I7gMtUzwqqL
 H
X-Gm-Gg: ASbGnctIuaTxMtg0gdd5ZyH6/bFg2pUnvrSAOfDTQ37HwdH3TaUNjSPQjFhS6Mqlu8q
 FuPXGL2StK+pbDjpCgB7F2Zj78OmBTqnNJyI0Tgj03C61EOlopVMoI51YeRV9plf4qxwLuCjaQS
 y1nubWBnsW1MmvHR/mm+YbTk4GoCnokn2e1VYJQ5BOo59cIsFHyX+YSEurvwUU3ANkQfkPTdopg
 3ogbRU6ZVfAhBmeVVFUzKJN7iWK3SGTv16iRNLd34Bal3RtIjnFW9n7jpK/u2try8iGDFU9JBdx
 ggyAkz6ISuQkKIBzzQLyxYkJ8354E2+Nij+ZrS3hiBoRl0enFK4ZBngwXseW5RMKWK4KmNiTKfG
 1Do3F6JN+nbGU5YXm618=
X-Google-Smtp-Source: AGHT+IGl0//I5/eTuoXscoJy/OaVPCxK2zQi0LrG/NoAlpGFrUjy/AQ8ZfmAofPzB2Xdx4QmSWdTHQ==
X-Received: by 2002:a05:6000:2482:b0:39a:c9ed:8657 with SMTP id
 ffacd0b85a97d-39d0de17e4dmr491822f8f.17.1743724881639; 
 Thu, 03 Apr 2025 17:01:21 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795081sm34897935e9.27.2025.04.03.17.01.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 27/39] system/hvf: Expose hvf_enabled() to common
 code
Date: Fri,  4 Apr 2025 01:58:09 +0200
Message-ID: <20250403235821.9909-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Currently hvf_enabled() is restricted to target-specific code.
By defining CONFIG_HVF_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS             |  1 +
 include/system/hvf.h    | 14 +++++++++-----
 accel/stubs/hvf-stub.c  | 12 ++++++++++++
 accel/stubs/meson.build |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 accel/stubs/hvf-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7083ab1d93..00ef33be0e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -525,6 +525,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
+F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d50049e1a1a..7b45a2e1988 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif /* !CONFIG_HVF */
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif /* COMPILING_PER_TARGET */
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
new file mode 100644
index 00000000000..42eadc5ca92
--- /dev/null
+++ b/accel/stubs/hvf-stub.c
@@ -0,0 +1,12 @@
+/*
+ * HVF stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool hvf_allowed;
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 91a2d219258..8ca1a4529e2 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -2,5 +2,6 @@ system_stubs_ss = ss.source_set()
 system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.47.1


