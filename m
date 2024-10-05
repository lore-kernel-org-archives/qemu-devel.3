Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D1ECFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkX-0005d0-PO; Sat, 05 Oct 2024 15:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkM-0005QC-0m; Sat, 05 Oct 2024 15:47:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkK-0007iV-HA; Sat, 05 Oct 2024 15:47:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso27841155e9.2; 
 Sat, 05 Oct 2024 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157637; x=1728762437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4BSHyKm9Xr2ijuyVGhrvTe55yx+XDCqJUFhxaQuRKY=;
 b=lIM8LTln5vsOQJN0sss0inhkPKbboHCmuZvt8GdBcvR9KeVhvTsksbPnELIFY/G7D7
 3HEKzXx/cF4iCAPxZzYlxgpd4QNRQaJjvkqSQGx32gBj5awDkfNe9k5uzE03M/rqqU9x
 lbfjr3mAfRyMH0g8i9rEJ1MNV1hvN+XtoQUNF+LULUv73ZkqZPC9F3IOO4znUUDYDhEq
 fudISN4ZujpQGwr/Agpw9ywx2hopJs9XnsKjxoH+8z3OvH8WPX0J9iXcWdJisfGNPTvN
 TT/N4Ge/0ZxbAkbPw7h/WrGDUWCmkijZ4aJXjI9CVmbwZ5IYtIrP3oKPW3Zmi26WkWT2
 9dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157637; x=1728762437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4BSHyKm9Xr2ijuyVGhrvTe55yx+XDCqJUFhxaQuRKY=;
 b=eaJQ+LLJT3DlorfI832BLHj2+lnq3qHlXug0/SnwexXnFQcpznxt3EMhiYSf1JStm5
 9HWRoH6/nyhBPqIRjQuz7QRV2EC/sVkZ/nqaWK4wCnHTYikd+hsVguo04TMNqaA2r2/N
 3Ly0nX+pROnITxy+rUy7G1P4mG9dXXn9cZsPn0GfQHClqAblLSwKP2FfC6H1UZfNi2hy
 OrYgnqxKzDGjG+/uSVtHO/uLlDOIBYIN7D899ogxvHIY1d55ytrNArktJA00phlHyMXK
 N9HxtNN9Oan4Uz8i2WKgX+fZJ8NfqP/CiE7w6JvfRoLmz/hqgs9uUlWn04lP3TDZK2zt
 g5QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYog8svZ2aPLaT6Ma8HazZVD/c/+PBh1Pw4bB03kBfXbJzqLv/5UhFZ7Of2F9HtF3WdIpmJGbP7Hm6@nongnu.org,
 AJvYcCXu4HWoiE8PNYgfgdE2ygmGpQkqqkAjZJJTVBZ7SRmzFMhcFRqCEo9Eh3CfRbTE1LSVwhnnAJdsAeY=@nongnu.org
X-Gm-Message-State: AOJu0YzAsBidOALgz9bhVnVaFycdS9ewRlvJrG15yC6FsgxNoLhsiJ7F
 WX1p/xPrdcaz3lrQIzo3H85Jr/bhuTDEB+yQZWN5Y1vM9hZcQ9TcYVLr7Q==
X-Google-Smtp-Source: AGHT+IF1mjHSp8+0m2jIfj3eYndG0IwLwGp3jZHLGJqgg5zGZaAk0mo+5Do+aBeHRP7BEEuskubToA==
X-Received: by 2002:a05:600c:190b:b0:42c:be90:fa2f with SMTP id
 5b1f17b1804b1-42f85af4582mr49749195e9.25.1728157636972; 
 Sat, 05 Oct 2024 12:47:16 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 17/23] hw/intc: Guard openpic_kvm.c by dedicated
 OPENPIC_KVM Kconfig switch
Date: Sat,  5 Oct 2024 21:45:57 +0200
Message-ID: <20241005194603.23139-18-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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

Allows to clearly mark code sections relying on this device type.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c       | 2 +-
 hw/intc/Kconfig     | 4 ++++
 hw/intc/meson.build | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 74836ebb64..566c3b6f8e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -828,7 +828,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
                                           Error **errp)
 {
-#ifdef CONFIG_KVM
+#ifdef CONFIG_OPENPIC_KVM
     DeviceState *dev;
     CPUState *cs;
 
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d..a3df98ae59 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -16,6 +16,10 @@ config OPENPIC
     bool
     select MSI_NONBROKEN
 
+config OPENPIC_KVM
+    bool
+    depends on OPENPIC && KVM
+
 config APIC
     bool
     select MSI_NONBROKEN
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 6bfdc4eb33..b9de6bf5c6 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -48,8 +48,7 @@ specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
 specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
-specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_OPENPIC'],
-		if_true: files('openpic_kvm.c'))
+specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
 specific_ss.add(when: 'CONFIG_POWERNV', if_true: files('xics_pnv.c', 'pnv_xive.c', 'pnv_xive2.c'))
 specific_ss.add(when: 'CONFIG_PPC_UIC', if_true: files('ppc-uic.c'))
 specific_ss.add(when: 'CONFIG_RX_ICU', if_true: files('rx_icu.c'))
-- 
2.46.2


