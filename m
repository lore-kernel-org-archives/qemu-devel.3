Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75637C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxC4e-0006V4-V3; Thu, 20 Aug 2026 19:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC4b-0006Sv-6o
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:21:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC4Z-0008Ex-Lt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:21:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso332808a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787268082; x=1787872882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tgrl9FGsBX2gHKWmEW2wbhUIJuCCqzVLGOz8ZAg0z+8=;
 b=D8UVtkO4BbC0wRaU+reNVZX+PzbeARZ3y65oDGrWGz+5rtgWzz6BueQkuyMEEVEGP4
 SQcupYbwQTxmabVpCXZaHTJJBNWMwsMoZ3XdzMLiiCY3fJDmWdaW7DBsRXh/Ka3KZVRt
 Vl/jXJEmXOwlfCnZPT+83SWGv4Gg8vtbDYckYp5zxl4JP5SpUeizwQxZqSKP2ZN2Ogb/
 05eo2ZLiZ8TSD068M69hCFuE+iHL4j0bPefMhfUVl5DMvS1c4keug12ycAmEE65WSB5u
 24RoKN4Q6gVktBm3vC4SqCEuUUcwgk5VzY/NcbvcOUJnXSIbqlRX2DYSExYhQZ/b/sAt
 ppgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787268082; x=1787872882;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgrl9FGsBX2gHKWmEW2wbhUIJuCCqzVLGOz8ZAg0z+8=;
 b=mVCiZMcqu/GI8O+MG5pK2jKqTg5gVMczLDmCLUekSAt7ktaV0p14QQf/yS7umeZokT
 s9tXX6biNewOeGuL0MlBoPi1wtBSDehUuK4SywqV7ojLrbcoGGnAHhjaoFIEuv70lC7V
 yQwOqmF236SB6bgT9u7TWma8WQ4efBYeVrSIZD1Koa6ssVsmz/6rbCgPRcp4FA3iEYSE
 TD4OPT+EvwNDANUoSf24ejdLmSuvLvszlg1eILYCEJUiKagMrbHXAA+lf15/e5mSgo+p
 OrVsKzMD/ftMLVHdC0wFHHc8uJrsHvA45VoaJ9NPwDl2HpaRTWPrJ0YINwMvyz4Qkxog
 xCLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPteH0Xr5Vm9nNd9Cf2B6JUbBV6qKiZIwEUNq0Y/jSoIokfz49GsVvZn3VM2bMzOjymUN0TjNHRfLI@nongnu.org
X-Gm-Message-State: AFuF++kCVwuLF4AGK+EnJ0EMRFe3fhS4hd5vHKZWmfEFUex9I9GwTlyA
 OOIlZ5+SLRrGhrtNDL3AvdmYFVzO6q46RzAT/nMAj6eQiDIfS7EdlosbBQ0S4AtT/6o=
X-Gm-Gg: AR+sD13giYqAgSCnoqzwMiowFYX53ZGELmRqLxSiTQJ4h6q4fKwEt2wwV6QT8jGHH8u
 KdSoIVTASF+gtOn5gOUWjbej6LN9ymPHFthV8GmfSgJS5jftlMzgivBSnGRdbuQ+ZdLVnCTelFX
 5sqwkVOZ4eMDIk1Q8iEDEZy1wFx84dIQM6X5Xsmm3t9vo1bPF5HeaI9RN984Vjp6MhzJWqPFpZ4
 wZA24umWuvHKcK7LwIBa3kTwQQCbRPzyTYogrmG2fZp6gCUKVws/r/hPPqHUGTRgBdP5zGQbeyc
 iF2nONoK6KAxogEUPHb2sb12osAzd7bFSTUx7zdw1v4kFo7j7nTOM+G0lUXYBN1ASKymfHrV7gg
 UGKH/8FJzV9hyCG7W5i5sjYQuxB+WUY1v6CrbGKTp5q12rWsEJhpBQMq6ceROuibyfaQSzqhhlT
 dJOMixzDrZObloVj3iTZid9Q19WXpYlnzT1nIBwrja5t30m3AkF69ubpMmhYN9Adkp9QbAos7tc
 4Ikwz+02sq1Qio=
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr3024274a91.2.1787268082091; 
 Thu, 20 Aug 2026 16:21:22 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b635d4sm623899a91.15.2026.08.20.16.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:21:21 -0700 (PDT)
Message-ID: <dc581081-a65e-4946-8aac-c80085b81e80@linaro.org>
Date: Thu, 20 Aug 2026 16:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] linux-user: Uncast void pointer argument as
 Object in target_cpu_free()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
 <20260820201356.29775-13-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820201356.29775-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/20/26 13:13, Philippe Mathieu-Daudé wrote:
> init_main_thread() is registered as Object::free() hook, thus
> take an Object* argument. Uncast the void pointer as such.
> 
> While now cpu_env() accept any pointer type, next commit will
> restrict it to CPUState* type. QOM-cast the Object to CPU type,
> otherwise we will get:
> 
>    ../linux-user/i386/cpu_loop.c: In function ‘target_cpu_free’:
>    include/hw/core/cpu.h:604:31: error: ‘_Generic’ selector of type ‘void’ is not compatible with any association
> ../linux-user/x86_64/../i386/cpu_loop.c:331:19: note: in expansion of macro ‘cpu_env’
>    331 |     target_munmap(cpu_env(obj)->gdt.base,
>        |                   ^~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   linux-user/i386/cpu_loop.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index fe922fceb5a..a0790f3f352 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -326,9 +326,10 @@ void cpu_loop(CPUX86State *env)
>       }
>   }
>   
> -static void target_cpu_free(void *obj)
> +static void target_cpu_free(void *ptr)
>   {
> -    target_munmap(cpu_env(obj)->gdt.base,
> +    Object *obj = ptr;
> +    target_munmap(cpu_env(CPU(obj))->gdt.base,

If you're going to have any dynamic cast, you might as well use

    X86_CPU(obj)->env.gdt.base.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

