Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D166D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1wI-0005mU-Ot; Sun, 28 Dec 2025 20:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1wE-0005lj-H6
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:20:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1wD-0001iQ-37
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:20:46 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso107403585ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766971243; x=1767576043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzgjZVOH0TuVlTZVe+keidLwn6BWFJyS9XoaeCJHPMc=;
 b=idXb8x2fVVp++Q15eVGv3xlc/lpdK6gM1BaXV2ob3jp8lJeQgAqMianVrBs9VoCYaQ
 w9uYwjp4cTv/huTucWNpFM7O3FaU9iikwUo3sfOHwm/Wqj/Tc5+5GRtkhrcnkgJdTigu
 VKNlCRyadaPCThVqyY79NuBTQBpdNaNo8BknQ0adI01V/vsceyz6OdiBKrUbNx0jUqqj
 iQmBV3qnN2vbh63tsRfnTCoDr/KYFBphsRSUGzzfMmHIseic0ipb0/n9Rr2rjFu/TIqy
 yZsvV8rN7cGVLvjVhsjdNQn6PTRiILqoRCzsizVGsE5aCBf1Bnaf8zPMDeMz74UHigFf
 l//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766971243; x=1767576043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzgjZVOH0TuVlTZVe+keidLwn6BWFJyS9XoaeCJHPMc=;
 b=ZVTEP03gy1PRSVFWgq7lF5vemqgjuUfpFGuh+18OEhR8nQC6xMR8mn1YkwW8gjssae
 z9gY+UV9CTDJZu4JIGSWw5y8SYqujv941z94N2haz0qDa0IJRVrGwairwotaf9JiY/oQ
 rGZvZxw1umj+/TLP2HW2yNjmi8eqPjTkgbRiEP6l4zuQE5ATyt5vZTTgZvqqRVTUoG1G
 iYYDdxiY4Zx2LNtYx1lanJJjjsyFt9PdummbJil0LvLJzm0S/6UYyD/AXvCBBQtdNR6h
 GZDA8ssIKZ42GKCM8az+4DIF+b8WO42WGR1Xlzgh/auzD2kqbU6ZHVrCezub9vRY79Lq
 s+cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWKT1XaAt5SZxPof6fcDBqidD/fWehRnfEliLNT3AS1JjhUCGLak6Ol//izH0nQmxzunUQJuXODQgz@nongnu.org
X-Gm-Message-State: AOJu0YzimxaqsAQHcRGfZZCfiPY1LvzfSZffZ0CT9hD8EtYWH+bb8zBH
 iA5xFTJMNpH4XMkYDmAJW8DiE/H0md2IP6gHoYncc3C2OlWu+a8kXThURiiuitJ9A8w=
X-Gm-Gg: AY/fxX7jCybXA8ipBI1FNK11513gEMBs/2eBmCa5dv+TWn/G7dFtrHRSAcb5i5XvrMS
 aTtBDAkuctIu24d0QTZwUtrDwSKHj8USg0LHwDoVUrj7JGnUbMN9X5QcE3pluMwf7jV1oFWEymp
 +v4+qnwoOYNsR2/xb1zUvHye7EReKOgvUZgaXWWcYMyoHHUmIvhvHTSjAM5mxi0GPQzxCiEPpfj
 R+xXEDLxSkFnoSE/ogyvKWAUvS0orr3oDLa1NP6Lx4mpkHoTT8s+IM6aT78KN74Thoj95Gj0hLR
 D3KaLOd5c4vhOOnTQK+5DqgFeD2+TLxqBb3z1f7Pn+lb3HBDfYW358GySqCaQCmmg/HCxHJ2+q5
 o2cSJ7cLT0PULDqhlCj64LJWdDuXRZfY7lTMCX3WW22hFBz4ZkVJ/KRIuDqJ9LbRqAzX5SxPL4l
 +ggcHBozR1NvMjFbrE55luDE66Aw==
X-Google-Smtp-Source: AGHT+IF212/GVb4Ja20CfOjVUdoPBN9tD5yeGzTIjjNHIHO40TUo77TvgMS3gAo+75Kcq7saKWDI6w==
X-Received: by 2002:a17:903:234a:b0:298:3aa6:c03d with SMTP id
 d9443c01a7336-2a2f2a3fc97mr308807015ad.57.1766971243183; 
 Sun, 28 Dec 2025 17:20:43 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c8286esm258215635ad.33.2025.12.28.17.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:20:42 -0800 (PST)
Message-ID: <0173261b-0fbe-478c-aad7-007e6b03ddb0@linaro.org>
Date: Mon, 29 Dec 2025 12:17:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/25] system/ioport: Do not open-code
 address_space_ld/st_le() methods
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-26-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> When a variable size is known, prefer the address_space_ld/st()
> API. Keep address_space_read/write() for blobs.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/ioport.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)

I was just thinking that patch 24 could be improved.  Thanks!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

