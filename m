Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15ADD1266B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQWOM-0008Lz-Ku; Tue, 02 Dec 2025 14:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vQWOJ-0008KC-Qb
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vQWOH-0005c2-Dx
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764705023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bwjVE6iHopEY0A4ZakmHTrRo7/mVn3KaUNm34cRn34M=;
 b=FYfJVa3NMCeR6y9hBflgDzSxMD72jo1q2w+nW/NUy7od8wgvzg9pcML4RFWb/lrIRxWxE0
 7xhJxeK5QUcLYHio3h3eZeYA8zyXJZ2+wVhAoGSbfzwuaSnpNmAr49F9asf44q0MIp1kL/
 md0lupO9Ade1LfpFq68BNCXLAIix8no=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-tK98RmvMMXGDVxDTdXxOBw-1; Tue, 02 Dec 2025 14:50:21 -0500
X-MC-Unique: tK98RmvMMXGDVxDTdXxOBw-1
X-Mimecast-MFC-AGG-ID: tK98RmvMMXGDVxDTdXxOBw_1764705020
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso43492315e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764705020; x=1765309820; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwjVE6iHopEY0A4ZakmHTrRo7/mVn3KaUNm34cRn34M=;
 b=DGXUfwuGy6H3SL25Idof8wEcDKuzw+61TVhbrOSON1KHUTYpx+zbwSyld2SSdGaMLm
 VFvKkJK40L+zJdteLKg6uJ7Y7ZgIve4MtVYnnQF5FBT44Emcc9338urd8wUSJda9OcJ5
 U75HprT6EDN4CF6w9TPA+ey5vSKGBnJvSIdVx7WyytddvpHHn/eXZXpfO226xIsRkgYI
 tBMhkGMtf/K+Sr2CoYekjUBK1iclpXudSFt+U9ETQkpYK376R5Tg1t3Y5v1eV90QTE2y
 gn6q+mKyeRhhv8CyNrMScm1UuWi9K9wDnqozreH8+f7TjCJ/h+Iovvbev4GDokFuecFe
 lVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705020; x=1765309820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwjVE6iHopEY0A4ZakmHTrRo7/mVn3KaUNm34cRn34M=;
 b=Hh1HnqBEOtYjCSm49hhPSChgK7eYTEZXvz8dW7MlF8g2Ed0qUcV4/rdYgEe4kM/cdk
 4EwikK+aMHbfecDxxtjqG2RJVU+tdJp06Mldwyya6Gg6MoR8SWW5U105weOl+7kTw2sv
 mYSZECHH/J3aDMhHOKNSUKgaoFSGFcGhihhVFLbBP51cv9bJTMxAQHuTmPxef/Zi0/oN
 B7mSYY2zhziEUtHxoHQ48zVdzSU/X4VC4iUnLnPd7oE2/KI02anrjnTiRISkfdyeMy2Y
 Z8HBUVph2qX3wtu0Ym/3jPPV48TrDubgHCDnFg+ZfBGDjcidb3xd+KFt12gLPWJa2Mn/
 HcTA==
X-Gm-Message-State: AOJu0YyOm+kwq9o64OXdv6ENzV9+kAJtqV7gslVn6P2GDAPKcQOYO0QH
 75m9yHcEJUXqO1SKFhxTngQeldHRD3IouNG0grD/t0SDtpICSnb8FAxFIkjAq2TP6pxAMb7HoaM
 1eEx9irnIz3GE/867h9lmQzQL9u2K8nb7pWw0dfuZ2ZJKRgJREwhN46Lh
X-Gm-Gg: ASbGncvQctRT1V5+K3zKS2xYXMzgWcS3V1nDFXOGd5cAEVfqVWX81meTQXII2Wv1lmj
 9bNpQixVvxt2TCDq/dtfl2Zrh9qLP67sqGC/xdHdRz62U1+aOy6+HvIFINb5ETHFk51BLOeNrLx
 vsvJ8Ib3Ok+XY5LE5hmVThbAyXGyWbiYGKxJTKBUC4N9iy2eAkcLEtNyvoGIiZTW12kSecXnP+v
 cNAkn9zkcoK9UacMWhKndib3PGTbfeT0TYfSDoif3wQ6rUsQSymygMXfcKik75FZRGpKzKWoLUf
 csHjC3ycWrW+sIFg/re3ofdElc6Ml+SNUVSwc4lKuHr907mr0brsrptPL5mROr60oSqw8KHz6p+
 vlHqtXKqtFAYeGshM3DWbZf4DmltTiaH/
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47904b2c2c5mr358930385e9.33.1764705020206; 
 Tue, 02 Dec 2025 11:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH54XkNE0a3SodqkM24NRkNojkdVxBe8l6lR1kXq4lZzXZO3RQfI548fq53VcSt3RzbuaewCA==
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47904b2c2c5mr358930105e9.33.1764705019736; 
 Tue, 02 Dec 2025 11:50:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a5bcf08sm3961075e9.7.2025.12.02.11.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 11:50:18 -0800 (PST)
