Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2A9D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGijt-0002uG-QQ; Thu, 28 Nov 2024 12:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGijk-0002oZ-Vc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:55:34 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGija-0005oa-EL
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:55:28 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6844074e7so77306185a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816519; x=1733421319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jj/1gQO/jCuWzJN3uskDHI9AE2uBNKoAhvsUVTgNgl4=;
 b=mnCiXGyi5pOUpvfT+DhYelrFW79ReUe8gcrHZSbtYnAdMjohp64q6N5K/Tu71RYyCO
 dGl1kgNxbNCXRUXz36rIztJ5w2YYo3/OC6dqmWh4PwDEo7Y04U6TfR087EE/lg/SLw0o
 +AOpDuwormYx3yMlq8/6OgApHgVDrcuEDO/dmoYexVVlXcySkKaqXQqJVfBR+YJ3tRRG
 AwPRGzUreWAbqI8oVYkfE7A1tNYL3dNL/8D4tj/n9fhdU4S7YFcsGUeglGyGTSp1p/Sj
 i1yI9WKw4Of/79BpMdO7NKIJl/SrmDAvl+98f1xvYCJNG8AjieWT/AG8Y4uwP6bf/TO2
 zXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816519; x=1733421319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jj/1gQO/jCuWzJN3uskDHI9AE2uBNKoAhvsUVTgNgl4=;
 b=ShrlygJ7HDisp5cRbPxM917PQki5xPew69cCiimCMeXinYLwyiyMc4uXj9+3vkIuJP
 AaT+DElu5Gi9OlChELHRVqAvHz371xE3p9uaSnBA28Zr6QL6gO4+vVUSAD7UWKD2dTqD
 xIicL6AwmTyHUQbNhxd9KmxQKSVdweMMB6nE35Ifp87TvbtWHteQc6iydVXGx3lb3gkA
 bnR51X/jh44OB4MHLaUlhYcF8MKHEL70lWorRjs3g8pfNN8JeQzCk7FkRkZ4HmNr3hiR
 9iWxMNYsbYoD8lJjrexjuBhvlI0b4EEiLfLSohbLWIWEbtVoQMsgI4XBIp2nL7IeaOVe
 3sIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1QWhoxGZU1nWcYk+Tjfm4MYt5pg9GHXAoEhr+r5h5U4VDrFss+OnOP0dY151S2L5KSu+0WYySn8zr@nongnu.org
X-Gm-Message-State: AOJu0YzOgUzF/KcR2ccNE4FaHcHW3opEjpOBmdonVn1AAQ4mpmdEMLcJ
 MrlA98a/mOo7jvPD1ydnnZa1lRXkFFsdY+zgUUxUBMhNEdkxUQhH/ZttYiCqHMceDa2O/drxhw4
 tnJY=
X-Gm-Gg: ASbGncuHLcEtXy+xpnqCWEgahHUswo2dFhtSs6lMK6sxuD7j7T5JGVcJ5mt+pqKYirM
 Ild4EsdBGNlhuCKhyVPV0l6R9JVXIVlrkq/rC5YZuBLIHKS630GsQ0xUGKgArzDLn5HvGsAfyft
 YII3dZmEH/N8hNvmp6awhplbLeWg2b5Uq1Y584ARHP6g0PifP1c1lcMhlo9st5KlQaqyNoMXxDe
 XXHNcTAnvsRC1Wgvtkfmoef/M+DHbBzey9tq3xp1afdHrZzuknO0ETMsnzP98XHfS0=
X-Google-Smtp-Source: AGHT+IGXPTtMP04jmgs1hMtxf5XS7qBmjVf7P3bQjftT9RQxtvJvLim5Wyr96y0sr09P9yZ+vrpNXA==
X-Received: by 2002:a05:620a:2915:b0:7b1:3bf5:2da9 with SMTP id
 af79cd13be357-7b67c2c0f89mr1091643485a.31.1732816519090; 
 Thu, 28 Nov 2024 09:55:19 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849b6d11sm75180485a.99.2024.11.28.09.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:55:18 -0800 (PST)
Message-ID: <8af3cca9-325f-4b67-b8ad-4a18527f5165@linaro.org>
Date: Thu, 28 Nov 2024 11:55:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 22/25] target/xtensa: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-23-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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
> Set the Float3NaNPropRule explicitly for xtensa, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/xtensa/fpu_helper.c     | 2 ++
>   fpu/softfloat-specialize.c.inc | 8 --------
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

