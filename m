Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA138C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSS-0006zf-8J; Thu, 20 Mar 2025 18:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPm-0002ag-G9
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-00079R-Oc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2264aefc45dso37719725ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509825; x=1743114625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRpFizF/E4rJtnjS8JYR/AaD9jyyXl0WSOs/w63P0CI=;
 b=T9wFAQKEQLIjGGkzDyN6HOe+XD2rAAg+8h45ToLvR7U/+beaSztR+IhePoMa9GtFkv
 HDe6EHV91KX7AUuCrhHx2E5k0fuYXk07ZXhI8EyQBs/0hQY6kwB1xK+SgzbNRxfyHs67
 4PlbJxJEu1TuS1+0wNcUzMsPm9EBTeQuF0JAYmdteNDKPw9HQgBkRozjePW1J2k2scwC
 XeOCxp7fACnM3nZOFXRrSwWgogMP5G2yw1Qo1jAj4BIXwB6Zi2FE9g8riVXmiyo/18qI
 1yLxsZx+xDtOUv2tOIdgdspHmbHPjtgRN0K2U0RdOVJ74p7zyKhXZvFls7tuLAQKeJwS
 9tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509825; x=1743114625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRpFizF/E4rJtnjS8JYR/AaD9jyyXl0WSOs/w63P0CI=;
 b=qPYADG6p9nBQUJGX7GH83sASwxrfzHEWeTGYx9aWKg3uZJHVpnBrXlg62hEB/1SsDH
 RD7wLzJQ509v9Rj9sNt2rJNZPcsyQp9qsRbmRlInSzT3sekUwQvRC49DOdHSumEl+a3a
 XFCuT5dX/Ia6YmppxjXcws/FiRxy6SRU1+hTAlFBj4lEg/751D8YYN6PQXMVA/JYGJQc
 SyYIqUx+YCGwBKtZWtXtFY6eySi+erZ8w55kiza4fXf97eU0DpUYy5nqkhd9ciGYOnSx
 kOOIg28MOBLsx+uQF6AjNq0CFHycWctuN6Dih2IH0DY/V3G0oHb8xJkZ7EN7V8b30AA0
 Pkrw==
X-Gm-Message-State: AOJu0Yz1dx1NQ1Vj5rfmOJe+vCYLEQJtnBSzihTkw18yKyxKCR409Nye
 dyyLTMmO9tzYJ6Vv+s4VLuATASxcHfysBWRm5m4uzFLe+UzIMzOg5rjqOrYLpxhV5sMs4Yn1M4r
 T
X-Gm-Gg: ASbGncvH+1T3QkdLhHq/JlqSSoLwI6Zcza90J172KqnJHJjSOV9mRHZ2aYloS1LcOo5
 GmnjacTUh9CYxFMIuYVo1C8e5QLiUTu8KBdZl16431b+QK5biLsC2rTe8Bvg+HSJW0PrKYH/stq
 Bkx4xoCdaY+JqRrNW7r7nx8aPVihoQHdZSsUZe7JHVe6sXyDI/PWtRWGpNwSoMtvOo0sUlWck08
 fgf6QcutD5fpQzxovsRTg638BQRk6U+ntbJ3c1taRPiT9Rvk7G6Jwunm3Dpy+j86tIEln/Mo+aV
 pYBo9FeKDYuL4ot7uQzj41jQ+jPAhr5Ae9Ki8RxwjOVw
X-Google-Smtp-Source: AGHT+IH7BU2m16/sgWEFUPShLOXk9J0IKxzRbCfN3ZFlgtRMYkB/snGd7MYIM9wzSgKzXv734g5omA==
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id
 d9443c01a7336-22780e0969cmr15319855ad.42.1742509825033; 
 Thu, 20 Mar 2025 15:30:25 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/30] accel/tcg: fix missing includes for
 TCG_GUEST_DEFAULT_MO
Date: Thu, 20 Mar 2025 15:29:44 -0700
Message-Id: <20250320223002.2915728-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 1 +
 include/exec/poison.h       | 1 +
 accel/tcg/translate-all.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index c88f007ffb7..05abaeb8e0e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_TCG_INTERNAL_TARGET_H
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
+#include "cpu-param.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a6ffe4577fd..964cbd5081c 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,6 +37,7 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
+#pragma GCC poison TCG_GUEST_DEFAULT_MO
 #pragma GCC poison BSWAP_NEEDED
 
 #pragma GCC poison TARGET_LONG_BITS
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb161ae61ad..8b8d9bb9a4a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -43,6 +43,7 @@
 #include "system/ram_addr.h"
 #endif
 
+#include "cpu-param.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-- 
2.39.5


