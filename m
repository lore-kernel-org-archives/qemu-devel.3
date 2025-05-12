Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4ACC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEME8-0001Hx-5N; Mon, 12 May 2025 02:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEME2-0001Gv-3D
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEMDr-0007BT-VQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747029664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fApEDo7g6PPJaSoo3F3YUH4wJSvJgEGLsuvFAvUn3kw=;
 b=RsgZZeBsO+3JucnxEfPvP6hr+ogWcqkSQQRbSiF0RrHgf4H+gNNWtJYHJdMA7qq2ZhxijT
 eKUxbfZSvVl3Hz9hwkE69kE784Jn8ogYPpJk1jEEBwFhocrOjkWDX9DOl+GNGWP1yXMTYG
 xAU/LGSn34F499hmqoDM4/no8r8WrKc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-tZfuytB2MTKCyq0FwIiHJQ-1; Mon, 12 May 2025 02:01:03 -0400
X-MC-Unique: tZfuytB2MTKCyq0FwIiHJQ-1
X-Mimecast-MFC-AGG-ID: tZfuytB2MTKCyq0FwIiHJQ_1747029662
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fc86ce3c54so2983651a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 23:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747029662; x=1747634462;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fApEDo7g6PPJaSoo3F3YUH4wJSvJgEGLsuvFAvUn3kw=;
 b=Ay0qI4f2eSOF0OpYnMpabbbOuAzwDGfKwoXRcCHrMSL6AFrVtVNh8dk4xGFe7zw+fL
 8VK2bOOJ6PAy3VUJ4UcJD+t9UkRKi53fHRKhBCOASvc1GHDo1EhYwrFqNCKO+/Q68zAJ
 RAkRtOcZuWOvckENPnhSRekvfMnkbcnu9njypNkcJ7uKb2KGNZmZnwkW4GKBEDw2gu5x
 PsZDcsnUIO3jR7wXSNXhqNxfvfioQf4TTe+jAmMNRcx2OkUS111fHJQ5RUy9eHm2asGK
 DjyorwmgVvIJyQEkQ2z+f5E08a00m/jlB1k2Ckv5GgYH4WkN/eajnk1wyFmeUZcf0Mj1
 yxDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhmmclpeNhxwH+JbF2PeZ6LO9QDZjJH60OqmrF/3Bhr1J7nNUdm4tV15hGML3kLQ2X9cFIuD/Cznmm@nongnu.org
X-Gm-Message-State: AOJu0YyvF8a1UYy2M3YGSHgc3Bnbtv71PNgkSbqfSYOFfePNrBLPtDyU
 23ZIqX4CnRqgZ/3jbWIOQqvh8QArycIvyPPtJiOm4zCAjh3K+B7z4/k0b9oBgttQZz081iCuGYH
 WFpVLPnq6xdUUmKW5Aa1guebErRSojmUwS9MnbxZkf8Phz1p1oQJN
X-Gm-Gg: ASbGnctQ4qy0VCmjWv8sWwDnhP/U8qJpXKXK6Xma4Dlo21T2CrwJUoGwa2dQ/BxaNBq
 3S+ei54963ylg+s/HWi54prppXgMcPHhn5x24thslMe/vWn52IUgQ3VV7CiQjqfZ8GquliRodtN
 LcocF3xw3xaSIp+nI2gz/aDMX/sq/CvyT7ncoxYJhG9yzs/eKe4vytqWFu84aIH8zsbC8smGhZD
 Zum+6toZA6eaebkn6saNNCMWfAEBoSmxtW2zAIUzwBKdYwMaHIhxwuQvkOqKy2DC1B/OWreuMj+
 ZYW+FTZPXkYG/KxSbAI6+5RMeAoNdEnqV3MckdIwBdtVB9fNO4t7
X-Received: by 2002:a05:6402:2711:b0:5fd:1a42:17b0 with SMTP id
 4fb4d7f45d1cf-5fd1a421bc4mr4644113a12.9.1747029662000; 
 Sun, 11 May 2025 23:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhnKCzvkJ9CnmDJ+i77PkBMhSdYE4qKh3iF3t+dsDTeFmXeOFkuI4NnmCH1I9u/KuqhCEV8g==
