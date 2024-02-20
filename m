Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7946DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBx-00056N-Rl; Tue, 20 Feb 2024 07:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBU-0004kJ-OU
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:24 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBM-00062u-8Q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:13 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2185d368211so3235283fac.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431907; x=1709036707;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hB+WbDK4cCm7RTBoj9AyHJpy8Jl15j9ME3jFPJODBw=;
 b=N2BcQxoF3tyk9L/EWq/DyYk58p97D/DDRapTP6Iac3LVqUQxqRC3Pft4ABj1eR80MQ
 yNsmZcybVG6X0Zhejady0Arco/OIeXbcfmRKakiQIT7R5bMv+c+oPpMLQyHNd0K9wuYN
 PkfY9XSjij89Rk5aOeOZ4VTxHbcaOMLsCRZLT1OGtmSng3jss7NPjX+j4d33285cTZC2
 lywpVW8a+ldATQevB+66FM079BHQdup4/ov6nvKAxU2F/6izrkuGqqSR3NYRR1qcyFaD
 AxoHw1KxSURQWSjysnb5ClAbN++5IKoqeP0a1lsokpl8/q/Bya9E5rZaxQ9x0bz+SAis
 tW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431907; x=1709036707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hB+WbDK4cCm7RTBoj9AyHJpy8Jl15j9ME3jFPJODBw=;
 b=GNktWLY7kDpJ3Oqramk/Rk4o+9bLADP7I/dPVyvFiQnnBzU5ChGu6LEe6ne2Pgy+tH
 WItwKjq6qtyNg6Nf/rocunpizroHhRT5BBiPgWSzcsUegrpMLvKqAhuCVF1pnENB4jCI
 3GJJOOMAPgBF5HylGPYjIO5oBypoOU5F5MVB4l4Cj245UuXGa+dwkmgOHAVUNfEavZqS
 17gW3JOTwH0vpfvdr8RYL5+6h8vBRlFbdjNuTxA7yGFzQ8eXpSz0eNmZeTxPzOkIKej7
 JmJvzrioaM93ywwvZDsOAS3OsnouNWtIc8+FyFl1/gxZBklmhVDO3UBjh1EVHcu8KLtH
 9E/w==
X-Gm-Message-State: AOJu0YyLeikjzmbF0cNTTHGijmaXczz4ddokZTvpYBP2X9bsNNryno6O
 3YAFzftDXF46WIbq4mzrI8JHHe95knD/SAxafRjYGGvjip5cTlZRwD7hOHRCtkE=
X-Google-Smtp-Source: AGHT+IG79sj3dgQcNT5fbSGu9xfueYsqG8dCJKhCCuWONUwyIcf/6LbkKk1gUAgIghEp1UqtY8jL/Q==
X-Received: by 2002:a05:6870:91d6:b0:21e:d8c5:a217 with SMTP id
 c22-20020a05687091d600b0021ed8c5a217mr6378474oaf.10.1708431906992; 
 Tue, 20 Feb 2024 04:25:06 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 l18-20020a637012000000b005c6e8fa9f24sm6498658pgc.49.2024.02.20.04.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:40 +0900
Subject: [PATCH v6 05/15] hw/pci: Always call pcie_sriov_pf_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-5-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.43.1


