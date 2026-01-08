Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22486D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdns7-0002Xk-MU; Thu, 08 Jan 2026 06:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnrw-00025Z-G5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:07:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnru-0002B4-BW
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:07:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso16709535e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870473; x=1768475273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uRip2Y1kz9dmZv5gRfsGtCgtZE0Vbf32ZYEnS0IMC+A=;
 b=xZBW1/Do3H3/gtBs/uj441TtS0+qEX1mSjX7sgPF/yYC1PWL+vqGQM+DXjU0zcVdRy
 aTOjzObMcQoB2iPmwsDWTut+cpCR0SGm+7fJ2q8VG6ewBSc8znLU6txEtNCxVdMJPG/2
 DaB8XzYM+LvWpgMrkpzw0ZsSDyUIDZ3zADG2sK9MXdDFMbxIgybOHV97CETIP/8L/jV4
 l2l9GXnPe9gGS3Iix+dJ8LqDReu5/sH+e0jM0CsPOygWfA3c7xs5E3la0Q/os41J+zvq
 pv0/Wn0SJR00uCIIGV4FHyNJBXprowncbu12KcouVs1r46LQdJ3wpt3J1AAJzO95Vu4T
 tp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870473; x=1768475273;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uRip2Y1kz9dmZv5gRfsGtCgtZE0Vbf32ZYEnS0IMC+A=;
 b=eBSm9jIxJKvI8JtE89rZEVZ3cMGLCLrnDeRuXgghX3P1cfJOklFX+UME9j8J/kw91h
 /LUod8RNm/ISOm2FRuuDQm0b8lGPltgxPf2ABB8/iMVa42CiRHbOphmBTS82QseJOwbT
 VsMeeed2VusrFvE7+7IAGul6XqJgcm+qgs/ldPWqD3tK3/sWBW+U0KEMqBV32HWVMKAy
 0W8lNfOHvBk9Uld2GW1Dxtf3kilXqnFQ6MxZPNQUSluauZEJobo3ot1CPJoLcX3jfVvn
 BoQDifdWV7Nb5sMFFsJCn/O5RKoRVKm0H00ptBwx5nORhbcoN4O+RWtOyXrpNIkxiozP
 EMqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHvprcVdMEC3YE0xBHxazB1g24INbHeNFyqouuyp5QmjBgOqV4Ull0vV45YliO4StauIE2nrb9CtWq@nongnu.org
X-Gm-Message-State: AOJu0YwG92B61M4mkkDAtpp0oy1IlNFY7n7AesfFmQd2yGQ2NnwIK7WL
 wMVE9AQts5SRgv9HB5Pc0YCLPamXW1Uh6s6RK2qMa4uxkkYiThsvl1a7X05Mh7X/rhW6BKocbk8
 HF0pmMm8=
X-Gm-Gg: AY/fxX4zHNHeqpySFRmgncNP+kHY0OzOudlDT7ZPKnWk7IIQptjWJVUZJGSWp8t2KmA
 qYgQ5QlJLC2w+R1LN79qGZJeCz1YHNYiykXrzA5VkIuqCSTZXJm5OiabnMUlYg8fSxYQQO+xjdW
 3t9UQs8jOwRWP5G4f7qi35rC4IAQ8092dKgOWzHbwpkAT/WcCsr0EFcEF41vuGDjbrhFMObIWnq
 RTd6qFDPG7FjGfxYmpAlWVdBJPJXwVHmo1S8A0w8Cc/ObXXgTdRBqKH/zlmNXqqcfi9CmdoWllM
 kmCn6cjmxYQfdHXBl0fbEtn36Zwf7VeJEgBQ8Xq8x+VEAt+EcfGc6Pf/d2GWgps0MjJwHrNwO9j
 TkomGkAxZi2nPCKVwPbB67pUcvBemEKaVOz05YKkPJqU6G+a1YtDTENixIxZwczgfoE88TUUtBr
 N4f056jeBjl4Sgo3AMYhxo0QpsM9ql8NP4cvPjc9W9ekO9O6RSncRY5g==
X-Google-Smtp-Source: AGHT+IF1CdFLOgPw4Nq+lc44j25cYIoxi8igfUTUeN+6Ke57Kzg4LXjaN7GaVrvbu7dmsQbn9soeXg==
X-Received: by 2002:a05:600c:4ec7:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47d8483cc5cmr77303125e9.2.1767870472780; 
 Thu, 08 Jan 2026 03:07:52 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8678cad8sm37801155e9.3.2026.01.08.03.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:07:52 -0800 (PST)
Message-ID: <5b140dce-b98b-4990-8fef-f48aae59f517@linaro.org>
Date: Thu, 8 Jan 2026 12:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/50] include/qemu/atomic: Drop aligned_{u}int64_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-51-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-51-richard.henderson@linaro.org>
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

On 8/1/26 06:30, Richard Henderson wrote:
> As we no longer support i386 as a host architecture,
> this abstraction is no longer required.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/atomic_template.h          |  4 ++--
>   include/qemu/atomic.h                | 13 -------------
>   include/system/cpu-timers-internal.h |  2 +-
>   linux-user/hppa/cpu_loop.c           |  2 +-
>   util/qsp.c                           |  4 ++--
>   5 files changed, 6 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


