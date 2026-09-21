Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B51C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrV-0006AS-6a; Mon, 21 Sep 2026 17:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrJ-00065G-7W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:35 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrH-0008WV-Kz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:32 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e66390995so18805345e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027250; x=1790632050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iO9iNINTzD2LX9sUzLOVLlEHC5CtR3JI1XqzgFFVw9o=;
 b=mw4xXXC3cTxTjAGozYlotrJuNloxpUfdW5GS+I7j1vslDFh3Jwmr+/J4/5l1vud/71
 oVOcsK6uOucw1cA7AtqrxO2pWDIlo2TQVZBlcCdU/KeyCCeko2zkxnvt9oXVGwdvOGNn
 qOhVtOXTWdB+8htc1h730M9ZjUgDs6K8NkYf4VHzsrPTEeOzog9pPNKfmIQRdP1YYbSE
 Q6dmm+8oY5whJeIEE7SnUm3JuxNHgXSqMAQb5D5ZiOIv12Wb3AhEMSwEf12xR6fs6Ak+
 o3sK9+1bZFBpAD2R2XNw8tc+1HVC4ukxMyRaEI3iztIcpe9Khewd4tC+tkntNVWzwZZz
 qemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027250; x=1790632050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iO9iNINTzD2LX9sUzLOVLlEHC5CtR3JI1XqzgFFVw9o=;
 b=BtV2u3n4nQNVj1IVvHUH8iN1Z8/sd9qWsWgjqGepbho4PiIbAcpa/JjCRsSUrjD9/f
 eHwLF5c+QLWNkcRyeqWtAyAcLCs++xYCNrKKa5x+gQ8NJuwSb9+6i2XMZ9oltWZlTbZx
 ADmqelceypBHl3YCtiLrqCGSdaLesOnbsR3Ds2lJT5ZLWzIzM+yPYXDzFVsO6EPznt8F
 uEr036g7Bf1uwcb6V8ldrMBZLq2uA+jjA5ccvzH5qDRjqzK2itI410UUsEpt/+ucPaXA
 Cv1VX4qSBnjEjOEHGy2uAqjoVX0fQe0F+S7AYhS/u+0gQm+tORXWeGhggVVy3oDMnQNO
 O+nQ==
X-Gm-Message-State: AFuF++k7i1UUUxonD+9caIAlMKsegrlYOh+chq5wyWOhn4wK73yJh7La
 vwqmGS+mIYTa20noqen71wxkkHpjutUk3at/C1pmMH93oiH5mikwVlAQACI0AA==
X-Gm-Gg: AYBFou1kfQ7xNombf/UFPJBWllUFmldF868H1pVAYM9swlyPFvn9WYuZPev+xk8ebub
 WgQUXb25KDEpnMKr+kulHtMJ4XGh9MxC3zCGfeYkOchmtIrxSbYiPoTk3RL/6YUNr9bUX6KTy2a
 8A6sXjoRtBcfTVUUgW8zXOjv1/qt3K1sjiPO5aV7zNsnqkxMPja+o47U/IRGJq97nSFayeZ0JOB
 BV8+CpyFxzxQtno6VCo/ccLxKxTnOAYITEyVkukRGCjy9OwC2HbqH0BJlycZqU9Q0l2dicBYmCm
 g3Ez5p30jUj6+8EwzckoGGfGdrh2d0prwTVHNgJhKnZW0W4hh8WK8jlZwRz3sDaFfbQKS2Vxd8W
 Z11OO6o85tYIA9VnTeQaLMLB4fVgJspl7ULTA/tB5wNSFF/3cVrOyzwO7MxZuHgdvHkM9/VHonf
 qy8FwCABUCpoH0HY2tbMxLd5LbPc9Hc3ZQWEyX8qCbkPBozpBO2zEh6pf6SnRXkOtqcREmPN8ua
 ndhR5PerZ1KcmDRWYq2dLQKUPwnEOYL3bamkEriTPpsyLq3E07Sg5MCR8rrovolqvisY+IHlSCf
 C/A=
X-Received: by 2002:a05:600c:4e42:b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49fc5750a8amr168804465e9.24.1790027250229; 
 Mon, 21 Sep 2026 14:47:30 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 03/42] hw/arm/imx8mm-evk: Fix reference count of SoC object
Date: Mon, 21 Sep 2026 23:46:31 +0200
Message-ID: <20260921214710.29422-4-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Using sysbus_realize_and_unref() requires object_new() rather than
object_new_with_props(), otherwise the initial reference count is
subtracted twice, i.e. ends up being one too low.

Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit)
board")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mm-evk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index c3215b11cb..6de0d9c4a2 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
     ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
-    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
-                                         "soc", &error_fatal, NULL));
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-- 
2.55.0


