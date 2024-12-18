Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588AE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLe-0007XN-1i; Wed, 18 Dec 2024 10:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLc-0007WS-5t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLY-0006QP-Tj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863703258fso624677f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537138; x=1735141938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ib9+afMAQlHaOpnPQrKm50FlQeuT4/NIcMi4TUV3nMU=;
 b=LjgXGtJKT7zOZJOUdMsBIpBQe1wcgl8Tsap8FWqqGrBxqwUMHBMbpFPM7wvruq/c62
 SCeE/UqgxnUllBd1UaoOiO3vHUjrHDj1ZRUR5gj15eTKwL2iMlnvUKRdLSFi/CWbGtBE
 q9GtfJhbsc2FEfMTCsPbq+5NYi3fGKSShh8t4DkDU7+0vOv8jj2ag54tpDu8kIxc2b7K
 Yet8rgczkMxelGgqUHI2J8iMirnyicg+0rauhr0pmTc2nRIcoFUhpAWKQSoICZXDzoPf
 dJSGgEad8H3PYxle2JihpQ35Qs00v+wPfR3z06cXWTVO8O6vX+N5T3+kODKihKI05GiK
 Tl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537138; x=1735141938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ib9+afMAQlHaOpnPQrKm50FlQeuT4/NIcMi4TUV3nMU=;
 b=sp5LcizP7a96zg/JCBKXX4+WmvHZPtS5mtvhbVqZbWEFwxqDV0PEfbUWQlkJP+qrnm
 Yv+W7njs9YO4aPSclFoTaohWnDh18eqFW1+pvzipZmOO3H6sti/4LeF6e+qHWVyyuA85
 uYFDtEYz8g39Q94bgmvZoMqZS0gKtm9MurJTzjdA4VR1NuNtZRbgPtzFRsjPLZ/FoGdY
 fQvUcQm9+IIrOCrwi3l9rLSIGNGI+fVJ54xwRl+keDmJngCoAhB6p5ftKfUw3I4JBgpZ
 5e4xee93GG7fYOPo0XDgd+jHb4+rYe5l1V85vxBWMCE5Zy61645gNUW5GgZcCPL7HOAa
 wosQ==
X-Gm-Message-State: AOJu0YxJdiYPea1io24dIWLYIxjSznoobpNNETgATl0SwvP9+7PjJvZL
 KLiK8Zmk22eqoVrflqjRul2PqmHL/7qyTVsVceYjwZRFYJNKoIaeuD3/kEeizIVgAbzXJl6eVKr
 y
X-Gm-Gg: ASbGncvWBJPHDpnBJt9nLks+y2zpEAR5leF86qx4Tcfd09sBslg9s4by7124K6jtrmz
 SNLyjmgWDE+e3FTcfVRKpx22tpUHIGpqRBbd4iclCBlP/bbIoHqv6LKXBBlWNtNLuZkCKpMS3db
 mNPSGHshe0X27B5d14+XyLaASeiIJ4MAMuyBm+KtZksklVviArfpZxASD1WFyG1LlOATK3netLm
 xH1urt0FzKeI/x+0i7aYAjZUmFNf1Vqk2RLBq7gWe4MWpynZHhdb8Z7ryAEJMfygIIEBDrnWX88
 SXjR
X-Google-Smtp-Source: AGHT+IFTyLIZf6A6Nqzke5YYkTYXKwQnGKfsmfXbDs/d0yw7/wEkszEx61K+95hulLsoOeTyyyOTpg==
X-Received: by 2002:a5d:5f53:0:b0:385:e3e7:547b with SMTP id
 ffacd0b85a97d-388e4e95107mr3183389f8f.25.1734537138228; 
 Wed, 18 Dec 2024 07:52:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80601desm14330975f8f.90.2024.12.18.07.52.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:52:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] exec/ram_addr: Include missing 'exec/hwaddr.h' and
 'exec/cpu-common.h'
Date: Wed, 18 Dec 2024 16:52:01 +0100
Message-ID: <20241218155202.71931-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155202.71931-1-philmd@linaro.org>
References: <20241218155202.71931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

'hwaddr' is defined in "exec/hwaddr.h", 'ram_addr_t' in
"exec/cpu-common.h". Include these headers in order to
avoid when refactoring unrelated headers:

  In file included from ../../hw/s390x/s390-virtio-ccw.c:17:
  include/sysemu/physmem-target.h:37:24: error: unknown type name 'hwaddr'
     37 |     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
        |                        ^
  In file included from ../../hw/s390x/s390-virtio-ccw.c:16:
  include/exec/ram_addr.h:52:36: error: unknown type name 'ram_addr_t'
     52 | RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
        |                                    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 53785cdb87c..ff157c1f42a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -28,6 +28,9 @@
 #include "exec/exec-all.h"
 #include "qemu/rcu.h"
 
+#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
+
 extern uint64_t total_dirty_pages;
 
 /**
-- 
2.45.2


