Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B9FD11042
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alB-0006c2-3q; Sun, 03 Nov 2024 08:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al8-0006Yp-Bb; Sun, 03 Nov 2024 08:35:14 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al6-0001VJ-BA; Sun, 03 Nov 2024 08:35:14 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso537705466b.1; 
 Sun, 03 Nov 2024 05:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640910; x=1731245710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EXWyrH8f7oP41/W4xeKAhIRvW+hPSPt58Osc1OjMy8=;
 b=cjV38T4Wor8TYsBHs1CnkdRDsq82kQrjIlRRaIRZm3M8mFVFobUUhkM1gOZ5iB+7GH
 EhSX08M8mzCiroD4k9kPQY62D3CqjIf7LXA02QKquit3iSwQ1V5cXOo6BcKQEX8f5fAp
 aa86vqKdy3Be7Ev0BaCvdFJtCh7nph25e8U441gdmKqbgeGzgOFaYG+h9daRvMMda7d6
 X7EdMzEJOc5aIWsJPp0IOX8nc5YGiqhcGT+Yo+SxjlLEBvStxmrNYEq0WdRSuwZq6lP+
 8/0woP6P7ZEGjx/twTX1nJaSREnL8yXKL4ehvON9nwl6IzpX/sTesQdKD6VRkPWy6SI8
 mKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640910; x=1731245710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EXWyrH8f7oP41/W4xeKAhIRvW+hPSPt58Osc1OjMy8=;
 b=Pmfs2Ilzsorm8wGV0Vqn0K3VAdqx8x92pcCGJuYmNfYOpQUJpKV/uXVnBrt394AjH0
 QMipGXbTz9WzMftigNgUmSBoU3F4u1SfqEuCrss33HUBnj2oQKv96KQmGoItUX+Eb2OV
 z8pOQY3oN2O701+D3ga8ll+SIeuvCebvKycRdgkn16icWTuBFlyYGLGXbcJfTaKodFyv
 loEsvrn3Nc10Z4RWzRSwBYLCITzpEQ4G9EtUqH/RWVca1Sl7Fkw/f08RuLyVWFLof8g+
 Loc+wK53gDxoNorKaFHD9T77bpfMAVu8AZaiuhHR1bRklMq/H3l3QxCB+yhnEGMKTZde
 j01w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbi5H7uP6wRSCV4Oyvu+yo+jifxHWm6chTjcImiUl/MUN8QxjkhzGEOQSxp1MKnE7PS97UGgv3piuV@nongnu.org,
 AJvYcCViJj0Zq01mZdp3eTk8joPdDakoOTANV8k//6k4pPGhWT1D09RXlrgiSfh14ibD/fA5F0xdXfIu/9M=@nongnu.org
X-Gm-Message-State: AOJu0Yy4WFbboJHueM+4NHCoO/3GD4McJQMxlxULtoJNuS5JvWG2V3hG
 /naXCVqgBm7qPRHesY2Vwmya69eyVdpLScGpB53H1lmwKo0B1PcL60b5tQ==
X-Google-Smtp-Source: AGHT+IHV/tZqpLoOKKUt58bZGrLOzCxYv81Fnu3Tg9rweTAyPHqh1/zoWbGPg5e3Ee1zp+QYJLdKcg==
X-Received: by 2002:a17:907:9729:b0:a9a:7f92:782 with SMTP id
 a640c23a62f3a-a9de61ea441mr2791292266b.52.1730640907941; 
 Sun, 03 Nov 2024 05:35:07 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 19/26] hw/intc: Guard openpic_kvm.c by dedicated
 OPENPIC_KVM Kconfig switch
Date: Sun,  3 Nov 2024 14:34:05 +0100
Message-ID: <20241103133412.73536-20-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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
index f640195e62..f12329feda 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -826,7 +826,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
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
2.47.0


