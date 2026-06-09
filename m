Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E102CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvGt-0004JZ-I5; Tue, 09 Jun 2026 08:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWvGp-0004J0-UC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWvGn-0000RK-VA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781006962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NakbWxM89QyZ8ftIXZuyAVP9kTN9EeYcRwvO9yw2Jg0=;
 b=K7/0hWLWnzNN7nHlm0it76zPqZ2ennsBTjMSZGfMpC8RvAsBOb+XB3soA3ZUgBM64IkD+0
 NKiiMjKS+oo11iefZLu1Ku6rZM3cqHmzZSdF+Bw8RykCpvE+8ZeQ5WTsoKJYoI+y6xeiy9
 DrTfLpNS6HzpzhLP/KPVM2y4Jn4GYic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-32f1uUPtMfW1VERV_eazjA-1; Tue, 09 Jun 2026 08:09:19 -0400
X-MC-Unique: 32f1uUPtMfW1VERV_eazjA-1
X-Mimecast-MFC-AGG-ID: 32f1uUPtMfW1VERV_eazjA_1781006959
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so3463269f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781006958; x=1781611758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NakbWxM89QyZ8ftIXZuyAVP9kTN9EeYcRwvO9yw2Jg0=;
 b=BdKQtRKhsvvmk+/bcrUw/PBoReofLrIf8OzYzQ6aguCnwpSjC+PO1rWT6I+qHBkc2z
 IzxQdxff3OHCTWt+XPOyMo4dNi6MNawihO6dBXDn7nwrFany9hP3G6fGpVwpuKc57LKv
 c91+k1c4kZIh3xHllf0IwnxIq7iSZQiKjIai4ZlsYhWrCKBjIObsOOXk05CSz9h9Zxs8
 VOoWD/FWxL8gi4a0UJvf8QoMm/4TWBvFV31JaUKSMWXvvD092Tlr3l75ztk/eDkpC1pd
 on5gwzzVHNXUKMKMMryz4i3MYOY/a/cjHNUnCnB1QImKPceSOaUXPFJezKbK1a9GsCnj
 U6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781006958; x=1781611758;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NakbWxM89QyZ8ftIXZuyAVP9kTN9EeYcRwvO9yw2Jg0=;
 b=Oqo0w5x+Jhs8FihYzFDwHdKbnXAyU9BPwPDQNZQv8dmUUEVM2DIV1kJCc9OnL/LrCY
 MDL4ih79RmJzJtjlqlyksVrABQS+NpkHpfPcq6rk6wnYPwc/QgctBuaaQNdLZW5hDMoE
 SH9Ga4DT31Ea6X/J8MBmevvhldwkfRMK9mF2QspgyBuWAjTA6TfVkwfXrfg/yuDzadaP
 dc4hAlLolfJrJCUnow5J90XsTwFOtpAkF5KQ9IYZMVuDbH+1qphUDLXdPE5sJB9ExaKk
 i8ATSP/FaFKOnrrF+7OsrTRPhbDz3Os9C1rzpUNfVuiM//r7Xp7HShwTNbjhX+8EabKI
 jKQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PGD2iUqtPcFaa7+ub4K+A+nM88zHdSfAPIIRdFI2zPtL0YpJhMAopA/yjldxltV97X8FEgjk0m2+6@nongnu.org
X-Gm-Message-State: AOJu0YwLsyn8V8DKKGxdwGB6cvS5og43IaXJ7lyyRyned/H314ga/QIB
 hzSA6t35OIk8JNUWYbWD6iOu5tGv3vWU/8l0Q87jpKIhFHmKbIE8SkbTgfr2P2b1zFBB2LeI4a2
 EP5SvXb6aSS6rkczVMRpCiRerLkakMy4hCAZN4qdlksc6/FiWFdsh0yAP
