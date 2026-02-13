Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E8EF99C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy8C-0006fF-TZ; Fri, 13 Feb 2026 13:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy8B-0006Xl-5X
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:43:07 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy89-0003FE-Ix
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:43:06 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-354c67da885so1009046a91.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008184; x=1771612984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FbYftkL2SWtQEDppXF+96qN61r7InJ5PDbJ/47UR+4E=;
 b=UoZXsuQnBiPqphlUL/aXvzNRyo1arqGzjKta2KYLFQW9cwjBXTnm83To1YWdk5LiSH
 tL59xco8YJRvOIO3wrDaNuCO68Z34O9r1RR1w0g9b7DitP/h5yDqe6h6gAzXD78XOSxU
 t8fFxzR1b8E5kqokgLKv2+DDodVW/TGnKeStFVIZLz3PToz4ub1DZgoDZrHAa7y1Ai9D
 Dr+dSnYc9O+kLpQbi3Tevg0sXcssfxUgDpLrWv3Jr2Yp2yoBpRuQE78iyLmIFnDXpwqM
 8EDrDdnchNYBBsicbDoBtVGfCHTYWsSEyqnzpFxrb1ObgucjussdHK5F5nHm+C/3gkW+
 wYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008184; x=1771612984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbYftkL2SWtQEDppXF+96qN61r7InJ5PDbJ/47UR+4E=;
 b=gd/Vvn3FJTUAFTSF86pwMSoBHqeaC0gznJMO9ajHterNoIBxsprpgIB3Wpfb6s0dQq
 VGXhoWo21wfPUIAlyUAu5LU9UMmyhF7AAhW6NyF/Z1RnprHVhkCeR33v5RuoytYP8lgg
 xIoetsUxYxm9wnTlWfmVE9A+TJt6CoGofgq5w+MQSt/ZSfj0zJAGX0o98ZMisLO5HFon
 UfEbAmGakrWpj3I//Qwo0kpuaoxz+yTvK6BrA8AdASUAKioy78ynP5499IXXz8PSdq+f
 Z86jBfeCEvAZvOJjVNfD2zaDMExG62IJq4CC5I+0RvAsgApmig2vPVhG2ABbwmFPXkSs
 d4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeIKT5EMlgHS7sV9KH02xDtr72qpSUY2AkIROk4Cz5EAbBAaicSFrL2g9+NhHpa4OXtAAyZle0KlEp@nongnu.org
X-Gm-Message-State: AOJu0Ywf2Hi97556F2kPupJ0RHh7Fsk1rEs7VwJHRXIjKZ4ksaROe7rx
 3Xj2KRmNF68viL0Rsd06Pow5NL5Ha0RQPbixrXoqYeoEGEzWSOdnxJBGSYYu4Ucmni8=
X-Gm-Gg: AZuq6aJBd1A75FVYujt7DRbFEUVudOxxv38oE/hIORPQZvxOeLIHQngbIb6Qah9jie6
 xHDBlXMxNjRO6sa+7UhCBa5rJnQHwbjm7SKHIRLJjvGnWYcIcpQwNGM+bv6cxj4IUeTlXkgXrIX
 9zDB3WxmkkesP/9fDkSLCcRH9whDT6mjvTHVCdmbssLuITBX3fn2dPd9j6boXAdi8m4oqIeJQs2
 gnHKw6q3Nj1IM9bhIweK8HKL82a/v0SCKJ+/oTVFtYljOMjro718f/ZnrWqeEfIOEMFaiubhlbo
 5z9zjSvXpoOgosKeqkpwM9aCCtYUP/hdb2sddShukKChns8ce2gpiflGTt6/lMVwsR5fZJ680yc
 IAtOEyfnCShqe7nqn7YrkYweSS8ahN6XJCzHUwgP0+j82NXPGRx4WfEwjKRKAa83kQgvqsuwV1a
 Hk38UP43HXvkiD2kdzGtVkSCi1aJu9Wi2texDJC0CtAjJas1ODvAeI5y2DE5cR++T1qvDF
X-Received: by 2002:a17:90b:3f85:b0:353:2e1:9605 with SMTP id
 98e67ed59e1d1-3584481ab87mr460645a91.6.1771008183737; 
 Fri, 13 Feb 2026 10:43:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a29aa5sm3318596b3a.8.2026.02.13.10.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:43:03 -0800 (PST)
Message-ID: <68446903-698c-479f-afe6-45fd8bf74121@linaro.org>
Date: Fri, 13 Feb 2026 10:43:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests/vm: build openbsd from lcitool data (!567)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
 <20260213154859.1551283-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213154859.1551283-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/13/26 7:48 AM, Alex Bennée wrote:
> For now only use the minimal decadency set until all the OpenBSD
> mappings can be divined.
> 
> Currently depends on: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/567
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/lcitool/libvirt-ci        |  2 +-
>   tests/lcitool/refresh           |  5 +++--
>   tests/vm/generated/openbsd.json | 27 +++++++++++++++++++++++
>   tests/vm/openbsd                | 39 ++-------------------------------
>   4 files changed, 33 insertions(+), 40 deletions(-)
>   create mode 100644 tests/vm/generated/openbsd.json
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

