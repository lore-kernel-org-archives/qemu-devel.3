Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E70C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc21Y-0007Ib-US; Sun, 26 Jan 2025 07:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc21Y-0007IT-4h
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:46:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc21W-0007Wc-OM
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:45:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so85164225ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895557; x=1738500357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0khpsUGa7gfVqDH4A1DW8013hnLaXZNt9HsFKni5FE=;
 b=kTqv/myZ0m+J4wzOjNNKmDPLCKi1AnXdc2MwZ8Y3xSf6clEx6xF+vQf7RqtY8k5J83
 uRX/nGC8AyaqcGU5rxp3X3jtJJcJ/N9at0v+zToKRds/6KoANm/Wgt3DLHOQ99Z/B86M
 q1QmVjRptjTmR2MfPFXaCoZjZ4SvtNkSx2Vhmm+Ur3qfhQF6ZwUeKdeWkggIFTSa+ltd
 NMKEr3QkZLj1OvFlSqMu299167CpAtrCXEpAdmD3pHfwF2j7T1UFWrrzaaiJ3YkfvOT4
 VO/9oajlJpyWMJxMaDRrsCLU/FLHCbXbmDYeDqDFGi6nZqQmBNPbMZ/0aZHwWbd9UPyG
 Vzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895557; x=1738500357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0khpsUGa7gfVqDH4A1DW8013hnLaXZNt9HsFKni5FE=;
 b=mjWNVWutEhyskrfvx0Ti/kglF5i8qgXeh0YPxuNMfLc4ecYap8HtW4VRlOJP4YyFYh
 MI8LLS4FmO/t+xBeLgmiy0uIaw/jF02zAkGdthm2xU5NLFAdUS7bWaM8gu9nL/Inopts
 6x4OLLLw0T+IQ/YtzIwSujgBpq5R18Wet+Yur1laBQ33MQzQkeD+k39APGbum6D//Es1
 zkjBGbZrrAVV1hrJV3k9vCy/LRKhIHdF47FoDlhzYd3jcS5D5OehTXY1WaCSbn3NZs5D
 3MCZok9A7s2blaZSPXXQRCivwIH3vIILy0S4ADlUo+JtIMYrXWT/2wHKaYHkzO7Z4ZFS
 dhPg==
X-Gm-Message-State: AOJu0YzumLs1I7oTRdrMriBT+4jpvcsIFmNsjgM0xcKaI9MvjUQag5m+
 u22h9AMDIWu0m1iogParyQI0Z7NCybiRckVsLJ1Avsb3x5fZOzV4zOrn33cKna5MefUyOCMpYde
 b
X-Gm-Gg: ASbGnctyKBTzp9Pu76EcfcXtf2Wupx0rXqzZTVxQc1gCx4lytQeBPukpQp+GcgRTvAQ
 73gzA+3+WbRzQfeEcVIkg+nU86igCJGhjebAMIZYfVxnzbEhEa+nrS9vGMGzXvXuh2Z71YPlS7O
 tl1pThrVIzbX9sLWPf0UTwZyfIFV7Va0ghI5bycDqwJUyCG7lSrpQKZ4mvGa4HEJCpdxU3bjb7I
 a4egE+u18TfIg9dSBKlYGMx/iIgpzLFsuMGQ/mZN01pMtDjHNQUS4nI/5FuepkmjkEOP3xHLBfd
 9sRayFv3B9o0fAP6bNEWmEM=
X-Google-Smtp-Source: AGHT+IGEWJf3AYpcFD8O+4O/iPJRAEEjnLDRBr/w7aisX0DmdiR+wzZLHrWsrQq5WSn9/5eu/tfy2Q==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id
 d9443c01a7336-21c3563a33cmr649026655ad.48.1737895557315; 
 Sun, 26 Jan 2025 04:45:57 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9e1b2sm45152305ad.17.2025.01.26.04.45.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:45:56 -0800 (PST)
Message-ID: <ba9bd56a-849d-43c4-ac9d-3a609217bd3c@linaro.org>
Date: Sun, 26 Jan 2025 04:45:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/76] target/arm: Implement FPCR.AH semantics for vector
 FMIN/FMAX
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-47-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-47-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the FPCR.AH == 1 semantics for vector FMIN/FMAX, by
> creating new_ah_ versions of the gvec helpers which invoke the
> scalar fmin_ah and fmax_ah helpers on each element.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
>   target/arm/tcg/translate-a64.c | 21 +++++++++++++++++++--
>   target/arm/tcg/vec_helper.c    |  8 ++++++++
>   3 files changed, 41 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

