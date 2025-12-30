Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C7EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyT-0008OP-IS; Tue, 30 Dec 2025 16:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyS-00089l-0j
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyQ-0002Mr-BA
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso92959075e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128984; x=1767733784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R1scoqV8tAtwsz0ByFWcQqiBZXTYa+pUST9WI20B7OM=;
 b=u06YXZCvNrQ4lyPUyab9NWGsWNgDGFdljf8PybVvMdlEb3UO750rwUYa82YW0Eofxs
 IltcGw/Kbtu8oQD2FOEbKpo6JnPesaLmE27fOIsvKiVG6mPMXV8Fw1IDN09QRZQ4i8lj
 4kv5CQqthUBDzX+ZkHgl7Wrhj4OWicR3tqcgJWn45KaCwFTwOhBQ7NrBVsePAoDxdeQS
 005ukotvQwPLKdE7rGbOXXwsNotQLnHCtYwB+6R1zF62aGYLWcPqyUbJlLcBcI5DyrLJ
 QgkliJQozqKygsiFK6E4MJlEORh61D2LeEfJ2RiV3//+gt+2qcPNT8yDJLOX1VOZn/yC
 UVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128984; x=1767733784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R1scoqV8tAtwsz0ByFWcQqiBZXTYa+pUST9WI20B7OM=;
 b=UMig6vQQsLkohVYnR5lzMZIdNGqGj5Yg39RpT23eka9yX22Iqjiae9twFl37ZN3MJ/
 NJ0l3yAHAO/HGnyr7ZIE94R6HBsZ3GAmmaFyJIgEfPboBNlYzmXHsxAWPXr8bg54WGCN
 FkLiAH7caoXgl0kaqz1eYDjyM+DeKwZivRihbOLCBWVOjtGwWUesXvDIVl6THAlx/sbq
 wyJKyNf9at7V5fXDE624lz6OAi57MWzhty0W3L44eZ8RcXviBQ3grqxnwumkngqzPm1E
 4PrPER3iEM8kola+/W8T4HOJKwn9FSnImJswwj8vLUO+PzatM3ecDYrfZwK3qGorEPli
 RYnQ==
X-Gm-Message-State: AOJu0YxxpvALzFmWFpMKOn1iRlrJs9pGaBOh2RRZWI3OLdPAT2DoLg25
 l6C+kPQK+6q5NFIaNsrqFrCraG3FvU5deucFQQnJIdVFDv8kMZCy9vzQri6myZNM2HXRohBHu2D
 QajSTGqo=
X-Gm-Gg: AY/fxX6tkywR4QuzneK2FM/mS9VRAE3fvgXjTvdHQbIqqBpr5PHcrIMJrx5vQeB0O/x
 18olupdCAOFaR1s7PT7X9HzIAipVIo+E/DuD70nSpSTZF4Sae+XC359ZvGIjyNSFkujBbHm+sw5
 cin0aBeCHH3SDkGG+3kqJ5vNONR3kY77V0Cr+GTy74c+Fp3gNPw6YkWHW+OYZMhzXZlFO0bo07q
 aCF0RwuXIwK9H8f72qn3+YGyrR9BIhStMpRi2I3IgZkj2fn51JDGTsUdnJZkSKAer6s2G/GbPfX
 eGpjyMhgCTgSstcQffAWIATZMwg7IXlj6ejxCo8oyyfJejBPqtmw543vjpKZA4dQajimgVRFych
 5g3T7L05yCkN9MsXitlA7B2l4V4dzXjntu1nVwJeMeDMdgRyoB4jBMM3rFwhHuVPb8CIXhSBOIy
 eE/FLgL9mvEI6vbyFzpnF5UX63tWerGHRH/2v77A5EkiPsd9VlJW87fMGZjQhs
X-Google-Smtp-Source: AGHT+IGydUl/lF67iiMs3RQTIaVUeXBTrPRlAC8WT0spYyVsHtccxuAEIr8wxnBaSEpkWfyISMrE3w==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id
 5b1f17b1804b1-47d19566f0dmr411510985e9.13.1767128983880; 
 Tue, 30 Dec 2025 13:09:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm72014694f8f.27.2025.12.30.13.09.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/34] hw/timer/hpet: Mark implementation as being little-endian
Date: Tue, 30 Dec 2025 22:07:38 +0100
Message-ID: <20251230210757.13803-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

The HPET component is only built / used by X86 targets, which
are only built in little endianness. Thus we only ever built
as little endian, never testing the big-endian possibility of
the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
the little endian variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20251224134644.85582-6-philmd@linaro.org>
---
 hw/timer/hpet.c                  | 2 +-
 rust/hw/timer/hpet/src/device.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 070b40e7f67..0d7b8e0c7a3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -648,7 +648,7 @@ static const MemoryRegionOps hpet_ram_ops = {
         .min_access_size = 4,
         .max_access_size = 8,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void hpet_reset(DeviceState *d)
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3166688e4e3..4757bf5fd55 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -763,7 +763,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
             MemoryRegionOpsBuilder::<HPETState>::new()
                 .read(&HPETState::read)
                 .write(&HPETState::write)
-                .native_endian()
+                .little_endian()
                 .valid_sizes(4, 8)
                 .impl_sizes(4, 8)
                 .build();
-- 
2.52.0


