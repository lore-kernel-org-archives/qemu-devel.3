Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238F1C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG10-0005uv-3o; Tue, 08 Jul 2025 17:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEj7-0001S1-Ea
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:15:43 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEj5-0006Fg-Il
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:15:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so7825147a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752005738; x=1752610538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnYFvx6AXsQG6APrU5M9iBhs/2lPcv8r3Vcv3up3nPU=;
 b=rOUvOwuZq85TPi3CbESgY9tF5RHfoCnqijyn0LrbV9tTA4v6IA05s9Tvr1o/y3Hcds
 sz2ZTmZFUh9VnXmGcqZEofBdgPfWE9yNzatF06q19eXDyeoqZODwsbIO4Tfev2KLkorA
 LRjAC8nf9VUMBrGTFJLKs4lRCFyUa+hTfIak4HlIj6GLnap31AwS/Fn/EuKmeMpGfFIL
 H8jtEnWEGG5emu3MHdHxl0KBqNOqsuS0yIjFWKpfBsD7wGR6r7hqDHWuSg2fAmxnG54c
 SQvhQeogFIlFuGfJFkJ40l96ModQTE+Mu87fkmy0g/P8GHI7duPGtjI0UFijn+mLemE/
 nltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005738; x=1752610538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnYFvx6AXsQG6APrU5M9iBhs/2lPcv8r3Vcv3up3nPU=;
 b=T/AFEg1hw3EcGoNyHlfVmI+y2eoDzpSQXPoWMgnbPOHS4o7X4zqnWi8/BF2dRpdhJp
 knSJ6IXMRY07V2Tgj/HRQOl5AV0B1E5f8F868mcK3zRH40+1O+raW9lg2kYfKAUlAkvX
 Rpeb0e+Y5dgO706VTfzGcK4shOcBFocAOCfZyH2eXc7r4OIRPf/NG0VC4AaZl9JOWPdn
 66u8U55obl8mKAx8upmjNSU+sKb4g/DwK2VTmnkz04LkmqY26ZbZrCufq+WTxMW0IeJJ
 XI32JEJooNQBRUA5jtzRxN64fSByAqg/sGUfSUxGl6UOHoqW3GOlAsLX7KRNyxVDex36
 0sMQ==
X-Gm-Message-State: AOJu0Yz+2nwAPRfQvorwsWlm8e1LDYedB8SbJkcTavAD0v8OTl/itgNz
 at1cTPQfu6njydIvuFZPmt2XyS2MvSMb02K3oSaC/wB8RGMiMg+pHWUeUuzs1cCOjvTgnXb2Mxh
 jddH89+8=
X-Gm-Gg: ASbGncu8aqYrlKgLyma+Y87ebCpuVMAasTbZ5qftd6eAmnwsD3CztLnwRIf2T/taSzY
 7ROS9C+cEwjYqjANAOoHfzaifDplOeqTVxJNglxy7G9OVO2EY85NpUZS7MI47iZrAlCSB+qzJ9K
 d34MG4nSzsXYVhudLhYgt0C4W1kS+pN8+qIJsjBoE14nIrRWEg15XIN15fBi2VGMWjsjJZSpJhR
 VOcUBnXsd43vr8YsOP0jh1AG/ej6oFxLWaXHxKTKUjFyXkGiRYCmcKJqwzIgmmJeALTvwKVd0pS
 DoYgznDMvGbyibetMsKf4v3YYTETtY7Ryrkb2/phlbcDogGOo744DhJFEAqKMtkziOIJtoGJZt6
 VeB70PVfbcd5EmgiAxdfC0PEWdge65CfrYUr/
X-Google-Smtp-Source: AGHT+IHShx3PT4QrBDd0iJjUGdHk/S+xmaRokGhSzwyRI1wbf7xc5xJ/Kapq4GhtVJmZoDbpTb1FmQ==
X-Received: by 2002:a05:600c:3153:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-454b4ea5f53mr176105305e9.16.1751965151114; 
 Tue, 08 Jul 2025 01:59:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd7e2f5dsm14708225e9.6.2025.07.08.01.59.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 01:59:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] hw/vfio/vfio-migration: Remove unnecessary
 'qemu/typedefs.h' include
Date: Tue,  8 Jul 2025 10:58:58 +0200
Message-ID: <20250708085859.7885-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085859.7885-1-philmd@linaro.org>
References: <20250708085859.7885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

"qemu/typedefs.h" is already included by "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/vfio-migration-internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a8b456b239d..00e2badd889 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -13,7 +13,6 @@
 #include <linux/vfio.h>
 #endif
 
-#include "qemu/typedefs.h"
 #include "qemu/notify.h"
 
 /*
-- 
2.49.0


