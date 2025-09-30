Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD9ACCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZaP-0002F7-Vv; Tue, 30 Sep 2025 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaG-0002Dt-2y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Za8-0007di-P7
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso43986035e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759235741; x=1759840541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4d9jNYVhhPWZq0ZIaww2fB2PiNbSZvEJt2tHeOKQcz8=;
 b=QpOdjwLNeNQ2qaMSEQiVimdh4VLf+qPi9JsDWhty0vX3XRDFyKbNiTx7voBVQRR2zW
 47qucwIeyOWVTB5CZMgvHG8hZNl5L0OSj8cqCxbEplEFDUZHco7LUKFyhmcVWP/bLSiI
 JmcjqcbXBwkmH2+9NdtVgXsRbOD/K5EG7iEUz4ei5hgfBW6jI4T5QPz75PZrzPnJjKlp
 mmUoJkHIp//m+pIAAz5B6zg5gYRcrBoGsZ7qWH6c20ioQStBtYNb3P7NAP04Nkv+Q34e
 mfa5aaUqVgXf7tcbtX5aHIkchKgS3EZtlxvdD/sge5fHpqRqCwpW7n5+iuYs5uQCOdSh
 t9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235741; x=1759840541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4d9jNYVhhPWZq0ZIaww2fB2PiNbSZvEJt2tHeOKQcz8=;
 b=i9UbVWR7DyimMetP8i5oCZoR0T3bQFVsmE40GcrA9dat95k0FYj9FSV+gPo8Um+MJp
 EFZQpzqdnxCIdh0vs5ZMWq6tnWikWfTFx0Qo5lGHjzCSAeBKqjAa1VFBMXMNhSQ9Bc6B
 WxNkIY3gb7XOsx4enqUwGa9fIkQ8SZgcibDa9X8qVcsgEMdqMEGP92eVfSD+CpRajtM9
 azbGsUQkkNxC44Lf/hZN9+Nrht9+1Mc5RLVB0Iw5x5XkYSzeApIqAEpfEFfGwKH1SB9C
 GvFXxtbAls+poF3AGk0m8Yrm+bedhkAGvbMqogsVkKFKb6sFgpba2KhgO3sMiiHDqUBv
 uQ+Q==
X-Gm-Message-State: AOJu0YxVseUDncVQmjyn8VKoM+EiPKOGdA+aaSQ8MYG2i4Ax/vPRNM63
 zi9cVh3Zeufnbqh+O+SBeW1iuLlYDmHYVY17HiISQ5GSCmGszWanaoQCsXCaIthD5mFMxEnfRmB
 +BjPv5cJPNw==
X-Gm-Gg: ASbGnctAFKUB9d039eQUQDrf3EwznVdz5A0oCuBM7kU8+8oT/WmLOBln72y+qo2zGGx
 DqweBElHfWncBTEaED/MpWZzfR39rHnK4nYN8Z1DNCToFcCKPzwzg4H+A9UT97inVYIVet+Va56
 9wbh4YxVGfIJdpLKSzyhzQagWKanx8BJqx+jXN2sDBEr/tIrrJzIe+LN1Pv7/7FX+wCAc387lkV
 dqC7AVmgONORnMZX7AIqCgEFv6pO+4O3ZYjZ6qp9HA2v6tNNwmtJcG6MMu3Uvp0zdQ4ngczZTlG
 2dXSKwjTIlfgrJ0V7pHx2NJyEiXzCZ+4Uak83D2AK8ih2srq2eGg2S5pDf6U0UBmCxccy8NjjyD
 hUjta8NaDwa9M1oGiSfJtWc+4usoGBE+XKbH5NAfdQo14YI1h4rlshb1gUhdQ+Ny8XfojMzzytN
 ojd+kvA7x2v6aPje9XnzYtr9nG4ewpAcCrHbJehB1eAw==
X-Google-Smtp-Source: AGHT+IH31P8PKAmUqoVzRS9+EHOFdRjuNUdlWvT/KsLiRDXm3xVKphxNvMaylsrd4W+vtm1fw06j4Q==
X-Received: by 2002:a05:600c:34c2:b0:46e:4b2b:f01d with SMTP id
 5b1f17b1804b1-46e4b2bf372mr76095345e9.35.1759235741085; 
 Tue, 30 Sep 2025 05:35:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5e4922sm13266835e9.1.2025.09.30.05.35.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 05:35:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/4] hw/vfio: Reorder vfio_container_query_dirty_bitmap()
 trace format
Date: Tue, 30 Sep 2025 14:35:26 +0200
Message-ID: <20250930123528.42878-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930123528.42878-1-philmd@linaro.org>
References: <20250930123528.42878-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Update the trace-events comments after the changes from
commit dcce51b1938 ("hw/vfio/container-base.c: rename file
to container.c") and commit a3bcae62b6a ("hw/vfio/container.c:
rename file to container-legacy.c").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e3d571f8c84..981cf40675e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -104,10 +104,10 @@ vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, ui
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
-# container-base.c
+# container.c
 vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 
-# container.c
+# container-legacy.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
 vfio_group_put(int fd) "close group->fd=%d"
 vfio_device_get(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
-- 
2.51.0


