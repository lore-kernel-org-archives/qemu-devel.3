Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF4C05023
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3L-0001PT-JO; Tue, 16 Apr 2024 15:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2K-0000sH-Tq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:09 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2H-0005Ng-Lf
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:08 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso607564966b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294003; x=1713898803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/B5UTN+VVzZIBHg8vuvzaIXLhoLwQMP7eYF+iW6nSk=;
 b=Jze8/bBAz2nKIkvy50C8jGwBrYzQ9Wd2QPeZdCZutEzvLy8JT2N3p1FbjqsvJR7PIr
 wzVqS70L2dvbBOMi1ZvzcO0wMObfh5t/f1QPZZkVxL/gadbEfwyK7ljoNmWinOrRc99n
 2KIRfe9tT0FTDL2dqfXS8iApq/0m+IOziWW1FKgqgdUw7tGgDoMWT5YJE4pBTKIWZRbn
 wTv1G88mR89e7rwwiL+lKM1KCSW6TnMXV/KC48L+ILX+z93nU3uAMFUpTQWA4smlYvq8
 1WeEJrAWduwZIJQEhNH6Td1IinBDpHS7Tol+JHeYLMwNnwBOG+wBqm0tnuHP63vkiJ3e
 SZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294003; x=1713898803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/B5UTN+VVzZIBHg8vuvzaIXLhoLwQMP7eYF+iW6nSk=;
 b=YPou23S67jGhIIzAnjcPxXU8hYekJ6uqBqajtNke7Zb2AtNqwKQ3pAUF8tyQLJMHBG
 9oFr4R7E0zl8m1umlELNuRtOf1actcFoJjS84gVe+4ktzEsmYiXNN0f6409TdP/ktHP/
 6MWMR4Lx8nEAL5MJyeSIcaP/iC/VXqd7/4E1FwsWthx5UTm26qlJtHig/7PUqtUiHYAA
 AIsqAvAeJEvF0RU7U90cxW+aogeLEq8LA2jMvIUZYK3JF4Y9MEIDumvVxcxGshFfW3ok
 IvzoCvukrIew3A0cg3su6zsiJhyLhCEYavqCZ8zEG2XLtHj5a7hqW6H1jl8uW0Kng5EJ
 jAUg==
X-Gm-Message-State: AOJu0YyyTMYvGecWRa63k/qnBKzpQn7XDzQoLC4J0sqx101LZTBDWkMb
 wrHNbljmD/IPBQ5kqAkM+2T03UBIWdck/Qq3p6pWRA8W6nfTTGdEZNTFOr2He06awEEKg+N0atu
 6
X-Google-Smtp-Source: AGHT+IFYPRtucDga6LKg9OYiy7Lp1H1gYO0dq5T1mdbxUJVv5BVKlYTRGjoZPSqqHynS6LcsQRYSwQ==
X-Received: by 2002:a17:906:bb17:b0:a51:98df:f664 with SMTP id
 jz23-20020a170906bb1700b00a5198dff664mr8257297ejb.76.1713294003357; 
 Tue, 16 Apr 2024 12:00:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 ne33-20020a1709077ba100b00a51b26ba6c5sm7137906ejc.219.2024.04.16.12.00.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:00:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 03/22] hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP
 flag
Date: Tue, 16 Apr 2024 20:59:19 +0200
Message-ID: <20240416185939.37984-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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


