Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51227D3398B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXg-00049m-F9; Fri, 05 Dec 2025 11:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXe-00048w-JN
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:22 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXd-0001Zk-33
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:22 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8b2aa1ae006so286520985a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951620; x=1765556420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IopA0wdhUDZuqTwawVtAEVCBYq9WXZhmde4vE8cm1yo=;
 b=fb0hFsOmbK/wVc9P0r+UK+/nAoBjPvgM9XzZBdMS5FEQfJjJ1SeiRNvyCsGwAkgvKH
 H+lnzfhjVO/4pMZfIn1wwUgf8QDujiOEvF0ud7bErJkEm64lpzBBw45UbmJaNpaEgKOa
 bsK3MUQi+3STguDMFiybc1L2zInSCTXMFBhTOs8roXijTeQzvqQst6VgBIS6YDOqV5h8
 JmV0cIAoFu7FfxcEGlAXLkGp6MDqz3kq15/Fpp4zCyAkrgs9R1A7eGsohHRCc99HnZLm
 A8qkhMUxacCozW5/byo7JsbWDh6wuW0SMLyodgH4ovNj18VePF+zNYXFbdpwyYX78Qh1
 inIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951620; x=1765556420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IopA0wdhUDZuqTwawVtAEVCBYq9WXZhmde4vE8cm1yo=;
 b=YLCKOSoBvFmVxHu+0mYd5IsGkwBAWgi3VN+LeMzr4Y9CYvRSPTodCDuzzo+Xi/lOIK
 D/s3MoY/U7yplscZ+R93IYjnbrM6VNJoYPLDOUcZ1GAn+7g9pSmwQ9D0ZGxOO+AYJPzq
 6Gta7RdoHJmU0ENiuLTAMre0t63Tn9BXFINcuQR0wIT3UAbhNfbsDtXNozdpvytzq0uc
 zV4kHV2fvDe4NY6uAQGe2UhJpvsrBV4t97Xj+Yd/aL5OKS58CXO5+BMXCdAlWeMoOlKa
 /8d4P/due86WYnLy+tU5w8EK5gzwXdKoZPCo2GuvzGISny8ZFZnk/7DwuEyMkOOpUDhx
 hYnQ==
X-Gm-Message-State: AOJu0YwC1yYka/NrRcVWw0sdoRGMF+N5T36/Zoszgjs8g5p+1IadXADL
 tm28QrvFNJBptHOJvqjDfH8laXA5v2J07/O6jmNSAFMKfIatUI22/7JD23SeSTg6dVrNVMhqgPi
 M1vKIJn8=
X-Gm-Gg: ASbGncsowuZPYWawmBhnzziCkCwbZxM0TjPbZqZ6bA24xhb4f4UexsdpscoGogagv1p
 1rIIo7Kwq4deVKkFZD7/bvhOBfxAnAt/gXvRlPBBEIcgF/KpTaNS3v80XArpX/rhd0q4XCjvHUR
 XA4QSPLHA1llYzq9Kp4QRwpO7RGhdp+MtZosOaicTpfUL81N/VFBc7+i1YdZxOCgRUfAkXYDKG9
 BH1QfWA8Yo8qHv6+w1GecvYZq+42elY5bJA7hfdHRfH3vUhZeDewhKcAMXdbLMRrm8Xg/FWmz5N
 1YKOii+0aGc2KOeDy5OKNvYRKL6teUMV13SoUe9CSsBPlcoQasbswLHK/TNuFUo3ywyfY2oy/7F
 rQ+V9Mts+v6mu70cLlw0l6TtA8qvVUwOmhXiTSMuW8Z+1/2Lc2k9v6oYXQQkGaBsItihugr4pjp
 OhAs1+YG4Y5qGFejaxdlz3o51ZgTZ8/kVKZgm27c8rT04TWZKtM90i0ehbOxRVXw6zRQo=
X-Google-Smtp-Source: AGHT+IE08JdSXB3wTbHctlp7ROToxfyOvJPyJUbRcO3XUT0rTCZK9EmqwQRbPBDFIP8FpctdCc1J4A==
X-Received: by 2002:ac8:5fd2:0:b0:4ec:f156:883d with SMTP id
 d75a77b69052e-4f01769c538mr151784621cf.43.1764951619749; 
 Fri, 05 Dec 2025 08:20:19 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
Date: Fri,  5 Dec 2025 10:20:05 -0600
Message-ID: <20251205162007.26405-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

Since we build TCI with FFI (commit 22f15579fa1 "tcg: Build ffi data
structures for helpers") we get on Darwin:

  In file included from ../../tcg/tci.c:22:
  In file included from include/tcg/helper-info.h:13:
  /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include/ffi/ffi.h:483:5: warning: 'FFI_GO_CLOSURES' is not defined, evaluates to 0 [-Wundef]
    483 | #if FFI_GO_CLOSURES
        |     ^
  1 warning generated.

This was fixed in upstream libffi in 2023, but not backported to MacOSX.
Simply disable the warning locally.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa..49a27e4eae 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -10,7 +10,19 @@
 #define TCG_HELPER_INFO_H
 
 #ifdef CONFIG_TCG_INTERPRETER
+/*
+ * MacOSX 15 uses an old version of libffi which contains
+ *   #if FFI_GO_CLOSURES
+ * but does not define that in <ffitarget.h>, included from <ffi.h>.
+ * This was fixed upstream with
+ *   https://github.com/libffi/libffi/commit/c23e9a1c
+ * We don't care about go closures one way or the other;
+ * just suppress the warning.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wundef"
 #include <ffi.h>
+#pragma GCC diagnostic pop
 #endif
 #include "tcg-target-reg-bits.h"
 
-- 
2.43.0


