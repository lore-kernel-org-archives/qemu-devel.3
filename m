Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEA0CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeFY-0003g7-GG; Tue, 13 Oct 2026 11:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGeEu-0003e5-Km
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:16:44 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGeEs-0000zI-7p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:16:28 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-530e75d1ba1so31487791cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791904585; x=1792509385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c4x78hifVQsi6fGRW1vcYagoyKKaaAq6828zAa43ju4=;
 b=gXbBMy4Pp2SPWVJiQIlkQSeXIte58pdqVL7Ds4FbnmyYoX4VRx9Iixtg7GQykDD4WU
 5ENitkmnUgl4bNI/40IwmLrJ2cTVGsSqD3o9X9GotGo+kKNbNJbztIbwl9OZ/vEabN4f
 qLsbZAE/LqKCmVzpzeTnG7kMh6ZMjESDnGCUmvcuuXiNrX0iR+xyQyjroA2tjMnyo0Wm
 ABkM6LGwM/kt8jR8hfm0Hu4gxZ4sgfjGH/Bpm5lf/jGvC5iI6LfAd+QxuhlcqbniotdJ
 8npMkRMOq4GGXCA1Meg0U3FGuZ93q3LIASFdhn2vtuKX4Iyb16m98NGOaeeKQ7chmEMc
 s7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904585; x=1792509385;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c4x78hifVQsi6fGRW1vcYagoyKKaaAq6828zAa43ju4=;
 b=ACfsAOLOndT1/daHjZWYtZf7fc2ZDKw/wPOD3GvHe5jFrQt+HYSmo5SCl4VtpAxCwR
 Bvdp3tV7OuuD+y9NCmOr6F+6OoOmXRRxZdLOOunjDyygS+Jgc2e32LkYAKjZk0Uvc+3L
 Lqg+eiFQkBsFb1HCc5y/CjMBLawDwYY2Gip55PkbG0e01Tc6VsyphReIrMciTtAOZFmi
 9+aMBwMOC2zsdGt76RwfJtA1Iorwy/oxCxLvRlt+F4QBpC3ZjFDCt6kFIopYdpluf3Uu
 bONb3YabmCjvM1cCPxlEsspQ6y3xtvqoROVvFoodoChY10HqhiCMdePrJoxvxyG8s2zM
 LdRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzha1TMnDvVGgz/M4D900SXtaKHKY1SGk0VKP5g5h728vdUKrMacnqgZ5AI9NpQsM7KOU+eSZUTvBR2@nongnu.org
X-Gm-Message-State: AFq9FYJceaRsq1v5YuecPdYcCT7y8Bx87bAP0fMEHmQB773/BJvLSy66
 7ceOddn6MV6++lwWcDx2dItp+oXDil+oJ0EoLYv1mVkIgtvEujdqgHe06PBePvzlcIo=
X-Gm-Gg: AYBFou3CvRmQYPKgpvKtvkXfIzZoKG2JEYIW4K1Hy+6uyQfv0cOQ3NXgrcUbw9GsrxP
 vNnh4Y8tcZUR/ZjLqEZRzgx+TwFSuhcZXX9zaPcDIvQfbpuH/+uz37t/yngBhlktxttrZorh3AJ
 nmR3cMkYuure42Xh+9XSIc0bjLGvlbJSs1DuFixpcmBXdCuigRicIAuQlJB875zU0wMb7CqGoNN
 7vOe+UHW/bDjBFgj689Yjpg6+4oL7RFcaL0klEJ/Z5weLys8zM8WEe0foTV3jIMlb/GXnyXICA/
 +Ybh1H173d+Dm0aOjoV5OjKx2OpVw0a3vbDvJeYq2mefu1qAkreAOW9EJ1JXaaFI+K5HlEL7lp2
 vETvb9ngoROOc4iKFx388qVOa8ObMUrg8ht2QJKDfYnvOLA41Td6HV6tSFUMD9+LoxYFc3UICkD
 d5TabBu/04x6cLZ75d1axe7pkfFHWM52k7W5dLvbx3HEm6TrkDTLZSig9qTzd2uy22FR4iGvCqZ
 8Mlve2c2eRGP+lbytDO/qk2+MDxH8gIJ8kLd2k=
X-Received: by 2002:a05:622a:8c8:b0:535:8453:73a0 with SMTP id
 d75a77b69052e-5359fb54d1amr212348011cf.47.1791904584322; 
 Tue, 13 Oct 2026 08:16:24 -0700 (PDT)
Received: from [10.86.151.227] ([172.56.179.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97b383dasm27423236d6.8.2026.10.13.08.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 08:16:22 -0700 (PDT)
Message-ID: <3ef62746-33e7-441f-95be-19836f63cb98@linaro.org>
Date: Tue, 13 Oct 2026 17:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Introduce tcg_type_bits() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260928113938.3157-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260928113938.3157-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

On 9/28/26 13:39, Philippe Mathieu-Daudé wrote:
> Add a helper function for computing the width (in bits)
> of a type. Use when appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/tcg/tcg.h | 11 +++++++++++
>   tcg/optimize.c    |  4 ++--
>   tcg/tcg.c         |  4 ++--
>   3 files changed, 15 insertions(+), 4 deletions(-)

Thanks, queued to tcg-next.

r~


