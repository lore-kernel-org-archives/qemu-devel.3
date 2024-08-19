Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A3C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBGH-00009C-Ii; Mon, 19 Aug 2024 18:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBF4-0002mk-PK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBF2-0000qE-ML
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37196229343so2253352f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107967; x=1724712767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Rpj0D5ZMl/IBwW6NXczoFAZCXLiZ4uNQ1t/B/Sarn0=;
 b=uhN6TedFXli2mt+RFohEyh5171RnC2ndEU8AUp9Sh8L7WG4ROgCceYy/A5IS9Oaw9s
 2xAT5QBU6tbILcgcfsLeWeknNwTCC0Aimsiyon+GtE4nQp9IWPpNZ6lSpjZdLXgSZ2Z+
 6mNtZM9fbQZ0fLX4ORdC2o1wV6058lbLITOXIBQaLZWahb9COHwjdoU//2KQN6jCbJ2Z
 dWBzroGChHkSgbTLanzLUuhYQAgO1mQqfSOXnzJ2//CmpSwRz0WidwpobnLd1HglkixL
 WKDEUrbICbpHLL6t5FbWomYvx5e7nwYbSGf2Mv+4P/5GXEy+/mpAgcv0GA1BjT9RKzzS
 Y2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107967; x=1724712767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Rpj0D5ZMl/IBwW6NXczoFAZCXLiZ4uNQ1t/B/Sarn0=;
 b=vwmI/Z9m8x1cFppGwgvi0izTNJbgTEmTD5y9Zi9pGwfFEd8YatALGsRm3I3FdXyrk9
 nCVfUdShT5Sjs7ob7D1wbr3fHm6m99vUIeHmaFzE8D2+kaxGkY6ANXxPuE2ij+2l2wjT
 MBl9rlBkm69uGygunkAbOXbx4F0FL5Dljqb/jEYUy+ATHYGcBiAyB0CHrTJFJpN0FwJ/
 AjysBgocZVP1OCFXzeRovKSUVKAl7zBny6onrLpLrjukPItEwQvzWyIaEBZ84Mx3f7Jn
 bNqEtfWSyh+rXvc5nUb/kbo9N1NZoIh+ydQ78KnMes27EYq8/rGNv9u2VtPLLXMqhaIB
 8CkQ==
X-Gm-Message-State: AOJu0YwIVkSkHQzOBCZGGLxh1PTIEXVO8WbdYWzhoawqPNweGRoouHP6
 CN/rMUp5d23KxC5dNPdajWwqQkrjrDCV8Hs/bs7YgggYEzCDuVWFFGoIsuAPou48LnpY94zmDOE
 nQxU=
X-Google-Smtp-Source: AGHT+IELigD0cS7VR5ltft6sqKDFpDlXbKn8GNqQVP3OgcfVSDZPkpns+vxxwwSrXm6C12yjX28iTw==
X-Received: by 2002:adf:ec04:0:b0:371:7e73:eb43 with SMTP id
 ffacd0b85a97d-37194694f88mr8068307f8f.42.1724107966740; 
 Mon, 19 Aug 2024 15:52:46 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded2931asm173290985e9.17.2024.08.19.15.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Kamil=20Szcz=C4=99k?= <kamil@szczek.dev>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/20] hw/i386/pc: Ensure vmport prerequisites are fulfilled
Date: Tue, 20 Aug 2024 00:51:15 +0200
Message-ID: <20240819225116.17928-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
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

From: Kamil Szczęk <kamil@szczek.dev>

Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
to disable PS/2 mouse/keyboard'), the vmport will not be created unless
the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
vmport was explicitly requested, but the i8042 controller is disabled.
This also changes the behavior of vmport=auto to take i8042 controller
availability into account.

Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <0MS3y5E-hHqODIhiuFxmCnIrXd612JIGq31UuMsz4KGCKZ_wWuF-PHGKTRSGS0nWaPEddOdF4YOczHdgorulECPo792OhWov7O9BBF6UMX4=@szczek.dev>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c    | 11 ++++++++---
 qemu-options.hx |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 72229a24ff..7779c88a91 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops = {
 };
 
 static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
-                            bool create_i8042, bool no_vmport)
+                            bool create_i8042, bool no_vmport, Error **errp)
 {
     int i;
     DriveInfo *fd[MAX_FD];
@@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     }
 
     if (!create_i8042) {
+        if (!no_vmport) {
+            error_setg(errp,
+                       "vmport requires the i8042 controller to be enabled");
+        }
         return;
     }
 
@@ -1219,12 +1223,13 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
     assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+        pcms->vmport = (xen_enabled() || !pcms->i8042_enabled)
+            ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
     }
 
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
-                    pcms->vmport != ON_OFF_AUTO_ON);
+                    pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/qemu-options.hx b/qemu-options.hx
index d99084a5ee..d94e2cbbae 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -68,8 +68,8 @@ SRST
 
     ``vmport=on|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
-        to select the value based on accel. For accel=xen the default is
-        off otherwise the default is on.
+        to select the value based on accel and i8042. For accel=xen or
+        i8042=off the default is off otherwise the default is on.
 
     ``dump-guest-core=on|off``
         Include guest memory in a core dump. The default is on.
-- 
2.45.2


