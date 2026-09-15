Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7766C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Z84-0002BP-S1; Tue, 15 Sep 2026 15:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Z7p-0002A6-Ku
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:47:33 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Z7l-0005tV-OV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:47:28 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so152551a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789501644; x=1790106444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAPFwBY8DtSuAjC4v/foxHEG0NNIDc0PTEeQzCSO9GE=;
 b=bxqolmkUgTkql8rOK/q4t4UKgkCLywVPMv2Eg3QU2FkdQRqHY/W9BCQ66BqF/WzORk
 0itgb9M9JFr7fMWrPa8+3X/H7AjYFukpRWlU9HuRuLvNAfM21jxXoxHpmGA3dfptoJ4H
 U12D0egE5eJ6tMA//6tI19ix/513NagTShpewHhDI9P9LXDxm1Bnt1aXbgxMQHG7lX9g
 fMFh8xcG5WvwilsG5t5F0hHP0wSNq+LCL/zSd40PaGeXpqwHZd5J16z5K1y1b3wHgeUV
 bAbin67im11d1I6eIrVsxuxZ0sSjFF/h83zLVyICPZogCRJMn2nassG5nnnxGS94Jy2K
 Giew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789501644; x=1790106444;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAPFwBY8DtSuAjC4v/foxHEG0NNIDc0PTEeQzCSO9GE=;
 b=kOUfSL25GsF+aZT+T5+vxvWag1/J98V5DgnQhAVGpIwLQMYOAhLD3MkvXA3KY4Rq5L
 0UZsPKdXCo1rqR6nVNBZhz6CvJVbvAp5Crg7qEEr5WKw4+JAv15DVdN46ao3F3t+hgp9
 lNbNpRv9A+ImwN7GXH1CcIa8TAFmAlvQzXS4uhE17OGM/jhfHS3O4Lo+AXzqI5o2VyyA
 hiO+w/pmEpLcaX4OrcdFzEO8oeUsnt+jy7DHdKqkmDmPBhrCLSme/RLleuvVXplG1ULG
 4xSoJev8cIO/JWQLALRycePi2qLFfjapyIE955mmasIj943b6lDQXvJgoSVGP0HJoJ9z
 ha4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYHE/72iW+uapfmniCUM46JOcBtOOX+vqFbEz5PbXKANyx0tcJ0T6Gq+8yNgG5DuPvwo93q808OtLs@nongnu.org
X-Gm-Message-State: AFuF++kPTwZZbzS+TP3NZL2iGZcnN/uC8cn2ce6m8mZsCj4o1O75fiYB
 Tq8u556oCHQnQI5VbYPA+f6KCYdOyN8JfXSf9CtCAK98O2IjQ0ILbhd9xiEG8y/2lXA=
X-Gm-Gg: AYBFou0IDeuDXoHKeJbAUYjgNJfQKj0SNVjNcDUyBz4gZbrZcINsI6yF0pFmqXt5nPJ
 tWe5S4gS1kjlGxbq8agjoAN4WyHMf3IWKO5iz9pO8Rwallu4Ug/qBUJIOB3KKegP+OJXho6HYg6
 0B36OHlmDSGzZ9ls3nHIYL+WbVD4eVmcLCsPi0c2NKXTox0fxIhhVUqFQ8lW5vnvitBXwph/BSu
 h1CaZTL2pk0fp4VoMbnc7pp1CoXgxrhKd4cnj6jUlT3qob1Hb3FCgEqW03KtsM7kyDNAA2k5oMF
 YTpVnSOOr+NnGCN5NIoJay+/OKoF+9NZpZ5LMRktNnwXzM2EhHG4R0JfQOUj3d/nrJxRPY8jY5v
 5OMM3Fp86s1bvIGAKvS0oLXCNI7i8NFQCWEDgva6f9Eka4gvXFcBxyFlc0hsqBHu6FmLtUiMP2U
 hTeH8P0eakB0nxaY4HpDfqNBtZSzgWNRbPIXtQ2SaMT51EeCBgVSNrkcoUX91++G35BNBGwbv1K
 yH1pf+t99E++/UWrcF262CWHeiCNCklxTmdBAiqqW70qDncpv/uVy3SnS3eZ7QZPC51zQ==
X-Received: by 2002:a17:903:19e8:b0:2d9:32ee:7b83 with SMTP id
 d9443c01a7336-2dd6c5f4ed7mr164526195ad.8.1789501643796; 
 Tue, 15 Sep 2026 12:47:23 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:c119:8717:353:53c6?
 ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b2753csm2098554eec.31.2026.09.15.12.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 12:47:23 -0700 (PDT)
Message-ID: <6e2b535d-5d37-4cd9-a24b-55f47f54d088@linaro.org>
Date: Tue, 15 Sep 2026 09:47:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] parallels: report the stored dirty bitmaps in qemu-img
 info
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260915114258.3862446-1-den@openvz.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915114258.3862446-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/15/26 01:42, Denis V. Lunev wrote:
> The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:
> 
>    Merge tag 'ui-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-09-15
> 
> for you to fetch changes up to ba48db334ba3ae0b89015583057468e127cb903c:
> 
>    iotests: cover the qemu-img bitmap operations on parallels (2026-09-15 13:30:29 +0200)
> 
> ----------------------------------------------------------------
> parallels patches
> 
> - report the stored dirty bitmaps in qemu-img info, the way qcow2
>    reports its bitmap directory
> - cover storing a bitmap and the qemu-img bitmap operations in the
>    parallels iotests
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Stefan Hajnoczi<stefanha@redhat.com>

Applied, thanks.

r~

