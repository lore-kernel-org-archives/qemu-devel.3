Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A860C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZDwx-00059y-S2; Tue, 08 Jul 2025 15:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZBMP-000624-E0
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:40:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZBLR-0007aT-1N
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:39:33 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso8990142a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751992436; x=1752597236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elOwmp7p2gWDJrCVc8PFCxj0WLgk5aOuRN8kccwBgM4=;
 b=m8qy4phN1u5kMBPfFq3isIrzIcF2c9WMY5odfevECr2N2kOsHKbkjdbTvNBEQlz1P9
 rnXgfCrHoR/VOdW8FkGmIc76MTMfzk2CZWteIfzJasik3FoBY6kuzCG/PQi57BE0Kriq
 S4tJLHY5oIDRx2PmUR3zOJp8EgVYT9LIzxq15BTc8bcn7mfVR9IiURHoeBMGaFliuaVq
 yEfFqoNqD2G2WbOsxBv9BGFSqEwQtkTtenvp+1e8pCsIjljb9DpiqbwcMw5yZm6wejzy
 E90j6PVZD5DNUY9OOU7xgI6Nl05U4KdQdivR9D84jGTAj08BHJZItes8koSPb2t1evpW
 ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751992436; x=1752597236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elOwmp7p2gWDJrCVc8PFCxj0WLgk5aOuRN8kccwBgM4=;
 b=JkCeY+CAaLrLqWcXh0M2Ztcf6HlzkoKCrAE7S6msD4Jku4aDaMHkcSkYLVypHIM8jL
 HqH9Ojuc6mxupvg700jnt8fWfDYB2aryPcWJ9Khqk1idU5Bu6QPVzHc/NteZ+LQ3A7Wr
 xN/TjqIKFZkTbDnVGaG3b/STMzu4BHQo6gScvu+OGs6MZTMduy4O2Iwjklo25n6F86+a
 8f1JVcyITgRJy/Idl8adhGp58OA55AII5vLUjuzFuCJquY7JH89c3OI5q8VeWYQdpPUc
 eOiYnXlyDTBt678HTKS6oR2u781PR5IOo4rdMCEVdNgrJ+qNGQUzu+MdseL/PA1ZX2Fd
 7Zeg==
X-Gm-Message-State: AOJu0YwRlAo+HdmjZocuLbxk664lUQ0RmhJzCyxEU4ZglqPyBqDyQDMG
 uXm+dS7C8ZtXTCxhG1XBNzHYEi59K/zHI5a6Ni4JW97LOtFF0Y8ZEyVOm0Paew7TYe2WwBaKzbf
 dflDbpG4=
X-Gm-Gg: ASbGncu2tLqgEFeTcCoiHI2QISczKwtl3nhuNJz/DRLIZV+SiMLIVPpYbcm7V0ML5i/
 Onw7Rq38H6YMR4ph+J8gr7zCZ2oMqoc7SvRCle3mV5SpLJ+5bii4VhlCA28DSXABlLGkSRpjKTs
 R8srwZWz9qaAtxzINW1t48MkqRa4VZ+xDLrxgoLX3N4gmnVy0+XH7K/44YjthP8UXaFHCszCBMU
 4BdwPChVbvAzM/MkHXJd0S2UP9ORP6r0btMJ5/p0un24xHBawMVWqbFOP5+q+KO6hEv5SGlkOuF
 JKht8HJmNFuPAoSNaRVwRtIFwfOtrsvcx+/lLgT3IVacr9RSgHPxCzOkfDs+Ely0bKXM+IHJxR0
 WOncOyHiW+la35jRx15jwu6Q82O0LT2yfaD8a
X-Google-Smtp-Source: AGHT+IG1FiabDSkCtdfckU+iXGgc1J8lgc9D+6N43pep+Er7XIfs7hkE7o94x1wdTRWGkegDjI/Pdg==
X-Received: by 2002:a05:6000:2483:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3b4964c09damr10255699f8f.19.1751965146374; 
 Tue, 08 Jul 2025 01:59:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd45957fsm15131915e9.17.2025.07.08.01.59.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 01:59:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] hw/intc/loongarch_extioi: Remove unnecessary
 'qemu/typedefs.h' include
Date: Tue,  8 Jul 2025 10:58:57 +0200
Message-ID: <20250708085859.7885-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085859.7885-1-philmd@linaro.org>
References: <20250708085859.7885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
 hw/intc/loongarch_extioi_kvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index 0133540c45d..aa2e8c753fb 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -6,7 +6,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/typedefs.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "linux/kvm.h"
 #include "qapi/error.h"
-- 
2.49.0


