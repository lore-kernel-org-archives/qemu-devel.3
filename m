Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8267BD778BF
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 00:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjRxD-0002Eu-Ep; Fri, 23 Jan 2026 19:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjRxB-0002CI-Rs
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 19:56:41 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjRxA-0008Pv-5u
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 19:56:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f30233d8aso18588135ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 16:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769216198; x=1769820998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AzUeBI5c2zXrM8Nnf8zOGbWPsXs8PHU7FFXEFxaj10k=;
 b=v7U3qG2N18+4pAJ9prahuqWD8CRuVCFvoWeqzkYq+BfB1n1BhvrGTX8NppWDDMgxG/
 6cMUgwkG0nAlM0k0fn5d5majbwFx0jtiTJbmcklDGtA0ogkk6DVlikM8mmvLPgTgW2HD
 EQyvv87YKzxiea5mMtfWFRgnOGW03+DLPX996PsLNLqeaeqVQ0PRhe1/iOFv27d81scM
 ucjJg2ErorI7fE1Nvct7NNSHA8ByCMtTMneW90qDPvpEOsaPIFqdWzNsXUvdLAxtgx+L
 9AnmeevPSscg4ER/QgsTJaqc8V/JNFP7GaEPQwzYGh6Yle+70BRvofgoI+LILKIGyWhy
 AFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769216198; x=1769820998;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AzUeBI5c2zXrM8Nnf8zOGbWPsXs8PHU7FFXEFxaj10k=;
 b=dvY65yVqkTbkBuOxwO8a3MFv0e87IV6+hHDd+1yuuEgh980uB7gJ8zE07/XxRBcchA
 5Uq7myu6Mu4nGfrBr2/MeiHVTGpDcvNAzQm9oWvNH4EJMDhmLGvj+0HmXTHwS05ZbVfv
 MsFT010mr+pO6xh2XRs1CcjdPJXKknsCUXcOzIJFZDw/G4z7EqBCWeJtnvQwDyronNt/
 EGdKuRnealTuA78fyc3T8wVCZY1AhGQHJIPNNTJk90bFxidCNdZZ2iTXUuJtz8uxr3SW
 z93OLMn8BmNYHTxxCfefUSjHA9OHJ9eRsEAy+6VO/JL07JhXNT8ih57idxNNz++rzJsm
 +wvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK/GADKu2oVigFaAPW60EE6xKKk2JZjsyxDwRPEXP4rnEQXPISPncXkuFD5g1FhxymPdTdZvDYdvhm@nongnu.org
X-Gm-Message-State: AOJu0YxOiDrkJGaykfXEJTmFgOAZ9tGRRMHz9EJ6hVZuoTgCmmwPE3Jj
 W1VGGyGzduZFoF1VhXdd0k9TeVJhd9f1P89JpLzdDkjQRpNj2a/0NJXaxXgt9ES0VsY=
X-Gm-Gg: AZuq6aKW6X7KkGJpe7aFu/Hje4Bum4rteyQxPvRIca2vZEEWxKiF99jt9yY/ZtU0+f8
 IhIoYjKAw9F1PU70n6KABkRuGFC7e/GH7xB1j2ELhrHcrnkIhKdLz5a2YA5ojcydcx8o+knFm6f
 /vFUM8c1cj7McWaRPpo1PN+c+bFIztvgfz+FQ7Ns96hieBlJyNgQEnLaaLTKYzVZE1yE7BxMXjV
 d1gj0ms9a2oddHdFCENKY7YmBh7rw+nojYYFNS/vMeq2h1NkKtOxP/OowMIg0PoZh1qjTPMnWsC
 dibVizz4o0NontOkyR971VTaHS3CywoS9C3x3uk6lcFR5FGyQ+k/cDhxxHVSRtd2X6qz4fI5KXP
 7YexswHpNNiFLv4ZpjYGob0rTInRCLl87eHM8/ERUR50g5Fl9sDfyI4ewn73biqrooBL4nTSmWU
 NuhHClUc8e7SYhpIo5lVUv+BLez3uhCA==
X-Received: by 2002:a17:902:e54b:b0:2a7:dd37:6e20 with SMTP id
 d9443c01a7336-2a7fe614120mr49704085ad.30.1769216198204; 
 Fri, 23 Jan 2026 16:56:38 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f97693sm30771375ad.66.2026.01.23.16.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 16:56:37 -0800 (PST)
Message-ID: <3e8d8cd9-a46b-4ced-959c-f6f4bebdfd95@linaro.org>
Date: Sat, 24 Jan 2026 11:56:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] linux-user: Fix MADV_XXX constants on hppa target
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, deller@gmx.de,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260123205230.33541-1-deller@kernel.org>
 <20260123205230.33541-12-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260123205230.33541-12-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/24/26 07:52, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Older hppa binaries may still use the old MADV_XXX constants for the
> madivise() syscall. Fix it up in the same manner as it's done in the
> Linux kernel in the parisc_madvise() function.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 64a2f1cbb2..2788c3239e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12922,6 +12922,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>   
>   #ifdef TARGET_NR_madvise
>       case TARGET_NR_madvise:
> +#ifdef TARGET_HPPA
> +        /* Emulate old hppa mapping of MADV_xxx constants. */
> +        switch (arg3) {
> +        case 65: arg3 = MADV_MERGEABLE;     break;
> +        case 66: arg3 = MADV_UNMERGEABLE;   break;
> +        case 67: arg3 = MADV_HUGEPAGE;      break;
> +        case 68: arg3 = MADV_NOHUGEPAGE;    break;
> +        case 69: arg3 = MADV_DONTDUMP;      break;
> +        case 70: arg3 = MADV_DODUMP;        break;
> +        case 71: arg3 = MADV_WIPEONFORK;    break;
> +        case 72: arg3 = MADV_KEEPONFORK;    break;
> +        case 73: arg3 = MADV_COLLAPSE;      break;
> +        }
> +#endif /* TARGET_HPPA */

Build failure:

https://gitlab.com/qemu-project/qemu/-/jobs/12848016272

> ../linux-user/syscall.c: In function ‘do_syscall1’:
> ../linux-user/syscall.c:12936:25: error: ‘MADV_COLLAPSE’ undeclared (first use in this function); did you mean ‘MADV_COLD’?
> 12936 |         case 73: arg3 = MADV_COLLAPSE;      break;
>       |                         ^~~~~~~~~~~~~
>       |                         MADV_COLD


r~

