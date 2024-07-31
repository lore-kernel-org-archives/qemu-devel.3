Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F6C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9tD-0002ZW-2g; Wed, 31 Jul 2024 10:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sZ9sy-0002Ut-Kv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sZ9sw-0002w9-Ob
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722434456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rb4m7abwoP2xHrUcxy+OkmrCQxwmjeD6QxVFEwHLIWA=;
 b=ezpCzTsQHHI3D5sJH8VqC56C4H8MqX2Ohjp/H72WQMtDkwzOhvwVtaNzwIJh9ccQtE6I3d
 I2OO8Brm/KsAuR/hAatecaZ9OvtI04a3ttcynjbVFIt/WM9OOuor6+NWtYEIeklE5w90PG
 wSr1V2rHN9PAX0ApJGHnAotLDpZQnqU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-LMCbhewMMHu5FQn_-JnJiw-1; Wed, 31 Jul 2024 10:00:53 -0400
X-MC-Unique: LMCbhewMMHu5FQn_-JnJiw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so510107f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722434452; x=1723039252;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rb4m7abwoP2xHrUcxy+OkmrCQxwmjeD6QxVFEwHLIWA=;
 b=akvPQu7f/qB4YI5i0UgAMwIgABncIEeG8vk3swB+r8ZVmri2IyWn6OCIdE1ldXabqY
 Dq7hMrK/ksjkyJjnuHpDy1gqwlOjVJp9LzIGkgjQ64fOPVMOpsIBUzSpjAL9VVyUsWuA
 hxe9MQaPVVZk+dZ2gqL2UN9T4IvQIM6FxKeGysRBFcJc4BtOUx4DxV1/0WixSaTl4PxK
 pCy9mJevG5zYEHmLd7RKfz+sLw4VlWEdICMkgFsr2OShNM0aU0p3hc4vUzQZBBlfGRsZ
 qXhk5MDAcQ2BPcI1aO5vXiYLNuHWIvvXExpkaUeiMst158ubEsFtAqCoBLOG/DMgZkhe
 Wf5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOGeHgEENWe5grAExbwrerLsg1UjdEq3fC4IR9LuJvXrcJA3L3KUb0CmrXb/aIjXS17+Nd0UdC3rqc@nongnu.org
X-Gm-Message-State: AOJu0Yzr6AfR86EIrWGPSVEKTU2nCF3d39G05ik7XMc/J7ZKwj+nEIfk
 +6vKcQT6iAFNCyc/tYCSfo/PkZ2qyUcyiw63XZuQNxE8wJSTuHd8JaLqMME9VFPtNw2sOvPIZDN
 lngC04o9qlTgbLFOdt7K6fpP3/tJ/Q/vnlmwTa5BdBUe5/zga5m7g
X-Received: by 2002:adf:f306:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-36b8c8e60aemr3988317f8f.16.1722434452471; 
 Wed, 31 Jul 2024 07:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiuUxa4I18lrCr10RUU/K7eUJfTLO7eQooHhoO69aFKzXe1mxsNp2aDevR4Yhymw5EQ0t2og==
X-Received: by 2002:adf:f306:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-36b8c8e60aemr3988281f8f.16.1722434451919; 
 Wed, 31 Jul 2024 07:00:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49?
 (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de.
 [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36858148sm17237094f8f.72.2024.07.31.07.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 07:00:51 -0700 (PDT)
Message-ID: <25fb9291-6b2e-45ab-812c-028f88de0dbb@redhat.com>
Date: Wed, 31 Jul 2024 16:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
To: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240731132524.308273-1-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 31.07.24 15:25, Philipp Reisner wrote:
> As with many syscalls, open() might be interrupted by a signal.
> 
> The experienced logfile entry is:
> 
> qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call
> 
> Retry it until it is not interrupted by a signal.
> FYI, dd has the same kind of loop aroud open().
> https://github.com/coreutils/coreutils/blob/1ae98dbda7322427e8226356fd110d2553f5fac9/src/dd.c#L1294-L1299
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---
>   util/osdep.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index 770369831b..a1269d9345 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -294,14 +294,17 @@ bool qemu_has_direct_io(void)
>   static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
>   {
>       int ret;
> +    do  {
>   #ifdef O_CLOEXEC
> -    ret = open(name, flags | O_CLOEXEC, mode);
> +        ret = open(name, flags | O_CLOEXEC, mode);
>   #else
> -    ret = open(name, flags, mode);
> -    if (ret >= 0) {
> -        qemu_set_cloexec(ret);
> -    }
> +        ret = open(name, flags, mode);
> +        if (ret >= 0) {
> +            qemu_set_cloexec(ret);
> +        }
>   #endif
> +    } while (ret == -1 && errno == EINTR);
> +
>       return ret;
>   }
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


