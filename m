Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A22CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE86-0000Tu-RW; Wed, 29 Oct 2025 17:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE85-0000T7-7i
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:54:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE7s-0007xp-Dr
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:54:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475e01db75aso2090225e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774870; x=1762379670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a651872IckFxyI4zFPyEsBWF3frcPZiE7HAcMIqgSHY=;
 b=Xd3k857WNl0FVoyH3w8zVoyzGCa83YL/gjsEz0yzD7i4GK7zGBWrfV/XhXEvpJ2F1k
 juHcQXgAfNt1hTs6B2lbrC93TiMIWeHSxnSl+XUiWS6x/c1s9xYFKmbl1Q5YPnRxrNVj
 3Cenhqv+Ba9OegZEsi3dE1IjS7xHTwuqK7aou4rMBwqGI8hZs/LGGXYFfWsvz7Xw6JIW
 lPUfYDG3kG9QEL1reUBnW/DVa/E9iYu1LX6h4sZ7YIh8KNDNTBPNDo4KPjgwdagD8A07
 UjN+/jXrWE/+xDWE3YbTTSgia+atpsb2Rsk7wRWlvQF0vOFDMHu5TjpSA4uYiIUgLxW5
 LEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774870; x=1762379670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a651872IckFxyI4zFPyEsBWF3frcPZiE7HAcMIqgSHY=;
 b=TysLN/ffB/UkUCdTGOUvZ0qCNdhIKd9/eFyH2+xL47y9rXicCWOJfgYkQbAkK+ZSXR
 AOTN/AXFQkO5lAqE9hH5gNF3aKDrO70IievGK7PdE7Yr1fyltfpmNBPdrorPZQ15pwoB
 3wXh6Oq8VgMTdsJLd8TKm+qwDMHesfsDLpM0xJZHqi72MvElLpXKIXjocbV/2/CHkutd
 sWb9Kk99+e70SsoIH2FxSq2EbGY9g8FLrlq1ATMx7bR9YgCNiTEovV9JJksBHzgK6GSt
 0tr7wLtY8KX3SkGG5X41QvRG5NcST2QJBs3sNoObWKijX6QCLswL5TggTZ3fm8Yg4nKv
 VoWQ==
X-Gm-Message-State: AOJu0YynUveZBRjTTFGutEZnE6KDGdtpDz0tdcZdMspn/u+PeJqVY17d
 F8dnEWOZYkAuCnyKIift+GtiG/OlyHXm4pqJad5FBzMCWLjWKUYGi5TwbepRie+T2OfV13AoFEO
 gOn4lBF4=
X-Gm-Gg: ASbGnct9MkmdyjwETDOLJMPUAwseo2cH5nSgAoMZTzdw9u6DFaohl8fK3+Xuv5d/8eN
 MlOnjo6hiZJxou2eIkb7H0VQEyEKqjQEjEjpayoAixaIUPa2PtfAES06zfYI23KmvQUR1Vc0xdK
 flhzIA5XyoOyN0QiiM2Li4obgLkg999kmyBgKGAanxuVROjqFIRace0YET4pQt101TnlssMAg0d
 itF4lxNza9XyvI3rB5Go0yGSQwXtHs+rc9Hn8Xeo7qf/qdTtRDobWgiETSo5D3VAbVxRt+PsfZ5
 KQX3ejwr/O59rhqsrvvf/kTKSKCIB5aluFVOrZdnXf6ROMYXuw4AQcq/LYMojsIJ0wtiNeQIp+S
 Z5tcg3V63OzVTTJ7azipbchSDeWOQ2CHLUfwKt4YdrfCyGApOGeSvn1Hiq+tFlgg7rEALJ/+aKV
 yi+BjwseMAguhjGv1A9UoVue0JN0oJuZJZZIFqowcx2VcFmVn7HQ==
X-Google-Smtp-Source: AGHT+IFHimm9eBbWvD/BAcs81SRDcF7UJ8k+1Hf6mJ2tc24EXAVR9UTMqj5twiCCVEznWQcHT+fGBg==
X-Received: by 2002:a05:600c:3548:b0:46e:46c7:b79a with SMTP id
 5b1f17b1804b1-4771e33045cmr48811955e9.2.1761774870243; 
 Wed, 29 Oct 2025 14:54:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718493c61sm52680805e9.4.2025.10.29.14.54.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:54:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 14/23] hw/arm/sbsa-ref: Include missing 'cpu.h' header
Date: Wed, 29 Oct 2025 22:39:51 +0100
Message-ID: <20251029214001.99824-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-6-philmd@linaro.org>
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


