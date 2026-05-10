Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF632CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMASQ-0000ea-JO; Sun, 10 May 2026 16:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMASP-0000eS-Lh
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMASN-0005PD-MN
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778443733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vUDWc0D7Mt4y/EpGEaDuptObLQRjGXQLFARoVlMuJYk=;
 b=dQyzongG7nGNrPLzdkgixV4MTS0TUineBK4G5N3bARdzHr3d+wmVhU9Tp92Id4PTmCfCkf
 cLqH+X22bomrJEHLvbSHnaRin9YV3k9Y2WYjogsA5B+mTO6y2V2TXGjaOMeiLUNfIjzZry
 czUJSMzDQOK8I2pupDMJK63eTgGPriI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-teS-taSyNHe6u5qlFI8h9A-1; Sun, 10 May 2026 16:08:52 -0400
X-MC-Unique: teS-taSyNHe6u5qlFI8h9A-1
X-Mimecast-MFC-AGG-ID: teS-taSyNHe6u5qlFI8h9A_1778443731
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso2227700f8f.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778443731; x=1779048531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vUDWc0D7Mt4y/EpGEaDuptObLQRjGXQLFARoVlMuJYk=;
 b=pF+eok2siHQK1cA6YXfX6My5Ten4b3pECJTQpGw6UMjNzHAnmAOrAzRxwsfCr/+zVJ
 vQnuKveth2Dr0oNMoTF/UrlJQL/yCRvzxPawDWJnqDWinjxgOaWUfScmiHloilX71b1U
 7rufqOtVM0Q/+wSWyV37abZKIYd9c5EQyAf9bplrwQrd6Kz7ud1mEegNjJFxjaWMOT7N
 Fsq48Mcs2bmPXiG7OdeeoBhejzAA4bB8UN1FiJlnEab8YHFo9BxNO2MgpPkzb/XULESK
 ZaX3LLI+gs4tWd0t64xDu16sqC7KIqEjzEIkHdHLLecWHQiuQciod37XOUr6ItnrPI3f
 BzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778443731; x=1779048531;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUDWc0D7Mt4y/EpGEaDuptObLQRjGXQLFARoVlMuJYk=;
 b=F0arBQiW4GP2MuY2k9SBBciI9yiMqRZNdHnrI0OPnfl18iiqdjx8YMqRJiJZK6M0KF
 DGrEMRiN9MYxurbUAbFzUlL2+SG8T0B8g4GaAmoRtm99AVPXxGg7PcL+Mwv+jMV9R9y/
 SHgsSkBjOa10APAkdGDpOdQlz2RriSNe0Hg+M3K1WU5di2NEyUBpjnau46CzvRDFdT8V
 Ddj+RffVggOr9AwYjEnS/1eH7Ew0Fi8c2yzTTCokKshLmZN0zNsrJC2xECkzqBDiNSTv
 DXlJMSyn2bldfF6Ifpt753WB9xIyv98n3eu0VJgi8JcFrjRQI/usRzBKtZR8b8rOXvE8
 HcCw==
X-Gm-Message-State: AOJu0YwzHFW78BzOD5Z71XW8jzV2kqtTbtkDbARadpdV29BbZ7j39BP1
 WVD/YfCxWwpQD2Ldz0M0JjypU1kjOhzQWalHU9X0RBbZUzaF5v0aBcDwrmrAgfZ88tV87fHbwfl
 yDuFOVVw2ejQXwnBjxLvdiks8t//K5nDm+m8IEJOOKje2VfV6A1sJR5bz
X-Gm-Gg: Acq92OHPQDCJC0aJmtcILAuEAym5L1DmrHnutjqihKDkCUZUcrsTKNBv0cUKdBHfuWc
 Rd7YgRAPxeHfO45788BFCBt6iZ2rEatayoejyFSdf4PadWT5BYSIGsX7rDT4XCO/SPY+bPeHGa4
 5EfJtM9X3XKOeyUK6CKMyEYucnKiw19Lm6cCL8daF7ADIdCMH9b9BXKw3tpcPHFfWPU9PV6f5Ob
 ckVpxxkfhuLpoFx20I3b3o5XYQ+YT40pc0Izq37qxoMo69K8HT4b5CSYWn5bCoL46RDVHs4RpdS
 uRbfFJSUbNDCUIWTCbScY3S3ouZCT8pgcpyJnSBhzVWCL6+vh2o9mgobFKC55y1EiQ0LMFNkpgO
 ZTqaJrZhPJVHRDanjw+q0cvcDBoZza+yelu1qbHQr8GMEUnJ/9TJsccSyoLMA
X-Received: by 2002:a05:6000:2dc6:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-4515cc31e43mr34149307f8f.34.1778443731002; 
 Sun, 10 May 2026 13:08:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-4515cc31e43mr34149283f8f.34.1778443730519; 
 Sun, 10 May 2026 13:08:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bbebdsm22175093f8f.5.2026.05.10.13.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 13:08:50 -0700 (PDT)
Message-ID: <c87311a3-b214-4705-8ed3-7386aea1056e@redhat.com>
Date: Sun, 10 May 2026 22:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
To: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 Avihai Horon <avihaih@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260507092358.2479135-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 5/7/26 11:23, Song Gao wrote:
> diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
> index 22f6eb8ca7..7baf1968a3 100644
> --- a/include/standard-headers/linux/virtio_ring.h
> +++ b/include/standard-headers/linux/virtio_ring.h
> @@ -31,7 +31,6 @@
>    * SUCH DAMAGE.
>    *
>    * Copyright Rusty Russell IBM Corporation 2007. */
> -#include <stdint.h>
>   #include "standard-headers/linux/types.h"
>   #include "standard-headers/linux/virtio_types.h"
>   
> @@ -200,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>   	vr->num = num;
>   	vr->desc = p;
>   	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> +	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
>   		+ align-1) & ~(align - 1));
>   }
>   

The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of
libc types") changed this virtio header and this breaks the
build on Windows :

   https://gitlab.com/legoater/qemu/-/jobs/14297040230

A fix could be to reintroduce 'uintptr_t' (available through
osdep.h) by modifying the linux headers update script. Ideas ?

Thanks,

C.


