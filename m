Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E140C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9dQM-0005kK-Pw; Tue, 29 Apr 2025 01:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9dQK-0005gC-6V
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9dQH-0000NK-OE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745904144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gOVwsbPORcgoQp/LsLcCTQu/V1bgR6UpWgYnDVBuJ+Q=;
 b=W0/7Khd9xVzvfAUMD31rC+gxr84tIkT2IP692E+srHE2XIs+bwP4zrkJ/rVOBukD12cKaw
 YiVRiAI9Pla5dFiTVTy33W14AzVCEjMr5+rUMdRm7bQ4ZjMKa/cD5tqEDHxpU6rcBwdcz2
 /kP5GnGQH4BhoTIUvrpeJoYUGIOq8aE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-dDDPXP7SPQe3wO9dCWQ5NA-1; Tue, 29 Apr 2025 01:22:22 -0400
X-MC-Unique: dDDPXP7SPQe3wO9dCWQ5NA-1
X-Mimecast-MFC-AGG-ID: dDDPXP7SPQe3wO9dCWQ5NA_1745904141
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb8d1231ffso406118866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745904141; x=1746508941;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOVwsbPORcgoQp/LsLcCTQu/V1bgR6UpWgYnDVBuJ+Q=;
 b=WeJcHb0Uq9CCQSvEhzlnWfbToWUdhsTRpu2FiwA3gSseRse2FhrZ/VfjcbSwEN5DNt
 dDmPNnBWia8UbA5IYMjOYLNn/P0JKdfVhvXM1vmoq/L3calPcjCrfcSe/m9OoCq+wopX
 RvRGZerB3jqH0fEg1ImpOEhMEeupX/USmvTR8BBXRDwJT+9aJF0OLXSSrpoZpcEwFsih
 2Ld1PHnSll0F2vM8urwSLucl9QGj9+g6oOcKn2GR43Q6I1P4TJ4jr783URR5SRgYD5jQ
 dPVpXZMkdU1cLc0xBDTUzdjo6nN0/7IUQthZLJXtE+C8XoW6rhZo4M8WZsQl4JMYmFaM
 jGQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIe6Dr/+UtJSH7EryCPr04Nd3WpN3MdNdVMPj+Sk7VDXxQAFRQaL2whaJWNpFjuHXZBvcBebxrA7wj@nongnu.org
X-Gm-Message-State: AOJu0Yzqv2MiUQ4Hn2lRE4Q+T9mvZ/d2BTUfN4eDs3ENnaGcNdyk8BwB
 lrQreqhU6wMoiQkEzIj9Pn8Zx44ZF4LJDOyFpCgF9eloFmulc65YN2nW8OmHJO30Gek1UY2WYK+
 K4wPlqxdPMWg3fKeSwxyihkiaX9PWvWyx12N99/4LPN9+oo3vHexy
X-Gm-Gg: ASbGncvs+oi8bR08S5Ajj6pCkNUNgbtKJGyAOWVzMyHnIUmqgSWbjU4iYY0bzuQP7yJ
 Ia3MaA2F/puLpUiUlcgXSGs4C5OAJwaGGwUREf/WewnpJtgEuBpNqXfqnMZt/LdGw36/MuiDMgz
 gD74qnFadLz52PthuFiIOfmyEU8Tc5ZXCSoVGPhlmn4r551viNeP73fRzIKAbglMuoORamoVf9v
 lYvBWB96isJjcfGIWSiYcsTH5qRycpwoBfliuRR2mAaDf6hYrc6J8Snjyuwqrxi/yPVU8CZ2g/o
 StAi3WqnNIUbnj0UaNAK46KRPuYYFmU+2xJ/4A0p
X-Received: by 2002:a17:907:7206:b0:aca:96a7:d373 with SMTP id
 a640c23a62f3a-acec4ed9e96mr246162266b.57.1745904140985; 
 Mon, 28 Apr 2025 22:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZO12vzQBj4U2bvSWeCGRgpWHL8XPXW+4MJIAq8UqfzjNBUFiagiR71fsWyMvgjXyCDO0lRg==
X-Received: by 2002:a17:907:7206:b0:aca:96a7:d373 with SMTP id
 a640c23a62f3a-acec4ed9e96mr246159666b.57.1745904140593; 
 Mon, 28 Apr 2025 22:22:20 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6edb1e60sm715584866b.183.2025.04.28.22.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 22:22:20 -0700 (PDT)
Message-ID: <9f72389e-7adb-425d-8ab4-5770c8b89e9c@redhat.com>
Date: Tue, 29 Apr 2025 07:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH QEMU] x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__
 in UAPI headers
To: Alexey Kardashevskiy <aik@amd.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20250429001705.2734439-1-aik@amd.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250429001705.2734439-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 29/04/2025 02.17, Alexey Kardashevskiy wrote:
> The recent kernel update 8a141be3233af7d broke the headers update,
> fix it in the script.

Thanks, but the same patch is already on the list:

https://lore.kernel.org/qemu-devel/20250425052401.8287-2-rreyes@linux.ibm.com/

> Or we want both __ASSEMBLY__ and __ASSEMBLER__?

It's about one x86 header, and for x86, all macros got changed, so I think 
we don't need to check for both here.

  Thomas


> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7d
> ---
>   scripts/update-linux-headers.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 8913e4fb99b..b43b8ef75a6 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -177,7 +177,7 @@ EOF
>   
>           # Remove everything except the macros from bootparam.h avoiding the
>           # unnecessary import of several video/ist/etc headers
> -        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
> +        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
>                  "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
>           cp_portable "$hdrdir/bootparam.h" \
>                       "$output/include/standard-headers/asm-$arch"


