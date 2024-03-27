Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD940C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPwe-0002HW-RQ; Wed, 27 Mar 2024 05:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwc-0002HO-I0
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:42 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwa-0006ek-TF
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:42 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c197d042fso3305305a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533099; x=1712137899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vS70cG5/b/toW0T3Vv9S7wwrpoW0NWEALf1HsSx3Xqo=;
 b=SEee6GPnEvFs/JbroJS4aChJuPnZAUFGMxKujmUA7Nfft2ZUwZowUsAu6/Qe95EVUr
 uBaBxU5uP1fmgKIgTzH5zd/XmhoEZVrtdxeON/aOg4JlTiTGUtoyz5VKlae5ZNnlCYO0
 f+vomRRHQaeLQpmMKBcMnUw5axKdZXjp8SRw3AB6Jfczav/6Fcsnucuw9PV/souRuClF
 6e/PiV3jJT1wpOoilHeJlNw3qBWBKhWqKhKFUWgKF+LBqjFUt9vNg8+bbRremY+dmqHB
 9n28uG1IQSzGY95JCIFsiBWgqQgnaFQZaPslLaV1AJ2gJ1/+dE5LH4PGJaWkt9antDx5
 XRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533099; x=1712137899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vS70cG5/b/toW0T3Vv9S7wwrpoW0NWEALf1HsSx3Xqo=;
 b=tzSW/Ev/P0vLztQrxkUhwIKRXMvK3ja1Zv6MW6cQR0NGd4X133646Dsq9QEuu0ZpoV
 TG6MeSdIlAycbJORPftrRjlOzkbq6/40y54KNxfQR2QRTyns3FFbhwLu35VUkpj4e9VO
 Z/RxzSz1JFwzGHU1UOCmUYYk090Yuv9ENRXSiHmnumEfI4XWb2TbGfroXElX9TZqedOB
 caWo53FAFpGGDWUKk4vMEbskYGFm5omTcg6UzFrnI+dVM6ceY16W0KAJZpnMrV33kEHL
 QW+WNYq3stgDwWXnByGSpUU4SHT7K7QGHA6GqNtlYPL+dXSmr61w/Ck7wvp4y7JZYwdX
 t5uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX43yO6jRDcnDP8MspO7DfeP+mJIZRlxOhiOF6/ddgvZpG0R6Z2cnHfJEa5lu8UW7yT1jUBr+TwVIxPxylPxAGEL2CRhAI=
X-Gm-Message-State: AOJu0YxHaDW91nWmssYkpfPHkxffywwuXhLnYJ43MmdHcnVTjyFfhoVi
 vmpg2jjOq8n50G4YjSYs/+EuJAAU6YhCy7m6WSqS8kskadn/1uHNbNzcPsEfFRI=
X-Google-Smtp-Source: AGHT+IEcgurc5xJQE+OdK7ozzNu1skl1GKf9MrqFsC2BIL6RppMRi7IoMlS/ZA4dmpjVGoYusXZHbA==
X-Received: by 2002:a17:906:eea:b0:a46:53e9:aef9 with SMTP id
 x10-20020a1709060eea00b00a4653e9aef9mr1408180eji.65.1711533099502; 
 Wed, 27 Mar 2024 02:51:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a170906720500b00a4df01f4232sm1947350ejk.189.2024.03.27.02.51.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:51:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 02/21] hw/usb/hcd-xhci: Remove
 XHCI_FLAG_FORCE_PCIE_ENDCAP flag
Date: Wed, 27 Mar 2024 10:51:04 +0100
Message-ID: <20240327095124.73639-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

XHCI_FLAG_FORCE_PCIE_ENDCAP was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it
and simplify usb_xhci_pci_realize().

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