X-Gm-Gg: Acq92OH5CFzizS7oC1DOqyvdt1axeDn/sU8FqASYm75erpoXO8JKikbmq48ZN7LYREd
 BUoDeQqK9bfTmZdcMu1TURmRbxz/6s3Fq8C4x/swClbIcqqNn9q2TAx7AktC4mtCADEvDzWSmFy
 naV3evym5aH6QCawfybosA9fUwiau3lnqWBLbIzIYaVJdBbzD+dSB4911Udl9P/LmF2N6NVvleN
 AtlwpkavQi8VCJMfJa8rjcRMvz4QRsy/wG4pMN9qAok8Syso0cI0yAlF4wE34rjRcYsumAgRCJz
 c7gTkGHIOURnVfPZOVaEXBZ9AmPYemCH7QvJU1HeRianUqjiWdWuoD+rbUcZ1mrUmP0+0t9M07k
 p/pjYKap3D4SoWkr1CJvXiZpeWqst1wKq6fk9Pq9/B4/0nVsp2+v4EjZoX0CQF5SXPoalUh4=
X-Received: by 2002:a05:6000:468d:b0:45e:6518:3299 with SMTP id
 ffacd0b85a97d-460302dbd32mr21454936f8f.5.1781006958553; 
 Tue, 09 Jun 2026 05:09:18 -0700 (PDT)
X-Received: by 2002:a05:6000:468d:b0:45e:6518:3299 with SMTP id
 ffacd0b85a97d-460302dbd32mr21454903f8f.5.1781006958065; 
 Tue, 09 Jun 2026 05:09:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm109946594f8f.27.2026.06.09.05.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:09:17 -0700 (PDT)
Message-ID: <cef321ac-d3cc-4809-b9b3-0e1b87575cb0@redhat.com>
Date: Tue, 9 Jun 2026 14:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-11-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260609075812.32067-11-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/9/26 09:58, Avihai Horon wrote:
> vfio_migration_init() already has many failure points and a new one will
> be added in next patch.
> 
> Add Error ** parameter to vfio_migration_init() to report a detailed
> error message through it. Refactor it to return bool as well.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 45f8e346b4..3ab6b7248f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1056,7 +1056,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>   }
>   
> -static int vfio_migration_init(VFIODevice *vbasedev)
> +static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>       Object *obj;
> @@ -1067,22 +1067,32 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       VMChangeStateHandler *prepare_cb;
>   
>       if (!vbasedev->ops->vfio_get_object) {
> -        return -EINVAL;
> +        error_setg(errp, "no vfio_get_object handler");
> +        return false;
>       }
>   
>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>       if (!obj) {
> -        return -EINVAL;
> +        error_setg(errp, "failed to get object");
> +        return false;
>       }
>   
>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>       if (ret) {
> -        return ret;
> +        if (ret == -ENOTTY) {
> +            error_setg_errno(errp, -ret,
> +                             "migration is not supported in kernel");
> +        } else {
> +            error_setg_errno(errp, -ret, "failed to query migration flags");
> +        }
> +
> +        return false;
>       }
>   
>       /* Basic migration functionality must be supported */
>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
> -        return -EOPNOTSUPP;
> +        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
> +        return false;
>       }
>   
>       vbasedev->migration = g_new0(VFIOMigration, 1);
> @@ -1113,7 +1123,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       migration_add_notifier(&migration->migration_state,
>                              vfio_migration_state_notifier);
>   
> -    return 0;
> +    return true;
>   }
>   
>   static Error *multiple_devices_migration_blocker;
> @@ -1279,18 +1289,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    ret = vfio_migration_init(vbasedev);
> -    if (ret) {
> -        if (ret == -ENOTTY) {
> -            error_setg(&err, "%s: VFIO migration is not supported in kernel",
> -                       vbasedev->name);
> -        } else {
> -            error_setg(&err,
> -                       "%s: Migration couldn't be initialized for VFIO device, "
> -                       "err: %d (%s)",
> -                       vbasedev->name, ret, strerror(-ret));
> -        }
> -
> +    if (!vfio_migration_init(vbasedev, &err)) {
> +        error_prepend(&err, "%s: VFIO migration init failed: ", vbasedev->name);
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


