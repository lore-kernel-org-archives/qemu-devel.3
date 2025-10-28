Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4A2CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDegh-0006mm-CS; Tue, 28 Oct 2025 04:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDegf-0006jv-Rt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:04:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDegb-0000rb-76
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:04:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47112a73785so35625275e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638646; x=1762243446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXTrcwnFN2dR0ftftMdZpCG9tw6TOxe98L9iT4TQNSQ=;
 b=xwjN7urz36lJ850xMIPLl/RdKR+on8dA5wr8HTdI+xxQFqZBce9M1okYOQh/MENN6N
 6zInfb7jBBLe32wotLUtor/5MkEZEjf+ml0nyl0YxMZ5PY8yy7VwP6LnnPyrkBDhboDH
 nVRL9y41tX8dSLHzhF+5rnvu02LeNa09jPpSpRS12fJgeS6QAprWWQIFxMlwI6ew5Rhz
 1iN3Q7wMX0CRxpgFtD8REFjgGMrkHyMGlY0Hqe+20Cd3EYf5LICTLD1frPuAndDnkpOV
 fE72WjwISxEudLILZ8MopWfZ+E6ZlyQo0U1EEJ5Gt3vGfesz88sVvHBOphJVLtTrrjad
 2uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638646; x=1762243446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXTrcwnFN2dR0ftftMdZpCG9tw6TOxe98L9iT4TQNSQ=;
 b=m7DRGnkV6hFUY76PQyNssmrln3r3sRyzqyVa2h+VLV8ElOCtXC7XvIexQj+PnrXkdV
 pT1c+we4DDPEOyuLY6IDNo51iwoIUHDlwANqg52aBEUVuICxU9T6FWUMRAzWWECPuAg8
 D9YC4GBw+eQhijvcaFwqFFwJbxpmzMVXLcCZ1I/EnNUbshvse/r9cv0vnH/Z9P65TFS4
 j44oFCsx+fhRSclJQ+zKuAHWe3YXU7T3gJZvoqbpXcU4MQxxktg3LmzTqEDYuQnPK3lu
 qma+2fWu4q4mnsbPmYeH2ej+fO/54Qoho5UOk3OOBevQP9SRTLMXNz3Vwvyk8a5xsriU
 pKUg==
X-Gm-Message-State: AOJu0YzPDeDpTRGzgb/58sp50PwXw3vuZrC/TPXVHfLuWjEmlSFqcudb
 A5wXsElIrX9ii8xoNpbYVz9vh9yA1CA2joSzis2QPb1B6gI+iB1PI3S625Ac9F4V+GTowV0Yju0
 4TMpTpkw=
X-Gm-Gg: ASbGncuc17c8aWPuY8b5iqrQllX0pM/X8xWhcIT5LHnBkZ+iYjXIFve7m9s2AkWhazo
 Eh7K71b3pZK+HwiqqwRovM/C5cK92Xn0T/4biwqYN2HgrIw0QX3F5r1eyahJj+AvQ7QaI6Z5mgl
 Rw1/LTiuG3taK8FICc7j+jSTW6axots4Tpj5ssKZLcHgxF1pnKLS9UNoB6TKNh6h9AmSmVxOlKJ
 jvYsjXkB7oRaq9pc1iQCTs6+vwy7S4KtlsahNVR4gomjjAeLfkJGvNLHDbmA0dAJiRyt5CurgHz
 Kqq+mgmU6CPr5eYnGigT+wI0LUCbE44hUwAIv8XRg9k1Dv0zf+fLjEvox4e5f5fGFhqkwWcYH+Q
 eGLQ4K/A98h0Msm/GuOL4Q7BAvX9oZSVXB7efAg1PQxxIBorXPEIyNm7UfwmbJIbhgVqtdnrVQp
 cw6KD7PpGHCjZCjVE1ysxgAkPd10lE2/0J1x4/PpRwRYf2VS2Pnru/PMQ=
X-Google-Smtp-Source: AGHT+IFSc+GTUbGoMWV0djgdJjUsuRAV3TG84f4Wo0S16Hh+bXc/T+lXNDrAgKUF66mxAuI5Dv8UBw==
X-Received: by 2002:a05:600c:4e93:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47717dfa486mr18951495e9.15.1761638646065; 
 Tue, 28 Oct 2025 01:04:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771843eabfsm14785185e9.2.2025.10.28.01.04.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:04:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 3/7] hw/i386/ioapic: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 09:02:53 +0100
Message-ID: <20251028080258.23309-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 hw/i386/kvm/ioapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 693ee978a12..0519432edbe 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -80,6 +80,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
 {
     struct kvm_irqchip chip;
     struct kvm_ioapic_state *kioapic;
+    MemoryRegion *mr = sysbus_mmio_get_region(s->busdev, 0);
     int ret, i;
 
     chip.chip_id = KVM_IRQCHIP_IOAPIC;
@@ -87,7 +88,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
 
     kioapic->id = s->id;
     kioapic->ioregsel = s->ioregsel;
-    kioapic->base_address = s->busdev.mmio[0].addr;
+    kioapic->base_address = mr->addr;
     kioapic->irr = s->irr;
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         kioapic->redirtbl[i].bits = s->ioredtbl[i];
-- 
2.51.0


