Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A74E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va42V-0004Bp-Us; Sun, 28 Dec 2025 22:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va42T-0004BS-Re
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:35:21 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va42S-0007EZ-CE
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:35:21 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78fc4425b6bso49367967b3.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766979319; x=1767584119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2RbvkafNavjlwNIqnFA+FQJZPXMiIfHMjLPGERDDlk=;
 b=JGvLOu+WPTPTpxODDdiq9EUHWJio+1E5cjOVS24dOK6T7cokmmwrZdaZNor5n1CQuw
 3npY7/NOkrW2GzAHF5hF2i3VjFVxjTsJTGOGvw4Trk4vvvFBGbO/tG/0ZmmvOqDsylEl
 4GDG+q8tmF0+7oOr1u/Jl1TDjLw37YK8dWExNl+75zkoHvErsoYoZDqjaza8cnk1mhNK
 c7lZgx6V4m2QTmbtlVAb/p8vOHcW0vNGvUoCvKnq/B9PIfz9NPTfc9/v0RswoqTz3AMY
 5xLNbVOmrPxJ4ZFNBH63iIxmipIQgAKsca57kkq7kufYVciNy9XpblmwUslnu4cCyRSt
 sDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766979319; x=1767584119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2RbvkafNavjlwNIqnFA+FQJZPXMiIfHMjLPGERDDlk=;
 b=Vx4/PfvNHVGR70pV6sn0kDXGEyxVMIyo+5gayhz+/3CHASpJFHc2l3XlxdEN4HyJ6M
 aNmYcSVL0fdv0/7hl5hOCmr+X5xZ56y6cRwUJVn/GjxGgVGSndcGwyDxAJmWh6VQodb9
 KKFNIZdXxYR4mdppEtzoo1gBmbvcW2MJyCJCKzdCCbzkRyXYqKCu1Jj+6jO2TNWnvqL0
 MnuJMhNr0IS7YUzvKsw1wqkgt7si1IMcEZbNgWGmXYYIjPOXQHBKRnPLq7g0V8aztzad
 xVuk+sCHS/IfLKFyDleA/4bml+PF2JK8grMl6Zo1xcVN1J0HEbWkqqiiw6BxEL3OqYeF
 jDQw==
X-Gm-Message-State: AOJu0YwUHwjpssIuOl+VHjEfUwPjrWcNz3z5u/WHJ9UmAzFdjHMO4qL4
 aboTDc0ET6g7UkuQrC4owrBE+Gl7bnYWAFcqJXk7F1cClc6eJA5hF2A8PvXN7gQfZEy0xBNdC2u
 D5hMI9Z0=
X-Gm-Gg: AY/fxX41YMQYYOpxg/Ag5F0DJXi44cEyUpuH11Tpgj4fTuZ/ipgDrLHU/95QXF5VQW7
 e1SL/RdH8ZZvZ1bQdNcKZHFzYdYxdKQOQbNK9HYmQiNSeuUaBN9pkFfKtQfXHORs1UabaYQjz4A
 tKoP8Pynw86pgG/0V9lh1oLEjzXbDTfg5SKbSB9+jmxaCh3lvaCzCP453HfABVKEMPknnWNynw9
 Fzvfsn1rccCi/uhgIskAjafCqvQnZmZXKsDor1qoZK6XTWqDNIm3eCvUj6waJIxxjYtW+SPy+Dd
 azzOisHsdNd+jqev4gY5KdJ7qbXgBQzAYpIHXHEPe0Yan0DokQB7ww73eZGpG0tmjineJxuvL/a
 sYmNZ8bvCiybvOQmydo30QmJ+FTlXdPFiFX50RzdTz+x0hUcO2hZsiHatjbfdtRIQ1k3J9vsn9q
 3lh1t0t9e6ahVsIQHRzLT1CgYm+7Rg4vyEmeBatqUT7F1JztOycJF+RymgSiScOcRVsHVpUxicc
 D11NbM5
X-Google-Smtp-Source: AGHT+IEOLL4FeFiRmjFtZQfGnT8iC0QFpSOzyBwCt7Ria5cvpzWj1PejlZv5L+HpXDE3xXXZeDwRQQ==
X-Received: by 2002:a05:690c:d1b:b0:786:3ee8:6703 with SMTP id
 00721157ae682-78fb417c7bbmr235080407b3.48.1766979318825; 
 Sun, 28 Dec 2025 19:35:18 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb44f3e26sm110553797b3.36.2025.12.28.19.35.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:35:18 -0800 (PST)
Message-ID: <5725d33f-1a04-4d4a-bcd6-d5f4e3a7e3bc@linaro.org>
Date: Mon, 29 Dec 2025 14:35:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: allow null `pathname` for statx()/fstatat()
To: qemu-devel@nongnu.org
References: <20251225153932.1906919-1-jean.christian.cirstea@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251225153932.1906919-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1136.google.com
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

On 12/26/25 02:39, Jean-Christian CÎRSTEA wrote:
> Since Linux 6.11, statx() and fstatat() syscalls accept a null `pathname`.
> 
> Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
> specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
> issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
> perform the appropiate syscall and let the host's kernel handle null `pathname`.
> 
> Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
> ---
>   linux-user/syscall.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2060e561a2..e1b61f6dc5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12142,7 +12142,8 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>               int flags = arg3;
>   
>               p = lock_user_string(arg2);
> -            if (p == NULL) {
> +            /* Since Linux 6.11, the path argument may be NULL */
> +            if (arg2 != 0 && p == NULL) {
>                   return -TARGET_EFAULT;
>               }
>   #if defined(__NR_statx)

No need to call lock_user_string if arg2 == 0.

Better as

	p = NULL;
	if (arg2) {
	    p = lock_user_string(arg2);
	    if (p == NULL) {
		return -TARGET_EFAULT;
	    }
	}


r~

