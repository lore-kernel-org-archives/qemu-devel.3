Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DC1D1266A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVP0-00034T-Ry; Tue, 02 Dec 2025 13:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVOz-00034H-N2
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:47:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVOy-0002GT-22
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:47:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso61785985e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764701222; x=1765306022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96nCGGqYcc5xVj4N02jySrfL9ZzT3L6t/Ls/jHE1pow=;
 b=d7dRtkP1wg48hbIwRD7iibkhl4V9xRv/8OzJrjvAo8SUce7YCnSZ9n89IwIfo5qwcq
 kNAYBxtW/0XXXbOi3I0DHdfKYilcX8CO8n1X9LSK4NxPmVEnk59YtzS0QnbK1EHGQ/4K
 EnJCGtV5Th+mqzRVUXCed4lkW72D9SgfkSsqJUR6bOheCxgvCdt5bQs1pJrt9qdPDIxx
 ZYN5w/fIqzK2skg+E7uRjJt+MKJN+RIrarrhQ+Gb9n4bhkAp9+ZBfzo+cu45w35fYwXF
 9jBTqB9lLyv/dzuXNOBo/8jd24kPk4wBly/OXxbxLnb5EZ0GjTO6/1das0yWxs/cKI+W
 xf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764701222; x=1765306022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=96nCGGqYcc5xVj4N02jySrfL9ZzT3L6t/Ls/jHE1pow=;
 b=B5M7G7feQIPDHquLxu1B9Pf6LaMYM02OmuwojEsKEVmWH0r+EUCz7ITxHFYZp0in+o
 DERoDLl0RHjU7oPh9P0X3WmSaODJD5l/qgYnNYKHVmx/ddAPNFYi/rwKFE+PkZblP9n2
 fHTZi9z/2dV/17tva19mB7bRKZm6Zf7brdWKvgbMoyub6JuZrlLXTMXdxsnOW2Qumnwv
 C1d1dpXSioyH6QD1zJWdt11oxQ91m2ShHMUPFv/NKm0jy8fZRp3ZzjavOFXDy0SWIfyl
 vSNMeqqDONR5Hg/O29Kztbc2UsUXlGcdicreSzL6z3STuELQk5ksBQTZLpjCkcGz3WDC
 3A/w==
X-Gm-Message-State: AOJu0YwWlnFou1Z0Ai4mINJvxNeARz4bNqHeKyPVfFvP0btYcRFsjbjl
 nlPzc8tiFM80OIGJs3DZitDV3fpoGt8SDr6Z13XWhAhSNAT1kone9ToiTkNczmv5ILPALCGrkdg
 RAAUztTM=
X-Gm-Gg: ASbGnct/5e1pg7E2CILjxDZtOWKrTCTnHsqOPodxcYBNFepo4spkI+nL+PSquiXWh3S
 eNNHk4aCH1VFv5AmuUbN3I2n69j/CCdV9+lXB5XhE8+AFY1kKoD5nQEGFYwsUML6qMG58xKjOaU
 fAvOmyC5BtQIo5FGLlfgOecLIDX7zA9l2TO2w+gXsoi5C4j1KJQ7CwDvIlO4xQQbd6THG6Lpkjp
 OHQgbWw/5qUQMlwLTXSXWqk5Tz+vzGtB810czRfJCIZ6qzPSMvaaB4K7HGbdb6CeKDVmvjTvwFe
 mffGW9qqZtHQSYcFtkZltFUCIcnsTawSLvIeP1PYgOO0vFgnRNTXZLHDf1c75uum2UXejRHGqT0
 GQPt+HBXn4MWNBEOx/8NKFwy9h0MkKRvqRj6VxR1FZbcgb9gPkOeMhmnE1D11RUQZTRZuRO9Jtb
 E6wH5mr8vT83G4cwVJ1d2H3WNWGdiM6g3eYTqHA3x6CySc99EEECTcmrYZZTIz
X-Google-Smtp-Source: AGHT+IEbmaGmWYca6WDGu1UXVHgNssfkr/39XbGT9iz28nv4dWSR01G+Ymc39YO4WQ25Rl08iXkkcQ==
X-Received: by 2002:a05:600c:1906:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-477c01d47c7mr405777205e9.20.1764701222118; 
 Tue, 02 Dec 2025 10:47:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a3f1sm34659320f8f.28.2025.12.02.10.47.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 10:47:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2? 1/2] tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
Date: Tue,  2 Dec 2025 19:46:52 +0100
Message-ID: <20251202184653.33998-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202184653.33998-1-philmd@linaro.org>
References: <20251202184653.33998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Since this libffi change was committed more than 10 years ago (see
https://github.com/libffi/libffi/commit/e951d64c0852), just define
the missing definition on QEMU to silence the warning.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/helper-info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa3..36bb7f8187f 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -10,6 +10,9 @@
 #define TCG_HELPER_INFO_H
 
 #ifdef CONFIG_TCG_INTERPRETER
+#ifndef FFI_GO_CLOSURES
+#define FFI_GO_CLOSURES 0
+#endif
 #include <ffi.h>
 #endif
 #include "tcg-target-reg-bits.h"
-- 
2.51.0


