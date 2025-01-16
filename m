Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBBEC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYR7B-0005eU-JN; Thu, 16 Jan 2025 09:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYR79-0005eK-VC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tYR78-0004dC-2q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737038692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lbm8ZpiJSIfk0K9r/QC6jkZD0uuOKN4cM9GExFOwd4s=;
 b=GRtHT750nA4SqG5IzoLqfJRPaVJRyChYbKVy1rB0a4gQsYZ5XHXzFp6UZ1FkKZs0dpgNfa
 1AlCgZNpLixYy6rTTGCrEGv/C8eQ0Q7F52TXT66k2N4H1b3joUqPm7nclKvHfw6VZp7mWR
 M1x+KLGBfh5MjMf31IeCZG74p1y2B1k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Lwt63Q14NcOpvQ0dzfCV6A-1; Thu, 16 Jan 2025 09:44:50 -0500
X-MC-Unique: Lwt63Q14NcOpvQ0dzfCV6A-1
X-Mimecast-MFC-AGG-ID: Lwt63Q14NcOpvQ0dzfCV6A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so4840565e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038689; x=1737643489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lbm8ZpiJSIfk0K9r/QC6jkZD0uuOKN4cM9GExFOwd4s=;
 b=MXMsvoKdZJMHYzT020oEQvpHYs5uChMQ8Xbkaf9Qd5KrEaIm6SSQGg4YvKtJF8Y9ki
 mkVooLjzs6QyijlNYL6fzVveu0nxHjiG+LcR7isFUyAcvPbAN06MG6Kq7StZ9SofOk5R
 7QZwRfYzGkFeghrQVwlhMAwhQkmwdQerWQlzCK3t3T1jvigxPl6n1TI/wKSFUwRvONBh
 tE/stCls9IyzQo4OE9c+4DGax4qlnmvj0tphIbV1g5G29elTlpaWMxv5CkYJhBOfIvhG
 FUmQkjwNtIhYPQjSwj6/lKU2tvoLzH53SeScc6PDvG7o7u1dv5KCe0UaHFakIDT9T5hy
 zdjg==
X-Gm-Message-State: AOJu0YzTVOhnUeO8YP0S4QD81JR4/dKe69FP4IkF0lsAEDWbfVA2YEku
 K13mlAbsjmhZyKT4ieB4tyNoylcmOrwPVM0Zm3xYJ8qCOlEKo2AyjpZhuKRY7zsaXBP8tsTXz4y
 4ov7smSNpDJRKF/cuzaKnuJo3hfflXZVWZqPqvmhXfkIrubkwKSsJ
X-Gm-Gg: ASbGncuBgrYby9IeKcCIXN2Q/JiHFhq/Re65vzJvYS05BFCKXLt5kvPoM9zmp0GbmS3
 DKZaYCDksWs2KAorfQ2iy+YHcg5/r8gacPmNpFd5ZkVMCQ5/1N91bFYQpYA68fS/usxrJCJ4Mz7
 uxkBRf+uiKahQhr1uCwpV/10IpCyV1BaMASsXIHYg8InnwmbuC5UEvuCB0UY5Ch4Z+vXR0a0SKq
 SJNaoT8g5WPSwMCeWQ/P/uxVX1GmvEt0fWQASpX7u8ozQ9iRteT
X-Received: by 2002:a05:600c:138f:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436e26a88d9mr323908595e9.12.1737038689160; 
 Thu, 16 Jan 2025 06:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPReRaCN2uEKXraj157hbz58a5now8P6QeL5Qgu6taSUb7/qs6LDFL9v3TrV5Di2ft6WU1tQ==
X-Received: by 2002:a05:600c:138f:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436e26a88d9mr323908115e9.12.1737038688454; 
 Thu, 16 Jan 2025 06:44:48 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fd1sm62461775e9.31.2025.01.16.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:44:47 -0800 (PST)
Date: Thu, 16 Jan 2025 09:44:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Subject: Re: [PATCH v7 0/3] hw/acpi: Add vmclock device
Message-ID: <20250116094429-mutt-send-email-mst@kernel.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116140315.2455143-1-dwmw2@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 16, 2025 at 01:59:40PM +0000, David Woodhouse wrote:
> (Posting one last time with the header commits split out).
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> The device exposes a shared memory region to guests, which can be mapped
> all the way to userspace. In the first phase, this merely advertises a
> 'disruption_marker', which indicates that the guest should throw away any
> NTP synchronization it thinks it has, and start again.
> 
> Because the region can be exposed all the way to userspace, applications
> can still use time from a fast vDSO 'system call', and check the
> disruption marker to be sure that their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, a simple ACPI device along the lines of VMGENID is perfectly
> sufficient and is compatible with what's being shipped in certain
> commercial hypervisors.
> 
> Linux guest support was merged into the 6.13-rc1 kernel:
> https://git.kernel.org/torvalds/c/205032724226



Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge.

> ---
> v7:
>  • Split update-kernel-headers.sh and the addition of the new header
>    file into separate commits, add MAINTAINERS entry.
> 
> v6:
>  • Rebase for DEFINE_PROP_END_OF_LIST removal and sysemu→system
>    rename.
> 
> v5:
>  • Trivial simplification to AML generation.
>  • Import vmclock-abi.h from Linux now the guest support is merged.
> 
> v4:
>  • Trivial checkpatch fixes and comment improvements.
> 
> v3:
>  • Add comment that vmclock-abi.h will come from the Linux kernel
>    headers once it gets merged there.
> 
> v2:
>  • Change esterror/maxerror fields to nanoseconds.
>  • Change to officially assigned AMZNC10C ACPI HID.
>  • Fix little-endian handling of fields in update.
> 
> David Woodhouse (3):
>       linux-headers: Add vmclock-abi.h
>       linux-headers: Update to Linux 6.13-rc7
>       hw/acpi: Add vmclock device
> 
>  MAINTAINERS                                  |   5 +
>  hw/acpi/Kconfig                              |   5 +
>  hw/acpi/meson.build                          |   1 +
>  hw/acpi/vmclock.c                            | 179 ++++++++++++++++++++++++++
>  hw/i386/Kconfig                              |   1 +
>  hw/i386/acpi-build.c                         |  10 +-
>  include/hw/acpi/vmclock.h                    |  34 +++++
>  include/standard-headers/linux/vmclock-abi.h | 182 +++++++++++++++++++++++++++
>  linux-headers/linux/iommufd.h                |  31 +++--
>  linux-headers/linux/stddef.h                 |  13 +-
>  scripts/update-linux-headers.sh              |   1 +
>  11 files changed, 447 insertions(+), 15 deletions(-)
> 


