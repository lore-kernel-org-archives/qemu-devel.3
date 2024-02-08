Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E29C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 22:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYCV2-0007F0-EQ; Thu, 08 Feb 2024 17:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCV0-0007Do-Ny
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:02 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rYCUy-0005DU-Kk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 17:04:02 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3850ce741bso29483166b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707429839; x=1708034639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MksDv+yuTaWdPt4ciwdCyn21modyrve25TmwyGLNphs=;
 b=I6Rh3ciII8iiwgTKkbXPAUhqe3Nj9B49FqX8PtAzV7b9d8t20OpCjHbFYFfSTAy/jS
 C09g5imeeY+R3FSzUMg/bcYkpMOvdRGldKEbCeSRaWHes+dU8wzNHFD8EN/3MDgWMaTc
 B1t6ZZuD1TbQH09+l77afGXsd6f4/JbT++maazLg3qJTdpuxJ4/T/ITokF3n4z2eP5kl
 4KecPWgcUpc7G3YIELvms+8+qMuuQO4EVJ35Mh0xWtr7jS4eEmbNHFK95q6092prfOXH
 WTY8g0yGXk3R7F3828UI1abA63ZHhFJ5n05ZikahhofLDMgHoRFyj1KYnkSs7/HsCIm8
 PIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707429839; x=1708034639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MksDv+yuTaWdPt4ciwdCyn21modyrve25TmwyGLNphs=;
 b=wX7sA6Z4LJbbrSRMpMR01GJKBWilrV1RkW0U0u2T7UVanCQPTNPvVz992LHK8Omr4L
 V8GYKytQeY/06aznpVst4wIM+XcGJfZtE3/iDGJ4m++NNenkW0D+nTR3uAlO2ZeXyG7E
 y61gZXPmAxrww7RF3fzFrXz6EIuxQ10m2SSdU68bbLIRVXx2mHNNRIrgrm2m7dORDndS
 NhQssufbqqYvSjHVzFowK6ZbcTMXnHfRFd11VkBZRn01ug4yLDC3bNHKyNTRrI7VWh8+
 rZGSAFap4MEDC2nk/scYYqPjcavPyBrnGZu42fY8HVtYlEkmPYkmlaSdM1p2HurTpgu+
 aLbQ==
X-Gm-Message-State: AOJu0YwwEnHzFOaMEr96kbkECtfCrfLx4zwKOMUFdTv3hZiDRFmBHzgY
 yImsB2VjEtG0xFQZo6RK5PsEMumui9rKzgX1zmTLT3KPJZYUKnmiqq/zT8bg
X-Google-Smtp-Source: AGHT+IF3doQBwPlTff1JBpCYhoMLchHMVBVk4rt4ky2Riv/YdYWSkSnlhaDdjAVao2YJ5T7cgOZT1A==
X-Received: by 2002:a17:906:7fd9:b0:a3b:bf98:fa21 with SMTP id
 r25-20020a1709067fd900b00a3bbf98fa21mr427304ejs.76.1707429838541; 
 Thu, 08 Feb 2024 14:03:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX9qSaZ8dwYbfgen88Xox2C+UejbFs0Oo3Ic7Un1ytEaFvm36wu6mzlyJFlsor43/26FCv1kWwEJMNtQ5HFSwVatjbpY0+p8MZX5q1ASyJnL10UYg6ZQzzl3Ukm158OEKMs/Be+PYk99Djbn4/f7fCQZSHecmjcjSf7vP3qsyuPevwoTYJywWOe6jcZifJipemwLKnD9vY3XR2Y2GYXdg979A2pWAAKTvCprOn1uJAwARSbfjF3
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 ti9-20020a170907c20900b00a3109a492d4sm109753ejc.20.2024.02.08.14.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 14:03:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/9] hw/i386/pc_piix: Share pc_cmos_init() invocation between
 pc and isapc machines
Date: Thu,  8 Feb 2024 23:03:42 +0100
Message-ID: <20240208220349.4948-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208220349.4948-1-shentey@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Both invocations are the same and either one is always executed. Avoid this
redundancy.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5ed3d69181..adb3b5ed43 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -340,11 +340,8 @@ static void pc_init1(MachineState *machine,
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
-    if (pcmc->pci_enabled) {
-        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
-    }
 #ifdef CONFIG_IDE_ISA
-    else {
+    if (!pcmc->pci_enabled) {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
         int i;
 
@@ -362,10 +359,11 @@ static void pc_init1(MachineState *machine,
             busname[4] = '0' + i;
             idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
         }
-        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
 #endif
 
+    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


