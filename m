Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA12D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9r0-0000xz-Oy; Mon, 02 Dec 2024 12:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9qz-0000xn-4V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:04:57 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9qx-0002P3-JS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:04:56 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b65d1c707aso340178285a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159092; x=1733763892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uRSGoZKXfzW00AjeVx1nCCOHT8P2wkrxvih2Y6a6Ojo=;
 b=oKnZ+dyos/WRAeMkTXjdrRzPyGOS3M3MVujUkbH5Qb9UKxth/+Ts6W5uR8MoGCErLm
 ekK3JybOyJOQaQiXYZHCAPXYN4gT3Am1ckGSk3U2OIgczD8RRU2OlbQ+RrZYbeAnHsBH
 MBRT1Sx+sti+8FJnojMea7UalVC8ZEApqisygMOuP29CaYqaiSw2BAqupVESZLUuRWrJ
 n07W5MdUP+bXFyI8wcMpZ6/FlD7MGdIlFb0JZU1JojJY+l06UgC+RhgSH2h6Gr8/Kys0
 9nslZ7ahXbwHeHvQXT6jJFwWFGC7w92cc7502Fv0n3Hqaed/R7nLr7cJNRSfT7QQvPaN
 BLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159092; x=1733763892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRSGoZKXfzW00AjeVx1nCCOHT8P2wkrxvih2Y6a6Ojo=;
 b=UQ3IE5e0la9fA4vQMQweQAHK+jdeFTe5RZAG7Yj4mf/SLgkBy9GPeutDwTLvmeSdYs
 oXlTrYxgy3QBG+PobmHb5nExrPZAXBmlUeTw8Ar7qNiNBIxXHahBB9liHFfg8ArfhiBu
 FLAVDyR2AkyN0DGbqe6EbikngUMnY7yF0DRfjlwPGZxY73KIDg/YYwWRm8Xt+tJWhHSI
 gE1Trs9fW8PoRQAvenI6KjA2sRwSxSgzFuVw2SLLJmVBZCIN1gxFJb/YaDdeqh/tA4AT
 H/zF5Tw17XHLOAp+Ze7hisacobANG/OAEaownap2aHvwgk5N7hlnrAEx2hiteSrCHhP6
 RUDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIoiZ+ccvwYVgaGnvOn570bZ1sDZR6Pi4vp2WZhiTQzd3XG0eauDGxNGuIigxAepd66bkNI/0iQ/Sr@nongnu.org
X-Gm-Message-State: AOJu0Yyg/rPa0E969w5jlQnp305dUty6y/n1rLNnGfYQNLjeleoYOcln
 nhwC5A4PdCDMMvVyY7v1YF01VRn3j1bIs6/kehCs48ttl0fp7X18fZ/+QvTTt/6CO0GHa4PXZ/z
 ech8=
X-Gm-Gg: ASbGnctad/c7IaVn8/Osts7gHSgyvvKWcuTgyq8tdHYosXNwaOn/Et2JuoUMU+nDl03
 WAPOed7LSGGGZTrrPWHFpxy8QuZsP291aqwB9FGh8teo6kpv/vm5tNeK/tcfGdzobsv0ahKOO65
 2hSbaFgnwNeeCyPdvUq6TpqunwnAqgm/kr05KUW1EHSenx+xJcXVx4scVNwq9HtcfKtsBEF4M0l
 Pn2pgrDqSIoxXgJLzeSI5H84snKasKtO1RBBG/krbSChiLJ/3ueO/FMx+yFGmL3Cyd3gzI=
X-Google-Smtp-Source: AGHT+IGgvLx86uYxhmZLVYICgNmbol/qZPiELkGj4n3HhdaItcTv4rpvFfKaDA32fMLtqYHJBZ+SZw==
X-Received: by 2002:a05:620a:6403:b0:7b6:6b88:cbe5 with SMTP id
 af79cd13be357-7b67c24492emr3871688085a.1.1733159092429; 
 Mon, 02 Dec 2024 09:04:52 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849aac1asm422899185a.85.2024.12.02.09.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:04:52 -0800 (PST)
Message-ID: <32ba634a-5797-4eab-8806-d691563ca46d@linaro.org>
Date: Mon, 2 Dec 2024 11:04:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 04/54] tests/fp: Explicitly set inf-zero-nan
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:12, Peter Maydell wrote:
> Explicitly set a rule in the softfloat tests for the inf-zero-nan
> muladd special case.  In meson.build we put -DTARGET_ARM in fpcflags,
> and so we should select here the Arm rule of
> float_infzeronan_dnan_if_qnan.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/fp/fp-bench.c | 5 +++++
>   tests/fp/fp-test.c  | 5 +++++
>   2 files changed, 10 insertions(+)

Lost your SoB.


r~

