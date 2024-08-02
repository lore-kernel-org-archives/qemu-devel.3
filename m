Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4191AC52D72
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkhG-0006Vn-Un; Fri, 02 Aug 2024 01:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkhC-0006Hy-7u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkh9-0006xj-UY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a92098ec97so5273325a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575953; x=1723180753;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=v9GJmYtbxCWefaWC2L7/8wddF/dp/0rodPDMzRG3tGNOLp8YwTrHnJmhdI7JKV2OhU
 +wG0gUIlUhFG7OOtUBb5M8Vv4nBfXuwFSS33Au7mjtzar1admAROG9jVD/bZUPO2u4hR
 0OjNVxTcdQJuLE8iiaveb+NjkKI3kvu3CYYjYGul3uxjhiYtRiXauXMs/3W+SegXjgDi
 sAh8QXzHl9w6apc2UIQfWvfEDRGFcHgzsMF5Kz2icyvZIb42Z4gydqfkJ6RnL0+qCSvQ
 1t3EZ8eL/q3xvWjcckoL8HOUlWpgLc1Uq5HQSMFQiwIKVXjGTOT19Jj9F6lkG/o90eaV
 uGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575953; x=1723180753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=nqExW538ugAr4NQp0MdUWMRri10pwqVTsLgrQVtZvUj6TglEzjqWslGJdL/NXBeOWL
 Wz/Wz2kLiK6d2yoeoA8D6ErmL6I+nGP0yresdTBj2CjeWPpofl3uy6mBvBvLnswZJADN
 ijzzrBrObpS2hf2wnob1+9ywOpCLP2EAwpGlCXTDI4sfOJrm413nLk1ZpVb7aNajGBAv
 qUjzO5d59v+nlhaYy5zrM6TraPRnP9BIbHBckjZL1KUXHCNrh/GmUCgMW8iDv/srCdax
 iH4TNGc4BfuvdSfcRmDRwEeg+D9rVhSM1lFUj+AhJ6hJ60BYS1PscMcbmN5aQIEKfWM6
 yyNQ==
X-Gm-Message-State: AOJu0YzcBAObbKvmmdjk40T1qeaKW9xdt4TsP2vY6M4ozULSqEsl7RvQ
 B5pgSDDOwtXad0e4OCDIWOJD3fQU3n+ohAKntN1zKqx9v4V3zTn/RFWtVLwfzi8=
X-Google-Smtp-Source: AGHT+IEgLbjkcKK1pXPBOTyntKiNaAfmf0I/+XpSSlls+hhdaM4j5NVopqOjklZcs7xNQWmUN/Krsg==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id
 adf61e73a8af0-1c699559d86mr2726399637.19.1722575953539; 
 Thu, 01 Aug 2024 22:19:13 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f29ef4sm8109515ad.14.2024.08.01.22.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:19:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:17:57 +0900
Subject: [PATCH for-9.2 v11 07/11] pcie_sriov: Release VFs failed to
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-reuse-v11-7-fb83bb8c19fb@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea85..9bd7f8acc3f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.45.2


