Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8787CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvh-0008Fx-0y; Thu, 16 Oct 2025 08:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mv6-0007Ty-4i
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Muz-0008Jc-8I
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5295755e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617033; x=1761221833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6XQfSNSGt2KFxddAnP+guBedU8PIeXbgFihUGWw5K2Q=;
 b=QzO5rCW+wfe5/85rhUkKHj6k5/SHz4cWRFMD3OjLOp4GeRETdawmPifST4wPeKjmDZ
 ayQweFzZYgFbrJ/eKp71r01N9UOxksMNJRyNQa9HvHsXlgP03lZHzUK8mJlOh61Tjj1O
 jVAdlOGtSkIAfLeLnk331KyIIO1x3MhUcoUjubb3ZoWuZh9Q5veEn/Q6dZ5T9cv3AA9a
 jpnVmnASs5je3oJiXO6ixBuKnJivbDVNwOgXsrQQAwqAtxJmLraXX5SnuVWSRZCIR2zn
 ywiLGC5P5BEJKf97M0D+4i+aRUW9cyG5JJVczEWrKylNIj6hGOR93feMd/bE+nXGqPop
 bWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617033; x=1761221833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XQfSNSGt2KFxddAnP+guBedU8PIeXbgFihUGWw5K2Q=;
 b=pFg9JII+HAqrdzzFUsHALd52ppRKSNxxJ7nCZUldN3tb2NuRzQ76auNz+otrRtRaeu
 fPBa7FZhMMfG2HIv/ZdLtCu83ebTVtO3G10XbQUODw6onl2LXxf+oKmPjpFD070MgOdR
 QfNLoHxbHYhg2JLbWP7DDCkcCBZ+B/GGMbTWsB9hSIPgcY21P2II9cFbRvwj/0gqxJSu
 tjLoaM+zMSlFIb1lTKLbh5iWfrOL4dGbV/Ck1dKv2GlXoZLi2IbLXzSl995uNZ+99pP/
 w4ksoC/3ffiPsHQBweAbPui37iRUsBoZwOsp6jDqtI0w/UR5BlUGor31rFQKbqH0eDj9
 kC9A==
X-Gm-Message-State: AOJu0YyxFmoFdsnDhoBPuNO+lybmf3hfM78dv86HpmJ11VLSo28sVSru
 dYNKlxjugwubByQv0SsGo48Q3ZO0y2cm9IvDjuQ5xL4pjFfOMNq6oUTcWsuXrj5n/UMgGiueajX
 tBSVSjCQ=
X-Gm-Gg: ASbGncufvHjxw5IsC3TlVAOgC8JovEO+OK5ddSyJyEi0vFmT+tahxIi45bIIIMvWzuZ
 +03wIHHXaYZjROP06tbK99vk1HY4PH6yI/CC9oxSfF0jYbXU/lz+54jh6SVCJfppzhavzjal+jx
 +7ihP8FGj903CR3D9enXIRAu/6NmVyxDx3YQx/Mo1umR+g+MQSMRqZNlS9D457QHkHvpInaHX+T
 po1Y1HiHUDF7FSctLA3thaUfJuPbSYBOYyK/St1pQc/VKIAtfXwIuRMB2ozuiByB1uR1o6mmP8V
 kdICs8hk9Gg4c6yoNl70PMwvsLeZCWMa5YAe0R4XmIWzCPRNbICM62QOC1aGMdwiYA4aGf6vBkg
 2iylm1kKaphmiMDPHZ/ZJy5L5ppGO6wiBbi3aBo7Ja8HQfYRUGrUpbOWWExTyjTl8yIpHddfeyM
 t4SPhFBCsfRkDnmM5nk5+lEouqq639eONwGdLk9H5wsOvc3+olmlmBUoOP78ZNpX92
X-Google-Smtp-Source: AGHT+IHFt98GUx07QjTduBryoRwihlxkQX3sKrBeuUlBS2tPoVbCeTrtnrYd16Hn8QQcUhqwQWisBQ==
X-Received: by 2002:a05:600c:4f07:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-47114b1dee0mr10638865e9.14.1760617033386; 
 Thu, 16 Oct 2025 05:17:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm36267305e9.3.2025.10.16.05.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/75] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
Date: Thu, 16 Oct 2025 14:14:37 +0200
Message-ID: <20251016121532.14042-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
cpu_get_phys_page_debug() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-3-philmd@linaro.org>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ef0e2f973fa..cf577a72268 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -274,7 +274,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    target_ulong vaddr, paddr = 0;
+    vaddr vaddr;
+    hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
-- 
2.51.0


