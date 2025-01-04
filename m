Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E3E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyyN-0001eX-6V; Sat, 04 Jan 2025 02:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyy4-0001QO-Ol
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:11 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyy3-00034h-8C
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21680814d42so154305365ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977186; x=1736581986;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=QG62ZyCPOh7Zxg6ENvTskkiIH1Vi9kgVIS+gU47PGLloD4yWoF0LjHkwQDrwHCH0J3
 L7PuCi86kIvzgqT5eIOrDq+nK3z4Te+8qikp77bGJGb011qVgp9SsaJMiZ7rXKk0KYCy
 Fbt17RjY1LUiLLjzhYD5KXIuW+ZRiYsKBW+OFDmkknKw1i7zgmBvOWE69ZD8IDeyLY/Q
 C0xcEBXtsIDj5iDyl9UuhgLra3cW72e0q6VsV4iNJZlQMV6XdFPvFd8LgaAJwZjstAAa
 Iuo9oDGqhQg82fwXUTUzfrBSVaQre9npPuSUcwIRtd1uVJEeV+gDwO/jzgjI/CKa2AzZ
 K27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977186; x=1736581986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=qhE4UMfnA5UAs8Sm6YR17TckUg9rxMk4Z1BIZNBG0M/QRkAr9+Q58Tfh9lt6LHPiJF
 9YUa0cweanCH2+ZLU2EwuRA/1h/NTSgi1VpsAnfO3R5JSQGp1q7AnABytjoCqFSwSgSU
 EAYArtzcZXw7msNJg5n1/bdeqVQRF2t5Adh2mBcx9tAT8tx3FkJVbOqW9o5HTsGG9YYc
 OgWIBXARfMlndlIh3ywMG4caGU53UOCfj87JnRQ4JDYrtZvqUq6xcHPedV67p+qcPOkk
 lKjkvGCJGyHiVM6cebfrJ9Rn9AKVc0YJIyfB+jDoAvtseZH+Gb622FvSPaJpE7952+sv
 rR4A==
X-Gm-Message-State: AOJu0Yx4d/j7ibfwsk80IePGyL36Xy8/tKNmy6l80uLWfdp12zfueAh7
 TLl3CKHRPuSQ4+gYztk+Zywg7ctnwvcmrw52/wvJWyeEEj4rMhg3lSWuXRb9w1g=
X-Gm-Gg: ASbGnct0eFAk9lcrbMCJhKUvaw76ZtyQKV4AsSw1leNWLjV/7sxKApcKObPmI11O7yK
 wFAVduvNVX8kODDT3v6J5fk+yr8P3QQKre79By/V5ROWPSGTovfN0cTWjuMIbGtHOA9YIZdtwMn
 BLMlJaieIUbiM1+lS+NAR81fCBVIWmI1a3F8RMDdusEqP5i4qKW3dvlCpzaL2g208MgThUhxBkD
 rCtNUbSL9PT6VpWTuxIuouzj9APfAc8VWhBV2diMvobUF7bH2slRg3pzADX
X-Google-Smtp-Source: AGHT+IExtDTS0CeN+ehkZvRYhyEczxR2MGWEiqB2HkPyYK45bLg3o4G2ip8RgaMES+f3YPpFvIG3aA==
X-Received: by 2002:a17:902:da8e:b0:216:2abc:195c with SMTP id
 d9443c01a7336-219e6e89b6emr623303335ad.7.1735977186017; 
 Fri, 03 Jan 2025 23:53:06 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9d4645sm256898795ad.168.2025.01.03.23.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:25 +0900
Subject: [PATCH v18 05/14] s390x/pci: Allow plugging SR-IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-5-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


