Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA865CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkgl-0006fa-PJ; Fri, 01 May 2026 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkgk-0006d7-6e
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:01:38 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkgi-0002Sv-OF
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:01:37 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-364ef7a759bso299602a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629695; x=1778234495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=exycjy4FAxHdjVOdXLZmsVYMkVF5iW6BRFb8MYIu4O4=;
 b=CVAWdFj9YiBMIvo7lJDMZFGm5VjiosUJWnnXZz2h+yv4lUfADfAGg/PaSp/gK+PoQ0
 tv+ksfGbRk2DNM0bgUmsZHbqW+zCBB0t7QQ+bLjX43k1aEpmJkv7EI+0PF8M3GhNPM22
 Hrp9fki6OFbTFehOXv4j7rZ0Sq84Lr6eDTOmusXJCl0TD9vsQAVWlqufGEl8eyG25gU2
 SD7GLoBSOngT2Z9Kp5d/onrxJ+2yCX3YvoE2ecbMFTBMtkrVIcsSVYo1L/1hSaiu4wTF
 vXOLyxTnv6Ob/KP0SCJ8mSVbMjFVkr87nI62ZqDCO/Qq2x1bUhnU88+1GXDT/VSdDeLN
 fhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629695; x=1778234495;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exycjy4FAxHdjVOdXLZmsVYMkVF5iW6BRFb8MYIu4O4=;
 b=MZv6xPs+8YUyORm5PeDB7PYskks3v6oAahenkPVkVby0lrYsYbbc1rSFqwdEsVYj8L
 1R/nsXhFkALsOYk/s2lkjouuUGllmyaXmbWsrBJkQc1X9F0t+5u47ZlWxjwMhjBX4EH9
 IKecrEHvTYHag1EQ4nBiasqCqJurRPKmjpggCgCUISw4t/APvnR5Dq++EkEMHzTagFjV
 yPjYbZvQ+yfQ/BDAkJPhmhOPLFBcZY/iED9nXJhSD1NsKafesGuKGiNmovnCyM2s0S1X
 gMA7g3+yh/iPoMxedytyisUWjaxs3cvh6gCMPOzs4e4nB6mtzWbTKVPYRCo/hnFpvTwH
 3QJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ//2iup9IY+QP64GSTFaC8ZvYw2TP4LNLgkZU0eFbrS9OS+SQ/V7B7o73+uroqvIkK0+MhrROsgDiaI@nongnu.org
X-Gm-Message-State: AOJu0YxX9Zt3f3tbr9nzto4z/tkOs0UEAWtckiVu3L8iCjgxhSOu6GcE
 RcMhkkh6kTOGoetJgT0kjYFiFHTVKOFgUdhWYoUZIepii1xA0WLkkErox0MrX5SZz4Q=
X-Gm-Gg: AeBDietEA/jpGVTW82Rkma2yQDGVX2+Pm+TJtCJ5GTcHPRqtNii4bj3FWpGv5uTZj+F
 qiJNDRL799M5klK283NfAIz6WpyaEsRxZl5LmJSSJntvtOyyJBJgSqTAKtSbMLH5RiC/qeIZylS
 qApBk75e98RruKErM2hGfkHi1oV5h8an3Pl5hci74USQjOXVoneMza+027ApvUG5uTmvetDntI8
 wsuFHDnBfoP9VXfQNX4yoMHw383oXHM/igCAqwC30g6yaKfm5zJYlkWMwDqq4OTVbAWfuTa82b0
 hAJcni+Fe2khpnKDFWG8SJtfookxZ6RbhQ0odKS+9eDGY008mPMawfHiKt/iQpoP43qCE/uMpql
 0jv4vDGEKH/n3AsCavXjB7pl48ioU7SxkewQEeKbbsY7JwK4ejjotHd86aub3+fzCrAsqhOiUfO
 m/7yBvLawNoAbpI7mg468V3GP80s4T8/ODTuoUOyeWaN+ZVLR9Ujbf
X-Received: by 2002:a17:90b:2742:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-364c489346emr5841158a91.11.1777629694744; 
 Fri, 01 May 2026 03:01:34 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364dbeb2db0sm3844099a91.10.2026.05.01.03.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:01:34 -0700 (PDT)
Message-ID: <8e8f3aa9-6ffc-4e95-a597-dc65399f233d@linaro.org>
Date: Fri, 1 May 2026 20:01:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/25] target/xtensa/xtensa-semi: Use
 cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/30/26 19:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> xtensa semihosting code to use cpu_translate_for_debug() instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/xtensa/xtensa-semi.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

