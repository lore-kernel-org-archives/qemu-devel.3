Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1920C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauV8-0003CA-48; Mon, 05 Aug 2024 05:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauV6-000393-7O
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauV4-0001Dx-NV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fdd6d81812so88694925ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722851972; x=1723456772;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=0LiCMSTInLESWSlSIdiPdlxn+T5sMai059YBDeSU3GxOTMTWM0IvouAoQSIOruLncD
 9Ckz9PLuCfspEEAZqZyfWfzgiGQypvdFtsvbKP2nVMkXwrKsQBopXun9o104ZuJtD+kJ
 54A0weQ2FRxDThZioyskOJT/m1Yfj9Nvm20ZAISX5Y/mxuRnUkb3m0EKH+CjTepM46Xx
 B4GpSG/kAzNNOQC7nnRywb1HbSgHB283znJFiTkffXB42e87QrIx5P5yibMBqaWYR+Xi
 qCT+qMczw8gXAyZ5nkiDVk28hCIxO+5hoIv0su1wc5lY0bpXOvB/2lLqtSmlvVIBJmI3
 NMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722851972; x=1723456772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=qxrHu2FtWp+R0LgZQB+waVALNSnabZSKhTrwVeNnC8qBA4XXS0XsQeoZP6/yZISZEv
 DUVbBjRbTEEckLgAV7z4KtHl+G5jlrmZWW1Pms8/WAVBSglChGaDh9zsfhZKGouJtFVv
 DRT1EBiPFvGPRKv+bwmD5PCCYfinta9JBoWzJxPaX/6ViN9WtOt7iB8N87C97JtGvPn1
 NHZ8Y3wJoCn8NMNErTzDkVRQTnd6A21TPKXTKVZqaiAPRTTX1PtrM728E1t+uWB3S9Gb
 MNyUBpyBkSpYMSS5fFujEkRS+ySvu0e6+SpDyLg7XiV7jJ7LITc2t8zD4V33j7gv/92v
 Fh7w==
X-Gm-Message-State: AOJu0YyK49DpY8iiRRLIGHuMOr/ig2HhOGZsf8r0Hqz5AjZbbOzKzUB2
 deTSxlrVIfFKNP1Nw/073SroOKa6UuIunL54Mh52h9/WdinbMgNMxqORwFu4p30=
X-Google-Smtp-Source: AGHT+IFMxas0IGE1uLO9bondQe0+egYNs5JjKDwQHB5wZvCvKWAConiEj0Dg51LGeNdwFeHDXmPr4g==
X-Received: by 2002:a17:902:c94d:b0:1ff:4a11:5f72 with SMTP id
 d9443c01a7336-1ff57271b1amr145075095ad.23.1722851972213; 
 Mon, 05 Aug 2024 02:59:32 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f2a22bsm64017635ad.10.2024.08.05.02.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:59:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:58:59 +0900
Subject: [PATCH for-9.2 v13 02/12] hw/ppc/spapr_pci: Do not create DT for
 disabled PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-2-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.45.2


