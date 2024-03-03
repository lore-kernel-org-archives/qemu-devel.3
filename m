Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33529C54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 18:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgqyG-0002z1-T0; Sun, 03 Mar 2024 13:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy7-0002xs-R1
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:55 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy6-0003yI-9j
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:51 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d2509c66daso46718051fa.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 10:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709492028; x=1710096828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rvC2H6C2Wukg8u7UcsRKEckfeM9Uh0xCoR3xrUsp3g=;
 b=W9gkyfT8wkGDvNsFTLBKmX4PdJKVtgZrOvufuhqaBdlTI/UK4ivX7cRrUKfZi/mCKd
 Navj1peKsJgY5cCNXauhNLCDc1hx5p4ySQw52BUNf/cw1B9dS6LliFdXqkN/pdtxTpzx
 IwvNAd4MTnmmyVQyNThT+FofNnsMmg8pytQkp1vG3Ie9XSLtbiZxy8+Il5lxFKndPhDD
 ah/QCKHWLSmiVldcG4iJTDToT3G4S1/PCvR7sVZiU1D5OTEV9fWehicH/d8i44lgSfQS
 1as5UD2Dzg7duf6RfZVeGv0//wUcPnlFKAE2Q/PYHc7VHhlNUI4nJMeiCSqi/221vSxW
 cmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709492028; x=1710096828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rvC2H6C2Wukg8u7UcsRKEckfeM9Uh0xCoR3xrUsp3g=;
 b=uRYGnjFirw1LvxhvAavLfaOpzxeq1wpsxJ0XVrKubcDiB8JNbNyyT9n6u16d22FGYR
 vxX0I2yV0LhFLGB6rbDtlc/PX4011WW5Zae0mQGJMKhm5QHYMDxtUrvl/icFsz8uh5ey
 7N0preZ1+88GIHxaQ9v/fQYA90+Ok4ANdJ67sF3Imr2q2OuwA2z5LpjMBSeqfZz2DaMu
 17Jl/wR4rXZrqGQGfZf96jR69RJuQndcgnZ3JqHT6GM1EH2A1bH4Lon3x/cb3tEWsASk
 DKRTQoU2bTeuF+kUQGnlpJxtXijl14UfGLsB4ncwtVWElKsLZD8IhjGCTvsO9cEfBXl+
 rwbA==
X-Gm-Message-State: AOJu0Yz+745coRETV7NeH//OgrxapMNpyeIJv2YwqpAAoVB50foiP48b
 t0NdD0dDr4EY7EeO0+Wza88b6jLpEzjgscO8j+LxKavCA0HXbei19LuU/niV
X-Google-Smtp-Source: AGHT+IEW5wf8oVE197xweQI8A8GKcmywEQnJPnvje6Vg4EM1fJeddU/BtZ7aGqakCwFsCwKDv/WgRA==
X-Received: by 2002:a2e:9d85:0:b0:2d2:b518:3ccd with SMTP id
 c5-20020a2e9d85000000b002d2b5183ccdmr5211263ljj.11.1709492027971; 
 Sun, 03 Mar 2024 10:53:47 -0800 (PST)
Received: from archlinux.. (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm5259460wmq.35.2024.03.03.10.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:53:47 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 3/4] hw/i386/pc: Set "normal" boot device order in
 pc_basic_device_init()
Date: Sun,  3 Mar 2024 19:53:31 +0100
Message-ID: <20240303185332.1408-4-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303185332.1408-1-shentey@gmail.com>
References: <20240303185332.1408-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x232.google.com
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

The boot device order may change during the lifetime of a VM. Usually, the
"normal" order is set once during machine init(). However, if a user specifies
`-boot once=...`, the "normal" order is overwritten by the "once" order just
before machine_done, and a reset handler is registered which restores the
"normal" order during the next reset.

In the next patch, pc_cmos_init() will be inlined into pc_cmos_init_late() which
runs during machine_done. This means that the "once" boot order would be
overwritten again with the "normal" boot order -- which renders the user's
choice ineffective. Fix this by setting the "normal" boot order in
pc_basic_device_init() which already registers the boot_set() handler.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 06ef278b34..7780d8d6dd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -614,8 +614,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
-
     val = 0;
     val |= 0x02; /* FPU is there */
     val |= 0x04; /* PS/2 mouse installed */
@@ -1254,6 +1252,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 #endif
 
     qemu_register_boot_set(pc_boot_set, pcms);
+    set_boot_dev(pcms, MC146818_RTC(rtc_state),
+                 MACHINE(pcms)->boot_config.order, &error_fatal);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
-- 
2.44.0


