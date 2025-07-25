Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F1AC87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOz7-0005lT-JU; Fri, 25 Jul 2025 16:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu3-0007e5-5t
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu1-0001EM-7i
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so2190137b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474824; x=1754079624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZA+eshzNfdTnar9wMQ/m2mWJrbR0690fXWrDb+QztY=;
 b=fAOsrfGtBr4EKpfvv2ZXeSl1kBL7Ta3B8+Lsg0BqNQoCbzA88TWoWgsHRPcmw/WVLG
 RQetd8FPgTplRil9u3hsz+d+ffXxWTR5j3nt76IELn04IVwGYLDrXz1KMuqcPmHWzFl4
 XbE43iNYVtYP3TP6yYLgIxoNoWqMogVLpfpMTuce+HRLS3nrkqn4f+Y6l5REmgj1f77N
 dKpDVyu53SnRKpwuLYAv8I5uxkyaT+eE9AYB/lbZ6F0PqQWZLIFDU70p97ZZLfxSS4ZG
 aLeW1ZxqEERv21+2JIC7OAJEdhCxqe/taJG0DQreMPEQFNUAjSBmWV6W7fPH6ubVGPCr
 +6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474824; x=1754079624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZA+eshzNfdTnar9wMQ/m2mWJrbR0690fXWrDb+QztY=;
 b=RYREcXVKhiATlEEzmaJwG8MiFnFFdsQH6C7dcA9NLcmLzFvmc2YJno0ZpXEa4/GxP3
 9stLYg1I23BO5KGp/p+xkkKRNn+IYqz295Zx2ytJPMVCsKcaf1MjerNsKnsIb27LPi+R
 4Gc0Cc1JHcqIHlgjKGmMTf544YsYkDCUGL1PttrM2M6FBaG7ILevJ9Irle0jtheWYRP+
 leMZxyPOAwW4zSH/tStNvS4OIR7MtT2Cq2FDPIxHzCbmv/L9Yogb8HtuDZA0t0Q+5WeO
 lRsMbbgDd17JhshcFK3VLpWWsWhort0iNnh9uk7HsX+WrFT2F5WLoc4vtE1PAP0XlutX
 3/1A==
X-Gm-Message-State: AOJu0Yxqir2hn0L5CWBc1XdNkzyaxVXg6zvfsoIEnyquqD8BtNET7GFQ
 +nzg40Y3nuOu2bxX5CEUa2d04NqV05Le0z6js5LLb4W+P1ATnT7S/u9vbxRV2rwsQ9KyUR3GO6p
 hgq/b
X-Gm-Gg: ASbGnct4KCdobKyWEP8GbIS8ZuZhnSZMJBkncyB/kiilAhztYA5OHWgbmS3izAx667o
 Cg7i5iis5Atvj/Kh2Bf0BSEczOwsXb+ku76xtzt6vVQYlpzwCpc/2vabeqzLgI5Iwq7i6OwkQcE
 OMjtuF6Xd1AkGEFZEC2ycFfiJIitlPLiNXdm4l+pulrgdw41sIFAGsOmiM1jZ0n5sUuP+HQGp9w
 hyVabTB7YV3CiNMY1LfKz3tFcH50/VDEwaJiD+jirjvvIkP8j184PasI9keGkUZXNaAxIpK/Eh8
 UoJp2KOOxRIGulWZDVL8QRK7gTqbNRufBQWF7cv6ZpGixZkJK/iWC7L5gidLQ22r60Ac+8bsjjh
 9VB5V4dAi81K5MEExS3HAhQ==
X-Google-Smtp-Source: AGHT+IEhVZ0eMbnHWvlrlCsnt4SOiSnV7Bq59sUJtgi9+ChiOpaCVUoyVk4c8m86n5/nKozqpvA++g==
X-Received: by 2002:a05:6a00:a85:b0:740:b394:3ebd with SMTP id
 d2e1a72fcca58-7633276c2b6mr5135968b3a.7.1753474823844; 
 Fri, 25 Jul 2025 13:20:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640882071dsm360925b3a.16.2025.07.25.13.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:20:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/3] include/exec/target_page.h: move page-target.c to header
Date: Fri, 25 Jul 2025 13:20:15 -0700
Message-ID: <20250725202016.21325-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                |  2 +-
 include/exec/target_page.h | 11 ++++++++++-
 page-target.c              | 10 ----------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index d0ae602c2ee..71c253ba135 100644
--- a/meson.build
+++ b/meson.build
@@ -3910,7 +3910,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-target.c', 'page-vary-target.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 specific_ss.add(files('target-info-stub.c'))
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index ca0ebbc8bbd..813591c9b51 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -62,6 +62,15 @@ static inline int qemu_target_page_bits(void)
     return TARGET_PAGE_BITS;
 }
 
-size_t qemu_target_pages_to_MiB(size_t pages);
+/* Convert target pages to MiB (2**20). */
+static inline size_t qemu_target_pages_to_MiB(size_t pages)
+{
+    int page_bits = TARGET_PAGE_BITS;
+
+    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
+    g_assert(page_bits < 20);
+
+    return pages >> (20 - page_bits);
+}
 
 #endif
diff --git a/page-target.c b/page-target.c
index 8fcd5443b52..66f03c61cd4 100644
--- a/page-target.c
+++ b/page-target.c
@@ -9,13 +9,3 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 
-/* Convert target pages to MiB (2**20). */
-size_t qemu_target_pages_to_MiB(size_t pages)
-{
-    int page_bits = TARGET_PAGE_BITS;
-
-    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
-    g_assert(page_bits < 20);
-
-    return pages >> (20 - page_bits);
-}
-- 
2.47.2


