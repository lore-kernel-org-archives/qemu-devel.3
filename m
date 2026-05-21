Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE675CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzJX-0003YW-3p; Thu, 21 May 2026 05:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wPzJT-0003YE-RK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wPzJS-0002wt-Aq
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779354209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WAZ/bX2CZ0TB3ddzWWLA5JpcbJrPhiBxyfJ/8D2iwA0=;
 b=Aj1nj5NZKE1Ct41gYHsdQ1fbY+4C1Edyb9Vjvj/jSGt973kmDpPO+Mj3t6GAEbAajq04LU
 Yd3RSNHHBHwaiWsh+9kCTYLbOWVz/4VfvaR9ocpPj4hsUAV/jeRAux+gWfbtH0u7Ox7bF4
 RgUNhGubSgSCAq8/pw5lpExRpWJHaZ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-O9zWUOGTO-WpN9rfMY-uIA-1; Thu, 21 May 2026 05:03:27 -0400
X-MC-Unique: O9zWUOGTO-WpN9rfMY-uIA-1
X-Mimecast-MFC-AGG-ID: O9zWUOGTO-WpN9rfMY-uIA_1779354206
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e81291d62so4284786f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779354206; x=1779959006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WAZ/bX2CZ0TB3ddzWWLA5JpcbJrPhiBxyfJ/8D2iwA0=;
 b=AJoIbMpt3MOsMz81ivhHLpA/LYzYL4hI8GXUOWndDPPHaUYlNkLHIYCOAYF8QCrlQm
 u9XQCJRhf/jNXJPnlkZ+eNansvdChFYFvTBYOlskuwImdyRO9zo09hr3r4SCLysPZcFW
 5oYc5EVcibXx7IrHE9Cm7Joh18oylaDslp60+/oUMhJgR8wbkAoVqeFDapaC1zjcDWcE
 i6bneyJXg77++c5azPL2dFmKKwtbsVuK6uGhBLwzcMJxo/5YkGGhwssqgfsivfpxDn9p
 B31TCcolU0mQFNlwJVE2Ey/pzLBtYnbqJB+EM0y6OS64X23CQ2crXv2nZW7L7SI4BqNf
 Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779354206; x=1779959006;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAZ/bX2CZ0TB3ddzWWLA5JpcbJrPhiBxyfJ/8D2iwA0=;
 b=NvAwgIKd0lbGVjNh2Y+BXvU7MFtig2uCN/NFkYyRTTgF5y0zHkxfjptggqxdXIaCDX
 5LuMLQIbtkv0EC7GOIRqS5zVv7pJekKuAyarGQGFJQRDxH3f9knRUMgIbcsjgmFIr1pP
 53qKO5I4bxehDxDNf95DEm+JG9YU20Y5SalP0lPc50NNMaYxsfuw24ochBXw+gIItmyp
 n9oALIHr6dGzLwulnc9ypMOEJeyNVuiyBBj1sP/nTvE0/x7GL4P/lQcAQkVJpO8/whDN
 Y0JRnOcUxUWYxuEK7cqzBllRTExvCf5vKjEDxpNUwUMd7Tdz3CMg9w8tMWhX53kiL9SG
 Y71A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QL9d7BY2VSZAXMF1/a3nnc5ZFpBOpUaYUOhOhgmk52tYySC1rHKGQTWRJNzCH94LsVqpySq23ya/g@nongnu.org
X-Gm-Message-State: AOJu0Yw7HYEEooeVdXn6GZt11SHdj5xKuug9aiXm7jK6EU++N6HEuzU7
 GUZSpvNsGp4azmboJLkFkpdo3MJBmmcag4MLqUu5xVlrhKAKFNAHE1RpkfxBC8t6kmm1xRxcosg
 W1i7kjk851n5xYxYGPMX7e1kTOWcFgxHZA/RnnqG+DO2M1Pjb/k/MVm5t
X-Gm-Gg: Acq92OFXpbdq+L9vRdC4TiecVNn0dIhiMQatN/GNDEQNZeTYLKpjVH2H1LpOFE0M3XW
 Z1Nwqxe5msYOVl+QlIg3/ZZ3sAeurO4n7JzjWk8yk8JcneimQwrRgdHP7onm3uJxXm0K+d/M1gf
 YXQUaqTHIZ2vggDZSBZrQiAofJCZoqjclUzLfhkJchTiSKj0jKjedhcmtGpDFi+ApBcH3RDma7C
 WFcQdZy/dwAzuY3aRfnhQMeYoLsLI33CFvFA+npM1j0wRtr10pvCoYhFBF794eP5DRsaBWPkzh6
 zfUcQgyYvk4fqa5O2UtAfiLT6zz6yuXFqMTjcGGBKrDOTxgLf9J+gRd+ZBjOgl69Uq029Q/wHq9
 wIMfAtwXqbY4VnZLmZEb6fij3TbSL6eC0KrcqVcci8MdSgNyIXVUoy4E=
X-Received: by 2002:a05:600c:1f89:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-4903606c383mr24818935e9.15.1779354205923; 
 Thu, 21 May 2026 02:03:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1f89:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-4903606c383mr24818425e9.15.1779354205511; 
 Thu, 21 May 2026 02:03:25 -0700 (PDT)
Received: from [192.168.100.100] (82-64-211-94.subs.proxad.net. [82.64.211.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7da426sm1168936f8f.9.2026.05.21.02.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 02:03:24 -0700 (PDT)
Message-ID: <c27cb59f-db7c-4ee9-9035-464aecadbdb9@redhat.com>
Date: Thu, 21 May 2026 11:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/39] MAINTAINERS: Fix bad / stale F: in "virtio-rng"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Amit Shah <amit@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-24-armbru@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260521080511.999266-24-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

it seems to be "vhost-user-rng" rather than "virtio-rng"

Thanks,
Laurent

On 5/21/26 10:04, Markus Armbruster wrote:
> tools/vhost-user-rng/* never existed.  Drop the bad line.
> 
> We neglected to update MAINTAINERS when we moved
> docs/system/devices/vhost-user-rng.rst to docs/system/devices/virtio/.
> We later deleted the file.  Drop the stale line.
> 
> Fixes: e3e01466bf (MAINTAINERS: Add maintainer for vhost-user RNG implementation, 2021-06-14)
> Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-10-16)
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d58459d7f0..8fff1649ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2541,11 +2541,9 @@ F: hw/virtio/vhost-user-device*
>   vhost-user-rng
>   M: Mathieu Poirier <mathieu.poirier@linaro.org>
>   S: Supported
> -F: docs/system/devices/vhost-user-rng.rst
>   F: hw/virtio/vhost-user-rng.c
>   F: hw/virtio/vhost-user-rng-pci.c
>   F: include/hw/virtio/vhost-user-rng.h
> -F: tools/vhost-user-rng/*
>   
>   vhost-user-gpio
>   M: Alex Bennée <alex.bennee@linaro.org>


