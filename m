Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB4D1A63C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDfj-0001jp-G4; Fri, 09 Jan 2026 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDfh-0001iL-V4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDfg-0006qz-8Y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767969657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9GPkRldR19buZgEM8xeHh4/W9lFaFoPs7uFmb4o0kXc=;
 b=f5q/yAHn2s6MCNIVrjfrpT+lCtbvhbBet1bt5GWFQUpcCBybGBzeh5u6uQ8paPSBwzHy7e
 1XibeSOQP4mXQcWoiotuaQLianmG4nUoxAju/KqiwSgfIVcUr0deYVqI6K7QjqVPapX9VU
 IeqRM2U+akYZTjKkswRJp4PYcBcl3eA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-h_tYO8PkM82ycFh3-E1xOw-1; Fri, 09 Jan 2026 09:40:56 -0500
X-MC-Unique: h_tYO8PkM82ycFh3-E1xOw-1
X-Mimecast-MFC-AGG-ID: h_tYO8PkM82ycFh3-E1xOw_1767969655
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso41021885e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767969655; x=1768574455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9GPkRldR19buZgEM8xeHh4/W9lFaFoPs7uFmb4o0kXc=;
 b=o8XPh3WJCXQoHiPwqoTj1Kro9tp1Ue04uCilXeZRgqI5WX/dqho7VywhP9qFqT5VYu
 UBYpouaNCrMjI9MmmlHlBX9hRGQUUwEwWVElEZXkdkAk/fKXnI6dHaREQezje8Tw3caE
 c7576nUsTFHK7keZcqwlKWw7e+QKgnFCrD1r0lo7U90mG4PquA7vUEGxcVDeM4LpogWg
 z0BnOA7N9DS8IiSBvwmEhk1cPKHpI/tdl3N7SWHx35hw4tSDWguJQPIkTCC8YXuzzNBi
 E7DM2hnain7OaMQeiWWh+KR8hIogsWCXlLKRJjFjLngMWVDFhxh002unCHuSaKmmmIWo
 5Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767969655; x=1768574455;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GPkRldR19buZgEM8xeHh4/W9lFaFoPs7uFmb4o0kXc=;
 b=NNeHjqxs9t/KzuOJWBbu7Zmv23+z/w6wHpG9ZcAgdiQHrRx102U1YBOZmhNj5tZChD
 FCWNIPwb5AVEjKsXUti0TTX7mlVpl5LR3/mpjB9n3oZyl0qVORSUPL0OGuInmppbsObO
 5Iwp8Wpwm8dJqwuM/JSNad88BRdCHOH6tlB6NjFmNRP5mIcgucHUIuTWgB7922/g7V9x
 byZKWhAdBpBOTnaHW1MZO5B2Cq9W87/iIY6XngWRxYZE53CW0mZcx9RBTWxRPN/ZO5Jj
 fifwh8OMb74oTTQpm1S+JKvSdcXX/zhK+BLz7e9W0GtFkP7HlkFw69juDg0o/EMOUjBE
 tc/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Vnccg1VmHrQ7PsKSluAl3LIBi/hrWCdu+EFCyocomET/ICrALyYRPSgwEft/CIBdUoAfc+VoUqJw@nongnu.org
X-Gm-Message-State: AOJu0Yy9RzGOq+ptNjlxrJSilYeJ9piM9NHOJlefEKl0i3rhGzJjOuri
 7biANHYI1LJocv5yQktc0hofjcxNrup8oY8uWAmb3bDS6Oq62/1Gzrdt+xMwZ1QgCe/7RvCIRl0
 P6nNlJCidOZlSaQ696CnmtlDD9JwNNi87nRaYEADEPG2ngP5MI4fynxeK
