Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F7E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm4A-000134-7t; Thu, 09 Jan 2025 01:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm48-00012M-AT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm46-0003l2-OG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:48 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-219f8263ae0so8259275ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404245; x=1737009045;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=Ye2lh/Su0gnG8T57w70s0pNW00VEVWTO/0cc6uasUM8riryfFF5KObiCG5ycMEE3+m
 8UCuCD4u2fxDgzMe/QIt/IN5Neo9dUepsJgCV7Yv+ZgunYSv9TXPdY+2jcit9dt6vgkI
 pAaCYC7p/KF6/bW6xKeaBA7pVEMSo6XT/1ffuqU/W7B+UOCgJGfhGZExdNMURS7R5u4R
 5n0SP3p/EB7fGinr6EEhOeBxATZvExHdD8TZKWtbFKlUoqzNwNgcWsH9jX7sh8unyEy8
 gLdMSZ6voyySN5nl2pJtYdAGP+s1c2kFHMTeraw2LV0rql9OEO8SdLD9vh9hZriePW2i
 NT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404245; x=1737009045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=XMFQ+WDeMSV+wLQ4cMO7R6i04Z0Y75GGO+Zs4JtkvR+XhtvXN6HONuJhQIuOvtVkEy
 iUZNsinQAwerl2S3jNyNNUqKlgr3t7N3NWShbZWuES8FVH7EGQBtOPPXLWALuGxcnSbV
 U35SmJ7BdueTmRhm7K978hIBSLO6ygLu0efmMrA3442Rf2vr9Y3/5tNlWmKziuRzC4NA
 10Jpa1U0ONruGtFMgrS0+KJARZtISC+XZDfwwMuJkLpDf4LISZiFp3FH6C/4SKoYhic+
 caGLf25zQJwIOTcQnhuiRlAFb5/eHC2c1EjcEK6Dk9x4kU9YNqCIKl9iKqp4gi8FamG4
 Sjog==
X-Gm-Message-State: AOJu0YwlvGatKoDeDw5mvTYuJq+3ArCugKTRfY4cHnHUV2q2EYFFYY0/
 +NP2Eyv3HqtJ9TvtWeL7L+x2589hYijHvwSm81roPK1agvsEp1copacqcMgDtVg=
X-Gm-Gg: ASbGncshpqBKHsg7FvTJynr7q/aYE7/WJDMIkox7AvMddOJfi0hwicqK6fR4jBfxcnO
 DKx+raGM2/Q+myxuEyyEtlSOX1cT7z8Db9MAgXq5FtVY6KTqvAOOK7iRWWEsZogDf4sWPFCGTYh
 5oQUgLCcx6Xglx6lvYgDieVkg72p6NfsOIFEwvSrlAD+NhOCRASpfWn+BuQ3wOfvgsYZXZxzL/+
 kIIwzQjEL9/Cd8WS1d5wmle3gnHSdXFtZZBZXehTV/Oqfb+gpImqpM7pq0=
X-Google-Smtp-Source: AGHT+IGxPL0hUzYPM/0rcU9Ja+Zse57wyucE6ZBjZDNfb4w3VDy40L3YGpikBdZ+CEkeQ2aMehsIGw==
X-Received: by 2002:a17:902:d50d:b0:215:7421:27c with SMTP id
 d9443c01a7336-21a83f696a9mr83154865ad.29.1736404245255; 
 Wed, 08 Jan 2025 22:30:45 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a31ddb9e409sm516155a12.74.2025.01.08.22.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:50 +0900
Subject: [PATCH v19 05/14] s390x/pci: Allow plugging SR-IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-5-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The guest cannot use VFs due to the lack of multifunction support but
can use PFs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 8c5eb69f7d76..c396d55c7240 100644
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
2.47.1


