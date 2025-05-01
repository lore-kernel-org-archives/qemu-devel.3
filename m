Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59465C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb71-0002AZ-0c; Thu, 01 May 2025 17:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6d-0001RD-9o
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:15 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6a-0006cT-Jd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:06 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d5e68418b5so13085815ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133563; x=1746738363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UZQft0G0qLlkzlmAjD0AN5/aAoxDFjk+IIAiFxxuxk=;
 b=Wtk+b9wBVk38HPrXI90RbZSR5BhexoRwnSnhSGq44BatVkjicuCPiPb6knSrjfntTV
 VNil/y9ftsbM7WUY+oA5EXJDJxIKbetjmTbByOi5Fcymg1L1tLwoDuCMAueKXtUH4e4E
 cMAoQ3lyUScB40aqET6H2eUSIanzv5JY/aAYRivhYHyY5FoCyco9yY2UQYXGi3u5oIEo
 Vpy9XDju38ibod/5Kx5YKh8KSPNn5O0xwSB9SOz37TqGQIaBRs4ut4DvScniSo9TQJet
 7CsAxdj9riASCLUcGBuvyjZ2vSyqEM7NtSbN1cRNfCQwa8y/05uiR8QGnYbTr0YuCK9k
 c/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133563; x=1746738363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UZQft0G0qLlkzlmAjD0AN5/aAoxDFjk+IIAiFxxuxk=;
 b=GR1zcYKFhhZPQJWaadJuRwnbTxC61GH9qCRvrlEkIdjGw9TInk8XbmkFI8Zp+ZVE3c
 bITMh3MQ4EcwFndxmN28Tn8IuHUxW9xgQH8gWGk6OHPR/oLtcfuCKCqGaE8zAuuelb+Y
 ENtn3t4G/IkEPxEjlMYG32v9MaSJzpwC8jI1IM1yqbkgludYdXUFegTBZ+Nle38qHgbQ
 cuXAnBwRDFEfbaRg0wm4vuHJVUSaB5zqkC5riXj9E3yUcZ0KXElqjN/ihJIpztam7lZp
 dbKuiPuN53QWlw3TqQUiEJIh4p878wOTC6ZDInvl5qF5HHMGH7vsqiZCLkoeqUh34Z3z
 smCw==
X-Gm-Message-State: AOJu0YzIqjvXEVJGl8aj/s0y0tSrRwcNB/KyeE5p29aWVrAxepJv2DpI
 056Mzdt1YS2ObFxqRZgGayqdQ2CNRUGSZMHQadshlg1j/yquTchfwp9D3oK+pSgJOfYJ0RK4uSB
 r
X-Gm-Gg: ASbGncuwW4C0+1n5aYVkXIVchcy+dStq9Pef2nYv2C0GtRJDJxeVSOYiczCzygvSOLO
 3xtZtD8LrA1EgYvWSEMOfgn2B3rT/RMZJnMgtqOazwt8dbSLSEhOxbCPb4v4Rsqs6+h8z9x7jel
 +NDN+rSD6A+qtnk2TvojsWcR2oflzSXq3yOUu43/+gTiLjxUnfmbxbBLmJPZwKJHonUlVFKkSwh
 ebtsRY28JdJOykBHBSEyssR7v+ii3t2JeCYRND+3n8OcnxYR4C97IhpgxEDsNCgoo7iwlgQIy+o
 IPYlBLEPLZd3bX2YJK2bIn2pW8RKw7M/e+FmdWHVgfLMTWaNlHSmx4Zl29MI6Jb/8B7p37aAvvO
 6l9clV+XFK5Ro22E=
X-Google-Smtp-Source: AGHT+IHTizOnKtd//rQZ5MNZ+h2FfRR5XgBuLQ9/ebXP/1Ak9kwfMQFLAcVGBVMrwMUIxStFBA2bIA==
X-Received: by 2002:a05:6e02:1a85:b0:3d3:d074:b0d2 with SMTP id
 e9e14a558f8ab-3d97c1771a7mr5740545ab.2.1746133562899; 
 Thu, 01 May 2025 14:06:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f6d755sm3065295ab.69.2025.05.01.14.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 07/18] hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
Date: Thu,  1 May 2025 23:04:45 +0200
Message-ID: <20250501210456.89071-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12c.google.com
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

QEMU_PCIE_EXTCAP_INIT was only used by the hw_compat_2_8[]
array, via the 'x-pcie-extcap-init=off' property. We removed
all machines using that array, lets remove all the code around
QEMU_PCIE_EXTCAP_INIT.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h | 2 --
 hw/pci/pci.c         | 2 --
 hw/pci/pcie.c        | 5 -----
 3 files changed, 9 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c2fe6caa2c6..6c72a61c4b6 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -210,8 +210,6 @@ enum {
     /* Link active status in endpoint capability is always set */
 #define QEMU_PCIE_LNKSTA_DLLLA_BITNR 8
     QEMU_PCIE_LNKSTA_DLLLA = (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
-#define QEMU_PCIE_EXTCAP_INIT_BITNR 9
-    QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 #define QEMU_PCIE_CXL_BITNR 10
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
 #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe38c4c0287..36206c77b7c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -90,8 +90,6 @@ static const Property pci_props[] = {
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
-    DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
-                    QEMU_PCIE_EXTCAP_INIT_BITNR, true),
     DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                        failover_pair_id),
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa29..a3969423bd3 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -245,11 +245,6 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
 
     pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
 
-    if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {
-        /* read-only to behave like a 'NULL' Extended Capability Header */
-        pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
-    }
-
     return pos;
 }
 
-- 
2.47.1


