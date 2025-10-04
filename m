Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E64CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wU3-0000GK-7i; Sat, 04 Oct 2025 03:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wU0-00006V-Dv
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTx-00059r-7G
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso17718785e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562103; x=1760166903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFel9QZfEKVlygr+DrR+3hW7E0y6gSTsjEwuE9AQ13I=;
 b=DN0W9X0jHKu+idFiG7R4tT1BbHszi7gM2XNP7sg1Z/2whyW8M1k0zoYAWJdgcIibAs
 gE8zrszDa1KoaatPuXl0prBUSOFtXMMf5f9jR2Yjx1zeF0FhKjG9o1y1pTXP45keAt5h
 v0nkmMNO7TBQ5MbUetu4TCxifomi0CLDkvwxYuLKpda/kAYUWGj4wolXtjZ2Ub+cVjZJ
 fHSW1GpBJWuvFjDU/sKI5qdCPXpftEGl0EYl5A70zUyKR0i0AfMF6ELBAZMi0QHrKI2P
 SAi/VL/nMKW38AODd3US4i8z+feSMUJu5w3IdeBx4PdD9gI+221jUlTo7fsqU4Axrxhy
 ujDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562103; x=1760166903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFel9QZfEKVlygr+DrR+3hW7E0y6gSTsjEwuE9AQ13I=;
 b=rIZM1/0DTRwOlU/npBhAVYSFN+zJp7NpWBcanKfK7hsPcRunbPd74mLbiyIav1RfwE
 kwhZlJQAF/NqxJO76u7lqFV25K0Jcer6efj6UbQNwDTMSKuouP2NY1GigMzHqXnq2eGs
 6VrW7Ezo4e39cihpoo4IyqLoxl3upXJu8vgaQHl2inV0C2TdefNl54AquVB5MLx9Fx5Q
 alkbxfpv67A8vUnuuARMMldIdWweKf8fqUy+Oy92nRGH1y90C0n7cxHeboj1jJH6vPOj
 /0IbZdMdrcROif10knJ65tW7zY5/UhuhvojGDP512zFxh6wt9OPk+WZo7ktWoPmUrWys
 i4FA==
X-Gm-Message-State: AOJu0YzUsPowlfnLi44P13GAeYWS3TNpYiTsRJUgPBE2YDJQ3cV4POuN
 rCA9eKgspJhqXXsRoV08VuFSkcbV4TobvuI8owEZ9DF15yt/TeWcfmxZasN83RCfOdo6GXa6Ohv
 sap2yzRZIgA==
X-Gm-Gg: ASbGncufKcYUr3aPjkN5W6BrIHralclNAyr5sZXshUQXrH5rbKmKZ+0l64b/xaRGw0O
 El7XT7quU8aCIrNY4HlAFlfm60WrFPUnQjGVSkuNOHu0cM8RAU86es2BAD/SJcPZ5LvZ2/60l+O
 8xLarNGAyyBNTQHQzWPMZO2H+ycrfp/xQ3ZF017JXgSWWA9/18kHqDRDz0I/N1hGmpY+uWnftnt
 zX+OEW4R5NqHNv5IqfxzO5nK7/NUbhUi5l5e1ZQjd6QGtJtkZ4e6Uy0zbfz/hLUUBI8KTU22/k3
 xOhmURi9HMegRXa7rB09dWnSa7HstZjUF+lK8vF46lrrVIL7CTUZzAQQZNEA63ZrfI8MeyeTW8K
 VghhZsHoziV0/EX6ivGoz24YoK4BGJPpj17Hi8wTUcebyo4EeWjR770W5L9dwHdzYyif7oAA5qp
 AbQ2gJpv0jylgQFwbFSoooHOY8
X-Google-Smtp-Source: AGHT+IEHXmcpKa35CNLBiPZkh/k5r2Qkuu6nx/D57rJigEsv4chUVTP8FoqLX/DaJ//3ezaGDwZc9A==
X-Received: by 2002:a05:600c:8115:b0:46e:3b81:c3f9 with SMTP id
 5b1f17b1804b1-46e71143012mr47811435e9.17.1759562102850; 
 Sat, 04 Oct 2025 00:15:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72343260sm60691055e9.4.2025.10.04.00.15.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] system/ram_addr: Remove unnecessary 'exec/cpu-common.h'
 header
Date: Sat,  4 Oct 2025 09:12:50 +0200
Message-ID: <20251004071307.37521-25-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
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

Nothing in "system/ram_addr.h" requires definitions from
"exec/cpu-common.h", remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-2-philmd@linaro.org>
---
 include/system/ram_addr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 6b528338efc..f74a0ecee56 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -29,7 +29,6 @@
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-#include "exec/cpu-common.h"
 
 extern uint64_t total_dirty_pages;
 
-- 
2.51.0


