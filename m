Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52ABE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLki2-0000kZ-Kr; Thu, 12 Dec 2024 10:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkhu-0000gt-Rh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:02:26 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkhr-0008U7-H4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:02:26 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-29fb532b668so180223fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734015741; x=1734620541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jfQ3WehMwq9RffNsZTaStJRd5grSK0R66jWt2VTryHw=;
 b=oCW1M2Mt24x9/eH9icSTgU91ZsTZYPTLsrsFHr/imBDbal+QwbN/bwGpdrai8bvque
 38UVI3EjNvVFJGYTrIfrUeCaLUpx/sSKU9GRrtz+R2lBq1YEGs21E2MAKW8wlQjd+5ji
 HtnIrH+WShrxt0IJEC93a73cVWiXp55jqXPMmnH5drVJF4Rk5ZU9ROQxDuYQY9gMoRiI
 ggcs7gXLF5u+Y1onCtNjktzsguzp6z8I93mv+7kDoa5rozxSzT8A+XFvkg03fCrIMXs6
 /2Z0KEDZ0rxqzXkk9ROohRsZ3Di7jcrCB4l/DbpLhpXz+gSmcXF60rGSznSGdw4v3T3m
 h7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734015741; x=1734620541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfQ3WehMwq9RffNsZTaStJRd5grSK0R66jWt2VTryHw=;
 b=rAmn1I+/YpfZ/FTM7tPD4t3+GgcPCYNFIKCKD6psRReWSpleVkTt17ymmaoEkm5Hvh
 AmLXJL4Ghnft53KEFlnoruRx+2d54OQkCRAiM4VMU2NFpLbUmv132Mb6n7pYXzBCjcex
 U3QqqCk+bV5n2zzoqUcYJsvI5tKUXt5w42IZXKFakIIi8V6QGW1fN0GEUi4mipqrELgr
 E/Xr59WdMGtq+ly0TwxhFXAwLVCQWTgX4j3HuD8GOhaYC0T6ORsnuz6awJjJigI5ZuYT
 EtQNjf04Eone45R1z6d0PmZDj1M7x935ONzXWFIwHn3/4eDCtdShz5XW8ynbj/N/Gsgh
 G9pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjnhqrrLmUIX8zw1TvIG9nS5EyNuC+wxvLP3fzYjvM2miQ2RoZbsEWp1a35tvVazlki0Y+81oyUj1M@nongnu.org
X-Gm-Message-State: AOJu0YwKXcF86yg3qgscqNEDZ9Vqg8f5pGIasEt5q6SpoQjoJgkF7W1w
 HvVs+00XRM58qCurzi/Ijnx/URBaRnc6+QNGMz3c8Uf1wS7EnNN68StrD+aloTcCmdyHPoHtXGG
 tk/nzfa/s
X-Gm-Gg: ASbGncuz3SvOFbifyKRo3eWKdQ9MWbaAiUi8VuNuUWC0R3eRe8EcGVLdz0gQxkdwtZA
 R7hIT/00PbilVZEKGgZDpT2D/6eXu4AdQRIZ4Mf2qnIB6uOoYK6L9h9XE8sBAMZKL7zHTwWnpyJ
 6sfvFGyiqkQRstQejdkrNDqH3VGaVcyoc15le4Om0F/X0nR5FG5jMu3taB7VIKeLzs+/dSABkHo
 v2kaqZz8vFG5Rh/ySWZpsyzBt2KmKz5DLIFi0JSPKqF8ZVPVAs/MDP+sqrQpKXdwgolGQg3tFBy
 TrAc1gnc3uVjioFU3nPzaCUSt5Xh7g/1S1I=
X-Google-Smtp-Source: AGHT+IElFZISBVogQDhivB9Hq9PwPpgM3dqyXylgwtTlHkTXerGms6xEr6ZnYH+lOI7DxACOefcwBg==
X-Received: by 2002:a05:6870:c084:b0:29e:4cb1:3795 with SMTP id
 586e51a60fabf-2a012c0c57emr4010971fac.20.1734015741156; 
 Thu, 12 Dec 2024 07:02:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fab34bdcdsm3111581fac.33.2024.12.12.07.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:02:20 -0800 (PST)
Message-ID: <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
Date: Thu, 12 Dec 2024 09:02:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using
 .h.inc suffix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212141018.59428-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented in the Coding Style:
> 
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
> 
> Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.

But these are not templates, nor included multiple times, so...
I don't get it.


r~

