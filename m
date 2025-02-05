Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBE0C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 06:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfZFc-0006ri-J6; Wed, 05 Feb 2025 01:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZFa-0006r8-9l
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 01:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZFY-0002WX-E2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 01:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738738262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/wHFPQoZwBbyyoh1UEJ9YFvf+EH0FcfNTekMZkAa0Hs=;
 b=QnK35JBqyacwVcTZ/5suj5vtuToyUsKGZKvAU5R4jl1Y63o5O2q2bgsrd6UCeIxLTKCAeV
 h5k/KD6/yuRRnO7UHPJdIM/dYuX6YM2vwwSbv6kf7QPrXnc6/r4aqLd8LCWwaSQr3dGCI4
 wYRr9OdN8TMbID/PVTDOkGw8eNHA7/U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-XP8RUBGzNVeBPjRyJQ2LJg-1; Wed, 05 Feb 2025 01:51:01 -0500
X-MC-Unique: XP8RUBGzNVeBPjRyJQ2LJg-1
X-Mimecast-MFC-AGG-ID: XP8RUBGzNVeBPjRyJQ2LJg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa66f6ce6bfso469811866b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 22:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738738260; x=1739343060;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wHFPQoZwBbyyoh1UEJ9YFvf+EH0FcfNTekMZkAa0Hs=;
 b=UKRTmU5EfOFQHZqgvNXeG+aSvIWWpdCA7XtGcswlW+DVlXY6h5C1sAU0hrIXKrhPef
 mUPJ6fbtMULEUUOIwe3m/SepyX29OOSLyUif+CmNoBoDnk4fTRkMQRGvAZc3/MihnNcY
 KA7wZBBIrxU7cur/4CgJNLfNzPdSK7prboBoMULDZWwMM+UVDpEJCQSYRJ7B6zET4aO0
 0t56dXAyIjoFRes4HLKCXp0j3gKDNV+dxJsxtbYemYUZPt2iC/mg4nXFexGo78NfVNCb
 BIVFU6XJqFPZSWteEJCqTi7AwdPVbXk/wdkbYxrxFvNLGn7lc2+59ZImPv6AWr732GPM
 yRrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXu78MNYN3+zeBqUICoSYcYQheTXoinUwgzYRDf2kuWj8/LNpaeZJoKiks6+5J+E8HrRhts2FH+kGB@nongnu.org
X-Gm-Message-State: AOJu0Yw1d2dkFkVvUeImDxu6a9Cd5gq+usmPeaeV7jRAD1kyLCHFprAE
 65wvcyfS+o4i1XegmH5o/X3CeCXIAs7WAww3siBjGC/M3LT3UQUOJGovm2+6mRfwEK6yCRWUepN
 cEr8APLIY5dcmRHsAmEQFYZW4HDRC0uX+EcgTGUk5sK5jTFVsNLUP
X-Gm-Gg: ASbGncvk+XgfCXR0eSsT5NczZ+p1J1sGZwBlL9D+uFI10Vnq/VE1klyKa8O8jN91bCI
 CZQRD7ltBCEtmadk7/jXPoG/BbWDCdabV/nFeymR3Hc0x5SMrj34kMKZKGE9yIuDdMjptrncBp6
 nJfwgOxBN66qltIoE8nOT/FK5l250HIjQ2TD1lwMD7xgJmV0YxFQH4LpCO2jPggYo8QU0OWR1RZ
 xjmhyPAAZSSPQVwx2e/CbX+nH6fthYk2JS2yUlWhicSwF7pkR/jRqPUb0tFpsvrv3F88lc7AfHR
 wNO6LeiGgkms4Y6iFcuhdhvKDlDNNJMT87uN
X-Received: by 2002:a17:906:794e:b0:ab6:949f:c52f with SMTP id
 a640c23a62f3a-ab75e2656a1mr131189066b.28.1738738259700; 
 Tue, 04 Feb 2025 22:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6i9IgjRFxzQDcv6Q8aNoz88sd3f7sSRYWY3EK9oViiH4axZUxsuerBrjJTZVBb2y5nYubLA==
X-Received: by 2002:a17:906:794e:b0:ab6:949f:c52f with SMTP id
 a640c23a62f3a-ab75e2656a1mr131186666b.28.1738738259319; 
 Tue, 04 Feb 2025 22:50:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d11a2sm1055561566b.64.2025.02.04.22.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 22:50:58 -0800 (PST)
Message-ID: <56d285f8-2edb-4194-abf3-dd39e635a0af@redhat.com>
Date: Wed, 5 Feb 2025 07:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-7-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204215359.1238808-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 04/02/2025 22.53, Richard Henderson wrote:
> Require a 64-bit host binary to spawn a 64-bit guest.
> 
> For HVF this is trivially true because macOS 11 dropped
> support for 32-bit applications entirely.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0ca83135e2..c80382befd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -319,13 +319,16 @@ else
>   endif
>   accelerator_targets += { 'CONFIG_XEN': xen_targets }
>   
> -if cpu in ['aarch64']
> +if cpu == 'aarch64'
>     accelerator_targets += {
>       'CONFIG_HVF': ['aarch64-softmmu']
>     }
> -endif
> -
> -if cpu in ['x86', 'x86_64']
> +elif cpu == 'x86'
> +  accelerator_targets += {
> +    'CONFIG_NVMM': ['i386-softmmu'],
> +    'CONFIG_WHPX': ['i386-softmmu'],

We dropped support for 32-bit Windows last year, so I think you can remove 
that WHPX line.

And looking at the NetBSD Makefile:

  http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content-type=text%2Fplain

... it seems to me like NVMM only gets enabled there for x86_64, so I think 
you could likely remove the NVMM line / the whole 32-bit paragraph here, too?

  Thomas


> +  }
> +elif cpu == 'x86_64'
>     accelerator_targets += {
>       'CONFIG_HVF': ['x86_64-softmmu'],
>       'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],


