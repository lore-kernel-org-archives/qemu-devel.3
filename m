Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340CEF9B602
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUK9-0004KI-58; Wed, 22 Apr 2026 05:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFUK7-0004K2-Qs
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFUK6-00063H-3F
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776851805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZnQD9U3binwSY9ZMXcH/vcnShSG25vlclm0k3rkQXZc=;
 b=N3tnmgHKcuIDfQZlM2KDVqwa5o+KcU6NbE0+SJE3MiMqMr3ZA351MmpCPTlwhF+uihfl8P
 wp/vkUh7AP/kojxAAn64P/oEl0cPBDZ7HDeHMaz//Sr5KWJNCC3g4D5e6QHpTcEPP3++k5
 tO7bCe+0SsCmM8QweNLvJKPDIwUkfL8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-JPJYQgfxNWWDGqg2_cb46w-1; Wed, 22 Apr 2026 05:56:43 -0400
X-MC-Unique: JPJYQgfxNWWDGqg2_cb46w-1
X-Mimecast-MFC-AGG-ID: JPJYQgfxNWWDGqg2_cb46w_1776851802
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo3957319f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776851802; x=1777456602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnQD9U3binwSY9ZMXcH/vcnShSG25vlclm0k3rkQXZc=;
 b=Vb7ekV/CyHmn9OIWIjBpMQQkOGW5zNMOvUKJH4ChzzB4UJS+Bnuok44rLxJi3lZSza
 f+TGiFUcqXRGBqtcONasDk5sdpaADM25xXmdssflO+ShHZIvNgVFLqJKbV4lpai2NUqQ
 8+OG9EWIUixW+iMFRGAlq0ziElqVMnLUGUDfn3jHrhZMa4PHpEmq5GPl7Pd9T8oqv0zd
 wov7jP4Ewx3tb4/nRDJVTjumtRH6t/MjieDGuYQqvPIRtV1CUGR4UaO8oL4pDheYkh+D
 r7P7GW2FVMitJeKMcBlN09q5K8qrI6g7WUEgUHx+iAc7HVpvL+vZdLJ35JN1JDaJxkiM
 UehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776851802; x=1777456602;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnQD9U3binwSY9ZMXcH/vcnShSG25vlclm0k3rkQXZc=;
 b=iqQETIAH2kOBuB4DpE8KR3/K0gLs4I4T1Au/i8XoJ5+/KVJPVDShZOEPWQGj54Pgnx
 motD1rvTuGCabEMCTTPTf1+VbUmv10grCjC3vvhQz+ksm8jAAN8JYvieShybePSeiEKk
 tK8ET6FOcPPfVRRP9sJ+8GObWPNrfitkcGpXqkx8sPclx91J5bIAusOB6OnQLbEd2Xgg
 kkxxXfJj8p16nsOB3LkaiEINz4SfgeYueHKOn6+C8vcSy3X8QtlpMem7Uef5Mbi2u27M
 VZAXIp+Kmy0ACIxAQee33FPKel+fSdQepFz8cQYmhaGgxTDE3iwEcjJMWejPm6XNK3LS
 LPfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/2FOSCmzEDuQEbcnEwmohr5MPfHHFqnrUaPzHRVlRZHB8l8G9+Ntc8kOxivMbXnnoFoGXrgZfh3L7@nongnu.org
X-Gm-Message-State: AOJu0YyXfB9QBf1E+jV6BH8uoZgndbijpbHYPhGl51o+/HMyCeY5fWZy
 LzSFRLMQHPlqgpGf3bGWLaBbnaYc2mQXtXqWJUHXhdvxtC71bfDGrfHMceDnUDjs+VoKWcvTuBM
 MWi89cyyF2voNJOWeazyM9lihpJsPT/i/Efq8i3EzAO+1h1u0Ehg9/Lld
X-Gm-Gg: AeBDieuLTEjsx6kodZEJH/M30riCzFEIdyY3LmOMcF5pbCpLiO8GxHH/ExpfcsMGNS8
 YPzBaqvOSzw4sMXmH9zfXIpx+JfReHU9RZGNU5tFitWZPLN5c0toGzAiF3VEawOo97ZJwhpMGGz
 zeIQ32SxrffbN54A9Yxq+xliPO12cM/CxTxxMxCwnhJYVxcL9dxr9dtR3ZoL2xRAw3e/8kja0+I
 H45N3IFck25fP0kYblfNTzCY2mRCp1tyHVqZdWW/V/WeoTegYAl8t4B5NgT4TXN7bfGH87YMjX8
 ZYOuZc32ory0tufy6g0IASAm2eeXMMG2ddF3OgWeIby57gWSR2uzxCu7DdMqMxCcS9yd3PMXpc1
 86KZXZEVJZUIBdxW6feI+nWrJdhl8Es264uszM5rPv48VII+Lu7LbQUiFfpmoF1uiE/gKEp4=
