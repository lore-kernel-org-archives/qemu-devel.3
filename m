Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09CCCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkR-0005X1-8W; Sat, 05 Oct 2024 15:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkF-0005OM-3y; Sat, 05 Oct 2024 15:47:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkC-0007gC-Ok; Sat, 05 Oct 2024 15:47:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cc60c9838so1773140f8f.1; 
 Sat, 05 Oct 2024 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157630; x=1728762430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV4roYq++fPVNjDJH3OXVG1IWov9RJmtNt7xuyalb90=;
 b=d3anrNlWdkZMbAMfHr6mF3Gax9uwN9VxWlv+n+twd4LUuj8cdL4zvI9s/As9lKr4Ci
 0GefztIBJCF/8VIaXKruE6VZThCC+gLTl4reWpX+kOVQlh2KtDWD9U5Y9uYJ74xbpIrY
 dHV1xRntfxYENgEH1YJ8NsFhYbe7ApaHWxfypP5aPng3Q/m2Ac7UC9mXqwNfwvC7dTHk
 UCaCMwEXciAcxMND1WXj9lrdUNtn4iU9PYyNyB2kQnB0ARM6xGCsLuBy+lCg/yGW3z7q
 HpT/jcZ/hSMqxVphGn+gX9s4gYebr2BWz15NX1JGwb49/ABOUeD52AjPBL+p+EtBbMVR
 QIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157630; x=1728762430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tV4roYq++fPVNjDJH3OXVG1IWov9RJmtNt7xuyalb90=;
 b=qexbedC6AMghb1hZ43s8axDbW+cC8b3dQeg2PMdT/Oyz1ll/W4tl54TjQDrrFpTxiP
 pi4eF3VXyg1XK9cXIELz0wmhBl5n3oovsoQOkreiIm1zwVb8O1M5bkzxzrWRV9wvYWgm
 5by6xs/aG0h+ItQSgTDWke21HyKxuaS2DkfaFuJdgbwN/LEr4FnXkgVAAvs1lr6EIGZl
 /lRgALBCddAUaqi7atQcTQUowUqb/ALnFKTSIBZ5Tp7aXzG1Y7vWTIeYXbqeFodCqXj/
 3KVNej2N4hNvxeflvHJUkCrogqv+BOvdrV+d0dtON5pV6ltwgDMuv8YCDzs0ZTln9S4s
 +xWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwWq4y41u+9XVtOy+oKQS0po88/N9O1TQ2kebzTS4wvFWDw4CVnMKJD42r8gtK4bx1oiixK2L0nmgw@nongnu.org,
 AJvYcCVk4t8MflFGHnVK68UJPetqwlCyk8BVaOEn8kTAR4vwZcxZN+FcBP6aiBfC39/wwYSC0B4lYkKodJA=@nongnu.org
X-Gm-Message-State: AOJu0YxGgAqZ/B+zZ4X87YhQvbrbtcff02y8YJKoYoANMdSXrDaF0Z59
 9erxRQV9b81gXDFv16sOZSc3u6wB7lQFb3oyeswar4JNiOkx5a8CFTOJCA==
X-Google-Smtp-Source: AGHT+IFIgwdq4hJJ6vgrn3ijzy2QYQI2gqfswWOBo3bVMtrVrKm1+RYkBMbeY6Tns6dc8nT+gzQU2Q==
X-Received: by 2002:adf:ee49:0:b0:374:b9ca:f1e8 with SMTP id
 ffacd0b85a97d-37d04a577f7mr6777001f8f.20.1728157630235; 
 Sat, 05 Oct 2024 12:47:10 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:09 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 12/23] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
Date: Sat,  5 Oct 2024 21:45:52 +0200
Message-ID: <20241005194603.23139-13-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Prefer a macro rather than a string literal when instantiaging device models.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 97e5d47cec..d7ff2ba778 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -475,7 +475,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple(b, 0, "e500-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
-- 
2.46.2


