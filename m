Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C8CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXaZ-0007rD-Mc; Mon, 24 Nov 2025 09:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaX-0007qU-5P
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaU-00033r-TQ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:44 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso1961706f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763994641; x=1764599441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2EersBLKb9S6tlHedyCki0WgUrx4IajTbClSVPvW4g=;
 b=nIFprDF22lIvWf9AkUR1pPElkB7VclEoE7rNCRv+pH+Br+1wcr8SlIbfcR1ZBgusUe
 ZhyePvEOkxKpdI8hAhBj353weIbSRdpnctz6eSyDWVsNqXKW0JSNuwwDkl1BvNLdIUmK
 kNic5R9APZzDYzUzMRYDg18kiT1s7p9KaR9php57I+aZkiejHlpCBf3zuDd/JinUlHSI
 f5PJ3R+CKUVj87HT/TQCZiHMwTluEGhh+Tl8WWHould0/sbqp8q7M9bcJVYtI2jO9rdu
 fUUyZzXk/7x8UmmBM+4wJ5NUyMbl/L88rrNqzyVG42dzvRcBQTdVzQTL/I6V1Zkg4ueL
 qvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994641; x=1764599441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2EersBLKb9S6tlHedyCki0WgUrx4IajTbClSVPvW4g=;
 b=kczJ/N0mY6nxI3hnSXTp9J7nXcKhTXimb9AO8ot17901XVux5g30BRHPZetAeLaNVo
 H57L/m3xIyeCzWtPnPLgF/rCJOc+OZ8UUdWRk3uVq2jwDu7Lirx/N16PFrVKUr3kj9h/
 d6L7ORGYdGPZQIeVW91qy0OzKJn3i6hEkN/wo0ntqtm8TEBLh7tAXR8B0SpbAKe+JQOx
 HIMrN8yP+1jIk6g/TCNCJU93++XdUt60OoHzsi/v6wEjYYHQHL12PQg5oLl9u1SCirIw
 +DjeLCcfxN3n3sFOq5ryZCbMlIyJkHIEnAExYRP51XcG6gFZlVofUH7ZMBvQCElanNfw
 8ltA==
X-Gm-Message-State: AOJu0YxJFlE7mk544fzcyKza6IcyyO920MuAC7M8V6Qf24xiEIa1OVyS
 xZdXsvyOqlOxt2RjiOTD4l1wcbIQ9K12KGkDwK0pYs3kJFW+oVeZu2D0kgjMSf3buq1Fy483WYy
 qhcqe
X-Gm-Gg: ASbGncuzlok+xNT82I+v+PmkHUJ+aR8PX5PzxLpZ9+ifjHT1f27fYi9BYgvpRwuhUVS
 o6y/am4AZxXHhydRlGLSSb85SesbKb78EL4AqUhAD0abOJmxts32QHA/HUCsgJBpofJwv6vGYH2
 V5D/Ar67LK17XLlnL09L/TVONSwYn/wJsjezLS6OmzKpcqtePek1VShcAMXP9R5VufhkrZpbI/t
 JqPs8PhBDgDzh+YTNVZ08XRm5Lfp7eMFnwHoxnxb7wzqFRLyF5NfswrGwRUXZ3Allrc8BtAQprd
 Vdw05Y4D2oWFF1dcXpM5wGqrD2q0HdFGGFfyEeDdD+gU0BSGQlIyI/ReRRiKLcT7CskHE2z9hKG
 qz2P2VDGcOZcTsFrUt7gcMyuEB3CfYK4bdHm4pC0/lAl6hgBFyrtlKyIOqCcgabsCdY+y1QvVfa
 WwDw/ChG2nVmHjF02j
X-Google-Smtp-Source: AGHT+IHy9piOAc5XmdUEIca8IiF6ZwTSbAD9INmRPq1HVyQ0++JFGeeIDOypRu35PpemTXRisxon0g==
X-Received: by 2002:a5d:5c84:0:b0:42b:3ab7:b8a4 with SMTP id
 ffacd0b85a97d-42cc1d0e42cmr13072184f8f.33.1763994641298; 
 Mon, 24 Nov 2025 06:30:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm29408930f8f.16.2025.11.24.06.30.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:30:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] hw/arm/armv7m: Disable reentrancy guard for
 v7m_sysreg_ns_ops MRs
Date: Mon, 24 Nov 2025 14:30:35 +0000
Message-ID: <20251124143036.4113886-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124143036.4113886-1-peter.maydell@linaro.org>
References: <20251124143036.4113886-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

For M-profile cores which support TrustZone, there are some memory
areas which are "NS aliases" -- a Secure access to these addresses
really performs an NS access to a different part of the device.  We
implement these using MemoryRegionOps read and write functions which
pass the access on with adjusted attributes using
memory_region_dispatch_read() and memory_region_dispatch_write().

Since the MR we are dispatching to is owned by the same device that
owns the NS-alias MR (the TYPE_ARMV7M container object), this trips
the reentrancy-guard that is applied by access_with_adjusted_size().

Mark the NS alias MemoryRegions as disable_reentrancy_guard; this is
safe because v7m_sysreg_ns_read() and v7m_sysreg_ns_write() do not
touch any of the device's state.  (Any further reentrancy attempts by
the underlying MR will still be caught.)

Without this fix, an attempt to read from an address like 0xe002e010,
which is a register in the NS systick alias, will fail and provoke

 qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: v7m_systick at addr: 0x0

We didn't notice this earlier because almost all code accesses
the registers and systick via the non-alias addresses; the NS
aliases are only need for the rarer case of Secure code that needs
to manage the NS timer or system state on behalf of NS code.

Note that although the v7m_systick_ops read and write functions
also call memory_region_dispatch_{read,write}, this MR does not
need to have the reentrancy-guard disabled because the underlying
MR that it forwards to is owned by a different device (the
TYPE_SYSTICK timer device).

Reported via a stackoverflow question:
https://stackoverflow.com/questions/79808107/what-this-error-is-even-about-qemu-system-arm-warning-blocked-re-entrant-io

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251114155304.2662414-1-peter.maydell@linaro.org
---
 hw/arm/armv7m.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4a9c3ac529..7fa1b37630e 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -442,6 +442,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                               &v7m_sysreg_ns_ops,
                               sysbus_mmio_get_region(sbd, 0),
                               "nvic_sysregs_ns", 0x1000);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the NVIC sysregs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->sysreg_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion(&s->container, 0xe002e000,
                                     &s->sysreg_ns_mem);
     }
@@ -499,6 +505,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&s->systick_ns_mem, OBJECT(s),
                               &v7m_sysreg_ns_ops, &s->systickmem,
                               "v7m_systick_ns", 0xe0);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the systick regs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->systick_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion_overlap(&s->container, 0xe002e010,
                                             &s->systick_ns_mem, 1);
     }
-- 
2.43.0


