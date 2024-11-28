Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD4D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGiiK-0001Dj-6o; Thu, 28 Nov 2024 12:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGiiH-0001DZ-Co
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:54:01 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGiiG-0005KP-5F
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:54:01 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46678a11ef1so6400491cf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816439; x=1733421239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8NePUAiHOQKFb6vb1a9Xa9aQMqXYszOS7fQtmHeI0w=;
 b=Y+yRSoLiHTvuhxsmNbuDAaarH1ErklfGZ3sGrQd6/qs6k745xprFiFw9kSmbZreUDV
 5hnGdEz8PKEqx3edRf6SvPoYQHP72T+pIxEB9xdDNg2YLMO9xWv8mqNukaOJ/EOl/9jX
 YeyC2k6WtLD9RQnakq188d0cUKvguRM3AtB3eibJihK4x2RCYLNHuUDvLODaI83zprgX
 eYd9+0PuD6uRFn0Wi7A4NAPyaLZVxT8ypOogTS00Dg83z6qE9dvquOzDlr2cJwkdWgSS
 5lCXcR2HNwBXIVtWF3UsX+i+49Zx9pkuXDV/TXhV1EYQYURVXZ0Y6sjKbbykhTGtgjag
 S3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816439; x=1733421239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8NePUAiHOQKFb6vb1a9Xa9aQMqXYszOS7fQtmHeI0w=;
 b=RV6sqMY5qa66H7erJ9uC2jVavnGt/U8vjwB55jIESuLWwWScnYGs2dXiNgYmQpoA0z
 zGVvF6RmIj8C9WUMzL73gQ2VpSJkyQuT4P6Nul56bgTBs205uX/mmnF2KM3qaZ8n4NMe
 9wsyY8vHUv4DAEiGcTjBxgYYMB/AXHkHgYCZQiP9VutYPvCFgytQEEMU51lzgnd0KuoF
 vvMwPoB+nBoePKmtF4FOUFaLYE6G2GhdPncGKr7CIKB7/F2Tbp/KyLATLUEYdtKmAKtB
 tgTLGlwuQjWP0Fw0ydj4HzUzsTvgf9oh1KVyWbebsN6d07kN0wUXjPifs5H3576FaJVl
 ni3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkd2VWuENiM37uXFUD+Bi/+5uILbnkHqoKxXkrb8u37IiRI158aEaIfY7tQeOMmseh6IEIjIasLOj@nongnu.org
X-Gm-Message-State: AOJu0Yyg0+S29QHMSIOwnd6ngL9+rJDnRjGDOvdcs1NRQJieZiQjDqzx
 RxiJLXeHW/Ll1ZWXZsNGgYhsKt/LRnIOhgbJvLSxoaUqchr2mzNKtYh1aCU6wM4=
X-Gm-Gg: ASbGncv5wahZ+RVPMJ4SnNAJnmhCyqrZi20NbHRa3NkIKCZpv4FE9B9XUZTpTxoedZC
 q0OgvqjUjaqn+swrhz4yQfajygmWkk/U97dhjyKH3p0nA/41FEOFwsRiKV3MPxO8WsnD1+ERs9X
 FcwmQJ8eKJ27bX7oCcjms3D6HVs2nFg/VM/35ZyAPpUQJVLqMvuxRL/0QDyCcYKOHo47cWfGIio
 HmXFZmc2GA7kl4Kht+aKuaMkwibuh9xtKJcu2Ib6gkgQT5WHRIuOpNKIc+nKz89r9o=
X-Google-Smtp-Source: AGHT+IGTl+gP/HpTu0bUjnZjzTGERff/0XCh9n9uWdl6TkJCb2qt1zY65Pge9ck4El3ZN9UQ/ejZWQ==
X-Received: by 2002:ac8:5d05:0:b0:461:1fc4:1016 with SMTP id
 d75a77b69052e-466b34d39bcmr105210681cf.7.1732816439050; 
 Thu, 28 Nov 2024 09:53:59 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4055062sm8621801cf.6.2024.11.28.09.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:53:58 -0800 (PST)
Message-ID: <493ac55a-81c1-4e57-a129-2f32ce8f2b3c@linaro.org>
Date: Thu, 28 Nov 2024 11:53:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 20/25] target/sparc: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-21-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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
> Set the Float3NaNPropRule explicitly for SPARC, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c             | 2 ++
>   fpu/softfloat-specialize.c.inc | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