X-Received: by 2002:a05:6402:2711:b0:5fd:1a42:17b0 with SMTP id
 4fb4d7f45d1cf-5fd1a421bc4mr4644037a12.9.1747029661020; 
 Sun, 11 May 2025 23:01:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d710549sm5185229a12.76.2025.05.11.23.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 May 2025 23:01:00 -0700 (PDT)
Message-ID: <a47270aa-3de5-4474-80ea-bc2d126d6442@redhat.com>
Date: Mon, 12 May 2025 08:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-7-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250506143905.4961-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/05/2025 16.38, Philippe Mathieu-Daudé wrote:
> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
> via the 'extra_mac_registers=off' property. We removed all
> machines using that array, lets remove all the code around
> E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
> similarly to commit fa4ec9ffda7 ("e1000: remove old
> compatibility code").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/net/e1000.c | 72 ++++++++++----------------------------------------
>   1 file changed, 14 insertions(+), 58 deletions(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index cba4999e6d0..e0310aef872 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -127,10 +127,8 @@ struct E1000State_st {
>       QEMUTimer *flush_queue_timer;
>   
>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
> -#define E1000_FLAG_MAC_BIT 2
>   #define E1000_FLAG_TSO_BIT 3
>   #define E1000_FLAG_VET_BIT 4
> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>   #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>   
> @@ -1210,54 +1208,24 @@ static const writeops macreg_writeops[] = {
>   
>   enum { NWRITEOPS = ARRAY_SIZE(macreg_writeops) };
>   
> -enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
> +enum { MAC_ACCESS_PARTIAL = 1 };
>   
> -#define markflag(x)    ((E1000_FLAG_##x << 2) | MAC_ACCESS_FLAG_NEEDED)
>   /* In the array below the meaning of the bits is: [f|f|f|f|f|f|n|p]
>    * f - flag bits (up to 6 possible flags)
>    * n - flag needed
>    * p - partially implenented */
>   static const uint8_t mac_reg_access[0x8000] = {
> -    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
> -    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
> -    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
> -    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
> -    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
> -    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
> -    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
> -    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
> -    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
> -    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
> -    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
> -    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
> -    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
> -    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
> -    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
> -    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
> -    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
> -    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
> -    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
> -    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
> -    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
> -    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
> -    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
> -    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
> -    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
> -    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
> -    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
> -    [BPTC]    = markflag(MAC),
> -
> -    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
> -    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
> +    [TDFH]  = MAC_ACCESS_PARTIAL,
> +    [TDFT]  = MAC_ACCESS_PARTIAL,
> +    [TDFHS] = MAC_ACCESS_PARTIAL,
> +    [TDFTS] = MAC_ACCESS_PARTIAL,
> +    [TDFPC] = MAC_ACCESS_PARTIAL,
> +    [RDFH]  = MAC_ACCESS_PARTIAL,
> +    [RDFT]  = MAC_ACCESS_PARTIAL,
> +    [RDFHS] = MAC_ACCESS_PARTIAL,
> +    [RDFTS] = MAC_ACCESS_PARTIAL,
> +    [RDFPC] = MAC_ACCESS_PARTIAL,
> +    [PBM]   = MAC_ACCESS_PARTIAL,
>   };
>   
>   static void
> @@ -1268,8 +1236,7 @@ e1000_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>       unsigned int index = (addr & 0x1ffff) >> 2;
>   
>       if (index < NWRITEOPS && macreg_writeops[index]) {
> -        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
> -            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
> +        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
>               if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>                   DBGOUT(GENERAL, "Writing to register at offset: 0x%08x. "
>                          "It is not fully implemented.\n", index<<2);
> @@ -1295,8 +1262,7 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned size)
>       unsigned int index = (addr & 0x1ffff) >> 2;
>   
>       if (index < NREADOPS && macreg_readops[index]) {
> -        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
> -            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
> +        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
>               if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>                   DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
>                          "It is not fully implemented.\n", index<<2);

There still seems to be something wrong in this patch, tests/qtest/pxe-test 
is failing when this is applied ... could you please have another look?

  Thanks,
   Thomas


