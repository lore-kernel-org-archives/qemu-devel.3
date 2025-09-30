Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F082CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3SW4-0004Sn-U2; Tue, 30 Sep 2025 01:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3SW2-0004SF-VU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3SVu-0004qa-3h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759208573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bL+RjxGqhOdRGXNtIbLqiRsKj/Y3K4D3P43i5DVXnfw=;
 b=AQXMQfpq1Zl5N4RYltApZW3u303kJCD1/VkTpgsnrj6lWjsmZ5+i+nn3RYxLepKO8DPvzJ
 4p1d77uUfoO7yhrwIMHXujgHD6INXjrkWZXKD31hL77eaB1VpNZDBEy0O8jE/q5MM6x97b
 dsfHC41DeBRhRQ1/M21XkazW9jULsbQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-hZjfwq3nMpayGPlAn31_6A-1; Tue, 30 Sep 2025 01:02:51 -0400
X-MC-Unique: hZjfwq3nMpayGPlAn31_6A-1
X-Mimecast-MFC-AGG-ID: hZjfwq3nMpayGPlAn31_6A_1759208570
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b07c2924d53so486267766b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 22:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759208570; x=1759813370;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bL+RjxGqhOdRGXNtIbLqiRsKj/Y3K4D3P43i5DVXnfw=;
 b=qPALVjFRCmNe+JDkEJ3wOEOtg1z+fodCvXkoOM/KysN/4dQW+++CEKfXVzbDC32rNF
 hC1FKaXFIGkMelzW/U/0k/+660jETqlDsTMIspRjTEG2m+6uEuTtAGbnd93t2vPtyBlk
 s/ncYmKoNgDv5So5vEFvOd27tbTlqxZXuMjk0SyN9OHMWselZ824YBnTTA/dVOGtFyiS
 JEqRQZfp1rP3suR7P2YEmC0B9+zcVB+jYKpscTKvIuPpWt4f6PHwDzFfDeTa69J/6w41
 ebOxHFY/RBRfBxNxtRfAKY9RXRin3jXmjW3cQ8SuZbzGHH52gjBlwiPL7wOBFrZjixVF
 5tnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7ILZ87jIR+JTYN1KG1ySI/t0H5bF7pjou3RgtCu/q/FmyTkRioAnpKT2WxMBRbVfTrm41J0+XcpDX@nongnu.org
X-Gm-Message-State: AOJu0YzRtu9SC2qojAdpkZf0tQweQ56QNV+6led3V9r16WvCu3us7iDt
 Hemc5LEuKls+seYzLnVR0CGmO/Dv7xzfucmQktVqEqqb7g2JgNLvKj4WsdPmuOYRtonuRXKgXX9
 nlVRoRnS2eWFWdeOb22EAEjatCWU+7cW4VqRlyv0a/11YGPLI9wdCdwLL
X-Gm-Gg: ASbGncuplc7jv+xY0iGt9UZecRxeqfF6IfA5bx/rtFbZ484gA37Scanl3KzBt15BLSL
 qrIGQt5cwv8cBQ//KRazTyWBfOZLJS22e9oMJlV33RReZSELIL+I28CsPEFqjD6d2HEAO7i5H01
 74nwq+TWlUK9KQ+4m/uZ2h99WYUdo8bdEjLfOVAowu0PKu8spR+GmmKKwIIBMNkKtQwBGcb/Ywa
 0CJss3FNVRGRDps9IEymXzTc2tgI0HDTTaOtOA/5gQeWxfen1Y2p2fTpHSt0kawvVvMVCPtJoWT
 1tgc/Bl7kqem8+yoBC0nCwAedG/cGdpKOpuVuc3ue7F6MRjepk5E0swU67/HkjKYFPIyWenXXqs
 K/MfutJdtuA==
X-Received: by 2002:a17:906:f5a0:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b41a5712270mr236496966b.39.1759208570366; 
 Mon, 29 Sep 2025 22:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxIe1/gUAycFtpVQcR4b+NsqR4Pre+MyQnotThndZ321+xPzQyp6FkW4vxaOLRMNcnkRphAA==
X-Received: by 2002:a17:906:f5a0:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b41a5712270mr236492866b.39.1759208569870; 
 Mon, 29 Sep 2025 22:02:49 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efb88ebsm1061296766b.32.2025.09.29.22.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 22:02:49 -0700 (PDT)
Message-ID: <193cd8a8-2c4c-4c2c-af22-622b74c332ee@redhat.com>
Date: Tue, 30 Sep 2025 07:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] system/physmem: Un-inline
 cpu_physical_memory_read/write()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-s390x@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20250930041326.6448-1-philmd@linaro.org>
 <20250930041326.6448-15-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250930041326.6448-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/09/2025 06.13, Philippe Mathieu-Daudé wrote:
> Un-inline cpu_physical_memory_read() and cpu_physical_memory_write().

What's the reasoning for this patch?

  Thomas

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 12 ++----------
>   system/physmem.c          | 10 ++++++++++
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6c7d84aacb4..6e8cb530f6e 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -133,16 +133,8 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx);
>   
>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                               hwaddr len, bool is_write);
> -static inline void cpu_physical_memory_read(hwaddr addr,
> -                                            void *buf, hwaddr len)
> -{
> -    cpu_physical_memory_rw(addr, buf, len, false);
> -}
> -static inline void cpu_physical_memory_write(hwaddr addr,
> -                                             const void *buf, hwaddr len)
> -{
> -    cpu_physical_memory_rw(addr, (void *)buf, len, true);
> -}
> +void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
> +void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
>   void *cpu_physical_memory_map(hwaddr addr,
>                                 hwaddr *plen,
>                                 bool is_write);
> diff --git a/system/physmem.c b/system/physmem.c
> index 70b02675b93..6d6bc449376 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3188,6 +3188,16 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                        buf, len, is_write);
>   }
>   
> +void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
> +{
> +    cpu_physical_memory_rw(addr, buf, len, false);
> +}
> +
> +void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
> +{
> +    cpu_physical_memory_rw(addr, (void *)buf, len, true);
> +}
> +
>   /* used for ROM loading : can write in RAM and ROM */
>   MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>                                       MemTxAttrs attrs,


