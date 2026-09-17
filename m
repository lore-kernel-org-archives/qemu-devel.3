Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33022C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jkb-0007zW-5g; Thu, 17 Sep 2026 17:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkZ-0007yb-4u; Thu, 17 Sep 2026 17:34:35 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkO-0005zA-JA; Thu, 17 Sep 2026 17:34:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 727B7435D7;
 Thu, 17 Sep 2026 21:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3B71F000FF;
 Thu, 17 Sep 2026 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789680860;
 bh=9uo/+I4cswb4xdQvbLnSxCqgYRLjAK5uSCjQBc2QM44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=emesaVW9coVHiLo/srwmMETgphlPwsS3GasziPikXoqv8mKzGzUTB3RQoKjpJZv/X
 /Ur38yqbkc0QjWEQpOf3F0jzyCbeQvXUTVOKymuF6jeSQpFk2myh/OGTFVdG2p3N0G
 8Gjvj2EL0RThnMQeNVHLv9LEapObF1fCROg6Ah6LwwRpsPJEOxT6/DoI7sH3niNURO
 OezqFVfDjKYloKf5guAIXcgAx5FOsFn6wRpX12nRKqgIQoAeqBbSM/ZkwCGRvdUE90
 j2Xub2hYoXzt2GRwjeAy7fN8lK4WK7zUApGsvDk1zUphqNhjaFSxvfL1zOIcVDYM59
 /ZiMzsy9IPsyw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Helge Deller <deller@gmx.de>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH 6/7] hw/pc87560: Wire up emulation of NS 87560 SuperIO chip
Date: Thu, 17 Sep 2026 23:33:59 +0200
Message-ID: <20260917213402.3127-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917213402.3127-1-deller@kernel.org>
References: <20260917213402.3127-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>

Put everything together and add the meson code to enable build of the IDE-,
USB- and core portions of the NS SuperIO chip.

Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/ide/meson.build | 1 +
 hw/isa/meson.build | 1 +
 hw/usb/meson.build | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index ddd7066040..be82ee8974 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
 system_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
 system_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
 system_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
+system_ss.add(when: 'CONFIG_PC87560', if_true: files('pc87560-ide.c'))
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 3219282217..1a150e7069 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -8,4 +8,5 @@ system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
+specific_ss.add(when: 'CONFIG_PC87560', if_true: files('pc87560.c'))
 specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('lpc_ich9.c'))
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index d4ba60a91c..429dcd6a24 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -45,6 +45,7 @@ system_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
 system_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
 system_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
 system_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
+system_ss.add(when: 'CONFIG_PC87560', if_true: files('pc87560-ohci.c'))
 if host_os != 'windows'
   system_ss.add(when: 'CONFIG_USB_STORAGE_MTP', if_true: files('dev-mtp.c'))
 endif
-- 
2.54.0


