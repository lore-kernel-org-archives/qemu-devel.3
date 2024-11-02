Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5425CE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E13-0003Iu-Ox; Sat, 02 Nov 2024 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0v-0003Bu-12; Sat, 02 Nov 2024 09:18:01 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0r-00021G-Jq; Sat, 02 Nov 2024 09:18:00 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so335543366b.1; 
 Sat, 02 Nov 2024 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553475; x=1731158275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EXWyrH8f7oP41/W4xeKAhIRvW+hPSPt58Osc1OjMy8=;
 b=GIADIxgRD3TAXKh8jHxDhfmxxZWmVPKqIj0rkXF84eB0GYeAFPLe4/vuGTymgyccRE
 OM3pJdHeGMhk7Spxq87xLtN2padKkoFVd38dkoU1ImplfMmCisGYUUmdx31uqP3nSVTi
 qUpbhXFDgOxSEucvOR4190ESJ/J+R8XhnzAaIGVPQck81cCDAJpkpJ4c31LItzjT3Sn9
 RjWt6/tAA9xB3NHJHVEB1jOVaUjD+lLNM3iebYJ296X73AS3YmTMHmshc2Zxlri+SGL3
 72cWXN66wqxlAnsu2uMKaErpfr2YX1akSQY+wMglFjhoQGkpl6QsOi33TlYtU0maSVzI
 fjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553475; x=1731158275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EXWyrH8f7oP41/W4xeKAhIRvW+hPSPt58Osc1OjMy8=;
 b=YIMom4rEx0Ll2LWcNcO3RCJxjr6+RGTZqP15slMCJ4hdYRMFQkJM1I0jiWJfrjVulZ
 77oRg8tHn290miF4Cwrza3X7jHQ/Zb9mUk5COrwRLM+5abTtnuanHsb6LbSMU5L3CGrE
 6kDE897zyeKc6HRs2Vwl/mbTl+8lOSenodnJBbVcIh9OvObkywMeIieCBH5IFYRmmDOo
 ZYHgbw9aNspTCt7SAlyDJHl1K7Mo2jd3pry82xAxZ7PfDl3pj+g3fRuYAi3DnNu4jy7A
 44/1xIGz7JRp8qjfF7kIozsYAK+Omw3aEdRmOT/8gyPVQ87871JAMdcGgnOUlTpzJgky
 fWZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHEVmrQ9hSQorCGKTztriOkgnPy1Cl1nq8C3CTuSVrQMgaWEkMU+7noFHlbSRcOReOo0ImFk8iYB8X@nongnu.org,
 AJvYcCX2XIv5C2lKVZKOMKLWjCIFfboUFARjBOzeefV5Hy+KbznjHzaNLqu+5FXfVP/AkFkRwPqeH5qctnA=@nongnu.org
X-Gm-Message-State: AOJu0Yy+p0FmtGjXmR7nb3MfseFuEGywYRCBtWHLc7XyQ3UfMHtujSyr
 9mwqzk3CWOEJn1+V0aH8dO1ZiQOx7sU32WksSeeLf6MqdRQRLTxI5GmFbQ==
X-Google-Smtp-Source: AGHT+IGvCirtSErn9CReobBS4ri5Ijp0aVXZl4rPi6i4m6alC70/1VgOsRcJ82+K/f7vtRkQAEXLAQ==
X-Received: by 2002:a17:907:3f19:b0:a9a:835:b4eb with SMTP id
 a640c23a62f3a-a9e50973610mr964153266b.38.1730553474734; 
 Sat, 02 Nov 2024 06:17:54 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 19/26] hw/intc: Guard openpic_kvm.c by dedicated
 OPENPIC_KVM Kconfig switch
Date: Sat,  2 Nov 2024 14:17:08 +0100
Message-ID: <20241102131715.548849-20-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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


