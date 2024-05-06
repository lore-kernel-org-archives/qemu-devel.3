Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25412C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xbJ-00015V-Hw; Mon, 06 May 2024 08:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbB-00014Q-CF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xb9-0001vQ-Ij
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so1000711f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999058; x=1715603858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms63JUeYQatGE3m9Aklqy6cJtKRUtl0Fpr26HXH+Ppg=;
 b=yJl95uhKu3XnnmZ+O2az6cjAje8ewLyCDTo18UXuYzhLyhQZw1OrINE4guC/qJz11n
 1lO7dsySJqwldGoPSwFf1a/SLIzra5+7OdyKH/4/6Og8gcBNE90aSMMu3eDoZVmqNYN5
 NXXfYqdxLhTfz51KIXHophVUSD+1ZgTm0Pei/ZcmNEkimdZl6FyUUwjp52sPzsd8MG4e
 jo3e8XZVt8hYQ3DYL3voZTL94QNW47H7LhuMzEfkBiQt5MFkdPxMvkvf8KeVEp4w9BT2
 RwEipIS14rT2knUeCR3wsgBUpHSfeb6kG3eE6dZ2scOnVVRWiGd2HFz32j6ojSihx55X
 KNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999058; x=1715603858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms63JUeYQatGE3m9Aklqy6cJtKRUtl0Fpr26HXH+Ppg=;
 b=pjMsF/9+oCePwbgG9bOXm6XP1IAUzSDmJ1Pm48gryX/a5V73hdd3p34F3ESeMwYvCj
 8Rltdq5KIe6GFq1rPxOBATp8XOqlbz0MCq/PM4+itO2YnLJCaNUs6oTwPRn+csGC/vko
 wFI6am4ByYNaPv53KEMXecsFDwUEEaIdcYpauI0Ns0npFC4t7TIcCR62XGM8Weis/VXY
 JFqH4UUgOmDo8rowq5l6UCUEpnfrYGfyHQPsV++PSA6m+HqzzLjM/8cals31D55LB2Fc
 CDpK02favKs4wBKBCZ+6YhK1RNgj04QZWARhzr3kRqTLo4hnCl4nvCAViwdhMC21ofgF
 UG7g==
X-Gm-Message-State: AOJu0YxcAcTswyFH7W+WswlkWYE8t6x9+4ijtgwNmUFWUYJUKEtkCZrU
 3UNC8+tlMwHMQpLC+NJxqjNWlhJs+iHpAvCeH3t2aNg9mJOBC6rGVGRHOLohPqWN3KD3UsFzmgT
 o
X-Google-Smtp-Source: AGHT+IHhArs3ahEP39ku8hZOue724Vz8Vt2Oqb0zLhk7z5sQ0d3SBJRntiNf16s3MhwBDU863+cu/A==
X-Received: by 2002:a5d:4c91:0:b0:34d:a37d:d383 with SMTP id
 z17-20020a5d4c91000000b0034da37dd383mr11873247wrs.22.1714999057721; 
 Mon, 06 May 2024 05:37:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b0034df7313bf1sm10715987wrx.0.2024.05.06.05.37.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:37:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/28] exec/cpu: Indent TARGET_PAGE_foo definitions
Date: Mon,  6 May 2024 14:37:01 +0200
Message-ID: <20240506123728.65278-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
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

The TARGET_PAGE_foo definitions are defined with multiple
level of #ifdef'ry. Indent it a bit for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-6-philmd@linaro.org>
---
 include/exec/cpu-all.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 032c6d990e..14fd40046d 100644
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


