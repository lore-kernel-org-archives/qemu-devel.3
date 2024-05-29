Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBfQ-0000Jx-7E; Wed, 29 May 2024 01:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfO-0000JZ-5x
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:02 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfM-0005PO-Be
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:01 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e73359b900so16834411fa.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959758; x=1717564558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/B5UTN+VVzZIBHg8vuvzaIXLhoLwQMP7eYF+iW6nSk=;
 b=ZQFBUyet99nnl0AvXzE5U+kX+n+Z7IJDe05vXl2fnXRKI1lGdEfH/UJ5ftTMl0+a0i
 /S53VnzOZLs7xS0cSZdVSaq9pWVw7bseaapn49C/dXVrRv9PZGV7YyWUtbRl149J0pKo
 FzUur04Wg0pL/HVWebQyVglHtYPkh6tlBWS2TPhc4v97fMhy47dfbQmMvBh/wn0XTc+o
 YrPbtPJbt4DCEqRV5DBDz96dRSF0EmIt46VQugplN2WRgasXRQHIOTuS/HjtcgkrYTcE
 s2Grd66fp7VgXjREMfXQv6Ng9uQdITLIqzsNiADAJ+FYFIkpwKeRpcQENqVauPc+Fs6h
 CGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959758; x=1717564558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/B5UTN+VVzZIBHg8vuvzaIXLhoLwQMP7eYF+iW6nSk=;
 b=fdBMFzu4hqBIvfMZCYEL9zT9nqTt+LjkCFlEJCRuY7dLzKbVsnggHbq0N3hbeGrfPL
 NAvja1xe0caB7xC18bi+5VubVZ45+ARF4DpKN5IdV9AgMeoqmDMk/fgyugnCC7xHdGqG
 7XN3wC/LXVTaEFgxyNgUxw5f+Z4nr3mzRyJsaFK42Qep+MI4VvdpU2d74k9C1FUyVWgm
 zj1mI3SMSHwWMo92dLiKkj6EaGBrpvDD63G5+0xWiIc2U2HaovjDlW6XAecId4vJ5c1c
 ELZsYJUbiDn8Yc8B4YKMD1CZq5HqWAq5PB8QmnTVx0YEnAeUoVPXHvuQDOtF3tmkwWDJ
 gJPQ==
X-Gm-Message-State: AOJu0YyFtYwleaae7Ine2oQc1UXVPo4KJELV1A+183qCADgGGn1mIzsp
 lRZG6/cL2s1gitimzdys8O/N72LrRczyMJ4lJXBdyNSJt4l6zg5lfL2xjDpPvfuHE3tA6j2rHED
 x
X-Google-Smtp-Source: AGHT+IEOhvz1MTE9Y/IMmU6g91ZbFFla2DYPtgXs+FkuMaVVZ7Hn9IKPA/QYBwHY3Zt36SDHDKH8RQ==
X-Received: by 2002:a2e:8793:0:b0:2ea:7d47:82a3 with SMTP id
 38308e7fff4ca-2ea7d47846emr2118261fa.37.1716959758147; 
 Tue, 28 May 2024 22:15:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c9363sm13705594f8f.72.2024.05.28.22.15.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:15:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 03/23] hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP
 flag
Date: Wed, 29 May 2024 07:15:19 +0200
Message-ID: <20240529051539.71210-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

XHCI_FLAG_FORCE_PCIE_ENDCAP was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it
and simplify usb_xhci_pci_realize().

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/usb/hcd-xhci.h     | 1 -
 hw/usb/hcd-xhci-nec.c | 2 --
 hw/usb/hcd-xhci-pci.c | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 98f598382a..1efa4858fb 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -37,7 +37,6 @@ typedef struct XHCIEPContext XHCIEPContext;
 
 enum xhci_flags {
     XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_FORCE_PCIE_ENDCAP,
     XHCI_FLAG_ENABLE_STREAMS,
 };
 
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 328e5bfe7c..5d5b069cf9 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -43,8 +43,6 @@ static Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
                     XHCI_FLAG_SS_FIRST, true),
-    DEFINE_PROP_BIT("force-pcie-endcap", XHCINecState, flags,
-                    XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 4423983308..cbad96f393 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -148,8 +148,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &s->xhci.mem);
 
-    if (pci_bus_is_express(pci_get_bus(dev)) ||
-        xhci_get_flag(&s->xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
+    if (pci_bus_is_express(pci_get_bus(dev))) {
         ret = pcie_endpoint_cap_init(dev, 0xa0);
         assert(ret > 0);
     }
-- 
2.41.0


