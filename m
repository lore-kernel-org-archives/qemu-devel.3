Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41FFC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjH8-0000HO-H2; Wed, 07 Aug 2024 12:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sbjH7-0000Gn-15
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:12:33 -0400
Received: from redisdead.crans.org ([185.230.79.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sbjH4-0001uV-Bw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crans.org; s=mail;
 t=1723047138; bh=pD2Do4pvajSm9PgFF/FiyU8b48sg/O3AfuLK4cZo/VU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tCOmnLB95M3wYCfoooC95SEfjg8qHy21DwukWAd7EaF8KU6hIMT6jeljEI4DBaD0J
 1/H/UVdQJjBte0M8IPrFiNrbO1/dfAcoUO6ZoOIKgheNUe/rHU6fkUUebBZoQYbYB9
 YYPgjKN54x98e6Qehe+maTbv+fLkgrsasjtVPTsC4EFV0NqJBp0wrlCe21ffocr0iY
 GrCtXKg8RkTMK6pJpMjBhTsY4wHVsVeLTSMBv88lbpkKgWEDikiNp0k+rHQNjSZ2dm
 gWFlk6AcdOWt/2vkqrZcRFx6WqAKU0Tsvp2Xg6kYw3r1bnbfi0rcxwKmW1aXejPwb7
 aJwCmY5e050cxV63AMxwjQn9TcKHnsxNaOVvo6Oq+mDTdPMRVEYbI2r5lQB4Og1hAS
 GAWqqH23ytZFvR8JjvtOhacYweADdX3adAc4N51ZhWsAOPhds8viptiuTPHox+No+e
 Gcaaniwkud+i8jRvOBGDuUy9sXkTUWrDLDXwROgl9IsML/dr//VOjHOiJxDvlO8neq
 QoIdORirRuHI8/ZJAreZuWnUjifILJNCu9CTUo8CrcE+3MGEpO6EwG+BaRULXFZ+Kt
 wGYNNMh3bftu5Q/K3ePzXaE4Hb9g+Wr4cWGhYtY61dTzB/eFcmaYtstBbfB/xHJKOE
 UKWWfbT9TGjlPwFPCdCWQ1Ko=
Received: from [IPV6:2001:861:3dc2:30f0:5f74:ee2d:c8ab:cd69] (unknown
 [IPv6:2001:861:3dc2:30f0:5f74:ee2d:c8ab:cd69])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by redisdead.crans.org (Postfix) with ESMTPSA id 9CA1728C;
 Wed,  7 Aug 2024 18:12:17 +0200 (CEST)
Message-ID: <e7dfd816-2d76-419e-a29c-dc38f72bcb54@crans.org>
Date: Wed, 7 Aug 2024 18:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: allow access_ptr to force slow path on
 failed probe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240807160236.2478459-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Alexandre IOOSS <erdnaxe@crans.org>
Organization: Crans
In-Reply-To: <20240807160236.2478459-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.230.79.39; envelope-from=erdnaxe@crans.org;
 helo=redisdead.crans.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/7/24 18:02, Alex Bennée wrote:
> When we are using TCG plugin memory callbacks probe_access_internal
> will return TLB_MMIO to force the slow path for memory access. This
> results in probe_access returning NULL but the x86 access_ptr function
> happily accepts an empty haddr resulting in segfault hilarity.
> 
> Check for an empty haddr to prevent the segfault and enable plugins to
> track all the memory operations for the x86 save/restore helpers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
> Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
> ---
>   target/i386/tcg/access.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
> index 56a1181ea5..8ea5c453a0 100644
> --- a/target/i386/tcg/access.c
> +++ b/target/i386/tcg/access.c
> @@ -58,6 +58,10 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
>   
>       assert(addr >= ac->vaddr);
>   
> +    if (!ac->haddr1) {
> +        return NULL;
> +    }
> +
>   #ifdef CONFIG_USER_ONLY
>       assert(offset <= ac->size1 - len);
>       return ac->haddr1 + offset;

I confirm that this patch fixes the crash I reported here: 
https://gitlab.com/qemu-project/qemu/-/issues/2489

Reviewed-by: Alexandre Iooss <erdnaxe@crans.org>

Thanks,
-- 
Alexandre

