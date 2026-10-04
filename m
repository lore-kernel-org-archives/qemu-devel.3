Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F2CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLK2-0006eM-HM; Sun, 04 Oct 2026 08:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLK0-0006dL-Af
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJy-0007Br-CT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a003bd18e5so5344555e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116881; x=1791721681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y+NG5lh/ZEI7RJkZJ1VFVc+j0jqGg2BufqgyXfescg8=;
 b=P3+8bQ/6uTaum266LzcCu3PN5bhApVSfd3X5P5/+CPziMt+w1BYz4mfrOA0xVNyRgs
 q+gLJjqhqtUxkXxbranfMJ0Ak3WR6esnFsPnAQjA6+TjbJ0HDr/YdN1KUg0kL2YhMfP1
 t48X3wkJweIC5/+GRjIvOlxfq9pR6LGs1GAvWVq8RIvTUu9YmoocYHWir/u5HXzPG2sZ
 X2+f/m8Jjfba3bJXoPay7X0g4sjC+lv4Kanp3ziRMgOzD/7D0qOfUBEP32h8tUjhQmi5
 +Xn0hzWirAlgt/wA5CNB4apQtJRg7B7RE636YdkisvKsMD8rMaC2eLhdKdBPfvxS0Dft
 yi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116881; x=1791721681;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+NG5lh/ZEI7RJkZJ1VFVc+j0jqGg2BufqgyXfescg8=;
 b=hTIMUs+iw9Si7rw2qRfsMwpsLG8DQXWk/bPJCNZVLuxa6irqhXrKNizjF37qXlWCKe
 LzF3e3Vv1NkehuWoXiHDMxRhsGuPLubDB8gKkAOGQTySNjzZWTGhA+Ac8Y617X+BBvti
 95YaunpbZNkkujYPInLyWiZHU9la+EKf0/5Zq4O5hZtMz6rL3+6wFuRUxajv5s7Dlzsk
 ySKQRhUWs9mFeXaHDk6wv2D0oomCN/+9Cg6td/iRaIaDJKnvYbKq75S+VxOmtQq3suZC
 przAqjwlyRLoGat9/+iDu9Tq/2ZshhFmLMiVRMtvPdbwVZhUgAtgW+WWlucpdhS0NYvp
 JnUQ==
X-Gm-Message-State: AFuF++nUhPYxPhR89K2GhVrAJ99TeFpLtK/NoysxJZxkpWjKTa8b18yq
 osoUtqRolwzOGLdgj6Zt+9Zka+0i7Tm9nX4cIP0BVEeNs3f8vY6WOW8W3gJuMQ==
X-Gm-Gg: AYBFou2czW03VDuO1k48CpG45jTiTDLY+o4+2zKSZs9EBgb6Ou0Lrr0hk8gKXy+fbjk
 NO+9pkn5pHfU/bJ9MtjvthylOdwy1n4w9U2OpTdLXUJXQGH0Xn1WJb86S60SURyXeoVT5OoXNOd
 lV2ynbBwyYCEJ+Vg6c6pdwSzw7XZi3YmmCUz32AM1OyFhLRvpfj50148dwaujSs4IqmDDnKqg5E
 jzQHWf6KMUweKk/9OVOpp2mDbEYnJWGqsW1BWl322FOeoe9fUDxQxAOcegC1bLkFsvsEq373PZW
 SfKprtGfIfx9rE5dGHI+o5hmGIkCSGXGkn1+3su8FIngQeab2ugaStdFXsivCIjmsp3feMipc7D
 2cHbe6ArKA5E9u5EuE51/M+56y7TyavnfG4IsEmWewyqsq3sUNFLEG6ftDkqX3r2SGXn1rXz8aS
 CKcDXESPPcbUIbGaqOrHulkuFZXOBtxJtxGutbyEoMEEOmfe+RmsdsPjVBx7CNbSiAFaKiE7DW4
 Omor5eyaCR8h1av0xFDob170qdBus1/4MdQHg==
X-Received: by 2002:a05:600c:3501:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a0276b78f7mr134566535e9.34.1791116880908; 
 Sun, 04 Oct 2026 05:28:00 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 18/30] Kconfig: Extract config IMX_GPCV2 from config IMX
Date: Sun,  4 Oct 2026 14:26:34 +0200
Message-ID: <20261004122647.3913-19-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_GPCV2 to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 030b218eb6..a33f5a46f9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,6 +581,7 @@ config FSL_IMX7
     select PCI
     select IMX
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -661,6 +662,7 @@ config FSL_IMX6UL
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97355f9df7..98dba7efb8 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -8,6 +8,9 @@ config I8259
 config IMX_AVIC
     bool
 
+config IMX_GPCV2
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 74d84b8ddc..2ac575095f 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -24,7 +24,7 @@ system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
 system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_GPCV2', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.56.0


