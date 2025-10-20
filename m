Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B3CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoGr-00077C-8W; Mon, 20 Oct 2025 07:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoGl-00072V-PZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:41:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoGj-0001le-DS
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:41:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso29643925e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960498; x=1761565298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qp+Z1SBSpYAY+WZ1oQiRrEXdZBFjg19eliXIiYnbf4E=;
 b=FcObzD9hVBDlQcJ2eGiNbj9yoG6A09rYN/FFiPCHnGUaSKw664E7jStTECrrMeVlFi
 Adu9wv12tf2LpWXCR5+Qq0Zc8y8LhKHdidhKoIbVv/2fQzOF/U19bycDQsrG8Y0wDAc8
 9x4I3ts/5IDvXqFeNP9EJC18f7jsTA5zdnUtk/I+Xd/IzNEBbDYTlUpgiLIwYeX6yWxq
 s3Euv84D+CgOOfX12lEwIU40bk2p5QVAN7Z0nDttazf9/G7X9muJpC1EzMvZrVWDb8mD
 DLi1wdg+rDcEoTZAVbwFn7RjsihH2P7S8FYGizyHpjEdoAb432Zq342ALPegyC8idV6e
 NDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960498; x=1761565298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qp+Z1SBSpYAY+WZ1oQiRrEXdZBFjg19eliXIiYnbf4E=;
 b=ERfK+sh4ExINouU+vAl/nqB5ouQHzke29SpWaOuMm0Jk+AZ6jVugrLyXoIJ9at4RfX
 MWpkGMRnbRgtsKWLFrXnotK4+aVN8f6K+7RI9X0FEqOzjEtfDZP1brUKwTUiKaIhPBJB
 imGdc+umBmQIhfJWQL8SsTm4tDuQel0WU5EYX/HcsW/8kC3/a3c+ydQFDtoIm2OQfIxu
 SeXlFFWbvBJOPIAHmOtT1oJPubKhsgYU/yTplH9PuN+vo+ktkmg8xCydgj3AVNOlQkGn
 FM0h5F5FzAUYbDnxkbz3BpzcB8xaJzV7YGAaltyiq6uutAaaAzPALGcC9pfe6Kinbd8K
 1VQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY7jDSMS3/wgeeSJd1UxTl2H6PszKlx+f9N8mBIhXPCzgk+4e+Lp1UTbGeQzBUChfV1oLnvDHOoPOL@nongnu.org
X-Gm-Message-State: AOJu0YyH1CuRhy13BFuaUB+CBl8UXzADU1GyUFSFvq4lZe42Lv/Ww5yW
 oO+oXEzYA4Tu0q66pyLgoV+pwKalVyqsUwkj8XF+kOP1pYiFO7o7Hk6OzboP6h6mOa0=
X-Gm-Gg: ASbGncteos43z2LOYpirA34jjvQr7wrYpbChbgydvYUQveVaFwP2XGOPYg3lmyQlpqS
 P7orxQ5Yhoi2aMYJ9KoF63N/MuNdqwfvQnJ+cw/gYeTYWq+WZqBGqlNbRH2mnYIC9m0gL6Mm84n
 ZLapIbdCYBN+mEDWIY2tbY2+FAADN250qlU8Ic8gfovVvHAl3otY98zg15bzX2ZEuzBDjbIofnF
 ukkvr0z5mav1Jc79Pu9eXgArFHBB4Uc8stNDNqjqfzjjwKXk5fy0mrKYD+idQfXOQIJLSggash/
 +TjYAI71Jjv+uoEj1vyMmrJKQsnUvv4iD64vhdr0Lt6U0dzCzgcl4xANNtEmrVUcT5gbsI8LcrX
 Tt5oDpLhwzK2/cHviEqLoRTC4o7RMYI2iRMESdgXS8tUSqIrt5KJF9/6IJ974RMJLQX2yFrApIk
 4/Ej+Law4eden+bnxKSTgyKv5bwkSZCcMB6oBnneQoS+I=
X-Google-Smtp-Source: AGHT+IEVHCAsZnROh7VmsLmzZ4s1AAt81ahNNjefHQsO9YT4ooEF4gTSF0rMrZmq9yNUpd1rB5UCmw==
X-Received: by 2002:a05:600c:a02:b0:471:3b6:f2d with SMTP id
 5b1f17b1804b1-47117931c36mr77512915e9.38.1760960498493; 
 Mon, 20 Oct 2025 04:41:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47154d3843csm140561135e9.11.2025.10.20.04.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 04:41:38 -0700 (PDT)
Message-ID: <03087048-6707-4436-bfa0-fcbd9760927f@linaro.org>
Date: Mon, 20 Oct 2025 13:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] accel/tcg: Unify big- and little- endian atomic ops
Content-Language: en-US
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20250915124650.435777-1-d.zhebryakov@yandex.ru>
 <20250915124650.435777-2-d.zhebryakov@yandex.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250915124650.435777-2-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Danila,

On 15/9/25 14:46, Danila Zhebryakov wrote:
> Remove dedicated LE and BE atomic helpers. Use MO_BSWAP flag of the memop instead.
> Adjust atomic_mmu_lookup to respect the TLB_BSWAP flag
> 
> Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
> ---
>   accel/tcg/atomic_common.c.inc       |  36 +--
>   accel/tcg/atomic_template.h         | 326 ++++++++++------------------
>   accel/tcg/cputlb.c                  |  11 +-
>   accel/tcg/tcg-runtime.h             |  48 +---
>   accel/tcg/user-exec.c               |   2 +-
>   include/accel/tcg/cpu-ldst-common.h |  51 ++---
>   target/m68k/op_helper.c             |   4 +-
>   target/s390x/tcg/mem_helper.c       |   6 +-
>   tcg/tcg-op-ldst.c                   |  43 ++--
>   9 files changed, 181 insertions(+), 346 deletions(-)


> @@ -1242,14 +1238,10 @@ static void do_atomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
>   #define GEN_ATOMIC_HELPER128(NAME, OP, NEW)                             \
>   static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
>       [MO_8] = gen_helper_atomic_##NAME##b,                               \
> -    [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w_le,                   \
> -    [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
> -    [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l_le,                   \
> -    [MO_32 | MO_BE] = gen_helper_atomic_##NAME##l_be,                   \
> -    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
> -    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
> -    WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o_le)   \
> -    WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_##NAME##o_be)   \
> +    [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w,                      \
> +    [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l,                      \
> +    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q)        \
> +    WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o)      \
>   };                                                                      \
What happened to BE entries here?

