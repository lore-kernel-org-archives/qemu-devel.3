Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64AEECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCQH-0006Dc-St; Thu, 05 Feb 2026 22:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCQH-00069t-76
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:22:21 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCQF-0001mf-Jm
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:22:20 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bc17d39ccd2so571757a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770348138; x=1770952938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=40eb+n3EwI2xAeF9RO4VYov2lwL4RdirlsRsrfNXz5I=;
 b=BB9yDqEKFQ5SsPOPCqbK8+zpvUkXD9RRkB3YdTvlqeuQtlhNcqFRP6qaz22miq50wQ
 +3YscyMWaxovY+cZ4NUprvXZErzwHp/vZjj3d1vJvR4HE/bXCr6+6nR1wNrrgbDp35ve
 leE0AYFbKvgUBZegDXZSduCtRa31+6kLmPTLaItt5un3JYdV/3QTocDZVOpIwSsDQGhi
 8NiA/lgcoDD0kd3/9ByWWqjiJ/RYfnwtz82ImwFg8U2MMBVt9COKBi3DJvSSDMsq/vQN
 wZA/57fUUNsMB/pm5ez+WHdD6WzUGPxnUViiid0PsUDQI91iz8kVKw09kiGgVybOu+EW
 fANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348138; x=1770952938;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=40eb+n3EwI2xAeF9RO4VYov2lwL4RdirlsRsrfNXz5I=;
 b=PFyB0OZCUl55qnOWfCk5cwTHz5Az+Ku39i8WeTuSPc5j9prak1s1+6G/XuaXOXLHmt
 XiNk1mUDnj4zGpaVVkxq6QxRwuOrqIpR4kx299C7fw1UOwSkzXAQvSYOWaF9cJTZKYV8
 j9fLaE1l/IS7rChZqbFXb7ql5Fs/M8E71kPj34A7B1XYWt5QtqyYteQxKg1JdHNuhUMh
 jW/3+8yhqpvkEZTIqjUjquVS+eSstyD9iNqATAwE95TF7dRJdhpt+Kf2+SdPjZ/s7jyx
 AC6lYuuROYiE1kcBulhSsHVTcThq1QM2Qu9s16e4+oBAzGW5QeCWIP2b3OrV2V495j4z
 aasg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD88+60GF2MbsEa/VpGqBW+vfJMEA9n0P9dF2+7n/EHUiHd7KxsLqy0KpKWIbqMiA22NHJfnEjxIJX@nongnu.org
X-Gm-Message-State: AOJu0YxU+EHfDDXGpzrHH+d9WMx2A2vjXJGc9rYQJY9Ire0mt+g8/1lt
 Pdob305gGNlLeMX6zgUqw6Prx4DrkgvOCfFxi3dDHkntv1XZkbVQr+Cr12CZaVzyBoM=
X-Gm-Gg: AZuq6aKECli9rDZT1vR8Hpo3J5wZGbGuMlBNDHte21MJHn8CFBrXBxNp0p1JLiUGyZ7
 nWsl1RXXW2b1bbzZX4BKsdMMr+kMWymKrfFQQYKiLIOrq4RZ0ZAt4nPZUnu5/NbsuwJ7gupw8xX
 4k8cmqdZr8eKjaHIaqp8wn3yn3fMxB4IBBwookWd3PtUGy57BZqOUOLG1dL62JSjAI5onDFaQ3s
 zDz2sNOJV1W9/5rWs1Lso3b1lINHh5mV++xBUgAqBD5dokghq+xSZqriC55k5wNrkcjyd+u4B87
 VgdyUOvb4/98h/6cpH9Vx6zz4Wzo2qU+Jr5+F7QCchbIO/pl00dQzC1M03A9Y/d+Ox+YDoA0Vci
 rX0Bp7sYRGBqaoxgZ2/ccG+L2X7slPmwSqtRMbzQgE1ms7PxADbb1xfMEDMJAX80W7YLhWB0PIm
 bCfLwM5bNKcQ+xJS+pR8RxjetNj01/fGMguEhENsVZ2U4Mw28akkcfbMh4v4Vwsnna+GfHwesCp
 kE4V9TtJvbvAcHnhlUrFjmEiZpyZiS75Ilj0PIOKs4=
X-Received: by 2002:a17:90a:e706:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-354b3d0ddcamr961732a91.27.1770348137900; 
 Thu, 05 Feb 2026 19:22:17 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b21fbfabsm903614a91.12.2026.02.05.19.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:22:17 -0800 (PST)
Message-ID: <1cdc9e1c-5c5b-4ef7-92e9-25085acd5ca5@linaro.org>
Date: Fri, 6 Feb 2026 13:22:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] bsd-user: Add do_bsd_msgctl implementation
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-19-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-19-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of msgctl(2) syscall for System V message queue control
> operations. Handles command translation and structure conversions for
> IPC_STAT/IPC_SET/IPC_RMID operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index 81fdfd8351..27f4497d76 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -28,6 +28,12 @@
>   
>   #include "qemu-bsd.h"
>   
> +#ifdef MSGMAX
> +static int bsd_msgmax = MSGMAX;
> +#else
> +static int bsd_msgmax;
> +#endif

(1) This isn't used in this patch, and probably generates a Werror.
(2) Does any supported FreeBSD version actually define MSGMAX anymore?
     Grepping current source suggests one always has to probe at runtime.

Anyway, if you move this item to the next patch,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for the rest of this one.

r~

