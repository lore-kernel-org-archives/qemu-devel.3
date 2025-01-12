Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13950E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zP-0005N6-6L; Sun, 12 Jan 2025 16:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zN-0005MU-Nz
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zM-0003ne-Cm
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso1591854f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719158; x=1737323958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MthpmBZalYKPKBsyZS//nKFY6fWzJ0z//b9OCoUIijI=;
 b=lNPFxp/v4UbLwaGKBSSB8llebz5Wv1/1f3cBAxih3y0IY4a7EOPx9aSHqg9I5Z3L4a
 /L0zHr9EKrp2gKIggRn79ygGO7XllcMrHIORNj2npCYqvZ7RxfpF9XO3onEANO2NRBAa
 iV4rxSOmrsifLCgmZoOgk8p2HwQ6L3XXRLpYuhAQVs8G960QPSkhL0KnbDoUng1shgiz
 PPAgJ72Oob2Rj35DAzk2FoKiZ6510ip2KhhTSfXQTkwfbSv6OLvh7TGcg5PKcW9W0rEI
 1sICo7ixt9GTKLbsPhVpyF/H1ykDhEsEdm6kYht0i/TLqeLqXLfNQ0k1rzvvJyBsSQNx
 k+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719158; x=1737323958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MthpmBZalYKPKBsyZS//nKFY6fWzJ0z//b9OCoUIijI=;
 b=PeDw9sCOw27jmj1CcEczWOjPKmKBZBm+eMTC9TnlxpzCVe7BjEbRm5JDJppZaHV10j
 bwUEHn+4HiO4WT9uzdiuD5Anayj9c/71KhEqQ46L06WF/Pr39EoTvyoWef07zZcA9nEh
 Scw0AoVCyJK5NzhP7h3w4rMGBLD+PLGhOWfQqRQYmru1WGj/XPo2e9ueg9ToKiyr5+rE
 lwJJWHH8Ifg3iEAUKvgXKkUYInQe8AfudvtPgRyBMT4D9X2B2GZAgIIlVrQxlWwP5Foq
 QsoXKoy+FPqZ5sO+3Qpz/0boUDG2oyqwUbN+hSvKcd5ZqytrO6dSY95V/z7Avi7meusC
 vjlg==
X-Gm-Message-State: AOJu0YxIuymVO6vvsYmrfNLiBIrbiqPvjs7oUtE/6IheJCtXSkJlMg7O
 aX8J2iwm9Ou83pWo2Hi6PQQWdGD1sRlvsLDvf9KCfMCaSKrTUThyq4vQs+6jn9MZ6G9WSpceozQ
 xRTw=
X-Gm-Gg: ASbGnct1iIML0vROkBBviXgiVqMe40rgZLVxcmvGW7decPLJJvcx9yuQ7AOblfzeLBH
 GveLJguHckWYyj4uZwMK0btTfMBu3LL+k89DUgXwSVq9s7cdbIc/ODCg/k/6DOaUKCVpjMOr+SJ
 wzdF9SL+QuPW8tNsWNo1+cXfdJiYZ1xylWfHfhSjshr4PTzdpX8TrdSF2uystDcaUSnQT6jh0xo
 pVwuefUrgMKVwUFGGh65x3S8SGBdhlASA1Y3J1w8gcVsxwpCamPHPjxQrREHt1QMK42r1ClkGd0
 H/fjTTjxzVJbfK4pcEKy6BDz1KZrx/s=
X-Google-Smtp-Source: AGHT+IFbSMmEzaIFhl7stANmbnTZ+xH+tN2Vyx21osaEVslk0Qrr4L9XvVyR7tH75rqxysomnxuZ5g==
X-Received: by 2002:a5d:6d87:0:b0:385:ef2f:92ad with SMTP id
 ffacd0b85a97d-38a872f7f80mr16096050f8f.10.1736719158351; 
 Sun, 12 Jan 2025 13:59:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d154sm10793919f8f.10.2025.01.12.13.59.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 08/11] hw/mips/loongson3_bootp: Propagate processor_id to
 init_cpu_info()
Date: Sun, 12 Jan 2025 22:58:32 +0100
Message-ID: <20250112215835.29320-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 91b58a71a68..1aab26df69e 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -27,12 +27,12 @@
 #include "hw/mips/loongson3_bootp.h"
 
 static void init_cpu_info(void *g_cpuinfo, uint32_t cpu_count,
-                          uint64_t cpu_freq)
+                          uint32_t processor_id, uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
 
     c->cputype = cpu_to_le32(Loongson_3A);
-    c->processor_id = cpu_to_le32(MIPS_CPU(first_cpu)->env.CP0_PRid);
+    c->processor_id = cpu_to_le32(processor_id);
     if (cpu_freq > UINT_MAX) {
         c->cpu_clock_freq = cpu_to_le32(UINT_MAX);
     } else {
@@ -115,7 +115,7 @@ void init_loongson_params(struct loongson_params *lp, void *p,
                           uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size)
 {
-    init_cpu_info(p, cpu_count, cpu_freq);
+    init_cpu_info(p, MIPS_CPU(first_cpu)->env.CP0_PRid, cpu_count, cpu_freq);
     lp->cpu_offset = cpu_to_le64((uintptr_t)p - (uintptr_t)lp);
     p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
 
-- 
2.47.1


