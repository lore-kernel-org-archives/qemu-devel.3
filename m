Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F570C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h5F-0007YA-Sx; Fri, 18 Sep 2026 18:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7h5E-0007Xk-8l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:29:28 -0400
Received: from mail-pj2-x16.google.com ([2607:f8b0:4864:39::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7h5C-00004s-IE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:29:27 -0400
Received: by mail-pj2-x16.google.com with SMTP id
 d9443c01a7336-2db22383fe8so8463445ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789770565; x=1790375365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjovbqUG8pDb3JYn/0DqlIpADH3BiP3dQlfOoMfeXEU=;
 b=ocl1kzvOf8K4TFFMBzeh3m2vkB0umkI6IbzawOI+S8CrOxtYJamFqnxsl3pRVOFmpG
 Ppr0eU8sfMqfEwSIyHyPXwx7+TS/zqOLXfb0e1znsBET2HknbQ3OGRTBkGsOo6JWdm3o
 0NeH3VD+Wb0cm7nFgwzpu1lBErSqIycetQYpebB7ymycAh6vWz1qMyNHcy1xtdAUh2bm
 1BeZS/9V+vnIhItWe1pWmyOfwvOpRNUN/atUODH0zj+x97Tb1zB1aRXqesLICzuFlt5d
 Uf/BQQ4VF7Y/gt0Ul6zApJdUjaVDK4qymzLTt9CZ5ZfcyyTk7mxRH74YQ/o78HBYhmVS
 BAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789770565; x=1790375365;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjovbqUG8pDb3JYn/0DqlIpADH3BiP3dQlfOoMfeXEU=;
 b=ZWK3gpayetJDa7qmd6Z32VAzPXf00jHCI/hGfchTGNsVLlu5uOmkpD6UTNFiO7ETVQ
 l47gJR9djqwRogiVC1/+bFBKg9P6O1Ex2Y2UccblZNhnLpnz+zZkEl7LLUXQqAqKn6IX
 CEWrIN8Kg1iVmS/bnfYH2K5HvlZSl1ogfLravAJnr66WuUEVZYsaBlv2003JqNyO0r1X
 iafKRvMe52CTm9udHB96JeBWjq5/CUEAPScI7P+3Yz5gvHYUVK/vkqySXp3Vf0/4QVXQ
 Y1rdNfdyYAflaKkEKKHeTXClGny1fZJK1SfzZUpTtikHXiU5Uk3DgltnkoyxYZytmaY/
 Ysmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByRiziu/Q3AyZWrAVVlf2nNhkloPz8be6/txKxqvr8CwazfwxmPtks4STOlIYGLWZDgBfTm74hCS3zW@nongnu.org
X-Gm-Message-State: AFuF++lwu76n6we5g0nIRYljvBna8XcYDt+woHUIKQ7ZoWjDOvBmiixO
 VwTKfPYen5zjXdoPmr0+PnDMpg3ImMB+FqRHpu9lhciEskYjpasQHTyBBYFyqCdJIvg=
X-Gm-Gg: AYBFou0UNCN/Sdlrm1ZFZL/bl5mJUQscuhgnpO7SAtSTsEQNFM0wU9aj3d2nHjQqA52
 zuBcsZ0oDYr++MfSMPb+HlHTmYME2xwKAO55vBmJ/EyXRZ5XJZZMNSUkYrwtAuagmLfIdebgaPu
 qFTta+4/VwHprvkS6cTQzEF6DBk1QfpYd5RxpLYgWfEutDhdbe/X2GumPpcnlDgiKvMcNDhHg+a
 a6ZlcYNiMOjrdOyHIhqOU0TZZkmaDetVRT95YsGVMFlcBrw1O93/NX/s5+DHGg8Lbwwbz5Ti8WJ
 9zJlTwRelTWhpeiPiaphsATEtP4bCJ9Ywa4G6spfYC0SigTYX5ggnksd43LCecxCKAMrePA6t2b
 W0fs8RMQ2zCl2tjNCJVanabCuVpFstQ02zlki3qpBWjJSLkChw920j0xKcGjy2l0BIaDRaqzFHu
 SIYxLnaJmVaaVBVjOgBwHzo1lA5pz7QgjxBJdr9a/jm9PqRc7IyY6yymjjPTYamsm/czsGTp4KL
 ws6q92Lxt2oSADEjMqh7EzUoPl/yuQhCQ4gCQ81yerrUbQOtUB6g5qhTRE0Rw==
X-Received: by 2002:a17:903:1a0b:b0:2dd:7549:39d0 with SMTP id
 d9443c01a7336-2ddb1b86d77mr65676925ad.18.1789770564614; 
 Fri, 18 Sep 2026 15:29:24 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:fc68:7352:7265:5984?
 ([2603:800c:7900:ed00:fc68:7352:7265:5984])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a6e5sm1457181eec.7.2026.09.18.15.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 15:29:24 -0700 (PDT)
Message-ID: <83bac8eb-9b82-4af7-ba99-d517fe84cd7b@linaro.org>
Date: Fri, 18 Sep 2026 12:29:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: reintroduce build-tcg target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::16;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x16.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/26 10:27, Pierrick Bouvier wrote:
> The refactoring introduced a new target named tcg-tests to build all
> ... tcg tests.
> Previously, this target was named build-tcg. Keep both for compatiblity
> sake if people were relying on it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index a5e0462732d..a571b939b89 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -522,4 +522,6 @@ endforeach
>   if exe_targets.length() > 0
>     # finally create a top level target to rebuild all tests
>     alias_target('tcg-tests', exe_targets)
> +  # before, this target was called build-tcg. Keep it for compatibility sake.
> +  alias_target('build-tcg', exe_targets)
>   endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

