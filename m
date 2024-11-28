Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2204D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGig7-00075l-Uo; Thu, 28 Nov 2024 12:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGig7-00075c-3Z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:51:47 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGig2-0004Bk-V1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:51:44 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46679337c24so7470651cf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816302; x=1733421102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0KhQQm7LAZ1ZYok6sL3wypZ2K4GD3eehY6zXsDXtQ+M=;
 b=ZyTXz4WtFUAbbTh0mrY3s/3hLOW4tGv2dnm5P769iGQECJKrKGFpd3VPwOHYTl/KZF
 llQihOI6gpLxF2z72bWEC1tr8VN84Xc44N2UK1DJlykgz4F9+MD1Zzhp3qjhAU/MsDkS
 +gKT1sQmlyNZ5vooBf+oHfCTc6+Ly/FrEJFNNMhgTu/5ehZ2hUoB136SEl5MTlyXMyVu
 r9Q/lvBmAfO475sWfAnqU/hIYB9wxn6T9K2i2xpvJb3v+9S3JepAmElCOmewu3CwAfyO
 UJPFnrsl22AcYz9zuyqs0CrsV9ypp+LwhGO8LIDjFKLuI8TfaFCuczNYb5ERSBE6MdUK
 lAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816302; x=1733421102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0KhQQm7LAZ1ZYok6sL3wypZ2K4GD3eehY6zXsDXtQ+M=;
 b=OOr8p+Ke8Bsm5JXim07li5WtZ8wKRWv13bBAV821YsgiECAXjLHm62mIqWDWDm000v
 ZiJk5Z9oIJx8x5vzAoedrC3nS/qS29CxWYSjI0aZJAwTgXNgAhg7xIyUl04Ryub1/VQr
 4vEGKyy2sHVuGhkl3wMeXbz/29Cd4lN5ooIHusB++KeRW9CHdFd53DlGDbYeQ0vVQtMa
 AuxKF3MfQuxrhAUVyfdKV8/+A/pFuoJS/+yYRata+S+lzb46EMBXt5T3wRnknl40nUVN
 PwasF6PEPhYh9EUBg5NyPzZTT2RKRlSb4atWEcezfO0jAieeSOOGYV5SXrufxAyqaALn
 TgSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHOwJSdhUidJMo9RZyG0Um/VeSXOctp87RRxUk/QSco6EoIXZzuwR2LM0hNz2A3UJlzhHWmiRB21aM@nongnu.org
X-Gm-Message-State: AOJu0Yyhf+VSap/O/g055yPfwPDpwfd85RuCNs+kaE6TJr9HzdZjNs1Y
 6C2HAYOTY5WZdQ/SFLkFclqY4tBbjA/F2iWp3mLaAKDFuE5g1Uk/bVzUuzkJ5XkE1vbxY416NUQ
 MEL0=
X-Gm-Gg: ASbGncsT42/u2x3l2cJx7iL6SsYRysutH6E6bh1aAk1WNy4D67RTjFzPJTfU1QgiIut
 DOy3Kufkst3Z1O5gDEiYOO5CkyxR1525OPnt5hTNUf25MF/tugVkcIGJhU4yhtfF6i6MNmhzMr8
 b3bhj7XHaoatzuGwW5J9sjRyIvfYnf2KmmZdyNtST5rssEbNqv1IkVfFOYxXOlrMNUMDBBt8umr
 dRhHinQSJMJ+qaX691DSIH3yq1OQu4NX4CWYuA+zZH/q6I9NrlAA7BHeCD3IS5W3IM=
X-Google-Smtp-Source: AGHT+IHg2Mvk0YNpM8z6udoCixz1DHZVoQpfavij0YKlofNfP7xyPdZSc+QqTgy3Pug04krGTrP/YA==
X-Received: by 2002:a05:622a:180e:b0:463:4bb6:bfe2 with SMTP id
 d75a77b69052e-466b366f08emr132244041cf.50.1732816301860; 
 Thu, 28 Nov 2024 09:51:41 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4054d16sm8615921cf.14.2024.11.28.09.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:51:41 -0800 (PST)
Message-ID: <6febabb6-0ec3-48c1-95e7-b0ba1a8ea8a1@linaro.org>
Date: Thu, 28 Nov 2024 11:51:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 16/25] target/arm: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-17-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for Arm, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c               | 5 +++++
>   fpu/softfloat-specialize.c.inc | 8 +-------
>   2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

