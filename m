Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9746C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiyF-0003yD-LD; Tue, 29 Jul 2025 07:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyD-0003nz-7J
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiy8-0006G1-8K
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so35639465e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790286; x=1754395086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZLCuI32mRLDzwfhzdD0trdugKB1fD2xZRFNlNXmbIw=;
 b=fBD/eg/2xa9CuHbr6i2NhpM0ciHCVKYL+MdsIuwRtcs7BxAceHvmNlk78ILWYpKL03
 1qs/Cw4XeFXHWvGAmEKk0Lkls0Cqdy8QKNW0LQy37sdDoyaUeDce2VMEJNOGYoBhtwK7
 SogV7nQF1FeqbYt6MazSNPqSKcFQjFkHlr8du5+TvhDNok8fRwT0QLxpaAxiCqUTqNCz
 vcNcuIEeQRqSEgWKzAcuXHrsad1itAvaCIE8AdweCLJV77LI1bP/qgfdJM+Ena0JB0em
 t0Zocs1Dj2a8mG4R9b/Ip/nNTLVCL4IV7xCvy5tZBWyxUbt/10FUJy2WnOlZa0kkMcXk
 eWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790286; x=1754395086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZLCuI32mRLDzwfhzdD0trdugKB1fD2xZRFNlNXmbIw=;
 b=rsDQjMS9q8BlV+Lc4FduM9aNaLgEUPMXvxImLeJfcNDhzM7o5TQOe0lsQAwZVN6Y2u
 je02ZYqj4jl5ZfrXDIl1VZF5VUyDtWqjYskKT5tBvJgm10pZEqn9Mo2gJ7slk+6PkZV9
 rMHp5dmht1tMhCSSRCNhAcPivEiZ3l2jp2uEamr7MXsL5m712u+5C8Vy2hyR7YxUZnyb
 fbyP8LRsqnGmaF8YCKkDSg+wEexJW3DVZXoeIMnyafxk5nXxNXiGlfNFklq2az5sGx5+
 2zNOL/6+Zrc9iCNDwu0BylAUAmbHfjvntR2yfde1vlYKffB1LsBB3wkQqEa5SPf2qgP7
 dc+Q==
X-Gm-Message-State: AOJu0YyQ5kawv5/qez1kpEAGuyMYj6EHDTcRN6MUFSvsIFq1QmzEn4y7
 EWbJoXVfLqnsF5DqN144cemFUhpvgOH7byevn/5lLp5F0iuWjWEmzfeuiMUvNcbATj1MJiIQ87R
 r3PZH
X-Gm-Gg: ASbGnct6slIWGsJCY41WIxR5XiDuWUi5fTyBwlNmzANvVYtRb9JIZjoRQ+64ghfOagJ
 RSAOnf+bNCiehtAzahyBTqEnZFjVj5xHmwAcJyBkM0qRA0ayWq9G6tqHlETsWx9glbk1D/CoRu8
 IxyfnsN4U20m/g8GqfO267xTrYvcujR37MHK0g2RF1s/80aklxpZLVKgQfxmVSRwnPstmAYdq4x
 O8ThgXqHTsLQ5ue3MkUySIoqijDqCMfnokRybxrb3TC1aGmwzLOM8xQJwuRSeMSkVn6j8uLKH2C
 jkT1p3uejuwywHp3SoD1pv0Sm5uNy1+AlRpIWuZ51Y8qK9v7Bgd3DTMs98c4wxaUrLb2WPzqWAn
 tE0T5rEUhOM5bASK99SP5c3wIa/gX2k+jEwIgZVgWyywxQriomkfz+Kgbszkn4e+vEnNjpMqY
X-Google-Smtp-Source: AGHT+IFm9e3gIXrKykE7g+jz/UvSig1IqrhOgcqxaEPGlK2m9NH3XLC6gGAvWtwPWiefgqfVJO61Aw==
X-Received: by 2002:a05:600c:1e22:b0:456:2ac6:cca4 with SMTP id
 5b1f17b1804b1-45876311cd0mr112740315e9.13.1753790285847; 
 Tue, 29 Jul 2025 04:58:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b789a31c4asm5676065f8f.17.2025.07.29.04.58.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:58:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Adam Williamson <awilliam@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 6/9] hw/xen/passthrough: add missing error-report include
Date: Tue, 29 Jul 2025 13:57:31 +0200
Message-ID: <20250729115735.33619-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
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

From: Adam Williamson <awilliam@redhat.com>

In commit cfcacbab38e ("xen/passthrough: use gsi to map pirq when
dom0 is PVH") an `error_report` was added to this file, but the
corresponding include of `qemu/error-report.h` was missed. This
only becomes apparent when building against Xen 4.20+ with trace
backend log disabled.

Fixes: cfcacbab38e4 (xen/passthrough: use gsi to map pirq when dom0 is PVH)
Signed-off-by: Adam Williamson <awilliam@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250717220207.171040-1-awilliam@redhat.com>
[PMD: Improved commit description, added Fixes: tag]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9d16644d82e..006b5b55f24 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -54,6 +54,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include <sys/ioctl.h>
 
 #include "hw/pci/pci.h"
-- 
2.49.0


