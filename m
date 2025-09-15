Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F231CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBtz-0006no-Ej; Mon, 15 Sep 2025 12:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyBtc-0006hs-Tb
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:17:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyBtR-0004Px-RO
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:17:40 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-329e1c8e079so3676835a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757953045; x=1758557845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lScsxchDTQ31UoeMQL4wJJX4dJ5bpYiFBbN3h5nfMjk=;
 b=CvZLD3i28bhK3itU0q/PbNlWhZ7hTmSCiRWfy7rL7JKpulO7CaPMUSsx9fev1nJo6k
 SEZdpzxbXgGpce66b3slCo+4zq4ZxubK2wYO/EwYPAueWuoFf4EDNYdgWxxE8RA/wyFS
 OKBJDGkIXBQ0f0Bcti09RHTxg88eq1TOj32BQfZojTL3rc/p3amHnXG7qIO78xZrPt2a
 ql2X2enDvFUghth5xpQduIK1lAEQCPcvYiEjPFlq879hXN0jYxNwA1sJVaj+1kT91neE
 nNd/9ViU32JeID4mYwvY+tk23ftg0f1q8uVJuyHlqLC6u3B0tlwDuAovZJJyzAdrVAl5
 x5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757953045; x=1758557845;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lScsxchDTQ31UoeMQL4wJJX4dJ5bpYiFBbN3h5nfMjk=;
 b=KNqIVl6+oV3NzLCQ6EKEYcCYW91Hm+nYLTpB+bQYlSM1Ofu4Svg8pI9phZeODU5uHC
 JxUyncnAf/pl+Mzplyx9HmBpJRjCUZMYNsCKDu2ngPno27iuC0Wd6s1y8A8JT42CRC8t
 TiGAMVxhH5Nqi17yHOIXp+4zpCFQ3pPddnGW0utB4+W69l5AQH2cWWTLF4in6hU1tAfu
 aJzvHN1Oe7C24bk2G2yW5lzV5U9XfNeW6WMUVIL0FAbVT1xaoEhcdWU4d42mbKmELk99
 p5de1wcoc34ll5ohlqQSlQCKQG0vLCea0at9YGGnEphJb2fNHwHD5J/kSyl478nPoBfd
 1R6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Kf651xwPG+wqz24K9pfXmW+Ag+gueaNAdYzHYHkHoW3El5cRWc7xWImgdlFFtbIbPgKZmZg8FYIg@nongnu.org
X-Gm-Message-State: AOJu0YyN7E4UAewEYPB373lXOAgX135I49QLAf7XwvRg64CAPGlW0kmM
 KUDYQCXt1XUqHxf34r3MaTQAzdU3P9kFiwRPTYzW2SbKgxjFaqbvgm5iBz015P5F0x4KtqW8TDE
 fkb4R
X-Gm-Gg: ASbGncvKyNbx0yBl8Byg98f9NWdzZHkKbjeWfKmWIZV9dNk5FCBk1rgfWGh3hHLpln0
 CYdlzDN76A4hFlGEd8v+tFQn2vU/kzKIMbNPxUt3DMxaGUUJCwWsj2va/DIKgR9EVj2RnfiqrlU
 fdAkISEOwQXY71KeXCT5Jw+G9k+BHCiWLVtTH9UIDTNpUGyi/R/WQsdMPabri544BTTZXPRsxT4
 Ss+Ny3C22ka6/16LWqjxtPbtgtPdwdP7LKekAkv611JTo9xGEl6K/yPRE6sfjZZSkexDKAKt2Ve
 scHcXieWma2wOxqI33MjfZWAQ1u/ieM0Hz0gBRyUOn/Q3ywVsgaIMO0E8G3bk4cAdMjtqDyqVX3
 yL/3S1fT7+61EM3caOIEynNNh5Q+q2d8Q2ePz
X-Google-Smtp-Source: AGHT+IFgVow00i+QIT6xiWqOWknXQkyBZwtUmfdydvIMttUoOo+PPsBn7dKnTrmYPLYHx0gvob1K/Q==
X-Received: by 2002:a17:90a:e185:b0:32b:be68:bb30 with SMTP id
 98e67ed59e1d1-32de4fbfdcamr15425756a91.37.1757953045023; 
 Mon, 15 Sep 2025 09:17:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54b169f2edsm8923979a12.19.2025.09.15.09.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 09:17:24 -0700 (PDT)
Message-ID: <ae8fe505-2573-4a37-95f0-d0677e6837d6@linaro.org>
Date: Mon, 15 Sep 2025 09:17:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/23] system/physmem: Silence warning from ubsan
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
 <20250909135147.612345-5-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250909135147.612345-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

On 9/9/25 06:51, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When compiling QEMU with --enable-ubsan there is a undefined behavior
> warning when running the bios-tables-test for example:
> 
>   .../system/physmem.c:3243:13: runtime error: applying non-zero offset 262144 to null pointer
>      #0 0x55ac1df5fbc4 in address_space_write_rom_internal .../system/physmem.c:3243:13
> 
> The problem is that buf is indeed NULL if the function is e.g. called
> with type == FLUSH_CACHE. Add a check to fix the issue.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20250728172545.314178-1-thuth@redhat.com>
> ---
>   system/physmem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index f498572fc82..311011156c7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3231,8 +3231,10 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
>               }
>           }
>           len -= l;
> -        buf += l;
>           addr += l;
> +        if (buf) {
> +            buf += l;
> +        }
>       }
>       return MEMTX_OK;
>   }

This has caused a new warning from Coverity:

Line 3224:
CID 1621220: (#1 of 1): Dereference after null check (FORWARD_NULL)
10. var_deref_model: Passing null pointer buf to memcpy, which dereferences it. [Note: The 
source code implementation of the function has been overridden by a builtin model.]

Line 3235:
5. var_compare_op: Comparing buf to null implies that buf might be null.

I think the best solution would be to split this function, so that the flush cache 
operation doesn't have the ptr argument at all.

An easy short-term solution could be to move the increment of buf into the WRITE_DATA case 
of the switch.


r~

