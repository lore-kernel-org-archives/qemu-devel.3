Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6ECEEF317
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy3jB-000796-4d; Thu, 05 Mar 2026 03:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vy3j7-00078o-LY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vy3j5-0008Ex-DB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772697990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0JMY89Oq6sKw0zclEoyEmGTa64KewvYqQ5n0V2ZfTMU=;
 b=a55ta8ec4OZMllV/UTFYJQHcbLiDEjcKopZ8qTN5csUqv1zsIrvgfXfR7/lu8kPvuVBRKJ
 PLdUoLuS0t7u/48ybQ6+DZBzHbyHKcKkCJ344bNGynMuEysIZ3vUw22d+eKt0UKQ9pfGrx
 /a/OPJNRQ5Y0Qmvf9U3JRwQULjIRS9s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-BN3BM9YbOO2VKIydKjRmiQ-1; Thu, 05 Mar 2026 03:06:28 -0500
X-MC-Unique: BN3BM9YbOO2VKIydKjRmiQ-1
X-Mimecast-MFC-AGG-ID: BN3BM9YbOO2VKIydKjRmiQ_1772697987
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so76372295e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772697987; x=1773302787; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0JMY89Oq6sKw0zclEoyEmGTa64KewvYqQ5n0V2ZfTMU=;
 b=pCRH5J5MfqaZD5Libq/o7XITpg/vZ15ZVkesRKHTVpHQQL8DSCUza/L55SsuBb4WdZ
 WIbpiq2QFnim19+o7ybSXh7Cyc0I7pAUUlwt69DUW+4o+9Wrst5ZihX4CaVR9G6J61AG
 nZ3UcUg5QcsznNJAF8rNuMlWAkcF3BT98WiTq5RxN9tq8PbM33fMnmYKec9GxYZIWVi3
 dklEhXL+ZilY+m8bSNjXsLtRtGxJr40D8AQGGMSxmVZSthK7TDGXQzgSlsTwTibpdZLn
 C0JDkVZnmsUpav2Ob8/Melsx8NqDWpQraGzxSLw5zpxGcHr8pK6BXkMiSCN1usFbHSW7
 Xm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772697987; x=1773302787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JMY89Oq6sKw0zclEoyEmGTa64KewvYqQ5n0V2ZfTMU=;
 b=dh7TbHFLcz0lQt3iOwUc2htq39aV9zYr/zbfFgnBtfocGlXZ9Ip0drZCXb1x619JuP
 c/UmaErV1kd0blccgiBy+j9j4bb09HU9YnMhSWA6WTf0cAGaH0VB9Uq1uF9mXPvlZqGm
 hsvRg4OLS/S3SKeORHXzRrK0kpvA75W4dJBz+JHMVOpKQYNm4fb60Al4LDlxWRiiwa8F
 +F2MmCGw9vGFYGPF3KCOHppHij3rNsqKTXY01i1ae8OZ4//NoYzjrA1BG6rPy0QoZrPT
 LkOHkYQ0mlCq01fZ3aJqKMXo5n/HKPoaI1ZGMpcBbv9dpXeAsj1zAlZ2di9Anhh3DJOi
 E79w==
X-Gm-Message-State: AOJu0YwiEobdip8kSYt7ouB/OQpo2/LjlSS3ivsu8P7MOai2pQPh5pjI
 BgTRQ03ubGGs3RnBX3gvN4TH4laWQSqtyZrS4b5outycN+IO2seSD0ojzdwk3p4R4EN0akPpU9T
 L0CSbC25vindllfMPj488vyihCSYP3YJUCzLki0xTcBKSlkUbG7lVizaV
X-Gm-Gg: ATEYQzwFG3SlbH8/OkRaURwvwSHCS62jTiiEu4EBEXj+29k6cV4sZZvDeWat8qxerx4
 78Hp/mkMMvHkXR2/Jo3bkBkKrKFAO0vOtDnmvmGz5VaO9SQ7eRjMrihaYt09QxVE0xdmg4jD7jz
 zPq/pjkVPO3SKPwMUPGYxgl3dbNwZx1Z7RY7vwrWgUU0YSjTZnJWJbwJCYRCb0bXIAPzBEVE2Da
 ufIMwenysDhccFKookJFJG4gPcL4U2QExhYr78O2miO3WaVayBlgfmi4Li9qp1rpoxDqslpqBAT
 CaN3jhdz2ViKzH6MVT5DXUbBEP8+v3Mnu//rHEgm8feqRiyAhHMfDPT45xq+UfqrZYgmmncmKOT
 jWfD5FTXEq+EX+7CRrzRjDJ5JVj4MDVxJM5Atn4k6QB0+YPSNf2HCHsEVMMk/9c95piZjURA=
