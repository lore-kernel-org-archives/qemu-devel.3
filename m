Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FB7F532E9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4wjL-0004sI-RZ; Tue, 24 Mar 2026 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4wjK-0004s7-ST
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4wjI-0007lU-Pe
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774339386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FDhaQQlJ0yFYkEgcZ1I2pIIIkPMoQ00+avbTeSWCjg4=;
 b=LEzuEcuctuQacI2dcZZLjkSSlIfHEP0iwFVzWVzNvE/6skGHgKhIGfcfssI6YypO5Kkt8L
 xwcEj5Xqrr8XUcoXAQK5J1t3eH12Xuo5f5m0u5kLH9NicWibv77t00S5qz5t7dl84srCla
 +3xqSEzaBs4lplvFauP9IpOFJ6+d8n8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--1uJKRMTOxO6Tr5Cbl3krQ-1; Tue, 24 Mar 2026 04:03:04 -0400
X-MC-Unique: -1uJKRMTOxO6Tr5Cbl3krQ-1
X-Mimecast-MFC-AGG-ID: -1uJKRMTOxO6Tr5Cbl3krQ_1774339383
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c794ec8eso4032188f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774339382; x=1774944182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FDhaQQlJ0yFYkEgcZ1I2pIIIkPMoQ00+avbTeSWCjg4=;
 b=DroguN7hr/7P8BAyvh3k3W+t4Jhg9ipIcaKiwIKQJYd20fIkqp7xsBETxnaDtQ63MB
 CWVfqO9pqr4p4E9QNnw8JWz1CAIYDzaPqUyaaDhJGNKWWoveXc3qEb8H/RjKHjG77LN+
 IO8Bw96dp0ROUA5MWKLqfF+m/L0fQ3brKtsKGMNm1xOYYd5TbF7ve9uaW5QlLKujZqhq
 YmUPcJ1SHd0QBTzbngGoptyoRuBtuFWGC7Cs/iJpxRPj0yIT6H/k8M/OFoHi7qDOtNJF
 n9exP6cbgIAU0phv9B58U5y429FkiKZQp0XDbse4eeVOayCnbNLlwzO/umV0/G0PV6Y/
 8HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774339382; x=1774944182;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDhaQQlJ0yFYkEgcZ1I2pIIIkPMoQ00+avbTeSWCjg4=;
 b=PHSq1Y8uWsf321gH07CziqbOkmhB+eLeVFOQd+71wjFEYlxoW48fpF84yTWI3JP5vt
 wec0oueVFY/AdXhcqd/JL9w+msvM881fDLGkX5lJ9xJf6xf5bcwUrh06nALOca2UDgA0
 xUgX25t/6Kj7QjS6cKr+OBuHccPbhPCzfh8uJWoa7vaBcfHUFuvDxeihMZ+TB1YImGH0
 mFqyatGytYW3IOxC1Cc8iBBv6IW6vsi0GhZ9GSv99czcMeuYphvH69K4MVM3MFSyGKcm
 I9Fb7YulGs0ESRO6813vn1p5SpSNWb4LZhJoyIyi/XvSm62mi1prpSfAIq7+lqEDb0Ok
 SxXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxdpUc/mOdYl6y6w40r7T1oUADk1sVjjMehgiCkEwoQnLM25q8kelGpjsYoiLmPC8Q5RscBMJav4Z2@nongnu.org
X-Gm-Message-State: AOJu0Yzn3F2kgItxFW8NluuAy47jzj8VULDeRVO5MIOPylmQi8OGlzjU
 HCVmxmgyew1mnl1yTPVXEgE+1FH8wtg0/0gIQt7zzH2OwPkG+EBJTdLSIA2oalrvbAW8KaPpehD
 vDHicSNErP6iPCAnOHvlFkNSefnlaH8DmV35/tliUrXMaKdt7L/7R7SZJDGCp05bp
