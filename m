Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1911DD1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3of-00085n-ET; Thu, 04 Dec 2025 02:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vR3oe-00085U-2s
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vR3ob-0004SH-Kt
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764833507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hi9W0rurMVdzFU9OfWhlolapU9csrGPjQr/FG89qgig=;
 b=WJS37ikY3pMy9gbgC5QEazTHVhDSqfKefMN+WvsMDPFqQUspMdlirX6nXA1XI3+YjrBJBl
 AhDtoV/vddEJy6OqtKAfGfv0cecMnraXihwUsaqn0Khils0b5ZpFHPxrKmX8ZRPNa839/T
 yhYT3zOlNSuv/Rfq0C5RRwV+/MmPdX0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-e_kpU2CTNDi4UqHL9fs6mA-1; Thu, 04 Dec 2025 02:31:46 -0500
X-MC-Unique: e_kpU2CTNDi4UqHL9fs6mA-1
X-Mimecast-MFC-AGG-ID: e_kpU2CTNDi4UqHL9fs6mA_1764833503
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so3377195e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764833503; x=1765438303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Hi9W0rurMVdzFU9OfWhlolapU9csrGPjQr/FG89qgig=;
 b=bmChxuw+fCMS8hLk4OIo6SLltcsjQzirVSVhIthRmUcg1v/3+7a4rw3kp4kzGuTGmk
 0vzt/vpHAX0nFF8qyCqNjGmlXNmGiN9lLAHMbEEhP5pQVot0VBkodwUVekHt1St5AxzV
 rtQPNCp5KKWD70oY3jftnKrk1gVqrsOATperyYa+iT/sy9cPi3h5dTgnp8ulb9CN5zN9
 TpyqtXCo37Ip4oCTZccbrTdsK2suJ7vYea1T2AHDspLzsNMJ0ouuHkgI4MQZ1Kd6S7O4
 uODUxi98e91QwSWVfffxaDedsmhcRunfvytveY4XdDlpKznM42rPZtCPcdVt0dMbf0Cp
 NMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764833503; x=1765438303;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi9W0rurMVdzFU9OfWhlolapU9csrGPjQr/FG89qgig=;
 b=nm2niuhGHNx0HFv9Chn9jj+q4KRDgHznL/ef7sdrMfSbI3BIEm0it7D3kyu8jV12hX
 JKc2J6+yojfa1XATllBb9BR39mFKNgd6GJKaZyUUA6Z1++SA7mutNllhnq3SPWH6ssXP
 AXdvvH+XQyWVZYZC3Ta/X4m3CWGS40MvTkxIi8VLM2iJXKvEqseTgv0gumVI6WPPYqkk
 mv+FbUJLwftje6aa5+ESD9Lbq57Dhi2olywQpBsfxTxSGljRn/YDGjXzSomEfVm5/hle
 LTEny8Lsybs48coG6Setw1bRdQK41M0JokDLYdFzJGdYOkToXOzzki6EJJXLs03+YBjd
 m8Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWayvddA3s9nsGjryBYjVECLpIgIKu8Iy3FAffmU1khm6godyiGX+1F85X4qmtdBlFPi94NFjr2L4gE@nongnu.org
X-Gm-Message-State: AOJu0YytrYcdoV3/FKbIBFNC4iUvhHWSskLCVFV1dpV4YkqGDlTAluWF
 afWvoZ/HB/K8/XYeUzgrCcfY47DTTESDYNU+eMvWGXiBBHgDuMzmHCin1tK4i9xneDRO9TSJQ/Z
 bUSqdUFEDfzXp1Y6GiJYs6CRNEAeAS8nhZb8MtbG79GMbtK4kagQ6FWlr
X-Gm-Gg: ASbGncu38xKcxdx8y5j2ZjP2pDk4ONi/Vl0hf77c9n8Qgx1zVX3neW4sJXky0+v5tXV
 xinRQxkh/nvfMeD84+qeE962iRqxZ5WD19EaudEhKbswt6MvT/GSKoUVCrAdwQDJ0EtAL9ryTDV
 hOZuxARbFSL0GukwEZm5N9iyhUdcKDYaaSWqAS7jIUDfEVKdG+XVUSLyk3nlyc5/gr5uCGhtzVx
 Fu7N4CWAY8tPtUqyNAIEOVg6ansYglINH8H/r6rf82ubM/PTtCxkuwuLc3z0WELlrnUJgKjzS+U
 vyNIUkp83hByA+13kY1dCwjy4ahetSRhe90SQFAJQnQQBNGbpwTCpPaqx6b4cHylvrJZHZQlQZk
 V7tx5eWY=
X-Received: by 2002:a05:600c:1c81:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-4792aeea8b2mr55920595e9.11.1764833503322; 
 Wed, 03 Dec 2025 23:31:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrjY+i48ABe1Ru9bPhid4NG1m9bnQXMmkCUhyv5diUFSOdntf74QgRU+HM5oO4PKc1cAasLw==
X-Received: by 2002:a05:600c:1c81:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-4792aeea8b2mr55920285e9.11.1764833502905; 
 Wed, 03 Dec 2025 23:31:42 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792afd3b31sm46709435e9.0.2025.12.03.23.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 23:31:42 -0800 (PST)
Message-ID: <f38c264d-d020-42fa-8ca0-a92420fcb133@redhat.com>
Date: Thu, 4 Dec 2025 08:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
To: dave@treblig.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 laurent@vivier.eu, pbonzini@redhat.com
Cc: jak@jak-linux.org, qemu-devel@nongnu.org
References: <20251203131511.153460-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251203131511.153460-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/12/2025 14.15, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> -M is used heavily in documentation and scripts, but isn't actually
> documented anywhere.
> Document it as equivalent to -machine.
> 
> Reported-by: Julian Andres Klode <jak@jak-linux.org>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   qemu-options.hx | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fca2b7bc74..ec92723f10 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>   #endif
>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> +    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
>       "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
>       QEMU_ARCH_ALL)
>   SRST
> @@ -179,6 +180,9 @@ SRST
>   
>               -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
>   
> +    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
> +        Define an SGX EPC section.
> +
>       ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
>           Define cache properties for SMP system.
>   
> @@ -208,12 +212,10 @@ SRST
>   ERST
>   
>   DEF("M", HAS_ARG, QEMU_OPTION_M,
> -    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
> -    QEMU_ARCH_ALL)
> -
> +    "-M              as -machine\n", QEMU_ARCH_ALL)
>   SRST
> -``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
> -    Define an SGX EPC section.
> +``-M``
> +    as -machine.
>   ERST
>   
>   DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,

Reviewed-by: Thomas Huth <thuth@redhat.com>


