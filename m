Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDDC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH8B-0007Jr-12; Mon, 27 Jul 2026 04:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH82-0007Ja-7n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH80-0007GF-FF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bntzi/c9uJWuWzQXlN2eTdhwBGTcY1hAzFIwaeRON5M=;
 b=aXTv7NwFcH+7h58noc5s5cLQWmOFkBXyTvtijMZkmDwhyJz9zKMi8bGda/RbLT0agJrOvz
 ev2l286O1tD4vqhDzRJVzk5Ip8MREbRp6xzYOsl3NPtj/C7SGm7vx4lQZkGx28MbPAu7OV
 3hgpRB5gL0DXBHXOA5jbpHXZVg3O9iY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-4c0jsy3qMIGEBWTqbf1pMg-1; Mon, 27 Jul 2026 04:55:56 -0400
X-MC-Unique: 4c0jsy3qMIGEBWTqbf1pMg-1
X-Mimecast-MFC-AGG-ID: 4c0jsy3qMIGEBWTqbf1pMg_1785142556
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso21664475e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785142555; x=1785747355; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bntzi/c9uJWuWzQXlN2eTdhwBGTcY1hAzFIwaeRON5M=;
 b=jAWcCcSCgc41WpHeAg77F/l4a3Zh6Lc6xsZTNyQI4YZdqdhT+fYmFoQQHU8glANLky
 lkSzOovHPii+qHfN8i5Sm7zFhJ9P+fMnEymLqBeYjB1VKkU2eqnLgODe1pAHPWzeIUPu
 pcRV/bLOQf9k2VK7CrSKpToPOuj+r9NOO3uLS9JdJWxPeJHX42DIvMoFPdWQybhYylFd
 eFI9CkdCYw1SbgxrdNM/KLup6qArVgBo3ksbjVGxF8hRlufDyCkFmR1+CGIdXBNVYG9N
 LrI4yrw4Alq0SA6DRLmsNGyuCFsR5jIHmuAlW+q/nMgtovp0LlkFBQoavik0W9CY3UZe
 M5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785142555; x=1785747355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bntzi/c9uJWuWzQXlN2eTdhwBGTcY1hAzFIwaeRON5M=;
 b=pda/1paUvVVkxBFTAHib6LikMR0p1EhRA0G06OhYHOG19/zXCiPwqlVybEUx8Fm3uT
 eHMHNc3pWPAjV3TljG9yPfsHeCJOQ2oePaing5R95d1X1rgGNDqcDaiCuyzzKX0cgJPQ
 9TY/RfaAGpCq1r4Nc+cja6ilDaZpCmaqTb9JWG/FV20GLS++0ImGUEsr4YJ/Wowg0hNJ
 4o1VQTYuf7/gl7P4eDMsFkS2L1OogpyhaYTNDFeNLJH2qVkefD2OVC1Z5P8xpN5qb3mr
 gsLQPNmrdNjvOOOziMj4413YbBLZNxX3S/hbVHQYkSmL5Ob8jh2FLelmS7lpSdVCt/zs
 k7ZA==
X-Gm-Message-State: AOJu0Yx/PaBmDOtxTm14jiDKf9CfrouK6hvrPQYhxh9v3TPozTzUJdPG
 3y29P4o2yLzErF8SOaitpznOVqYjT8EZIujlZWM2+efXRICzjS0nSy9MN8ZO/QLCKd9u2w6Spj2
 BvPUpG5q24MtyOLDRakXOcaKLFydiULZSGG3+KQAWmJRqf7Cksv8OGk+F0LctiT+0QIjkjiChIZ
 K7iNmS+9R23nsJhNQ/9elZwvKxS9GLGakH/w==
X-Gm-Gg: AR+sD11JKlwKW9nsAYcquTj0zUvcJryIlIDkQMc4ue4JvFryy03DAWUp6LpMakKZsvh
 yTdEPI6rIh1VanqAmKXQPI678cVHwabVRfVlSKWg+QOPphuUITzBl79DB21QBTVwmF5/+2SXT5D
 AlA3OIiqxJxxt8jd+IsWGeyz7yL1YdqC35K3PSCKnKUDc9dy6O2xRXLlBczdXJCTGzl+clZhUPS
 +J8OINOXbnA9az/jVeG3FKuzXfXm9QJxW5SWQg5K1pNH8roPiTwapp6R6IalCwch4uU/hsgr+TR
 i6MjZIc5ZhmEcvlY7DHvqu8mtVMYv1BPtLn9zHdKFmtc/YXyZLaUeF662UI5bb5jT/X1RrtHM+g
 ZR0x5T1XlOG59Rg1SZ/XhwA==
X-Received: by 2002:a05:600c:1546:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-496b5717741mr106639585e9.10.1785142555588; 
 Mon, 27 Jul 2026 01:55:55 -0700 (PDT)
