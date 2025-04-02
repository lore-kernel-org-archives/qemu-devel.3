Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AFDC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05OD-0001eu-Rf; Wed, 02 Apr 2025 17:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05O1-0001Pz-4N
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:12:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Nz-0000Op-7G
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:12:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso899995e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743628353; x=1744233153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7T6RWdp3VzKL9YmF/dHvduFGWZce2SBaH1/e0xTHbQ=;
 b=sRbIMjjpV8PBePASwGcfaO/zMYeDqWZTfeITB3aCzCOneCNX84D4XwVUrrNmY51yHL
 mt8yhnYK2t/blTLR5hQ8GPclHi2gzSI5YNnqmJnsZZmyU3J+8us3ruHmHt1HHr3GL3iN
 uQCt7lxFwkyzjAyi1OEEY46pdtNsHn/rz3ajk+Nz+4akjqJRiUsp8jNQbwZI88DpnSGI
 Bl+Kc1Sm2BuYQlI5mENIKE81skgGUq1T7GkmQv1ge4Ydj0oEpnIyvzNIYo5xdFmYtbG0
 YpKYAlpIZbQUzScMl6IYKT5a73Fm4yf82+uYIKuszwlGYUKcRFzSTMMtAvBD02PIC0K6
 l/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628353; x=1744233153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7T6RWdp3VzKL9YmF/dHvduFGWZce2SBaH1/e0xTHbQ=;
 b=QuxRSWNmYSUFkKMycq8MxE1iplohtcRp4Cqiue3Fcy5Jybf+zceeTcERxbfCXDydQG
 XrzVkAQIVO2pU9pG1a4xeyHvBv1rLjVWFQNdzteVC1xoMKgK4oR7nG8vNDaVVXYJG884
 pZgctf+nT5+Q/fyp5zK2vT+3WcxkcMquzB9cNQxWiosOvfI6cUw4JyHyWZebmld6Q+w1
 Jj6VHHjGeFaZGMcaUc9GBYe6kTlivUAdFWQ7lSLVEg1fXHU/7Gsy5OnY3UPMOOl6zMgw
 60bKvKFAVyiGdThKMTYvaE25XGfEzsrQ6jHoUggSDE4Ouc+cd3f9XZARlRTrQCI/vuEU
 eufQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcaNrKBVlHbMYJXD26yAQIoUjr5JMlsg8Tx1Ja8Ug2d06QE2GmnvPNgHqldvSpibQBm7sg+sKoDJEc@nongnu.org
X-Gm-Message-State: AOJu0Yydf2TaEqhEpBTFsE7dkunXmL/lga8bSuNNYhQN/Rq2dMi6+pej
 NN+rMMpuBNrjA/GgmOaWrd1IcYCzFv4XzLvzzSwhmYgh14fOoWjR80Rwre8rlO0zllePhIiUMNh
 6
X-Gm-Gg: ASbGncuYp7TRTN4fEqTRm/WQ3I0ZdGckDNZSOuXSrVYp0mSv0UuK+jsRHt+Q/NyaRk6
 /NqaHz98Ji74YIf0hXcOsHJyvG9pqD9P9UWXGV/wCS8XEbJH1Hq4OcRqSgOWE4HLiM5uhfJfoVT
 aywgXSd06IQBvqF6mD+JjLtGBy0b4AGTnsnzVWzerxKm/RFGvNyT+/da85TpbAFyVGM7DzT6M33
 ZrehTtHHHsG3kORKzErIrAMUv0itE3z1wTfbp6upRIHyVvZMV/HKePaTY5LeM5ZzsVOvtMRl7a/
 aRjy6MvE+nilX4niUVO1dCSjAL1otyBmx3ERkSe0aHKM9PuyVoM/kqXHfQ03N907OzTJYqf5hSr
 eCwxz1Hb929Mz
X-Google-Smtp-Source: AGHT+IF/msAqsxzaRFPaCX6PN8jC6ao//IVoW7o6XY2EEBX5QMKDnUXryvvo4cWo0EXpd4rbJf8inA==
X-Received: by 2002:a05:600c:6792:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ea7c717femr82976035e9.13.1743628353479; 
 Wed, 02 Apr 2025 14:12:33 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec256e5f6sm46475e9.31.2025.04.02.14.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 14:12:32 -0700 (PDT)
Message-ID: <6d4454a4-4782-4a9d-a391-010e559e907b@linaro.org>
Date: Wed, 2 Apr 2025 23:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-4-philmd@linaro.org>
 <c5b9136b-abe7-47cb-9341-ff0280d53ef1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c5b9136b-abe7-47cb-9341-ff0280d53ef1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 23/3/25 19:43, Richard Henderson wrote:
> On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
>> Use the OnOffAuto type as 3-state.
>>
>> Since the TCGState instance is zero-initialized, the
>> mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).
>>
>> In tcg_init_machine(), if mttcg_enabled is still AUTO,
>> set a default value (effectively inlining the
>> default_mttcg_enabled() method content).
>>
>> Instead of emiting a warning when the 'thread' property
>> is set in tcg_set_thread(), emit it in tcg_init_machine()
>> where it is consumed.
>>
>> In the tcg_get_thread() getter, consider AUTO / OFF states
>> as "single", otherwise ON is "multi".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I think it would be better to leave the warning where it is for this patch.
> Move the warning when required by other changes.

Doh, I forgot to address this comment. Do you mean, defer moving the
warning to the next patch, where we remove the TARGET_SUPPORTS_MTTCG
definition?

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


