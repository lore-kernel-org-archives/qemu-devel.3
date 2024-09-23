Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519BCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPp-0003LG-1M; Mon, 23 Sep 2024 05:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPi-0002qH-3b; Mon, 23 Sep 2024 05:31:26 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPg-0006za-Jx; Mon, 23 Sep 2024 05:31:25 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so468925266b.0; 
 Mon, 23 Sep 2024 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083881; x=1727688681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUh+oh7tSH9I4rc1ZsB6pfl2pyJWratf071Tqy+tkcU=;
 b=U+oPZC+hysKG6aM191gij5dmDFhms3o2ff3YiZ0ce7Sd2KOu1NQ+Z71Lb9aKE+4N9R
 9z/2UT3enCcrRRl5fg/d66XbMuy3wCkEg1FsFrMhL1mqtpkB8xP29OSHoqypKdewDvxC
 JrRxYNHg/Us+ODVxarOEQKrLNv/lm3JEHxAXMuIjLZQMi+ubRKRpNd11NPreCbe5T1Li
 YpUHfj+GWQk3CYl4BbbTH13eC2zZYWJgybiwBy17JH7w/dJII/pQTRn4uSSZvg3N5k4J
 AIQfZ0mi2432k/5Vf5d/NJpWvgvsvDvpQplOeJTC88yijbeU8mxk9aaNvc1tj7C9cKgg
 PeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083881; x=1727688681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUh+oh7tSH9I4rc1ZsB6pfl2pyJWratf071Tqy+tkcU=;
 b=UH8wmIgaZOfS57N4SIWlIfpBn2/ZSD26ugsbyyfNSmkroLYqmacGQpmZQjoORjalJt
 yPpfPadAeOkPc0NnfH+sXBdNxVrsTHnAN5n8xX0EFl+z6ydhyKKhM1YlxKgBiFz7NBkR
 g/5r8WQFSLt+koHbtONx1CQ2Q5Rf6GcvIJigwhy+/9/43dn2iCKZYQ6sizhz3j1V+Ojl
 sO1OzqIuMaf0gxk0ZfyLx8oVylfHC8gu+QhGbHvt8W0Xz5n68peUR6X2NDvm1mmj4cWy
 B7YDht06coh8wQrgG9rrK+qKgQBEw8N/kFm8dnpdyAmAg84+j88RPh9LiQ0v5JAFHIoi
 B/HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3x1d2JoBw6qwGqvLjyUJqcFFCe+O2MNstP6c6ZvSJOslODXP9DXMz0DQAPsgevYBE6A6zI6Q3v8k=@nongnu.org,
 AJvYcCXlSnthZfqBUShHlk29/28ouxjhsengkA+EJF+17QRqRXbiMOZngFqGMTzTh2Zaqkn0ZfNuqe2YRkOh@nongnu.org
X-Gm-Message-State: AOJu0Yw/NFhZVbU7ZTtlugPTcd+UYU3971ogzZKHVvZR7qDeWrdnSLD/
 5ALr3Ljb9+GLjc6r2Uz3Zmt4hdH/T9XcvUvT8UMp6V/t+5nKFnv0r+eVYg==
X-Google-Smtp-Source: AGHT+IGhZPbR4sS92Yd3klCUpgb6yNV+VJtM3enhxhrJr4m2BQw7iB/OEqxNo6fgEFeILE3Fo616ig==
X-Received: by 2002:a17:906:730c:b0:a8d:55ce:fb86 with SMTP id
 a640c23a62f3a-a90d5122bd7mr1185738166b.57.1727083881148; 
 Mon, 23 Sep 2024 02:31:21 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 12/23] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
Date: Mon, 23 Sep 2024 11:30:05 +0200
Message-ID: <20240923093016.66437-13-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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
2.46.1


