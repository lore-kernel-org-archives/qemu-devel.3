Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FBC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2fD-0003EY-Ey; Wed, 02 Jul 2025 14:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fA-00031O-0W
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2f5-0002tH-Qe
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3279728f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482705; x=1752087505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UiewseZoW7++jqLIzKMJ/OYq1tgfsCyntten+qzSRY=;
 b=TczYc5Q3m8C39gmWZbnWxZJdmumTo/W3WMGCZqGOdLn0g5kIfcjo5FA1BB8MGwWnbk
 IZncNxHqwPBvsbbZCBN3h/uGHQ70MH7zEsiMIDGEwM4XEOj5BknFRZ0MUJTZNZ4pEKpM
 O/UeBWrCipkH/4hqEBhNHEKGhPEVMpEBhDsLjWCFXowF0KCsUr4apy6wAy7h4nyvrfdf
 S3Sr5QHps7WlIFy2/8aNfiTiCBzTGKljeW12XEG06sR5+GhdPRaHifMhDAncRyet0Crf
 LhEtvGqbk1ODZWWMfPg2uBU4+7059AV/w6m/GV67rAacLt0voXG/L6RGJadzEGi0pkkH
 HLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482705; x=1752087505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UiewseZoW7++jqLIzKMJ/OYq1tgfsCyntten+qzSRY=;
 b=Zes3MDTxxdZyG1lKKh31RKuMT5Nkc5BPMRDlK5+kIgJoDv3Au/QPfy71LDvW8dTodQ
 VRGsKUjV9XxQl+AgD88u0FvQQSzMIv5o9yKPXRYfZZu9U6tlVbmt5JZSHri5/0JRSvRb
 ou76Jq5cGhlTfxHlp5jK1ufN+MQDd+MM9oY466Ej3SKdG+U2dDsRhttzxeifBrJv0pne
 gkjaOS0KMC7GujOOh/amTU6qsbnD7ipHbFYsoaO0691Y/idHHVkIevLHB9GNfxf9rVz0
 KPsTq6w5Id0MH5veP46BLFFSb+lBA5cCUKBrvMAJfdCxum0Tru3GpYJyeqgercNTRjgb
 yXyQ==
X-Gm-Message-State: AOJu0YwPxn/UDwy/Gg0+6kI7QtAkLvu56yE51bU0oP1MlaYEOadUZx8/
 UFbXxVqNj9HrAfY9kvy8GiC8avYCnB8aN1L2l2dfMHqOYLW4qgIy/Z4HOkBArOkzMOsLV7u8pOY
 8nOGb
X-Gm-Gg: ASbGncsxsUSpjO8mI6sTt1kDRq70VpNDKoqKDwL8CBpdnHXJZS33O6lDZc8cDz/nxHZ
 shfMPlPqXRo4LbduSlNGjoiMqHHTLBZVYMjH4v8siMkYXaqjijTeFMdca8zXuH8jS+/+OB60f2k
 fGjJIz9v8Ryc+GGBOE81Edmxh0+QNqeY1niTmtKnyCp8l//TzUOGvVbL44estQlNehn4FQofHcp
 MsX+0dlTzWjB6GGqp7BwqEFkl3nABHnieTpu1OQB0S/9+2W6BUxP25hweMg5Hd3+uhzZAr3QeQg
 d4/d4MzVp/sm0veJo0/cXKYmfO0Ow3nFgHEB2p1wnk+nvjnKKcGTQlD1xEPovlapFQbjDhfiAj0
 MAMbl8T4T3KXZA+pxvveK20lHOxsQnlv4m2f9H4lzWrQM1lU=
X-Google-Smtp-Source: AGHT+IGjFUmKl+lvv9OK5JKGKAwhSmT7t8bZLQi6uuNDWFj32VAHtHAPfYEUVZWzoVpnQ/oUnKOJwA==
X-Received: by 2002:a05:6000:2c0b:b0:3a4:e54c:adf2 with SMTP id
 ffacd0b85a97d-3b1fe5bef26mr3449934f8f.5.1751482705473; 
 Wed, 02 Jul 2025 11:58:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a998a47dsm5646495e9.18.2025.07.02.11.58.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v4 40/65] accel/whpx: Expose whpx_enabled() to common code
Date: Wed,  2 Jul 2025 20:53:02 +0200
Message-ID: <20250702185332.43650-41-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Currently whpx_enabled() is restricted to target-specific code.
By defining CONFIG_WHPX_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/whpx.h       | 27 ++++++++++++++-------------
 accel/stubs/whpx-stub.c     | 12 ++++++++++++
 target/i386/whpx/whpx-all.c |  5 -----
 accel/stubs/meson.build     |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c

diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00ff409b682..00f6a3e5236 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -16,19 +16,20 @@
 #define QEMU_WHPX_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_WHPX
-
-int whpx_enabled(void);
-bool whpx_apic_in_platform(void);
-
-#else /* CONFIG_WHPX */
-
-#define whpx_enabled() (0)
-#define whpx_apic_in_platform() (0)
-
-#endif /* CONFIG_WHPX */
-
+# ifdef CONFIG_WHPX
+#  define CONFIG_WHPX_IS_POSSIBLE
+# endif /* !CONFIG_WHPX */
+#else
+# define CONFIG_WHPX_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_WHPX_IS_POSSIBLE
+extern bool whpx_allowed;
+#define whpx_enabled() (whpx_allowed)
+bool whpx_apic_in_platform(void);
+#else /* !CONFIG_WHPX_IS_POSSIBLE */
+#define whpx_enabled() 0
+#define whpx_apic_in_platform() (0)
+#endif /* !CONFIG_WHPX_IS_POSSIBLE */
+
 #endif /* QEMU_WHPX_H */
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
new file mode 100644
index 00000000000..c564c89fd0b
--- /dev/null
+++ b/accel/stubs/whpx-stub.c
@@ -0,0 +1,12 @@
+/*
+ * WHPX stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/whpx.h"
+
+bool whpx_allowed;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 525d6a9567b..1732d108105 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2688,11 +2688,6 @@ error:
     return ret;
 }
 
-int whpx_enabled(void)
-{
-    return whpx_allowed;
-}
-
 bool whpx_apic_in_platform(void) {
     return whpx_global.apic_in_platform;
 }
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 4c34287215f..9dfc4f9ddaf 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,5 +4,6 @@ system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


