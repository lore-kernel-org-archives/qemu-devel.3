Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C6CCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Nyi-00027K-F3; Wed, 08 Oct 2025 02:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Nyc-00023f-E9
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Nya-0005YP-Nt
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso41605445e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906119; x=1760510919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TX+6TIzMvbiySIam4hedU4eyrfXXsCN6EkPBQRKAqak=;
 b=QUsVEaZqM3qRumi2hh4hFEwZM/ZqrYbSanV1wmbE+sOiVbx2bs9Fjoj7HCE8InekF7
 tbn3f4tzVDQ525VJvY81XUS4N3TTW0enkspBGAM6sWiZ5os1KGlq2O4FaRCGsI1QKjz9
 18/pRt1nrzqWVxy1jnud53tJVZAxEObTPrllp93wQBpnmREk0Ta8PEfCLioAE1yv4QNX
 SYtI99N0ZxPzuAPpA7nabvJdMRVaurKCxcn3NwGzA4hZmTYYsPK5folvLGzAI8AnQiB2
 4+ZHfYywf9ZCAoqkC4JocXvYvmeneThbWmrLrl959R59rO149xkuJcEY70t6ZQiSjkMU
 OY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906119; x=1760510919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TX+6TIzMvbiySIam4hedU4eyrfXXsCN6EkPBQRKAqak=;
 b=aiGh2+npeTR/Vk1SNt8iXEFpInNLDCjv94A2Wfw7YaAJqgh1xqo8GzOuVYLI/Bqq21
 sxTZtUPH2lnzWlMpketeHshyb2bHZImoeF+93Sh3VLE21cGHVnw8ywcWhCdMEfyOdjzk
 3yFHFnXEQ3beCO5OlPHTyvI6hWCqy8UlGHbHj+Zwwr/uCx0PIgE47Ch/ux6vaDbXKxMo
 bSUhb05t1aUsJPMZ23J96siE6RnkmfG+4MPbytJVvxMvnra7gfSzgbY87/+zvfWpn0DL
 KC0Dpi8QhkABrCnFa5oMlIvcBNdX6+xcBXf+rVKbCi1WswE/fvZIf9o30BFjcy7qt78S
 MhLQ==
X-Gm-Message-State: AOJu0YwnpuUczwLC4+TVtuZA5CvfOiTVuxqtp/gfyjtOeZyev7eDRKVd
 Zs+6j00VYOuQI21g7pPKxdF1iyZt5g3MIKj25K+cj4Q+gfmwvpRbnMMMeGTTyZ3YlwCPWGeQQRw
 cp+zLAOjVqQ==
X-Gm-Gg: ASbGncvN2SaDbJ3pTpmNRLlE/vR0Hn7kW/bHDBo77Rt2259OReq/zoiPxLaqd581oPy
 6Ml+z536YFvMxqtQby5/Botbzt2MU42ClZgLg4sU6aT7jnk8tVfbEM+434sMFUwtYQ5LgIkJ+yf
 0LbIyG3cB/SFiwFsHYNUWN0tx6zESExwb7kmKMz7QxCUaSme5yrjeIhaHHQV9tUcziENjk1tPU0
 CXC1KrktXKfKzXu9hTK+U2kfJhDej/tJYu4lifn8GdE4Mn7kEDv0EbnkH72L+wtP+gNrHzga/3j
 Ve+LFQkPEeagAZ9KkPmN3A9zc1KzCb757PsQS6igVcQ8zwRjeA+Hh/c7/nui4Mdrzwj475B2PWW
 zHe19dsaA75mStC5dGz1wYXlDfGg6XTG7N5xfsA7wVbLwYlyPWMollhjEvgy8FZKFf2rjmxy4f+
 kGGverJURqCmvaZpXSlIlM3/dq
X-Google-Smtp-Source: AGHT+IElgTXIGO02jDS7WykqEOgI2I/hFIeEaV3UlikPVyE6Hez8IrjM6naswdTMJjx5Ttx3PNoqbg==
X-Received: by 2002:a05:600c:1395:b0:46e:27fb:17f0 with SMTP id
 5b1f17b1804b1-46fa9aa204cmr14482385e9.9.1759906118726; 
 Tue, 07 Oct 2025 23:48:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c2a39dsm25250575e9.18.2025.10.07.23.48.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] target/sh4: Use vaddr type for TLB virtual addresses
Date: Wed,  8 Oct 2025 08:48:12 +0200
Message-ID: <20251008064814.90520-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

tlb_flush_page() expects a vaddr type since commit 732d548732e
("accel: Replace target_ulong in tlb_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 345efbfdd0e..507ec78368d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -452,7 +452,7 @@ void cpu_load_tlb(CPUSH4State * env)
 
     if (entry->v) {
         /* Overwriting valid entry in utlb. */
-        target_ulong address = entry->vpn << 10;
+        vaddr address = entry->vpn << 10;
         tlb_flush_page(cs, address);
     }
 
@@ -528,7 +528,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
     tlb_t * entry = &s->itlb[index];
     if (entry->v) {
         /* Overwriting valid entry in itlb. */
-        target_ulong address = entry->vpn << 10;
+        vaddr address = entry->vpn << 10;
         tlb_flush_page(env_cpu(s), address);
     }
     entry->asid = asid;
@@ -570,7 +570,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, hwaddr addr,
         /* ITLB Data Array 1 */
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
@@ -665,7 +665,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
             CPUState *cs = env_cpu(s);
 
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(cs, address);
         }
         entry->asid = asid;
@@ -716,7 +716,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
         /* UTLB Data Array 1 */
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
-- 
2.51.0


