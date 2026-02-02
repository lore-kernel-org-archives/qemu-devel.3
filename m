Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3646CE7DEFA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwEm-0008DY-Lt; Mon, 02 Feb 2026 10:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmwEl-0008Cy-FW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:53:15 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmwEj-0007wW-V1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:53:15 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so606182866b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770047592; x=1770652392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=adV3XGCQoenjTbtR7JywCgpSGSU4EgGQei3eXFrTJSw=;
 b=sRU/k62apo60KYjkrDCGLWW7pVuq5pBBqsXp0ga2K9I7RM2KC7mU/GKJMfg3wcgmzA
 3Kdlz5RymcEv17XEI9/mi0DtlnOmV4ix2aU+2husypbb/gQOSDXFpse9XyXo3j/cmogz
 I8ksTJwr7un7v+sp5DF+PDUtE8tv6hd0ffbFk9mk2L9mz8myJXSG57EFdrLGVIa55lYJ
 u6/uHldvOSqgNc/dWpwseSSuioi+KVuzxtFAWT+mD9OwnO94z5MIAnh5nXDmDq3YVGGt
 ErCzz2MJEaU7fCyN84HZBZ8P1ljyPxY2ogxfuS7t3qy95KJZR44zdeku/lACFzAoTFHd
 3LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770047592; x=1770652392;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adV3XGCQoenjTbtR7JywCgpSGSU4EgGQei3eXFrTJSw=;
 b=YevI3B7dDL58/ZUtmhP7TlUqHg1Ue1y/ysK2nbLw06JtQGX45xE9o6ANu/eCnmVhgo
 obMhDEH6iXoSSswndTj8b46dE+DIv3HMqUhJwCUuakLwGhypOFewsAO+KoF3wkJHSs7p
 JJ7WXsth4XMlxMlh4QQeigWoJJpyLa/F3uSSwppe3mTEC/CxhdFdJvq4BcG4hehAnqlN
 7nIW1Wl1XvzNmd1aohkI+ChINWDLJZbofi0g/8tP5/jRF9YMzENb2fHACvjCipK0J/UN
 80sxPbhB35aSbKkQKVwYZ+nmZiTuUpaO23E8yHIAo/gneNYPluDGGKzQ7kdwK6ltLO3d
 OURQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrBrslNjQdeqm6aRP/UYK+G3L+oTkjBsWYd1ewSK2y0QqIwu4DKjDOgK1ugk3AYGlK4QXmID+u1WVr@nongnu.org
X-Gm-Message-State: AOJu0Yx4ApcaokcweQXSLjmNiZht5GQ/OyVEbUpITPoiRQm4iYoAZF1S
 /uSHk8JNXrc9rFgccpQuT5ybH2w+74x9GhRupjplZXBoilIA4Wz4foDjM+S6Rg2/PF4=
X-Gm-Gg: AZuq6aJvRj0DJ77OCcC0LfU0vP11oviLJ/Vh2sBU3v1fdWlPNDwNDiC0kLEI7FUlW2z
 v05VsaLOH1O+Lavei+sjccyBHB2+vaBv2MbZPL7+vwSjio0ZOli6gEccX+EXG/vaWFrqNKPbHou
 CTXJhVbVRQqkbRbLY5x3RzpmQo01iTNirBxY83+r8KFbVp2sYy1Qvk8EYc+6qX6f3KT2t4P6EOb
 HyvcVk4wOObK5sNtYDYEJ7BqjP1+1LqhyMMPLPJZ7S72KX8x2AEnAdij843M6HlzvjPpCPoUPWG
 JLTXvi3f7vQGahMDyFQfvyflIf/LCXWX9P46EQofGEc4v6hQ5imu35cMO1T+wxhE+7nM3TtyUYp
 aPYGLZezp0ra5tIMv4er3DM2EwNiMMczsYjw0zcSf3gIIv2M4N/YEtL73bx1ps5mgxAzWM/shKM
 OTWQyIVGT+9VfRTCrUOagRGSCxXLehY6Gab66wL2Bk+Mg/f0SXH5pTUw==
X-Received: by 2002:a17:907:da17:b0:b87:9d1d:ec6b with SMTP id
 a640c23a62f3a-b8dff228764mr719604466b.0.1770047591750; 
 Mon, 02 Feb 2026 07:53:11 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b4691e5esm7922692a12.16.2026.02.02.07.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 07:53:11 -0800 (PST)
Message-ID: <b283d771-98e9-45e6-9700-f45d98d01e81@linaro.org>
Date: Mon, 2 Feb 2026 16:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload.c: use get_elf_hwcap2 to fix regression
Content-Language: en-US
To: Qi.Chen@windriver.com, qemu-devel@nongnu.org
References: <20260202054537.2538899-1-Qi.Chen@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260202054537.2538899-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Hi,

On 2/2/26 06:45, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
> 
> In commit fcac98d0b (linux-user: Remove ELF_HWCAP2), the following
> macro is removed:
> 
> However, in place of the original ELF_HWCAP2, get_elf_hwcap instead
> of the original get_elf_hwcap2 was used.
> 
> This caused serious regression for at least ppc64 user mode. The
> error message is like below:
> 
>    Fatal glibc error: CPU lacks ISA 3.00 support (POWER9 or later required)
> 
> This patch restores to use get_elf_hwcap2.
> 
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0002d5be2f..35471c0c9a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -708,7 +708,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>       NEW_AUX_ENT(AT_EXECFN, info->file_string);
>   
>       if (HAVE_ELF_HWCAP2) {
> -        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
> +        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap2(thread_cpu));
>       }

This is the correct fix. It was committed recently:
https://gitlab.com/qemu-project/qemu/-/commit/c333f9c4ee212297f3b9a8a6ef62396a63c48e61

We forgot to Cc qemu-stable. Michael, could you include this
commit for v10.2.x stable series?

Thanks,

Phil.

