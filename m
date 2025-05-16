Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB075C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqFS-0003Kr-0g; Fri, 16 May 2025 04:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqFR-0003KC-7W
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqFP-0003iW-Bw
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747383409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ponjZ1bMIQsWiXk7WTS/tS/PO88+ZdqZ5stNGCvbQN0=;
 b=FcNSAN/cj8biBxr0JgtPZJrTVMq3xCt2uAAYcEL/5+NJbdeF0BTZH3/c//b3mV6QgBxuzJ
 IUfPIL71raM3vGLEhL0D5yXsX57xpgCgbk91BVnRUTp8tdLGk5pYUNZhlLsbXeK5Tkd2wk
 4hJVnLX8+CHKUb48579R+AR0RBj9jSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-gNkOE35EMVOZKSHHbM7Uvg-1; Fri, 16 May 2025 04:16:47 -0400
X-MC-Unique: gNkOE35EMVOZKSHHbM7Uvg-1
X-Mimecast-MFC-AGG-ID: gNkOE35EMVOZKSHHbM7Uvg_1747383406
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0bd4b4afdso897563f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383406; x=1747988206;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ponjZ1bMIQsWiXk7WTS/tS/PO88+ZdqZ5stNGCvbQN0=;
 b=XTwDbSYmQ4YI/nrUqjtVK8lP7lKxIB8UzlwDK+8OuxO1crDZ+OUzjoREIckFu1rNkI
 s7vO3uqvkaZ1tcRNDmI8jLoToHoDQPvl5ez5U62p13kGJIntgFiZ+64FulDEOLsPcrdG
 E8vyhxXNyxuzgMW7k46GToKV6tsYSnNoBYv2AlvFje/5S0Ed3aHgQxHPfuIIaJEaBRkY
 VSwGJIWK4MUItD3t1/6vYOG7unMM1u69KIDejV7wPCuRn6gkk7uT2hHl1i4TGAF8bp4e
 NlQenItATXjdYUvLEYUsmqZC40F3hNqrfrEzR1oRWMrgr3yRnSkM7sS3UNuQJxGmVdPn
 DHJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQE2pWkQarHqleGJtrUXKDJa0WoZWGEewvOaaTHu5MqDSP+tDq0C8YyeenoGCXkH34PL7dlVyzQL4Y@nongnu.org
X-Gm-Message-State: AOJu0YwMYNoX4NRKmABk3HyWwEWMAR4c9Ioc6ucO6pQHYxuE/MBep/rG
 BPBEW0uk694PMSPLQT8vNQSle5Aaobs4KhqeOtDVE+uXekwnDpWuA5CJTAnwSf0rg9iDLBQ7mlF
 J3TasE8/ZKkhCELHvYzScUs1IQF3Ad0vofSDCKCW4OYBH9CdbqO2SQZ+K
X-Gm-Gg: ASbGncu0v5aI8Kxv/ulKQdfTeMLr5N3FZCK/UCpkheWp8Fvq3hPVJIMGnGbDK1JzVTo
 6LChUhgzD46JUj433SIMH52sB7hDsvHHQ0+shOK8sx1+PO5chkrz3UigD67GGCjMyYP47+0i7rK
 aMR5ZyVBGLPGNzjGiXMAEymbw+AK0VIptWQcaiyKnjmr2wvOkvpRMV1tG8mfo/KeQOnBzDMmqpY
 /vbwRqZjCQTCzLAOTH17tQiUNyi/jQMQe2W5qvrWPXMjMRjTSCd5pzUrQJ0+qUhqsyfyMfRC0Lb
 5scFyzimvNL5XE24JoL+p09uB2QcpJK2MQ+a8O6E4mvoAZLD8g==
X-Received: by 2002:a05:6000:188b:b0:39e:e259:91fd with SMTP id
 ffacd0b85a97d-3a35c83a529mr2687988f8f.17.1747383405954; 
 Fri, 16 May 2025 01:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQIU+1h4nPopOlQ5HRyCvZevbJhVGfoJjUIscmM+fgVkiWCHEcc1EvmRgkAPLheiVguxr1ag==
X-Received: by 2002:a05:6000:188b:b0:39e:e259:91fd with SMTP id
 ffacd0b85a97d-3a35c83a529mr2687941f8f.17.1747383405523; 
 Fri, 16 May 2025 01:16:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8d012sm2057695f8f.94.2025.05.16.01.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:16:45 -0700 (PDT)
Message-ID: <1b159c3f-92b7-44ea-8baf-14749c8ddcc8@redhat.com>
Date: Fri, 16 May 2025 10:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/42] vfio/container: mdev cpr blocker
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-12-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-12-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> During CPR, after VFIO_DMA_UNMAP_FLAG_VADDR, the vaddr is temporarily
> invalid, so mediated devices cannot be supported.  Add a blocker for them.
> This restriction will not apply to iommufd containers when CPR is added
> for them in a future patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c        | 8 ++++++++
>   include/hw/vfio/vfio-cpr.h | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 0e02726..562e3bd 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -995,6 +995,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           goto device_put_exit;
>       }
>   
> +    if (vbasedev->mdev) {
> +        error_setg(&vbasedev->cpr.mdev_blocker,
> +                   "CPR does not support vfio mdev %s", vbasedev->name);
> +        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
> +                                  MIG_MODE_CPR_TRANSFER, -1);
> +    }
> +
>       return true;
>   
>   device_put_exit:
> @@ -1012,6 +1019,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>   
>       vfio_device_unprepare(vbasedev);
>   
> +    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
>       object_unref(vbasedev->hiod);
>       vfio_device_put(vbasedev);
>       vfio_group_put(group);
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 1c4f070..0fc7ab2 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -18,6 +18,7 @@ typedef struct VFIOContainerCPR {
>   
>   typedef struct VFIODeviceCPR {
>       bool reused;
> +    Error *mdev_blocker;
>   } VFIODeviceCPR;
>   
>   struct VFIOContainer;


