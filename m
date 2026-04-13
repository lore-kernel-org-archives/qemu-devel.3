Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24D2F531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCR0c-0002ek-Bd; Mon, 13 Apr 2026 19:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR0a-0002eV-Ux
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:48:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR0Z-0001qS-Lm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:48:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f351ca23cso794847b3a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776124078; x=1776728878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYMlEJohryTgYTAUKe0GQldV+QSPLuXFIrJ9sXtGKmE=;
 b=DDn7E8G3JySfXrYzRvku+iDEv0SX51JqbgkgG3G5UJ9EGLpruAOZR49ikeujed86U7
 B9D5LEkG6zcQHKaFPdVWUb6EJgNKa+osB5Ha/XTan3RkoKBkBxOUBQUqVAJw0elyI0ax
 XppayXEzTo6s6VtseZuQ8AkMLaVefJph8xkVWvJfCfcyPS/44clQGMZZFWYjGKsJKyVM
 TjHsTBxhnJzpao7qakZ2Q40KCWbjjC2Dvt6LR6nTQVy/y9vpRhnrcr3f6dIqbZmhtN5p
 A0j7wBdyY2sDhoQJrZgq5KX6R4cr94G3JCmSY32AquWWay5YAFQbCxLzlISgwUtXW0Xj
 i9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776124078; x=1776728878;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYMlEJohryTgYTAUKe0GQldV+QSPLuXFIrJ9sXtGKmE=;
 b=CrJETNhrsSpuFeD6SQyhnwCZztiEsc95/sLCbL5/8VKutv7Yxjj3Ow/wJqwWhiLm/K
 +MIMOcgDTXo8epHvIDsHhVYIJ9VH6IafjIWQOufwrr8DDkVtR57sFTk4D6nqG0ZWYZbz
 6aZypiWW31HYniD/zfkB+ChKyJ8SNFTNs+Lqhs2RUagvxF2h8hfqV04t4uM8vGbBLB32
 pBYcsJOjHZvoF4Dw2+5nusw/yqn9uImBD/RKxd4OuIxip3db4ofSKYTmQp90YIcm3RrN
 nGkWvYDKhkReWK40A3xjhSMHyU2ToQzRId8FkzFRPGY9p+9kCUFv4Huhkj8jx3U2IyId
 Lh0w==
X-Gm-Message-State: AOJu0Yzku8Uqpe+xkUafh/JTGryP6oZ1PjGst7kvOhwoXiXy21+jGLPm
 7t18dJKxuNzRFUXZXdKm2oYHd0KTW6btTwSlnDS43h6TKgSt2mGmcqQ6w9wnROeHsEyo9fIT/H+
 3QmOd
X-Gm-Gg: AeBDievhf2MlR+4nC4RGMs5KsCCwCSYTwal2cAnaO85vniZ9qoqt3yqdba+7cbWcoF3
 Jms/L04XvlYB0mxje0YGZKsoO+ga2GIORTeKdYVxdBphvrXQsLzCks9QQkYfVyQOdneWBF7mh9H
 IeB34DVUbYLg0Q+kbMRJdpDAUo8O1D8Zx8LvPcaiHeBM+XHcEOv6EKqA2Z1pAhKUKnt5LW+pXfQ
 XeWzoDOYidfK+MPyVKMebdBcboDTE47EhI0jF3bU99xNX9TTAgN3iL4uCBcGaxVnbPzdx/gAXUu
 pWQ32rQ9BKvS2RVYnW57kVUoOXPO5mGlTEDb4nr+pLoyNC8ocnssXhRC3Rlu58QhiPj5B63KG5v
 JZ/31ks71lYmdE3x1Be4WaDN0eDi34pU0OpWtZo7khEOwpNWbvAe4hfMOMAuStu/AhAxK0HKVcx
 9yvj8vRMqkFK2274VLF1crbme/gCLRqBkEbGugMRhfJNjAJ0MjGQeDFHc2j7t+MSXVNVkiWowBc
 HVhPEMP1AHOVA==
X-Received: by 2002:a05:6a00:2190:b0:82c:e775:d430 with SMTP id
 d2e1a72fcca58-82f0c3562b2mr13728370b3a.28.1776124077867; 
 Mon, 13 Apr 2026 16:47:57 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f50534794sm1340755b3a.4.2026.04.13.16.47.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:47:57 -0700 (PDT)
Message-ID: <39815f0e-7dfe-45c0-a96a-48fcd8fae1b0@linaro.org>
Date: Tue, 14 Apr 2026 09:47:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/arm: Replace MO_TE -> mo_endian() for MVE
 helpers
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/mve_helper.c | 47 +++++++++++++++++++++++--------------
>   1 file changed, 30 insertions(+), 17 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


