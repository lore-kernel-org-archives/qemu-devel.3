Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F4E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 21:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNIs6-0008Em-Vg; Mon, 16 Dec 2024 16:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNIs4-0008EZ-5j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 16:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tNIrz-0004sL-2h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 16:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734385392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1x1J4PDIjkB8swmGz2i4LthrTaB3+4755Bvkibt99Fg=;
 b=hIq/mdNwVxXpCem6iBpfHhLBVbGtEU8F8686AIkyB5lvy/KaxehroHTIaKx+uoV0EErpV1
 zTKUjnmo7eejJY0GjWrXaPgumXq08J5i4KpasOPBhUG1eNasc9dDaPoJu5+ZjL1wBGmfuY
 O58BlBpeaKvCNoSoBi/uh8Al4qiuKkw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-A609Vu7RMemNlv_etasgVA-1; Mon, 16 Dec 2024 16:43:11 -0500
X-MC-Unique: A609Vu7RMemNlv_etasgVA-1
X-Mimecast-MFC-AGG-ID: A609Vu7RMemNlv_etasgVA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so38269675e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 13:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734385390; x=1734990190;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1x1J4PDIjkB8swmGz2i4LthrTaB3+4755Bvkibt99Fg=;
 b=e2SXq3G6SbSxh5PITkrcAEFlFyuNwGZ5Bdynf6yDVz7loklN5Kz0dnC8LARmrIDIy+
 BahIGN2JDvC5BSnFCz4rWMFlSwyq5zX0vYYfjQLvYB5cxpYb5EJUMpt6+4hSEuXNDqq7
 aSj5uTgQfOfg4sAN/lDjPUVSx7HTLwCphqIr8cSglgpabFDWDexe2M+INAcSuu5RyEiY
 kUsc9PsOXagAfSdUIx1lazlXAXNijf9pW3opRb7cJVG89fZ2EPLSgmnaD3md8mIiMheq
 nsvRBw3L1CVT8/5xK7dUsSO4Vs840T+LFwDmZomdkySzQY1s9WzJnm37V/tjDdMYMIbi
 /Osg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKrJKC5EjKxTIR0NvXGrszktUNbnOAr0SjGkV9Q5Yav/TekN2Ae0HkP7rRedO4Dv+NT4PiSdolNz97@nongnu.org
X-Gm-Message-State: AOJu0YzQBf0dbnNRx9P8EhEYyAiiB0M0+zO+5/cujhQxZBk1crr66BqX
 ieW2sB13N/8+34YGGJ7zfwlaGC325Rb5vTCcxh/tPs+zKn1gwX14bQ9FpPWG0ONqbikv7xB4D2o
 WC85bC80bbjMjAv3V5hy6kpF/aLWPLgRYw5sMCkjIoE8HhrXgr8+w
X-Gm-Gg: ASbGncvwIsZTzLVhEcDAFJJ8h73i7+yQYeeUaC51AmqaPXoa05K7NV9BfbfcMsLO1Vr
 KJMHHNlLwXSCRrlRNewsDvmsGp+Dv5IPXqB1BdcfkwBY4JDRT7OeQz9FGvh2U8LOFTue3S70iTP
 rcuKmSNmbKbiByIuWDXTwkEuE8+EVAljNwpYQJohwPCfLoJKE/Xb9v79TUPcbQa3E8nRgGVs0Ui
 po1zQoEFWhi2s0bqqrIItCbjT1uKObClMi91nNEDDFG4CnyDWmFDkJFMYSx2ymK/sX3F989Cea/
 Frf+Unhz8W1FscOG9uo=
X-Received: by 2002:a05:600c:350c:b0:434:f297:8e78 with SMTP id
 5b1f17b1804b1-4362aa15448mr124354625e9.7.1734385389908; 
 Mon, 16 Dec 2024 13:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHmlYLwOOtgWRx0L57InA3yHrgH0FuXKPRvpV/DSRK+U7715kxQQO9niXRZcdyemCWaAOnIw==
X-Received: by 2002:a05:600c:350c:b0:434:f297:8e78 with SMTP id
 5b1f17b1804b1-4362aa15448mr124354455e9.7.1734385389521; 
 Mon, 16 Dec 2024 13:43:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm9368400f8f.71.2024.12.16.13.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 13:43:08 -0800 (PST)
Message-ID: <91039070-7a87-43ae-9bc6-adcd9a05e2f4@redhat.com>
Date: Mon, 16 Dec 2024 22:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/16/24 10:46, Avihai Horon wrote:
> Hello,
> 
> This follows up on Peter's series [1] to simplify migration status API
> to a single migration_is_running() function.
> 
> Peter's series tried to drop migration_is_device() and
> migration_is_active(), however VFIO used them to check if dirty page
> tracking has been started in order to avoid errors in log sync, so they
> couldn't simply be dropped without some preliminary cleanups.
> 
> This series handles these preliminary cleanups and eventually drops
> migration_is_device() and unexports migration_is_active().
> 
> The series has been migration tested with the following:
> - VFIO device dirty tracking.
> - Legacy VFIO iommu dirty tracking.
> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>    currently blocked, so I used a patched QEMU to allow it).
> 
> I didn't test it with iommu DPT as I don't have access to such HW.
> Cedric, I remember you said that you have such HW, it would be very
> helpful if you could test it.

Yes. I can.

I am bit busy now and I only looked quickly at the comments. I understand
from Joao that it shouldn't be too complex to change the VFIO dirty
tracking engines to use calc-dirty-rate, which I agree would useful.

How far are we from that ? We are early in the QEMU cycle and this series
looks ok, may be needs one respin. Should we merge it first ? I feel this
would be good to have before the migration cleanups and the next version
of Maciej's multifd series.


Thanks,

C.





> 
> Patch structure:
> 1-6: Refactor and clean up VFIO dirty page tracking helpers.
> 7: Refactor dirty limit code.
> 8-9: Drop/unexport migration_is_device() and migration_is_running().
> 
> Thanks.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-peterx@redhat.com/
> 
> Avihai Horon (9):
>    vfio/container: Add dirty tracking started flag
>    vfio/migration: Refactor vfio_devices_all_dirty_tracking() logic
>    vfio/migration: Refactor vfio_devices_all_running_and_mig_active()
>      logic
>    vfio/migration: Add vfio_devices_all_dirty_tracking_started() helper
>    vfio/migration: Drop vfio_dma_unmap_dirty_sync_needed()
>    vfio/migration: Rename vfio_devices_all_dirty_tracking()
>    system/dirtylimit: Don't use migration_is_active()
>    migration: Drop migration_is_device()
>    migration: Unexport migration_is_active()
> 
>   include/hw/vfio/vfio-common.h         |  4 +-
>   include/hw/vfio/vfio-container-base.h |  1 +
>   include/migration/misc.h              |  2 -
>   hw/vfio/common.c                      | 61 ++++++++++++---------------
>   hw/vfio/container-base.c              |  8 +++-
>   hw/vfio/container.c                   |  2 +-
>   migration/migration.c                 | 23 ++++------
>   system/dirtylimit.c                   |  3 +-
>   8 files changed, 48 insertions(+), 56 deletions(-)
> 


