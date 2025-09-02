Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54561CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQn0-0000Vb-5s; Tue, 02 Sep 2025 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmp-0000RC-0l
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmf-0004RN-FX
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b82a21eeeso34638285e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818646; x=1757423446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X+SFIFq6U9bHOZ8xKmEzKqugUCiHKif7YLVtYxmKJZo=;
 b=v0s+uuMGzOio/te6N7rgd/O0T8KBhLnKLJu8k7hige/sG6eVrslZd8r/2NWVJ4y8US
 NSZ8mX7d5C3kFrQ9HBepvGhBOjzLi2/LbL9+4uo451ssEc595MjooCg40xE3Tiyup7cT
 DFG9INUZx94ouoZswbOlUG8NTP3ltyvQw08E9KDuIAjyB/D0EmE4Sgs2Tccv/qfY5q3Q
 dif81vF94Bjs9wK724GZwJfUkjWXvUV4S5P1bxFlp4AwQXFw+EutX/pGxdKNBI6iPRaM
 17evC9RNdANqhlOoUW4CvlZH2AJtZNXYqVYpflv/N30xAiE6SpT+suplvqhK910s7/jA
 RL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818646; x=1757423446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+SFIFq6U9bHOZ8xKmEzKqugUCiHKif7YLVtYxmKJZo=;
 b=rlxrXE8F3uhEm7EAkjoLR/i8vPrwfCHKuxu8Cf4QRAiqU70VaE5t2dtZc4Vbjx1/cD
 RljKvXJLGzB6L+w5e5QqAE+2fPv4WuQnvaXJJL45hG1Mkgoxo88ngmfL5ntmZY/5a2BF
 CgWrB8i+pGFzH42EJ8cEjTSrQ7j4HMYd0ZWDSqQNY9kKB3pfaUvHRWayDBRPXmM8unGh
 pWNdZtv0kNJ4sKAsXHV7tEB2qX8I9hegMT4nMCJ8+nARYJHlyIhVGj3R8xdpOJakxq3m
 M5BoN1zc35QdgJ6p7gK3Tc7/hWFmf9UrWSlkIctg+Ja7Uk7mJeZoSw/4RsE3CQBxku2k
 kr/w==
X-Gm-Message-State: AOJu0Ywqwq9IbNz1PQUgaNvZR0EHR3L7sumfk/5dJtBa8HcE0z5+FPti
 F7vFjum5ZuPk5se+LX5j+0tMxCj9I5gb0DCaE1ltqOTXSWEWYqaIrrOPrBYXzSoYwo7tgjMGuRt
 6bNbI
X-Gm-Gg: ASbGncsFF3MOTpcG7SQ3pA8K1R/+bzb6ahoMJHFBpguga5oVS+x38lyQszOs7TEhghN
 krQ7OShzihyShi9d1MYMoe2S/MB+b3Xh0gW/rVqXMBeopQAskwJexiHcODiFJQpmfpBS7TDhmBO
 NO5dZQA5ndCm2SImCWwZAJDJ0/ZIAdzkERHQXPdc5LrTh42C9jw08rBPTo2yoylkgjTfuUissCA
 ZrnNe0MkoY4Ynx5oL+VlGO0lJ7qlhfFfC7FDXFOMphu0tqtd5qOZfi2L4yUpxuI8eiOwhUefnel
 Y7m/a0WlO66ePhjKyTMYYFWZr0O6eFly8tnxyYqsDWU6kAsnQD/sblHLoggsk1c8gEe639YU65q
 DHUg8ONO/1R+DgSByfGI6qckispa/vYUs1vqJmDbo3OH6GWekRAVSi2nmTkN51/PXjxNlvBiP1d
 GyG+Q7arU=
X-Google-Smtp-Source: AGHT+IEYKryt2d0nkMVc4u4TFTS3RpP45uhnInPld68u6BuSaXOcmBp6TE302GNYTnlktiYdgePyRg==
X-Received: by 2002:a05:600c:524b:b0:459:ddd6:1ca3 with SMTP id
 5b1f17b1804b1-45b8549c817mr92937795e9.0.1756818645607; 
 Tue, 02 Sep 2025 06:10:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9a6ecfafsm23428815e9.21.2025.09.02.06.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/39] migration/vfio: compile only once
Date: Tue,  2 Sep 2025 15:09:43 +0200
Message-ID: <20250902131016.84968-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250730220435.1139101-3-pierrick.bouvier@linaro.org>
[PMD: Cover vfio-stub.c in MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS           |  1 +
 migration/vfio-stub.c | 16 ++++++++++++++++
 migration/vfio.c      | 14 --------------
 migration/meson.build |  6 +++---
 4 files changed, 20 insertions(+), 17 deletions(-)
 create mode 100644 migration/vfio-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8147fff3523..07c9f929d2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2268,6 +2268,7 @@ F: util/vfio-helpers.c
 F: include/hw/vfio/
 F: docs/devel/migration/vfio.rst
 F: qapi/vfio.json
+F: migration/vfio-stub.c
 F: tests/functional/aarch64/test_device_passthrough.py
 
 vfio-igd
diff --git a/migration/vfio-stub.c b/migration/vfio-stub.c
new file mode 100644
index 00000000000..f59ebe075dc
--- /dev/null
+++ b/migration/vfio-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU live migration - stubs for VFIO
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration.h"
+
+void migration_populate_vfio_info(MigrationInfo *info)
+{
+}
+
+void migration_reset_vfio_bytes_transferred(void)
+{
+}
diff --git a/migration/vfio.c b/migration/vfio.c
index 0b64e49ef06..af6ae2c1e19 100644
--- a/migration/vfio.c
+++ b/migration/vfio.c
@@ -8,13 +8,8 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-types-migration.h"
 #include "migration.h"
-#include CONFIG_DEVICES
-
-#ifdef CONFIG_VFIO
 #include "hw/vfio/vfio-migration.h"
-#endif
 
-#ifdef CONFIG_VFIO
 void migration_populate_vfio_info(MigrationInfo *info)
 {
     if (vfio_migration_active()) {
@@ -27,12 +22,3 @@ void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_migration_reset_bytes_transferred();
 }
-#else
-void migration_populate_vfio_info(MigrationInfo *info)
-{
-}
-
-void migration_reset_vfio_bytes_transferred(void)
-{
-}
-#endif
diff --git a/migration/meson.build b/migration/meson.build
index 45e9445f97d..0f71544a825 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -49,6 +49,6 @@ system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('vfio.c'))
+system_ss.add(when: 'CONFIG_VFIO',
+              if_true: files('vfio.c'),
+              if_false: files('vfio-stub.c'))
-- 
2.51.0


