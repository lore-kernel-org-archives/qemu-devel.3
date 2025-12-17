Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B2D609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfPn-0002Jh-I1; Tue, 16 Dec 2025 19:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfPj-0002JJ-KA
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:29:11 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfPi-0006Q7-4A
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:29:11 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so39898915ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765931348; x=1766536148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4GPTrweyyeK+8037DCuuyHtXWg8qaThAkj48F0vT19U=;
 b=IRQ4dTFJo6vc33riGhT2J8tE13/mqXnCvE2srcoUlf7TiqaDYAWewhu29250tke1vp
 134hf2WdUnDCFa/rDlX/76Bb/ijI9p5Te1s5EYS++pCKIZB10HpDJLyA67pTJlp094zX
 iXib7PA+7RTS+FzG8v85rgmwsep8dpqmZ36ZrsOtGRuxW5YfgkFYqkKIdM8BB2UyBWqX
 btZGWN+9LOksYCalKdTW/DOyOowHmJ5Ip8GgEtAWj+Sn65SRG57NE+cES6z9Fo9FypjC
 6USZLBr1015wJ2Ek66vwof02VJ6KnTLvL89jxe51czphT1YmG4rAXSKhNjpQ7f21ifUE
 TRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765931348; x=1766536148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GPTrweyyeK+8037DCuuyHtXWg8qaThAkj48F0vT19U=;
 b=g/jvGJpZgSv/W3zI+EuuZPzYVxjMrTgHIoTOVjaXUVsj79MHgDQ1ycFuXxhvLKPAm2
 c0crUiYHGj5o+/j/G4+skh8LVKBUbvaa/b6sPaCOXRP1HbhE+Bhw67fiJmMYGhXmrS/a
 0ztd02uQ/oSk++2ZcevbGl/UDQNe1lqVhq5Gj0MEXXO2AoAlLyqLpard8NMjxjdm+Erx
 K6yzyowQXWiZEmaS2zOssQF7x3dPwnby/rxBSBO1fLhx+R7KXGxNz9Ij7jCRBX8M935l
 vkN3IVkvN32BY2JmWCE5M+YYqAmKLHGxxKI0i0ncd65pKWPyxC/+6exE8VEZB7sEFWyj
 p7Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWraifiHVfZQI2DD30QuYyq5LjLf3SEfIDCBntEhoNXxavVOgnuKQR64av1I8S4e7Yel++qU7js7Ho0@nongnu.org
X-Gm-Message-State: AOJu0YyHaYND9isQl2UTHKUwdQIkFz0WHrvdhdo6pt7N2YOH+CZHRT/U
 LQEf4yxTqxe9clvdicSAmrWYPxj9RsPNHedhLYNQlTiTWm3qyvpYMmt8QaS45uCgdpM=
X-Gm-Gg: AY/fxX43eIO6J5C1mBb8oKqZUqA0/bJXWW4rZYHzW0/BXky69wsXmfLetmugcBU4gqW
 3E6Q0XEqmarBno/n/reoOaUHQheTP75YlL8V54LXvM0oqAMF/EBXjcmfLcDx6HA+YzWsHq/LK8X
 QjGodkBttpKfpWQm8i7CPnFwo/N6HJg/QyPT/Kf2Iy0VM4Hps82sIm2JCWM4Ok/TkKygYHcQQu8
 yeC4XKQDvvtOp/gk8Aiu3LmLYpIFkvXji6t4MNo/PQxx5tQiyH9m0D/+CHz0zq8NYWdbAvfhnk7
 FWxzDDqw+PHqtFIXpHO0Sc1Jtlo5Hb817DokLYfvsBwed6ecwpolofE08NYVU1JWCYgW+hU5vFs
 6JV3TicL+Pjj9oWKFiE1fyuCdteLu9haNnARdUaaIYF4C8/RIubJtZJZCk9UW6Vq8VCo4O6tHLv
 g81d5BHxQpg0PDYegSFHwTU1OJuLMfttlP/EAdao/EFW/EfUX4FhAUEt9S52NXc7qqjg==
X-Google-Smtp-Source: AGHT+IHjNVTshteqwEDQzmUnxpXjrD7YI+4+V9yvrc1wytnYFqQcT/+jNzWuy4xpju7tQ09+f7cACg==
X-Received: by 2002:a17:903:32c4:b0:2a0:945d:a195 with SMTP id
 d9443c01a7336-2a0945da490mr140741435ad.45.1765931348308; 
 Tue, 16 Dec 2025 16:29:08 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34cfd90bc9asm591859a91.7.2025.12.16.16.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:29:07 -0800 (PST)
Message-ID: <7ba085b6-8461-4538-bde2-e291fe18bcab@linaro.org>
Date: Tue, 16 Dec 2025 16:29:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hw/core: Add riscv[32|64] to "none" machine
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-4-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-4-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/core/null-machine.c | 3 +++
>   1 file changed, 3 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


