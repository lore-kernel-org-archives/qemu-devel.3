Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9E8C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZkp-0006GH-Ad; Thu, 31 Jul 2025 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYDO-0001cJ-5X
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:41:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYDM-00061i-Gz
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:41:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23636167afeso673235ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753987275; x=1754592075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doMUWIgRUCZHu0ghlXWubeQ3uFyDpsT9R6VbfkdNNYw=;
 b=YxlmUSp+Caynb06i35vHo1il0YLpgX3pU5auDSQUgRsSVpnf8nLQn0GcgKnCd1GMdC
 IifYNp8KMivlBDwI/OIfq5EDPKlVemgafgZjTQKsF36cUodR2l/F351my7It5pXZMzDj
 Jk2Dq5aW9TP8wlpGp3DBDBzD9TJuIoox1m3/Bj4AI/8wnKC9lPucy0PgbvQhYCZkp4Ol
 pCE7r73ONlVsoGu+1TEx7R039cPm6e+gjq3k8ihd+MqBsnWwQ2lp9jucK06OHV/NB/UG
 G8wdU3/va0mzAKMGsgd1BiSX87cJ2jSCzJ79dKfY8VYtUHXpygZdLNgpil5anDtwcETS
 ghhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753987275; x=1754592075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doMUWIgRUCZHu0ghlXWubeQ3uFyDpsT9R6VbfkdNNYw=;
 b=ubR4PAGLYK1Wq51humAlh/ZJwXFVI1TdZyMVoHTi4X8388HEdF916cjo1c+U7vOUm6
 JHplWH25404+D9XYOsPA3Kg48DwavuAu4bDqlQpE1TcPwR05SScCi4Hg7ALVhwEziL9I
 pfA4GZDui+vmpAD4Bn5YW9v6Edr2Wo1leEhGQNWQrrSo0plNjnbylwmfNUEMIW2LZ/ir
 1Yig0xQDkYAlIpz7zPKUsBQoWwWtd8Bh+XUAsMEcw9wOeCi1oI1sg8BTkKtduEj6pXJs
 p99ILDnHeOeWSVMRpxjVxHABKNhWmrHbJuQNooJs/q5dC4qpVVdvGje2aS/WkFRDEsIF
 o6XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ur4daz52HYro9c1NoQuqcWrkLdcTmOHte0hcSUympMjvI344epo/SmqoleBsxMg3h77QdvaEJdR5@nongnu.org
X-Gm-Message-State: AOJu0YxqjbWP2iP3ub5ZDJ3Y9RmGvktag53xK12EBE84OAnYjWOiifGl
 MKLzLrlp3bCT8n37/1Ebq9WhdnN1XOhlHXTEnVJL1ZR3/uyoFgNT6uQ3YSc745B+HKvRt96S/DU
 jM9Xv
X-Gm-Gg: ASbGncsyeVruLPfh6goDTG4RBZ7Z0GhQHPpul5AANo8MVQiQ5/46UTXfhHEWF1oJXmZ
 fOX7XRF5TYAxIVAUzz5jKnjz2FtMY5DDBaRMuSXpY6naln09/bWjukU5+4Fuj4FCvmRc/zbSX3Z
 VXa+ZK/DYoiERZ0UPz3bJjmdQ8+ReEITj9I+XyMo0CW4/BUTQITFss67T54H4LmT2DMDqTYoN9a
 qlOU0rvtxT/zBQJjRJRvmVnIlzABDRTN90+UZD624LbLfhjNZkox9lJcxCyUiP3bQl7kmCBCf8o
 sziJ61dTTE1jSQEZJLO8SGSqDa7Z1zM/CoNicYs17WizKAaeUySfR13RpFxF4MFmi7kcmet0TMf
 EOoqzQCjZZnGnFo4Q39L2166aFwOIJcA2Znk=
X-Google-Smtp-Source: AGHT+IGIe1JF9t+qwn6YNTd2ykkMeSeEAL0V+RpvprdX/1+HVeKkDNpYVCwPHMForeUeJgTquEtn9g==
X-Received: by 2002:a17:902:ef46:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-24096bcd286mr124177685ad.41.1753987275032; 
 Thu, 31 Jul 2025 11:41:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8977345sm23710695ad.108.2025.07.31.11.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:41:14 -0700 (PDT)
Message-ID: <e72bfc26-ec05-4cb3-a8c8-de5731ec8483@linaro.org>
Date: Thu, 31 Jul 2025 11:41:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/82] target/arm: Implement gcs bit for data abort
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-44-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      | 1 +
>   target/arm/ptw.c            | 1 +
>   target/arm/tcg/tlb_helper.c | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


