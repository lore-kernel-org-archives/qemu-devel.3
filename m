Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD5FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoFY-00008j-5G; Tue, 28 Oct 2025 14:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoF3-0008Q1-LV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:16:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoEy-00024C-3P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:16:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so3263290f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675369; x=1762280169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMOoNQ4yfP8zRjN/wkqFcQTswPDQJkEjRZPyBLzoOO4=;
 b=mBL6CLxA2L+RZlV9pzJ1CbK9eJTwCmMSHctZOe0EuyvLFVImmCocLgjtxEQlR3nbxE
 9YAUrfno+siznb2VRG7aS6Dsv/TjvmZIHQKeyREjhi02m9D7QvEtgCdV3Ky6YiVkewv3
 0wjvd+3P4bumVRu5Zuvl8kGMYfifk0pHPpmpIaYgKu3nJb6IPaXvk/I6UfALjouODPxA
 QBFHUY6qZfeNq2D/2pLH13JcqCi2MbF98xZLi9qpYM+m2GY5FJpkAHDgqGznAJoJB89N
 vMCIu/XI2QAvap/9kjptXGpflkJuZy7FN7nBfsb3shu0MTYB0QzsGn8b7036+6o9M5Om
 W8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675369; x=1762280169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMOoNQ4yfP8zRjN/wkqFcQTswPDQJkEjRZPyBLzoOO4=;
 b=O7DBF5xiy8Ci7naUyXUVj8hG9BGYfQxVEsNzfOoh/OcP6/N6kn06fJxQePf9ZQuRbB
 VrzASlp/Cq+iobaKEDvcrnG3iEztGHtKbJTpPPg9BK6tdXHhPGKkCOAUMh9lGqGwRWIe
 3NuK3cv91l4kumoL6BkTMeNPqF7bsj4mrt6bHG8pmK1OiZB2vQ77cBh/2ytL3UQP/PZo
 j+Jeq61EJaCv5TmslO9+YbKn5Qlf+cSdrM2DZCp1XCkuoFEPrOojQb8CDZVw/hsgRcsG
 SitZFs8StsSAB/vsDYMyUqrG1yp9rSnImACwG2OKS9EGCqdd32OCjwTjR6GmJoLQLZx/
 oO4w==
X-Gm-Message-State: AOJu0YxeBbOeV+wQE3nCkH0UOG55WPAjBLDV//rieyQ5bWsAVNYbY0j9
 dPhudjdVrggWFUIm0JiSONpOqGS6XPvpoxB/0mBb/G6W7hQgnR7zLAac8F+kVyevJ5jZy7Ct1sU
 kf8a0Gvg=
X-Gm-Gg: ASbGncsdyqYvfYadhIBUfDGQBvNOfFdSXLCwSlGMAd/7vDfLjoz2T5WlTA2CBsMJov7
 wbKhIofOLS1WEb8NvPN1UkXh8SHvaqsAidd07XduIq11mDEKdj5+pYeCGxCO2XNZg2BMJK59XrF
 lsoAsVXOwTszag7zOafEyfcV6iqOT19v4pCKsyEBYsBNtArHR4YrSLShzTgaNKP3ETur5rtfGIW
 wvttwEDJjDQDZOZ3OcOll0LtN+umeL6V2LBv1kb5ZYGvPK8Sb04ABfX8edST+oveIojdJdm7/7V
 lT1FTQ1mxJxuv8UlsMDmzsI92eWKnI3LyBrefFDiThWkGaP/i5jcwvy5Fd0SLhEXCx88ZZxXfqy
 AbaDVjHeupE9aC9L0nANlnoLwbO647M7pK2WjGj0L8KIoaa9dcdhUFDkux6RkTqNCavwg4KO1LY
 Q0a+cHn57XqtgTIbSVMJ1hxGElNkSnqbxOxDFCkMHStetlK5OMSA==
X-Google-Smtp-Source: AGHT+IEjfV7sF/zvHFmsLDmAn/faukg/F1LWBSlaDOpKZ7DB2WWlIEcz69CsAWaVreP4Y8dnZflKXQ==
X-Received: by 2002:a05:6000:40e1:b0:429:89c2:d944 with SMTP id
 ffacd0b85a97d-429aef82febmr23492f8f.15.1761675369423; 
 Tue, 28 Oct 2025 11:16:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7d1sm21956221f8f.16.2025.10.28.11.16.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 03/25] hw/timer/hpet: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 19:12:37 +0100
Message-ID: <20251028181300.41475-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

SysBusDevice::mmio[] is private data of SysBusDevice, use
sysbus_mmio_get_region() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1acba4fa9db..c1b96d0a89f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -654,7 +654,7 @@ static const MemoryRegionOps hpet_ram_ops = {
 static void hpet_reset(DeviceState *d)
 {
     HPETState *s = HPET(d);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(d);
+    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(d), 0);
     int i;
 
     for (i = 0; i < s->num_timers; i++) {
@@ -677,7 +677,7 @@ static void hpet_reset(DeviceState *d)
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
     hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].address = mr->addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
-- 
2.51.0


