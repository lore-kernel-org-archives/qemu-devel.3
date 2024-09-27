Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E99CF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIml-0004Ss-4J; Fri, 27 Sep 2024 17:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImk-0004Pa-7i
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImi-0003w1-Oa
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so23862415e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473555; x=1728078355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fbocd4kmjbgTZkW00sKJRg9Q/JlRfFmMDabLRJXpjXw=;
 b=K4SJx18e3KP8qa1ATO9TlXGNmoSyGlFxcD0ybXAGMZvYR2Gyu3aHwbpKbhyMWk3IhW
 4B67Rvbkb6W1K+xEF7eeSDIemCPvbqe2la+YW3DeZwIahQTkTGQ8SFl7Ajnsi3aE6LQY
 NkEFgQlAlOTvyUB0qaKb+riX4olt2uMfmWMCTbXyU+l2VD1A+FKjqJkAALOjmoE0mriA
 wHKUDtN+dbgyy2b6NqUFzWY9eeOBf99E1ej368gnNeJp1x3Z3+arROwwVcebgsfHuUVO
 eF5fbpxx53K1B0sNc6aQvbfun5gg6Mdgku0VpFUW6QinR4dp4LyfbhZbfUYI8YH8NMaR
 gryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473555; x=1728078355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fbocd4kmjbgTZkW00sKJRg9Q/JlRfFmMDabLRJXpjXw=;
 b=ZMa8kCXHlrvEWd04n9UJZnQ4HmXmv3Gj0WS3tToemRYcgg4aP/GQ7vgbX/3pZ5+68x
 szKhi09RCnCUFGjzfqlRSJ0YvUEO6et25pLiuYWPKbMa9SvlXcSigh+8M5wdVE4JQAhu
 TmGW/ZGZFiLg5sWmKG6QvBOtecejdm37K8fgfaNGt1BwdvXggdO+ETBBttdnS+mcOgWz
 FH4SqG2axah7qmowbZiwDe+ivieDyD5jugI6UpcwOCSj5EQbkJUwWTjLYZwRJw/KbhSG
 Kgyik35hOI/Jac/iwyrFAq/zRmIh06BuXBbGksa0WVQAYVnBOiDurDh6KQW0grKpP5WA
 QRFg==
X-Gm-Message-State: AOJu0YxgJUdzY3udCtJD8uSTJMBz5pcoLYf31UPUfSWYGT9IlvgQHRRk
 24q77CsIYKibFZJ4pDjFKQJXRrnC42Pv3ECTMRO/P43ngmjLxC88/rt0mCfBo6BPPzEFUlstOWJ
 L
X-Google-Smtp-Source: AGHT+IEbJWrZPp/+ZGCMU0ft1/0/FCAkzhRKqmgKFLU4Vqi++7MsZCs4bsrNHIWVsCOhD8zi4cIVJQ==
X-Received: by 2002:a05:600c:45ce:b0:42c:df54:1908 with SMTP id
 5b1f17b1804b1-42f5844ba2bmr35683315e9.18.1727473554875; 
 Fri, 27 Sep 2024 14:45:54 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a52308sm84020965e9.43.2024.09.27.14.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:45:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/ppc/vof: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:45:30 +0200
Message-ID: <20240927214531.20242-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927214531.20242-1-philmd@linaro.org>
References: <20240927214531.20242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Directly call ldn_be_p once instead of be32_to_cpu / ldq_be_p.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/vof.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index b5b6514d79..fb152efbe0 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -645,11 +645,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
 
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
-    if (sc == 2) {
-        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
-    } else {
-        mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
-    }
+    mem0_end = ldn_be_p(mem0_reg + sizeof(uint32_t) * ac, 4 * sc);
 
     g_array_sort(claimed, of_claimed_compare_func);
     vof_claimed_dump(claimed);
-- 
2.45.2


