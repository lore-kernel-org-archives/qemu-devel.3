Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FCEE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwSQ-0006Eo-Il; Wed, 18 Dec 2024 10:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSP-0006E4-5Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwSN-0007t4-AP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:59:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso44790555e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537565; x=1735142365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVrC/xB4J4W5X585RY4Zqal4Bi+Ph7neB+RzuTzMwMY=;
 b=J6Sq7t1fQoSlxAZ7SgPjiepzVQwPI4H3leMSsX/0tLr6Y1Lk8Aj4FRf4HOulyZQujw
 Rjk14SB2oUe8fnU+3gnnmie59wBJ0KhnRRWscXgJB23kUjQw7L9Ov9f2mhU3Iu3xlK9o
 xlt6eqAPwZ7kXVfN5iNcojedeKdCx5WNJlqrvUJCOteCidfTE75B3S1W0Bn8nuh3pXpC
 5ODfgYpy64+M7Gft4QwVjagaEBUxBz2ggljxs/Ftzo6G6bQXOi/QWBqtuKa0Er5e4pWg
 5JgtvHT7GYPQIIIv1c6tD9krKbvN0jkGKpsjAWIyh9MWjdwwJwCGCI7Bd0CHlpWv0ezq
 rNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537565; x=1735142365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVrC/xB4J4W5X585RY4Zqal4Bi+Ph7neB+RzuTzMwMY=;
 b=JP4sNUao9Adgz6F0ezO5PZoLcCqFucq9HMo7pn7PvB/rs8+A02j9pFLNtboUlpQXto
 OfhCbU/uS+XUi1M5+AQM94BYR9tY1X2roF1mH+Ai6ZzAFqZ/H08PAu+gvVBAPlCvdgVD
 2arkTY7TT/wuauZhRTmdJpQQZpj3KRpVldBRP5pITM6XzNiyBGNfFakpFhKkJ+AOyBRA
 t5ScRUtRHgehc+5li4l1OaCqhc2f3ufKecsgjKGHenI/vvajXvmFUr/QnP5rV1BmgW/1
 brQSVH9deexCFc9vRCo5wz0qDaP0qQUzyjzRtXilS2RVtaqfWM/adWVPqiI4ofcTuXvj
 l4+g==
X-Gm-Message-State: AOJu0Yz50qDco28uhddXB54xJm0ONr/Ieo/Egdr1Av1Og/cLxbfXQMFe
 g18CF1CUCNsBRBWzFPdlEU9GFqKAf4iQX62pHQus2Hq3/UEK7HAh7Mc/dDGvDbTEOV9wUK88Bfr
 4
X-Gm-Gg: ASbGncukiZV4STRCUk41HJiTPRZBZx1FrEfCg8qqneRwawRl9Md8VmqQ8tbXGv3kr0i
 1BRD8e/jT9XguKHMJoB6IT48tS5GIU+cJiErRJ3fSDmdyCD870IFdQVuSOpYqUa2fqcn/q7ahGh
 X/hxaCfqhzaJ7gDNRcV3zdVWIS1lcAWFJK/DJWkTCrX44ZLTxfBuE4vZyj6rseyGyNQ98kAJVR0
 vl8lyiQSBmuKoGyhZqj+Wb0Lohod+VMl3iEJWXcyIrF8MRPuBQZyiFcY5kvCywWrEA4fpJhfYyA
 WUpl
X-Google-Smtp-Source: AGHT+IE/GsnVIVpBHu0FzqISExQ4TN/zyNddvEngW8uvxopkfrRRPMhL0arlvZB2uk9iMPH3fG20pg==
X-Received: by 2002:a05:600c:35cb:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-436550b0fe8mr35114405e9.0.1734537565061; 
 Wed, 18 Dec 2024 07:59:25 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b01b73sm24760955e9.14.2024.12.18.07.59.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:59:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
Date: Wed, 18 Dec 2024 16:59:13 +0100
Message-ID: <20241218155913.72288-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155913.72288-1-philmd@linaro.org>
References: <20241218155913.72288-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/i386/sev.h  | 29 ++++++++++++++++-------------
 hw/i386/pc_sysfw.c |  2 +-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 2664c0b1b6c..373669eaace 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -18,7 +18,17 @@
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
 
-#include "system/confidential-guest-support.h"
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
index da7ed121292..1eeb58ab37f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -36,7 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "system/kvm.h"
-#include "sev.h"
+#include "target/i386/sev.h"
 
 #define FLASH_SECTOR_SIZE 4096
 
-- 
2.45.2


