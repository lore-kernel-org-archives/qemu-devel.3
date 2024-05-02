Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55FAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XQv-0000DF-4s; Thu, 02 May 2024 10:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2XQt-0000CO-QK
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:29:11 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2XQs-0001kV-9Q
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:29:11 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2db101c11beso95490711fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714660148; x=1715264948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IzTYQxXA15CKrEh25p1hdM44GrHltJy7g46cuEmtUgk=;
 b=wWVrNXchnPLh1SRRR1TfzgoHSZweZGXwTNOrrFpiL7lVyoWGZG1Z7CXKP3hnhdG0b9
 xsREAXChX6J00raKaQtR3+nxs5ryrvdfMs1gf5Y8TDOG808xiACYxT6U3yVBjqE7+nW4
 ipNuHn444pO4CCaKyR961PK+Uq31fZRI/UbjoQnj5UQdsl6HtP6x4nwhGJk4Xt3dd8F6
 1As82PYifq6m+nZ9r9diUSu2NifxjfuLN/OUSW5xIm9caDc3Hk7ufMYcbU1O+3doH5GZ
 Q5j+p9wEKR4TmIW1axBloLHVyvsQsHXZelUxh06qHO+Uj4+IPXdx7JbiCAvVyQm9f3Sq
 guSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714660148; x=1715264948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzTYQxXA15CKrEh25p1hdM44GrHltJy7g46cuEmtUgk=;
 b=D+0ZVkcnrATdZ2gEAvgENubLxv0IDgub7HI2IjV1/j5+FBJRrNjOo7141QDdlGY1Q7
 aTIemYqbnohoZz3irHcJcQwnhuTpVNT8YIOtUyDlpnL0XMkUZWEZUVLxvFehpm8qwioE
 E37Ed6IQAg+Ub4vGwAX1RCSBEaqi/GD60BYbEZ+iLLBraqX6SA22+UnVNf081pfigzCV
 WA1t36HHiMbETuQv6eacLBiTShrj2xX/XoJewriOumXc0yMxEFNx7/qEENUhTypF2TPe
 yPivMbeKnqGZ8f/SL0kZbXIBdOOFYWdzvrkbhUjhkIUF04FYCS21n3hUBaLLfjBynkwU
 STcA==
X-Gm-Message-State: AOJu0YySX5fsahwUPm+Ox91LTa+p2kI28ZvnlMHKu8thKq5JQo6rqeih
 /l5479xDoGPeJw3fjZMJ/g/ms6Zy1hifijqG8OKAquZP1OQK4IwnaPl2e3Jabo6OHqSG2iDQyrN
 x
X-Google-Smtp-Source: AGHT+IFFKORn4jgXgD8pRCbpwEkzVeXnoq8C2HdtiNv9UB1FFtWZ7OsrAhGRZ7I0t9oyD79RdeIiJg==
X-Received: by 2002:a2e:a167:0:b0:2df:b800:5bff with SMTP id
 u7-20020a2ea167000000b002dfb8005bffmr3603651ljl.7.1714660146338; 
 Thu, 02 May 2024 07:29:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c470e00b00417e8be070csm2112941wmo.9.2024.05.02.07.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:29:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] ui/cocoa.m: Drop old macOS-10.12-and-earlier compat ifdefs
Date: Thu,  2 May 2024 15:29:04 +0100
Message-Id: <20240502142904.62644-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

We only support the most recent two versions of macOS (currently
macOS 13 Ventura and macOS 14 Sonoma), and our ui/cocoa.m code
already assumes at least macOS 12 Monterey or better, because it uses
NSScreen safeAreaInsets, which is 12.0-or-newer.

Remove the ifdefs that were providing backwards compatibility for
building on 10.12 and earlier versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 25e0db9dd0b..981615a8b92 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -50,23 +50,10 @@
 #include <Carbon/Carbon.h>
 #include "hw/core/cpu.h"
 
-#ifndef MAC_OS_X_VERSION_10_13
-#define MAC_OS_X_VERSION_10_13 101300
-#endif
-
 #ifndef MAC_OS_VERSION_14_0
 #define MAC_OS_VERSION_14_0 140000
 #endif
 
-/* 10.14 deprecates NSOnState and NSOffState in favor of
- * NSControlStateValueOn/Off, which were introduced in 10.13.
- * Define for older versions
- */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_13
-#define NSControlStateValueOn NSOnState
-#define NSControlStateValueOff NSOffState
-#endif
-
 //#define DEBUG
 
 #ifdef DEBUG
-- 
2.34.1


