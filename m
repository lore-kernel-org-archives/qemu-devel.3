Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8999BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5Y-000387-OI; Fri, 21 Feb 2025 07:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5S-0002Ws-Kd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5Q-0007Fx-5T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AoCeBbkagUX8Kyv4XqGNujI5QUp6oIuMdoxn2XTqVk=;
 b=ecqmbU6RdVHtJQGMKB//SKxDrfkBceXR2+v/64BkWBs874m6YA6oAxF16WnZORvWEo2/SM
 ECy3EDPsGsUAK49dvIeH2ib0KZZS6pQE6O3jBMXRamkBup6GvYid5O8pTe5JEPRVZN6MRc
 5sNLhbcHjwjq2xG0xrpMf2zB9XeqmUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-YnydFCNOOQSY8tgy7HAz9w-1; Fri, 21 Feb 2025 07:24:54 -0500
X-MC-Unique: YnydFCNOOQSY8tgy7HAz9w-1
X-Mimecast-MFC-AGG-ID: YnydFCNOOQSY8tgy7HAz9w_1740140693
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so10251115e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140692; x=1740745492;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AoCeBbkagUX8Kyv4XqGNujI5QUp6oIuMdoxn2XTqVk=;
 b=GncP+wwrg4myeNus4i/D3VsOuZEsxn1HhuOcNP5c2iCbY0g6y6i7j8i6shrxAVcZRV
 0Ka7IZ9Dl7zTYmSe8EH9Xz95PqLzCY9xa89VL7SAOri2Jo4PvBB7M7rqzANUfIJvRM/l
 cj/eoXV9mIT7tVc9Gh+bmROenElERpe8bjO4Djs6s1F7j8wrvP+AGaGqWYTreh7TgTzP
 xZdsk9qGwVIwJODQRjBZLBzHy3H1YhM940q/pMOAmCLfCu+KoZFpMotRoljW5vDmhZIt
 TrXuTi2WtCeSjVAu8vu9HzFUXAsk6nvlBzuFfYXK+dgS2S0EQ3rbqBtOCBl/eC2l4YDS
 ISfg==
X-Gm-Message-State: AOJu0YwQ3zdSm7N+VjntN2xc7H8A2dVIoc+2PaIgivWRYB8eC3ndunNN
 nYeyRBU4jdA3W7nqRaAMSakJoky40c5XW8DTTbEqoLAiRnEFRravdjyyYhw/VnWnG3g3jCbz65S
 7RB7RwsSlyIDPFQXEZLqbs7FPfz3mCRI670vr17dxtQdaR/D3HmsOaDuuBbIMzL9ELL0XQsl3/0
 st+cX99O8ULuo3WeQXQLYZsqpkaOh6Hg==
X-Gm-Gg: ASbGnctZ0OsKBpkDJY2lSHFp6Bw3JmsH8FtLJruWIbB1ud4LNCaoKmGCPDIsKBw1iyn
 p2ankuLciYJQddJYcAbaqhmao/QqOtvx5CBIYaeod0UZ4DlW63bVpLTXK/uzgQUi1XHAFVnzPRU
 Hb9Y77VyP+mQ7aObmojyK3JUchXKWS2FM7N9xXp5SIb9YmNwLtRC5FN0KZ2KVk9SQ03RCShVPxi
 KsNpgy0Msjrig+WLkFMbvd7egRwGwh1xixey0Xt5s/Ffe8DV4H+WWOwpke7RWYqBjsGFFo7Cbh4
 j8nFhA==
X-Received: by 2002:a05:600c:3548:b0:439:a138:1d with SMTP id
 5b1f17b1804b1-439aebc2408mr18512765e9.22.1740140692570; 
 Fri, 21 Feb 2025 04:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC1S3BVBIVp6Aq5M9p4iY9jtpnipohLmI5OfqtcZ9IuH+TJxJwTRR89FVJi6u+C4uJxcbysQ==
X-Received: by 2002:a05:600c:3548:b0:439:a138:1d with SMTP id
 5b1f17b1804b1-439aebc2408mr18512445e9.22.1740140692044; 
 Fri, 21 Feb 2025 04:24:52 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d8859sm15613625e9.16.2025.02.21.04.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:51 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL 40/41] hw/vfio/common: Add a trace point in vfio_reset_handler
Message-ID: <d410e709526d1cd4aa9085c6e254a622594a02a5.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

To ease the debug of reset sequence, let's add a trace point
in vfio_reset_handler()

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20250218182737.76722-5-eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c     | 1 +
 hw/vfio/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7499a9b74..173fb3a997 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1386,6 +1386,7 @@ void vfio_reset_handler(void *opaque)
 {
     VFIODevice *vbasedev;
 
+    trace_vfio_reset_handler();
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
         if (vbasedev->dev->realized) {
             vbasedev->ops->vfio_compute_needs_reset(vbasedev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cab1cf1de0..c5385e1a4f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -120,6 +120,7 @@ vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
+vfio_reset_handler(void) ""
 
 # platform.c
 vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
-- 
MST


