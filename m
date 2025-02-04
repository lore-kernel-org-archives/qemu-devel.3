Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C531EC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQiY-0007J7-Sv; Tue, 04 Feb 2025 16:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQiX-0007Ip-JG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:44:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQiW-0004lJ-6p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:44:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso42212135e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738705462; x=1739310262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HirS+efXtai9AWrBSdUYOL4632DOxcexEWe1FcNRPEU=;
 b=Wa/jap2glH772d6/zNQnvORKikctfySTOKYPa/xi953csovg49iJrBWf1VITViJzid
 3zAV7F1HznBuIF+0ODwT2nahX2hXiDi9uDgzqGgBxKAfjo9Qsft3eSVjCjOv2kK2ImYh
 CodO/qJp8+vs1Hzc7/Yv4VvDNN+Rrq8E5dG2MG4fZfXAVA94xvaVx5vPT6W1YNKxJEwr
 aFALCgiGkxFdzouROnI3hTQtqJp7r5zVKxWUhokevjqw6wOfGSRgV1vRcndVWngaasX8
 QNRdK7g+V9tpXYSZ858Ij08kGKg2CZa9dLo6C3ogEKh/+BkmSiDhoO4y8P1ul9EDLqch
 SIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738705462; x=1739310262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HirS+efXtai9AWrBSdUYOL4632DOxcexEWe1FcNRPEU=;
 b=vE/YJXfcZ2OIYh59dsNLByGOVpuak7ImDFqVaLUV9wE8EdBp2bB1DiTUQ3m9cje2xx
 ykfd4x9ga3m1woNPefgNmmgrAaNBc95Z6FKxeNcgmALaXbXN2dl3fuwGeF2/Fhv3pqd0
 6xyvmq/fiaoOU5LaH4ntavyInvtlEfYN2Nd9rZCbOIzhhpk7dCSYtDyCgrMagBoRQ6Ab
 o7+V0UokIoo9Do8ppw72i4bM//t981Nonx5KWtzL9OXnM039OBaHklLD/9SoEq0FOjig
 cAqH4sOwqzT1PCm78nI3IJrKGL/98/PlcVgpGiHouxMtsxAKLJOi6kR1fpNrVq7W16El
 jp2g==
X-Gm-Message-State: AOJu0YyTlJFm90dNdwZS56du9B56idbZxxSvmJCMvkFG7vuW9aZJlU5Q
 uHBpBdHh9lHqZvhESu4hFESZ5PkRD4IxGgOhYNB5BVoQ5JgzNtefVBt+Hk5Rk1r7XciuIWRW84o
 qN34=
X-Gm-Gg: ASbGncucecHMwHeijF9K9CwDWflT0EEx81vEIS8tOZ/A5dfSyxnEHIMgrABjXESfHzm
 BdWVujHsSW4AhSGNahDedPUZiPgXQfuBFscKDHXK9zDxQGd8pcPh73pZFuYO1PG99oH8j0dZYcD
 pbVsuj19VyOsgWymeDC66tQVOQJ/Pyxdn6xkBU+HLutjv+iHmX5Pd4zCSkdRthV+BtPNv7/QEVl
 Q4jHlBQN3XN1Pj7Apz6Odnw0z8kSKJBGrCGKQU2e3Nod3z102GJAcJ4buL06NlQ4CoqryOsjmYD
 wQv/50pdKlVw3x7DkUHY2fyVa4oluqJEEGMDUrIR3od6PiqP8Ucpj7HQGn0=
X-Google-Smtp-Source: AGHT+IEupuehcIzdd6BClMcxRHmBrlRjx+wigeto+VouGkFQap9cClTbhIKJNqTe1MhYU0kzAKkYNA==
X-Received: by 2002:a05:600c:3111:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-4390d43ddddmr1848395e9.16.1738705462187; 
 Tue, 04 Feb 2025 13:44:22 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dadca52e6sm2580134f8f.0.2025.02.04.13.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:44:21 -0800 (PST)
Message-ID: <0e30640c-1dcc-4b83-b69f-305821714151@linaro.org>
Date: Tue, 4 Feb 2025 22:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qemu/timer: Clarify QEMUTimer new/free API
To: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250125182425.59708-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250125182425.59708-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

ping?

On 25/1/25 19:24, Philippe Mathieu-Daudé wrote:
> Update few QEMUTimer docstring and add a
> sanity check during timer initialization.
> 
> Noticed trying to understand leaks in QDev
> Realize -> Unrealize -> Realize transition.
> 
> Philippe Mathieu-Daudé (2):
>    qemu/timer: Clarify timer_new*() must be freed with timer_free()
>    qemu/timer: Sanity check timer_list in timer_init_full()
> 
>   include/qemu/timer.h | 12 +++++++++++-
>   util/qemu-timer.c    |  1 +
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 


