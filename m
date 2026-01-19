Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38179C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhe1k-00072O-PD; Sun, 18 Jan 2026 20:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhe1j-000717-9k
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:25:55 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhe1h-0004kG-Tr
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:25:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a09d981507so27737065ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768785952; x=1769390752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y01E/RUCaBlqxhgPfwif2LFgxCVHmXAvqYomjATnbKA=;
 b=OEdRYOIEE6wlYL8vwAUgI3pkdCLU+AM7GAziWvHKjuak3j5bMEM4+jIQQTyV3u4YaJ
 yTexTpS+tvfKwzmCgEMXCKK2tcpPM6WB5YL0Pucul+1c25Gppho9S9qKYDXdDULFW7La
 7gIw9n7CEGr6nDAt/Nep6fBbB8N6bYgNH2W5unzH0/uJhO68WOHuNwySVfWi72XH6Xre
 +ZqTmIUR2JckxeWtxlPzwk6IfdgsgGhWGm+YRurn3xmKon9NyXFuNATgnhv76xO+/QCc
 QIgD0OLVEhE+CwXp8zoW81KJaLsPI7oeWCZoId/ld4H2VR+4N2ZFeveHLT6CGV2EfVzP
 jr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785952; x=1769390752;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y01E/RUCaBlqxhgPfwif2LFgxCVHmXAvqYomjATnbKA=;
 b=kdJVcHpq/kOtWnxW+fxQCp7mLWymztbAssn5cvATZ8C1uGCYIeWgHTdTPiePmxRl+Z
 biJS6zZFyvCtIV6Ws3KFZNl8gnDc7+glzo6KMKgfWR2AntgoDw01IRlN5XTUQdLWkBWP
 +o1GHfQ1w4gS6IoinSnRNivA3Y5g+HbvxmoFVSWCAezLECaFWf6fCu4dcN5drUtZd/v5
 0wo0IReFwgGzWLTjvAPnub4l21N0OSgvKBBNPFvuDoyzw8VTGxCBJTj+SUYwCfCCnvnd
 zrK0phW4VPYOCFg+Z0rZ3IVZMroQ+HD6Z0gvYWaXAIZbcXJLccthUBgALfE1yN7u+NEA
 p7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQmqRFsP7vTOYcW/y203c8w88Yuw4lZRYBsXJ3roHxi5lgGsOSCpi34J0P0b7bNFe1lWeLaQnWD8qk@nongnu.org
X-Gm-Message-State: AOJu0Yy5JjkTobW7CGdK33uPIODgL4Gkc0U3SjZ91Wai5YZYNapg6VkK
 LZoCi8689zINwgagAAU4mtGSZqkkLYd3B88NbKIIbtgXU5tpprL8fVvK+8NHBuMdwcJpXjXkdtv
 iJO1pQsWEjkvy
X-Gm-Gg: AY/fxX7wq8ym/vPi3/xnMC2wTuMYPzHJn62d8z4EMFJ/z8KFju9ox0NHnw36W8/l0Nd
 RahAm7Ovy8MvK4mhqWZrj6RKJdvKgNRs5ZDvZ+j4AijxzbTA+ZDIwHErZLee+ELjOTFAfRRIzpU
 x/W3NyCkvalr4EL2MWwBJUXgDLv4wP5vzEq9752WLdC5fjy+3ivIWyJ0/af9T9k/L2xlaYNdvaZ
 /3RkSfhlljAHDMprA3UqI9LRp7wIOZ5G8/M0RTb4HVHpf2I0a2tD8FH93pqNrNsQmJoRuGEb9D5
 22mqUUhKd/+5b8ZThZWNMgNJKUoL0byXN/8k1QktSKYfMmuVuyUNcCbhjuUrxh4csb2+R9e9vZZ
 8xjMQ5OULqMfC+FdVW91X1v6DaIo+VUm7f3cQWnl3dzTocmlGsRsgdATtIXhasTO9+a8bhMn6Wb
 OwwXljGtDSwJE+zYGcU5887FYLN1APYA==
X-Received: by 2002:a17:903:1108:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2a7009ba1a2mr114506545ad.13.1768785952411; 
 Sun, 18 Jan 2026 17:25:52 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190abcf0sm77374445ad.12.2026.01.18.17.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:25:52 -0800 (PST)
Message-ID: <1ffa78cf-a1e6-4338-827c-2d1b175de044@linaro.org>
Date: Mon, 19 Jan 2026 12:25:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 5/7] linux-user: assume epoll is always present
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-9-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113130008.910240-9-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

On 1/14/26 00:00, Michael Tokarev wrote:
> epoll is in linux since 2.6. epoll_init1 has been
> added in 2.6.27.  There's no need to check for its
> presence, including all other epoll-related syscalls.
> 
> Modern architectures don't have epoll_create(), only
> epoll_create1(), so keep conditional around the former.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c      | 10 ++--------
>   linux-user/syscall_defs.h |  3 ---
>   2 files changed, 2 insertions(+), 11 deletions(-)

glibc 2.9 for epoll_create1; 2.3.2 for the others.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

