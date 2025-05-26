Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D79C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 20:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJeah-0005U9-KJ; Mon, 26 May 2025 16:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uJeag-0005Tz-5z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 16:38:34 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uJeae-0003Fc-Jq
 for qemu-devel@nongnu.org; Mon, 26 May 2025 16:38:33 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad1d1f57a01so526862566b.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748291910; x=1748896710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPXHECAissZnEw+lEAzkB8iRvv3z5heujH7hDxNB0NY=;
 b=DXTLziP8lqeGe8OJNBx4Oa/8xRHmJ5ilKXq5FDlptWj/AcjRtiK4iE8FmgRYWUH2J3
 he04F+X7OtSSXFYs/KiVj0FM9FFICKBD8+mmq1edhra3aNq00voaDu0rJNQRZcHHhf46
 1c/VwUCxFXY25QQkTt3lNEK5we/hig7OU10NYXuxaZmmx1HRAc4pyqXhBUTFcSFdUgzS
 uuHfZWWmSC9ABVTrwowcU1ysYaJ1Dj5kba6CvYvEi4czS56Mx2NMI7ADQ4i1CYK7PwHo
 OaAn11tEC7DDdJjLQiRB91/aNyBskLGfIIcOqA8gWtlDTL9ZuiEp2k7BAV+AmK/B7HHz
 RkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748291910; x=1748896710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPXHECAissZnEw+lEAzkB8iRvv3z5heujH7hDxNB0NY=;
 b=YFWWShyYTrIzxFjNT8uUeIc4XfJo04UB73CHyezsmOMw7lPSyjNwXsWCi/ThTsYqSK
 kaNqLQELzUT+bczbmqvPhd0B6ClJwYAMyyVoFcGJpiItSrnPrvLfE8Y0lAGLiCwwjaZg
 g/TGFAaEH2d6hxda4Vu4ulhbdpIca54bMH6nXlCh1toVShR9ITV+Ce3RXEgGEquFifU2
 MoLkKJbMgbU/nnkr/Zwlp6iwF7+QGz7lbm6ppyBFjBUygtBYYr8nW0fbbvjpW/m705q7
 Qcsj2OgDXV6BbeKRZdrQSaPo6PIAR5+WvXa73HPdEaqXld6vDp+8XEMe56LdTIBV+spY
 N/qQ==
X-Gm-Message-State: AOJu0YyB6sQTRQPwJi6CtZM3yb0il5yiaypdqKkXW2yzd94ePYWOwElb
 MWfJjQrG2fSAmRqfHR8hsvEXWGC92EkMfmVK1t5kjQum6/xZmZNZeeIiGzB1TK3b
X-Gm-Gg: ASbGnctspwZQjrxblwuKBVxxtTZX6+UJGRKHON7DL1Ef16zuAQYbN/niT8zrRxLI8TA
 qhhOgMXY7j1HLqwDz+oy3DV+esusaAxut3UY7wsz+crYWSsJ3Fg95EjlkhXNgluguT6XlIvMNze
 GBJKwJR7GVbfTvt/6sJqTI8rFKCIbHS8rrMK6z2p6hkk+h8+OKRgTlVS/lW7aYqtX8rBCKS7VzC
 dYYp1VFamTYn/IudfI6JtR+TUUejA1heKBfL3+gwWcVSt825X8jyNO8S8YIK3Wd7SN91y7SsBGU
 6Z9NY20WzXWC2Fybe8i0zqkddPDWzs+Efgk8LzLLFObm7PLYHOgpW5kyUpKMDnNEuY3AQwe3tLW
 UZVeDqdLBdju8Qt1Ptv5ZCfPqsa5IcPPlT8uNUDc1z4/TgNhOJ8GTyc+tPv7Wxf6O/vNn1kU=
X-Google-Smtp-Source: AGHT+IHcibaMZlrD2lSNNh45tDWMB4AoFWiwMl9PVdV5QhehVvS1SbPZo2FJk1ov+SW84BjTCoP5mA==
X-Received: by 2002:a17:907:9715:b0:ad8:8835:f794 with SMTP id
 a640c23a62f3a-ad88835f7bbmr110854466b.32.1748291909721; 
 Mon, 26 May 2025 13:38:29 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e3c-a000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e3c:a000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ea8aesm1740919966b.179.2025.05.26.13.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 13:38:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
Date: Mon, 26 May 2025 22:38:20 +0200
Message-ID: <20250526203820.1853-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
attempted to refactor RTC IRQ wiring which was previously done in
pc_basic_device_init() but forgot about the isapc machine. Fix this by
wiring in the code section dedicated exclusively to the isapc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2961
Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

---
v2:
* add ISA_DEVICE() QOM cast as a safety check (Mark)
---
 hw/i386/pc_piix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f18..6b6359ef65 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
         pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
+        uint32_t irq;
+
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
@@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86ms->rtc = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
         isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
-- 
2.49.0


