Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4C3CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoER-0007na-AA; Tue, 28 Oct 2025 14:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoE6-0007gk-3v
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:15:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoDx-0001wc-EB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:15:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso10646935e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675307; x=1762280107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zA8SKmOgkqXDGcERg1H6mkjaSwJToDep8qiHL7yl9oQ=;
 b=kxf2Gi8s4AXIQUzGKJMNUAQE2EeJ4nKagRDiI81YYeAKnKnY7DJBHdxYkaQVVEy+q6
 xLQUPFAM6vmjvXixGDJRHeVU0y4y/u8OgScq3YYVGkmrJhapuhTnZe72smNYYpfGdrPD
 obBvya28p0wQHPbX+djEBGaKruCprqsksemVjDceMVbsvFqIYdoCeehORMFXBVoB/lwM
 s7wUut9A9baN2M3UzbtqvgznUJ7uhw5Mv9HkKiiDfQSAfSZDi95mts+u25tuIuR8+YGu
 VgWVSYtW/pQJXmBkl9/Ve7qb5HFNJoDCIZiWaphW8yaaLY4daQxaG97j5d0YCtF2Iwes
 pUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675307; x=1762280107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zA8SKmOgkqXDGcERg1H6mkjaSwJToDep8qiHL7yl9oQ=;
 b=qxNwnk0somEFTX/FgPq0gglC/rEOxgO9TXgipz3tS/m+SWlB8UxL7Nn7I3vVRJL3m+
 O0ae2cqJ8JH57QoV8Nl7wDMPvMQaKuz6rngV+qViE3FS7UHaOWKI/pQ/n1jJnn4cxrw7
 c2Vc3gWQ/YiocC8bwMAhbAsNMAXaA42gd+sBrhtQpauuZXrLKlVEkpri7yNfFANdhbOz
 0In5A5H375glrADVh/n3ffB8iGJ1Ym9Bo8xJGD5uIrqr861CYTqp5igSDNyOvim+Ddx2
 KGENIDfLIHugCHQZVMmE/hA4/ib8B4WZ8hrZJjxNHJNRDlw6grpmAla+M34VlF0rE+R3
 CmWA==
X-Gm-Message-State: AOJu0YwPg/Yyyarzp8KgLj/LY08b4UqgUnTryGgenHAIiHpeQhMjPjkZ
 bjLh/FTVEoZw1E2Df6EmpvB0NB5waTTUulDKMD+grfJh38Ohds9n9gLQImfXbrpw6a4MocMoFOu
 DUWXGb7Q=
X-Gm-Gg: ASbGnctDdtVvFKBX6acA8CqDqQjlI1ub4z2rN4u1j/f4x0kKJlJZkrGA+2d2PuYiaU4
 NYBmyO3cre2ZbRDduTQ9Z5uAecZMf0psmOF3b9MbQh4IznH2GQIEAG2+WerVP24dUBM25AlBVTO
 wcjYcEYvktL5ssIRGtwvxgWDINRM1D1fHPIDIDP+c8O+R5adNCA1pW0ma9LTbmHcb2HmqiTpnde
 x2DQEADYmJqaBvBRxNPuMT5s6O9Sqwuc62LPk8865q8D9i8huAcV1tYmpGNjI/kvLpS0XycmQCP
 dHX3SIank9WR9NlG3gFSY1gQT1kqHnvkSwwyYLBBrxmSLA1Tj5vS6sRySYqulInLcgsJpCcrYds
 T4NrQwHw9LrnF7d32lDrDlOuP9WI7EvL/ooppIN2ls5CeyngvB2LJx2rc5i+KqFEPFyj4MfuUi0
 JlD341VIf+6aeaxlPMl4fPx9hDb19Spe+a0qjRQJu6Bvwg28SgiZuQfSIZUPy/
X-Google-Smtp-Source: AGHT+IHGa7i8N5C193MPmkOywSRQJAfkqFaPiX57WAZi/cfIO5WheZGBTLOuNNoY3ewFL4QjIRNsZw==
X-Received: by 2002:a05:600c:1549:b0:471:1306:aa0f with SMTP id
 5b1f17b1804b1-4771e20e400mr3209855e9.38.1761675307364; 
 Tue, 28 Oct 2025 11:15:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718489d96sm26888875e9.0.2025.10.28.11.15.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:15:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 02/25] hw/i386/ioapic: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 19:12:36 +0100
Message-ID: <20251028181300.41475-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


