Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94335C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOw1-0001MS-DR; Tue, 18 Mar 2025 00:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOve-0001FI-2m
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvb-0008W5-IT
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:49 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso3824872a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273505; x=1742878305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJs8jpuU5VHY7crNqDB8k9WdWD2PL+VSpwoAKAzM9C8=;
 b=ZNiH/HBFwJqkyPHZh4epSoAHEC2nRCCp/F2xdUwthnIh2NmK/a7vxwoVwy3KAOvPjA
 s9MBHmwuTYobOKzeFY/142oZbVnN35QQmuJ9u3CPBHj2w9JnEM7XpXdpj8kUZNyCzXYS
 U8YkinifZfC8siaUWnw2/Q2yGpxhiE63S+IPSqzOXPuoPiqUJAJQstJHpDuhKS3BDlZa
 Xlg9n8xaA4MU5Qoa1wLfAVpyGsiZEog6dX/WOj6ZXymT1xpJdXbEHkRTD4DwgaqrAorP
 IOQdjzw1IQiumzEoLT2Moh3GXesJ05BA/0gg+nKFYNMsg+1qoJ6LVQyQ0pWyJ+1XJlin
 xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273505; x=1742878305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJs8jpuU5VHY7crNqDB8k9WdWD2PL+VSpwoAKAzM9C8=;
 b=dRZEEkTeU3BhEgRjnRj+B/XfxRW9OAmjXkxn/rmn9uK0/jmmofHU1d3H9pbS+Msdv6
 odiFApbzg13tvRzQy+pmUC7Glw2Yn/zj/6EKU40KnOqaMhUDb77xU57g8YJJtEzdcUCx
 Wb3v9D0BBcR/nDAMzRDQEwNScYzSvjqjszopXbZEARHyaL+jfSr5lLJHaG0c5RJXL1Ni
 3ZfgsqzmbJRNjSfiog/8aVTvJxn+n0UdMZK5QzkAFMcLSwlBMNLvmbyJLonuH4nscvna
 aBu08bmb9urddQv9Jxgt8jbzT0KOEdPQrNnfZpWw3sl/s4nM/FHzfV3wH82/Xyvmq/Hp
 0BTQ==
X-Gm-Message-State: AOJu0YwERrK+C6LDchIStZur4zcU3m0u6uAjJDdv8fduZy2E+DN2n9Bk
 u/AG0cIs7hPrTt/Ww9AuRlrPeonGiv1vdo3ficBW2Nv80EfP1NOlktCqoNYwkTwP3EzuceqCpJv
 w
X-Gm-Gg: ASbGncsv9DbHyy3vM6QQIreAh2rkZ3cVAXWNrRKYx4znf07KJQOnvRbPavhhf+SdVt+
 Nzo4zQEXdpjt6NPmN3yluQSsU8Rtvw7nNdZXL5V2/3nLJ7dt9/Sc/NnJj3iIipR12bQaI9EPgDf
 j3KgTpQtMoDbiprIPE0ps30sHw+g868hfummFj4UVbKeinJ8iM5LVNArRi+fqvoA3AC/uKXzVvK
 kKsO12ulbWX//PrpRu2MF6q0uhL8Q7HwgD78S8CqEw0MtfyW1+b4dj2cWGDGjSxH55aOLKKeGWU
 C/gX23gBA7HwfF9GZDH1VQ7t/uNn4FdejXa9eqHosSanWF7hdANDet0=
X-Google-Smtp-Source: AGHT+IHEmBiDYdH8DpN4X2712XG3vEXoAh58XN6VBOwchF+ihZ4rs3b8Wb2Qrcz+iN/AtHC1fq47cw==
X-Received: by 2002:a05:6a21:1fc1:b0:1ee:a410:4aa5 with SMTP id
 adf61e73a8af0-1fa50bd891emr2581469637.17.1742273505380; 
 Mon, 17 Mar 2025 21:51:45 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 13/13] hw/arm/boot: make compilation unit hw common
Date: Mon, 17 Mar 2025 21:51:25 -0700
Message-Id: <20250318045125.759259-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

Now we eliminated poisoned identifiers from headers, this file can now
be compiled once for all arm targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/boot.c      | 1 +
 hw/arm/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e296b62fa12..639f737aefe 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -23,6 +23,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "system/device_tree.h"
+#include "target/arm/cpu.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cda..9e8c96059eb 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -75,4 +75,7 @@ system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(fdt, files('boot.c'))
+
 hw_arch += {'arm': arm_ss}
+hw_common_arch += {'arm': arm_common_ss}
-- 
2.39.5