X-Received: by 2002:a05:6000:2389:b0:43f:e272:edff with SMTP id
 ffacd0b85a97d-43fe3db29e0mr35319842f8f.4.1776851801494; 
 Wed, 22 Apr 2026 02:56:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2389:b0:43f:e272:edff with SMTP id
 ffacd0b85a97d-43fe3db29e0mr35319722f8f.4.1776851800490; 
 Wed, 22 Apr 2026 02:56:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm48180109f8f.24.2026.04.22.02.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 02:56:39 -0700 (PDT)
Message-ID: <da0329f9-3f12-447b-9777-e8f1913285bf@redhat.com>
Date: Wed, 22 Apr 2026 11:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] vfio/migration: Add tracepoints for
 precopy/stopcopy query ioctls
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-17-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260421202110.306051-17-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/21/26 22:21, Peter Xu wrote:
> Add two tracepoints for both precopy and stopcopy query ioctls.  When at
> it, add one warn_report_once() for each of them when it fails.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c  | 33 +++++++++++++++++++++++----------
>   hw/vfio/trace-events |  2 ++
>   2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e6e6a0d53d..04d9f94edb 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -329,6 +329,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>       struct vfio_device_feature_mig_data_size *mig_data_size =
>           (struct vfio_device_feature_mig_data_size *)feature->data;
>       VFIOMigration *migration = vbasedev->migration;
> +    int ret;
>   
>       feature->argsz = sizeof(buf);
>       feature->flags =
> @@ -340,12 +341,18 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>            * is reported so downtime limit won't be violated.
>            */
>           migration->stopcopy_size = VFIO_MIG_STOP_COPY_SIZE;
> -        return -errno;
> +        ret = -errno;
> +        warn_report_once("VFIO device %s ioctl(VFIO_DEVICE_FEATURE) on "
> +                         "VFIO_DEVICE_FEATURE_MIG_DATA_SIZE failed (%d)",
> +                         vbasedev->name, ret);
> +    } else {
> +        migration->stopcopy_size = mig_data_size->stop_copy_length;
> +        ret = 0;
>       }
>   
> -    migration->stopcopy_size = mig_data_size->stop_copy_length;
> +    trace_vfio_query_stop_copy_size(migration->stopcopy_size, ret);
>   
> -    return 0;
> +    return ret;
>   }
>   
>   static int vfio_query_precopy_size(VFIOMigration *migration)
> @@ -353,18 +360,24 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>       struct vfio_precopy_info precopy = {
>           .argsz = sizeof(precopy),
>       };
> -
> -    migration->precopy_init_size = 0;
> -    migration->precopy_dirty_size = 0;
> +    int ret;
>   
>       if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
> -        return -errno;
> +        migration->precopy_init_size = 0;
> +        migration->precopy_dirty_size = 0;
> +        ret = -errno;
> +        warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
> +                         "failed (%d)", migration->vbasedev->name, ret);
> +    } else {
> +        migration->precopy_init_size = precopy.initial_bytes;
> +        migration->precopy_dirty_size = precopy.dirty_bytes;
> +        ret = 0;
>       }
>   
> -    migration->precopy_init_size = precopy.initial_bytes;
> -    migration->precopy_dirty_size = precopy.dirty_bytes;
> +    trace_vfio_query_precopy_size(migration->precopy_init_size,
> +                                  migration->precopy_dirty_size, ret);


This is possibly an overflow (in the kernel)   :

vfio_query_precopy_size init 18446744073281946832 dirty 0 ret 0
vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 3735178384 precopy initial size 18446744073281946832 precopy dirty size 0 exact 1
vfio_state_pending  (0000:b1:01.0) stopcopy size 7106032 precopy initial size 0 precopy dirty size 496 exact 0
vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 3734129808 precopy initial size 18446744073280898256 precopy dirty size 0 exact 0
vfio_state_pending  (0000:b1:01.0) stopcopy size 7106032 precopy initial size 0 precopy dirty size 0 exact 0
vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 3733081232 precopy initial size 18446744073279849680 precopy dirty size 0 exact 0
vfio_state_pending  (0000:b1:01.0) stopcopy size 7106032 precopy initial size 0 precopy dirty size 0 exact 0
vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 3732032656 precopy initial size 18446744073278801104 precopy dirty size 0 exact 0
vfio_state_pending  (0000:b1:01.0) stopcopy size 7106032 precopy initial size 0 precopy dirty size 0 exact 0
vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 3730984080 precopy initial size 18446744073277752528 precopy dirty size 0 exact 0

C.



>   
> -    return 0;
> +    return ret;
>   }
>   
>   /* Returns the size of saved data on success and -errno on error */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 287df0b8cb..854a7e4b19 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,6 +176,8 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
>   vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
> +vfio_query_stop_copy_size(uint64_t size, int ret) "stopcopy size %"PRIu64" ret %d"
> +vfio_query_precopy_size(uint64_t init_size, uint64_t dirty_size, int ret) "init %"PRIu64" dirty %"PRIu64" ret %d"
>   
>   #iommufd.c
>   


