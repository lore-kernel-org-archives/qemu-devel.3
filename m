Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD02C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KiM-0002wA-KV; Tue, 22 Apr 2025 16:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KiK-0002vk-CX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:59:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KiI-0007c8-CM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:59:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so4722217b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355569; x=1745960369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNTAXzo2GvMFejsFAlEIqYnF1mOIwvwa9Mm8lszrIbs=;
 b=Xw7ohtVoL9ovYlloiri9PTjlwVJSWfadxG3WUgU2Ss3a+f/cFOEFv7mjfLgiCQXpLE
 GQ8bThYnEIdeHpa0FGMrobUZdGe9ErowG7d+gn3nEmikgjz6rGl+auKRWMeX/0jS3eT4
 k0rIM0XE3tf9IBcHBNhZ/sktjjZ9wA/RzmRxZMgOrtKHrd5nZyl/5FO8jtOz9y9ibhqh
 PiyCv+Lt/TPXXpsKOugWlv1cU2GfW+A8j0iy2HTJpdKXBf5ydE4dnU2BC2joqG8grd8s
 yqUNxwTBR5N3HcBcMzyvZwyT4rMyFkb4g+/yMNqWne7/Gaw9t0OISa51eoxQyRiwG13K
 OHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355569; x=1745960369;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNTAXzo2GvMFejsFAlEIqYnF1mOIwvwa9Mm8lszrIbs=;
 b=ZqehLsZFdzQgBNdISixREjA6BvwrcuBVORRcnUTX7AjG0cXtofUgWRBZJ2Z7Adazfk
 /8eJcQP/KmYUrYn4/V2v30cVm7D0uMRzU5zt2jh9I5tITijJTTiMDDpEyTC44CRrBiqD
 mB/ldIPEmhKrotNEJPyDwVuobvbgFdPzoF0rBy8bqUUMNSg6gGvmOcymIfZrUJdIemcj
 7o7jX2FVPj33hgZwidBcX2dhNkFQgOpwgaq06Sb1mqvLIlhpkxgkE3SHyJDJAfqax3uK
 OAcVsAUW0UAT6///rvkHb75a+zuzLGQS+SbBzhiNETyP41DTrlnhjF/o7mrxIhVxKTuT
 KlAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/It7ljepdaBHrFRnW4Dvd0gYRg1buSVJg8CTK+mu+9M6kVAKSx7hbnkcS7vopkywyhhnccwRfoFGu@nongnu.org
X-Gm-Message-State: AOJu0YxQqpF/XVJANFK7zCa0MJG5ZGY4dscbS3M305u0GvwAJxq7IDYT
 COa5IKkLaRM/D8dc3zrErL7DSfJ6SsSp4+fSjzu2b+pQEHm90HdlNRKzuhBTZls=
X-Gm-Gg: ASbGnctr0bxwby+OiWL7OVNMCTWjd/xN+OIV7qP2aDwpSL+5Lj0VZfmfIzf2c3uoE4I
 01+aazjnVWm5bokJfQvftMnx1ApIYbABf24CbqAgyLit+5xjpM5VWHMFy3SI+IeovO/yUgzNZ63
 2axI1MUkGfXd+zaOg3ApDc0ranhwSP3WapRolzkP6Ql3Llub/51bvZaMoBrsmWmMgt9QR2sgviQ
 a9l+xSOC12sayP7BVCtXw8aadfPDsEN79kMr39vnmAp2XV88SnkKLd2R7h0MCE0BvSuvefQrxnE
 r+ruPb+x97VjnQYqJ3G3mXKYXZ8GmDYilIjTldv3PUQmd9E+SpnlkQ==
X-Google-Smtp-Source: AGHT+IHdo+LQFOdKre2arvd2ENYkCvaf/VIUWjT85/IsPX2SMEschKM4qja1wo5Z90tdoBgHnAEQ9w==
X-Received: by 2002:a05:6a00:a91:b0:736:53c5:33ba with SMTP id
 d2e1a72fcca58-73dc15667f1mr20637458b3a.16.1745355568813; 
 Tue, 22 Apr 2025 13:59:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaaa313sm9065391b3a.122.2025.04.22.13.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:59:28 -0700 (PDT)
Message-ID: <5aa67931-2f45-4678-95f7-90f90d62654b@linaro.org>
Date: Tue, 22 Apr 2025 13:59:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 140/147] tcg: Pass max_threads not max_cpus to tcg_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-141-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-141-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/22/25 12:28, Richard Henderson wrote:
> In effect, hoist the check for mttcg from tcg_n_regions()
> to tcg_init_machine().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/startup.h |  6 +++---
>   tcg/tcg-internal.h    |  2 +-
>   accel/tcg/tcg-all.c   | 14 ++++++++------
>   tcg/region.c          | 27 ++++++++++++---------------
>   tcg/tcg.c             | 14 +++++++-------
>   5 files changed, 31 insertions(+), 32 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


