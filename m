Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B593FC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9YA-0001sp-Pm; Mon, 17 Aug 2026 22:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ww9Y9-0001sY-K6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:27:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ww9Y7-0000QS-Tx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:27:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d032846c95so59267275ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787020053; x=1787624853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ELNuMkobl3J9Ou3FC69axO7mIx0GREEJA4juCJ8mKE4=;
 b=BuBEe680uik7WzKCggVUFI7/sbIbItcz/HRHXwbisBXn8aTvaSjcu8rqSTiTQZyyrv
 Wk6baKEi8FmIeKgsDBnAZUa5+hIC0krCfOqrEQbxysqS4oxRFhdIDSCXid3s8WSBoRAy
 3cexfquuqtK/gKwdQgERpq5pOaWQY6bL42m/oPb/+uc8e77kn2OhyPifLWeAQ4mqOaSi
 ZX26t7f4TAZbiI3K58+/wp0qyEqSWIPYxhC/EWveNh6HQjvitfKGDuZyb+OdByz5SUiy
 HKj5jX74Poq/0SDEGRW8fpCiqVcxftgmLvRig5mwz14BAsy8Jo1/PbztOO1GRIM6a1Kf
 nz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787020053; x=1787624853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELNuMkobl3J9Ou3FC69axO7mIx0GREEJA4juCJ8mKE4=;
 b=fkNRGzr/oTY+K8QoNhrQzOle+5k0lXZkJoAWgrv1/AllJf7YGlfaEMA2oWklceGe98
 HdrSRJte3EhJ+6Uf4lm9Shia39N+fIXebShuANODA7BRvCaAaOBwvSzPRFzggx6xX5Ee
 SkMjBPlkag+E0hebiwedC2AO6Y1rjWkmhEffsNyo7zS3P6WX3gmwkMV8Dl7qs/wqffAp
 I7nkrpgBfaUkelIsAnNxV65W53BgLulhakUoXnjwBtfjREmHfeuVSShwNtGgJ0v5n7rC
 lsFTtbYcQD3wYa43yiFJZkC0wREmHwELpFMpYx4kKAmXCtRSfx1J8mua6s7JbOEab1Zs
 E7YA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP18xqaUvLSjR4KCOjHy8is+ivtPvpLWNxWKjD8l5XjlT4UmBBJfMFSik06f+H5MoaLA4balZvReY1@nongnu.org
X-Gm-Message-State: AOJu0YzEYu7TIj9ngltVaKcESEniDmFdnPbhLvN/6xgO3PPlY/NRJq3K
 1FJpgZDOPDxe0gwJh99GoVa3DXZS39yhe2hvLy7qhqMV7jC7FnGDIEkeHunqZMJ0Hm3cNZmW/pW
 myto/
X-Gm-Gg: AR+sD113oppQpAfSU0xVu5FH+MlTva0iw374ccP5I4qQ5Tqn2bxtMKxQ1pUh1RvaP6V
 mlhjpUWhc4hZ6BaLeXm7/e9GrNo6TN9YtI6wd/OlrsCsKx4+kNSF4rjvUnBAAIrivM+yP8e85Y3
 p5/ixaBG5orkT6VfyobrZZOooIPwKMAoaETWgutm/POSRHf9KjVWefGo7lLmRNf24UDCqMuifpH
 U4wLg/y/hH06Nf9ekbNkEhaS9o8pxBAqdOBGcxWzeS2MsttIVM9qA8sJUBIWa0r6XSuIH+aYHgo
 mBOmbU2KofVcvQxt1PDwgbweMCneLbQl36qXKsA3mJ91FpcvxXAKJb42Fb6XkyYzskg6L/mN7XK
 3EV4cO7SESV2FDqR9LBFQ2nW0V/9L7wEKUsZnhOwOHLMHd8xs5zINxzXyffxQ8Yv2Y60qoF6yOb
 8NE5E9krwos3zBIuOlubeZCDMn/NAYWxjNAU9yCsa882sHYIhuv9WHCyr4VNc3fEsSXK6V+jtsK
 2ol1pI4gnNRWG2TIGzmvmVGIT2pqhhpuNfPrfxQZkx3mJE=
X-Received: by 2002:a17:902:cf07:b0:2d3:2e86:647a with SMTP id
 d9443c01a7336-2d5c4f07dd0mr62947335ad.5.1787020052812; 
 Mon, 17 Aug 2026 19:27:32 -0700 (PDT)
Received: from [10.213.131.227] (c-73-181-156-132.hsd1.wa.comcast.net.
 [73.181.156.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e91348sm8978605ad.58.2026.08.17.19.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 19:27:32 -0700 (PDT)
Message-ID: <49c4ddab-ab0e-4378-a69d-3e74a5216c35@linaro.org>
Date: Mon, 17 Aug 2026 19:27:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] block: jobs and dirty-bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org
References: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/17/26 12:29, Vladimir Sementsov-Ogievskiy wrote:
> Some fixes and improvements around block-jobs and block dirty-bitmaps.
> 
> The following changes since commit 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa:
> 
>    Merge tag 'hw-misc-20260816' of https://github.com/philmd/qemu into staging (2026-08-16 08:17:47 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2026-08-17
> 
> for you to fetch changes up to dc04053687ec7219a78f9b90fe2f71c9336914e1:
> 
>    dirty-bitmap: fix integer overflow in serialization coverage (2026-08-17 18:32:44 +0300)
> 
> ----------------------------------------------------------------
> block-jobs and dirty-bitmaps patches


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

