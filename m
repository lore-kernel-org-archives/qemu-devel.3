Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D7CCCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU9F-0001Aq-Qc; Wed, 25 Sep 2024 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU9C-0000kF-JZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU94-0004n8-4g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4H1mVLbJkWGPsw9d0frYmP7X7L9IKi3hcg+OpRtg4RM=;
 b=S08XznwgpfQiD672bHyX9pCGHgYo/qgA3d3pb6S9vth00SMHIomvlwh94Iz4DQ0iART4lu
 Dv3xueYypGVlxcziQxb5tQ8W3nZEOEwfCxr3ZU35DrDZF86EHAvENuzaEXvg5gjI50JIY2
 4yE2tLfBr3AAKAc4OteZ3nIdrfQdcpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-8tvGTyJyOhaLiAqtRLRcoQ-1; Wed, 25 Sep 2024 11:41:36 -0400
X-MC-Unique: 8tvGTyJyOhaLiAqtRLRcoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb6dc3365so52737405e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278895; x=1727883695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4H1mVLbJkWGPsw9d0frYmP7X7L9IKi3hcg+OpRtg4RM=;
 b=pvIMMSeJbIFVw+vNqj+6FsQ3012EwFWuR7nSQduuju+kSg/A/yKSgA1aYTpdaWxMwO
 6jf4r6sOJVLAN94AmfmoLF+HQl8mY1RnMr5mSzwDkEmfu2fzH7Gi23hv9Ko6KL9UeZmA
 YqRnnD7WlmOtpTffV2YtsDT7F1zQYzsQDrZnFk76LlgSw1vfs/rdwU6RcL07wR/X8/FE
 CnC46/b5N/VdwPovkeV06q67HgttIyRXhiACOJ6b2UBpDtHVB3RixxqMFd8cqgLBBbbx
 hEWcuyNdSd6k1WAo3GOqpCTaTY3wzEHkL0rkKY/wsnDCeFRWRjKbi+oFkuajeru5NJuX
 9gAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzDCfqzoAAI1Axmzguf+uMXxxwAhJlnohs4yQTHswS2jfptV2K36w0/06JIai7u5masqaIQy//KRJF@nongnu.org
X-Gm-Message-State: AOJu0Yybwtw82EmmAqXb90ypechIjSjdzWAzkfKROIyW+vTOZEWwkVL1
 9JatliRuZOyKDlAdjg327j3Aimm88u/2mbj4WtyJPIiknjvB1mFEYfvA+FbsKLpxdI84OuDLuuv
 7CmApbTAD2Zm99ohjTNWfb+LPPKBVPPhxaBzg/MjiAm2M6PFQF/2b
X-Received: by 2002:a05:600c:1c82:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-42e9610de39mr24637445e9.14.1727278894985; 
 Wed, 25 Sep 2024 08:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQlF64amEy1UKJDzyHHrK5NZpzIJwkAirHftSVs0XCtJyNvW4OaALpQspsZ31cfGQi33OH1Q==
X-Received: by 2002:a05:600c:1c82:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-42e9610de39mr24637305e9.14.1727278894559; 
 Wed, 25 Sep 2024 08:41:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a17d30sm22421305e9.40.2024.09.25.08.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:41:34 -0700 (PDT)
Message-ID: <1a6f68f8-7107-44b8-971f-b962d64255d4@redhat.com>
Date: Wed, 25 Sep 2024 17:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] hw/intc: Guard openpic_kvm.c by dedicated
 OPENPIC_KVM Kconfig switch
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-18-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-18-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/24 11:30, Bernhard Beschow wrote:
> Allows to clearly mark code sections relying on this device type.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/ppc/e500.c       | 2 +-
>   hw/intc/Kconfig     | 4 ++++
>   hw/intc/meson.build | 3 +--
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 4ee4304a8a..149e608324 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -828,7 +828,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
>   static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
>                                             Error **errp)
>   {
> -#ifdef CONFIG_KVM
> +#ifdef CONFIG_OPENPIC_KVM
>       DeviceState *dev;
>       CPUState *cs;
>   
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index dd405bdb5d..a3df98ae59 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -16,6 +16,10 @@ config OPENPIC
>       bool
>       select MSI_NONBROKEN
>   
> +config OPENPIC_KVM
> +    bool
> +    depends on OPENPIC && KVM
> +
>   config APIC
>       bool
>       select MSI_NONBROKEN
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 6bfdc4eb33..b9de6bf5c6 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -48,8 +48,7 @@ specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
>   specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
>   specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
> -specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_OPENPIC'],
> -		if_true: files('openpic_kvm.c'))
> +specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
>   specific_ss.add(when: 'CONFIG_POWERNV', if_true: files('xics_pnv.c', 'pnv_xive.c', 'pnv_xive2.c'))
>   specific_ss.add(when: 'CONFIG_PPC_UIC', if_true: files('ppc-uic.c'))
>   specific_ss.add(when: 'CONFIG_RX_ICU', if_true: files('rx_icu.c'))


