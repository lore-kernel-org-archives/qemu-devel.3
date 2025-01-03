Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909F5E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 20:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tToCA-0007ph-Fw; Fri, 03 Jan 2025 15:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tToC9-0007pH-4i
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tToC6-0006mZ-UD
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 15:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735935773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BndSMCn6ywMaUythDoaJmMsbmuf7sn8y4fBk5UNVXZo=;
 b=P2iMgBhJqsjtojm5di00xg3LYqRqRbRsi8I3KyLDex4lrtPe4ovvBabKJRlK8J4BoueqU7
 l2lPR6Pm/5nKE+tRjQOa/geKOa4VlhxxMAQAiGlp5kA31sX7e+vtHBtOM6EuLa5wfmPOrd
 kWfmv+6G5pQQiZ6noFDuTz00zt3hW5w=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-SbDJFRJdMp6vt5VWFIIkpw-1; Fri, 03 Jan 2025 15:22:50 -0500
X-MC-Unique: SbDJFRJdMp6vt5VWFIIkpw-1
X-Mimecast-MFC-AGG-ID: SbDJFRJdMp6vt5VWFIIkpw
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844e20873f6so22414739f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 12:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735935769; x=1736540569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BndSMCn6ywMaUythDoaJmMsbmuf7sn8y4fBk5UNVXZo=;
 b=Sk2GIwymrvaIKUfTSb/VvPJYqcQzRPxqKDJxjFVlIwmRzIGElnDiqr/ibFURsX3ptZ
 xgixqBk3YNJclhOVdMUMN45hSBhyQrwbR4Y8cfd/Pj1n4HXnw/UPl+bXZF5kLv/9vZqY
 MCZlW+zhSBToV+LFOpkv4cx5/EI6OvZtGCGOthbuiJZW7QeBVNjeOfVpsJ9fQBQxKemq
 Y5iRcg6L1cdjpiEJadDltdxak43HeS+OxmRn+pEJGhJkArB3B1UgPaRSZNaSIiBTtQXJ
 CYPXcISmKEHRIVD2IqCvHkqZl4sGGqX1kGJpBjGtMAJD2omA37rXkuBPz/I1niekkGbB
 VEXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu9bIsyw6Cr/47K6aFouDTtQo4Uamy5P/IKucv14N5eZ1Z4dBMPqROAR1g+RhcefrCtdTihMLabqi9@nongnu.org
X-Gm-Message-State: AOJu0Yx8kqBhWw+4tHvUB3ZPbAPbRY3phDtf2lJyKxTl1+COcappn3yo
 OYGXWvggJvDiBMApqplA0lKn2/WhQcMU7PjOPltrPOM8ytFMw3W6e+1HEcjCqeUoBmYQc7kJdDQ
 +5GXKaPjtzCfTnzgfUINCBVJeMj/8y0sQ+4L5yFbA7Vn8x2/xBkBu
X-Gm-Gg: ASbGnctQPwac+p9RCfcZdXnEgMxecjO4f4ndB1RH7UQf1Oz1upYHMu9xgzOAI0AvaHA
 +7mKkDzkU46D7YhlGtQhvX4cA4LTqTtkInPqWqA1MLg53UASdQmhxZEeVwLVp60MSQSU+DvrWFx
 AcxLB29/7qN3GCMLkc9t+GI5M6OtF05Wox8RfXKL2CP2gv/sNESs6Y4zosqhSON899jq5uns3wH
 roATzxs/Lbj7vTztOxHvKjxzicZjojC+gqxm0pLa0h6nDb3qDStDvWCJMgL
X-Received: by 2002:a05:6e02:20e9:b0:3a7:bc95:bae6 with SMTP id
 e9e14a558f8ab-3c2d4b89d00mr125146885ab.3.1735935769692; 
 Fri, 03 Jan 2025 12:22:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT36V1Pxsx6SUPkQsCBeNJI2y2hXaWXRYGGpgQuHMsDZLeLydR4aPJ/T40ow0pnskHsigs9w==
X-Received: by 2002:a05:6e02:20e9:b0:3a7:bc95:bae6 with SMTP id
 e9e14a558f8ab-3c2d4b89d00mr125146835ab.3.1735935769355; 
 Fri, 03 Jan 2025 12:22:49 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0dfb32043sm83102775ab.40.2025.01.03.12.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 12:22:48 -0800 (PST)
Date: Fri, 3 Jan 2025 13:22:47 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] vfio/pci: introduce config_offset field in
 VFIOConfigMirrorQuirk
Message-ID: <20250103132247.2719e3c8.alex.williamson@redhat.com>
In-Reply-To: <20241231151953.59992-3-tomitamoeko@gmail.com>
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
 <20241231151953.59992-3-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 31 Dec 2024 23:19:52 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Device may only expose a specific portion of PCI config space through a
> region in a BAR, such behavior is seen in igd GGC and BDSM mirrors in
> BAR0. To handle these, config_offset is introduced to allow mirroring
> arbitrary region in PCI config space.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/pci-quirks.c | 5 +++++
>  hw/vfio/pci-quirks.h | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index bb2ce1d904..5a0b25a544 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -162,6 +162,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
>      (void)vfio_region_read(&vdev->bars[mirror->bar].region,
>                             addr + mirror->offset, size);
>  
> +    addr += mirror->config_offset;
>      data = vfio_pci_read_config(&vdev->pdev, addr, size);
>      trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
>                                           memory_region_name(mirror->mem),
> @@ -175,6 +176,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
>      VFIOConfigMirrorQuirk *mirror = opaque;
>      VFIOPCIDevice *vdev = mirror->vdev;
>  
> +    addr += mirror->config_offset;
>      vfio_pci_write_config(&vdev->pdev, addr, data, size);
>      trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
>                                            memory_region_name(mirror->mem),
> @@ -456,6 +458,7 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>      mirror->mem = quirk->mem;
>      mirror->vdev = vdev;
>      mirror->offset = 0x4000;
> +    mirror->config_offset = 0;

These are all allocated with g_malloc0(), we don't need to explicitly
initialize this field in any of these existing uses.  Thanks,

Alex

>      mirror->bar = nr;
>  
>      memory_region_init_io(mirror->mem, OBJECT(vdev),
> @@ -908,6 +911,7 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      mirror->mem = quirk->mem;
>      mirror->vdev = vdev;
>      mirror->offset = 0x88000;
> +    mirror->config_offset = 0;
>      mirror->bar = nr;
>      last = (LastDataSet *)&mirror->data;
>      last->quirk = quirk;
> @@ -929,6 +933,7 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>          mirror->mem = quirk->mem;
>          mirror->vdev = vdev;
>          mirror->offset = 0x1800;
> +        mirror->config_offset = 0;
>          mirror->bar = nr;
>          last = (LastDataSet *)&mirror->data;
>          last->quirk = quirk;
> diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
> index c0e96a01cc..d1532e379b 100644
> --- a/hw/vfio/pci-quirks.h
> +++ b/hw/vfio/pci-quirks.h
> @@ -60,7 +60,8 @@ extern const MemoryRegionOps vfio_generic_window_data_quirk;
>   */
>  typedef struct VFIOConfigMirrorQuirk {
>      struct VFIOPCIDevice *vdev;
> -    uint32_t offset;
> +    uint32_t offset; /* Offset in BAR */
> +    uint32_t config_offset; /* Offset in PCI config space */
>      uint8_t bar;
>      MemoryRegion *mem;
>      uint8_t data[];


