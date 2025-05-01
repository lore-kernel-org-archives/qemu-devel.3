Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86C9C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb70-0002AF-UU; Thu, 01 May 2025 17:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6t-0001ks-CI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:24 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6r-0006fx-Na
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:23 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d5e2606a1bso12501555ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133580; x=1746738380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isJ+xEvRBKFtxiyi/HDhWV18nqZ0er3zYVHJmZNBiUM=;
 b=gmOWgzwv7LdjGmEZxoL+p8bJnqDW02Elt+H8FCyHtVIQIPWLkcrmJO8+7NlkCVz68d
 lQd9AnaA6e+WWL1tccFMM7hyq34Gf2fRZRB3mCzu0tNYcSC13mA7tMaV9X+nXPfJl7GH
 2B9TRkL3tsuoXgyZGqstcUaBDsZaOdeMCIaIuGRNeAWYXxFNgAqByvlh0vhkvK0liRIY
 dpqaZmZo+/wq+tTMH8i+tLvH0gEimCHMUyVyqyvOy5GLIlKusIT1Bi/CTsKX+Ax7sZnA
 yu/cEv+yEDsS+DzCBn1RK5Nl6ndWDkH8RpwftZa4/Y9FM+Q1RsjxzJSIsQbdQok2HJ5M
 zVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133580; x=1746738380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isJ+xEvRBKFtxiyi/HDhWV18nqZ0er3zYVHJmZNBiUM=;
 b=D0ASi1CpCrGq1oH9UlY4NsTh0W6Wf4KA9pSctxw4bWGgW0C6SZ9AEbDv+tjcAgJoiG
 ybyTDVVixCGm3sQJlcCc49ZjTgR9M4hnnYAYPBqrc7UcIazUcEhsce/bg0PaDvl4MpQL
 T9unlK7n3/4DJzPLr57wU1BRU5AVSvVTDypm6pQYEp6ttyb4LGLbsK+i47HJ+L8Vdpoe
 AhqghSdInLzVMmUXzznlVUxvJGk5EzqjB44xQHwv0FXJuASrJ7wMXmlOYZ9k7ifh35ZT
 hn2a5pvkAmIHUHn8Drl95KQkuKtzSINun2gfOVlcdV22wQYM7aSkfGrWNOUch8aLm5Ct
 c04Q==
X-Gm-Message-State: AOJu0YxhB3lxZ5mYdp5L7jeZOSn5IAsntYXYOZuxHlEy7MZ6LLBYGjO1
 ttprStTUPjbZEA2aurhqqhaEXmrp6QTdfR/yLZyWgP5AaGvDP7k5gggIACa6ECv1I7JRbO13EDH
 m
X-Gm-Gg: ASbGnctJvmtjIuoCTnbK7lDDLR8lBC1j0v0XvdPt99qCJpU4tAxTkI7Z/DhiD3Oa56W
 ttatmOxX5/8QEEoGvPwTqX289Qss+LOitPumrsF5nzbgG+B+Hecc8qNnRkOs8dO/+a26+sI827I
 tr4LO+4T0Toqv9/KOQdC3yFcsLBMtDthH5H4UDqR6MyRJcF3X343WXDYvxJX75tc4VC9aZ+CBZn
 g9FOVd1pyIJocH6dC+TkoNnshL5Nr6cEApZ4zqadl/kTjgTzrn4mrvSqDOo/AeGTdIHd30rVFaj
 gFILRyUKlN8gaAcG7xsbXbBJKhuGkVwSjhrE/8fUAZUPbbYZ+tRrKqh/DeNJrsweAqrDMtC9rmc
 MP1JDrgr4gLO500w=
X-Google-Smtp-Source: AGHT+IGINLrAHGwr43KW6ALjOdfV8joWbulUaker/Sm7tkf9exPUTefUtiE1begb9XhBvJBAZMBL6A==
X-Received: by 2002:a05:6e02:3a01:b0:3d4:3db1:77ae with SMTP id
 e9e14a558f8ab-3d97c239085mr5769385ab.18.1746133580005; 
 Thu, 01 May 2025 14:06:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac7f88sm44327173.133.2025.05.01.14.06.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:19 -0700 (PDT)
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
Subject: [PATCH 09/18] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_INIT_LNKCTL definition
Date: Thu,  1 May 2025 23:04:47 +0200
Message-ID: <20250501210456.89071-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-il1-x133.google.com
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

VIRTIO_PCI_FLAG_INIT_LNKCTL was only used by the hw_compat_2_8[]
array, via the 'x-pcie-lnkctl-init=off' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_INIT_LNKCTL (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ed142932f7b..a8dd613ffbc 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -34,7 +34,6 @@ enum {
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
-    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
     VIRTIO_PCI_FLAG_INIT_PM_BIT,
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
@@ -61,9 +60,6 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
-/* Init Link Control register */
-#define VIRTIO_PCI_FLAG_INIT_LNKCTL (1 << VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT)
-
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0075ae590db..5b86a9a447c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2218,10 +2218,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         /* Init error enabling flags */
         pcie_cap_deverr_init(pci_dev);
 
-        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_LNKCTL) {
-            /* Init Link Control Register */
-            pcie_cap_lnkctl_init(pci_dev);
-        }
+        /* Init Link Control Register */
+        pcie_cap_lnkctl_init(pci_dev);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
             pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
@@ -2347,8 +2345,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT, true),
-    DEFINE_PROP_BIT("x-pcie-lnkctl-init", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
-- 
2.47.1


