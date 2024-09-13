Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956D2EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxF8-0004GH-PR; Thu, 12 Sep 2024 23:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxF6-00048J-JO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxF5-0008ER-0B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71911585911so1450118b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199106; x=1726803906;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NmGRr/j4gFqTMWcqdWmxMlNXp+Scii992isCntXZZro=;
 b=R6LvL9SlvEzQk+L3Hvk9gJYQnBZldGYxsydf/c3RitG/WuD37MqZ7cBJWsX9iIusOl
 w5VY8IDfGnMIJo5iJVNSyx3YOdQZsc9LIlV8+wlbfHdb1AJ7eOh15F7N81gyFik/1leg
 +ziBvGNjzwRUDVK+xpfp6fFzeuSQy9zn7sw/CI1TszQBF5m8epfFwckR4TU49tzF0rDr
 rT5k+47xFr3o8P/hGsSh9CJy49eSGz+g3zfQ5Gw8f+zPE+s9MMVH8mxS95gqfpyEaXne
 gEWOiEn7Vydt68ubJDlOCE/bx0pfyy6/rWG3Nzg1fpU6PW/8XNhoqg4XGscelzwidhCL
 Pgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199106; x=1726803906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmGRr/j4gFqTMWcqdWmxMlNXp+Scii992isCntXZZro=;
 b=T/wTDAYJMVpFq7TOhx9wdA7cX7Qu8rqrlRfRd2ta6F/Aepg7/AWz+Q5D1QOegVvQuU
 3mn4szkKh/AtWdpVMgEOhjphvLa2ZM33Zaxzo3BNDUABggOmtg3KuOmUtJPsejAVfWoc
 oN1HzGIW/27xKUfpN11QfbXtqjjnAA+ndb+VDJ0vGZPwTcaWi3YA57jSAvmdcqUxuWnN
 vLjmHjn308Ix0Hsj709x+xf92SHMw6vpZpKvSpzJsuWZxrUMIfT/lhvO9T1/D95JP7bo
 yu9yz5/+n56v20+Xmt3hVv5gjp608gBV6fVqiRI7A62SjWg820I+BXD4Q55dMzFIBrmk
 diTA==
X-Gm-Message-State: AOJu0YwpEnUB5O/45/ePd35BsGnwFSTZ33FnoRBeMtmFQ/1Q/WW1RA90
 Go0y6YmIY/xfvnanDlfXj7Kpwa4KI59R7HjSfCkyDStR3StfldBV/Jrz+lwidEY=
X-Google-Smtp-Source: AGHT+IHcN1e8wMSn9NWoQszzECURROSRUsw95kJD8YbJglBBuxpJI04hSBh1D+4Ehc7oW2R1fPuanA==
X-Received: by 2002:a05:6a00:b92:b0:714:2198:26af with SMTP id
 d2e1a72fcca58-7192605a169mr7974832b3a.3.1726199105393; 
 Thu, 12 Sep 2024 20:45:05 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-719090ad428sm5448909b3a.142.2024.09.12.20.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:45:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:33 +0900
Subject: [PATCH v16 05/13] s390x/pci: Allow plugging SR-IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-5-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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
index 1a620f5b2a04..eab9a4f97830 100644
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
2.46.0


