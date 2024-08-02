Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69DC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkgt-0005jz-4j; Fri, 02 Aug 2024 01:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgs-0005g3-4z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgq-0006vx-L0
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc566ac769so56953685ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575935; x=1723180735;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=bdbBoHleMsw318Xq1ZLf8JTg4nDWUu7y5JX1wGKSgfQNYtW5DBHCwCFnxsYqV3DG58
 pn7DlB/pAoKhqX+hOJ3PzsYt34KZXEsb474o3ULOXT8Ve47e4flNgUqb7KJ9MqwbBEwx
 FtrT1f22DeDhshmW5+RumbHJq4l5lT1LgLD40SgEjTcV0Mp5a4uGWLTjDp43CtWZWvGq
 71vxDADeyix8NozQt6I0OLyZSpQtUa7kC03Pr+UQAdccgcd4PUuaLJ3Qw5DPgPMFOqQh
 qmpYPOvmsVWnCy9A9BhaGHznBt1IxIZZFL0NN34q8C/2DtwnbEK8vjr2EuIG5V0DDLBb
 Rn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575935; x=1723180735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=QLA2B3cPoedlSGagKZFDo4RT8VjM59xIFGUcSlJE14Xcnn+lGf9hKjB9v2A3+WAHu6
 nf7HnCZ6NtNe9qKuVdyxhJesIh34fHHi7sKZHjNmwKgPeaAIAG9qfCiFuEQWSWFC65Nl
 fqHOXlO9MMFYj5Rmelq0STmK6tPwwBsIULimvflFGrgAqnZzOzj/xJGt2bHiqI+W50fJ
 Tp94khhpBgUIKOw3y8RTMO0uEgWoELmURr+sSq72NSdJJ/8lm/iBCg2qe6e04Dz+iLau
 dz8ENuSEXcvs2VTFKnT81TorpIncwvy4eXbESmCoV7mESRQZupWgW5ogPCy0DZxvPsuT
 htXw==
X-Gm-Message-State: AOJu0YwnK070D0Zm8OozxrslFjjszY4QzgIBqpN4wQzEJSsXAbI9kG0P
 /V7u9FZ31/QnzXGMOPXftJuPRAMYkedZwRN2PcAp8pMZ1DdzDnPMKN7w6F7EcfU=
X-Google-Smtp-Source: AGHT+IFxNjyye6sX5p67ga/P1Kbtxl/HsZiznMyPqaaHc4q+TQnBbLbDhLHp/orJKV/cNkdL/TiZMQ==
X-Received: by 2002:a17:902:d4c2:b0:1fb:93e6:94a3 with SMTP id
 d9443c01a7336-1ff57291d2fmr33708975ad.18.1722575934999; 
 Thu, 01 Aug 2024 22:18:54 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff5905ff25sm7926605ad.128.2024.08.01.22.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:18:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:17:53 +0900
Subject: [PATCH for-9.2 v11 03/11] hw/ppc/spapr_pci: Do not reject VFs
 created after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-reuse-v11-3-fb83bb8c19fb@daynix.com>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
In-Reply-To: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c41..ed4454bbf79e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.45.2


