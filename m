Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11610C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtkh-00043x-LJ; Tue, 13 May 2025 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbk-0008Pf-JU
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbi-00039Y-WB
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so41384235e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157995; x=1747762795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlgmqWinD7NQwKFSRiJub8ZlgVYRN5tlN02/pnlcz3E=;
 b=H2lcgZv5lkwQ2TjE6djdysechGwVmP+Mfhq/Bc69c6e3mNH8PDEikqxA/89a9pW9vG
 p5zgZXWqpEqkb1Axq+a5HOtUIRQvHNmBFnELZZWOwrhG4YAeCpn+o+4CUuJvbbfP3CjT
 Ar/F8Xfyo+ihd6Y/kPz9Cw5dyqmt0fbVHdpR5izTdi9n8gKjNEExChNCIKO0JxJ77jfV
 eY+LU3B/Qbp6r2+zBgfpCDF2sg69hWiO1vEy9p9Q/NbG/w3rJgL6cUmxozs/dSlrHI2D
 KT84aze0O/kbafG/OjHmVITlGHrjqKM4gfxORqX9wRvGo9RDkZq/iKvt3RMtDfDgtwTI
 oqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157995; x=1747762795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlgmqWinD7NQwKFSRiJub8ZlgVYRN5tlN02/pnlcz3E=;
 b=dqrPvtsbMkvi7AQLsORsXXtqgsTok2ES8/MbSYHaLmzO3IzT12jGFaFT9P1TmHoQZY
 ybL18taccy5q7bz+7RdoRL/x9GbJxBHWGlThfCKwGUJBz/rrMqSEdzK48PPfSClnOud6
 tx8ci/NL6le183UFOPDzbgVkcfE5tXsbKM8/Sjr7E7Ry+lFLL9arLksF+KWgdQBGd4pA
 ZxGEUtv50dRmHr28j7rLEYjkw9TwM7DKIjOAnrJKv5gbl+pRovIJixrFQQAuWM74dj/6
 stkdyYodkUGhSCAWvvL44cQFRrF8zGZMs+liqsMRpuNbPEIURsz2tA6gyiS3oP8zEHXL
 VG5A==
X-Gm-Message-State: AOJu0Yx7rfhiP9jWmItCesLDMYtOIgKNOsDH6naM9CalxhmFocl2tpiC
 VhknUUja19nSqviJiPndvcRK2TPNV2wYIlSeuvULEcSG3Dt0bH1w4ABlqIQhCy2jtGVRGOn5BXO
 EQRg=
X-Gm-Gg: ASbGncuBmNvGJ1MBGCgqio1tKmoOZdUYO5YbNIYejxz34SYxJUTjvBW2kHt0IkVG5DO
 hBkvscEUz/FJNPEz0wOlOP/xu9d3VrF4SvurNXga67tJ2CbV/uk4ku2d+bVA8B4qe/70JCCpDAk
 B8qRhzdgPCuMKs/U5IA1NreKBFMXkjDVFFxuUohavfCeHmAmoEXufk1avRjOzSsDzBXmhtdqxoX
 ZV2HiZMFx2fSutVFnS6PxLj25aMvzK/hugWU0MsukmueAiSuFWQsFTHC7Crqbdt+xsd+EmRKZvA
 1kdoQeS7Yd8gKqxAGBIVe/axN3zbJKy5pXMVjUGF97gQsQg+Tyfsi8126kbpRkAKjkKMEpEUmjG
 A2+r1rb4MEZK9wljXWCJ+FWbeX8qd
X-Google-Smtp-Source: AGHT+IGqRbFScHu2W0GbObbXHTUW2MB0R4YO8MerGHgXgvH0XR6Ui7KH71IAcmB+7F8jtxq09KXjzg==
X-Received: by 2002:a05:600c:1c12:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-442f20ffcc5mr2233185e9.17.1747157995571; 
 Tue, 13 May 2025 10:39:55 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2b29sm17198563f8f.53.2025.05.13.10.39.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/19] hw/arm/boot: Include missing 'system/memory.h' header
Date: Tue, 13 May 2025 18:39:14 +0100
Message-ID: <20250513173928.77376-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

default_reset_secondary() uses address_space_stl_notdirty(),
itself declared in "system/memory.h". Include this header in
order to avoid when refactoring headers:

  ../hw/arm/boot.c:281:5: error: implicit declaration of function 'address_space_stl_notdirty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
    address_space_stl_notdirty(as, info->smp_bootreg_addr,
    ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index f94b940bc31..79afb51b8a5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/system.h"
+#include "system/memory.h"
 #include "system/numa.h"
 #include "hw/boards.h"
 #include "system/reset.h"
-- 
2.47.1


