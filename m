Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5980DC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD7n-0005AM-Jz; Mon, 03 Mar 2025 16:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpD7l-00059o-WC
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:14:54 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpD7j-0001Dt-QY
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:14:53 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2238e884f72so36474035ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741036481; x=1741641281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FoZh8kij63L7ZWUeVXuxEfukohfNTDG1Eqnv6ZUsiXg=;
 b=AzQs7ZtzzUVTSGbbWmQRtGfkrgZtsK3BcjhmGXvryzs4ZmpHGy7CUYrDA9EuNxNVOq
 xd4k6IA3xPLEUF+O6skICkqAOrr3maG3/x4Jrt/+b+EZrmVPbRxw8vQXCXk8lQzGYkU2
 MgBKXBv68KNNNRYVnnBb7I6pgW9on6hPQ+iH1bHN6L9YwFeBjyjI44zoUFUtumGd7ap5
 /awvLtDLlsI1EO7GLuIHZv3xIBAaq+OmDppOIa46Td1K1STjxvYEQgz3ecTfT2USANnL
 miLM9Nyb1uSbWP62j5RERYle8O1oVwAqaDc8haFIE3b3seL2iRh5eeholOF0oVtIHR4k
 JtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741036481; x=1741641281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoZh8kij63L7ZWUeVXuxEfukohfNTDG1Eqnv6ZUsiXg=;
 b=LNj6hK0Fs19iYNjhsLbCxHzhc/yl7wJ+R//LSrgDit3Jx6ea8HOaRp9d2Zv1MUV2ZK
 IyZToc+UL3A5EHaBtqlWZzePDeyA1ABOVqok8foxanJF388CAWbXuwDPjR+tgrN+lI2A
 e3fnR7BxBs1RyILGFo7qqcBvGT4ycgmWd4fKosvEGgCDK/idrvdOaPO3oolfbMk4bFP7
 9rNcG+EbUysCogFgYydAe5tCW2VDQc8W7CPMKHk5Oy57REPbx001JMHM4dPID6OJPW2J
 hW3kVsqCIDCHwjgliyRSO2Wj74HL9jhlXe+2m5iYjIrh959pFV8hdv1Mn/jCpFeKfpUm
 /Png==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr1NdsAiAZOzxYnQ2W/WljetWeMS5Tm0Awl7pfOI5pLNQc5xcfqLk4v+ijpIfEk/3LyQEOkXKihF1p@nongnu.org
X-Gm-Message-State: AOJu0YwUOmzpRCgXux41fTBnQr+pHxes4NmGXIWG/oJ7TxrRCxO4DJWY
 VPx4/Fvg0ZidYQD2oaSWFTl/pNRptq/UPti6DuJBcXNuAt2wwKuCxmNBchFk9vI=
X-Gm-Gg: ASbGnct1aGLJgEAZpqRz/7PA1blWxU+Hghbgr2NgYD/bP+NpZU0bRiL8Es5JVo4ZFpX
 NuRAg+UlEQ6nsg/wCYPXdaissabnGJnM/948mhl0jyhlR6D2WVb3McasDvWcYLZOk7Vqc2yMKVq
 6XlYGvMJQ5TYTXlLrDBcWbxFzi3FyXW/Fucvegtzy+FArXAxDTbmqeJkN8/FCmA5b0iOXhk2prf
 C6+k7OBn1sTTys6+IB20bc+myIorelm8Aydh0Ch5R/FEZcbnQyF0YaDFYb4+RfNSDJZUlrUO4xu
 +zCbEjaYRH96dpIjIoWwfOSAwCrdiNsi4h2bCHZQPUQiTV7Ib6M6LGuEvo9dY/yuj7L5b8UFQCU
 6i/e7LkaW
X-Google-Smtp-Source: AGHT+IFVefc98/ZzTj9ySy/gnW+tHnG0UZLiqT6Id3TLGY8/XbxU9MI2kqJRINJ3Tlz1exedbDJkHA==
X-Received: by 2002:a17:90b:3952:b0:2ee:e518:c1d8 with SMTP id
 98e67ed59e1d1-2febabe2603mr22527470a91.30.1741036481272; 
 Mon, 03 Mar 2025 13:14:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea676b133sm9422819a91.13.2025.03.03.13.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 13:14:40 -0800 (PST)
Message-ID: <72621646-1c18-4986-ae8d-66ec2a2147d3@linaro.org>
Date: Mon, 3 Mar 2025 13:14:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: fix msan findings in translate-all
To: Peter Foley <pefoley@google.com>, Patrick Venture <venture@google.com>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20250228212329.1775669-1-venture@google.com>
 <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
 <CAO=notwzQsC7oJZxY_Jby9znX0ov62AVXsTENb7tagEBR2DcWQ@mail.gmail.com>
 <CAAAKUPP_mK2VApyCOf2N3twYfn_fe5P5Y_OMhmCSqP1HrhZSDQ@mail.gmail.com>
 <CAAAKUPN2AJAuNuzoHn5dOf3R3WY0VZzmT3mff0ATZF2-6SHsqQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAAAKUPN2AJAuNuzoHn5dOf3R3WY0VZzmT3mff0ATZF2-6SHsqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/3/25 08:40, Peter Foley wrote:
> And interestingly enough, it appears that execution continues even with early return from 
> get_page_addr_code_hostp:
> https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translate-all.c? 
> ref_type=heads#L308 <https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/ 
> translate-all.c?ref_type=heads#L308>

Yes, but without using the hostp value.

> 
> Which implies that we could still have an uninitialized value here:
> https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translate-all.c? 
> ref_type=heads#L362 <https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/ 
> translate-all.c?ref_type=heads#L362>

Passed through several layers of functions, but still unused.

Eventually, we reach

https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translator.c#L257

which again checks the -1 error return, skips the use of the cached host_pc (now named 
host_addr).

Again, I'm open to unconditional initialized value, but doing so in 
get_page_addr_code_hostp, not tb_gen_code.


r~

