Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF15C3ABAA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 19:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBIel-000850-0A; Sat, 03 May 2025 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBIei-00084e-4y
 for qemu-devel@nongnu.org; Sat, 03 May 2025 15:36:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBIef-00076g-5F
 for qemu-devel@nongnu.org; Sat, 03 May 2025 15:36:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225477548e1so33886655ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746300967; x=1746905767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46poKVfyXcj1Zy6VBI+f3TapzLJdZeetv6cFKL1lOFs=;
 b=BxauF/Sbj0irmJxPgrqPU7GqIUe4+GTH59odNxXYYx4ORwExfh9na9Ih1Cm+d9tknv
 cg2lV1lCUQlMswLk4SM2ljjOkL17YO9ic9lhlyZwlvusbuL8R1tr1gnSm6sQa0u0bB5S
 0Z0iNC/NgWJ/WsU+KWKqRxBekAJ4nQxqj9ZABLudWY2zi5GUqY0iRgMLa1+tqiRGIM+a
 o5vSdVyyTrkAbrQu7ngi9Dde9D3b8NMsxJ/+OWNYriWV/9abRwj5qVGNEbxD+K5ioE/I
 g/mNW1QYf3YmnBDpiA672kH6rt6LgrJ1UV0WYwLNw8Oweubl9VpVcKMNC5/q3f7u+RzS
 Tyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746300967; x=1746905767;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46poKVfyXcj1Zy6VBI+f3TapzLJdZeetv6cFKL1lOFs=;
 b=hLxYDJ6jZXAaGmkkkHfut8LJoxBatIdwGVoI8i0ZxQV01Va9KwAGrHOIQmqfCXsEZ7
 mJcWYMzlSVG9Ar5cEjXyg8CTGe0+UUTp0OAYMwt9A5tH3dNTxb5PeIMv6R7F8/Jnefug
 GPNohG5qOIFgHtCfXIVftvhnJYgtwS5U9acUQGkxcc+320ei3hNCU63OMQAmgrc3qTKY
 1WmTitA6PVCcVYL7oswgDKvoAICTz4IBrPb9kpRTTjbugcDy9cUEfq+BZcSkAa3rU41W
 xH5e7YKtENhYGkidlVkn+DeXUfyTOQD+GKO+NefVv82cThGVtGtIYntyC4m3gEFI04LF
 Atdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg5mEWfElPR4kSJIuKp+MUqpPY8Rel2cq2o1sJ0xorYnYS3CdZJ7RIsetvzKRvxAhtY4UCnkIFVg+6@nongnu.org
X-Gm-Message-State: AOJu0Yy4auhwlnhutF8h1yjv5fvs9TniV2YUBx27ZskLhlgBM13TeSDa
 JvS6Kmo+7y83Y3QzLYZdi/N4DS/+cN9vylqOpnqM8jma6MKWbjd93UCrivBAfO8=
X-Gm-Gg: ASbGnctGNVw6SGHffNGTIV5VH8G5R42aUu4/3W2fLvBKSTBXzaC4Oz2ch3tfeovqshF
 TLQMjctvb9XdA0V+FueILEqM1RqyEKkCYJogCqd2IbgdQyrI1PPCOORYnIIXfkk5K363SGo5aGa
 fhWawKvkDKCPe2IM4tZCpjB0dU/A7IwQ09jdsH3mX96igGwczUo7Vz8zLU/Hgug0FJbmq0uvWCQ
 VF+wv//BG5xafjISqDS+pp1WsJpoWcmR6ir+ixqaKBbeTO3qvqZtmVxya0s2PWn/esvw7Pj7skB
 DRNwgGNWhRqWedU9B+mjnfv/OfvIs+WEEe7leAKJBPAf9s7/DGbuHA==
X-Google-Smtp-Source: AGHT+IG7YClw5tK9D0RNIsYZNqILBlESABp1fCfoFx4l1RRyEom4+a5C2VRjhcLwSyIOuIE/XQ7rqQ==
X-Received: by 2002:a17:903:2ac3:b0:223:3b76:4e22 with SMTP id
 d9443c01a7336-22e1e8d33f1mr25488695ad.6.1746300966896; 
 Sat, 03 May 2025 12:36:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522f987sm27346875ad.232.2025.05.03.12.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 12:36:06 -0700 (PDT)
Message-ID: <f35f97fa-8fb5-400f-b126-10055a0bffe4@linaro.org>
Date: Sat, 3 May 2025 12:36:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Don't define duplicate label in
 qemu-block-drivers.rst.inc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dario Faggioli <dfaggioli@suse.com>
References: <20250501093126.716667-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250501093126.716667-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/1/25 2:31 AM, Peter Maydell wrote:
> Sphinx requires that labels within documents are unique across the
> whole manual.  This is because the "create a hyperlink" directive
> specifies only the name of the label, not a filename+label.  Some
> Sphinx versions will warn about duplicate labels, but even if there
> is no warning there is still an ambiguity and no guarantee that the
> hyperlink will be created to the right target.
> 
> For QEMU this is awkward, because we have various .rst.inc fragments
> which we include into multiple .rst files.  If you define a label in
> the .rst.inc file then it will be a duplicate label.  We have mostly
> worked around this by not putting labels into those .rst.inc files,
> or by adding "insert a label" functionality into the hxtool extension
> (see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
> argument to SRST directive").
> 
> Unfortunately in commit 7f6314427e78 ("docs/devel: add a codebase
> section") we accidentally added a duplicate label, because not all
> Sphinx versions warn about the mistake.
> 
> In this case the link was only from the developer docs codebase
> summary, so as the simplest fix for the stable branch, we drop
> the link entirely.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label argument to SRST directive"
> Reported-by: Dario Faggioli <dfaggioli@suse.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have a proposal for how we could permit this link:
>   https://patchew.org/QEMU/20250429163212.618953-1-peter.maydell@linaro.org/
> but since that adds a new Sphinx extension it's a little heavyweight
> to backport to the stable branches, so I thought I'd send out
> this "just drop the link" patch as our fix for stable.
> 
>   docs/devel/codebase.rst                | 2 +-
>   docs/system/qemu-block-drivers.rst.inc | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


