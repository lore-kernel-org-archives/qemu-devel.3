Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3993AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVqW-0002JH-1S; Thu, 15 May 2025 06:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnu-0005k3-Q8
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnr-0008JS-38
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so5935915e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304818; x=1747909618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xSiXRwtDMWDeTq5UrKQY9rIDpqHmH/9swQvH3M4K+Hg=;
 b=oIqNc3ntlA88EkycPWvU9272DyoYFXz76+xdYwNszKgbbqPz7wnNwYfk/6NakgxRnG
 RxM0b0z61do6qf7yhYTbHUp9pX3+ahgzFb4Wjn4FN81mdGUIUP3A79CS7o/yYhNWBe4W
 4bdXzRfJgXjfkY1umMJlqUsQGNhc92HrufhnCZYUTsYuP3RFjJEIZKV0iu7/7siRCbmU
 kViC7rwaXaZon3v0KJ7IHGAocPI1M0rwsTGPvEQRd+dFLl4OzqXmRmOBneGZggzOweRw
 96ijYEOCWM2CodJcnvQrQd6IDnWPMo980SIaTtKPpwNSRki1SOZHc1o6I1YkfgqUKBu+
 oxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304818; x=1747909618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSiXRwtDMWDeTq5UrKQY9rIDpqHmH/9swQvH3M4K+Hg=;
 b=qnsFsur/7kIwHg24AJPbP6dBv+4qvNQJJl6jvk1BGzCPg3K7ksmEf/SggX9w99SS+E
 Lz6M+LNYICir5LyRkHEF6+e9kSyBdPMwfKdCFAm3rg2owTxeDiYa7mzZ0d7ol0hLJKhM
 hYbOdTpL6Eq8tEliPy3h/uhEp7mcMOYx/5ua9v8ujW7FMltVdkXxJUDh02KEDLZcyko2
 9y/FEWzjHW2SfypK5n0Em1R6fg2lzppzRuML2ESO1oSdslUVTw+CQeBbbNhhwdhjoAJl
 hTwq/h9z5/rWQheLoymnHR5pg95730DfQS5jGmla07O/gZivtD0lfVleXqBvxbvDqrIS
 sC8Q==
X-Gm-Message-State: AOJu0YwMf2jRyN0Q9jhup2KCTIANYXHV+NZiE/WMMHWOh6UHtQz8ye9m
 BZgHeebolWnmJwWO+bfjJwyfmSrNDG+K8i4SxSmAWUHT5A9CjeJGePWF9Fvl4uExb6chrWdRiOd
 SoSs=
X-Gm-Gg: ASbGncuUgH6Z5M0UUxvdtzRnNIyRDwaWQxylXlvfCIT+OCObh5aC/VgiO3WFfZQWmfn
 5ObdhZKwBTOzae7RmdN/Q8bWJ1htwrZWDdEge9BRhT/QBr4bG4BPu6apgiMp1uVnw3HTEGn67Ck
 ZB9i0bEOaApJ3/dXnFjhw3nlF56HlQ4Aj2SNoj5H9LVFna+vER8Ah4hD1Q5dPt4AqAYeDDAnIpk
 U+Fm0zE4bvcmw3U9k3hEmAj3a0bYQnJDf1k5c+vYVVjiOntTXkMWU6Clv6cEU7wsqkmPe9jAnLC
 ubLfOB5Lt7TzD9pFORKLxbvw7z4gjYa6mGnf7b539wJUnWMelsXSz2IdUg==
X-Google-Smtp-Source: AGHT+IFr7JlZy8Y9oDKm4ySxdH0vppXAmqbiMVk2l2hr7OFX+ikrB5hTUSsIAxzFOoP7L69FKz2KJQ==
X-Received: by 2002:a05:600c:1e84:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-442f20b91cemr72098175e9.3.1747304817730; 
 Thu, 15 May 2025 03:26:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/58] target/arm/tcg/vfp_helper: compile file twice (system,
 user)
Date: Thu, 15 May 2025 11:25:46 +0100
Message-ID: <20250515102546.2149601-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-49-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vfp_helper.c | 4 +++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b32e2f4e27c..b1324c5c0a6 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,12 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 7502c5cded6..2d1502ba882 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'vfp_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -68,10 +67,12 @@ arm_common_system_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'vfp_helper.c',
 ))
-- 
2.43.0


