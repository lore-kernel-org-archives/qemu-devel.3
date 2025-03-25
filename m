Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D3BC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twt1Z-0007s5-QQ; Mon, 24 Mar 2025 21:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twt1T-0007qt-0a
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:24:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twt1Q-00063K-Nw
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:24:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224171d6826so23590705ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742865843; x=1743470643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3f/aamhcaq65N5QVWFb7BojgdxkqrG6VyY1uYeOMdAE=;
 b=JbuM7bEN97m1TZtBfDTSAQ0jjrQvL5/L+nkXDTZvwvpKoa/jklyIrufRgCP4yMKMV3
 AD9GBseTQYlbP6RC+sCcWavYGeBAKggv+p1eVTHwwtO1KKEDzl7f1giErMZm6PO1ibuR
 25ZSWJyni+x2IueaYbs3Z5VPM5uGE+OXYUxS1+y7eXomqcLLQiaJ1gPwFuw3gG4KE2HV
 qw8W1F56t220n1xjvdLIqLOXJtnjNSP48oEewXgCqj5+qr/Nb78okotHquvj8ykM03UK
 u79VyA2uowI+yHLPm7wVXEd5nv3nOqFZX+rdk23DFUvx5koW/NipY88JsSg8p2XV2z4M
 3B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742865843; x=1743470643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3f/aamhcaq65N5QVWFb7BojgdxkqrG6VyY1uYeOMdAE=;
 b=ZIkUHifCIlvK/cUFaRi25syQG492eJnpSDlYuXVabD4ReoPj6DTvAA+lFyqBD/cF8t
 YPNQDu+S8ndfxUkrNVJE+tmwWDVeeDSCJbbv3a8xH7pYGiWP4xKoIUptHdBDI8wLtGHM
 z4HbaWJOCgUa2DSrKifOGQYEK2eTPyMjs6/SOXk3+NhHGDdd54KSg4GiDVskO/0LQUSk
 FjUfmV9RTBwgPrndyglH/1Jmfg5PQPqBu8+u/aeysk7J0363ExRCQZvXRZuEyWnNZpVu
 5YZrVSWDh/S/USwXQI11cw0WKj90UCIUqMnHKyVHfvOFRoecp08Qig9qNJA+myUK2S8U
 Ck+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU24YP82JlBsHOxfcO8JIJToDic++MRQz8D5Vi5gu5S/S6R3oWmQ4EVim5otFV5m9pVQF/dJFeVXGGN@nongnu.org
X-Gm-Message-State: AOJu0YyOeRpry+iVZM97OE72bnjfgEIXjSfaYiw7oLagQNdSBvaEju2M
 pAAr0bApg6D1tUAYvCEJesTAp8++8hHxerwdFRlb8zjL4HR8ggtlHNqE44LqkO8=
X-Gm-Gg: ASbGncvXdVJQtopIJFHmwJ/W1ZyrLd9UaNPhG3Osp9EJcW99qdvWRplwrnMC2iMyl8p
 NizjDxSsunnRnboGiJ1Bl8yYONgxBQFVB+W/MpMc/lmRc0nbAr9MaEWCfqHoD+L2vl1IexPfKe9
 IQsli/XhVjV9krD/qtVNYPFVHglZd2a/VBB+xCK6F+c4z1OfI1iaIEy5lvKC0NbfPrc+cvKCJmv
 tk4oYMCUD/uBm8A/oyJMlkaVCvGVieefS1i9DSA8ujTFFnjMu7jHr7lKAk2QfBYKQQtUKwyoPET
 49Lz1JvL9qvVqYtyCLs5zJj3+yFt/ZgDkghWp+paIbikEJbl1D9cXt+V0KmW1hKRZSrSADFU5D6
 +wqP/EhjQ
X-Google-Smtp-Source: AGHT+IHtYFXPUcyvhT6u7EcdDtjGqWUVYlhcNricl/EtL0dR+OXt6ZmrKRY5nBmdo5X4L15+2ngQQA==
X-Received: by 2002:a05:6a20:258a:b0:1f5:7280:1cdb with SMTP id
 adf61e73a8af0-1fe42f2c9d0mr25068794637.16.1742865842846; 
 Mon, 24 Mar 2025 18:24:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28467e9sm6648568a12.37.2025.03.24.18.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:24:02 -0700 (PDT)
Message-ID: <428e6fdb-24b9-47a2-9d3f-4ef5c2e1a0ae@linaro.org>
Date: Mon, 24 Mar 2025 18:24:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] target/arm/cpu: always define kvm related
 registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
 <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
 <11b5441f-c7c0-4b4c-8061-471a49e8465a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <11b5441f-c7c0-4b4c-8061-471a49e8465a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/24/25 14:11, Pierrick Bouvier wrote:
> On 3/23/25 12:37, Richard Henderson wrote:
>> On 3/20/25 15:29, Pierrick Bouvier wrote:
>>> This does not hurt, even if they are not used.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/cpu.h | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index a8a1a8faf6b..ab7412772bc 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -971,7 +971,6 @@ struct ArchCPU {
>>>         */
>>>        uint32_t kvm_target;
>>> -#ifdef CONFIG_KVM
>>>        /* KVM init features for this CPU */
>>>        uint32_t kvm_init_features[7];
>>> @@ -984,7 +983,6 @@ struct ArchCPU {
>>>        /* KVM steal time */
>>>        OnOffAuto kvm_steal_time;
>>> -#endif /* CONFIG_KVM */
>>>        /* Uniprocessor system with MP extensions */
>>>        bool mp_is_up;
>>
>> I'm not sure what this achieves?   CONFIG_KVM is a configure-time selection.
>>
> 
> CONFIG_KVM is a poisoned identifier.
> It's included via config-target.h, and not config-host.h.

Whoops, yes.

r~

