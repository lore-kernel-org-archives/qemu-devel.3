Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F8E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 00:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1UX-00045d-Jw; Sun, 28 Dec 2025 19:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1UW-00045V-8V
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:52:08 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1UU-0006qQ-MH
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:52:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so75222855ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766969525; x=1767574325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwuDY7yTN4zB/2omvRVtJ3cZTef8GHaNJryBMXIMIIg=;
 b=Y9iKGmZ2u6jz+GOvfATO4AA/eFMWH70toUZCyPMwMuJ9xYyGVg1nH33STHIHFZQ31G
 5uYvE8WqYMYMACHZe0R7jsv14Hb4GdiFohPP5yRak8OP5eOkuaW/Kc/W4ACuUniRzftV
 In4GFgSMsDukhB2gALuMKTAtNcogQYRrIkGBBNknnn9qJMPPDHGqlsMJc1XsBXM7Guws
 k5kKbS1YQKaECQOAQksYG27eja7pidpFVkladrvF7VbEw8XEGJvwgKBZLts9wrzc55Vw
 kqpCuMjaJKq21Jhpu5G8RcXtLNr/Myp9BUmGCpy58YcBhLYImU3mwBOvrMy9viPTSHuZ
 IpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766969525; x=1767574325;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwuDY7yTN4zB/2omvRVtJ3cZTef8GHaNJryBMXIMIIg=;
 b=XusGEiWCcgnncAdJRGA37YWyOywsiDmnrH5RXJ6Av5UX1KsZR/Hj0EqFob7UueaDbr
 3XaWmjep7xbevNxMvfcMYXUfTp397LaAaxLYNlCqlO22eGr86oqv774jbeT8ETlbxQSm
 k0KcLb5zLEPsjLeHwMM1w2TBxBaAqQ2jrBBH1xA7TKzOWwV6Oaw1OxSocGaRb4+ffGbw
 nn0jEOf60YRRnbMudY+ziVxvwyy1ZR6GQDwggQd2LHz38rod7MDylVBWiE3UvBZiAbGi
 m3MhK24toWrm8xOoO0DbePz8pNMOK/kZpcz+kCVs+mhbQzOQp4cafvO1c9tf5g/J4+An
 r3qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrjG24yzpReHU0wvfev3GfU0JMy83nL7kDm6XVWgs1XdEUv29lDr3t3RJfv0NcV19FvAk91L8AAwqc@nongnu.org
X-Gm-Message-State: AOJu0YwRjGWu/YsiiMP5d329C72c8Q451X9QHIyti1snOx6n/fBVjpoJ
 NMjdy5iHOoXdLxnkmJLW/DNwSEam2IOanWzuMXCF4J3UShRGUrguUV9AlhTUi8OnoDc=
X-Gm-Gg: AY/fxX5yj4JPT5ISlK+KbJ5qW+qVSnv51ickMLCscykXpFjI5Jtnczhj9jzKSlrxlW0
 f3fIJwbv0aaDgmdhDjSJoiK/XxcASAw0Q7FfVCUTmz7WQCf4gtmWYkebbGAXcRbvoGbyoe4szKc
 5AdBdorJ9w+3ZyycU60Y1CG52eg2/LxO6JfZNsnwozTm7W+clG9Uwpvn3aF0s8t/dV+CqYaik0/
 rMCty7Z28ZUTJVlvXdwNX1iAQNTV724UfNoxoG1hMZxD1h1gZIFynJn5Ncj5zDft9FPqPcmo68F
 Fk3G+Mr9ao8Oyj8pDbB7rJMxEmSHgvdL4oG7MIacDX9LVWAvbUIOptPBfD+xCHJXI+E71jbQuAB
 Q0ZznfAhJATqxGoyv7ZHfSLzGTzxcySEHTtwZRX8kaAF1E3x0R/sF409CmN8XwBdDuatcgvwArr
 qofieHRqv8m9FYXOW3Cp1kXth+fRGJ07jndRMSDQzuDoL4Y9Pa/o8YqGWQAEQpDDltalNBh1eM/
 2kovwqB
X-Google-Smtp-Source: AGHT+IHPfhfv5+tjo21yCR5iO8BDR/bTLOc5V/8qfoSbIm9gy9lTsJTQGwrULHo3E13KQQ3I0rDOAA==
X-Received: by 2002:a17:902:ef43:b0:2a0:945d:a195 with SMTP id
 d9443c01a7336-2a2f283beabmr279928865ad.45.1766969524861; 
 Sun, 28 Dec 2025 16:52:04 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm259346695ad.31.2025.12.28.16.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 16:52:04 -0800 (PST)
Message-ID: <61307bd9-bf5c-4b19-b71b-b2501e30053f@linaro.org>
Date: Mon, 29 Dec 2025 11:51:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/25] system/memory: Move *ldst* headers from exec/ to
 system/ namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/25/25 02:21, Philippe Mathieu-Daudé wrote:
> Keep all system memory APIs under the system/ namespace.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                       |  1 +
>   include/system/memory.h                           |  4 ++--
>   include/system/memory_cached.h                    | 10 +++++-----
>   include/{exec => system}/memory_ldst.h.inc        |  0
>   include/{exec => system}/memory_ldst_cached.h.inc |  0
>   include/{exec => system}/memory_ldst_phys.h.inc   |  0
>   6 files changed, 8 insertions(+), 7 deletions(-)
>   rename include/{exec => system}/memory_ldst.h.inc (100%)
>   rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
>   rename include/{exec => system}/memory_ldst_phys.h.inc (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

