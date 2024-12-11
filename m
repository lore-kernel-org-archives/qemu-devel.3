Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4968E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 11:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLL5T-0004xb-Ln; Wed, 11 Dec 2024 06:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLL5Q-0004xF-Hb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 06:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLL5O-0001Ra-Sd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 06:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733917255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g0+vRHgQKWrTIdbAyngV5f9Ylm0g+CaMM+3u5zwSIkE=;
 b=BtHRbDJ8lgyEPiO7wwjw3tndd/S1LON4jjvCsi9lIvA3a6GwCKJ7IPd3nRz+eukkaPSsY1
 WgHPnhLh6TP/4uzk+CN96f49ZSB3Cnw0u4wo36AMgNm1lyPRn0+kGEPtBXyG8Fp6pRJc/a
 cQ9/WxSuu7ce/h/X7wavc399sTS0qDM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-SOIcr4prOyGDbPFEy24ytw-1; Wed, 11 Dec 2024 06:40:53 -0500
X-MC-Unique: SOIcr4prOyGDbPFEy24ytw-1
X-Mimecast-MFC-AGG-ID: SOIcr4prOyGDbPFEy24ytw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1b0373bso176104085a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 03:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733917253; x=1734522053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0+vRHgQKWrTIdbAyngV5f9Ylm0g+CaMM+3u5zwSIkE=;
 b=hFbO5Yf0Ns9rg6IDHAkwLPKnRoP9bs1lt0BH+zUf9c31MdGWNBW+4m6uGTPuelhcq+
 RuSp//rJ2jbNKpb4Fl6NlaG+ERhbqD24jBkPjIjDPJdMFcBgcAcNwamnWUKNbpoGUIQv
 ab4xosYJEI1riToANCaueOl3hFpS10bUrq+cOWozdn44IXO+BY6VY+iZSROaZlIHgkBN
 rEUZ3tIkHb0IlGvF3HOw1lLyoB6sNS4ofTZstT+JJi9EaunH1Z4N1VmFdXcgpr142FPI
 NnclG/ADab6+2unDs3avU0vUNtt3AMsT8miic5TWEUF474OJ26pWJjDLuGN5F4s0jqWt
 tahA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFrpFsJ+EoSqjS47l9l1g7wiySTpjMSwc1uMma0TkJ4anlDi4o71GjeM8Fy0Q0WtVo+u0KfUiIEQU@nongnu.org
X-Gm-Message-State: AOJu0Ywab0FtgALEY9vDHFw/EC5AGAGT7laAK3EfZzQ1O3kbXvjPxw8J
 60TzfWlGiFEXh7b0isheCuNkdu4QgQJWS+1/dn6qoILRGbDqdKSiNwxen6qtJCm612ULxF+EPKk
 EP27wLCyet+yuO/hoa40b6dv+FlOyMAxTH/QNXIAzS8qpd3G7Uh8O
X-Gm-Gg: ASbGnctiqmdiObhkEOtLvZ0cIy9UUzZXmLjrHnnB15SQJJtaKDfHasBLH89AzqORowz
 rWfnn+4B5tIlpP36VWIBA5edD/Eg3JyrgswsPjdyv+B4EYNNu1UbVD2/nI8tJlRU6ffFEHJwP2s
 clSH5iDwdjZsTcmSxx3UU5WKamylicXphiOO4HFBFrU/DnKtKPmaCy3hn76U3PNPpPrmGK+f1vs
 u4QumjQ9EPnMB2srQpxN3qcmrVxHklAirKmm1PBadf5KGwB1dLCathKn9+5uextxmVbjNLgeFrJ
 vIKztVg=
X-Received: by 2002:a05:620a:4088:b0:7b6:d8da:90a3 with SMTP id
 af79cd13be357-7b6eb525549mr503030585a.44.1733917253205; 
 Wed, 11 Dec 2024 03:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjB9xsy2g/+9hfSuayp4TDdfytsaN/QZlgyTdsS8fFhngegUo76Ws05Fzw2DDKcwRtg0zxXw==
X-Received: by 2002:a05:620a:4088:b0:7b6:d8da:90a3 with SMTP id
 af79cd13be357-7b6eb525549mr503026585a.44.1733917252889; 
 Wed, 11 Dec 2024 03:40:52 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d6313ef6sm281754785a.0.2024.12.11.03.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 03:40:52 -0800 (PST)
Message-ID: <7d860eb4-9e59-410c-bce3-ca6627a46533@redhat.com>
Date: Wed, 11 Dec 2024 12:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390x/pci: indicate QEMU supports relaxed translation
 for passthrough
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-3-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241209192927.107503-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09/12/2024 20.29, Matthew Rosato wrote:
> Specifying this bit in the guest CLP response indicates that the guest
> can optionally choose to skip translation and instead use
> identity-mapped operations.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-vfio.c        | 4 +++-
>   include/hw/s390x/s390-pci-clp.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7dbbc76823..51ac5ff3eb 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -224,7 +224,9 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
>   
>           resgrp = &pbdev->pci_group->zpci_group;
>           if (cap->flags & VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH) {
> -            resgrp->fr = 1;
> +            resgrp->fr = (CLP_RSP_QPCIG_MASK_RTR | CLP_RSP_QPCIG_MASK_REFRESH);
> +        } else {
> +            resgrp->fr = CLP_RSP_QPCIG_MASK_RTR;
>           }

Just a matter of taste, but maybe easier to write it like this:

         resgrp->fr = CLP_RSP_QPCIG_MASK_RTR;
         if (cap->flags & VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH) {
             resgrp->fr |= CLP_RSP_QPCIG_MASK_REFRESH;
         }

?

  Thomas


