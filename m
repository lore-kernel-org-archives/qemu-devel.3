Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6989C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6ic-0008SD-7Y; Mon, 03 Feb 2025 19:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iW-0008Od-C5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iU-00072H-TI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso51266665e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628581; x=1739233381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVNCwynGFIOtISxx5EetqRZMocUYGnGpNyGbXMYbhl0=;
 b=tMIBcUE2VHK4TgQaIk3UOJ4qm1DHFXc3cS13gKCgnWedNDkRFlhWsYjroaoirAjhy+
 KhoppYps7tjst7SMR3SpKb+2kh4jVHDdbOHtPJLYlrLnMei/iKfy2pFhuioaJOTX5EQ0
 SOtBMAVP9jWpyefmY68q3q4g0eOuDKBTGC4dQm3O3XRV45TPAsUsxEEYBBkIca51zXFD
 ZEwuubH0U7qaCPEsABl/gXIksMtzu1CwdU/G4SsZft2JqN11rlLBjpRazuSf2VFQbxcp
 9dqVG7i1IuCfI1mFfvP4c47UYIHgc559gI3QVwGLi0ZpbVzsIK0NzFVu7N6/5iklDOJJ
 e53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628581; x=1739233381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVNCwynGFIOtISxx5EetqRZMocUYGnGpNyGbXMYbhl0=;
 b=AUu1cckLtO2s8X4XM/L/u5ylTLFX+2D0f+Kz2lPLTKfnfxCSwFFeXRQA3btajdd+EP
 jGbOxUFNqzI7DXn9UgN2b9NgaYpkURuPd18eADSlkXaeinkCJmeHp84XgRnxy7LHJ92R
 ZF5iUV8ZYxvO8ZlkTebsfxvCIQo54qC3qsdIuXF1hn6p5gbve5dPnECis0AlJxFx99mS
 4FCBytqD1eiJr5RsAvJerDEkM2GzBUdg1IyvNMpQmYyguPPCEOWf49CEduIDeNL+RmCb
 lF0Xv1m+UXN9SCUdP2EdAjQvlQgsyD/OY/hYaa6qdp/KgvS4jot2vwv9ULfrXcYLajpP
 w7hQ==
X-Gm-Message-State: AOJu0YxoZFllkhEeBQ/pRL4CWfFYBTbqD/ATqvFZ7LiTDKCfQ794eAZB
 Njpa03/ArIXeLb+/lT9Kca4uxFqaXx4PtG3WhnRaGhP4wO6m8kjCxhydy5GTNV5KQ91UmTDo7F7
 PrKE=
X-Gm-Gg: ASbGncvtBdGxYs6szGFwH7wHZqzu754mEZE9fdlkcRbtURcRZE+b1YprWEWXZGn/GRZ
 M6Bu5kUhgRMcdaTY5ns2P/NvAm//otgZO3QjKfg5LySMT/yqUapByvAjIWr1ISR4XBjGBuYaFcb
 v4TP8XRcI77UgfAhQqNkW1EgqZ3X7DYnH8YyFyV4Bpacq3D66xyiBa3ZirK0OpckgrfguoC2fhG
 ij7iOFL9cFqwoVllupDvfT0eTbrdW22hUKreL8X5AgB1MRHYx9wO6/vbe24KMipT4k5bBuS7XYp
 H0u+S0T/GeiPtlD2sAZT1EyY5+i+sluKgVmodytA6Hjv0gXo4eLTUNUSUp1UtG1Uqw==
X-Google-Smtp-Source: AGHT+IEgsAQgnUdrPCSLWADKulJzu3xBQ6zfJJRjAoGf4pxTEoHxz53Qq3cDLFtkt6vLH27xW1VB3Q==
X-Received: by 2002:a05:600c:1e02:b0:434:ffd7:6fd2 with SMTP id
 5b1f17b1804b1-438dc3c22d4mr217757185e9.7.1738628581014; 
 Mon, 03 Feb 2025 16:23:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244ecd6sm175398995e9.28.2025.02.03.16.22.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 03/12] hw/arm/raspi: Unify RASPI_MACHINE types
Date: Tue,  4 Feb 2025 01:22:31 +0100
Message-ID: <20250204002240.97830-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
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

Merge Raspi4bMachineState within RaspiMachineState by
using an unnamed union.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3fa382d62ce..ef94d57dab5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -38,9 +38,6 @@
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
 OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
 
-#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
-OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
-
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
@@ -49,15 +46,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
 struct RaspiMachineState {
-    /*< private >*/
     RaspiBaseMachineState parent_obj;
-    /*< public >*/
-    BCM283XState soc;
-};
 
-struct Raspi4bMachineState {
-    RaspiBaseMachineState parent_obj;
-    BCM2838State soc;
+    union {
+        BCM283XState soc;
+        BCM2838State soc4;
+    };
 };
 
 /*
@@ -380,10 +374,10 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void raspi4b_machine_init(MachineState *machine)
 {
-    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
-    BCM2838State *soc = &s->soc;
+    BCM2838State *soc = &s->soc4;
 
     s_base->binfo.modify_dtb = raspi4_modify_dtb;
     s_base->binfo.board_id = mc->board_rev;
@@ -515,8 +509,7 @@ static const TypeInfo raspi_machine_types[] = {
         .class_init     = raspi3b_machine_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi4"),
-        .parent         = TYPE_RASPI_BASE_MACHINE,
-        .instance_size  = sizeof(Raspi4bMachineState),
+        .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi4b_machine_class_init,
 #endif /* TARGET_AARCH64 */
     }, {
-- 
2.47.1


