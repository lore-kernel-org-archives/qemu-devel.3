Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1347AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFr-000657-Ro; Tue, 23 Jul 2024 07:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFa-0004b1-Iv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFX-0002kY-H9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i33/3Qja9OS3einDB0z9RqroZS7tFHAamIIdFj14KsM=;
 b=YDuN0lM0M+oD7D3Qa5v7n6TmqR6tdC0YJg/sX4PQ8BQI3EuKBtEnSSiObXmZwOoMcQzsvD
 TOTkxlhu0zhopET4mPt6W+wF9NCWnu1qeu4A/+/AVfm9AOSURtGueYdWasmJKyahlx7T/1
 SpPwC4QNrFHHRIyEiS0QTQ/5Vt0p93c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-iuLz5_mCM52gRKNQtxwjuA-1; Tue, 23 Jul 2024 07:00:02 -0400
X-MC-Unique: iuLz5_mCM52gRKNQtxwjuA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3687f5a2480so3115211f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732398; x=1722337198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i33/3Qja9OS3einDB0z9RqroZS7tFHAamIIdFj14KsM=;
 b=oNpGkjPwyz6DstI+qiNyHlrvjFLXDv9SQY3MCWf2nLnSaBR9qZrjk9L4KU3IBOczGM
 hBIUphBJgi/YKg65t/JLAQqQZA30mTton/gtQUa4Wxz8iX+3eS/8W4WR2Hz+aAonxbDj
 zKKXegTbm1qtHApzGkkPuywizW3bHsMsGV6k3CxKecotj6MrWqVXUyA6op4o4KqwQLDp
 MeNlfeV0SCTfolgxDXFhB26SvybvYK5czpiXqHGqkOIMHMuicinrYArYUv24vze+MMaz
 yBY0pRW+fj8Gdx6pBdmFAanoWIMMV+nFDC0PMW6t8i72NKiuXDxdWu30U3U14ahld18R
 szhg==
X-Gm-Message-State: AOJu0Yzhizv2kOqlHEAGhwnsXb8Fi+D0vS9v2J8zvWkut0tes2i58eBr
 /odwInz1o9aS+cxijtDrhfqZrY6r1U2KnkOFhhEpfUwwxVH0leOYp/NPdnGXBgkM1qNBWjlzm/i
 hhy5m5iUpsUSC4GNpuHR3VjqFAoLR4ArWya4x+azaCIY28x+JcGFARa5g2DucfzLnTuH2BKlr9i
 2mAwXJpFvN15kr1WAjpUKMwbnui0kpjg==
X-Received: by 2002:a05:6000:881:b0:367:916e:4206 with SMTP id
 ffacd0b85a97d-369dee46164mr2209256f8f.46.1721732397773; 
 Tue, 23 Jul 2024 03:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG7bO1brr7fBBfuIFQuCndrMWRKXgHwfHk2CN0x441KigocNiTbuJ3MnvX6kS7QgPStArrVg==
X-Received: by 2002:a05:6000:881:b0:367:916e:4206 with SMTP id
 ffacd0b85a97d-369dee46164mr2209228f8f.46.1721732397002; 
 Tue, 23 Jul 2024 03:59:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b262sm11156565f8f.30.2024.07.23.03.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:56 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL v2 44/61] Revert "virtio-iommu: Clear IOMMUDevice when VFIO
 device is unplugged"
Message-ID: <935c3914184c4ebb1a4c545fc77fe2f0b24645c2.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 1b889d6e39c32d709f1114699a014b381bcf1cb1.
There are different problems with that tentative fix:
- Some resources are left dangling (resv_regions,
  host_resv_ranges) and memory subregions are left attached to
  the root MR although freed as embedded in the sdev IOMMUDevice.
  Finally the sdev->as is not destroyed and associated listeners
  are left.
- Even when fixing the above we observe a memory corruption
  associated with the deallocation of the IOMMUDevice. This can
  be observed when a VFIO device is hotplugged, hot-unplugged
  and a system reset is issued. At this stage we have not been
  able to identify the root cause (IOMMU MR or as structs beeing
  overwritten and used later on?).
- Another issue is HostIOMMUDevice are indexed by non aliased
  BDF whereas the IOMMUDevice is indexed by aliased BDF - yes the
  current naming is really misleading -. Given the state of the
  code I don't think the virtio-iommu device works in non
  singleton group case though.

So let's revert the patch for now. This means the IOMMU MR/as survive
the hotunplug. This is what is done in the intel_iommu for instance.
It does not sound very logical to keep those but currently there is
no symetric function to pci_device_iommu_address_space().

probe_done issue will be handled in a subsequent patch. Also
resv_regions and host_resv_regions will be deallocated separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-2-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 33ae61c4a6..4e34dacd6e 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -467,26 +467,6 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
-static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
-{
-    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
-    IOMMUDevice *sdev;
-
-    if (!sbus) {
-        return;
-    }
-
-    sdev = sbus->pbdev[devfn];
-    if (!sdev) {
-        return;
-    }
-
-    g_list_free_full(sdev->resv_regions, g_free);
-    sdev->resv_regions = NULL;
-    g_free(sdev);
-    sbus->pbdev[devfn] = NULL;
-}
-
 static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct hiod_key *key1 = v1;
@@ -728,7 +708,6 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     }
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
-    virtio_iommu_device_clear(viommu, bus, devfn);
 }
 
 static const PCIIOMMUOps virtio_iommu_ops = {
-- 
MST


