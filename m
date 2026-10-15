Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2019CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEU9-0004Hc-Ir; Thu, 15 Oct 2026 01:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHETs-00043L-A4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:23 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHETp-0003Lw-Pt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:19 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6dd059478dcso3244301eaf.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792043896; x=1792648696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MIm3Mt7yyoFBmBnlFcIwJHiEyrqLsJMmP39NTugDipE=;
 b=x3EQOLUKSjwx5HavvhUea9jS5OC+yYNUhxRX8co4AmTWDH9dYMLLI+tJJoGcA/3fY5
 XtMQHHkcGSP3x6ATqJ3kEmYD30GQF6szAcYXeToJJlvAUNol41zUSYiFtbPKjf8sHbdc
 wHU4o4uROQp6F626ejXty5VrNPmDq8xel4iBWoMt7j/RDtFR0RLwTfnXdP1XjxCeJzJA
 oJyjU5oazVys8/WwPBUGaexCSvjBfTOKwMYmNBIsq0y2bRbfYEZBHhUrxIy/fnc5UGhn
 jmglAv3icW7cH6BtitBzXerN6ip3mmzY7+CRKEJv9W0eYQ8LdgDEuEJ8pk0RTN4rSfnQ
 Rk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792043896; x=1792648696;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MIm3Mt7yyoFBmBnlFcIwJHiEyrqLsJMmP39NTugDipE=;
 b=hdQA6NY7xzo74tSW1YxdKYeChTY7NylHiKQ186pxZ532Zi4CEhOyKHBXGcd3gOa3Je
 67JsmSClSs6Ov/U80qjm3Ng1GcVEyqwwNP0s2QQX7S4cTiZatLnfLwtMFtgLnVEWwaUW
 dN9Ju8YONO/xEUTUYjDIzc+B2wdilpSOsr7QKpng/Waadi9jpe9H+zFnhNRWJtXgkmsP
 maS4T1dc1ldFdIlgAhVB4Xsh36AqDqSYWlKzpaJk0THTfy6iA8bTbgmUzMYUnHljRFKl
 WKbiQnLMfRu9fKXJgiXqWfTepChKUwefwTOy5L5rdn7TGnlz7FVchHFRE4Cnexej4480
 pv7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyDfGkKqd/EQ891NB1bWg2ofmHySlgsIcfkaoALLVVRhozPpadv46AgZH004kMWXbXpdlz5L92/guT@nongnu.org
X-Gm-Message-State: AFq9FYKLGm+Yt9x16aBK4zY5546/KCO2jQK+13jAzMYCSbow4ckZmQNG
 8EwtzjIZbM9Ts8fRsSZaNwecL/uVy9ISsarc1itbBuV14/96HUvVPqNdcAMDaRcxR/1Lk28O2gm
 f+oFz6bA=
X-Gm-Gg: AYBFou3G+qZTQvnEMCqnBAz6hSNLBvdDpsXhan15xX5N0RIUQChup4jeX2TGFUv3ZpF
 9ONzAjPUJWlH/ZcGJuUN+vWL8WM//h65g/u4SVYI/PqSj5xFMbtQoGkco9N+UIPb3wPe17dCj3E
 Ko0Mo3/ATq/dVsHSjxEZ4z0e01egmeVIqGu9+DGoPoQsWRI796jBCv0fkSzOLFCzU4bZQSuB8aQ
 Hgv3gMnEFU7sY+Uu3fZtmMR5iX1q738ObO2DnOcH8kF76F9TMKvqhmOAGIPW7VVS76D0EkCyeb+
 CT3pP3eCeaDp3+BDdfGjnufomndPeTrjcr17g46El3AeTUa3DF2UKqBabkO+CwJcWXSLaBJKz6Y
 L0sM+9LUU/KcYybrBE2ZemFQeodHEFxHxKy/Tdg+WFpKE2VLDBfzSopUqipypiKO8rabUYERwKB
 uEXVI4sVf8fRnGqHCdUtEg2hr54L0hGar1Uh8PRXNUwSUQ6mJ30+WXXlE2XYzprpZG95l6YZTd7
 KYib7XOCXS56yttieNtnrKDGCB+mXv99Af1HA==
X-Received: by 2002:a05:6820:f029:b0:6f7:3c09:c705 with SMTP id
 006d021491bc7-6f73c09cbfamr9360872eaf.55.1792043896481; 
 Wed, 14 Oct 2026 22:58:16 -0700 (PDT)
Received: from [10.86.151.227] ([172.59.192.11])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f6ed64de8asm8702062eaf.5.2026.10.14.22.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 22:58:15 -0700 (PDT)
Message-ID: <0db12754-5e69-426e-8762-f6587f5ae64b@linaro.org>
Date: Thu, 15 Oct 2026 07:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] tcg tests 20261013
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261013191948.3546-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013191948.3546-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

On 10/13/26 21:19, Pierrick Bouvier wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261013
> 
> for you to fetch changes up to 850c46a5fb2187edd741b3b1ae18e6a8ef7571df:
> 
>    tests/tcg/riscv64: remove forgotten Makefile.softmmu-target (2026-10-13 19:19:24 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] tests/tcg/riscv64: remove forgotten Makefile.softmmu-target (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261010225351.79098-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

