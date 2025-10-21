Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2130CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB6RU-0002WC-E0; Tue, 21 Oct 2025 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB6RS-0002Vo-8o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB6RQ-0004t0-7o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761030353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q7vYavpC/cOHPtpc0FQPfjALNpsLqem+CR2QQmBQQbA=;
 b=fjzUbU/Ebl0v/q44v1XrgUmO2KnjtJGM8eOf+OrHMqZHTq00JmYlo+KjaRV7gZDD+hp63V
 LRvUUcqykOSFKxPUvI9rTJUTWfoZlI2+m5RKayK/3ynlNDnURrAi4+/oyxts5gItNwHxUq
 m9n4cqCJZZODkj7pbi2ctB+5XZ1OFTs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-8bQAi19NN1-KTDEmQJ0nfg-1; Tue, 21 Oct 2025 03:05:51 -0400
X-MC-Unique: 8bQAi19NN1-KTDEmQJ0nfg-1
X-Mimecast-MFC-AGG-ID: 8bQAi19NN1-KTDEmQJ0nfg_1761030351
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106720618so32482625e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 00:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761030350; x=1761635150;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7vYavpC/cOHPtpc0FQPfjALNpsLqem+CR2QQmBQQbA=;
 b=thitMQ3I0ExHo8DbbENJLpvPKrHSzZZkqHd9GKkiZrzxwYFMYm20NIjnoAc1cqAiHo
 VJm6XRBm5+MnDweFYL/dCCVcX5kUyMd01FuSKL33cHbq2vsn9IFYG0mZSnv4ghT+6LWJ
 n4BIUSbR4XMu7FiCzr5kh2+ngi/VImkUZjbmVnCMmDl1DRD9iloZe8T1u8PrpD74rjqb
 9JXleWXjqnTtHTg0Qql1JP7CW02lGUXGIAiEWchi/jgrlNCHE1khusfC2qS1RK0eYsch
 Hgvr31QLarTPY9gRgVoaKgB07Oi2iF21rF/9HCoh4gZPE1ctliSS6hSgmmxKK6QR9COm
 Cjqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAnW0o+awVf2g3FCgKCbTrCPFA6LELzXQLU9WFi2buPBiu/OxfznRVSi7qYs7LdasoLkdBhr3UEk2+@nongnu.org
X-Gm-Message-State: AOJu0Yz8Ua6OyoGjAGQc9gWiDx5WhQsmpxsp7QXsnva2R0sg2PozvhQH
 EEzXgDmZ/H3y02ZiYvqpA+Fiz+3uRtC0QkcsNO4nx6gR/CGfdpLs75VUwFccdWaxdjpMIo3PrPK
 rcBmSjm0kCv9ntm/L1QpjLqOBWPz/E/9+9EOSd7/+YDApwff1CYk75Qce
X-Gm-Gg: ASbGncu+S6Y7ohW0HpjDbvFtHSCZhd/fheP7BFxSi0jHNJBpACUbiU/EbBTC7QxOCyL
 LJqjBsF8jUBW4jh4Jfqg1VZ+FMKeyfCj1BCbcr+DN3Jy91OXVCgtQwZymbO4SfRkOozGUNG7my0
 EK6NEoMCDPHza/5ERyBcSELmQdgNMzuoKIucGK3wvyZXFwG99/yv9TEiCdP40/s956ipTmFVRT0
 WUx9Q6Ec0hnloQUZaIDFpV/IzF57aF8TpyZX7zvlhbaqszor5MOPDE75jduesxY4NjpcVSNg8qJ
 4EJu2j7TsJeJIo8zyK1iV3WPz+H0WT+30GYFB0S/CmoCviSeBMETb2sLRDbriSBIPSFAZtN+4WW
 YJZ+bKaOAN32Tp+cGFymb6ZzJd/zPMZHALFgEgw==
X-Received: by 2002:a05:600c:8105:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-47117872704mr113481785e9.7.1761030350605; 
 Tue, 21 Oct 2025 00:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ZCuMApAV+RPALM1h6/g9a0Q+zUr3p0RmnVwbMKMyWA6TQUSPisj59AK+J/FWIlJXFYiDOQ==
X-Received: by 2002:a05:600c:8105:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-47117872704mr113481585e9.7.1761030350179; 
 Tue, 21 Oct 2025 00:05:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm18914582f8f.47.2025.10.21.00.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 00:05:49 -0700 (PDT)
Message-ID: <1892476d-6176-4a49-92c9-bae0d0c3a0ba@redhat.com>
Date: Tue, 21 Oct 2025 09:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/helpers: Check base architecture at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Zhao Liu <zhao1.liu@intel.com>,
 Luc Michel <luc.michel@amd.com>
References: <20251020222315.68963-1-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251020222315.68963-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/21/25 00:23, Philippe Mathieu-Daudé wrote:
> Replace the compile time check of the TARGET_ARM definition
> by a runtime call to target_base_arm().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251020220941.65269-1-philmd@linaro.org>
> ---
>   hw/vfio/helpers.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 23d13e5db5f..007c37b28b8 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>   #include <sys/ioctl.h>
>   
>   #include "system/kvm.h"
> @@ -220,9 +221,5 @@ bool vfio_arch_wants_loading_config_after_iter(void)
>        * See commit d329f5032e17 ("vfio: Move the saving of the config space to
>        * the right place in VFIO migration").
>        */
> -#if defined(TARGET_ARM)
> -    return true;
> -#else
> -    return false;
> -#endif
> +    return target_base_arm();


is that a new helper ? I don't see it being used anywhere else.

Thanks,

C.


