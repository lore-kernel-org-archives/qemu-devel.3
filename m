Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B87CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MNj-0001VX-Tc; Thu, 03 Apr 2025 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLo-0007mV-MN
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLn-0000XP-3d
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so10746175e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693565; x=1744298365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0+RprBk/o3T2/onsX07N6cNtjoQucUjnD/IYou/K+s=;
 b=zg7nbwWvkxIFTPzQIo8htYVFz2UBC79HWrjY3kq1OkaqpgMVTXBQw1UN0JfXHemczl
 EVOyT3kgUIkMwjg6FOfsNGlPQeRxT73dgmfq4gd2a7CaKGmc7jKUt75fMJa3SOH+Xx+w
 QhJ0QRs6oelXNiWlcTpb0LDuul4u33v5pE7Y8yWLMne04FtX7gVFHYfb0pVJNn5gl6h+
 yKKV/FPBaPccAKwbd5ROIZ9RwS4hFG6x1EVo+4EGpZkmwR8HaWsfQ16OrQgyhXuxRmI5
 gN1MYjmzBULGeTskFJN5NoEHX9F4F6Iq/rfsOF0D7JRPn5E0cWeShU3yVWqDnIfAxlpt
 Y5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693565; x=1744298365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0+RprBk/o3T2/onsX07N6cNtjoQucUjnD/IYou/K+s=;
 b=qVTMyxw0Z+70e1Iil10no3o4zdw9Eq0DBkUzGuhbauKPcytazi2mdHW9SpQYcm/tz6
 2q1UblntqYMsOK+kN0LAwNu4i52qFZA0wQwYs/Dv1jtqX2QTh6P0t4zVzNM5MfF1phCe
 ICofYbt6QOVbXEiT4ka9ZmP7CU0kaD/K3/a0iYEKwQegsahRRoNPzIwTgHQ6kGOBikgJ
 NZn7RbfpEUTybtGjgctLw7cQdhAxpimm87SV+m3tVguYcKNO+TdR5EQpaN9QoRvn4pos
 HgbHHRWjQMR84v+kd500I5LELSi3b8Ikf5vT5aVii8llmVyCZB0oIJ4OZsCJhmSgxg0K
 9RIQ==
X-Gm-Message-State: AOJu0YyqchXX1IT5P3X0iuxN1xWdK/M1/7GMTlhNTN2g5cHj8eSrLOq4
 juQavM31eAJ+WtoFfHf52aviRbogYDbRqeL0IPeZIwDpJm7mJcdt2ggAdatlzIyFXMG+wl0UVt9
 G
X-Gm-Gg: ASbGnct8UBAJN84qpTbY5wkU/MbSBXymjqRNgcsy6kxlmDZuAGcO5bVfstG5AFJ4bl6
 KnBWmpvWVg+b2HD4BLi19qcxUc0FOIdpmsjlw2x+PDjH/N2fve2qNGGzQlLG5rVcwWi2QA7y7IJ
 6NI7kAG8umQRMBXdgRWD6P186GtS7xxdAEquxxaNgnczOtL6Nq1NsCZHaFB3hJ7gXG4j48KcJgx
 C/xkQCcB78YG86PixXWkO5604FIaxuvzqp2FsMr1Qk9pRM8Hc2PazkrMEi6INyBIdzWF0zRuDwu
 qqtRqRgeyb7UbPJX6caz7Ep9kpFedB4i3ArtXqutKXgt6KGJoJOM91D0wPCUSVbfWHa7qvLEuhb
 TXqCvo1lxt8nlWGtRpbg=
X-Google-Smtp-Source: AGHT+IFQaLyp+VASftM/8c+uxflaQY/ts8/JzD3JMKwIVNijGxWUU2GZ/7P7QgHgIEU3FdsgF25K9Q==
X-Received: by 2002:a05:6000:40c8:b0:391:2c67:798f with SMTP id
 ffacd0b85a97d-39c2f94c014mr2681507f8f.41.1743693565261; 
 Thu, 03 Apr 2025 08:19:25 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36691b3sm21460425e9.34.2025.04.03.08.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 08/14] hw/arm/virt: Simplify create_its()
Date: Thu,  3 Apr 2025 17:18:23 +0200
Message-ID: <20250403151829.44858-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

No need to strstr() check the class name when we can
use kvm_irqchip_in_kernel().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c0748cbb95a..d17755548e8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -711,21 +711,15 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 static void create_its(VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vmc->no_tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
+    assert(!vmc->no_its);
+    if (!kvm_irqchip_in_kernel() && !vmc->no_tcg_its) {
         /* Do nothing if not supported */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.47.1


