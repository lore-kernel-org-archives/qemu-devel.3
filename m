Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34FBC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPM-00032F-IH; Sun, 28 Apr 2024 17:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPL-00031y-F4
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:03 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CP7-00015Z-1O
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso3493084a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340982; x=1714945782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2gMJsks/FVGo186jApsF1W5B3KJkzW5GgYA94nXNvw=;
 b=EaiZpbdVz+MlM8jUP5QUju2iA/21DQUmvj0vKfOYoa6QOyqx5PxxczAx6kuSn1nEmr
 NiDogCJcJG5ctcllwoAjc8YIj85+CVQ8IULSiJG79jx6AP7tkG7PnyBtrBQQVF7ygr8c
 Tu2lxFazHIxzTlibd19T1fRv8tLmI/22MzTeB4sd3SEDyEGtHYLDOQ9/4+qTkWf4OX+w
 TuFhNr02FQrYpLg1U0oXVJT3Jm90uNzQBAEK/RjI5vVe9GLBYIn9elgO72qnUSQJmAbj
 Sfh9JbBcLyKKasxNp83ds9NDUqhIDHv3c1qPVKfgSL4UAhdwNylJrUrnCPNlcZ52LAW9
 3UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340982; x=1714945782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2gMJsks/FVGo186jApsF1W5B3KJkzW5GgYA94nXNvw=;
 b=ueIwS5NfqTRQns5FTZzg4xGhOeg/J2hZKqS9EbIiC87fidGfoDaPiEd6kgkvZRe3bU
 7LY/wvlOF7qjOhqGAzKehakr1HWyz9fbpkixyZDixvEH3YIwzXea/KXjCm+oAy7eiCf2
 JoPFkibbp0wZPC/M2XoXvdjt8U6XQ2UvIUHCOGMhBDHCzlk2BnaX+FCg1LEhxJur3K0K
 Sui2IkDaU2DZzDrePOaieitW0t+8Wqi/vJZ1DKc1AiAnqZqCpaEfC7FSHKIto8oyt5VS
 Ukokhv1YcuZ3efnTWOTg7ifhXJ9TycIYWq0UQ322y/nJUR9SymW6ZXsOT5/rwEAbKFHl
 SDlA==
X-Gm-Message-State: AOJu0Yx0pL/PAavIcWtVm4JsabL69Gj1GGdbVnbg1a295KgAw+p3CkRF
 wIlZZH/1jTnIoiF9hBvX9M4Lxd41uypw5UKSH9jasvtc5hM4aFwxio0D4HtBwVtKcav7ycozGaZ
 /
X-Google-Smtp-Source: AGHT+IEpx49G/ihPXjmqGEmvisfic+JEboNBZEcEwoBFy8HhTFhXWSexJ/TqeBbCd/jCgyZBX73jUA==
X-Received: by 2002:a50:ccdb:0:b0:56d:c926:b92c with SMTP id
 b27-20020a50ccdb000000b0056dc926b92cmr5519675edj.38.1714340981894; 
 Sun, 28 Apr 2024 14:49:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a50eac7000000b005727eadcb79sm681556edp.46.2024.04.28.14.49.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/12] exec/cpu: Indent TARGET_PAGE_foo definitions
Date: Sun, 28 Apr 2024 23:49:07 +0200
Message-ID: <20240428214915.10339-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The TARGET_PAGE_foo definitions are defined with multiple
level of #ifdef'ry. Indent it a bit for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-6-philmd@linaro.org>
---
 include/exec/cpu-all.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e75ec13cd0..eaa59a5cc1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -139,19 +139,20 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #ifdef TARGET_PAGE_BITS_VARY
 # include "exec/page-vary.h"
 extern const TargetPageBits target_page;
-#ifdef CONFIG_DEBUG_TCG
-#define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
-#define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
-                              (target_long)target_page.mask; })
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
+                                target_page.bits; })
+#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
+                                (target_long)target_page.mask; })
+# else
+#  define TARGET_PAGE_BITS   target_page.bits
+#  define TARGET_PAGE_MASK   ((target_long)target_page.mask)
+# endif
+# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
 #else
-#define TARGET_PAGE_BITS   target_page.bits
-#define TARGET_PAGE_MASK   ((target_long)target_page.mask)
-#endif
-#define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
-#else
-#define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
-#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
-- 
2.41.0


