Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD01C54E41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHo-0006zb-O6; Sat, 24 Feb 2024 04:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHj-0006nh-VF
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:34 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHg-0002kR-Or
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:31 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso8807075ad.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766727; x=1709371527;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vwQMc7eTDkdxhjLzMvuMnyMxWvXIcpUjn8IJsLlj/Nc=;
 b=UyfPmMx3YrmVx0IDdnP6hgryTet2CcMEekt8oEZRssBInb8AM2bLxEHhPVq9l+ZLAH
 mVKqQuEcVZpg99piGjnEOmDzkEk7lcPJZJZOZwSK3DC7KHpRlj3BEw1mtxLq8KizQV1D
 HAvTXPed8hVeNl5D45G5TX4Z6hiy9p1Y+b5g4RdRiVzg8Htf/xCRhk54mf/kmK+BSBAE
 HsvY01LEk6r1Uqpj/ubXpw0pDQwPHCZVCaE6mMWXPr5tW49K+OwP+myM98ahS2xEz785
 R6O/b7lGkVAsj+sc3Y5efgwZynXQggGQ9Q3FCljjgDL7Uvu2pWet2+Hj2nf/3uVgxJ4Q
 Oi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766727; x=1709371527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwQMc7eTDkdxhjLzMvuMnyMxWvXIcpUjn8IJsLlj/Nc=;
 b=P4F4uovjpFWiBdUAcFviqLs5hjAnT2HODoyB3D6dc6wTcosG0KiBgFvD1M7XeYWizI
 mYJJF6aljDtkNW+FNPfyz7qr+9j9a8gFsJj+1HX1VFPPhqtlI1Qap8NzyQ/yUww/tZ+h
 KLqyN26njVifNEhdTeTubtsHZjpzEOThJFpp0nXi059p2gqY7NBP1RfLOyf5suEVRuQz
 CD4qHOZaufbnP0+pQ4oBeQdWfSokBe0BeV5d0LgtbxK2OMfw7sy20h/gGxu8NbQ+MwGE
 +iVzWTTSmw138W1lzpkNewKZgetuPTD73o1LPMpRH6TqiI7QtLdFsVa47uFl0eKM2Ql2
 9j0w==
X-Gm-Message-State: AOJu0Yyae+I3ik5KII89kWiLvtV8x7JjjKXeuhvI1YZycUkVqd+mTTWH
 gnYQf9NdXEPtr47D5GjC3f1LbEZUt5iSIW06l2el5HQyZBV2tfLgwy2Fmbw8j3E=
X-Google-Smtp-Source: AGHT+IGTINbE4Jfdd4QQqBKogpjuvlGGHGmpwXcnr4qM4n4z548zEmhE/AJ0JxNaZDUABkCN51tfyA==
X-Received: by 2002:a17:902:ce84:b0:1dc:2d65:5fcf with SMTP id
 f4-20020a170902ce8400b001dc2d655fcfmr2910111plg.4.1708766727157; 
 Sat, 24 Feb 2024 01:25:27 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 bv193-20020a632eca000000b005dc4da2121fsm728367pgb.6.2024.02.24.01.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:41 +0900
Subject: [PATCH v7 09/16] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-9-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index d934cd7d0e64..8710ee95b26d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -86,6 +86,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.43.2


