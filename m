Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8417C52D71
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX7z-00018E-Jg; Sun, 04 Aug 2024 05:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7x-00010H-3y
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7u-0001Az-PK
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc65329979so84616255ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762125; x=1723366925;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=mwnVcHv1piEulKNnOb6g8Vif/hR84twR+Qvmx02bXvlSUP+DhRcYwXGAaDZFfRObiz
 1i8WLAHsePFQttc14B3lQWr3IgmCERSqVfvB3Uz6YjnzO1pvHz+1wi0oeqp9ZLfUwjFw
 jdv/CLlZIb4W3svwlc3Ob5Uf+K2NuiWsiQ/rm9HbW114/uSvBjxTQjH2/mlE/08qC0FE
 3u8V38UHMneINdc96pAVNn8Tusm72l9NMvp1RKL4Esb6XU4BJUqLOk8Xee4nWpX+WWFY
 hyMf9Dar4G4Ju14uCdBJOFphn5EcuaDJBFlj6wWMum0wDWvMBz1DMHKLa1KvCkbVs9Rr
 1/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762125; x=1723366925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=s5eZJ1oFqbECFrbcqtnHJGsa7KANr9ZTppQelbNosH2nQo1Cu7BjfWkZraSwaCBx48
 RvjgeQOCJJjPkFhwZKvG2UVVcVtI56ysDkzaD19x1G7T8nhh1il68/tzSimVj317NttS
 pIiNcZi+U7xn7hrtynasCZ53TMbMGlc3mhMtnl+T5VImGoJ5NvCcQi61RH+zyhCk+BiJ
 dKmll4tdC44E8tV7P8Z9OPxfbFXyWXvsnBWIUVken56HMAeybEMxjPNNsvZcuRzm9U82
 QEClv0MpGdSAPxcf47iayZBPdBD20sPFP9w7aAmCJmBFOB9CTbYfC/Fc0UUZChEkqZu1
 RHlw==
X-Gm-Message-State: AOJu0Yxb9u+rnSO+5sXi9sbW+RSmPYwBF5k5u4KoVdveoXKeNZEDu9/4
 IWLC0HINepWETTqC9ImmXfWJ9Br6GhQhTtObC5+lkVeH5hQCXPi7W8TSX/EQd3U=
X-Google-Smtp-Source: AGHT+IFJ9CgM3hQ8Bm7gybl6ynWwssF8aCIxuoXc5/GUxUQcK9RHFDhWLhY3cLGkMAw/6C0SfvQrGQ==
X-Received: by 2002:a17:903:22c6:b0:1fa:b7ea:9f0f with SMTP id
 d9443c01a7336-1ff5722de89mr121114095ad.7.1722762125408; 
 Sun, 04 Aug 2024 02:02:05 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff592ad9e4sm45835915ad.283.2024.08.04.02.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:40 +0900
Subject: [PATCH for-9.2 v12 04/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-4-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.45.2


