Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC476D3517C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ve1-0002N2-Br; Wed, 01 Apr 2026 09:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vdu-0002B4-7x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vds-0006AA-Ev
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:29:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso91479515e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050195; x=1775654995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHAVsCsC8Pt2G9bwpio7qpW5H3otap3+Q97quMFDQOU=;
 b=uYUhmlYkaYzRerobb9+v9Q8HPWW3JAaYEtAvpXSxxR0+Cq7MR/1JyCT/uiv3K7oVEB
 2N0k7m8m8XWUeSpAHpkhKnB7vVcUiVpWCZksS8h5H5upTHGxvLRY3uOmq0Com44xyfeY
 WE1NaHDASncvYv9Kj4uRY/+wfasDgPNHH5ygPgbY1bh1mYTofrLhbNpO3kYF6Mm4a862
 /v/CG4MoJShUVA/sgB8A3efLoVEz9y/tSMAXxg06TFU6UmeIMJMR5N24BjM6dY3kbzM6
 cBQv2PrRnimyWbraH7sn2mPjumRAKDmucKbHmCHB/fjnpcIOFO9Dgv/+njXE7WHAVWlE
 J2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050195; x=1775654995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHAVsCsC8Pt2G9bwpio7qpW5H3otap3+Q97quMFDQOU=;
 b=MKKLZisNR4/Tc9ll0E5E5IcIdiWGwrZ8JEkybjJjBxyVziC1micz2wSFOJGJgj/jxR
 n8jKX3e1XYwQ4G8N6TXRtocf7lrWkyZeWAV46+56tuFt7Zs55NnsSHxCCMF1dUbypmR3
 p4HAVNgLOMi4nJSF4/su2NqOJcpm3X6qPNjZxHcEvuh5aY9aL8GIHLiqX+QHJMvIhhuo
 qvu17PvcfzZeygVleZjhJ/peb0YxUcDBj1ghkOogdd5Qcuia7jbeANTTbP9B8FQKc89p
 ott/QlJ79p6h3n2Oe7qkM4TtNbPgdp4kVzVHizRWVf0gMZ9fGntNw+YN82WlKT/M6uFt
 4GoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ7q2ykXnYUUaUZw+GjRBUulSXJCqs4s2KId1eqRNGf2wV/0vlM5BvfFRnxExBZ9ytTdON5pSepf8C@nongnu.org
X-Gm-Message-State: AOJu0YzLAQ/IREH9BU6r/FX70Hn/pucSIpQoexdH3tKM80KfrbZp54oI
 sv3xOZf2OlSJIBsr2ir8Uuhk9iOSX93uFWP56i/K8rmIIzCvUL4phcNfXnRc93V1uUc=
X-Gm-Gg: ATEYQzwST9J6AC47jqaEd6m/rKibRONScX/3Nd0wylL002rTurfe2mWXnq8VYMljdwN
 M7ACTdhgMP3u63tpD2m7Vq0CmO44UFcHQHKYIaEPb2Oxpl58eyJfBE5mDiNdzhMKmVoP1BAU7Bw
 1xhyZ5JnezYjrVxLTY6g/qA6lHtOiHzY3Km6WXj+WL5D6WILuuSgg2hnkrBq/xW7Ri1EgCotkNj
 Ow9ueEmq4kj2wmMnwawJ2yrAaY7xi6T6K3Ztw5lRjJQgVGJ3FUAyPgCrO9OJaGyxy7sld5Pn2O0
 Raz2pGEcB1NvfD+L6NA8IAB9LSvZCOjMUUp7HPNl0BJ5Z3zN2OMJo/ShjcPqFpTGTq1jH+t02T5
 NEh+F99OpssyBnVsp//bmtD1c9zavBI1yTkCqq7DGzripfjhnSrvcva6lGQAXLFPPEatS76O8ah
 K9taHlVO2Jeom3H1jUftKPXPDiYBvflbtZ6sSZxrEJKUeXkpczpOLxK3vlscsQXv8xOA==
X-Received: by 2002:a05:600c:a406:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488835ccc61mr47899645e9.26.1775050194554; 
 Wed, 01 Apr 2026 06:29:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c883b96sm41477375e9.17.2026.04.01.06.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:29:54 -0700 (PDT)
Message-ID: <975c0259-cb5d-4930-a8ab-3da0bb6fc308@linaro.org>
Date: Wed, 1 Apr 2026 15:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/11] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-2-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260326210532.379027-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/3/26 22:05, Peter Xu wrote:
> Passing in a pointer almost never helps.  Convert it to pass in struct for
> further refactoring on VMS_ARRAY_OF_POINTER.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>   include/migration/vmstate.h | 6 +++---
>   tests/unit/test-vmstate.c   | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index d4a39aa794..8992fba57d 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
>       .version_id = (_version),                                        \
>       .num        = (_num),                                            \
>       .info       = &(_info),                                          \
> -    .size       = sizeof(_type),                                     \
> +    .size       = sizeof(_type *),                                   \
>       .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
> -    .offset     = vmstate_offset_array(_state, _field, _type, _num), \
> +    .offset     = vmstate_offset_array(_state, _field, _type*, _num), \

For consistency, "_type *" with a space separator (like in following 
patch), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


