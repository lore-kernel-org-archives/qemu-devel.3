Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C40C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkpr-0003SC-EB; Tue, 13 Aug 2024 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkor-0007cY-FF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoa-0003XE-Hj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so3596271b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529723; x=1724134523;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=jNctXkflen3KJzNEIdGGZQi1sGji+vUR/IuEMgTbqYi0mZUJHkBVlFXpvmdXNOgWmQ
 4g2n18piVzW5KEI71cwbX556HIqPInluhphNRiaxs5WajIpa19NrHO52ay9vbuJ0MjHi
 Z3z3uFlcWxGihGKbd50LmK6LS+eualc2tXQ9avPprho9UK38U10FxXqd6EYP36p5xYRr
 ZxMLIZk/K9iNkakNgxKUG/BUS0JG776FKAoJTVdN7hwJM9mRCKaOb+Lqa+msDwBw8CCk
 aR0vrQ2iAS39LtR/gvwQLclKsO4avSrNnoo0L9oFQwJJyGETwyoz2PL9XRDA1wg+Tvir
 AVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529723; x=1724134523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=sPI7P7B0SgLN0GGzsVqju3wAgKTGxbP3d19oVluE5WRZReod+0d/q5JRRkuPZvP/Og
 znceI9jOt8dm8euEj7kS2tpw6YFbgC+ocgKxZ5tmW3vCoMkWdr2l4dsdyurMFQAKAbIH
 EOShE6nwvGbcq52Qu5FC1REtzpxhpOdX8upyN7Dl5AEiSbE1S6feUTYDm38GyBr+TgLi
 WTPTpPtyIoV9Vzf8pklvghPYjKbGvheKE2402a++8wPEcvckapOhLL6kByTOwkphdJGf
 soPgRTl3NANLPzM3/lciDbjot8HemfdSCHHgb/08R0zdsO/ZFUQICBnXgTjG4t6/Jo8f
 8hRg==
X-Gm-Message-State: AOJu0YyGw6zmrcfkg1Y0bPg2Y2Qo8q+bk9hRqoKG710X1UlKd1U4pwlj
 mN5T7+OD816S9OjrUh3JXztdh8CquKJ1Fnl7VJ9HmRvl3RLb9ht13Auw+hv4q28=
X-Google-Smtp-Source: AGHT+IE0pglnaj4j0HQIzVbtnwwhhgN9n/g1yTCaRoXDEbqyXEb6JbVpBkmDRQSoT4/83tX46rGD5A==
X-Received: by 2002:a05:6a20:6f08:b0:1be:ffe4:b2a2 with SMTP id
 adf61e73a8af0-1c8d745a6cbmr3275098637.7.1723529723349; 
 Mon, 12 Aug 2024 23:15:23 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201cd1b471dsm6185785ad.201.2024.08.12.23.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:15:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:50 +0900
Subject: [PATCH for-9.2 v14 07/11] pcie_sriov: Release VFs failed to
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-7-4c15bc6ee0e6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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
index 4bffe6c97f66..ac8c4013bc88 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -87,6 +87,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.46.0


