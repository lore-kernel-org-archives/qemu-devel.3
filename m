Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41362E83041
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6Mt-0004iZ-C9; Mon, 02 Feb 2026 21:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6Mr-0004hx-S6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:42:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6Mq-0006HL-A7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:42:17 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c62239decbeso1993479a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770086534; x=1770691334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AVdMqrT+YI+jQXDLH/TQUTSeswogU6gmyJFjnUuA6rM=;
 b=DEReZRoWsFjRT4U9TjgKzynmCaFhKC2KinP/jT7QHgDjkHUd/15WO9hm31aEZGwI2E
 nsMZli+Qx2iDcZVl49P4NhIlG0vca/AL7dyME3avg5HVjz6VxR37hDmZ3el/l1CmaTns
 JclALFEGeaCtVN2sym7nC33lD/RK5C7RfcGK7iE7ayuM0xVsgkU7Wj/DC/iMCNbnzDZr
 DGE9WcQnjvUad1u52rTDSHHuvecCJPWpI/jeME4CYOfG6T7EVhP0tinMt8uLF7TlTCxO
 lFRxiFVodxAt273zn/oazkTnxx57Zsl8AjXlR8MyNZVDcNjW/Pd4JitnT1cxMr6KY4H7
 JKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770086534; x=1770691334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVdMqrT+YI+jQXDLH/TQUTSeswogU6gmyJFjnUuA6rM=;
 b=ZgKm7VrQ9w7fTVXqbImzOtGRyI9I91NkQcAFuE0kwLvyM44pdOChcFPYHyuYQGTeb4
 WE7kEuaTHXlXsjbc+jLMaXQlK1LrmvKLtLpGqw3R7d1LejBXiLP61nwC39Tm+KqxLb9H
 /vqw9N4/N1pF+wFWWyGfDu3k52eBvuxnZTQ9tGTZ8eogfPnzW/avFL796PQR4Bo/UOmT
 xoDXbx0/NetJ9k74s8QOTmCPkLtQ2kuQTQGBbSnZF/IU35kokiyb/zxK3oJArL7DlM+v
 vgWGIXhniIGwlItjPo9a2rbyofqrEb3y63i+83niN2hnNstp1S1edwBZ6Gx+awdiE0xv
 Ibzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5lDv0G0Sxvy9ciALy65V2ktHt9t4EmoBuH1QZFjjuy2BtT6zutdCLR0uytn6Yjsc5cE43uy3baWwO@nongnu.org
X-Gm-Message-State: AOJu0YwfWOV0VDDJDPPtoTzB4HFV+LinRKMrz+UnkWkonBhPakkl/qLH
 jpsIyGxjrbOsauezYwPBDBTABBuBFph1+3lEJK+c3M42jnq/M/jtcp97tFuXBGXcmOA=
X-Gm-Gg: AZuq6aKbXWFKUWmJGoZIXMr9xjgPP9usie+l85DHV/E+hZr2ib0ajmSIHH87wSFPIda
 Q/tVR0TrJpG2kjGn0nQKENAepQtdNRkcYYYTie7SL1KoujQ8ZuBeDtaf1ZbBgqTZLJGIDC0mF1f
 xLGePpGR9OUDuhLVIjxVRQwFmr5owzNo6UYHI2kPL90te1RWVfw3HaAVbZqDOl/GytHXEWSgrdZ
 xq9fA552c68IoRJzQIPth6ltrfLUHQVVVbzRe7oXrvvewafChMWMsfIK9yxLmnIhJbSGdaVewih
 vb2YzdbXCBZ4jp/tYIFjAbZvPB3OR9A5NkDq++tGGAiq/cUG4qpYsYBEW6Rh2MDx5DFKw1KHN+F
 3TXnMVrNQqiTZu1QiEgcOMJDPL9UunHOHPU3gnsgxL+KLNzBTz8fowAajM4AoDmhIEjvbxJK1MK
 4i45ZRYcDYvWyYcS7yCrOjjI6vj15c74Stv4nEY7dG2b3aB8z304aq4MKBeO4k5jDY3AlRmVyuj
 8ewGEo0f67tcxmLn3UJCdnH3DLE/V55n+wY6mGzesnvBeIusYyD
X-Received: by 2002:a05:6a21:2d44:b0:38e:9c27:72e8 with SMTP id
 adf61e73a8af0-392dffe0d51mr13116481637.4.1770086534473; 
 Mon, 02 Feb 2026 18:42:14 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3eecc5sm166466385ad.17.2026.02.02.18.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:42:13 -0800 (PST)
Message-ID: <e0ceab50-b976-4c38-bec8-705994295c0d@linaro.org>
Date: Tue, 3 Feb 2026 12:42:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/syscall.c: Prevent acquiring clone_lock while
 fork()
To: Aleksandr Sergeev <sergeev0xef@gmail.com>, qemu-devel@nongnu.org
References: <20260126151612.2176451-1-sergeev0xef@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126151612.2176451-1-sergeev0xef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

On 1/27/26 01:16, Aleksandr Sergeev wrote:
> By the spec, fork() copies only the thread which executes it.
> So it may happen, what while one thread is doing a fork,
> another thread is holding `clone_lock` mutex
> (e.g. doing a `fork()` or `exit()`).
> So the child process is born with the mutex being held,
> and there are nobody to release it.
> 
> As the thread executing do_syscall() is not considered running,
> start_exclusive() does not protect us from the case.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3226
> Signed-off-by: Aleksandr Sergeev<sergeev0xef@gmail.com>
> ---
>   linux-user/main.c           |  2 ++
>   linux-user/syscall.c        | 14 ++++++++++++++
>   linux-user/user-internals.h |  2 ++
>   3 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

