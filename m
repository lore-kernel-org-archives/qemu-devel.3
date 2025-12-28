Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC12E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzZj-0004qX-11; Sun, 28 Dec 2025 17:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzZh-0004qF-FH
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:49:21 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzZg-0003O5-3d
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:49:21 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c7545310b8so4290354a34.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766962158; x=1767566958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FoNylknlnWh/erIYHcNyii7jWtQvlc8Cx0EsGBg2xac=;
 b=WqNM2Ah0fOtADeJqyQScI5e/ZdcI7rGpWTcpcM0FyZae015vCckwgtSYzjApd6yeT5
 IYJtBNeWtLKahg/BYN5b0dfEo3SKFN/jUERlhYreji2ineqQiteyZYQJcYyJJUAtyw31
 YEFzOCVA0cKemVnNR0MYpzBUrf0/vM+u8jYVT4V58ozK/QgzFB6nZvaA1EbgeC8Qa6kJ
 VYLG+KyiQf0aqMMWJZjG8jYfyKKwmZJYwIxIGBcRyyb4G6onRHB0Bia850oFSMdDkIBS
 +iNhqCB/ibiz9cFMXJOppZJLbc7bSlDIwE+PJbO8xKgiQOG2bGE78qR1IJj3GuVIjNvE
 m2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766962158; x=1767566958;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FoNylknlnWh/erIYHcNyii7jWtQvlc8Cx0EsGBg2xac=;
 b=cHZrI1vpNvpgyrvE/HrCVFLnBwrG0LsHXstS3uqy+HcbEXjLOePEb7wiZ4atSr+cpW
 0iTyafhwfczltLyTeghCB+nL1/MNEem2SHL433Gx7D8Xfpve7SCCkggbrTdV2shjAdb3
 0/SMWC0w91C0RgzSAAtEkOAOKDyaKIjQEX0anYh+mZ06/ZdRiu5KbqREw89lZ9eUklr7
 xsRs8XMBkCP0kvi/ThBlvZvyCLXx39EbLmwQYBWX8GGeEV77zHWTdyblM67nVCTEA9Dj
 0C61xqdQjDrVGKaljS9N30Q5OTZKecA8FPVeEeiKDX4bIgncGDRvKGD8dvaZqqrLLNLc
 2lxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf3gwyY/OvNAp4GJBYDFQDF5sum/gGETeS153E4qbl1Dn3kuig3Z81i7roQrogVFQRqDoDJ+xbROl7@nongnu.org
X-Gm-Message-State: AOJu0Yzue+XWGQsbINKOqfWHco/0ucCHyGIU0LtKMMp9Z/ST7kozOKQW
 dAkh5rsUCnNh0xi6LkBmEY14McMY7DRy1LEZ6T7/F/DJlvZyLCLoJPU7FAc7EhJc8HU=
X-Gm-Gg: AY/fxX7RKIUnth9JqLIe2c6vi3+ODgT6mB5v3wRk+f6Q//vo5ThF08qQs5KrcATFB+k
 ntZPTHCKzz6FB0Je+Nwrqu8GRDx1Osxa9ku+zBKzekaTeKKCFbZOMHXpF28g++I7TE8U4Sl0oLw
 6F3urKVCdvFkRyYO+BMklkCb4w4bvzaiSWzbEeBq7FaDBFp+n/koDVxwwx3BwrtssMcWN9FccHV
 EJfW+Jj/iRgm0M4jhIRVtM67w8dXwAql4DmjYvK/9hho/If2BO9tQlCgYSQHejP2oozRM2oRPjp
 68jpeKHIRcRDDIYs0kB5P0+sV3cLJ6oSCCNvxCaS/IeqeKupaLquGcGVc2PmGiCDrHiNbzGdgw2
 cH/MP32+f8iryNtCLKGVRGsCuquguva7K0nux7bhYv6AhuVlrXeQ6im9HglRCFa66KYyud7XyWt
 cbjHw+Wm9rgCiuaxSpU/oGBT6IbfNN8PhdxsK4lgvuRXWXFifq3+vm
X-Google-Smtp-Source: AGHT+IH0sZwD3trJvJdPIAU8nDukw4a57hjUWU1bVZDwa3F50NywbhbudPpkOo4t6k+yoTQS1iMZBQ==
X-Received: by 2002:a05:6830:2b07:b0:7c7:5d72:567b with SMTP id
 46e09a7af769-7cc66a19be4mr15442646a34.23.1766962158379; 
 Sun, 28 Dec 2025 14:49:18 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6680358asm20094156a34.30.2025.12.28.14.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:49:17 -0800 (PST)
Message-ID: <5bfe2b0b-fdde-4fc1-b19c-44649b1aa614@linaro.org>
Date: Mon, 29 Dec 2025 09:49:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/memory: Rename unaligned load/store API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251228161837.12413-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/29/25 03:18, Philippe Mathieu-Daudé wrote:
> Rename the API methods using the explicit 'unaligned'
> description instead of 'he' which stands for 'host
> endianness'.
> 
> Inspired-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/bswap.h                 | 32 ++++++++++++++--------------
>   include/qemu/memory_ldst_unaligned.h | 16 +++++++-------
>   accel/tcg/translator.c               |  6 +++---
>   hw/display/ati_2d.c                  |  2 +-
>   hw/display/sm501.c                   | 19 ++++++++++-------
>   hw/remote/vfio-user-obj.c            |  4 ++--
>   hw/vmapple/virtio-blk.c              |  2 +-
>   net/checksum.c                       |  6 +++---
>   system/memory.c                      |  4 ++--
>   system/physmem.c                     |  8 +++----
>   ui/vnc-enc-tight.c                   |  2 +-
>   util/bufferiszero.c                  |  6 +++---
>   accel/tcg/ldst_atomicity.c.inc       | 10 ++++-----
>   13 files changed, 60 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

