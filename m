Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40407EA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjgh-0006Rm-PE; Wed, 04 Feb 2026 15:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgg-0006RP-M9
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgf-00038V-9n
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so230112f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237679; x=1770842479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iwrHIoAKqqFwPkVjgv8M8zC3K9151EFYt5ePTiRaaM=;
 b=MVRootpIjdMLXSUMuwRdTffgwQOibNTi+gR/6GS0xr3VcRIcR1Ie2G4ck5CcvK4eyu
 KArOCr7skV3Fx8Y5NiENz5YO10zxhhmDqgeog4+I3jO5bKK1hAR17iZD0UM97Vco+RkG
 opbGDR4XZ+zJHtfaDc+jwlnqIUyEW5XpehajSS9GiMhHCn1n/EZvzLFdnZfl296KKYS/
 JWT1eyVQzCpyDlfta1+q+M4QmucduB6t807WrS7aM66IZE37V7LDonsQaidmOqLbSeaV
 WP/r8gilevv6BchRC7IcLSMv99PMSqFTOSDVWulzzC+NLaPXDeniQJqJY90veLXtH3gW
 Ua/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237679; x=1770842479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0iwrHIoAKqqFwPkVjgv8M8zC3K9151EFYt5ePTiRaaM=;
 b=Ext19TyAe2ciPsxfJf32jtOpjhy0G6JVJu0iMbYZUJvepqG18IKIMuqWuYWLyXID4N
 COy0sbJ8HvnxT8KFA+ut8glukyphu0rZfse8E4IXN3LVJgw/rW6+sf0M+/v7K61cmPG2
 rAPVOQMKaTQCKWMGH7z4V2jkZ61e8bqbHAkTfxWQamHpC3llTzyLW8xoZUqSwRAE8vJr
 S5tvLcZVojI19UqzYK/lFyjJYdlwVbASWvnRMKQHRxhU63j5QpZsH6bXfLUn7Gi6MjVP
 rvwmg5Z4tpD6Ow0thulehXRjmE8GzbAVlv/FpAGAAgm/2f6/dNmeUx3LyU3vkI1VVDnl
 WD0Q==
X-Gm-Message-State: AOJu0YyvqgdOJOvy9WxEhM57x/PAILDhQ3i1rUeGeCKwIFjkF7kn8Ei1
 Ot7PB4rlzjKV1Pg/tP7fZDbAR6hUMH81e9LPeT15Hpk35519sHPVqD37aihTrlZMKy/2vGrm/2k
 rKIjT1M8=
X-Gm-Gg: AZuq6aKd5GxfYTam2AJewZrodDaeeEEH62n1B/gCiS65rvuT/Iol1AoPiaZ7HXru+MU
 8Kd8r3UzPCidL2OCyGbPKt+g0Insjul81S4bCiiWwJgcDFEu1RfPK30U++gFDoboMcEOA+A6QXv
 yx7S0czvJp4tsc1FNwGUgmxAA2Sb9w+0ooee2yZU/RK6oaUBpY4UtLZn7CI4oGw7kg2BzgP5tyT
 dfIuXBbuGwEBHKcEFyGh9QSBuwB3z7rb4ZIwkX5wLV7YGTrghcLF8o/gAITWrotZdZdctpGn/Hm
 8PQCvYukKH0cuPpojTaepwq9bgQhLtjks10VMWvUYqOR49hXINsWAN1D7RqvGlFEPsY+eCZVr1v
 wResG1JDrIDp9NXSh5rzbMeFO8vLuY6gpohLa4ZhRrb+a+ZJGpqVEmg7xBCeHkXXf+CpbGnMEv0
 uulZHmFAi0aqk+eHdxfCmCTTherkjyjt9kpTr5BIpmZJJleTJd9qolUCVIZFJyWtDQgYB2WSw=
X-Received: by 2002:a05:6000:3104:b0:436:b87:ce5c with SMTP id
 ffacd0b85a97d-43617e41e00mr6241648f8f.20.1770237679352; 
 Wed, 04 Feb 2026 12:41:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e250bdsm8990710f8f.2.2026.02.04.12.41.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 12:41:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/intc: Mark x86-specific [IO]APIC peripherals as
 little-endian
Date: Wed,  4 Feb 2026 21:41:01 +0100
Message-ID: <20260204204103.46343-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
References: <20260204204103.46343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These devices are only used by the x86 targets, which are
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic.c   | 2 +-
 hw/intc/ioapic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index dd8c77f8180..8766ed00b92 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1108,7 +1108,7 @@ static const MemoryRegionOps apic_io_ops = {
     .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 98de6ca8108..87ca1af5421 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -429,7 +429,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps ioapic_io_ops = {
     .read = ioapic_mem_read,
     .write = ioapic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
-- 
2.52.0


