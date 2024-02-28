Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A9BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICG-0000kE-BX; Wed, 28 Feb 2024 06:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICE-0000jy-QQ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:58 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICC-0007AQ-2w
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:58 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso4234079a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120033; x=1709724833;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NRg9XEk8ieabjRBH3umLjrDCheGnL9tHvYE3lVOEyqg=;
 b=NuHlBjgfS37TUzdw61d+mZfKjKZ9L/teSXScVl72SR+Z0Nq0OYfJFEMqsg0Z3gLZ99
 24qD6mnOFWQT9Fpm12nFEZFeuaelzcZcskmYKz470kCLqYgqJhKQFiEtgSGvhp2BnFUW
 Fkfv94IYD5NeQ9uz8CX0O/s1yfwZg4zdRIfalomNxoPbv2Xwi387JPCowUCbxuwMvdt5
 Umo2/ELXui/r0sKAGhsM5CWaIM/WTvK+mgEa5CtbSqli1N8ey6CN5e3ikWNUtsQs5v2C
 +kOlTT61tH/ScVP1mITNLNDYUQgkI1Ii1yrqkgh03W+sBlbRGpG65KBcfm6x+aqr7q6M
 codg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120033; x=1709724833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRg9XEk8ieabjRBH3umLjrDCheGnL9tHvYE3lVOEyqg=;
 b=w9+nZiQOrnCx5dhQ6H7u3kdto+ds/oEqTDnVLI5dg67FiHqsHtU8uZlzocDNh7nwd2
 GuSEpAEDT/zsyF4ebUopbfYfeheQjcJAoU+EMcrQzP8dy3PLpCHXUdvCv9BQvSAWbF9B
 OagNlZLCJtoATqNStSUU2cj8QEuCTSLToJnJbNIRnwqnmkgU7yk/IwBfZryURcEY52kf
 zRgx9k8D/PDkKf23KnOegZGrr+cxwhOeMib+QZEzVuE6gH6XJijJ6gOo1a93JNH3h51k
 XUSonji4Xmpqv5XUahzviBItTyIlz+Y9xk+qDQUxIem5cmHfBjn216fJUcZBIvqX7HC5
 LEWw==
X-Gm-Message-State: AOJu0YyfwdkvrhKXBGViAFS0VM52C7VeV9RBdBMEim2c/H8rkFBAk3kr
 FFp2YG2eFh8QPnXvTGI67QakfqQ6XbmJqhOXTJQsU393qzoOFlfk9Q0Tf0fPprM=
X-Google-Smtp-Source: AGHT+IH1so2QMbXVySVNtchOocIJxnh+3DMvZLw2D6lXN8QMvGevJPtP1JyqT9J/1/zMGEvsadA5+w==
X-Received: by 2002:a05:6a21:9204:b0:1a0:de5c:d02b with SMTP id
 tl4-20020a056a21920400b001a0de5cd02bmr6245225pzb.1.1709120033337; 
 Wed, 28 Feb 2024 03:33:53 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 d19-20020a170902729300b001dccff4287csm239577pll.202.2024.02.28.03.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:16 +0900
Subject: [PATCH v8 05/15] hw/pci: Always call pcie_sriov_pf_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-5-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Call pcie_sriov_pf_reset() from pci_do_device_reset() just as we do
for msi_reset() and msix_reset() to prevent duplicating code for each
SR-IOV PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb.c   | 2 --
 hw/nvme/ctrl.c | 4 ----
 hw/pci/pci.c   | 1 +
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 9345506f81ec..9b37523d6df8 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -488,12 +488,10 @@ static void igb_pci_uninit(PCIDevice *pci_dev)
 
 static void igb_qdev_reset_hold(Object *obj)
 {
-    PCIDevice *d = PCI_DEVICE(obj);
     IGBState *s = IGB(obj);
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7c0d3f108724..c1af4b87b34a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7114,10 +7114,6 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
                 sctrl = &n->sec_ctrl_list.sec[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
-
-            if (rst != NVME_RESET_CONTROLLER) {
-                pcie_sriov_pf_reset(pci_dev);
-            }
         }
 
         if (rst != NVME_RESET_CONTROLLER) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca61..e7a39cb203ae 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -409,6 +409,7 @@ static void pci_do_device_reset(PCIDevice *dev)
 
     msi_reset(dev);
     msix_reset(dev);
+    pcie_sriov_pf_reset(dev);
 }
 
 /*

-- 
2.43.2