X-Received: by 2002:a05:600c:1d0e:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-48519888ab3mr88441335e9.17.1772697987088; 
 Thu, 05 Mar 2026 00:06:27 -0800 (PST)
X-Received: by 2002:a05:600c:1d0e:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-48519888ab3mr88440475e9.17.1772697986537; 
 Thu, 05 Mar 2026 00:06:26 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fadeb5bsm36456485e9.5.2026.03.05.00.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:06:25 -0800 (PST)
Date: Thu, 5 Mar 2026 09:06:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, manos.pitsidianakis@linaro.org, 
 slp@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 stefanha@redhat.com, stevensd@chromium.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, Peter Xu <peterx@redhat.com>, hi@alyssa.is, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <aak5QkV_RxUEnV_f@sgarzare-redhat>
References: <20260304165223.2166175-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260304165223.2166175-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 04, 2026 at 05:52:16PM +0100, Albert Esteve wrote:
>Hi all,

Thanks!

This is now fully reviewed, Michael can we queue it?

Thanks,
Stefano

>
>v13->v14
>- Switched F_SHMEM id to 21 to avoid collision after rebasing
>- Fixed all occurrences of shmem->mr.size to memory_region_size()
>- Other small fixes following reviews from previous version
>v12->v13
>- SMEM_UNMAP spec update to explicitly state the use of
>  VHOST_USER_PROTOCOL_F_REPLY_ACK for replies
>- Removed confusing remark for 0-sized regions in
>  GET_SHMEM_CONFIG
>v11->v12
>- Refined VIRTIO Shared Memory Region configuration mem size
>  spec description
>- Removed unused name in vhost-user-base's vub_device_realize to
>  avoid build error
>- Initialize shmem in vhost_user_backend_handle_shmem_unmap
>  to avoid compiler being confused
>- Added stub for memory_region_init_ram_from_fd in memory.h
>  for windows builds
>- Use memory_region_size for shmem_region handlers instead
>  of accessing size member directly in shmem mrs
>v10->v11
>- Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
>  and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
>- Mention mapping cleanup on device reset in the spec.
>
>This patch series implements dynamic fd-backed memory mapping support
>for vhost-user backends, enabling backends to dynamically request memory
>mappings and unmappings during runtime through the new
>VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
>
>This feature benefits various VIRTIO devices that require dynamic shared
>memory management, including virtiofs (for DAX mappings), virtio-gpu
>(for resource sharing), and the recently standardized virtio-media.
>
>The implementation introduces a QOM-based architecture for managing
>shared memory lifecycle:
>
>- VirtioSharedMemoryMapping: an intermediate object that manages
>  individual memory mappings by acting as generic container for regions
>  declared in any vhost-user device type
>- Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
>  with the frontend creating MemoryRegions from the provided file
>  descriptors and adding them as subregions
>
>When a SHMEM_MAP request is received, the frontend:
>1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
>2. Maps the provided fd with memory_region_init_ram_from_fd()
>3. Creates a MemoryRegion backed by the mapped memory
>4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
>
>The QOM reference counting ensures automatic cleanup when mappings are
>removed or the device is destroyed.
>
>This patch also includes:
>- VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
>  vhost-user devices to query shared memory configuration from backends
>  at device initialization, enabling the generic vhost-user-device
>  frontend to work with any backend regardless of specific shared memory
>  requirements.
>
>The implementation has been tested with rust-vmm based backends.
>
>Albert Esteve (7):
>  vhost-user: Add VirtIO Shared Memory map request
>  vhost_user.rst: Align VhostUserMsg excerpt members
>  vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>  vhost_user: Add frontend get_shmem_config command
>  vhost_user.rst: Add GET_SHMEM_CONFIG message
>  qmp: add shmem feature map
>  vhost-user-device: Add shared memory BAR
>
> docs/interop/vhost-user.rst               | 104 ++++++++
> hw/virtio/vhost-user-base.c               |  46 +++-
> hw/virtio/vhost-user-test-device-pci.c    |  42 +++-
> hw/virtio/vhost-user.c                    | 274 ++++++++++++++++++++++
> hw/virtio/virtio-qmp.c                    |   3 +
> hw/virtio/virtio.c                        | 201 ++++++++++++++++
> include/hw/virtio/vhost-backend.h         |  10 +
> include/hw/virtio/vhost-user.h            |   1 +
> include/hw/virtio/virtio.h                | 136 +++++++++++
> include/system/memory.h                   |   2 +-
> subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> subprojects/libvhost-user/libvhost-user.h |  54 +++++
> system/memory.c                           |  14 ++
> 13 files changed, 951 insertions(+), 6 deletions(-)
>
>-- 
>2.52.0
>


