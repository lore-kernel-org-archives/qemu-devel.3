Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C76FC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBySm-0007M8-LR; Mon, 05 May 2025 12:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uBySW-0007Iz-DG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uByST-0005x8-QY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746461656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRj8vIahj24I+TAmXNQO246qvWAwwzLtdwkAciwCGi8=;
 b=hwzxsIbRzfGI/KXSW0gY1rQNJ+W7RHOQA+Se6ij7SV4CQT8ewD6IKzqd4fo2tf2GkjyT5s
 x2cGC+oMORkepU5phkBdvgi15cCglDI5QeosUKFQ9/R2K3Tx/X0sqjq5vxSOO1QB8mizO+
 f51HpL0MGL4bcq7ZMWL5/VenkHbLs2o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-uRA85iUHMMSjYv60GXyF-g-1; Mon, 05 May 2025 12:14:15 -0400
X-MC-Unique: uRA85iUHMMSjYv60GXyF-g-1
X-Mimecast-MFC-AGG-ID: uRA85iUHMMSjYv60GXyF-g_1746461655
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85b5c68c390so32758239f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461655; x=1747066455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRj8vIahj24I+TAmXNQO246qvWAwwzLtdwkAciwCGi8=;
 b=ttCyLRzA3JsMZdgKJ0gmMK+pjLfNOsUAsSPQlERbe54bTjeauRMduBLgmrdhogiGxJ
 3ot/PHtRMd5/hQrd+I3BbP7denk21d9eAm9gtzSXui4q3cl/8jPfumyYIqqpRnVKsnzZ
 gKAobJJPC7geHjKtF6XlciXRTmVAJvkZBgTMmnpxi3o7GSfkB+rS2EClebZ8XuQLA+ng
 Y4Pd1upjTrtzoinFrEgxAxANToXaGQqi5M4bBNOnekkCfrFSW5FBG+Ep1J1JzM39uVoN
 GCmVmKY78j2E9hn13KnBghdiEPVJGvnZly50ya5V8lG7G/v1Ptg2Hc/R0Mei7mCZu7md
 CMuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcmcjClpTIJEXJtbNhpuwEx+Mc31tVMqxt47NqkI6wb7u9CpRecCv95k3mV3ESEfVgnsXue0g+sHce@nongnu.org
X-Gm-Message-State: AOJu0Yx3wcRIR/djNWox6hhV2HSGmN9gz8kjhvzNMo5c9hWBrWGKujra
 PYXHgY0CyZIITxIqnr35Bpkw2vpzIPMnPcYKbjdmxt22c05Ubjpz5aQOotpxp00haGGKgJrkHnG
 GIn0Da7vLeWDVhg1qTPQqOXUnqXFc/OyxtwzQOdYuohxQFDD7wUJR
X-Gm-Gg: ASbGncvHklddm8x4E73rTPlCsKiWiULfjden/h4WXzZU6/CmUJrkuBrWijnWjt3v/Tf
 41PnfgRCUEZMw3eiZ2Pi8iFdXTX2xjbdDVNvq+NIjh/7uHCeLVAGZPHwWcba5zWac7w94na50/q
 6ippUqitE7owlZfF2XfllNMiH2J1TMc0ixtf+pnuo+T8IL0sV2fuUqbSHg5UCGj/LbDpQZ5Y7sf
 UgzQV31ZTUexWXWB8F/++ECtETxjiwCADYiiEHs9sZBHPV+xElFAY8+hkFfcH3v19AEILbuj9pq
 5u9TpHtPRVN55CI=
X-Received: by 2002:a05:6e02:2292:b0:3d4:6d6f:6e1f with SMTP id
 e9e14a558f8ab-3d97c25e579mr34387625ab.6.1746461654848; 
 Mon, 05 May 2025 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAHhVqRDKyF3cbnLeTIleE2Cj6mTAlVd/sPxSDFJbJNuHXgRPt4T+ZZ7lR9/4y/LTD+mwbpQ==
X-Received: by 2002:a05:6e02:2292:b0:3d4:6d6f:6e1f with SMTP id
 e9e14a558f8ab-3d97c25e579mr34387505ab.6.1746461654486; 
 Mon, 05 May 2025 09:14:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa58ec3sm1790355173.94.2025.05.05.09.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:14:13 -0700 (PDT)
Date: Mon, 5 May 2025 10:14:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH 0/9] vfio/igd: Detect IGD by OpRegion and enable
 OpRegion automatically
Message-ID: <20250505101411.00d1a202.alex.williamson@redhat.com>
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 29 Apr 2025 00:09:55 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> As proposed in a previous discussion [1], detect IGD devices based on
> whether it has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION exposed by kernel
> and enables OpRegion access by default. This enables out-of-the-box
> display output support for IGD passthrough without having to manually
> set x-igd-opregion=on, which probably saves effort for libvirt users.
> 
> This patchset also limits legacy mode to Gen6-9 devices, as Intel no
> longer provides CSM support and VBIOS on newer IGD, and Seabios does not
> support setting up the 64 bit BDSM register on Gen 11+ devices. Exposing
> VGA ranges to guests by default on platforms without VGA mode support is
> undesirable.
> 
> Additionally, as we enables OpRegion on IGD devices by default, and
> Intel removes the BDSM register from Meteor Lake [2]. There seems to be
> no extra register quirks rather than OpRegion required on newer devices.
> To support them (and probably future devices), the generation limit is
> removed, with BDSM quirk only applied to known Gen 6-12 devices. 
> 
> Note: I have not been able to test this on Meteor Lake or newer
> platforms due to lack of hardware.
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com
> [2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
> 
> Changelog:
> v2:
> * Removed "Allow hotplugging with OpRegion enabled", hotplugging is
>   always forbidden.
> * Test device is not hotplugged and get opregion in a single function.
> * Update documentation along with code changes.
> * Minor code style fixes.
> Link: https://lore.kernel.org/qemu-devel/20250421163112.21316-1-tomitamoeko@gmail.coms
> 
> Tomita Moeko (9):
>   vfio/igd: Restrict legacy mode to Gen6-9 devices
>   vfio/igd: Always emulate ASLS (OpRegion) register
>   vfio/igd: Detect IGD device by OpRegion
>   vfio/igd: Check vendor and device ID on GVT-g mdev
>   vfio/igd: Check OpRegion support on GVT-g mdev
>   vfio/igd: Enable OpRegion by default
>   vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
>   vfio/igd: Only emulate GGC register when x-igd-gms is set
>   vfio/igd: Remove generation limitation for IGD passthrough
> 
>  docs/igd-assign.txt |  11 ++-
>  hw/vfio/igd.c       | 218 ++++++++++++++++++++++++++------------------
>  hw/vfio/pci.c       |   2 +-
>  3 files changed, 137 insertions(+), 94 deletions(-)
> 

Looks ok to me, my Kaby Lake GVT-g and GVT-d configs still work.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>