X-Gm-Gg: ATEYQzwSUMixwZj3plY0zI5NVxh7PQoKnKTiYpFb2Uqq3HS+pZfnXkboAl5tDlv5j6J
 Izs2KRrfbbrb4PZl0nAFl+M8V23bwY5lpKD1qVAq2liqBEmGzmfdsl/1lUJu9VRZptvT5x7sVMX
 eqP6TeIgP9MM0oBiV7N+kOA+ys+ifS/plO/JeQj3qZQefoB5fIz+Bok+JjVZb1N43Fyguu4gXSf
 bMKLh7me3ykcuD2yWAOtIxh7krcimYOtMDcyHwDokjCRztkxeSjj43bf1bYKlTA6wrJLFeDJNjV
 LBy+nQkqyayws2KFXf5FPINHr6EgDUXqNbWZov4H0xhdK/o/vWdMGltlLyMdh5dz24dp2Kmwg3e
 FMVSj80AEa/SJC5OtWOZ6ZPmr/YKEcEgIRZbBIUhZOXPlrx32HKGijLWzy8l+
X-Received: by 2002:a05:6000:608:b0:439:fdd5:10b5 with SMTP id
 ffacd0b85a97d-43b6426d710mr24429557f8f.39.1774339382359; 
 Tue, 24 Mar 2026 01:03:02 -0700 (PDT)
X-Received: by 2002:a05:6000:608:b0:439:fdd5:10b5 with SMTP id
 ffacd0b85a97d-43b6426d710mr24429493f8f.39.1774339381807; 
 Tue, 24 Mar 2026 01:03:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a27csm38355690f8f.36.2026.03.24.01.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 01:03:01 -0700 (PDT)
Message-ID: <37e7a5da-9fa5-4602-97f4-d3190f638b01@redhat.com>
Date: Tue, 24 Mar 2026 09:03:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/27] hw/net/ftgmac100: Improve DMA error handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260323165218.96607-1-philmd@linaro.org>
 <20260323165218.96607-26-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260323165218.96607-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

On 3/23/26 17:52, Philippe Mathieu-Daudé wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> Currently, DMA memory operation errors in the ftgmac100 model are not
> all tested and this can lead to a guest-triggerable denial of service
> as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.
> 
> To fix this, check the return value of ftgmac100_write_bd() in the TX
> path and exit the TX loop on error to prevent further processing. In
> the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
> flag as appropriate.
> 
> The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
> AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
> Nevertheless, since it is supported by the Linux driver and it should
> be safe to use in the QEMU implementation across all SoCs.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335


Philippe,

You can certainly apply the fixes, but I don't see any email from you
about it. However, I indicated that I was applying it to aspeed-next
as part of this series:

   https://lore.kernel.org/qemu-devel/20260323125545.577653-1-clg@redhat.com/

There is reason for it. The SMC patch is required to fix issue 3335.
The patch should say so, I agree. My bad.

I see that some VFIO patches are also included. I appreciate your help,
but please contact the maintainers before, I believe I am responsive
enough to requests ? I will rework the aspeed PR I had prepared
and update the VFIO tree.


Thanks,

C.


> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20260322215732.387383-3-clg@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/ftgmac100.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index d29f7dcd171..2f05bba11d0 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -624,7 +624,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
>           bd.des0 &= ~FTGMAC100_TXDES0_TXDMA_OWN;
>   
>           /* Write back the modified descriptor.  */
> -        ftgmac100_write_bd(&bd, addr);
> +        if (ftgmac100_write_bd(&bd, addr)) {
> +            s->isr |= FTGMAC100_INT_AHB_ERR;
> +            break;
> +        }
>           /* Advance to the next descriptor.  */
>           if (bd.des0 & s->txdes0_edotr) {
>               addr = tx_ring;
> @@ -1134,7 +1137,10 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>               bd.des0 |= flags | FTGMAC100_RXDES0_LRS;
>               s->isr |= FTGMAC100_INT_RPKT_BUF;
>           }
> -        ftgmac100_write_bd(&bd, addr);
> +        if (ftgmac100_write_bd(&bd, addr)) {
> +            s->isr |= FTGMAC100_INT_AHB_ERR;
> +            break;
> +        }
>           if (bd.des0 & s->rxdes0_edorr) {
>               addr = s->rx_ring;
>           } else {


