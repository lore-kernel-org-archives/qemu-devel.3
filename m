Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515D4CCD1BC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJVW-0005Zl-12; Tue, 21 Oct 2025 17:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVN-0005Tm-Bx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVJ-000305-VT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4711810948aso42231925e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080566; x=1761685366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZHYX7VXV4conWXUV38dh7lf+geoYCF1Bpj8/lXvUeA=;
 b=AeI5Q2ZwkHudCWW9YbRsaX+gtenNhIL/GW+YpaNtvLqaRsG4CeMboET2lUrU/gEwG6
 ah+FY8wXOqUVocagRewJZIsxmtddSH9DimN4oM5k7jrFeAu0kRGVKxk1QQCvRCDZMqOW
 WHJDDr2VA9tzXxRzjtnCjp82jpoXGGS92zd8M5ior2APmUA7bbKBEIJS4DYCom72Yj3l
 u6/OCjg98NKdAjac63x8OHITuVxIjm8IYRpWAWYTfc9woDwhARIfl/7ZoJcLcfKjns9N
 mNVgqR9NU5rzYEz8FVVmDej1AyzSXDmSQLaKbQ8kFMnt1VcOqQAtEaoxmY5mYc5ylwG4
 W4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080566; x=1761685366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZHYX7VXV4conWXUV38dh7lf+geoYCF1Bpj8/lXvUeA=;
 b=seVVL0Xg1ra3GoRxvC65aHo3DDlf5tf6Eqde6Rrop6vvPu1mpVXzB2Sm2RvFZCgw48
 dsOLDE/K9WCBuHmxyBLxHCt68ELXcjKj+IVush1K/gsgb899Zt+BaovTWw+WvsWmjCdT
 TFjj4gp6rrsNw0Ku0tJ9SiDtY4fWuuLS5teEOUBWZtfAW3rkRNKTD4WyQttweZmWDlDX
 ffcf3WjxkqcICr0MqNwi2xIuA4k0yVHlKu2jWIm1D9jUwNBjavR6paYCltZG6sdJHDvH
 HIj6sgMYdHET0eDIAvOI8666hqnOAqUtZCCi1OoyzGOhxG5XpW2k5K5kVL/Cr1H4L4rh
 YrRQ==
X-Gm-Message-State: AOJu0YyAGgYRwf4Hjxp9tfrpxSk85nubYkebx8RgDw/zZDKHUPVB9+tc
 mL1a8I/ev3w18wKxABroogBI2NH111wcO6TNQvB0qYyEXPAx0uOA07BlqhLr2dvO4yqkL3ReHGC
 CfK8kxa8=
X-Gm-Gg: ASbGncugjyn+ZFh7d7Y8xjQx1YvS0FR/KebuocwtDOd6MNCSZgpu1P0tfu6KAaW6yq2
 uxwWckUVyhZm8yJUiKA7GNxe/xwUW+OafOnxb41uFqWM/wET8vUSAS0Ak9shYWXYP9GrJp2zgOH
 y/S1jKbGuPUFgiVwFu/AJ23sM62DGYtWU0G6BdBWDA4lcWggigOip4AtHQH04d/ItEGklZE+Sc6
 K4e8l5PhT4209psCI+OV0vwXQFvGYxTSyvRZNj0coQlGfG0ZoXArDV4dDIfmFbKVZ5YSb8np1pD
 mM48wdbVQvPsU4MLUfFHvIjo8/z3LHmDxxXeaxjvZPxZZR5Xc04rrgAd7mYHYV8hS1qxGRmFnso
 uB3rl/Q1bYWebD8OoFU3S6yiUMMsHc5IC5v9qCP7hA60dLl8jkOFKHUt31o4m0mm+C0JFizQ3j6
 jKms5TEs9iusYHgCSbPFHrfsm9JfYyaCt7MDLDm39YGMHKIxGuC8+xOf8OdeSh
X-Google-Smtp-Source: AGHT+IEMO2cqQFjxIrVEBZs48U7qwniflxRNGHFGC4XngGfZK8r3NAlFQZJVFwY0+JHkOxc6AaI+/Q==
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124f with SMTP id
 5b1f17b1804b1-471179258f3mr133065255e9.35.1761080566464; 
 Tue, 21 Oct 2025 14:02:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428ece8sm10623795e9.7.2025.10.21.14.02.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:02:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: [PATCH v7 14/19] hw/arm/sbsa-ref: Include missing 'cpu.h' header
Date: Tue, 21 Oct 2025 23:01:38 +0200
Message-ID: <20251021210144.58108-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

"cpu.h" is indirectly pulled in by another header. Include
it explicitly in order to avoid when changing default CPPFLAGS path:

  hw/arm/sbsa-ref.c:162:25: error: use of undeclared identifier 'ARM_DEFAULT_CPUS_PER_CLUSTER'
    162 |     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
        |                         ^
  hw/arm/sbsa-ref.c:163:12: error: call to undeclared function 'arm_build_mp_affinity'
    163 |     return arm_build_mp_affinity(idx, clustersz);
        |            ^
  hw/arm/sbsa-ref.c:746:25: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
    746 |     sms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
        |                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index cf6e6eb208a..2205500a8da 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -52,6 +52,7 @@
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-- 
2.51.0


