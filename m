Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D223E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOqh-0001Ug-5T; Wed, 11 Dec 2024 10:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOqf-0001UU-DZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:42:01 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOqd-000284-PW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:42:01 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ea68fc1a7cso2948160b6e.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733931715; x=1734536515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/V+6WmErS68we8rDOWo1x2NG3NOtYVZMtfAEc8POf5w=;
 b=UOpECAHRICF9EsNi4zMPWlbcUqx5Gg/Wqr3ILpLXrCgpuMtZQ2mEnMP+DJmV0JDT8e
 ofBgyybYlUs9KA6OnX2Oo1NWWYlEmQJhdFvVEMGZfM0PrccO3FD7Lx9xpud1G5DhbTjA
 7I45KcTwz11ZiB83yMkUarY8ziiFM01LBQyRwIPRdRrqTmTOU/CIFnR0viHhCaC6wuKg
 ZV+5dwsiW/lW1IQJ8e0T8e3jCxhf7wbRfwqQw32q5q4H5gYPI5nr14Zl4I/6bLzpEjWV
 z9dcjYfzuZP3mQpVrVnjfAR7Vl73vPvKnN3jpSta19j2/GlfZg/mq9/Z+ycyLDOq5FaF
 AupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733931715; x=1734536515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/V+6WmErS68we8rDOWo1x2NG3NOtYVZMtfAEc8POf5w=;
 b=Lci+l2gpVpWXRGRHLocIPCSkV4Z/3vx3ivK0GmnhLwFiUDsww9taPZN9z7ggS1zjnC
 Vy0oW/WHZO8J6t8NJJo66ABuY/FtLeatmZubiC3k5KnfGHGIZVwPYXkyb8pSDzHylqUJ
 JQ0DgDNIk2c1Dly0GU/c4SbKfjVo46o/6QOz+CTbqSpffk86WWpyXBbTgSk9PtndSm+P
 fabTDAyd8iHSnUWg5pwjUdU6B+CGBHddOChU2fqw2zQsS0pIqL2YF5z5a0MqEGxC2lZZ
 aF2QoEfNm7YBE/UF9GShANb896nNdRfUJYY+3v1T1LySFK2ZLrYN4BcsKnTpBAbnOlzz
 oaTg==
X-Gm-Message-State: AOJu0YxYPw2VxuO/W0xvVbfFP769CfTnx6TdXFOPc+YZ7jnAiOc8P/HG
 Vp/GxnKrHOImux9tJD8KF9kdSsF7XILtBlHBihLlpIuGXmb3Z10Imf5v+pCDKNCEX4pNZhoa8Kt
 xnZz+LWf/
X-Gm-Gg: ASbGncu0Mhr3fRwS3GPkVWu2EGIlMIrHS/lTNVQla73Xj9XeGI7CnFydpNEfZ5RkECo
 MMwotnyEDIsvKFDE1kn4MY5Ix0rXor/m7YX6Jb9DTPg37PW7V4/97bgCCrL9u8d96+Q/nMX1DVC
 dmKOkusDPVRIZ3z0MYf0CwddjkTkX9Jhr6ZpWr211GGHGdni3pteNYjYna/xLg84ifNdAU8vGoH
 /Qy6GihUiXt/NojMO7/0V7xgBEaw6bnJnIn4dElc7g0435c3enQLAx+r4E/c06RhjBOSeA=
X-Google-Smtp-Source: AGHT+IG8lutSFEcQU6zheKFx4KPvg+XxzQLRM/fzevOvROvUfMFPS2s/jOdMYUPhj6LCVApuwR0mXQ==
X-Received: by 2002:a05:6808:3a08:b0:3ea:6149:d6ef with SMTP id
 5614622812f47-3eb85acf173mr2282374b6e.1.1733931714651; 
 Wed, 11 Dec 2024 07:41:54 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8be9ab58sm163430b6e.38.2024.12.11.07.41.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:41:54 -0800 (PST)
Message-ID: <919e6491-3aeb-4437-9e54-2b132d7892bc@linaro.org>
Date: Wed, 11 Dec 2024 09:41:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/arm: Implement fine-grained-trap handling
 for FEAT_XS
To: qemu-devel@nongnu.org
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
 <20241211144440.2700268-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211144440.2700268-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 12/11/24 08:44, Peter Maydell wrote:
> FEAT_XS introduces a set of new TLBI maintenance instructions with an
> "nXS" qualifier.  These behave like the stardard ones except that
> they do not wait for memory accesses with the XS attribute to
> complete.  They have an interaction with the fine-grained-trap
> handling: the FGT bits that a hypervisor can use to trap TLBI
> maintenance instructions normally trap also the nXS variants, but the
> hypervisor can elect to not trap the nXS variants by setting
> HCRX_EL2.FGTnXS to 1.
> 
> Add support to our FGT mechanism for these TLBI bits. For each
> TLBI-trapping FGT bit we define, for example:
>   * FGT_TLBIVAE1 -- the same value we do at present for the
>     normal variant of the insn
>   * FGT_TLBIVAE1NXS -- for the nXS qualified insn; the value of
>     this enum has an NXS bit ORed into it
> 
> In access_check_cp_reg() we can then ignore the trap bit for an
> access where ri->fgt has the NXS bit set and HCRX_EL2.FGTnXS is 1.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        | 72 ++++++++++++++++++++++----------------
>   target/arm/cpu-features.h  |  5 +++
>   target/arm/helper.c        |  5 ++-
>   target/arm/tcg/op_helper.c | 11 +++++-
>   4 files changed, 61 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

