Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zJK-0005OS-Gp; Wed, 01 Oct 2025 12:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zJH-0005MS-9h
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:04:08 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zIz-0002xP-1S
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:04:03 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4e3117ea7a2so31841551cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334624; x=1759939424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRN/gSuS1GAP18uW4uZI9r2/gGWJmDTUpS3beftY9+c=;
 b=dtUBpzspJQio0kQ5KI4bDo5nOwzJ/kZ9eH+9UhiOIls52shWoIUEpx1xn7wdMeA8PC
 nb/E7qBSxqky5+P+nav/mNhoYyTh60Ppc5RmoLW6kD8+4O/PGKA7hVzpgjan954Uiv7i
 0kYa2LQNnbjBHdIqwsZJuQ4aOlJOudQH5R2PHjUT+Iy0NJ8N8ZzIUUmP3rZJCtXfvztY
 la9hFB4AeTnWtIznYbEQ7adx0zNVDGSEBruqOtWHPqmsZeNnBA0H43aSKhRyc3NALY7f
 8wIH2ca/k37Ltr36FQLA118a60fvFKGC/GZGqZLCpShuabDA+s1rmrqu4EmIZ6q65VcM
 3Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334624; x=1759939424;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LRN/gSuS1GAP18uW4uZI9r2/gGWJmDTUpS3beftY9+c=;
 b=r6GyGFgNf4PR2WzntTogCNpZ9FmNnEaH9Gnnu2aA2F+rCe0RBuqUEC268saY/t/y9U
 hqqZJWakfpnVUc/Xymvrv+4UARvj4pK9E1famlRgy05dVPGJE7W9wlaUPg1uhSwWl7tj
 LmBDAHh3lY3w+yA42qV0HwAxq0KJ/7gV4qwoJd2DqYbz+Khc9XZnXF87H34jfwxynFlL
 dVr7Gf2D14aY3O0xpIkWh/tC/N9AQ24/Xs+cNMBJFXQXNTaCP8E1wbOICjb8wHr6RfFJ
 kEEg/bAWUyGzQySVSK/4PQwFOCMYQ4f2VUIGBwq3LPO1yXhbdDOAzBnln+DEwTqtGnzy
 4cOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeRlR0jQcOlgZokX8THGm0H1WLSONCLwWr3q4YVLSUmX6A69cFpAvGGRsbgI/8loybE+MsJp8fyawo@nongnu.org
X-Gm-Message-State: AOJu0YwJx+aJrXJohefWytqJgBpl1ViKJoycbosut6YX0W/08HxYoJXm
 nT1B9DsvVEtlQO8eLNIZnVUm3ZrQ1BWpBR7HXY1HpjGWHYOLAT8KbgaEvg0pGb/PeP4=
X-Gm-Gg: ASbGncvtPcHqlWhiCYapJgCFgvlM5pLQs6FIjDyWGV5uaRLL9iZVGNEM+5JrNOrDmJJ
 MMBdXl5vVbbDgKCozSuCdQ5P877gPo8bXHDq4LkxwtYGmjP1UIiJ0GeqzpXGUulaJ3/S2E4m3Zm
 5AnCGXeG0B1ObiK4ORTvh7v8akubjiQOKHDT6PY84zsDISj3pTbFFQg/Vy1rm0hcI1uTkMPURnz
 9a9qc+Np1DFaBxV+pjbReaN/NjRT4EAWPYjlR6k6V9orBZzrcxotrDj8ZrStDjUtIHw3AsduvO9
 V+OglMKs30GsgCzZJPhCM9QzypNI4Uv/702mCbAvL58fzykdeI9+l6KRIWmvACux7EozZ7cQg9N
 kMgxhf3Fq3Dw4an46dtoN2MYk9dSFmSvSS91AIfswWsChyhsPUlOP05HLJ8BdKcKAlMMWAkoUR8
 GhEnXoT5db8yD5rld+NDKXd4QM3A7T7qM=
X-Google-Smtp-Source: AGHT+IEHuRntYtfblmIAnhKBBcUOe3vagIGzluokfa3UwmivMH5oOuOgJzWyvpEoKCwtykjm7AhDBA==
X-Received: by 2002:ac8:5a55:0:b0:4e0:296e:8cbb with SMTP id
 d75a77b69052e-4e41de7318amr48478751cf.64.1759334624359; 
 Wed, 01 Oct 2025 09:03:44 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55cadc7f0sm1011971cf.26.2025.10.01.09.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:03:43 -0700 (PDT)
Message-ID: <62257ea8-f06f-4a42-b426-bc4a7d93eaff@linaro.org>
Date: Wed, 1 Oct 2025 09:03:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] system/ramblock: Move RAMBlock helpers out of
 "system/ram_addr.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>
References: <20250929154529.72504-1-philmd@linaro.org>
 <20250929154529.72504-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929154529.72504-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 08:45, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 11 -----------
>   include/system/ramblock.h | 11 +++++++++++
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> +{
> +    return (b && b->host && offset < b->used_length) ? true : false;

... though we could stand to clean up "? true : false" silliness.

I assume this comes from programmers who first learned something other than C, but I can't 
work out what language that might be.  I see it in patches every once in a while.


r~

