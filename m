Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09EC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsGI-00082h-6w; Tue, 10 Jun 2025 02:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsGG-000823-Sq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsGF-0008UU-C6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749536102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EIB4JW9UUtIcvwYbeZvdGYjF1MD+HJ2Jlj4Nrcnilm0=;
 b=N0zgucpHqSe4ihkbrx9vCLvwBVvKI8z+zk+47Y2rTYV0PkeeUYB+WyELe4Qs9LRe9UMESQ
 nIwflUdvGGiia5+Gen2gwkKZ/HzFoYoexSKJzpb/BPbVqajmlJUuuw2i+rf46W2U1z1uEv
 MdVG2q0o6Q2064Be81N8wSkfiFlFfHw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-VnqZ6wfqOniQCDXn_SbFLA-1; Tue, 10 Jun 2025 02:14:55 -0400
X-MC-Unique: VnqZ6wfqOniQCDXn_SbFLA-1
X-Mimecast-MFC-AGG-ID: VnqZ6wfqOniQCDXn_SbFLA_1749536094
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so3266276f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749536094; x=1750140894;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIB4JW9UUtIcvwYbeZvdGYjF1MD+HJ2Jlj4Nrcnilm0=;
 b=Hsg65HtylJTvtfjk/Z9GwLZxrMqN0vrSzl3g1WofgZbXuIcZBc2k3Q+wCRr7of5jYj
 S3Z3IHouePUSAFzFrTdSTCpVn1N1e7sLCvVSu9sxxj5tW7GRcNvgCe9jwA2ZkwlbLaIn
 O1zoNh4reujFKD6bkj9rH/mmYzRO4YZKdviuT+0RFKk7DwUzWRH2Q+2M1zxS0MdrLUD3
 agg6BD8BQRwJU2k2v7PnmkuSk8xWoX5ZRbTgMG6C74Oe/dIYmVlH60YAMKyZNMYoZ+iD
 4OOenqHL/VOX7xcZG8J1rIg49E4Y0BOIaNVlXC0LVfV7dpOilxNbxbCxGknYXlmOy+LC
 GusA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwpft3WQ6awKdl/bWE3cEMi/cgcssu66M7K7DfE4RiY5cgJxxfloWD2UxFdtTUWw4XT1bYjH0HNVIy@nongnu.org
X-Gm-Message-State: AOJu0YzVDoF1+uneoc6nosZ/ODyKRngPaOF9CkRE7nLBgG2rFhVQLH/K
 wEBAD3EmRItAKouVFY5itknPyBhY+6qxjVYy22/Uz1B3Qs6rxhT/c/Q9O82RBTSxIozu/luIgxU
 Us4mAeO7NGw8ddyFKQaJzTfezakDsaTNZLdz0BLUMjhLQLeomBjFLsNV0vFVjAa/6
X-Gm-Gg: ASbGncuFj/KPSLuA4oMK+TL64Zx+L3QKTtt36RKH49yCs6EvqykQIQA8kPiFeuBPZcB
 w2WzeTIf5riYuEocBhFU8hbTVuOYEVXkCHqDHw0Z+LtfL6Xdgbeou3XrTWwYcTdMjw7f0hVqLNZ
 2X9GtGYXRYPfdTvWCCXsXXLGuDEe/UZ2Vrq8eu2EiNEwRyJOLQ/xAlsSMeb1X3yKA7ovnOeiPPC
 OP8l2Vt3CPerH6Y/22oVomL91VArIbnnD7m9cu57BcBzqx4+Pi9GgK6B4+kAFFOeMe899NGrogb
 jqntB5oMnVJUgC/I3jcwensxcjn8s2ry27bvULWawSb49u/oGRwjsIYC1W5v
X-Received: by 2002:a05:6000:290d:b0:3a4:fb7e:5fa6 with SMTP id
 ffacd0b85a97d-3a5319b6aa4mr10539727f8f.1.1749536093998; 
 Mon, 09 Jun 2025 23:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+WId0CLKl6eJwV4AbRmUcFqUiDIbIx9aIsqpP3FNz2Q83VmnPrHPD79vsjiOJiYij3+9yTA==
X-Received: by 2002:a05:6000:290d:b0:3a4:fb7e:5fa6 with SMTP id
 ffacd0b85a97d-3a5319b6aa4mr10539702f8f.1.1749536093641; 
 Mon, 09 Jun 2025 23:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464575sm11387795f8f.97.2025.06.09.23.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:14:53 -0700 (PDT)
Message-ID: <a766b316-2383-4b71-ab19-83869ffb6234@redhat.com>
Date: Tue, 10 Jun 2025 08:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 43/43] vfio/container: delete old cpr register
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-44-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-44-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/29/25 21:24, Steve Sistare wrote:
> vfio_cpr_[un]register_container is no longer used since they were
> subsumed by container type-specific registration.  Delete them.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-cpr.h |  4 ----
>   hw/vfio/cpr.c              | 13 -------------
>   2 files changed, 17 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index f88e4ba..5b6c960 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -44,10 +44,6 @@ void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>   int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>                                Error **errp);
>   
> -bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
> -                                 Error **errp);
> -void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
> -
>   bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
>                                            Error **errp);
>   void vfio_iommufd_cpr_unregister_container(
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index f5555ca..c97e467 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -29,19 +29,6 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>       return 0;
>   }
>   
> -bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
> -{
> -    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> -                                vfio_cpr_reboot_notifier,
> -                                MIG_MODE_CPR_REBOOT);
> -    return true;
> -}
> -
> -void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
> -{
> -    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
> -}
> -
>   #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>       g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>   


