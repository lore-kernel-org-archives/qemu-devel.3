Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDFCCDD0C6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 18:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3JXY-0005qa-Lg; Tue, 22 Oct 2024 14:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JXO-0005pn-UP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:23:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JXN-0001SZ-1A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:23:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso4377892b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729621399; x=1730226199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+4KOQbqBYBUMkT0Ly5YuoP3T+8Ia6XwmJMrY0/+2vc=;
 b=iKNllS6iP3P5PDLY7h8J580PEOduOqkXjHLnxW/3nItR8DMy3RPsoON55tEU6+RBAn
 QSVYsKVBHQCMNj614WA1Ni9UuFwzUWRV99nzl0XlMaLRCYFv+vEO9o01rsKFTfD+daCC
 YCbDOV9IFAplPZLUHMGLuKu2qgBoPAsGt6f++1ZYoRoQkvPyYwVb1zJqGkH6YAkUgugD
 FcsErsiFd58vAdompY0NhXABozg7tWxF5BacdC5wCTUk4HB4AQGq6oC3YtnDcfgTapBH
 4cHLM03gCFoFmYrbPymM5wIwViHVmwJOn9jebXHBSHe/DcRUn+WhjMHGh1OLWJ+2Ia/0
 mFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729621399; x=1730226199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+4KOQbqBYBUMkT0Ly5YuoP3T+8Ia6XwmJMrY0/+2vc=;
 b=wMnkcBBfI+IQIOISFlyrrkN5+BPpVEBvIK+r/kVOgJLWWcfiwAKpPhJVOk6F+LNYuy
 ebBb9TYKkVkrE4kUwgUa6G+9QTQ2fIqnpCnCivUOtYzBNQ1D9oTaAJmod0NGvyptr4ii
 a/p22DEKzfcYZP36CDT7VkBBLlIRNmzX61lUDskrs6nRXPpQImAGpa5IeD2kBNyWJNjs
 Qm3BXClJsMSYjq/Sv8SnwSlw+BAsQzf1qaBqukBiXMlswBP6Ha1jkDpp0MFxC/ZVpJI0
 NLHNfTcOuLqe7uzfMF/Y5uXNke3U9VnbglUoIa8WfLx0sDjskdhShgiViTmVsGbS2rCM
 keGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWKmu+m+4RILOBQRLIx6LH5j53BNIaFLn19bfDpap8mDCsJgsrotAOocUUzA1bimbrTGSHXfNuFkaH@nongnu.org
X-Gm-Message-State: AOJu0Yyehb6k43M5aWHk4ZfCH08+N3uFScYM95tiF5QhvLUN36S6CuZu
 xy7V0Tv5ozcUuYT5vjNxMxs8tfLrKPbuigsy5A7WXY7vC4UQL6GsfJWrUtx/C0A=
X-Google-Smtp-Source: AGHT+IFs8sK5N2FJmS5U34+XvOwls4PNRZUa9IxDcb39w8JK7noLT0AICe+T3vzygQFJNWmLmsgkDQ==
X-Received: by 2002:a05:6a00:c83:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-72030a49e82mr211901b3a.11.1729621399248; 
 Tue, 22 Oct 2024 11:23:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13ea1a3sm5218339b3a.149.2024.10.22.11.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 11:23:18 -0700 (PDT)
Message-ID: <e1b3b627-ac9d-449a-a6e2-3e2e613af068@linaro.org>
Date: Tue, 22 Oct 2024 11:23:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: Fix definition of
 RISCV_HWPROBE_EXT_ZVFHMIN
To: Yao Zi <ziyao@disroot.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241022160136.21714-2-ziyao@disroot.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022160136.21714-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/22/24 09:01, Yao Zi wrote:
> Current definition yields a negative 32bits value, messing up hwprobe
> result when Zvfhmin extension presents. Replace it by using a 1ULL bit
> shift value as done in kernel upstream.
> 
> Link: https://github.com/torvalds/linux/commit/5ea6764d9095e234b024054f75ebbccc4f0eb146
> Fixes: a3432cf227 ("linux-user/riscv: Sync hwprobe keys with Linux")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   linux-user/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1354e75694..ec1a77f23a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8943,7 +8943,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>   #define     RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
>   #define     RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
>   #define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
> -#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
> +#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1ULL << 31)
>   #define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
>   #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
>   #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~

