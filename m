Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68807D5C0CF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Pzv-00062a-Hn; Fri, 08 Nov 2024 09:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Pzt-00061f-Ok
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:30:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Pzs-0002Yd-8I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:30:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so19131745e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731076198; x=1731680998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JIyOpWsIdv8kFRBEg5bjtZkiQ9mzRA39tcgchUTXeJk=;
 b=tayyO1/zy/mVeBbd6ZCfMeupCMEisUpcERba6WhNYf9oCOcgJNw0H7y7RlHJsCcxjZ
 NSTM3RauSmS1WSs+IK2bbD3B52oDeVGKNrnxXNs+TrMbSONWQ+Jcx6ygr/j4WkGdDgkU
 6rg3/yqKoYKb36XywK/EU9SEc+5+kMzKYR8v26LFj0mCub7Ilw7DtARER9yn/OBd5Qov
 kmzMi0laIa7zY4TgANgwkhJMOe4RISZbaAPIG87uonPUK+aj4CM6HxxtuTnaU4CnCoKW
 A8NhS2lKjXvKALPXUxt1x0jd4/yND3d+RqM+o+cmHWo6ngX0k3U+2MC8RddkCWY25x2S
 G2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731076198; x=1731680998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIyOpWsIdv8kFRBEg5bjtZkiQ9mzRA39tcgchUTXeJk=;
 b=oEUyD7gF6XC/w9t8vH10efKWiVMjAM14gWGOGZNhzMiW24qDqCMBhDhJzqihrydwGD
 AB/k7DnPHggTfRLFLhTKXwylA/fJLLLu/vltQtwz6JAf1mFrNV7FMV3H8uYDC77+WDtR
 jTjz2VotkeezXwK8pXaANgIxhucic1Zwpo9+hpX2bHcwCdXr139T8K63HFR06wwmiITk
 f2ArALPu45Dd6ay3l0BufWTOqWu3qyAd8VnM6ac+f8FSfxLKJkMfztbcYYuRHXX/VqS3
 DWiDuKMuGYlC/xn1hxx+jEYrKbGRwUZQSWi1qMGipWf4+VsREQKB6QvWLTAPwmbGMunw
 p0lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxR0slWQIK4lrelJhwaXDLHIXaepHKiM0FI8lAENwIKu7Rbc5w90+PJoFouwG1jQ/+e8YiCwSWJ2WI@nongnu.org
X-Gm-Message-State: AOJu0YxdRJMSoSxh2fC1NiLfiaytoJ7omMHJJusMWqxowETUiE5D63Dc
 us1xoe9AXu9LbihhES+qhN/VujYCQBjoAVVEUN1jITxY29/og3nT8lLcwoOeRGI=
X-Google-Smtp-Source: AGHT+IF4gXANmcTPwN4j+Zijqv8ia/5yLmkxOEPJ5HlLv82l70bdmq4oXEACik4A3nSFhG6veVwRXg==
X-Received: by 2002:a5d:64c7:0:b0:381:d890:b4b6 with SMTP id
 ffacd0b85a97d-381f1834e6fmr2485287f8f.48.1731076197664; 
 Fri, 08 Nov 2024 06:29:57 -0800 (PST)
Received: from [172.16.22.241] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a7508sm106380205e9.0.2024.11.08.06.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:29:57 -0800 (PST)
Message-ID: <51f753df-3d7d-4f85-8a63-88714e9117b6@linaro.org>
Date: Fri, 8 Nov 2024 14:29:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/nrf51_rng: Don't use BIT_MASK() when we mean BIT()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
References: <20241108135644.4007151-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108135644.4007151-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 8/11/24 13:56, Peter Maydell wrote:
> The BIT_MASK() macro from bitops.h provides the mask of a bit
> within a particular word of a multi-word bit array; it is intended
> to be used with its counterpart BIT_WORD() that gives the index
> of the word in the array.
> 
> In nrf51_rng we are using it for cases where we have a bit number
> that we know is the index of a bit within a single word (in fact, it
> happens that all the bit numbers we pass to it are zero). This
> happens to give the right answer, but the macro that actually
> does the job we want here is BIT().
> 
> Use BIT() instead of BIT_MASK().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/nrf51_rng.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