X-Received: by 2002:a05:600c:1546:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-496b5717741mr106639265e9.10.1785142554945; 
 Mon, 27 Jul 2026 01:55:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm198650155e9.1.2026.07.27.01.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:55:54 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:55:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/30] pci, vhost, virtio, iommu: bugfixes
Message-ID: <20260727045453-mutt-send-email-mst@kernel.org>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jul 26, 2026 at 05:29:01PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit cbd42e2b75b23953a9bdb073c8531518b1bd6163:
> 
>   Update version for v11.1.0-rc1 release (2026-07-21 13:18:25 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 13342b9c4104f3bf93c2e52e7de4b383971d7bd6:


moved to f2fe2afd27ddf93b49a16a29e8224d16b9888953 now:
I dropped 
       vmstate: fix type confusion in vmstate_size() for VMSTATE_VBUFFER_UINT64
will go in through the migration tree.

>   backends/rng: cap request size to avoid oversized allocation (2026-07-26 17:26:41 -0400)
> 
> ----------------------------------------------------------------
> pci, vhost, virtio, iommu: bugfixes
> 
> Fixes all over the place, including a bunch of CVE fixes.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Clément MATHIEU--DRIF (1):
>       intel_iommu: Check address mask before using it in pasid-based iotlb invalidation
> 
> GuoHan Zhao (1):
>       hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
> 
> Haotian Jiang (1):
>       hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
> 
> Laurent Vivier (4):
>       hw/virtio: reject zero-length packed indirect descriptor table
>       hw/net/virtio-net: Protect from DMA re-entrancy bugs
>       hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
>       backends/rng: cap request size to avoid oversized allocation
> 
> Manos Pitsidianakis (2):
>       virtio-snd: check rx buffer descriptor size
>       virtio-snd: check for overflow before g_malloc0
> 
> Michael S. Tsirkin (18):
>       virtio: use masked features with set_features_ex
>       virtio-net: fix OOB read in RSC receive path
>       virtio-net: fix short frame OOB read in receive_filter()
>       libvhost-user: protect against OOB writes in vu_set_inflight_fd
>       libvhost-user: protect against OOB vring queue access
>       vhost: do not crash on ring map failure
>       virtio-scsi: fix SCSIRequest leak on a bad request
>       virtio-mmio: fix QUEUE_NUM_MAX
>       virtio: fix queue size validation against allocated maximum
>       virtio: stop migrating num_default, validate vring.num on load
>       virtio: fail early on bad config_len in migration
>       vhost-user: assert nregions within limit
>       virtio-pmem: wait for flush requests on unrealize
>       libvhost-user: validate last_batch_head in vu_check_queue_inflights
>       libvhost-user: fix heap overflow in vu_check_queue_inflights
>       vmstate: fix type confusion in vmstate_size() for VMSTATE_VBUFFER_UINT64
>       libvduse: validate vq size
>       virtio-iommu: fix OOM due to unbounded call_rcu
> 
> Peter Maydell (3):
>       hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
>       hw/pci-host/q35.c: Factor out creation of SMRAM MRs
>       hw/pci-host/q35.c: Avoid early return in mch_write_config()
> 
>  include/hw/scsi/scsi.h                    |   1 +
>  include/hw/virtio/virtio-bus.h            |   1 +
>  include/hw/virtio/virtio-iommu.h          |   1 +
>  include/hw/virtio/virtio-mmio.h           |   1 +
>  include/hw/virtio/virtio-pmem.h           |   1 +
>  include/migration/vmstate.h               |   5 +-
>  include/system/rng.h                      |  14 ++++
>  backends/rng.c                            |  21 +++++-
>  hw/audio/virtio-snd.c                     |  24 +++++--
>  hw/core/machine.c                         |   1 +
>  hw/i386/intel_iommu.c                     |   9 +++
>  hw/mem/cxl_type3.c                        |   3 +
>  hw/net/virtio-net.c                       |  25 ++++++-
>  hw/pci-bridge/cxl_upstream.c              |   3 +
>  hw/pci-host/q35.c                         | 110 ++++++++++++++++--------------
>  hw/scsi/scsi-bus.c                        |   7 ++
>  hw/scsi/virtio-scsi.c                     |   2 +
>  hw/virtio/vdpa-dev.c                      |   2 +-
>  hw/virtio/vhost-user.c                    |   3 +
>  hw/virtio/vhost.c                         |   5 +-
>  hw/virtio/virtio-iommu.c                  |  29 ++++++++
>  hw/virtio/virtio-mmio.c                   |   7 +-
>  hw/virtio/virtio-pmem.c                   |  17 ++++-
>  hw/virtio/virtio-rng.c                    |   2 +
>  hw/virtio/virtio.c                        |  43 ++++++++----
>  migration/vmstate.c                       |  31 ++++++++-
>  subprojects/libvduse/libvduse.c           |   5 ++
>  subprojects/libvhost-user/libvhost-user.c |  61 ++++++++++++++++-
>  28 files changed, 345 insertions(+), 89 deletions(-)
> 