X-Gm-Gg: AY/fxX5Xsce/0kxh/ncv0Eei6wIyNYdbGs8SOy8XpsgyryZeuSuDHPllUeQDwEvZalQ
 nYjHRMHof43uYsAgYuyRvKA++5oG9xADTjOASDZQE3TVsdv042+WgXi50DnPRGJRTgpd8LWiIOg
 fOlPF5TvT869Rpe6snUbKhLVjgBsXdmtGtYXHj6nVPMcqF551D2UYs0L+PM3/bCOfQTH8Lsivqp
 2nD3zJWiR+8EqbxQA7pd4fs6RttSgqXP++sLa17a2Y5t/kFZ2PpEu9lhHoZkQMmlk7HTSfOQons
 taQSW0Pz2yxun+D/BAf7fc4lwMqwq2TxSaMAAHogm+JaIdEMNKvoGoEBG/DItXq+ETuoKZ8wJpY
 gyGIhCLR/V+8WO4Fz8xuRpw+izzHE80ngfOC1eya3AjtaKuMG
X-Received: by 2002:a05:600c:8b58:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d84b49d53mr116706915e9.31.1767969654954; 
 Fri, 09 Jan 2026 06:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGxu7qawKFNqoe/FCIpYbJPWxdmCkQGAWeUbSTSbC05Kjh4HrG9OwW7zndrYwITE3z+Jezdw==
X-Received: by 2002:a05:600c:8b58:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d84b49d53mr116706695e9.31.1767969654509; 
 Fri, 09 Jan 2026 06:40:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm207989725e9.10.2026.01.09.06.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:40:53 -0800 (PST)
Message-ID: <b1cf9ff5-e7d9-4667-9024-49f6459f964a@redhat.com>
Date: Fri, 9 Jan 2026 15:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251021161707.8324-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251021161707.8324-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Maciej,

Could we have a Ack from you ?

Thanks,

C.


On 10/21/25 18:17, Philippe Mathieu-Daudé wrote:
> Inline vfio_arch_wants_loading_config_after_iter() and
> replace the compile time check of the TARGET_ARM definition
> by a runtime call to target_base_arm().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Supersedes: <20251020222315.68963-1-philmd@linaro.org>
> Based-on: <20251020220941.65269-1-philmd@linaro.org>
> https://lore.kernel.org/qemu-devel/20251020221508.67413-5-philmd@linaro.org/
> ---
>   hw/vfio/vfio-helpers.h      |  2 --
>   hw/vfio/helpers.c           | 17 -----------------
>   hw/vfio/migration-multifd.c | 12 +++++++++++-
>   3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
> index ce317580800..54a327ffbc0 100644
> --- a/hw/vfio/vfio-helpers.h
> +++ b/hw/vfio/vfio-helpers.h
> @@ -32,6 +32,4 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
> -bool vfio_arch_wants_loading_config_after_iter(void);
> -
>   #endif /* HW_VFIO_VFIO_HELPERS_H */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 23d13e5db5f..9a5f6215455 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -209,20 +209,3 @@ retry:
>   
>       return info;
>   }
> -
> -bool vfio_arch_wants_loading_config_after_iter(void)
> -{
> -    /*
> -     * Starting the config load only after all iterables were loaded (during
> -     * non-iterables loading phase) is required for ARM64 due to this platform
> -     * VFIO dependency on interrupt controller being loaded first.
> -     *
> -     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> -     * the right place in VFIO migration").
> -     */
> -#if defined(TARGET_ARM)
> -    return true;
> -#else
> -    return false;
> -#endif
> -}
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index e4785031a73..b0eea0de678 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -16,6 +16,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/target-info.h"
>   #include "qemu/thread.h"
>   #include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
> @@ -44,7 +45,16 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>       }
>   
>       assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
> -    return vfio_arch_wants_loading_config_after_iter();
> +
> +    /*
> +     * Starting the config load only after all iterables were loaded (during
> +     * non-iterables loading phase) is required for ARM64 due to this platform
> +     * VFIO dependency on interrupt controller being loaded first.
> +     *
> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> +     * the right place in VFIO migration").
> +     */
> +    return target_base_arm();
>   }
>   
>   /* type safety */


