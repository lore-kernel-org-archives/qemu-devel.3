Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A432C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXec-00022k-Eu; Thu, 27 Feb 2025 01:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXeX-0001yl-Km
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXeU-0003lx-IN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740638744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=skW8PkxaLzlBr7+XwTf8oEhUdmDWk+xAFZFHn8OJd3A=;
 b=Coq9129f6CB/M3MLPPkAt4CWTyXVRiy/ZP0p44roKpK+F9OKyCyws8G/bSl09eqmI3848U
 h8BmmBcYFLcxwFo+Xj1/XSiHmb//LqArOuQ6qWVXzloZyEckwlxLMwtDbBQDijcngodscm
 zBxygt3wRKhZ0kBn+rYNgqTnF2uVCP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-uOIhXTpAPp2dbRdDVl4_sQ-1; Thu, 27 Feb 2025 01:45:42 -0500
X-MC-Unique: uOIhXTpAPp2dbRdDVl4_sQ-1
X-Mimecast-MFC-AGG-ID: uOIhXTpAPp2dbRdDVl4_sQ_1740638741
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso536825f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 22:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740638741; x=1741243541;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skW8PkxaLzlBr7+XwTf8oEhUdmDWk+xAFZFHn8OJd3A=;
 b=k95YuCcZKQgJ+nP+Vl3avG/RpoT9ynKVuMQDUUdr3mUhei157PnGrDb4Sk9W7RBnDg
 D2yZBLxEUXDbtYMoZnlRYWgEBLgq2O0FuRZw8DKNdp5kc0UiqhDLx7yvJEIRKYB+we8f
 9eCHNDpkPutZQ63wCSrhpyfDdy3O0OaWZ8L6ENBaXvHyJGHxp05v+dtdM9IYrEh8kRBa
 F4BIcXYqJ7+CJjc/Ts1sbF6/jA3x67ihZKaKahO8VPhPy6lQ0IoX4BNRwg5B6fnb1cNa
 wT0RzKSQ8y3VymR6EBopEHb5UeXRTs6x2etkjsHTVaII+2e4sivlBS+XRoq+kBlCpysI
 IOUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNN8i6yh/UZ/ueo77fNL1HcQDbkVUOIRke7v+K0JZpQPoiG2/yJwBLGsKEPV6sROudpoIRsARTZsIB@nongnu.org
X-Gm-Message-State: AOJu0YxdytgBlyEIJkp8G+IC9hAUYBWEAhy5KPuG3JWCCQX/iU2X4mHX
 VwvRz8znYKPpIcHlskZRIABtMxrUvpV/S+PoXcj8zgNuUagIORzE2YkMc44uxOJ/jyZbVPQ5fbs
 dNx+zd8+aEzhHiW9z4TOjGHFCfETJ6fp7Njvvgn0eacG1e2xLKcHl
X-Gm-Gg: ASbGnctQ3kUDXDuNyLBOKCAIe6lESqWMBETMV85s3w0BdPAf3ALSudnBz8mdIAY7mlk
 IlUS4iB6qI1akrmCZOfhBpGT1M/B+DUsk0PIMys1oeYVph7/sVpj9pRMG9V34E9cIKHC92bqev7
 Sn8dHBLuOP4kdvbQK4CveiXM0fZZ3DhldAKOR79qeRfyUF79bE2nSVHgTL9+rlGuEqi5CScBpPI
 bnPWQV8zvcfKWelbPgULh4aOrRON2fdAQqBwRavLfCiHkYC8C1md0VLbhG0AkdfJfgP6NGBYWqw
 BVNqELy95AEZiZk3VhbhBKtzhjy3zTEYofwHXtdta47Fjtd1ONCSlC+N53A=
X-Received: by 2002:a5d:59a9:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-390cc5f57b8mr10348151f8f.9.1740638741188; 
 Wed, 26 Feb 2025 22:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUQKeJT8k6RHXjC+Y7LI+5r3PzjSZLN/F0M1zs0xCLsyJ2LUOF4BB+15GACUwxZ9YAIor6Pg==
X-Received: by 2002:a5d:59a9:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-390cc5f57b8mr10348134f8f.9.1740638740826; 
 Wed, 26 Feb 2025 22:45:40 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485df5asm1022564f8f.96.2025.02.26.22.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 22:45:39 -0800 (PST)
Message-ID: <d03dae83-657c-44e7-a0ef-672d399d4ad2@redhat.com>
Date: Thu, 27 Feb 2025 07:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/36] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <8f38087567dfc898fb0f1688be0689dd1dacfa22.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8f38087567dfc898fb0f1688be0689dd1dacfa22.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring at runtime whether to transfer the
> particular device state via multifd channels when live migrating that
> device.
> 
> It defaults to AUTO, which means that VFIO device state transfer via
> multifd channels is attempted in configurations that otherwise support it.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 17 ++++++++++++++++-
>   hw/vfio/pci.c                 |  3 +++
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 0cfa9d31732a..18a5ff964a37 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -460,11 +460,26 @@ bool vfio_multifd_transfer_supported(void)
>   
>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>   {
> -    return false;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->multifd_transfer;
>   }
>   
>   bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>   {
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }
> +
>       if (vfio_multifd_transfer_enabled(vbasedev) &&
>           !vfio_multifd_transfer_supported()) {
>           error_setg(errp,
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 89d900e9cf0c..184ff882f9d1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
> +                            vbasedev.migration_multifd_transfer,
> +                            ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),

Please add property documentation in vfio_pci_dev_class_init()


Thanks,

C.



> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ba851917f9fc..3006931accf6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -91,6 +91,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       VFIOMultifd *multifd;
>       bool initial_data_sent;
>   
> @@ -153,6 +154,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 


