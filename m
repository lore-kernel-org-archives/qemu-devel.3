Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C9C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRN9-00031v-Lq; Thu, 16 Jan 2025 10:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRM3-00029E-N0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:23 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRM1-00007U-F3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43635796b48so6904195e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039616; x=1737644416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZG24h4qnQZXs1NKv3BZzjC6mbrq7P8tcOKtCiGYeems=;
 b=RYrOX6XjwtXXL0ucxd8NDpRDho6RRaOuA29vWcx+Cs/ll0IXcwzEPWSRPcR+qc9UF8
 txfchvX4S+zmOXC4vJvSbPoi0pCrJ/5o/Kw8qIvg8GhgQ+sPDQUoH1VHSS3o/r3VfP2l
 DR5SoNBSXCpJ5uaqklIYDiVEaQ2OUH7sWVnytjCmbs/aYK/lpjpM+/2c5DHp830JtmGl
 FDzFWwPJckk0jdaV4fkJ4ozfzbVX+fbAwvLNoT6yrYMbWjS8r9mB7Gn9JeHcuItj+4aS
 hBH4FDQYq9cKnhqJrYXyPopBev122EU6p+EJ/EeZi4OQWp2HKd2C0elJ3Ue8O2l2B6Xp
 kK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039616; x=1737644416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZG24h4qnQZXs1NKv3BZzjC6mbrq7P8tcOKtCiGYeems=;
 b=hl98SNg0Rg7FT0gCm1F7G+T+j5/h/kAn18gOkxg+cfL6ob38L+chtfTLZXihnN1MPp
 sHyTY85lE1z5bsBK+H7PRt4vxH7/IShTsS6zlM+QeTBD8rWZds6ryEbunxLoYWjotLVj
 95B48r/jP3oxAUI7g34G7NN7cYheRpaTebaXsfmdmSe3K+W1dnp01yQv7nxGu50hlYgK
 5cscg72G9htQyMJJ38FiWurT0OzUl3iFvzoD8coVDikkpKMHBgUmeEl6aRiaYow4NCET
 ZQuT4KHZrpB5rLY6vfLUezzT65cT/P5Q+Shsz+IXDP+6n44bGVvhT6OK5f9fztYCc6aW
 M1Hw==
X-Gm-Message-State: AOJu0Yyt5MyHzD8Ej31QzFc+LUBYwXf53euLoHEAAncgH5VhKcY8zHwi
 vh3S9l4Sj1zX+4z/L3hZk4ieoiDF5j4uPo7mY0TgJVvrdwBkhN5PfIlz7Lgu1E+4V91bV2QsG50
 EfxQ=
X-Gm-Gg: ASbGncs+tVQKgCMBpDko60ttltuDMj++me3QxR1o/0BjkXTNj98IB+cL8zSS1/qpnZU
 HjBqP+OdR/mtKUuoJAHG5nqoqtdluEMYzYXwuEpBhXKV3H1PuZWx76EiedcMCsdfPY8XooMqdvX
 vUmj7ZuOgDEsMbbPaOgYqQ4833G8luoMqSJKwwxSyHXDlYWVhfUxhqTsedVdPFcM5UpoWOBKkuA
 K5wxVTruTBLhOaNMC7+kdtVbqI9T2ralkV/vJ7aRhZDX3WZmT5vALeSPL2eOGJY3QF+r+yrbeV5
 FX8NnvAWjEcfSclIyqk6lUKy5vQlEFo=
X-Google-Smtp-Source: AGHT+IFaRWf2c1Owfs99JgKkoFFwEU89Hlv5dCfduSYPddXpPB0NANh7RBLvenci20pjRHKmRisaUg==
X-Received: by 2002:a05:600c:1588:b0:436:747d:55c9 with SMTP id
 5b1f17b1804b1-437c6af20d2mr60087905e9.5.1737039615721; 
 Thu, 16 Jan 2025 07:00:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7540ae7sm61296945e9.33.2025.01.16.07.00.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 06/13] hw/arm/virt: Remove deprecated virt-2.8
 machine
Date: Thu, 16 Jan 2025 15:59:37 +0100
Message-ID: <20250116145944.38028-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 06530a5dbf8..76d83cfdd3b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3572,16 +3572,3 @@ static void virt_machine_2_9_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
 }
 DEFINE_VIRT_MACHINE(2, 9)
-
-static void virt_machine_2_8_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_9_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    /* For 2.8 and earlier we falsely claimed in the DT that
-     * our timers were edge-triggered, not level-triggered.
-     */
-    vmc->claim_edge_triggered_timers = true;
-}
-DEFINE_VIRT_MACHINE(2, 8)
-- 
2.47.1


