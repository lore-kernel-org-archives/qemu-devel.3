Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C802D1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOS-00025b-SU; Tue, 22 Oct 2024 04:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOR-0001yJ-13
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOP-0001W7-1W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c7edf2872so47121705ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586248; x=1730191048;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iZa4SHG6kqnCw7wEadUMiCSvFMQvdZ0uEhNofSMSARA=;
 b=abL/NvgcioC1W6g2ZnwCY34qAxuXMboxMt0Icw3u4WM7QKaav7RoyzIpqsspPGutvE
 T30IH0kztIg6Lo3iPjxYZ1JQzqoES1IYUJ2gSFUKkblnIzOzVAVESUUc9GbW1Qv9A0Kw
 BsWVnfOIwG6wvzcMkb0mQXmzHCHdycFzSTDnnyAc3QxY27bLdtOGDadNGxKwgU/Ghwdh
 xtDsCdjVFRVXcHF3xYgpZ7fJ0dRPybmT6t4AESj8TtAI1Flf4kSp6eOQMGCxIMmSR5kr
 peaNd2fdBBggdZr971TShBtxFK8p22RWbeFO+X4qLvDRLT6KRMCUIyZRVYH9J4ljUYok
 QoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586248; x=1730191048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZa4SHG6kqnCw7wEadUMiCSvFMQvdZ0uEhNofSMSARA=;
 b=j348RSBX+fN7KSvAdXf8Fgzl4Sbehl5sUPx759ckzsS+2HHCMZ9Ms5fs7aWB0D1Tgs
 J3/QvWkl9TQk6NZVDvpSjm8C23bS10EB6JLXULvH2+0Vve7CFwZky6q08/5nx0lG+doi
 yTo7hzlW6pjORUmyP6W2tMdhespB0B74RHrGPV+c6mKZTuSpcom25s8pqMYyq9MOwKCN
 CqRW6AhaoYy8MEewSJlC2fyW1pnhAZ3W4hJ8ueI1Zr0vIT/5MsaJsQEKAulxlmUSdLeC
 HXFiz0f+RHT1zjpmuDS/8yju2XaX2oGdRO8jOftNYd90VrRTzfLxj3t1Uzf+CIZo9dbw
 fn5g==
X-Gm-Message-State: AOJu0YwMfkvdA3NqDZI4plZYuCNKVdCXGe1mEErhZMxxhuo+N6vq32Y4
 aCohU44P0y8gVglefOAE7xsJPgMkx0dEJS19LUTjPGidMIz/AnuD5/ipWLcPDow=
X-Google-Smtp-Source: AGHT+IHAKEJdaylFNjSGyAqXmH6/r6eXyKVTHr2NBnmuU/GejIfw3Rk1twxlWVe7YvJGz6HcayrLtg==
X-Received: by 2002:a17:902:da83:b0:207:1845:bc48 with SMTP id
 d9443c01a7336-20e9712be45mr27705475ad.30.1729586247807; 
 Tue, 22 Oct 2024 01:37:27 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f0f355csm37922865ad.265.2024.10.22.01.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:42 +0900
Subject: [PATCH v17 05/14] s390x/pci: Allow plugging SR-IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-5-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

The guest cannot use VFs due to the lack of multifunction support but
can use PFs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f06df757a34b..0c8866f8298d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -974,7 +974,14 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Multifunction is not supported due to the lack of CLP. However,
+         * do not check for multifunction capability for SR-IOV devices because
+         * SR-IOV devices automatically add the multifunction capability whether
+         * the user intends to use the functions other than the PF.
+         */
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
+            !pdev->exp.sriov_cap) {
             error_setg(errp, "multifunction not supported in s390");
             return;
         }

-- 
2.47.0


