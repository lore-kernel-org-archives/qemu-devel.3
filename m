Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBA9C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvo-0002yo-O1; Tue, 04 Jun 2024 05:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvm-0002kB-Qm
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvl-0002J2-0m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42121d27861so8664055e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495091; x=1718099891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNllFIjXNz5GjqDOBbChwyL7SF1oO9qoS6VeKoJgVQQ=;
 b=LBkGYM+JHguc/GC/OWjs783zYXQr4eU9T4Y5XiSqleBFQ4RF6tvcB5oLiFLeblmK7b
 IO6IDTIyou6e1zgnE2TWOFX36SNmBT2C8UX4wJ4UzvF34Zgg5p2zF22LE9mPmQiLUoUn
 Nvt5T6EJ5a3myhYEhwP004Hq0iz8ubsiNT6OkbUVzzH8sLwGGhPkhQ9THnKkP0xL6LU3
 znb1UNi7Nco/3RjOhfQmxdoUrNhVTzBU4BlPJIM5oe5kEXvH0AqrNxct9t60bGdpI6//
 g1KoxYIgFC+VV/azRNlcMCY77rgvMXhOvTpnjMS0MBTtYPU3dk5+EfODDIFYn/Kk+9ER
 N4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495091; x=1718099891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNllFIjXNz5GjqDOBbChwyL7SF1oO9qoS6VeKoJgVQQ=;
 b=r/aDWcf0+ZlLigFkGEC6gG075pfgXujvWkNX+Jf2va+44SiZcOUwDhkh4eKSsfUan+
 rF9Bqk21U2LWjpW6Fma+GUjXFq+2pC/28Bm0RH45a+EpXEaBT1NCmTYR4EwEunLfcI+g
 l2MoegZH87w93sx89pNqG3TNgNuenPUFXkwzSDLeDY8zaWE1fC6BzJsNIV2auNH4/reP
 NwpciR0MzBb25gSsTp8QW7TAgSazPezhGajk1A8BVoXu0AMxupy8mEclcnCjmXSDXjha
 50OA4YEx4cXxugGFMXVybEK3D4WH/5XndWm/75tvu1T80UrI5zGCeSGY2c3ZW23cycz6
 ZarQ==
X-Gm-Message-State: AOJu0YyWy7pu/O7ed+4DoqM+vahHQBQAC+XXqzUxT4rZ4uaGvhU7sn1E
 KiKTCSevTokoAGQlt7RudiQv2HanFERjpVY/jygVCmryP3UtrPdcW9lG5zx6TG49habRVGd+x4E
 /
X-Google-Smtp-Source: AGHT+IGK7i4mnCY4rcZ0K8m+AzlE92Y1UXIKQleM6PeYArTfWB721sahRuFDriX+HnsfYqX5nP1qfA==
X-Received: by 2002:a05:600c:4f13:b0:421:418d:8f7 with SMTP id
 5b1f17b1804b1-421418d0be6mr28047945e9.12.1717495090999; 
 Tue, 04 Jun 2024 02:58:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8a5598sm147525575e9.38.2024.06.04.02.58.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/32] physmem: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
Date: Tue,  4 Jun 2024 11:55:58 +0200
Message-ID: <20240604095609.12285-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

For xen, when checking for the first RAM (xen_memory), use
xen_mr_is_memory() rather than checking for a RAMBlock with
offset 0.

All Xen machines create xen_memory first so this has no
functional change for existing machines.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240529140739.1387692-6-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e6257ef65..b7847db1a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
                                  len, lock, lock,
                                  is_write);
-- 
2.41.0


