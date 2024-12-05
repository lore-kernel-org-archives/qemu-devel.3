Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F67E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEQM-00020V-K8; Thu, 05 Dec 2024 11:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJEQK-0001zs-34
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:09:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJEQI-0001U5-AU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733414989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EsvhqekRj8pSgByReoQUTkJu/oYQaDoS5+V3eLnOXYw=;
 b=PlPtluT+ZCSzNXwUOMBzEh5nRHd74kZzIIEPh8SPrrb5FoqwaSncYQDMJOPy05Mn8PRaNt
 C4C2sIME7IKXMm+6nNXtc/kPtIwJpqOYdkoD76eJquhWjqi40TkGLwBJuij7YD8VKLhCbS
 feQS2SW4TIPtQXrWBxMtBS1j7n9gU2o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ZcxYkykjOb6OkFivYawWlA-1; Thu, 05 Dec 2024 11:09:44 -0500
X-MC-Unique: ZcxYkykjOb6OkFivYawWlA-1
X-Mimecast-MFC-AGG-ID: ZcxYkykjOb6OkFivYawWlA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4669be6c87aso17895851cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733414984; x=1734019784;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EsvhqekRj8pSgByReoQUTkJu/oYQaDoS5+V3eLnOXYw=;
 b=YIMP/uKRWGH9t7/ExlETwTCIlk67bwRAZ5lM8807rCxdVuhBXbCSkEUzqezprUZxSQ
 aVwLOmbpGSqmKWaT1j0jzIoL/Tm2skERq67rN3+B7wdx/blkFo2/j/VoHZZOC8494H91
 qr5nZg0snxRnGMHTqI4GdaXkhPMd+DH4rj8dlagnrXkkpUKL2jm5SvbEXOxWOU5stcjz
 2Vf0Nvl3XBWIgiEjzXRSQ6EqPLNinXwB4K+kgHuuP2sIJswMoJUM0lLDjSetoSE27H6J
 BedIGjIsYVzWnbi7xsG9WRp/6zkUpe7YpUnUPu9Wv3qeJuCFMWU3nK04m675ySHSU6mD
 DBHA==
X-Gm-Message-State: AOJu0YxanvDg9J9A1KqyVLKnzAUexhpU97Q3KDeWQJnT2A6NEUPjBO7p
 Y1ZZb/M2dE2nBsr+S+SacHBnfNT3cxnDxMTNl/wOpKlBHHfG6VklyfrSzAtihAi1wPysDTZ5eoD
 hEIX9q8hsL3DnCTPNRZVTCJmwG3fV89lUFzSuZ5emJYO6JA9YOcGV
X-Gm-Gg: ASbGncvvCO4NW0TaZ6JlNcYHJ/zOEuXQ8c+XG94kkSkn8pe1ST8oYimE9zxR2yN4LEb
 5Bp5IOYlz1pfjrOk+RcaufEJF63uhDqYfLchWyvHPc3q69++5HMM6FzHoX06t6Jjjhq+3tPbA3I
 WIO/8oNayubUSh5y2FGQ5M2lF9euQ5J6RTyh1SN+P8jEwpfeci9YubFOoenF5BLw6dkgcduyIyK
 ASsfAOPNG/lo7vWk4+0N0QEUcfxRvNmcbWC5MmL36Q3GGuJNTR6
X-Received: by 2002:a05:622a:c5:b0:45d:5f8c:8280 with SMTP id
 d75a77b69052e-4670c39ac40mr164530191cf.35.1733414984327; 
 Thu, 05 Dec 2024 08:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4ogBoO6oxxetfKmfXfVD01k2GGF7Ih8yAElhaQQx92Dml9FwhsEZDxszJogbUalSdz7BD4Q==
X-Received: by 2002:a05:622a:c5:b0:45d:5f8c:8280 with SMTP id
 d75a77b69052e-4670c39ac40mr164529941cf.35.1733414984036; 
 Thu, 05 Dec 2024 08:09:44 -0800 (PST)
Received: from [10.20.9.127] ([144.121.20.162])
 by smtp.googlemail.com with ESMTPSA id
 d75a77b69052e-467297d6bb5sm9194401cf.85.2024.12.05.08.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 08:09:43 -0800 (PST)
Message-ID: <adb80a8c-ee40-4d8e-898b-a62d12746aa9@redhat.com>
Date: Thu, 5 Dec 2024 17:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/13] rust: add a bit operation binding for deposit64
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-6-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 12/5/24 07:07, Zhao Liu wrote:
> +pub fn deposit64(value: u64, start: usize, length: usize, fieldval: u64) -> u64 {
> +    /* FIXME: Implement a more elegant check with error handling support? */
> +    assert!(length > 0 && length <= 64 - start);
> +
> +    let mask = (u64::MAX >> (64 - length)) << start;
> +    (value & !mask) | ((fieldval << start) & mask)
> +}

This should be more generic and implemented as a trait that is
implemented by u8/u16/u32/u64.  It's okay to rewrite these utility
functions in Rust instead of relying on bindgen, because the way
you'd like to use them is likely different from C.  Something like:

pub trait IntegerExt
{
     fn deposit(self, start: u32, length: u32, fieldval: U) -> Self;
}

impl IntegerExt for u64
{
     fn deposit(self, start: usize, length: usize, fieldval: u64) -> u64 {
         /* FIXME: Implement a more elegant check with error handling support? */
         assert!(length > 0 && length <= 64 - start);

         let mask = (u64::MAX >> (64 - length)) << start;
         (value & !mask) | ((fieldval << start) & mask)
     }
}

And we can add a "prelude" module so that you can do

use qemu_api::prelude::*;

and get all these useful traits at once.  I will send a patch after
fleshing the idea out a bit more.

Paolo


