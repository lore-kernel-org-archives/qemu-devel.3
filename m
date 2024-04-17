Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E8C04FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1O-0007dY-2d; Wed, 17 Apr 2024 14:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1M-0007d8-Go
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1K-0003JL-TA
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-416a8ec0239so568055e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378513; x=1713983313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnqT/8KLlXL1A5GjOlmM9XBc7s531rVah3xCrUywBWs=;
 b=VSTTlE+JZTXVo9hmJ1LWMJ3FJxxeHLYFYBbubOiXxeVjaKAS+PxsNwdyeS9zJ3z7cj
 LY8Q/34i6+oVahCPucxg7f3sOwjZE9gqGICiACdN4hakuk69+QoAMWBGnrQPDY2+JZ92
 ILEKTLZbq0M2ztfhPn1YA8iXKFOasFM+1rK/U9K2HRP4VfA0mI4bditAsomowAPwx+oc
 iuYpdj9zpIvp1/I6xT4tPKmlUl6hCOFiycTBIhb0yJauEeFluohD6PeYoV/2UXshPnpF
 9fjfX3JnZyN3pEt9fDgJJ1uN8vdOgKXHg2FGxayXAYwqKfGkzO4P+hEc2krYkjV6Ji+v
 3r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378513; x=1713983313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnqT/8KLlXL1A5GjOlmM9XBc7s531rVah3xCrUywBWs=;
 b=eBWDwMmr7Ju8eOVOKmFoTqPlSJ1sA0wooS6YcNiOAR80uwHiialmc48PLKvkRYpiC2
 5So91R0w6FuT0TfxcDTor9hK4xnDJkJ2euEPzkobIYLidktW8LYx/pFEWhQ0s/evfZ/e
 DV4Y/Wb9pV6iMYD0OHIspzeDrXJStNW3WKS2S7QGmUaavmjshcCgY3INvllyuZUILOnv
 +fi7chQOpAyhYYjGNKdtI9hvNYNwUrnsrLuWaOQ/OqZYysJIA8MS4HtQCt+iORf4ccRQ
 /sRy+4MZEWzq8KXTTinTzOyiI9Gzc9f8YJFw7H42ehkZok6k3n/XRLLBxWk9RlkgFj3C
 7xyQ==
X-Gm-Message-State: AOJu0YxZWmU+aAONXk1g//hAd2TarnfS4rOekYwW12YPFzh2UMlzS/YP
 2Sijq5z0mvK1v/qMzx9FURZPf1YoRsWlTYBQbuAUYGfuZRHRoz8dZSE9uu3x/ynm4Kmfu9FCrGb
 8
X-Google-Smtp-Source: AGHT+IFKEsx9LL/RI3h2OhBGQlrVhdbEYY5AV3HGCqe5GJ+zPPZBxvt3iU6+c+xB8zPytwGT8cqh/w==
X-Received: by 2002:a05:600c:1da9:b0:418:93d2:3bf8 with SMTP id
 p41-20020a05600c1da900b0041893d23bf8mr203138wms.3.1713378513074; 
 Wed, 17 Apr 2024 11:28:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adff4c5000000b003437a76565asm18092458wrp.25.2024.04.17.11.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 04/21] exec: Include 'cpu.h' before validating CPUArchState
 placement
Date: Wed, 17 Apr 2024 20:27:49 +0200
Message-ID: <20240417182806.69446-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
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

CPUArchState 'env' field is defined within the ArchCPU structure,
so we need to include each target "cpu.h" header which defines it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20231211212003.21686-2-philmd@linaro.org>
---
 include/exec/cpu-all.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1a6510fd3b..b86209fc49 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -391,6 +391,7 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
+#include "cpu.h"
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-- 
2.41.0


