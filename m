Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C92CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3e6a-0006OJ-HU; Wed, 23 Oct 2024 12:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3e6Y-0006N2-Qf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:21:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3e6X-0005sr-8b
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:21:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so65705415ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729700460; x=1730305260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rll0KkErhJLMNNm1d+xbnkqe5NHXnnYS+qBM2j1wp84=;
 b=Dc/GFBqEteLspmjlOcY2tOPZog0WMMER9f//Z5u+DzSiNkbJp5HVWczqye6eOwPiV7
 FR8k00B4b4vRUR1SMbLr6tnumTXlK0ZF/tmVQEj5uXBmpzF0xUJVSOEqfrwYDRVWTFS7
 ac2f3YVS8314JPFsDc/880nS9FNt/VW0FMPGzIE+N1oa1czNRu2gL0RTYtanAUmzPfts
 ZK6WR3BWnaZHVA0XmtwmX7yvrYpkn79Wgz5yjbRFL83q/+H1zYjgx/LX811l8y1YAiD9
 rHnK1o/tyTdvBZDSbDjOPD3SHWjHADVyYJ97/kaxfI7M3KjAc+/arcTwispxz2vWWe48
 cVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729700460; x=1730305260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rll0KkErhJLMNNm1d+xbnkqe5NHXnnYS+qBM2j1wp84=;
 b=d+p0ZvDy6h5DdfmNccUTiJr5TmssBiz/+yqdvdPU+Owmt2WWZ2lR24wyYXzzorC0gw
 osu6dMo+ua3TCuxhjhe838CKn+TgACl4UmEjHaP7R3BzFskso95XTH9ZEvjTm6AHpAEH
 BBYgz8e0U7JfMbULzrqQ7cZD8NVY2opp7yOh7dsEAjdITb4+W0/DXjbJjk1E0H52ogUv
 C4OEUeMWlBziRrp86p7JrCZWCz3ZdFLax+5iYuMYWWbSk4YoVSqSpoBdtqZOealn4dgv
 jSL1BDujM54/IrxaS4gIfN2zSe0VUxVce9QHQEZ+01Or98bpq+BzX0uaK8QVbAGbevcp
 azUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJG+oXz5iq5KGJxD/+ma+iNBNr7g+wGB3wShwvmD1Yfk30hid9glgTTSa64Q1WAUs2d/h/Nuae6DMN@nongnu.org
X-Gm-Message-State: AOJu0Yy7DWLAWR1SG8ZQfn56oGXaPMpqhppr5TPZuzsBHmO/b0QjzqLV
 V0ae/RVJHr4nNUYLJMuxTlIqaoYArFv4RFPCWO2v/Q8RyPb5o1tP+5tSHKeNz3o=
X-Google-Smtp-Source: AGHT+IFKWQktNFo+HZIoTY2tHL0dWZzuqKr+mIOlJGQj/pVWVAi+RiKRYO6kuHuv4rYamEEklwDOjw==
X-Received: by 2002:a17:903:40d1:b0:20c:b0c7:92c9 with SMTP id
 d9443c01a7336-20fa9e5fd6dmr39297625ad.34.1729700459850; 
 Wed, 23 Oct 2024 09:20:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef0d6f3sm59675785ad.106.2024.10.23.09.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:20:59 -0700 (PDT)
Message-ID: <7ece7f8b-652f-4e76-9e77-ababd729717d@linaro.org>
Date: Wed, 23 Oct 2024 09:20:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/tcg: Replace -mpower8-vector with -mcpu=power8
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, John Platts <john_platts@hotmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
References: <20241023131250.48510-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023131250.48510-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/23/24 06:12, Ilya Leoshkevich wrote:
> [1] deprecated -mpower8-vector, resulting in:
> 
>      powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is no longer supported
>      qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';' before 'float'
>          4 | typedef vector float vsx_float32_vec_t;
>            |               ^~~~~~
> 
> Use -mcpu=power8 instead. In order to properly verify that this works,
> one needs a big-endian (the minimum supported CPU for 64-bit
> little-endian is power8 anyway) GCC configured with --enable-checking
> (see GCC commit e154242724b0 ("[RS6000] Don't pass -many to the
> assembler").
> 
> [1]https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
> v1:https://lore.kernel.org/qemu-devel/20241021142830.486149-1-iii@linux.ibm.com/
> v1 -> v2: Use -mcpu=power8 instead of -mvsx (Richard).
> 
>   tests/tcg/ppc64/Makefile.target | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

