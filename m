Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534A0E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgW-0006iw-48; Fri, 20 Dec 2024 11:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgA-0006Rj-Ta
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfg8-0007JV-OT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso15446655e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711399; x=1735316199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb+0VQxzILhCFrzwEvDqpARJdylYJT6AW0M63nRZSlg=;
 b=wwd0O7sVlwfvccMYYfAO6xnt9cTbdKg/+q5UXqtvFoztmqodOpGLgzlIeCPIGlXpAV
 mkLjvpo6IeK/pe+NoIyIEQOsEmIUDoMd4GCQPGX/vHoGGobz4w8/qaL7nsgtTAdasLvs
 rW3+9Mm9RHpNa+l+trAZgKUsETUeLTBdX+8oYHn3yH+MB/eX15hVZ3ZuqsEx1iRgVYRb
 Ub+dYms/wkMPRoXVTmsQrT7o+I10PjU3Y45XUTnJ5d8VLbor4fmhP0w1nR50hzUMVJvc
 UZZ+tMTQ25vjJ4K3GAMndFUCH1VVevpvzPPTN3EkFN/rOWUXmRZ4QbXb95lWDNqr7AQl
 +OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711399; x=1735316199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zb+0VQxzILhCFrzwEvDqpARJdylYJT6AW0M63nRZSlg=;
 b=vMKs2ri84evJ92+JjoAJ5yeaLl8JmWHj4VQ4q1RrvT6GxLGwpExY8zDfoJ5c5lOiXD
 9QwZKTcylhUYapIPGifjUZ4BUp1/3OokMR+ONKiAWf7bEoyi75Ok6+IEhce5t6ock/La
 OU4kNTC8FnJ5L2ttwwF8tBvNan1/9LXKCuZqNHn8nbW9Pc59HlBhxEn2Sd8TOY6I+EGQ
 mnlwoLl+BepDRzbk63PJ9cQ8+XbXl1F5gtTnEXyBCbHrSaKys1wFZDNVs1aUx/CIjrz+
 X6NpFQiQZALR3OChvkfbfUnoPpDQxmMzljQM9MOxflBeQ+aRgmZje3p/A6O6yJA7wD/Q
 3ruA==
X-Gm-Message-State: AOJu0YzKkKBaWOVweYVTjDNLad0bpreW3+uD6Dl1WzIS09KlWUy/t2sm
 v0HJ1bWP2bWFUxNq2rc/KKv637+cbzxceT/U5gXwQwgSLSPB34t6QgNJKgPDprYQGwIxtDHDFaz
 Y
X-Gm-Gg: ASbGncsob9SDwYKaDNxuSEg6RAYfxSNeqfFnjgdWlXvcDDvuB09t+E3IHWaafyj0oav
 8jZbg1Mwlm4PwDVhSdgyUSxlrCtzbITLvSE6apOdVtylaheir1niHUjpJ+mcd4/Y7ZZh7GRbjkH
 DqLElBgAq5MMZmRlnzXSlmyHExHOh0tzAMdYW98jt8o/DiEfMKOo2n8rA5pb5nHonwybAFrT05C
 cz+pnql7DJYnYVvqEEOG1fZEmrGj5PCt3fxOPz7qL3t+cgaPvChe9XVru49gI6LuEZlcOSKla4=
X-Google-Smtp-Source: AGHT+IEA47CGMOvRVjBDWV+cvg1Ve/2QZIQQscjjpU+lWNQRHQs/s3In5Tyh2hsnJz3T7rMBExCFmQ==
X-Received: by 2002:a05:600c:1d25:b0:434:fdf3:2c26 with SMTP id
 5b1f17b1804b1-43668646362mr31307445e9.19.1734711399050; 
 Fri, 20 Dec 2024 08:16:39 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b295sm85627725e9.33.2024.12.20.08.16.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/59] target/i386/sev: Reduce system specific declarations
Date: Fri, 20 Dec 2024 17:15:01 +0100
Message-ID: <20241220161551.89317-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

"system/confidential-guest-support.h" is not needed,
remove it. Reorder #ifdef'ry to reduce declarations
exposed on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20241218155913.72288-3-philmd@linaro.org>
---
 target/i386/sev.h  | 29 ++++++++++++++++-------------
 hw/i386/pc_sysfw.c |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 858005a119c..373669eaace 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -18,7 +18,17 @@
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
 
-#include "exec/confidential-guest-support.h"
+#if !defined(CONFIG_SEV) || defined(CONFIG_USER_ONLY)
+#define sev_enabled() 0
+#define sev_es_enabled() 0
+#define sev_snp_enabled() 0
+#else
+bool sev_enabled(void);
+bool sev_es_enabled(void);
+bool sev_snp_enabled(void);
+#endif
+
+#if !defined(CONFIG_USER_ONLY)
 
 #define TYPE_SEV_COMMON "sev-common"
 #define TYPE_SEV_GUEST "sev-guest"
@@ -45,18 +55,6 @@ typedef struct SevKernelLoaderContext {
     size_t cmdline_size;
 } SevKernelLoaderContext;
 
-#ifdef CONFIG_SEV
-bool sev_enabled(void);
-bool sev_es_enabled(void);
-bool sev_snp_enabled(void);
-#else
-#define sev_enabled() 0
-#define sev_es_enabled() 0
-#define sev_snp_enabled() 0
-#endif
-
-uint32_t sev_get_cbit_position(void);
-uint32_t sev_get_reduced_phys_bits(void);
 bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
 
 int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);
@@ -68,4 +66,9 @@ void sev_es_set_reset_vector(CPUState *cpu);
 
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
 
+#endif /* !CONFIG_USER_ONLY */
+
+uint32_t sev_get_cbit_position(void);
+uint32_t sev_get_reduced_phys_bits(void);
+
 #endif
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ef80281d28b..e6271e10208 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -36,7 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
-#include "sev.h"
+#include "target/i386/sev.h"
 
 #define FLASH_SECTOR_SIZE 4096
 
-- 
2.47.1


