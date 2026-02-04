Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EEEA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjdO-0005j4-UV; Wed, 04 Feb 2026 15:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnjdK-0005iq-QB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:37:55 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnjdJ-0002eq-36
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:37:54 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81e93c5961cso235083b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237471; x=1770842271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppbWwbdYbFxnHKPDva+koH/01mgTjSewOYL3RJ5AUM4=;
 b=Ity2qSvkgsBeK7ykDBZQkZb5DkdX4cFMUhlBFJeRjVZ+r/diJV74USB22iwWeWBkoK
 gMWGgkTArRLRNWvcyPdainF5aVCCtat0ZuC4NQrg4LvP3gaTbbcj568sIi3gJDTHfzDQ
 bIZy4IgYiF/Y8wgThLDpmt5ENMsQHUAT/hljkp9zF5JnzK7uEFiROgusvS9bvDtafWQ4
 eV6u21KzMPyYjI6GCPucmuvzv+LsLB3aqY0PCwdDqSfIz1oxyzMpqSAMyaJNDzdHR4lk
 2pHnDdgRLEtBVVVvQvsoYot67HMUpXPvdqlcnkpSUqPX808Cq3a+WQul3Ik3ICXKs4Mz
 jZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237471; x=1770842271;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppbWwbdYbFxnHKPDva+koH/01mgTjSewOYL3RJ5AUM4=;
 b=EASPaY7bn+fALlblH21xu15MlnSF+SIitg1xrV918LUFSdGYK7H2mjv7FZeD//7UwD
 yZSbGiftzXny0x66Eevg9kRxUbqmiDLYGGHFRk/f/pFckDVPVw/43HqmFYpK5zsLZpqc
 V2kcvuvG8MZEjgyxbYIAqPaBSh2z85HioFfkm2b4w8Rb1GHc9ouUP5SbQy+fYDeXJlb1
 On4b0/inrSWShE6F0QP5xbMLut9wGDSrIxzT9DjTTci0cjr5GundHUZD9rJFDHRuf9IC
 YIVM3bGyCQ4LnjoCQqIPrSfu2VgQxADliBs8bYnGc63t7oCwlStJLphMw7Pqv8I9R1ZO
 6dxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxs/4MJ9tvY2QEqMlMs4ri0yp6wppGK/KSe127UqXS2A8EHo8sl9Ts6E2unqr+5xinUt9Ixr4waViO@nongnu.org
X-Gm-Message-State: AOJu0YxYBQCTJzdPhtmQ2DXUBsAOd+URp19Z7obtkFIxuKoduLSFVU/l
 e3kX+SYOBom5N+NxcfkEDEfdHiQZ6gHHQdBaKEAfWaikrakr+ALbBICVReqVi6p6xGo=
X-Gm-Gg: AZuq6aJDLJRHpPSF4kpAVeefxqxzeeHJll+CD3F91HzPgH0LGEk7wT3FKQbXK5F3Obp
 0CpBGf0TGH/8kH2x79cbhduOrrCKF+/SdxBUqe3Asrtye9Yi8wyzK9oixWPfjZRzghrhgENv/mi
 /B7S2qFUma5t3NF8w03kpFNvT5lczr3NvQYzxuQcFCTaIWZIbOy1IMhF21zGi/KCwhd4+pRz+lS
 dg/NR5YE4kGRNq7+UrtMAOxa0dkElwsaO3JHLIpexSX1oDE4CwMWN1uVo7UPO+Tdp5x+3jMYz7Z
 gnd9LccpLS0X15I1F9Dseqt19m4+alxjcKJp/GEQpLbp1zPmxIhmlSpbt182Lu/3JJKvnJrJC3Q
 IoJMxgfGOET5VTaUv8hY0JeicZknWH5PfbnQapBYfyTu85GXlIUpv1sozZmBD3Q+wwW4Zfd/gxi
 PeJ1tl45InNo+MFduyuwlLYc5CL1UWy/OinQKiqsu0FiPzwm+JukJ5ikdmmms28gmgIxJswWv4
X-Received: by 2002:a05:6a00:1248:b0:81f:bb67:8f8 with SMTP id
 d2e1a72fcca58-8241c4c4961mr3676704b3a.39.1770237470941; 
 Wed, 04 Feb 2026 12:37:50 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:110e:c2b5:eb10:f92d?
 ([2401:d002:dc0f:2100:110e:c2b5:eb10:f92d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d163865sm3795131b3a.9.2026.02.04.12.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 12:37:50 -0800 (PST)
Message-ID: <fa6b22a0-b605-4090-a9d7-ed3b61f26143@linaro.org>
Date: Thu, 5 Feb 2026 06:37:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] qemu/int128: Add int128_signextend()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-2-philmd@linaro.org>
 <45d7fb96-f2de-4d67-8069-b545e210947b@linaro.org>
 <db38246e-091b-4bb8-84a0-fc50b02e21d3@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <db38246e-091b-4bb8-84a0-fc50b02e21d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/5/26 04:35, Philippe Mathieu-Daudé wrote:
> On 4/2/26 02:47, Richard Henderson wrote:
>> On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
>>> Add a method to sign-extend a Int128, along with unit tests.
>>
>> What in the world does this mean?
>>
>> I can't imagine a real use for this:
>>
>>> +static inline Int128 int128_signextend(Int128 a)
>>> +{
>>> +    return a.hi ? a : int128_exts64(a.lo);
>>> +}
> 
> Should we ignore MO_SIGN in do_ld16_mmu() in the
> next patch then?

Well, since the next patch is broken... yes.

r~

