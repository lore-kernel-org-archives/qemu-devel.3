Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0062C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIY9-00009i-G2; Mon, 01 Jul 2024 11:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIY1-0008Kv-Hp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:02:30 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIXz-0002JD-MZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:02:29 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a729d9d7086so668808666b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846146; x=1720450946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxc67L0Wz50+CSwhbiqJJUNkuFwEkB8Pr9ZDPtyhMSY=;
 b=mCCR8GiOa1YZkoI4wJBR6Ee8bf7qnFoQf908VHlbWLb9KxGCq9AFCMicnSzxZbmsL2
 a/hjmpm2FHZvjmBN9X+Cvo5k+5iZ/OLf/LGYMUq1a4d61yYFEdRIB8FDmFhe9T8wpDsJ
 spkKv+kZvoEqVB8nznGwwh8EJ06whtRIOOtTi9EivUIPu9x81GXQErJxjFWbarI1Nw6n
 MKhATmiCsLZWUXcBboSvurVGUKk8oxBPjPI+TPKs1u1FSic+MgJ4RxLQjj2fl/LqioEL
 iy5hqMMiKNYk95+4afhzKI9k6U3byyixGiCBodhCdf61tYj8+sxspUIU60jt4BSmGVJL
 mzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846146; x=1720450946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxc67L0Wz50+CSwhbiqJJUNkuFwEkB8Pr9ZDPtyhMSY=;
 b=IBcqxBUeg1nnfuzU+C3b/NqAoC/2TLTc1b34M5E/QjSCQuaXZM8eun66vpkceS3Oxp
 ImV0AVThUw9rIWk/DVKymKKvxifILHo5v/CtbFT/xXunncb6sbuMvpd4mf2US804MezS
 KVx8suAtd95q7v3PwzT4/YUYBpMvknlsMCaXY/ixwVR256XDWjFKGThGHGocgK2qUiyt
 rZuDHZmFftv1/qjHxI5jkU8FdtchZzGH064xm7LWnWR55n3Teo32Pbfo8SYtT99tBKXB
 G7ma821h/FcsYrZVsucAJ8/Sv2lGWU2kUFV00gfB3jTm06LF1nl4EAWYrtmq/2wkibC8
 9srg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2IjKX8orOJ1Q0W5Eqi+kFyHkOzigXZv1YymofAYH8Dl6sXc4tWEAvq/QJU/WTX1gc62HV3kGboxLmTXPpQT7sLfvxB6E=
X-Gm-Message-State: AOJu0YwHDDHQwyzUV9Swv8gih6fvv+nU5DVgyWAr8/5bZeyvEQhyqT18
 U6Zxv+zEP0nmoMmDgEzGmytcJqShcw6DoMpAtWNT1wi3lfEqR0R8nBlm1bdunuM=
X-Google-Smtp-Source: AGHT+IEr9jvqHJZUaru02Q1xRzAm06qY+fIx36o2T93tCvVEOhyreaTJ7BCmr3PCnl9loujCqsx88g==
X-Received: by 2002:a17:906:6d92:b0:a6f:2835:be95 with SMTP id
 a640c23a62f3a-a7513953cfbmr368147966b.37.1719846145977; 
 Mon, 01 Jul 2024 08:02:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a752008272esm141442466b.175.2024.07.01.08.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:02:25 -0700 (PDT)
Message-ID: <73a64211-0fc0-45e4-bf11-083497d32c40@linaro.org>
Date: Mon, 1 Jul 2024 17:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net: prevent potential NULL dereference
To: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240531073636.3779559-1-oleg.sviridov@red-soft.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531073636.3779559-1-oleg.sviridov@red-soft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/5/24 09:36, Oleg Sviridov wrote:
> Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL and is dereferenced immediately after.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> ---
> v2: Debug message added
>   hw/net/spapr_llan.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index ecb30b7c76..8af33d91b6 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -770,6 +770,12 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
>       SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>       int i;
>   
> +    if (!dev) {
> +        hcall_dprintf("H_CHANGE_LOGICAL_LAN_MAC called when "
> +                      "no NIC is present\n");
> +        return H_PARAMETER;
> +    }
> +
>       for (i = 0; i < ETH_ALEN; i++) {
>           dev->nicconf.macaddr.a[ETH_ALEN - i - 1] = macaddr & 0xff;
>           macaddr >>= 8;

Thanks, patch queued.

