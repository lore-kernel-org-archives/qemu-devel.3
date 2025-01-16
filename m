Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3684AC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLlJ-0008Ne-MG; Thu, 16 Jan 2025 04:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlG-0008MC-Qp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:58 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlE-000110-KQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:58 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165448243fso14347395ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018115; x=1737622915;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=FxHQtYHkuz9SJZcgugHNUVHqxEQJOa6XK34qKkblqLKJwlu7rwrTqIH/jq76KX+RFQ
 A4Bs7UDyDtj3Dgkwpo02vxM4/5jnzGx6vqIGIf6azq5RCXb4vZa2vzgNV2eXLgyttHn+
 /2wEg43+kEl/xezckBifrI0WDZtuPCBz3TdGiZaP1Hz3OdW87I9akKLBP6R3t3uEogwf
 53tKt+BNfaBtKmT+bSnkMz42e1Hn6XJ8xjddXblFoC5NRKtDb1JbtAYPinWnj6Df+W8l
 +8TyUth9iDVBMaFlwXUSWRANUVJbNZFD07jAovFdl70xzF6CFblpKAsCIv9V2QEwBZ8t
 Xaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018115; x=1737622915;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=lo3axgjBgu1E/aznaHDwsRSsv83iYMly1Qt7rHLM7fN7tkQSRTU0wLQOjpXIkeGP+A
 XrOtiWpkHlXEcJLNK6ScbO5gxroVY5+ys/t7WtT3vk8PD3/jcOgAdd78eKHfIuS9p729
 qEpF5/o2nRfRvco03JjUZ8rwZPUvLNvfAw893gBveslCy9e/D4lW8nf7IzOapMtxVJaG
 uqxMe8k5qzhnKQnDFVPHTmtDCyjcBfIP9ba8l0FLsavCyIZABRfJANsxFGGVViK/f4ip
 QNBH4ReqHcbErdAj3CwiL262nH0x3wrttqY9Rzw9cYaBbOrTNNLqj4ZD9A1HBd5xJ+AN
 8LFA==
X-Gm-Message-State: AOJu0Yw5UuO8EuTFRfURL51n9827iU31myg/2kexzSbi2oQk6rwRqs/1
 oPkqY/IYU3TkPk9261GsZfr3G9ZqxbTPizyPuZSU9wS4ybgqV7CDVIZ7fxda9Is=
X-Gm-Gg: ASbGncvG8M1Yp2w+XqIDL7WrdZOFc1XHmRPZgs0wzTNdBu+KpKFbt0vbID+Eh5mjQPB
 Olz1r3t3YfDJO8MGlKLyLC/VzYg6Zx31niEn+QWf65Y1rOUWLjkR5tiX0YuLsDbgQ2ZvrOgUqYK
 lSBnozrt3NyyDpo6xHKre3XR5AV7MU502Pgooh2zhOKo7v3H6UMT9ZAyrm0h9Hg9hUeG3t6RLuV
 4D/vJTHg8bLmYCLXtI1INqBdrc+qfwOEXZe5NGBH3ClAms29d+l0QYymgI=
X-Google-Smtp-Source: AGHT+IFwX0o8QzNxF+Fu7l+lie/LJOBUkKSO/2Kbf/jCs1uyFNQ2ZBwoTLsoDAhIGYnkOLIk5Hw14Q==
X-Received: by 2002:a17:902:e950:b0:216:4853:4c0b with SMTP id
 d9443c01a7336-21a83f92f64mr460183145ad.33.1737018115408; 
 Thu, 16 Jan 2025 01:01:55 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f10df62sm95064435ad.21.2025.01.16.01.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:57 +0900
Subject: [PATCH v20 06/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-6-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
2.47.1


