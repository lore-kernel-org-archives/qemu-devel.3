Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D38AD75BD8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE33o-000303-R9; Thu, 21 Nov 2024 04:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE33j-0002yi-26
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:01:07 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE33f-0000aa-QZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:01:06 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53a097aa3daso508685e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732179661; x=1732784461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZpECdcL90k6HY/g1pnGGOGdl1tox4TFKO/WsKkj1Nis=;
 b=R1bCcPtr4FHeJypKbkg8Xbgdod3RpZNeINYMNvyTKK4f9Bq+lSnuKyPCCyljIKW60V
 C0EIxFeiG3rP6ydwjGi05RfsA/MruAoSXK3No5KRck/b3UsGwuvUyOOUjI4LnhB4bBn9
 lvlz0fdSvyawGvl+wLWayWsZWopxEBebnHNtBtamhvXr7JQPFk/EibEkeO9WH1+Cty7v
 C9PXw2d41CAqQpFcfeLuf8Qm/ATtN22xKNPeK5FwB9iR97//OZTAGP/dRAkov7Xu6oJb
 i4zabxbQWtBSmOghGssK/RecwmA7BIendrE7rUP1SPU+Lr9g8qtsRmFmXU+C/6bGgVAU
 SB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732179661; x=1732784461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpECdcL90k6HY/g1pnGGOGdl1tox4TFKO/WsKkj1Nis=;
 b=Dtkd8+nIcX1rzq1Ol+2GO9Tfc8LHgjBk9tQ4cpTtPsOqBdMZfAaAlm52V8P6TP1noV
 Q0Nqebba72HsK/pNZ9flgDF8YSwhp2Tir7vr1UIPK2PqWhfPxMP+rkuJLP0edCYTTRvk
 B2OJp2tjpQpKPr9M6U1Q68YFG+pq69lVj0q3FxjPFWZOIxPo3srysrwrDRFBl1OfR6Kh
 Z1QYXxvxYqSuQde4vo3Gqwea66T4YLclsNAjqX+b5bLGGnVWUD9/A6dRehnPzFwrteiK
 y25l/OahEaQq+OpoCtJKAmrtse22aZ3JqBTIQZEI4t53nx1/S/FVvE6yTHouwy1BlVYO
 /+Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtRkgFBQcMnNRiQonbePxRra/Ez4K7dpHlAS+IUjdD6te4u5AFie1AVCQrBXsbKIp8COZuQ2gK/LXT@nongnu.org
X-Gm-Message-State: AOJu0YyTSzNvrnTYq5hsd2uJhxHFp8+wrb0A3ucyNEMCeVXIjyKUDOEp
 LF2Tk/nK+HCPOD39Q1r5NFB+6DMBk7BYjk7+Xa+pz8HrpJHiocNk+xnbMq+OSPI=
X-Google-Smtp-Source: AGHT+IGiASeqBGvdyPyJCT0SSF+YZYiiUdU769DT4ihcqGlN+mBNpcuRDbLbn6I6hpv6aWHBabpJ0w==
X-Received: by 2002:a19:6453:0:b0:53d:abc8:b6dc with SMTP id
 2adb3069b0e04-53dc1327e39mr2505531e87.6.1732179661162; 
 Thu, 21 Nov 2024 01:01:01 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4c68sm46281495e9.22.2024.11.21.01.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:01:00 -0800 (PST)
Message-ID: <faeded70-af8e-4c3f-af1a-0bd1e11f5394@linaro.org>
Date: Thu, 21 Nov 2024 10:00:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix strace output for s390x mmap()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20241120212717.246186-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120212717.246186-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 20/11/24 22:26, Ilya Leoshkevich wrote:
> print_mmap() assumes that mmap() receives arguments via memory if
> mmap2() is present. s390x (as opposed to s390) does not fit this
> pattern: it does not have mmap2(), but mmap() still receives arguments
> via memory.
> 
> Fix by sharing the detection logic between syscall.c and strace.c.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
> v1 -> v2: Share the detection logic between syscall.c and strace.c
>            (Richard).
> 
>   linux-user/strace.c       | 2 +-
>   linux-user/syscall.c      | 5 +----
>   linux-user/syscall_defs.h | 7 +++++++
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b70eadc19ef..9c55f39b095 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
>   {
>       return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
>                              arg4, arg5,
> -#if defined(TARGET_NR_mmap2)
> +#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP

We still want to print for mmap2, so:

   #if defined(TARGET_NR_mmap2) || defined(TARGET_ARCH_WANT_SYS_OLD_MMAP)

>                               true
>   #else
>                               false
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0279f235768..1ce4c79784f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10588,10 +10588,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           return ret;
>   #ifdef TARGET_NR_mmap
>       case TARGET_NR_mmap:
> -#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
> -    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
> -    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) \
> -    || defined(TARGET_S390X)
> +#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
>           {
>               abi_ulong *v;
>               abi_ulong v1, v2, v3, v4, v5, v6;
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 0e08dfae3e4..faad9147c91 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2766,4 +2766,11 @@ struct target_open_how_ver0 {
>   #define RESOLVE_NO_SYMLINKS     0x04
>   #endif
>   
> +#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
> +    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
> +    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
> +    defined(TARGET_S390X)
> +#define TARGET_ARCH_WANT_SYS_OLD_MMAP
> +#endif
> +
>   #endif


