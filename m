Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D491EC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wx-0004Vu-Mm; Thu, 24 Apr 2025 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84ww-0004Vh-Rk
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wv-0000xl-63
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so956295f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533300; x=1746138100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FP3LPIP8VvEj5FRhb7z5N8ONbnNZZViAztLoLjie/dQ=;
 b=O+nek3iGcEmOC1Qf6a7YjdaZ+e3/5+fFf7BHmgVjkA8HXI9gaC9w6AgmV0fr7mojiA
 QUugpG8mR0CvE6WTLDRJMeuqYejnhE116tu3lkWDn+5VVBCEfh8FCEmWu5oD7uZBGZ8k
 ZLY1QwtlN+OBLHzRnX4HGwgeboxefcXJLnf401KBYUZml/GHpXhDTtSD9kRfUXx/gIjW
 Sn9I/FCqqFSEVnxOvWhAPugYqLqI/ADPq9pXAZ09uzu9ri3B/eZlmapOcn2jWfA4mbuI
 hg96aFpVhFOdIQZQqau6GAXoZ8qNXpzf2EEb8wqNCNhPl98J4IoOSDnP9Wh9o2fMzg9l
 eWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533300; x=1746138100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FP3LPIP8VvEj5FRhb7z5N8ONbnNZZViAztLoLjie/dQ=;
 b=FPvjZNYZeIjwEcZ4VAaeC0UlLg0yGFLPgee59qw1NLsz1hLfmry0FEKxQR+AMOFdKM
 IULkDheBsHt8ad97gVvBGUiD0BNQ8X4cNlMKZiIuKf4kjDpFkNeIFb15zhuFfUIxDd5s
 s9Ix0G2JWPJZbIQE/y/V5Rlbbka8JNO6Y5Du/nStUHet0v1n8Aex3KVDxVwek5UvjYwP
 yZyEJ42+T7MStLytq5dq0l2YDH0JGv2042LEhc6h/TRdwGetRIzpwkFV7mbWgzqVMCYp
 XIE/kNs8ukq5+vwxrpXhHg+n8d41WQC0sxuBFs3AbX4zwQTNdcSeiDQS87RpKEg75HQf
 Woug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPnkicwkwVQDZOOl3LMx/0j2SkcWhxAYfOQvHY5NBMk/MGQF/PUz7JosJor8bXZXmPW70EckY/pXQ5@nongnu.org
X-Gm-Message-State: AOJu0YyZfWg09z1WHBEz7lL5oMFt0cBFnCP9zCermt+IbQsNWth5mBTR
 AEdQRAwEXcveCzPG3TKmr75fnHHk9y/UwvTy16T7C3RaHVpCeJgcg23b5x5XxQ0=
X-Gm-Gg: ASbGnctSyX6pUkZWkhB2gDgFtZOTrqQYE7L8bFmqaxV8aNSYYQbvc/UeryXebmKAFwN
 2HqURZTmPKq3JZWJwCsRL8UGjYqkcpc7mTabU8RsJZLfzVCUII8UfVHUkX/C0e8BNk0Javemeoc
 FfY/2iKDpzkwByKnQEeECufWMla0qbrVPuYvAfDndJlCkrMlvWmZvhsDz4jCrUfwPlQb5VvtKqN
 ihgo+94m64Um9IkqPIVn0FfOUUQkjXrg22Ew5kMoEEyv+gAVkJWibPVYSFB4baIBLSSRO6Uu8P+
 puisr8wkfoq8TLOiE1rAfao9Zretjk8hJePCNc9QrUyE6LoK5WIBH5T2m/HUFCh3GojBEfTl3iY
 +U+IqbxhB1xFDj4o=
X-Google-Smtp-Source: AGHT+IGW9nhyZfIVhIrH+YIy+WBgfMOL6jKIaAz+3JTsY4ubWeZ6UEZ9H5RfLJrvQWhLAAceR/ia3A==
X-Received: by 2002:a05:6000:1863:b0:39e:cbe0:4f3c with SMTP id
 ffacd0b85a97d-3a06cf5249dmr3516702f8f.8.1745533299626; 
 Thu, 24 Apr 2025 15:21:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca556bsm516466f8f.37.2025.04.24.15.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 05/21] hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE
 QOM interfaces
Date: Fri, 25 Apr 2025 00:20:56 +0200
Message-ID: <20250424222112.36194-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
QOM interface names to allow machines to implement them.

Register these interfaces in common code in target_info-qom.c used
by all binaries because QOM interfaces must be registered before
being checked (see next commit with the 'none' machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                   |  1 +
 include/hw/arm/machines-qom.h | 18 ++++++++++++++++++
 target-info-qom.c             | 24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 target-info-qom.c

diff --git a/meson.build b/meson.build
index 8ae70dbe45a..32e6aeb295d 100644
--- a/meson.build
+++ b/meson.build
@@ -3796,6 +3796,7 @@ common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
+system_ss.add(files('target-info-qom.c'))
 specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
new file mode 100644
index 00000000000..a17225f5f92
--- /dev/null
+++ b/include/hw/arm/machines-qom.h
@@ -0,0 +1,18 @@
+/*
+ * QOM type definitions for ARM / Aarch64 machines
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_MACHINES_QOM_H
+#define HW_ARM_MACHINES_QOM_H
+
+#define TYPE_TARGET_ARM_MACHINE \
+        "target-info-arm-machine"
+
+#define TYPE_TARGET_AARCH64_MACHINE \
+        "target-info-aarch64-machine"
+
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
new file mode 100644
index 00000000000..7fd58d24818
--- /dev/null
+++ b/target-info-qom.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU binary/target API (QOM types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/arm/machines-qom.h"
+
+static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_TARGET_ARM_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_AARCH64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+};
+
+DEFINE_TYPES(target_info_types)
-- 
2.47.1


