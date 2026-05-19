Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E91CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSw3-0002i4-Ds; Tue, 19 May 2026 18:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSw2-0002hg-8k
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:29:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSw0-00045P-OE
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:29:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so27231645ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779229747; x=1779834547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KOwTmykjgbRBiAqY4LXbkPW9vllVBGm1fARJ1R6QkwI=;
 b=uTcjqY55up2UxfqLnY+8/B/iknWcD5itdvsQObRZe82fZZAP5wZljCZIj760u8ZnAh
 Xr8darcTG0XZeV4eeCV1gPg5zDyNR8+N5e+djk4lFaHWVFBhGBaao/PlIJAXxGK66mlf
 A6j/SR5HdZPNPmHnI6GhX5bn04wvtV3UctTokIk/vRcz1dXbj2IbOm4L+Syqjif2DdFI
 HAdVFY9UTrMKHeEXshAeki6IQjkObmLi3tuewsEaqYp9e72/pljAN5eZ77QV2WKz8O3n
 +5btN54HGVO5G/dQAYoGlMfYKDwZc3u1Y3OnMgQHkHKw84Km6acZz/V+v1IdIpP4Cwxv
 FBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229747; x=1779834547;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOwTmykjgbRBiAqY4LXbkPW9vllVBGm1fARJ1R6QkwI=;
 b=m/QZkNXZmsueKt/2aM+hlG7fPbH9MB0hYOvOIi91j71HA3v8BWcHWVouJG+l1KlUG4
 VY1uaIryNus3O5Zjo8+OB1nBJa8eShJwmlkxPgmbdIk+4P9o1w86x/IDOnSukmXdfsDi
 vRo0c8McKnSz6U2rmn6uTE5IqQQLu3x7LoWCpB0sTbnUwPpouIJOJFm3AOhohCgL03pT
 0mAEyHqzdbtfcsYE0JXnAdCWAsOzkeulHbOBeCCyivroUu6C1aP4GfPQgPzM1YZIMl3h
 zvckLCu9O6A1iNomIB3mp+Nd91XDzjCR7XXIhoceh8SU58qHgL3V7mj0C2HnzPyOLpTE
 WGHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dL+bwtb/eEc2JOQn1soDgLNQ/lZGuvLbtIns+xRHM3d+kl4GKZp/2F6S254s500udVx6/bxhCrBoH@nongnu.org
X-Gm-Message-State: AOJu0YzYzwnVzKoi/k5gA4OBsZrSPminpXPgW9fgM69er9ihGuiMPQ+n
 1tkGLDRzKHYvObEqsrVoyDrH+uEeBnhEVwVsGGWHIusTNawRLS/JNnK9851lubZ+4mY=
X-Gm-Gg: Acq92OFprSbjEt2dZAzR55unpQ18fHJY5C51cYUmZJR5pWn5Zt++m/oiTvpH3I20xRn
 4Cb8Gm+bbWYzOjMP83Q8DWsMwYiTCt8YHBtJIKBaJzdmDEthncINAUfxAlIMGd8CdD4NUHk6ksH
 Z5y0dPCwyGWKU2Hfcy+rruRJoGOUyY3nRuhtu6eeUWOOUlXUdZ/WEgaa1JRvJ1y/EfwXAq9MTh8
 EpzqTIYqLoclOrWORXUGpFxM/bHC8KXwmPxhyKbPZTSUVJnF0vedRsspVR8m3xehxiFeTgzDoSs
 mGgYXs43MzzA5HnyV61IsPGPpNclvrWKLqQj+1p21WOC55RJzAqp+BVbp7xflSsfBYkIC4N4Fzh
 KQBX6I/qVC0dcgXp4A58m3tkh5MBKK/PJr7+XgbWRNdm5MzC64Rb3VmCG3Q75L/8lvcSVuU6Ksl
 h8NeW0tcWFNqBQoweJMtavco2pQtzJtP8+KGLr
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id
 d9443c01a7336-2bd7e86c6b1mr167455105ad.2.1779229747010; 
 Tue, 19 May 2026 15:29:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600b4sm198859755ad.28.2026.05.19.15.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:29:06 -0700 (PDT)
Message-ID: <fae9b59b-4806-4239-894b-f800dbdd7df1@linaro.org>
Date: Tue, 19 May 2026 15:29:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] MAINTAINERS: Fix tcg/s390x/ path
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519171240.97420-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/19/26 10:12, Philippe Mathieu-Daudé wrote:
> This folder was renamed in commit 3704993f545 ("tcg/s390x: Rename
> from tcg/s390").
> 
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7749fe7f9bc..92b875ddfc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4180,7 +4180,7 @@ F: disas/riscv*.[ch]
>   S390 TCG target
>   M: Richard Henderson <richard.henderson@linaro.org>
>   S: Maintained
> -F: tcg/s390/
> +F: tcg/s390x/
>   L: qemu-s390x@nongnu.org
>   
>   SPARC TCG target


