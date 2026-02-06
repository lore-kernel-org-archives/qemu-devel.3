Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11377ECD9BE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCDO-0006mK-PI; Thu, 05 Feb 2026 22:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCDN-0006mC-K2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:09:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCDL-0003dF-RN
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:09:01 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a93210fcc2so1686445ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770347338; x=1770952138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yUbEx6tu8H6xfY+P9ys9g1iDB4fNhn4oZ7DEeBYj3ig=;
 b=d+ipgNnP6caqBFswoFZJnPX1MgtMUVKjE/BOmiFE26s2cUphE0BYQTpjqo9KTWtTRM
 3iQ5Dsj1CwE3ucn1pTqth9eVfCiW5X+yS9u6LO5t8FxyN47QUqIkmvH2P+LYPYq+HObG
 CRNXCQS1B4fo/YRx5St6YxInEvLkh2p+3YpM141IFhKh6sv6cQwUB75aFKDO6HDdE1iA
 gKw3bJZJ3j3I4XSyCkexOaFtM+PaIxMwMC0m1S2Z9NbktIKxt1pow5SAl86ayXmVPwBs
 DjdBLYeOMjoLuxyT4QenRDd2eLnN/zbZWGtNkIElideAPynn9ZSb3FTbII4436N0Q0aB
 1c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770347338; x=1770952138;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUbEx6tu8H6xfY+P9ys9g1iDB4fNhn4oZ7DEeBYj3ig=;
 b=ky7XvKIJOuQLBHL6Y+zDRP8Hc1abWEUOuSFX5Q0j9N9N/biSxIDO+QXQaDDTKCYUHO
 NqJ4bzx6Yagu5YQXFnT+cmGj1cLFMo2bBck+ei1vIIzKC0+Y5RIr//1rueGilVHLraHM
 VX/URWaSn5Zyd1OfWgW7lEjcjmGVwZlITy+p8YlpaxiHyk+Qwbdsy4WqzLMVijgB9JK+
 Zu20op3tm9F/wfVQX0abciuNtINkUi40rqPMQKa09Gxfv2DqbzJNO35UDCOrgkt127xQ
 0CiZBBmGJNgqo6LMNre+hSq8EyAdP3Rs0hfP9BWBjKERShZmdCYxyMs9qoTlLK6aQ2zP
 1WXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURWZiDPMO9EKOmIsJCAzuFYRIldaMf4tfS9/PokscarfVpFQVNHNPxspcUdOMDYolw/+VL1tZH8ftZ@nongnu.org
X-Gm-Message-State: AOJu0YzpZH5VhozcUX6AlUG+OnltgXqwIYDAnTLPMCxmkm9f1NZNg4NZ
 e9+MNA600gQIhPwh07yhIk2ubDtw3TH996oxytp/SuodYz4aWE+ce0QP/NbiY3E7BQs=
X-Gm-Gg: AZuq6aKZE1n5BoukWqsxipbw7iIAn7bSNOrDaDVE1Yey3n1pQH5tvxzuaaBpCqWhP3K
 BWyl9CTYiQPYpC6JbuEnswvCpEHCsBPD3ZANZh0KJReuMKBKiHlm7dFX+M4Ytd6zSCmrdpUyw/L
 U2UNn+2rzJNrGVtZTnFgXEecPKFZ888VYn8Tr1s8h08a/A9lFiXy6XW2fZ7LH0auaRvehoobHUB
 4sp1Pyl04IZtgQ5/IC5etsh5zlv13NwH78CS0/xS/Kt3QAvxCWDJOYy1PaL78nvKimAhPuSjvYg
 QfR3mIMW5ymooPYPNeX6Efnxx5DnzhBCgBIXxIiQRz6Sct1JcqlW9Ak8u93kjClYToMa8KXpMzG
 v7fnTNI/Dm+fJa6IB5flwWUe03Uq+wXHMCZUb9ddwBU8tyNDbbFZCvb27NQEZfHynPAugCEFWBU
 9NPJ1Gtu2bJ4fgeftWjZdTcSc1ATftoZLcKEdA1qFCENGdmOhMa3G+wKiMSeYAmIeX28vxjLA1D
 zyESC+X/dt9NCVS2HlF+m0lvoW23R9OEn+6+y8gUm8=
X-Received: by 2002:a17:903:3d0e:b0:2a9:484c:ff19 with SMTP id
 d9443c01a7336-2a95194a492mr12853315ad.42.1770347337700; 
 Thu, 05 Feb 2026 19:08:57 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824416746cesm684989b3a.11.2026.02.05.19.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:08:57 -0800 (PST)
Message-ID: <4c338621-eb9e-4048-9f1d-cb4f3ab6b259@linaro.org>
Date: Fri, 6 Feb 2026 13:08:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] bsd-user: Add do_bsd_uuidgen implementation
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-15-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-15-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
> Add implementation of uuidgen(2) syscall that generates UUIDs and
> converts them to target ABI format.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index d81b4fbaef..b722c63437 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -43,6 +43,40 @@ static inline abi_long do_bsd_reboot(abi_long how)
>       return -TARGET_ENOSYS;
>   }
>   
> +/* uuidgen(2) */
> +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
> +{
> +    int i;
> +    abi_long ret;
> +    struct uuid *host_uuid;
> +
> +    if (count < 1 || count > 2048) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    host_uuid = g_malloc(count * sizeof(struct uuid));
> +
> +    if (host_uuid == NULL) {

g_malloc will never return null.

> +        return -TARGET_ENOMEM;
> +    }
> +
> +    ret = get_errno(uuidgen(host_uuid, count));
> +    if (is_error(ret)) {
> +        goto out;
> +    }
> +    for (i = 0; i < count; i++) {
> +        ret = host_to_target_uuid(target_addr +
> +            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]);
> +        if (is_error(ret)) {
> +            goto out;
> +        }
> +    }
> +
> +out:
> +    g_free(host_uuid);
> +    return ret;
> +}

Can be improved with g_autofree instead of goto.


r~

