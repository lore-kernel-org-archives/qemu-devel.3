Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9AFE74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 19:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIYBF-0000KK-Uf; Tue, 03 Dec 2024 14:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIYBD-0000HK-UF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:03:28 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIYBC-0002En-BL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:03:27 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ea5f158138so2718290b6e.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733252604; x=1733857404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQJzDaCcj7AfQbutpjaGoPZQbLoX3i50/ogR6/P/iIA=;
 b=paPXV0YidWCeNb/oGaVpooLY9UzqFBr6LGIpse4FShAk8CnTL1CZzfNOIpnPSjcLGF
 bzwcdl2CFTqIrpvd+wZHfevm94HtdYxzqAfCTe+ZjWhOcBy1gP6ehV0MKWilmjPHY63E
 EAFb1Zms2cImSmG84AyqXK6GGkKrzTu1u7lCtHFV8BFkpU0Rc1JHUR0SGLWrRliV6GLb
 BINPaUEJ+goKrdZLEUYRNJOYYjpUUEtfIT8wBJVJpSJw1XA8JZmR0EHKfsGx2TURAOcT
 iJzCXrSIO0LHahkkCyROttYLdinPReYKzDDEE8rM+rU25xSxWyMxWdF8S0M9/BhHQAWu
 ExaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733252604; x=1733857404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQJzDaCcj7AfQbutpjaGoPZQbLoX3i50/ogR6/P/iIA=;
 b=OGYmsHCdWeZlckNDMQDMQWxLTaJ5b+q80wnLBXLYA9C62Hu+ykRKNEsa/TZ22oyT3y
 uDWevI1x7r7VIFka4INsSMocUpjdkirj84VpvHld7DF6/wGKtygjwCOzGlEwmWpvKDGs
 SF8Izn09AYtikTa1BSx2sC+5UOpbklguSplclvN7YDp3ana6lBeBRCnJHqQXvTQUNsvI
 scIhrDb6KsAlpqmm4Y20kd+im2dOxpRJAnBAZ82HpkpOt49I4QpbN7hnTwzEWvQZb5bV
 MENzAmdQjULlnPnZ//gAN5LXM+yo76WPVgDH2NH/YJcaiuqWR05mxciNToocV2ajKVuq
 Cm3Q==
X-Gm-Message-State: AOJu0YzgscdScOy5OCCecMiAnGrs/6sw+4wYERlFKIrioI1zGPYhZrky
 ldSNcQ6r1x9AMAxyp3/8cEOL/VrYL3hfLwiZqosIQqZaIu+LTq4NfTC7D8Y8Sd4=
X-Gm-Gg: ASbGncullH8NgVOEFXH7i7wx6zfqcF6D2gBiDj3MVlXg6pdbCNpFwOfzFvnhiXoZ1dA
 v1dMA+7HEfxBDYFRhREpWibVev4CTuXxtwC4/ncU4bOgR8+kTISgvmsmPUfRcuVnHikWVFK1urm
 dhDESuUmlQyXd4SWaQ4b1GU97QOsrXxEjND4fPegJaXsuSU9PJgfXjqQHmlHIrGFytwr3okwEm/
 PKysiOOwkPeLSEhS/VTfczc3z3xawNDvqm7Dzwsg9CoTLwHEWE3HxTsAaBwPWpHDoUX3nxq0h6u
 mFiqmxSy3rkKzn3A3wPPDcNaPRDE
X-Google-Smtp-Source: AGHT+IFYxbRWeb9aVaKFm3CuoPViarxnZQEhyXQjE17WZU7CdOArxFpdVtnKTZ2gO5sX367Ybx29XQ==
X-Received: by 2002:a05:6808:238a:b0:3ea:66c1:cbef with SMTP id
 5614622812f47-3eae50d7cabmr3067869b6e.39.1733252604608; 
 Tue, 03 Dec 2024 11:03:24 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8634d830sm2979012b6e.52.2024.12.03.11.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 11:03:24 -0800 (PST)
Message-ID: <ab3ef70f-d458-4738-904a-0c847cddae78@linaro.org>
Date: Tue, 3 Dec 2024 13:03:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 04/43] tcg: Add gvec functions for creating consant
 vectors
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com,
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-5-anjo@rev.ng>
 <a1e76d49-e307-4718-987a-839e0cbe074c@linaro.org>
 <vmaedyamz4zas5elmgn4sg4n3wrgofganonh2drsiube52awdx@76pvdn6onmkt>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <vmaedyamz4zas5elmgn4sg4n3wrgofganonh2drsiube52awdx@76pvdn6onmkt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/3/24 12:19, Anton Johansson wrote:
> On 22/11/24, Richard Henderson wrote:
>> On 11/20/24 19:49, Anton Johansson wrote:
>>> This commit adds a gvec function for copying data from constant array
>>> given in C to a gvec intptr_t.  For each element, a host store of
>>> each constant is performed, this is not ideal and will inflate TBs for
>>> large vectors.
>>>
>>> Moreover, data will be copied during each run of the generated code
>>> impacting performance.  A more suitable solution might store constant
>>> vectors separately, this can be handled either on the QEMU or
>>> helper-to-tcg side.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>
>> This is invalid because generic code does not know how to index elements
>> within the target vector, which this is doing with its per-element copy.
> 
> Hmm I should take a look at tcg_gen_gvec_dup_imm() again, isn't it doing
> basically the same thing?

No, it's limited to replicating uint64_t.

> 
>> The code in target/arch/ knows the element ordering (though I suspect you
>> have not taught llvm), and could arrange for the data to be put in the
>> correct byte order, which could then be copied into place using plain host
>> vector operations.  I won't attempt to riff on what such an interface would
>> look like exactly, but I imagine that something sensible could be
>> constructed with only a little effort.
> 
> I might have misunderstood how gvec works, I thought all elements would
> be in host order, and so copying from a host C array would be fine?

No, they are not.  They are chucked into host-endian uint64_t, but the ordering of the 
uint64_t is specific to target/arch/.  You never know what "index 0" is, logically, even 
knowing host-endian, simply because different targets have different element numberings. 
Especially big-endian targets.


r~

