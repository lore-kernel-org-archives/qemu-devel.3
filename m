Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D263CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfvF-0002M0-TG; Mon, 23 Sep 2024 06:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssfvD-0002Fi-Sg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 06:03:59 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssfvC-0002B9-6U
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 06:03:59 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso279660266b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727085835; x=1727690635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5mPZ3ybkqTPjfYLq71uKMC4lZU8i9dn7NOC8iQ8zJ0=;
 b=D3MDnh49otRau+Mqg5qbA2W4Thnlp17YYtGuTIWOIwVj6EkZyqyZud37NT8czqmXkd
 TeyF3+WrDvXC04nk/3yg7IqMZpfR4R5cLzaXdOesvTt5/FL6QK7i4Ayw6DXCHr2zaXo1
 3Lou5gIPCptJITSbyTsqaiglykfyOjIz9idWjUFstJYpxO0j9OLoFxkTlHxix4zgt01t
 XohoXnA3WW7b5c7F8IFTg4XFYiU6T/8WWgKPHvekrCZY2rIxxBTc5bEM8TBmaOQNDYuI
 R/thygCOmWNJL9afF/mN/jU+OP5sEHxZzwvu/C6OgLCgHsCO9p11caXlNv0Zzl0xtdaX
 fvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727085835; x=1727690635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x5mPZ3ybkqTPjfYLq71uKMC4lZU8i9dn7NOC8iQ8zJ0=;
 b=lksyvg5SZNi5lL3y/VoO6lVh/xZ/HIiFqk9sIt1cBgWW7VwLIS9Ll9SUhx0sXD6ANN
 DarTbKCGnDXVFXOxbTuRwbKMgcbHxCqA/9evw6DafRYV0+CgRLEQkYppJUPDJjmTKhrN
 /Pdnn74naxQmu4OXOqk61COu4NrBsc/9f1hG6OURXzqfRHyhwzK4+0lrj1Yj7nZcKkBC
 fUfbw1/v4HAhNcCjxieUr6TL0YErpq3A97sV0pyGA9gcQe8wO+k1ClK/rI+zCpcF7U4U
 3DRYiwXBCHgIoyz3iisBSzlPmusVrWAVx731yHlEERxeuGNvEc1cnPH/B9/P1eB9y70n
 Kb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOkC0epFET506z+RMDzA0A/iClfNjDxlDOxLFLibQ2NcYXSKb7iSEugEShcrljClws3VNU366YdFkL@nongnu.org
X-Gm-Message-State: AOJu0YwVcGXZw7kTiw4TIguI5acFwe0qlzwS3D533LlYUUj6bZf4DGev
 h0bXu8GT4FFFCgauLxDS3r21uf4cw0Qe8N//9FVJ+3X7ybGvDcKlqiO8TXuqBeo=
X-Google-Smtp-Source: AGHT+IHUSe6cDKrbAADkZhqMUtdYoXmHDcHY+OPX8pMhq5t6/2pwNejPOQ9xdMjm78D8y8oMpaYnWA==
X-Received: by 2002:a17:907:e6a1:b0:a77:cf9d:f495 with SMTP id
 a640c23a62f3a-a90d5813b2fmr1250241866b.40.1727085835118; 
 Mon, 23 Sep 2024 03:03:55 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612dfa6bsm1198015666b.154.2024.09.23.03.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 03:03:54 -0700 (PDT)
Message-ID: <659cb837-f53f-431b-bd29-297cdcb1c73a@linaro.org>
Date: Mon, 23 Sep 2024 12:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Avoid target_ulong for physical address
 lookups
To: Ard Biesheuvel <ardb+git@google.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <20240923092233.3235856-1-ardb+git@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923092233.3235856-1-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

On 9/23/24 11:22, Ard Biesheuvel wrote:
> From: Ard Biesheuvel<ardb@kernel.org>
> 
> target_ulong is typedef'ed as a 32-bit integer when building the
> qemu-system-arm target, and this is smaller than the size of an
> intermediate physical address when LPAE is being used.
> 
> Given that Linux may place leaf level user page tables in high memory
> when built for LPAE, the kernel will crash with an external abort as
> soon as it enters user space when running with more than ~3 GiB of
> system RAM.
> 
> So replace target_ulong with hwaddr in places where it may carry an
> address value that is not representable in 32 bits.
> 
> Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
> Reported-by: Arnd Bergmann<arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel<ardb@kernel.org>
> ---
>   target/arm/internals.h |  4 ++--
>   target/arm/ptw.c       | 16 ++++++++--------
>   2 files changed, 10 insertions(+), 10 deletions(-)

Ouch, my bad.  Thanks for catching.

Nit: The type "vaddr" is probably more descriptive than "hwaddr" as input to 
get_phys_addr.  Both are typedefs of uint64_t, so there's no functional difference between 
them.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

