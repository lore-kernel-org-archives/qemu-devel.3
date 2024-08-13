Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A8AC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkoU-0006Rg-4d; Tue, 13 Aug 2024 02:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoQ-0006Di-6u
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:18 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoO-0003Vg-FQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:17 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-260dde65a68so3246466fac.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529714; x=1724134514;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=hdIUXXDZyiHiIbUjWw56Xt62rfpBq4/UDuFfTpI3rhrjbcb6nbvtMUCmz1GQmnORxx
 Aar207w/tqP3YbA6ZRAJ81RJTCN++Qet4T9/nf56fMSyQ26SOE65ptTeSxVo38FVh3YO
 PU6G4HYtNvrHOpGUKohJorSAJIPnt1ksWpJ2XoWI9/n82TR5+zdQTXkLkE1/aHz7AEFm
 ypqDBZb5DJLZlaYOnKAHbC/6WxZHckfNBZ3NQRnPf4RZ8mpE452+fxP350bQTFxAncw/
 15Iixu0I3A1bAB/4KWGFVERxDF9ni74qP91Cs0uJFo8e26W/ehLf2o3KMUEsAKjrnF9+
 EiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529714; x=1724134514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRjBowTwtb659ZbVk9eSUPoUW4j3xXhVBm+o7M+tERI=;
 b=M0o7EV+3kc5uxGsexJIQjeBgWVqd6/uojRFsWUBLeB62o3KqDeCmFw8FOuOoqn4VzA
 xWrI9cgPaumTD1FOXsI74EVi7LiDOKtQZzBakJiMy9Or8DqbONBY/ky+8F+0RuHCUcqQ
 RQFntsG4q+v7+sc6T0MVGjC+m708Nx0XZT3/ifkmTz5eIi1wTDYXy9KkHFjYDhaD6b89
 +1mnOt4gCEay62Y/IhQR++jrQb67Eg9SqOqcUXPrAUlDbA45AMe3AsTCCg2uX/76Nl+Y
 BPwlfjJSUN6M6ydefsuU/xqp++CjpKFKdp22sVoUyY7jeSoc91D/tnZHydRrjzdMd+kA
 OSfQ==
X-Gm-Message-State: AOJu0YxQ6t1Ge+KSooe8eOFsX5V9SRr4evVf2B+MhLmUb5v7vznUGkYA
 3gLmsPQmN0mJShwvx2aGmgmcfd0/TInLUYPt1zqvEyWBN1zYUQiKgq9erUx96UA=
X-Google-Smtp-Source: AGHT+IHOKqSvUzcvpAAX53JKKQ5Lobb7OfAb9SecdPPb5R5R3Zm3Ascdd7OrHm3VFyfH/cP7Dz/JVQ==
X-Received: by 2002:a05:6870:b52a:b0:254:a811:6c75 with SMTP id
 586e51a60fabf-26fcb64b94cmr2794485fac.7.1723529714162; 
 Mon, 12 Aug 2024 23:15:14 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-710e58ab867sm4936542b3a.66.2024.08.12.23.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:15:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:48 +0900
Subject: [PATCH for-9.2 v14 05/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-5-4c15bc6ee0e6@daynix.com>
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
In-Reply-To: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
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
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x31.google.com
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
2.46.0


