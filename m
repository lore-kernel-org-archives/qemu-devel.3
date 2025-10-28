Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ADCCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeZH-0000l4-DC; Tue, 28 Oct 2025 03:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZE-0000dl-LD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZ9-0008AB-Vk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so31915225e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638183; x=1762242983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xvt81oTocua1Ta8tXB0FL77zCb5dz+PU0F1ycKw4jeM=;
 b=YkmuXmSrJoVBUYT7M7zn6e4shHg4HODH9AQJ7wygtt35qHhamYzW8XTA1yhUlnHJ0t
 j8AN91rvtOrefPYoVesumlhvWutskUYOY1qAZzCtcr8iLKv+4K/nwIK1yO1w9QsJWbe3
 38aMCsbz9H8gwXyyFYQkIn2R08dg5z0b7Cqe13KdQJk3rYZR/WV6fuObumusjgEktCJG
 fQZQV8zFCU+3fHZlKfPS2pvRecFaKsQwOleCA3sZ2bsu4adzkjGcTjbex+i+VBkK9DB5
 kdW46tfqN3JwUwyIi22YbJG9PiRUydt3j2gVv/W+Wh7Z1p3jULpw3xKSGKGBKq+NDQ4j
 uY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638183; x=1762242983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xvt81oTocua1Ta8tXB0FL77zCb5dz+PU0F1ycKw4jeM=;
 b=Izk7uqX6TiBXNaSGP93MgP8eZhQDrC+2mvpvuglaNVQcdo09oECGnrOKITatp3Z4wW
 G/XH1Bsgx2pjvLeKRUEZ71q2kH/aZGT1YzdM0Owd9r1+Mjix/99DlwXFKaj0YQfNIz1z
 R3ElZW6vtDRpqrS+TKrTXKdUV6KNhhQgHbeO+rnerwG/7h6IM86OcPh/U5f37lnmPDDg
 tnqqvRUvHjeVcF0MmkvjouStN/mNiYw9U5/g3b7hmHE1hvu0/btgx0f25aCWIiVv0yBj
 CVPvUNdfyPH8NE4s5pezJr30qL4MYYgXJYfKEIJD8VMWllNC+BDfZiqs7BdrNhKW37rf
 TpgQ==
X-Gm-Message-State: AOJu0YzgZdh7ztMa9d/Lpy/7sunowNCp1TOZBn4WsmbnErunsgxAhIJE
 gg3HI6WMHGWPCwvIYyK9T41C8bSg9WsUv9SriW9a+kW6WhZleUHi8+rY0O6+Nx9jgfhM8eSlXe/
 DE4eTJYI=
X-Gm-Gg: ASbGncuAaYofF8d0SwNkj7ewCwuZPAQ04nBYfW0PsX1kmkKn7Cfm2JCTdsKASQCpMKH
 g4i8fkSQLC2ptlw4u8nsBj298Q6HZAKyDXxVjPP82vDjdt+30LWm6fRTddZzSf1a7IkNXa382wr
 3FKEMqadYkRie5NFOoJuPiWC1iGxuzHSxXyVpQEYjqUxQbHTSLkEz76NuzY/p1fBbHL28MZ8UyM
 PNSp5DfM7hLYOOJh67nkzNcWHDoozAKKm/yCAgmhOCGg7ksdhEgX44COThkTVyyBeJc3u1dAFqk
 oWLk+rszhfTCj4yNgEjXJ7AfIT3priXRAx2JkLpdCJdPMUhcin7foYr6nRy2f7Miwy0t52jEeF0
 FjTOl3vDFtNGiu6Wrgn0vqkvXnOWawDvufjGzXfmV8aACOQbAenD+vX9RO8zRoEtcerWACpEKu6
 uvp0fVV+1vSc5bJ1yfPvNgokEmsZ4GAdBY7GjW6f3gz3YPKzbBZZHWNm4=
X-Google-Smtp-Source: AGHT+IHJczaNa5566go8c3wZ290JctSo/N/xFdkjbKFVABKLNDJwm74dH07xf5bTDNLHO2QyujEMDg==
X-Received: by 2002:a05:600c:4fd6:b0:476:929e:d07c with SMTP id
 5b1f17b1804b1-47717dfc3bamr16019745e9.14.1761638182757; 
 Tue, 28 Oct 2025 00:56:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm184463205e9.15.2025.10.28.00.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 20/23] nw/nvram/ds1225y: Fix nvram MemoryRegion owner
Date: Tue, 28 Oct 2025 08:48:56 +0100
Message-ID: <20251028074901.22062-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

s points to the MemoryRegion itself. dev points to DS1225Y, the real
owner.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/ds1225y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index dbfd0d2e536..0945e36652e 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -126,7 +126,7 @@ static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
 
     s->contents = g_malloc0(s->chip_size);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &nvram_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(dev), &nvram_ops, s,
                           "nvram", s->chip_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
-- 
2.51.0


