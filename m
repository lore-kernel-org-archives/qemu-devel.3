Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21203CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPs-0003Wk-3n; Mon, 23 Sep 2024 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPp-0003Pw-Vt; Mon, 23 Sep 2024 05:31:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPo-00071H-8Z; Mon, 23 Sep 2024 05:31:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so940227366b.1; 
 Mon, 23 Sep 2024 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083888; x=1727688688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6N1zWPO8DnSJg1Q/8i6UHf3EekeeyOAcUgqB8xGeAc=;
 b=icgvvAMd72sAmyGs1SlwBR/nBdkThAGhBpapsgSnMvepseDYIu1Eb932rCOr/5eOGv
 9b+hW68Gj9c0pqYx6O1K/lyZCcs+U8qvLKrzlRBLIyUJ9yWhj/ernKEiVd2icguS1Tmv
 eIvnzHYaG7ALQaz69s4eMddykYxrwmFOLD0ontFhlQi1y/5HEF8TEYNbpd04rfcQut3c
 y8GE2UkUyF0qiytjq4iY36hvMCDauTNjq+nGJOb4rbC3uKhJBo6Mz/q2byYrunRDkhvM
 lTxyXKi2WPsL3rHYPOzvnb5PUxqSrmSFl3EpsCWcrK0IeunYBQbh6qTnZybiivbmH9Ak
 60mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083888; x=1727688688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6N1zWPO8DnSJg1Q/8i6UHf3EekeeyOAcUgqB8xGeAc=;
 b=MXAy+Nap37XHhzM/RqyCMx2Lk4I4mCUQlvVyLVWZsWLZncTd0zcNcRsZgG3QE05CIa
 MT6M3hA4ygv7JZRIg7urMEkTr8dSUI8aJZ09/CGNQtsBv+kxaItuEpvL8h6GI9WaykVO
 nWENVY4JhEX0BZ5OI3Vtv5mqJvwdVkR5tJXbpmID4PMXvwan8GaQDrdNwILL1vYZ8SR0
 CuWM1XkFn1GXFE9ZFoHgwUrQKR8NK7xGn+PmRzuXQI/DMdKGy8HROOqoq8om2lc0HtrS
 cuc9mK0LKXj3+MW72X1TjiqK7HwT9KrbrbEck1XFNHU2zSr7JXhsa6USzTe8rlttAn9h
 RxOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG59p9Yg6uiJoPVDEeRWItRVi2VwvmDyvAPmJlA6EAhLzrM+ZXE23TOA9UknFgZHDs5KXN0v53LhM=@nongnu.org,
 AJvYcCWbzpKrJgO8OVOApfJ9Qqil908HwwrClUiwEfs8wf3Q4e0BR1c63Ph5XnBiR7xd6VTrdUKbVOOnDYcE@nongnu.org
X-Gm-Message-State: AOJu0YwFC8y3YHBP3R7qUtS0fNsa3HDUxhVsmxx2zfJujknW6A48FrkU
 x0sHVxLQEB5eci/D/osYcmwIUvWvwNmsgVF+/TU/Zz8v2t3HhyVmctq9gw==
X-Google-Smtp-Source: AGHT+IEzfruuAabaD+oBvcCRqz8chteMFhJRScR73hbZjHbHlB2rxyLnv/Ws0MbJsapmh7VM5amC6Q==
X-Received: by 2002:a17:907:2da5:b0:a8d:6dab:b8ee with SMTP id
 a640c23a62f3a-a90d362ce84mr1207410366b.23.1727083888464; 
 Mon, 23 Sep 2024 02:31:28 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 17/23] hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM
 Kconfig switch
Date: Mon, 23 Sep 2024 11:30:10 +0200
Message-ID: <20240923093016.66437-18-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c       | 2 +-
 hw/intc/Kconfig     | 4 ++++
 hw/intc/meson.build | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 4ee4304a8a..149e608324 100644
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
2.46.1


