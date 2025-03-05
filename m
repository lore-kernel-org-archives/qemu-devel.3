Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57552C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdX0-0007O8-RU; Tue, 04 Mar 2025 20:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVV-0004QP-6H
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVN-0007KP-3X
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so2009845e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137899; x=1741742699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoS16jcofKMfC1p+Goa3uOwqWjbdT+vw3k8DI4uqp0A=;
 b=Vbz0a6H9BFCuuQxIj9Uspumq4IL3DEtZZwmWOeG/JCN64eS7Zg2RJL9Teyq/kw9eoW
 krSQ3jq3qsKNgzcf+loKUiKyBce1EGs6NUGHWB9Tm2L4YzI9nc588CZAvs0KwDkGZ9tW
 AATEb195ZTFT8FuTd0MkhWExNvt3OaPRwAsT8+qTYQOLt/WGPqGsuM4iux+6MZ3glxxZ
 yrvPQA8ta1t6cw/yzmE6VU9afBilL2jJAeYS36fXFUXL2yTobhrNPC5BP5lLq82O49N9
 HRkar45RrqYjhSpZWt+t08YFdLZqoMtJcvWOogCvygN+5+UILi3H/r8+OTMZ5ewZpehv
 nrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137899; x=1741742699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoS16jcofKMfC1p+Goa3uOwqWjbdT+vw3k8DI4uqp0A=;
 b=uKZiac7i3PsN6x1Ul/wiV6pPS+6SNPAaJhenKqIsK8azoccQcePOTuSyMaM0rU6j6x
 VHMMG/EdfrCCRrs/RkL85+kOWNrpRwcyFu2SstxeApI/1wORQm6gHerR7r/4tlUE9+mH
 9We1XF4+Z6r7CU2xELWgSCq0nMWKHNYxldqNOjH7kxxu3NhMKDBtmXAae18Onfld+0vs
 fU/pN+riJvWRVkxe1U+vbo4SUiyho7Gku4lbIslV1KE3kl5k9SVF5aWp3hv93Nxa51To
 K3D7Sh/Fho01TT5CsFtd6ioz2wLe5fNhLimEZ400jdLrGz3FY1QUDZbPItj+Bc8ah68O
 e8cA==
X-Gm-Message-State: AOJu0YxCfQiCmTyx6zpIsVPb/CU1RbB36Wa2JI0M1qujeqcrDYO2Nr+M
 hnJkuM/RaiUMkTqYY5h2aNGJDQh7bp5L6zeFmKRUtad1hzmMDtWtooBzKJq3F0Gh86KeQ1IJFtR
 AjLY=
X-Gm-Gg: ASbGncvaZQOPJsCwaohrPUo0PlmwMf8lB0lvHpucNfEhajZh49CSrgETxQjAF0QMlm1
 aAbrktHOfZvghhlCNho/nRgCX1/rdkF4K26DBBKwdW6lqsEwQZs8HiVWCnYKzzf0To9fmhpkOxT
 8j2RqDmV2iGmQjTS5e/VwIMcL8gX0yT/uf1K8ogSN+mu7dzQXHo8domluQW6umbDfhb2KzLn7nO
 xPgfweZTraEU1LnUZQGD/oe4GzFX2m2ooFAXjRZv5UV+lwa1N23IoPxMSx+8/T0wUpUfLfYGgVE
 UHcLAC0Df+xsmECLHg+JzYi/zUzL34Cms6k26Qw07ERVq03SXsXfO6wBdoovtNpkVEp2lhw55Tt
 ivoFOLYmGLntqVHxeB3I=
X-Google-Smtp-Source: AGHT+IG9RiNTml7Tetk6YzsQlR6DAAerSdlz1i5p58Ud4ZdC5Pl/3mL2ELwhyF6F8O8Vg/oOEJDVGQ==
X-Received: by 2002:a05:600c:3b16:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-43bd20879a6mr9163235e9.2.1741137899205; 
 Tue, 04 Mar 2025 17:24:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd431070dsm1932715e9.34.2025.03.04.17.24.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/41] hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR
Date: Wed,  5 Mar 2025 02:21:52 +0100
Message-ID: <20250305012157.96463-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert some printf() calls for attempts to access nonexistent
registers into LOG_GUEST_ERROR logging.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250227170117.1726895-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/versatilepb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 941616cd25b..35766445fa4 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -27,6 +27,7 @@
 #include "qom/object.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
+#include "qemu/log.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
@@ -110,7 +111,8 @@ static uint64_t vpb_sic_read(void *opaque, hwaddr offset,
     case 8: /* PICENABLE */
         return s->pic_enable;
     default:
-        printf ("vpb_sic_read: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "vpb_sic_read: Bad register offset 0x%x\n", (int)offset);
         return 0;
     }
 }
@@ -144,7 +146,8 @@ static void vpb_sic_write(void *opaque, hwaddr offset,
         vpb_sic_update_pic(s);
         break;
     default:
-        printf ("vpb_sic_write: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "vpb_sic_write: Bad register offset 0x%x\n", (int)offset);
         return;
     }
     vpb_sic_update(s);
-- 
2.47.1