Date: Tue, 2 Dec 2025 14:50:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com,
 manos.pitsidianakis@linaro.org, slp@redhat.com, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v11 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20251202144821-mutt-send-email-mst@kernel.org>
References: <20251111091058.879669-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111091058.879669-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 11, 2025 at 10:10:51AM +0100, Albert Esteve wrote:
> Hi all,
> 
> v10->v11
> - Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
>   and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
> - Mention mapping cleanup on device reset in the spec.
> v9->v10
> - Fix transaction_commit invoked without transaction_begin
>   on vhost_user_backend_handle_shmem_map() early errors
> - Removed fd tracking on VirtioSharedMemoryMapping, it
>   is handled by the RAMBlock
> - Reject invalid BAR configurations when VIRTIO Shared Memory
>   Regions are in use by vhost-user-test-device
> v8->v9
> - Fixed vhost-user new handlers to ensure that they always
>   reply
> - Made MMAP request flags field u64 everywhere
> - Fixed double memory_region_del_subregion() on UNMAP
> - Add mappings cleaning on virtio_reset()
> - Some small typos and fixes
> - Fixed virtio pci bar mapping for vhost-user-test-device
> v7->v8
> - Unified VhostUserShmemObject and VirtioSharedMemoryMapping
> - Refined shmem_obj lifecycle by transferring ownership
> - Other small improvements
> 
> This patch series implements dynamic fd-backed memory mapping support
> for vhost-user backends, enabling backends to dynamically request memory
> mappings and unmappings during runtime through the new
> VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
> 
> This feature benefits various VIRTIO devices that require dynamic shared
> memory management, including virtiofs (for DAX mappings), virtio-gpu
> (for resource sharing), and the recently standardized virtio-media.
> 
> The implementation introduces a QOM-based architecture for managing
> shared memory lifecycle:
> 
> - VirtioSharedMemoryMapping: an intermediate object that manages
>   individual memory mappings by acting as generic container for regions
>   declared in any vhost-user device type
> - Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
>   with the frontend creating MemoryRegions from the provided file
>   descriptors and adding them as subregions
> 
> When a SHMEM_MAP request is received, the frontend:
> 1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
> 2. Maps the provided fd with memory_region_init_ram_from_fd()
> 3. Creates a MemoryRegion backed by the mapped memory
> 4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
> 
> The QOM reference counting ensures automatic cleanup when mappings are
> removed or the device is destroyed.
> 
> This patch also includes:
> - VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
>   vhost-user devices to query shared memory configuration from backends
>   at device initialization, enabling the generic vhost-user-device
>   frontend to work with any backend regardless of specific shared memory
>   requirements.

Looks good, we are in freeze so will merge after 10.2.
If it's not too much trouble, pls ping me after the release
to help make sure it's not forgotten.


> The implementation has been tested with rust-vmm based backends.
> 
> Albert Esteve (7):
>   vhost-user: Add VirtIO Shared Memory map request
>   vhost_user.rst: Align VhostUserMsg excerpt members
>   vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>   vhost_user: Add frontend get_shmem_config command
>   vhost_user.rst: Add GET_SHMEM_CONFIG message
>   qmp: add shmem feature map
>   vhost-user-device: Add shared memory BAR
> 
>  docs/interop/vhost-user.rst               | 102 ++++++++
>  hw/virtio/vhost-user-base.c               |  47 +++-
>  hw/virtio/vhost-user-test-device-pci.c    |  39 +++-
>  hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
>  hw/virtio/virtio-qmp.c                    |   3 +
>  hw/virtio/virtio.c                        | 199 ++++++++++++++++
>  include/hw/virtio/vhost-backend.h         |  10 +
>  include/hw/virtio/vhost-user.h            |   1 +
>  include/hw/virtio/virtio.h                | 137 +++++++++++
>  subprojects/libvhost-user/libvhost-user.c |  70 ++++++
>  subprojects/libvhost-user/libvhost-user.h |  54 +++++
>  11 files changed, 926 insertions(+), 5 deletions(-)
> 
> -- 
> 2.49.0


