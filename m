Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43857C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl9u-0006QI-8U; Tue, 13 Aug 2024 02:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9q-0006Dz-WE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9p-0006Q0-Bi
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so38122275ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531044; x=1724135844;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sLNYm1kEQastcr3NeEEOoStKnsUPyQiA0AB5cl9ypRI=;
 b=vEhPY2zkGytE8bQkUs8cCMgMzOVNDjWdHHwf69M8HOJYXQOeabIVfwn00eSlg5bhsA
 pOg3arwVulfs3+7PxDED9KtGxlXwd8JpGrQbpVDTU2JVw7T3ceCI0YxsEhYZ0lWYVqtv
 QFhtEueM+HGghnNyEQuOTdltnbi3Z+2lyB98tNkiKW1ciadpGJIqnokrzDug29p5Ckk8
 PwnfACBHnhXpznrTn3oiOqnX1fcDtoZRu9Z4tTUvB8YpP9kS+t7lmP58v791kTHd2uaX
 TkIPqL01N2SNyi2JT8ATOw4pzJalXQPrOrK1skvv957nba0iMQnCNjFQvAtuH+K15N94
 UqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531044; x=1724135844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLNYm1kEQastcr3NeEEOoStKnsUPyQiA0AB5cl9ypRI=;
 b=vL5rbuRwugSbDDM5y1S9XvXFcSLdSQ37L5RblFPCfpQl68IMBTM7//V6qu9QG2HCAG
 RjjwczdWlquMVfv+jdl1lNa9oLMWNagwlBIt3utqoXHjrUnuSe3bj/mv/y2CEf0xUU6i
 /F0One87k7/15BABwtgJK7LrVWPIEA4KJmeS4XnJDXqmGl5m0EXJ4maPJMfM0IMhrVIs
 jHscQpQEMiGTRDzSsk79uwYAUlDHfEBgVnXCLD5G4z6VHCQf35wWqlbNjoQGIrX/Dy3h
 foguPJ6D6A/IfFErsh9yhwQmu/iX7cKcd4p3gX4XvxRLlDB2PkNl7OUq/k239blNaeZ2
 jP+Q==
X-Gm-Message-State: AOJu0YznDON2ixp+77uHoLcL1kkSPUDHz/FLoJluqRAByAq7jT/279mB
 z7vDO/LfKp8bK1fmcYatzqEeuc9b7BrrN5vY0TOoz12PUS1IAz3rd+hAez49gO8=
X-Google-Smtp-Source: AGHT+IGnQLrDp9DkpksoF5PkMiT3Wh7IcDAkoqzn4M85GHP69v09o4sfdUhgbjsX7lJMAXHDavXBmQ==
X-Received: by 2002:a17:902:e88d:b0:1fb:82f5:6641 with SMTP id
 d9443c01a7336-201ca13ced6mr34317055ad.23.1723531043849; 
 Mon, 12 Aug 2024 23:37:23 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201ce2e7bb7sm5501525ad.3.2024.08.12.23.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:02 +0900
Subject: [PATCH for-9.2 v7 3/9] pcie_sriov: Ensure PF and VF are mutually
 exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-3-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 1eae9f0a0acf..e1b4ecf79ff9 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;

-- 
2.46.0


