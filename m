Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C731D637D6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBORM-00080w-Q4; Wed, 13 Nov 2024 20:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORK-0007yw-QT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORI-00025Z-7p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so77988f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546866; x=1732151666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzDo0drcf+l9FI9MFOgWksxtiPTKy7V4t/YiPF1FVxo=;
 b=xDaKBRynSr8JeDchNRXFzlr5P4Up95Wdv+eHiQ9jC66t08D5310uyNgC4Omw+ZX61O
 BGz6AH0v6qQjF5lEfA/lc2fMYunHf+AK370mDhqDvhPPqUUO/50hw7HncwkOgFI9fsVU
 M6GxGA3GvrGBDmaG0SkkV4/TZGbsc7HKRYIFw7bbej5PY5sPFmdkA03vDUGt+FczBi4j
 YhMO4jiUyYhm3MhZiOu2+AyRJ3jCwoMNz/iWStLyRif5riDAGZX6xi6UYNJy+LjzvKbr
 1I5cQcoIDTlwrnhjaYYP1ynjrt8zMUW6dtYkRY+C+owL188HVT5CERjoCX89sRvLKJCj
 Ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546866; x=1732151666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzDo0drcf+l9FI9MFOgWksxtiPTKy7V4t/YiPF1FVxo=;
 b=WPEbSPbTcnYtH8d33WOQtaQBP5AHQawTTTHorFyDnTElwlaC0W2gJm/Mq+jJGHwBnu
 BeXSBXzTgSYTvqjT/nFOVTtFjGWDrt94KvhD+aSAAWHePQGQ2bU2a9EC1N4tyI6v9CGY
 WVO/wwDvb5ROQNdjvLZSVTtcHnPr4U+Mz4/nXMeBCCYNgJlcCeggZc0nev593QR7kKc8
 63yCVHkKew99YwOQT6KTlU8VkbYp6mojFbXkJTSWoPuvZUZQ7kUOADgEUVwamBtyod4K
 2vgBOjgiB8GoCgqDA4+J7cEVUjlwkaP4FJhp/2NOiJwRmTuzPVDhpi4XINddlFebrRl2
 itXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1VafjC4i8R4/zVaptcJRJdps+S5CvF3YSKbWFAEpMD5wzoPq95WFML3MWUhJN+34nu0AT8nof03QY@nongnu.org
X-Gm-Message-State: AOJu0YzO2LacJdYRGcgYBteLe7CVTzeet8NFzIyJ9w98M0ffbdeaVogf
 gW8rs2rZUnzzwROBWS6qTSbe/JmCfd9+03YwyOv2DKNLoLyri0ntM9Vl0Qv02Uk=
X-Google-Smtp-Source: AGHT+IGRAvO0UPawK2zfcCGO//9i8AmO6U7NK1zJgE+Z8dy6kuyS/IdN4ms2Ng8UXNa65KniwwxN/Q==
X-Received: by 2002:a05:6000:401f:b0:37d:3e00:9a9b with SMTP id
 ffacd0b85a97d-381f186cafbmr19128225f8f.20.1731546865946; 
 Wed, 13 Nov 2024 17:14:25 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970f68sm19860449f8f.11.2024.11.13.17.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:14:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/24] linux-user/aarch64/mte: Include missing
 'user/abitypes.h' header
Date: Thu, 14 Nov 2024 02:12:53 +0100
Message-ID: <20241114011310.3615-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

abi_long type is defined in "user/abitypes.h".
Include it in order to avoid when refactoring:

  linux-user/aarch64/mte_user_helper.h:30:42: error: unknown type name ‘abi_long’; did you mean ‘u_long’?
     30 | void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
        |                                          ^~~~~~~~
        |                                          u_long

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/aarch64/mte_user_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 8685e5175a..0c53abda22 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -9,6 +9,8 @@
 #ifndef AARCH64_MTE_USER_HELPER_H
 #define AARCH64_MTE USER_HELPER_H
 
+#include "user/abitypes.h"
+
 #ifndef PR_MTE_TCF_SHIFT
 # define PR_MTE_TCF_SHIFT       1
 # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
-- 
2.45.2


