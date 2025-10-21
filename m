Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C272CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHy-0000QA-8T; Tue, 21 Oct 2025 16:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHs-0000GP-34
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHp-0001C4-7l
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47114a40161so18069755e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079730; x=1761684530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1eGb/qWicD87v06dVtQ6TfIwBX5R3IiSQQ+m6Usu1EA=;
 b=ix2sFrRhLEbQn/2iGSmegEzgb240YZeUsja8qUKft+gQJ5Hp18y/DW44w9CnR7660D
 q5viV81cNm40XQHVApahUNnYi7LxtNcgoGbfIZO7uiT1NQ3dni7CTSjdxOU+Vc9UlP1G
 ERnhIUeWlcH8tdY0qbMikbdXb9Uj+0o+/3vSDrtHrhpWgfcB4v0HtJoRnFKJ6g3glnrQ
 ybrmvZVC4t3Gm3nEf3enY7QfIVrCo0UCyVtLDpr4Jt3+C2iwtD+rP0sEG6HmhO1IKuXj
 OIxjjqRhZjdI8cF+Cqoh1+4gSNjAyATqQmn9YS4GyNq4BS03ENkxDqVcMraoQvXgf8dv
 FfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079730; x=1761684530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eGb/qWicD87v06dVtQ6TfIwBX5R3IiSQQ+m6Usu1EA=;
 b=ecSDphg/wwJJfkrPj/1ajUt8n1WAxv+A6ehFPQYt3/GMaLOlynupPmx4MCLFCEfoKA
 SfxGR+d0G4RE6ikyBWXnIWfIvhgEH2SzNyulmKyyTFyHu8w+71q2f/CEVC95b9plxCuH
 q4K3JkofQA7A5RTgdqfoiSueHvwd5IL4VG3jwGje8MoK0dQDjcbX7RQbXOn8bv7Jg1r6
 5ushl2TYfxXVc5YRi8bqCC1/lRocUkSMgFMcLjRIQgtzqbPASfYN+DhiR9g4vxsRibG3
 maAUZNBr31n49jCuNkdLhBuAnwQCIvf2CqCKRGcrCMKF6JVbrAqr3VWghgm4fKmX57Lp
 dnNg==
X-Gm-Message-State: AOJu0Yw8w869JXR4XyLubPpeChxITjzmzlEVIvaxzWsXXlJyZYjJLq85
 Cow0G/QADktdre6rqy+NkgjXhDDBQadYpdx8M9s+3Fi57s568CfKaqU4DlSOSYVBVcADejsq05F
 RFEXxNP0=
X-Gm-Gg: ASbGncsYKDC0PZngzmW36JYONmSXGkb/uP/IRSQsrvNwlyRrG8rwqbFOpgWViLSUrhf
 8msSW6f/5KClmxIQnMelrgPpgTnixbBgV1It+ozmgg7q/yXC+vHOb35XsxBP5eksJogGz356Eyl
 0z4wOmEqIr46GKep4XZa2yp1JGtwyExzpQxJoc5GEP6hraVBDV6qycW9q3P60s4FLs3lGadId8W
 JgbTpyCjFg+yKBhiVgB/nSCj38xaUWe79l5Zx26Nw1MGN1mVgF4VJwHvakS8Iv5/E0/6eyQD++T
 lxZ0SkekFWbYqxZE622zPlvmpqgdYA4N3m9LQIUXi1c1U4otE+r5mRsViYymrf9ObnPNhq2sBFR
 j2DhENmGk5iOvIXquzV4Mmxp0mcjn62dysboUAbyfWHtJ4j+LbUq3pZPdtw9qCVaGwBBtyiKmCF
 gBfEJIWm4fjV8FniGlJSjmqU/IbmxqeSVy4AI9tSHKInfSz6w1YnVd3+GQie92
X-Google-Smtp-Source: AGHT+IHMtTUsCeDArJeD/9daPczhMPGY8RM1UoZBRhQSnbMXC5+UPgeBXWny49LTqpzMVdmKkwJx5A==
X-Received: by 2002:a05:600c:3e07:b0:46e:450d:e037 with SMTP id
 5b1f17b1804b1-4711786c560mr143291925e9.5.1761079730576; 
 Tue, 21 Oct 2025 13:48:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b02475sm24800085e9.4.2025.10.21.13.48.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/45] hw/ppc/prep: Always create prep-systemio
Date: Tue, 21 Oct 2025 22:46:37 +0200
Message-ID: <20251021204700.56072-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The prep-systemio device models the system control ports of the 40p
machine which is not an optional pluggable device but part of the
system so it should not be disabled by -nodefaults but always created.

Additionally remove some line breaks to make lines related to one
device appear in one block for logical separation from other devices.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <b5b0150b6c579b10682f6482e7832cf381ffb759.1760795082.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/prep.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 982e40e53e1..c730cb3429e 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -308,6 +308,13 @@ static void ibm_40p_init(MachineState *machine)
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
+    /* system control ports */
+    isa_dev = isa_new("prep-systemio");
+    dev = DEVICE(isa_dev);
+    qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
+    qdev_prop_set_uint32(dev, "equipment", 0xc0);
+    isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
+
     /* Memory controller */
     isa_dev = isa_new("rs6000-mc");
     dev = DEVICE(isa_dev);
@@ -333,7 +340,6 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
-
         if (machine->audiodev) {
             qdev_prop_set_string(dev, "audiodev", machine->audiodev);
         }
@@ -344,14 +350,7 @@ static void ibm_40p_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "config", 12);
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
-        isa_dev = isa_new("prep-systemio");
-        dev = DEVICE(isa_dev);
-        qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
-        qdev_prop_set_uint32(dev, "equipment", 0xc0);
-        isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
-
-        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
-                                       "lsi53c810"));
+        dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810"));
         lsi53c8xx_handle_legacy_cmdline(dev);
         qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
-- 
2.51.0


