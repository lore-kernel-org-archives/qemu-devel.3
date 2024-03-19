Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2374AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyH-00053h-HJ; Tue, 19 Mar 2024 02:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyG-00053S-Jh
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyF-0005cc-4a
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-414676fe047so33825e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829749; x=1711434549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCgoP8SLDbVfo8JThgfHljHZ06CYNyRI0w/tkagv/vk=;
 b=wUnKRgthxzgT02Sh3wX8JlB+5GL0xjfZLXYWbk2xjF/7ScZibTId4wZ9oGxV2I2yWv
 tyMOH047uFHB4+xPAx+kmrnXvyFyW2i+2EcTh/vlk/3NchIbAuKjDV4/seA0JwbokST5
 2ymU6KXJa4FsWBH33fA6qvJJ2Qf99MReCv0YNPsE9SEps7NfOIVYJNREC18Mi4LfzDAD
 F9aEOtaaNhEP8akEAhMPanK7IpWOrW3xCPpQAanUMxRNrlFBTzB3gq1iKTFAZ99iTFD7
 KA+Y6uGFMS7s2ndawmpUEX4U9BZ+3uo2JS35WayLq+d8BlF7nC5RWOeA/qMPxt6ep4HJ
 w4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829749; x=1711434549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCgoP8SLDbVfo8JThgfHljHZ06CYNyRI0w/tkagv/vk=;
 b=VpGsNaEh6QcPbGyNrecr/eeJOh+UcnVkFNkOGkWUag5IfEjZthaYQcTbZVQ3QO4Z5R
 hqx4ZtXNc/U0vIKdyOL5bdsgM89NLBTu797X8e39NVDJog/eXuxHeqiszwpP5ZXkp43K
 UqgWXhyELnQ2dEYUL4OUME3CrJkNdW/udDHbrP7dX5BP+Ch03B9+guZ8o1nB6XwjoTWN
 SDoLWXmCXaieSeIh2LEfyO10V4LO7bSPLf7Jvv0SzxPi7Nb6HXV9Mb/pnMay015hfTg0
 Bp2qztqV1fFe9NuDONpTbazlZfkQyFyBdLs/f7/uv1lM2eBzwsCmud28wxH7ljvivvYf
 I8tw==
X-Gm-Message-State: AOJu0YwP9MEbNH9IUoYTjDHEtVbc9mzOEPGSkexHA6WTbMrYLg+E65Di
 stBbdeYA7Hv05jI3cMxeC+mym6QG1d1SDJxwJEOxQx2S1Xd2FzPteRiOOKxKVwk5sSjh/xgN3Xo
 9
X-Google-Smtp-Source: AGHT+IH9yYR3wHc4A7BV0vTOaHo7L5x2ZMnwbyp5OrS/LN4HeNT8AR8GkI1oriDv1jpFspkfI4nXKg==
X-Received: by 2002:a5d:4590:0:b0:33e:cf68:7345 with SMTP id
 p16-20020a5d4590000000b0033ecf687345mr8214247wrq.61.1710829749489; 
 Mon, 18 Mar 2024 23:29:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b0033e7e9c8657sm11509428wrc.45.2024.03.18.23.29.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 2/8] target/microblaze: Use hwaddr/vaddr in
 cpu_get_phys_page_attrs_debug()
Date: Tue, 19 Mar 2024 07:28:49 +0100
Message-ID: <20240319062855.8025-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 0a12c4ea94..3f410fc7b5 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -228,7 +228,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
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
2.41.0


