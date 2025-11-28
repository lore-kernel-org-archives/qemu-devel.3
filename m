Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A23CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy2a-0002Wd-UM; Fri, 28 Nov 2025 07:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy2U-0002VV-OG
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:57:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy2T-0005RB-6g
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:57:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso9805935e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334647; x=1764939447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PQaX/QltTNqm3fwcIFoERFUth1fTW91e+uqNRpNB3Z0=;
 b=O/qzhPzdb1ROcwmKQ8ltXcJZ8yS54hQZJ9CM4apAjwr0bkxC352Vt0R/vPxuNIYakN
 orI5w8K63wFF+jcAVNzbFsJGWVAuCzBlB+xex5NqvG7N5/8Hi53YD4RUWxjpLDbE6ikr
 13xX2GsUKfgpNkWrJWSRDUeSUd5wVt8/Alx+5EuXVmKE3PvtCNKlWGct5lq9ocUEpVep
 LWkkNuWHS/YAla+ZFBIjmZY840GDlCu24I09h3lIMcEU7VfiYmQ1+mhnQldwy4w2km4N
 cI2VSiXDH2GqzaV4gGXfWNVWWbvKyNd6zIKCVxoTulKfOt11uayYpc7oFxZgqXq3CcJJ
 EryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334647; x=1764939447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PQaX/QltTNqm3fwcIFoERFUth1fTW91e+uqNRpNB3Z0=;
 b=HxO1aiFRbrBFeIHhaU1lp0QJn+klqMDsR+ucMBEBDZGCcv7mtclNjXML3HynnEDjST
 7tGqwo+7uD7OzadC4CCzHj9sOJEFNS6ujIuNUHo4eLZxGwZQFy86O2gLSruw5aDm1oYh
 POKLusR9vRoYz56brqjendI347XFt9RO4Jdu05fIVB2eicYEZTi6Ej+unRiRB6/VDnzq
 zL+548efjxKEVOrHsECF42cYKyQxfzmsERK3wy//VZFGdIez+u47eBkeD1PXI9IXzEi+
 lRVPAp1zHeQXv8mUcOnWYRzFUhGxLFushuQKPlX0/0BbX7vhcuGHkM22Rx80W6f6ZErX
 hzyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSgz49MhEO9WOXEei2nXRXyG8/9tQuBjHfDQCh4LRxwL1OjfPFSjT9qBJnMoXKlRaVyN09sc6mmcPc@nongnu.org
X-Gm-Message-State: AOJu0YwdhPz4Tu2BiCT8HqjfJMddOIIAwBTSKsnAibCCp/EcAka6BGwM
 EAsc3hgePEiL8t8IclIFAW18yScKeCJ6nMqaz/TjxrBpcxZ1YKBej7wJlzi7A6eI+N4=
X-Gm-Gg: ASbGncsJvZGQwB2udm7Yf153EXLUmWebXO0TRTcUgzVmaJTGjym8LpBQNo1jeDNBIxm
 BI8VpDwU2NrVKoAugHXkpkW9ueEPy5tVOX0snfrYGxfR0rYo7IfzP/kKD3hgvHqPAVBal3QusMW
 kIwa4e60zc8hAwVx6Hac+5zyu4lZtxeKpW7QAuYiHDPYgdT+bv+1imEh2SgwIbDiXE1qvFAeHdo
 VP9EsV6H+4oqFSALpCtQsHaATReCYMinKuKSsuHt+wN+007efI9xlFbHOZKnrHyaXl53EQdPSjE
 iisTb/K4mI3cS2SZE/+13nTbNVDDOJ02P//KQgwlFbxqLlpRyckz19TVxtcqpuXhE2ScN1w4I6w
 Z8fxWyYsl4vC7rQqUk31uyn1yOx6bp1O4MfKMNsGMuDqBdZo2Xi5fVNoh0OodB7kyomBxvrXv3x
 BP16dUBczhHKjGQXt9l0kRrCtDpHBfqLuZbSDmxCXwrzfVvSmGVhbGhibnrWqoJ7lA
X-Google-Smtp-Source: AGHT+IG65iZbQxckgG+WkXzdfbCi665ESyWBjDVu4GaezecdQH077Y664I5XX05e6RCA2U8HG2adZw==
X-Received: by 2002:a05:600c:310f:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-477c1125568mr312362445e9.24.1764334647493; 
 Fri, 28 Nov 2025 04:57:27 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add4b46sm158969195e9.4.2025.11.28.04.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:57:26 -0800 (PST)
Message-ID: <6041639d-a63d-45fb-8466-43290bfa6567@linaro.org>
Date: Fri, 28 Nov 2025 13:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] edk2: drop 32-bit binaries (ia32 and arm)
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128084524.363989-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128084524.363989-6-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/11/25 09:45, Gerd Hoffmann wrote:
> Keep and rename edk2-arm-vars.fd.bz2 (identical for arm and aarch64) to
> reduce confusion.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
>   pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
>   pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
>   pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
>   pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
>   5 files changed, 0 insertions(+), 0 deletions(-)
>   rename pc-bios/{edk2-arm-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} (100%)
>   delete mode 100644 pc-bios/edk2-arm-code.fd.bz2
>   delete mode 100644 pc-bios/edk2-i386-code.fd.bz2
>   delete mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
>   delete mode 100644 pc-bios/edk2-i386-vars.fd.bz2

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


