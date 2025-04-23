Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB82DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y5h-00069c-Eg; Wed, 23 Apr 2025 07:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y5f-00069Q-M1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:16:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y5d-0001om-R0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:16:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso46645305e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745406987; x=1746011787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b+awRrfnLaus72pFDpCOZkkckWGefdIiXx1C6YaLfqw=;
 b=tHjoUhYuzLWBMejFDK+n7c/zt4xOysKvtyWbZARy5yXU56eWWpTAG18ZPKeF+DAbA2
 jAGeF2XYWbOSPs6dSjXc3JSj6+ddLleE0IQR8BS8V3SXGqVBeBsf5yMN5p7ms6bccicn
 dF3jOcbR/nPQQUWI1mHTztrNckH7rrFayapUx+niCE+a3MP4l//m+B7mCC/RWtztFyk8
 7XB5le7GufUGJxvOzpjdfE8t6VD68txt4NdXvLko3pIgTANwQF27FfV5GAtg5dTDEfT1
 /hgG7fsE5uktg7folX2kF8BNz0esa4ZDXMEP3y2OAP6bH+POBvthOJBiZkH009OwQSkb
 8prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406987; x=1746011787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b+awRrfnLaus72pFDpCOZkkckWGefdIiXx1C6YaLfqw=;
 b=LlUn4tE6Bsgfc+9S0ChNz7rySCjDz8uyXTlQ3PBTxxUnDxiPOo8YFW/LCtt4vir6uj
 19CmA2d5bt3ZdZ14QsJAnLZhGnfby4OCDaeC6PQrI4D5DNAAewSjHahpsnTq1lmJY9Ui
 6q9qBBciRo1T3svN2+OraVn9XNjSsCn67KwnyPNlPd/5IMnLhXW4P8rvIh9jX63uvYzR
 qAg8MyZ5Z9x6F/qnImyQzGQfwPtaLh0e9Gq/Jrurkr/2yqWO3zReb0XxT70lcQ0v0EJr
 eVUP+KL4TnrnqQUKgcIx5EPCXX5eAHBUR0ARsmSLcaKKUZfpQlq8X5HG8HlEhrnnnVxi
 X2rw==
X-Gm-Message-State: AOJu0YzPpeyV+pju/lPVxzg6jt/jC/BGFKnGw3oHrwwpkaac8xgMIMSp
 2SvNWDU27aZvQIu0lC/kWFlaHlcRRoMNaeZvBmYXu6t4K+YB8sOrDDVZl5VxhObAd1a0lSlekfr
 I
X-Gm-Gg: ASbGncuPE6TAgd2S/n+1Qb7mAHr2A9iy3ZjnxH0qYjuKMIQytAc+ltgHpLQUN6dpSL8
 UdU2vOQlnisrlEmhFHLk9zMciGYXb9Ez3PrDBcZis1qE4bKWRCSLdWRVbbUPYGeiS5/CXTcr2yp
 OKRbF7K56EvzGsyIcE0wMzyRvmDchq9RsAvsL4tt6yTRPanjzlyrFQ1DYvylDTj5ocKf2udpxAc
 n753PWbr25ucrPxPlxNsdFQ7zQ4lTeIWrOPDp3215hIlf10hi7zuRF9wb8tf0XNEsVczE2GqsN7
 S9VH8MnT1NADWKju5Y/G3ZeA/gK6rrI0rkKst7X4ogtlQWO+7TqJfflYo7Jw0Q6ErN3PaGHKhMH
 QC9dnc/MrQ0gnF8rD5CEwedP8ig==
X-Google-Smtp-Source: AGHT+IGHYaSYjORejDdHJiqEhdXylm+WxPJ22WjNvYuoeIoRJKEYe/AQDgUVZTJfaG9Px1vaV4czQg==
X-Received: by 2002:a05:600c:a06:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-44091fba640mr20495405e9.4.1745406987301; 
 Wed, 23 Apr 2025 04:16:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d17846sm22293275e9.2.2025.04.23.04.16.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Apr 2025 04:16:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] system/memory: Remove DEVICE_HOST_ENDIAN definition
Date: Wed, 23 Apr 2025 13:16:25 +0200
Message-ID: <20250423111625.10424-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since the previous commit ("exec/memory.h: make devend_memop
"target defines" agnostic") there is a single use of the
DEVICE_HOST_ENDIAN definition in ram_device_mem_ops: inline
it and remove its definition altogether.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250422192819.302784-1-richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 6 ------
 system/memory-internal.h  | 3 ---
 system/memory.c           | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b83fd7ac88..dab1e7e5809 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -44,12 +44,6 @@ enum device_endian {
     DEVICE_LITTLE_ENDIAN,
 };
 
-#if HOST_BIG_ENDIAN
-#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
-#else
-#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
-#endif
-
 /* address in the RAM (different from a physical address) */
 #if defined(CONFIG_XEN_BACKEND)
 typedef uint64_t ram_addr_t;
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 085e81a9fe4..ed5d75de24b 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,6 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_words_bigendian();
     }
diff --git a/system/memory.c b/system/memory.c
index 7e2f16f4e95..b398f656c2f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1382,7 +1382,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_HOST_ENDIAN,
+    .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.47.1


