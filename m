Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8A9E91297
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCcY-0004Xl-Gp; Thu, 05 Feb 2026 22:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCcW-0004X3-I2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:35:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCcU-0004g0-2k
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:35:00 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso17706105ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770348884; x=1770953684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4nIhgBYzj/pMMe7C5ff1M39odY/oil8Oq87UlRR6ips=;
 b=nAS0iIcycz+8MRBQxW9AtXKlt4SDFcwZ9lAnL/U0j8ZnjaOBtbQGtAJdH66GF3ysK3
 SZiYyzJ0M47/iybe10ZqvEDswoCDMbI+U6qpr5/BbW0GtlFW4UsJVDBCl9aPyjFiK7MK
 psRJJcTVWE4bRc3o1SPn1iKEuKdqYFJUYlkWpyXXXOsWUPzgxrNpdwyTg3v3K0re+me0
 FwUvf2agq+Jw9+UPFpRB89nkovahX4icrkTjiRMPcHbpXJlJ9DVbwR4NSF7Ai9QZpgdj
 IGZs7xpcG/kCsKC5sMgmDZk9SEyfN8Zo1pYqDGw2oS0MFHSe4WZ5xvKD0RCNFM23mNdo
 VmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348884; x=1770953684;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nIhgBYzj/pMMe7C5ff1M39odY/oil8Oq87UlRR6ips=;
 b=sH6eLZrDo46iT7v0S6LybHNbovOYRvOSeyWIMTC0NKMhw+n2ghlSymGne9Mi7lshv/
 1Z0RyHiKHiFcdx7B3Z191XjlKlop5oaYArD+s/KjYmFQExLiNdLRNUXiYthiQLJw+vEv
 7fNN+Ho45VK/50uQnmkVOQkuPKN3c5sMiihG1sF9Fl3IbmdEehKt/eEctEXG++axKEka
 MA+BX/GZEdYwQDWAdL6hrPPVhyUvVpDd32pSm82Wk8t0vIPav3YkRb9YgIf2M347xWvk
 nXemKNKz8yJlnVmgtKH2blOUY2nqqUYJNxgE1izX81oSLpGTLOo2yZva0zkO/LS7hEjV
 sMpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGrgkyksyLA9WxQRSjdH+AwAoTytexe0hMn6Cc7zBtmysQnbC6EKNvRrcCdJO+LfmOaH5umE9pjw4u@nongnu.org
X-Gm-Message-State: AOJu0YydOK135B1pY5/VPWRSiac4p8i+DQaPxOPuSgNCmEnQ873s2f4X
 RhbuHv1zNf0dJVhxxODsush7G460EVRligcWfHiIuUmQPpvacuNmTzOjArCK7A6oyJg=
X-Gm-Gg: AZuq6aL0jCME+EFMgfzPfQhhAZ1ml5MC8shTSyiMgl2eOCe79SZkeX99wogs30YHpOY
 +MsrfZNUcTcPgjglTn2Qyrm4D1u8aMh+tEKkxuNz9MEH6xS7ssA0antvc5MR4I/almOGsIzK+aR
 pqJ1/K3x79CIEgW6k3/nq4TMm51/jo8iW5fiUXoUnuunhSS/8SG5l+HvJ5SP8LlpqWY8RvW7oKY
 J68c/wHHuBkzay1q30IffQkD23kL4R0IaeLHVoKro2XJRjTrBXSTJJg6uPGvU9l75XOSvfHupis
 aVvpyyZifpIfwgTNqnUBtfNpCUNpO4zek4WvmU8K4V1IlWK20Ys9bzjzKOfOwrW3nBXVKk8GynO
 p2qpuLXSxJPE5mkiPxX+Am/yzUq+PJafUuTazUqgge8s1MOT+v0CvlX97odY3/nXqRT9EJqt1o4
 IbQuneUBN6onrcIVIpHu8YdBDvjoRqZIZzaZErGFx7yZAnMqBEEryUqw5aJBVuuG2GvZ+4Hn8cn
 OYZNq7RYKkNKlCQlRjAeLfdLMF47HK634PGVe+giZ4=
X-Received: by 2002:a17:903:2351:b0:2a2:b293:27d2 with SMTP id
 d9443c01a7336-2a9519beda3mr15502475ad.53.1770348884057; 
 Thu, 05 Feb 2026 19:34:44 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c7a047sm8139385ad.27.2026.02.05.19.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:34:43 -0800 (PST)
Message-ID: <effcf620-704f-4d17-b3ce-1832742bd4e8@linaro.org>
Date: Fri, 6 Feb 2026 13:34:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] bsd-user: Implement System V semaphore calls
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-22-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-22-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
> Wire up semget(2) and semop(2) syscalls to get System V semaphore
> implementation, as well the undocumented __semctl used to implement the
> bits of the interface in libc.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index ca2f6fdb66..6e38007bdd 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -37,6 +37,7 @@
>   #include "bsd-file.h"
>   #include "bsd-mem.h"
>   #include "bsd-proc.h"
> +#include "bsd-misc.h"
>   
>   /* BSD dependent syscall shims */
>   #include "os-stat.h"
> @@ -879,6 +880,28 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>           ret = do_bsd_shmdt(arg1);
>           break;
>   
> +        /*
> +         * System V Semaphores
> +         */
> +    case TARGET_FREEBSD_NR_semget: /* semget(2) */
> +        ret = do_bsd_semget(arg1, arg2, arg3);
> +        break;
> +
> +    case TARGET_FREEBSD_NR_semop: /* semop(2) */
> +        ret = do_bsd_semop(arg1, arg2, arg3);
> +        break;
> +
> +    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
> +        /*
> +         * The semun argument to semctl is passed by value, so dereference the
> +         * ptr argument.
> +         */
> +        abi_ulong atptr;
> +        get_user_ual(atptr, (abi_ulong)arg4);
> +        ret = do_bsd___semctl(arg1, arg2, arg3,
> +                (union target_semun)(abi_ulong) atptr);

Eh?  Does this really compile, casting an integer to a union?
Something seems very confused here.


r~

