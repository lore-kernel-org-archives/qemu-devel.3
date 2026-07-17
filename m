Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FB3C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiCI-0001B3-Nt; Fri, 17 Jul 2026 09:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkiBk-000195-Sd
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkiBi-00047W-Mp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784293269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EodF7DQyUGkeM22LFxe7SrfurNa2rmmT2tJtZX2I5vE=;
 b=C5yyosPxFTzbtsroPcMRwwWCleRWB7DujZZ6lYB7VKrEnK5rJujcwj2lv34SLbmN9Z+pEy
 FudsBH3JneZQu/Qgp7QsHsCx9auVj4SHyIGB9+nAKInPg9G74qt5pi2I5NDHegi5XRvsL8
 KhLltAY3vIUCast5Wk+5TCRt8wlvVWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-5sb3z9h3NpCoZw-BAPRWGw-1; Fri, 17 Jul 2026 09:01:08 -0400
X-MC-Unique: 5sb3z9h3NpCoZw-BAPRWGw-1
X-Mimecast-MFC-AGG-ID: 5sb3z9h3NpCoZw-BAPRWGw_1784293267
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473bc66c837so6605680f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784293266; x=1784898066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EodF7DQyUGkeM22LFxe7SrfurNa2rmmT2tJtZX2I5vE=;
 b=sZzXurw9mpgx8YXrAMehNk1K7Vaz3jnCnCYGv4B4nQOU//FjakIt/SLpUXFJZi5E9H
 qVE/NSFX6+By8Cvc4sFPfw5/Y4q1CI89nhk6rLoYByo2kV452KetGnmeBX/ZWRsi5jnO
 uQfg1bmZ+b7th5y0z5J8Ul/MykGggMNDPzM+/O/KsMTTzQhiWFMQmwwp50nUTtHjXwKM
 63QsdkEU52xPnMqprxF744Sf792NvFCDjM5eRTMvITbswpsIbmiuesgZppuqLcnnM8E0
 W2Ib7y4QO3czZle1D0suq4zsI0kvgbboKYG+WMz8ZsfUG/R5NrF+JqF2XqPewckZ05mn
 npOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293266; x=1784898066;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EodF7DQyUGkeM22LFxe7SrfurNa2rmmT2tJtZX2I5vE=;
 b=PBhoxgvizXNmibRWK6sjwC64KZeGJDxJOehHw7Ip8HMe4lKumaat3v1hpRNGoVCyFc
 swGn4JgNtKVXwh4cSWE4eURM8XKnEcKmte7eHKXFFyQ6nPE1TuXQ2palsKDSoW0bIqbb
 SuMd7hP26pqfJr10xC2Gjajj5Sfrzw5p/NiEGC3AuP1ihj1Z/46uzLOyKpeFqCTMC33e
 QwIpC/UWIY2VWxz9PVH8bGE86U/O7HfZjbY6xtEeB1Ogc+FaqkbgbvOgpbsVxVlTITVc
 hh/k4frs1ATmRJzBB2nLlSsGCmzbpBjsfAdNFAkdvNFMEo2dOqz9KGXpyRhCb/rn6Pnd
 eptQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rokn8NxF/x4u3YqJnNKWXDW6mIv0x7aC14Y+4WXYq7OWk6t6s0vuegNfTQhp4qb0dVSd3ERLHvTORZY@nongnu.org
X-Gm-Message-State: AOJu0Yxwed4Sz+Ep0uha0JZCp5fxZYgSap8ycC6R9v/ebhBntUvPqdMQ
 /8HRxnd+DioGtmA+uSRHXu9I4jqRLsnU0xSM2zgGfmZ/5A0sEic516umm4RSLHyJhrteRLdWUMm
 JGYun4ONk2UPPpbnCMqujkCdhqr5BovCed+qX876G8a8IprISIeVByoYU
X-Gm-Gg: AfdE7cmqg1pCBOesWG2sVvDXEo+HkZ9/CtKR3EYFcCMKLIVOJLqPjLZz+hBxNpbbaOx
 Wof6FQDJ3DN2EB9J0ZZOs+MtOL02EOO7hcRNZkzqzqSlAM7KYDMN4qN1bx5uv0yPCNLmf3tEYsC
 OFn5cPVgCkiL38nNToHEHFz1VMOpBAnQ71D6NZMwgVyqHKFQXaKOZUBIrvvJ+riwx9m+y4hWvoL
 ilcqfcvU0tEfk9k/baU96OKdEsZ9oN4cLlkOaMM1fYZpLzN/+Vp08A4BWKM7O+0c2h/RLoB0uHW
 54v5RrlJ1f6+pD9Ts+hhVtB2VEgvdCbAh/sEwJAUoaqWA+pHn216NysNMMdamQ7MhPm69PRe24A
 hjskFWKF44vLsU7PEdGHhIH362CBiaZq8Wg6IL5k=
X-Received: by 2002:a05:6000:2484:b0:47e:8e1b:3319 with SMTP id
 ffacd0b85a97d-47f6230e6f3mr3507631f8f.15.1784293266530; 
 Fri, 17 Jul 2026 06:01:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2484:b0:47e:8e1b:3319 with SMTP id
 ffacd0b85a97d-47f6230e6f3mr3507543f8f.15.1784293265833; 
 Fri, 17 Jul 2026 06:01:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52673sm4063167f8f.15.2026.07.17.06.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:01:05 -0700 (PDT)
Message-ID: <31e410ea-c590-45fa-ac20-98ee1048f19f@redhat.com>
Date: Fri, 17 Jul 2026 15:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/pci: reject invalid PCI_INTERRUPT_PIN values
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260715191735.2454719-1-den@openvz.org>
 <20260717122232.468955-3-den@openvz.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260717122232.468955-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/17/26 14:22, Denis V. Lunev wrote:
> qemu-kvm aborts a few seconds after starting a VM with a
> passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
> out-of-range value: vfio_intx_enable() only guards against pin == 0
> and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
> value later reaches pci_irq_handler()'s
> assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
> pci_irq_deassert() -> pci_set_irq(), aborting the process.
> 
> Legal PCI_INTERRUPT_PIN values are 0 (no legacy interrupt) or
> 1-PCI_NUM_PINS (INTA-INTD); reject anything else before it reaches
> vdev->intx.pin, whether the out-of-range value came from a read
> failure (now caught by the previous commit) or was handed back as
> data by the device itself.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alex Williamson <alex@shazbot.org>
> CC: "Cédric Le Goater" <clg@redhat.com>
> ---


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>   hw/vfio/pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8b8e8b6379..f14cc8e99a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -338,6 +338,11 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>           return true;
>       }
>   
> +    if (pin > PCI_NUM_PINS) {
> +        error_setg(errp, "invalid PCI interrupt pin %d", pin);
> +        return false;
> +    }
> +
>       /*
>        * Do not alter interrupt state during vfio_realize and cpr load.
>        * The incoming state is cleared thereafter.


