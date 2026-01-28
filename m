Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ABCD35687
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 07:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0DA-0004DU-Vp; Wed, 28 Jan 2026 02:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0D9-0004Bz-1y
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 02:43:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0D6-0005Nj-Lb
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 02:43:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso13780845e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 23:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769586210; x=1770191010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=93oA18CGIBfMgKWNXx+7cw/sKNI9taxZw45WhVVxPIo=;
 b=CLSRugKu1Jy4EY8kTNncEJPce5v0vKqzCoVLLV/AfHr6FFTa76m4eF8LEvwJ6I7aYH
 s/2iE6kFi2BuZrSeFbjBBBGlQKXLtMMi8RxXcCwvzDAMQ9Lavxk2FCSAKTKqoMocjm66
 aDQCTWTgpzSwOh8E7lmwB/WdaJ69WbRusWgWm2gIyW0z7XrJdnyZgP4axX94xz93gZ6V
 ur1i1M3PJJxjA/c6AF+zOrZyp2v7K+ReIjxpy4BmJlNJgBuSE3ikDlMyYFogUgYdckHZ
 HulWVHgCz4JBX/8LmAgnhmawzdYxJmRxAuOmXUHQDlKmbboN1tU/LkXahLNjsjBl/Ur2
 Zh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769586210; x=1770191010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=93oA18CGIBfMgKWNXx+7cw/sKNI9taxZw45WhVVxPIo=;
 b=IP1L7M0L4hmJT/o8FOMiJ+zJqyclTkVX8IceDxIqyf0E10I1YnjiANgMzOsrV1opdZ
 nFyrVSHBQ3ndAuplMgq8bfZP28kC6pviPuPB9o7LZ2lw6VTO335WeRDDkjh9s3fL3VFa
 Gr2bJ6VncEM/dRK+ixFcT0Wsk1Log6LoMtQq0bA9/smXQk4A7tausbgEWMeKjnbEXoR2
 7q7iGAouY8YPkIjBlPFzV3diddgyBQ1TIToKpyfpDya/22Roy0D/Irwug8qxDGf6TZl+
 6kCbtrlHSYLX1STUVW9GrN/Mfe11j8yksmSSqR/VEjD6Tr7j1r44+ZdLbc8Sr7/U7s74
 EnbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlx1xXmp6Ebjry+VT9xbdn5R+XI8yqG3gja/ZZyuGOwsPtqRrH21ccBhAm8MBewU5loYwF2CVFIfDY@nongnu.org
X-Gm-Message-State: AOJu0YzF2ljn2gK4gKwq0XPCKyN0prKEyFkWvS/8c/yVVAPxgZkEx1We
 1FlobpV7ePdapfU2jUy7f/v26RGkjCy6g47ASbnz8ecmYyMlbRZgHLPqT3ORKCyso5Q=
X-Gm-Gg: AZuq6aJ4iABTtds6d/MHd/T8Cybc0pCdXV8Rq7vUV8YT1vr36WysOUW4WWur6hDw+aR
 qG31qNvEplOo85K+4p1zuDN2WV1p+jX/HvsZ6WPNlG80AeSZPXMQIocT7eZGgg0rNu6LdVpCGMm
 viCXpSWOk4eJuKjMS/+EZ+HrMlOqTFWj1qqpDJ1UN6xcmUlNCeh+tj592+CmQ5A0760DzuVDkFN
 OEA++L7JnZVo5qq1bEsllRQekyIHQhO543uobFrn0RsbYjX77GeLYy9MyDBYcsIyBX1bQadyEpB
 o887ewN9OxZiAUpc0DG/9y7tlKYEm+FV9Kw9UIBXWK8UM/8VTRAPA+5EZdbkGYSFXp9pvTy3VAl
 s5WpSswZtTgt/wr9Ov29MwOLzpCRGFfCmv5TaRYKjG+WfEChLFiQNqVGqdI8PoM1Hpyma5Mp+VA
 +7efAg3F/h/KzQ7mEB9U/Bug4=
X-Received: by 2002:a05:600c:4e12:b0:480:6873:b2f6 with SMTP id
 5b1f17b1804b1-48069c557d0mr52539885e9.20.1769586210574; 
 Tue, 27 Jan 2026 23:43:30 -0800 (PST)
Received: from [192.168.69.210] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d9800e7sm2930705e9.2.2026.01.27.23.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 23:43:30 -0800 (PST)
Message-ID: <6e0ae94c-212b-4267-8f78-56353fab3a27@linaro.org>
Date: Wed, 28 Jan 2026 08:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 3160104094@zju.edu.cn
References: <20260128010715.347776-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260128010715.347776-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 28/1/26 02:07, Richard Henderson wrote:

> Richard Henderson (2):
>    accel/tcg: Don't pass NULL to get_page_addr_code_hostp
>    accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


