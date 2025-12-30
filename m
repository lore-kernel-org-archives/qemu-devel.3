Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B618EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyZ-0000Yu-46; Tue, 30 Dec 2025 16:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyX-0000T2-L5
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyW-0002P1-9H
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so8956875f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128990; x=1767733790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UCJ7R+BMO8hWETAQauSDjMMyldf8uRW23MJ8WuvIvM0=;
 b=Ulaw3jE/5/YU+ALVXPyO3dlLtG4HqBrNM+FgvDwtQOsTj22hgWPFiHCsSzyUDzTsWl
 rigGWA2yZDSxw9fJ/qV9qYQsKT9Jx2Baz2U+yPTVPyyjTzLLiDRDrNEBqYdy7XYplX/r
 gmUEnjnEIXYIYyRkq/M7cTqsK5K2jcZd8ndVMNBfGd6rCQo3RsSMqO5/VZVYk3e6HCy9
 w5+cXRfGlgbYsMCh3sS9WfMylWoaxq632SsTMMHr0pTqwY8d8Ae7GhjVIUy6QMVRDCev
 QopG0JfED2ss7l/cI9wIPQHkTaPuk6gG3kaaZ/p8dLgJCpHxnjdYJh/1Eeq19dbV7MJ+
 PPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128990; x=1767733790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UCJ7R+BMO8hWETAQauSDjMMyldf8uRW23MJ8WuvIvM0=;
 b=eI5En2lI9KGlMLN3AlHjwqYRe/HmD+TbbpA3YQJzLi5mqTBMnHCGdT2ZsVvj/Fh0AN
 QkHkw6FdXPyr3CWRQ5MFJH6aVushED4PCS8Lg23fDq3W8ybzJMBJemcN0BMd5IkgLm91
 4V9b0iMyaMrjnNDbYgpSvj7euv4K7hVWlXHvBCyrJj0tgbCR12DBpizqbbIk5TvvQkom
 VHV3Z9PCyvCPNpsnccJAuAkCg8ErUqpezdcoBWBVTPNRQTPPB5CEXQ+MPSRpa4YOWB3q
 6aeWZAG+23BzzaME8Dl1a9fnCyDmkMsLXLttXujHi++i7HKGL7CFpDVQr1SQ76y7nKKr
 tYpQ==
X-Gm-Message-State: AOJu0Yy02ZDIvtBM1xxrhwPBbkijVX5Lv1NSEu2l4gAIP4pfUVCuycx+
 HJjG9nL3dTv7QPmvDsaV53Cp0y1kXJ9Ymb2Mhd01uPbPI6CT1Fl/RTISoRBDO9BnL3s3r8yq0Q2
 yw/ujxjI=
X-Gm-Gg: AY/fxX5xOLzUXw8BscQl15KysYDEhC9ntWLE6jYoQrpHieQjt56oGWERGc0ygXbuna8
 zS0gYv0C1lCPndYw2fOSVK85JJdF4ebZ3esJZM9fmpX80MqZhCnvOISdzQxPp5Fjq9nRgImyrl5
 Q/Q/zsgl19PF1mYfNg3W5ARdEqkLsD9NxhP9VfermRrZUzoJ3kScHPYBfh5iaSAsSKqRWnmxwuR
 Llw6Piii2VuhQ8mSDV7gwp5zQio5kvaYMXdwMAzR/6QHnV+aywNSFLHOevsyrfaBrioDycTM2FE
 /8/2cBxn0nzm4qGrjdAjSLFa8rvqFjLAYX9DWByYWpm9woUM7xlRPWczXw/ojyXFvCF9nWRPF02
 rR/6mbXfP8Bce2JSy1z/3TKGcbzaNQo2ICguTqZbGPmldnwvP/Lk6dCFU+RhSnope745rBWAJnP
 L7BZqfxt0jaWh3RzGZDid2HUXrzEYNl0WrKF7qmYvbtzQtL6gtNKvjolLeMEoG2f4IE6FR9ug=
X-Google-Smtp-Source: AGHT+IGlSu+uK8XCdtzJEB/7lylqIBu7QbKWK6u8eTTEkJ1U6oNm0IoxPV4vo3+AlDpn4Cn8oKfg/A==
X-Received: by 2002:a05:6000:200f:b0:430:f879:a0ee with SMTP id
 ffacd0b85a97d-4324e4c1259mr46160254f8f.5.1767128990297; 
 Tue, 30 Dec 2025 13:09:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm62446347f8f.19.2025.12.30.13.09.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/34] hw/char/pl011: Mark implementation as being little-endian
Date: Tue, 30 Dec 2025 22:07:39 +0100
Message-ID: <20251230210757.13803-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

The PL011 component is only built / used by ARM targets, which
are only built in little endianness. Thus we only ever built
as little endian, never testing the big-endian possibility of
the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
the little endian variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20251224134644.85582-7-philmd@linaro.org>
---
 hw/char/pl011.c                  | 2 +-
 rust/hw/char/pl011/src/device.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index ac453c1057f..b2ca68e3e86 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -538,7 +538,7 @@ static void pl011_clock_update(void *opaque, ClockEvent event)
 static const MemoryRegionOps pl011_ops = {
     .read = pl011_read,
     .write = pl011_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 9f5c4a34df0..eed3b130ce8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -489,7 +489,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
         static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
             .read(&PL011State::read)
             .write(&PL011State::write)
-            .native_endian()
+            .little_endian()
             .impl_sizes(4, 4)
             .build();
 
-- 
2.52.0


