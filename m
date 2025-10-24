Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37138CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNBR-000561-Mv; Fri, 24 Oct 2025 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNBK-00054x-Df
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:10:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNBH-0005yY-K4
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:10:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso3332845e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333029; x=1761937829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfFJAb/KcoEMKci+o785xcZsNgBjcX1J9BbfpmwSLMI=;
 b=VmufCYqd1efBaAb38BREtu2GEJlFpuByifre4YKtIvxB93VpvtNQ3p+XyvedwNqX3j
 d//YKh1Tgf+fdBrO6jwggyyNqyTfgVJ5phAkiGiyVGr8KM+X+Xdv+JX0j21HfTLD21N+
 c/5Dr5VsdZIRaJjho0sNROCk230PnheiJMkqk2Gm+0rnsQCojls8dj9xz5oDQ9XaLtg9
 PXXiFaqXvtymyCeQBnbTDhcmEjpJh4BcxPBVnq5rVHb4Wr/ny4gUFeULaHiTxz3QsF73
 IUGm+aYsCZkup3fPP8pdXQpI8+wK2YLEmaiAxjYP9AiUzYluVzew/H8xVNjuuVGMXQCW
 0tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333029; x=1761937829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfFJAb/KcoEMKci+o785xcZsNgBjcX1J9BbfpmwSLMI=;
 b=FLcQnmL85yupb4Orw0by1rek5HZ4uknAq/bLzs8603Tw27igC7cTNJBFYoVoe/Yhxe
 GMcoqvNoDwowy7a/Ra1amF7fSiO+m1QPJ0ZIK42e65LoGPiQF64kUF2EMM/exM6s1d7x
 CEei560keXsJB+93f8p0IS4vZBxYtKcoBTTagT3nz8wRaeu2xTl56/gVzyrJKViqRJkT
 rCuUUT+748SWmXqRYLEJHIuHtXHiAKn5t5G+JhqcGZhNdhpGKhf0P9m+7skJqlz8hC08
 6l0mB3qiD0j8wl4924r1Nl6hQSsORap7liBxxtg462j3n0T2UBTWVy/f5LlBLI6GjOhC
 VzFw==
X-Gm-Message-State: AOJu0Yxs7kQch13uCh9Z9dHPTc0ri5/Z/rpqA/4u26XFjt7gEz/j+e8L
 H61b6JsIRc2RVZPJjNSdrsJ7u//OoWJFX2wXtsUfsz+smZJneysQS03+RRisEL5vmw7Ma3FgH2l
 wu/QCDaw=
X-Gm-Gg: ASbGncsW5wMvgCDJntCirPRRTvMINYiZS5tYjJaXNU+/OvKSfNg4EIGa1rUuG45TL9+
 Q7KoozKljdYOPTVIlAS3/2SkdNGOWx/qf5Pu3qjboSQs1f7/AMdgvJXrdJ4wcjWK1cmmJu2AxIZ
 KqLSgU2X2hiOkGeLZVpQYNGjYq0zyOja0PVsvlx7pGcSFX0vh06zEtBjjSbAZXMB8j1GfsWo7BB
 Q8fm1lf1gzXlSKEO+4EYBenw9CpRf2DBy5MbQJuRLLSz9XLEkx3v1TcgXdQJVMQUTpVMo7mvZxA
 F0Rp2dIqFT/TWChcREHBR7BguyFz6Ym6npogvcphLMTfPJCv3P79kFss31kN+74r9qa92N18ws4
 lbd7i4dXrNT0JXiFRz4WCfsNVv6Cy01YaDdiP2iV5og8Kj0NH1lFfCkQ32ggvwnURdydVPM3WdM
 u1JaacRAEIgzEn4lJX/cnIfDUm8ydobttAdQn8vsHO9QNyt8hA1A==
X-Google-Smtp-Source: AGHT+IG/meHJkaNRhIs7e4BzP8Y0pKzZddPA0lObwZfKmDDtc5JNXAo708iuGM3repkxV4qyozv+mQ==
X-Received: by 2002:a05:600c:811b:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4711787dcfbmr208223115e9.14.1761333029128; 
 Fri, 24 Oct 2025 12:10:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4298b9963ccsm9027464f8f.7.2025.10.24.12.10.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:10:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 04/27] hw/i386/microvm: Use proper SysBus accessors
Date: Fri, 24 Oct 2025 21:03:51 +0200
Message-ID: <20251024190416.8803-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/microvm-dt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index cb27dfd732e..d7f49bc1b5f 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -71,7 +71,8 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
         return;
     }
 
-    hwaddr base = dev->mmio[0].addr;
+    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
+    hwaddr base = mr->addr;
     hwaddr size = 512;
     unsigned index = (base - VIRTIO_MMIO_BASE) / size;
     uint32_t irq = mms->virtio_irq_base + index;
@@ -150,7 +151,8 @@ static void dt_add_pcie(MicrovmMachineState *mms)
 
 static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
 {
-    hwaddr base = dev->mmio[0].addr;
+    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
+    hwaddr base = mr->addr;
     char *nodename;
     uint32_t ph;
     int index;
-- 
2.51.0


