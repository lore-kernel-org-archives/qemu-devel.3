Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E43D2F7CC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 13:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRVpo-0007X3-Od; Fri, 05 Dec 2025 08:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRVpj-0007WV-MZ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 08:26:52 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRVph-0001zG-SB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 08:26:51 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45066bee74aso665196b6e.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764941208; x=1765546008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kC4nl2cFcOGdE/QGi5Jzw1XVWtzaQwO80xOZkzk93us=;
 b=FUqrAzIVkm8D5/riEHLRkX7Kyl7PON22bu7RrUPpqExtecfcAVqy4ZxRrVHag4voWi
 8XyiwFzaFojLrMWOAiw6cqz3ccgDO7xOP1G3vwbZ+F9WBkvojn5n7IDfjhMw8kALlkST
 KE6sBLkZAAbj9gL65hfWUODpAKNYhGGk41hx5gE6IhqDtJK+sh2SLhEmEKRI8JsyMIN7
 xqAkMYU3/VpJPaNDhbo23tVEQdAtE6wWJU2g8d34MnQZIZIwqNZroiS8iYfC+bav/dy7
 3nqnxUE1udTYyRusQEdrJOTrdRbGw0cJULA/guDcXKBes/hWhGZ7sf3nSydDCwUarR/4
 O2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764941208; x=1765546008;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kC4nl2cFcOGdE/QGi5Jzw1XVWtzaQwO80xOZkzk93us=;
 b=emvbb4BBwubUMWl58QiQ+Baw9fj+1S+b7cQDKcSSbl498/anil8fSgoc7AghIrmqdo
 YbsUwHgFg5vg/u30P6FTK4vjgZK8OaWz6uwd1u3Rc6NAr4BBtZVs6i6+TH6Dp3sZpJFd
 h91+AzY6kbEkKTVo0/3va3FnSqakAf3+GxJjh8KV6qltAhyCd0/1TjJwakST/0l6PJ37
 +t20i7nGK0AyMPWGVGdfCll4CRDkhj2R9oDsJRjVzGCbfXP9819tYNr9B2E415rmloXU
 6XeH+YLysGSZFgqs0Fzf55vQFTrFL347Bn07ktXN/x00fdY6WrJsxm64prw7ZQVmKvEE
 4Txw==
X-Gm-Message-State: AOJu0YwN2XS9zMZToHH6tboYsNIMJPSReZXNAS0wCHd+TuJBCn/DpywP
 /RzqVGSSwOxYrn4iO/+74Tz2g0S2r2dQEeXzJuBLuxP4jdRwQqXf7Js/X4YDitbVyvc=
X-Gm-Gg: ASbGncv9oI89Z5EvxdWa25GH+V/nEzPe2yfIJvhX7bRsROosOmxTDcLA9FtrZVaa+OW
 n9VuYNYJY2jBRTDHpDyvDm5D6JePe/9HC4v9xTpK3373FVJcxnvL5wOQJdYBRelZtGKvO3+n1Tj
 +FmQ8/b05vmf8EO+yXs/Zisp8a9N9n5m3BZfLm6umTM4jp4PMEQHtDShucVMNQynlMWxPxGdXc9
 eKW+GY7ZUXpDcPxBUnjYFyAr08R9wk5NnOYRmI42oFM+55qUPHAVgK2ztwH5gAadPMbGxz+lEe4
 a38WizSIFeJmTmopvvflw5BPlqbInWdclWakdkfFdpPz9r9XWBZ0PRbB5w8g4NHYKpMgVs0a6eC
 90wowiBwtWGKVAQnzylIxO5rm9w42W34mXuT/zJlzfJ3igb3wRLyOKdVUb7+f321mzzf03JwS2D
 HV0LIzU2eBOiXbM2cB0eJLXZL60XzyGOrCkMnkbtroT3vSFJmbam1QiWQAqDMlgQt9JhuhB34v7
 LU=
X-Google-Smtp-Source: AGHT+IGFWGf11ONXPRwnYuofKwTAFUZVjCV2EJ3tOEPwEZahuPbMBJSi6vJAIEXAt7j+mcYhdQeuWw==
X-Received: by 2002:a05:6808:14c8:b0:44f:e49e:8e4b with SMTP id
 5614622812f47-4536e3f5e69mr5292222b6e.20.1764941207788; 
 Fri, 05 Dec 2025 05:26:47 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453801528fdsm2180293b6e.18.2025.12.05.05.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 05:26:47 -0800 (PST)
Message-ID: <48fa3266-b17f-4c7c-9bbf-98703ad087ee@linaro.org>
Date: Fri, 5 Dec 2025 07:26:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251202162645.182909-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251202162645.182909-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/2/25 10:26, Kevin Wolf wrote:
> The following changes since commit 66ec38b6fa593afcc26a2dfb5d1f9871dd15f527:
> 
>    Merge tag 'pull-target-arm-20251201' ofhttps://gitlab.com/pm215/qemu into staging (2025-12-01 12:08:52 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to d94ea1a10bdfb99c5822e64a5b6ee3e352719326:
> 
>    file-posix: Handle suspended dm-multipath better for SG_IO (2025-12-02 16:51:47 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - SCSI passthrough: Fix errors on temporarily suspended dm-multipath


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

