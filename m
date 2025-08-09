Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04956C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uksxl-00039S-Tp; Sat, 09 Aug 2025 19:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksxR-000384-Ri
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:26:39 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksxO-0003ze-KO
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:26:37 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3e40ac40940so15247845ab.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754781989; x=1755386789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LMVnD/fmqI8ngGOzT3fLx/jfKcutYsIymIaFu+JKAXQ=;
 b=ScFCvvp1W/fHA6Je8jVaD/Sb8GM9EGuUCks2fMnKibLqPvWS1cpGerMnkxKCEd0BHm
 L2sjRDFCfggxBw8X1/2a395l/hTSyKb6c3Nben6CZQrC2VzyQxnW8AZB94z2hKddrRcy
 2108MvAonkefwjMihrn0FmrtVRcqXtk66KWv747D5XWH2jLhiRp6GOY8bQZ1N+uD8/IH
 NxHqZQJYudDOR4l3xsZZ40x/PDfEOYZ9YuqaRplWOz1pSIwhlSHDecLfDOqIla8cCE1J
 JgN/BatG5ysjN5qbTy5ezVYI2ipAHKNfeDWq2Ky2RGpaKXDA1b2y2auABIljRx1zvYqi
 rKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754781989; x=1755386789;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LMVnD/fmqI8ngGOzT3fLx/jfKcutYsIymIaFu+JKAXQ=;
 b=lAouvfJ52PxEy0HT3TXcImYWIiX18eEcxBRzireFlmavDUod/rbapjYIJDz1TJPekL
 Lzs9iAQEKiZGh/1PhHveh0DhC5lHkscLOMeBsbmJCqHCXW026xqMGaZq031QQ61cmfvm
 udZERcSVuRxaaDOsCFWM/w5ryIOIxQeT0ZvrHWO4mkaNUMKK8wQ3AtFPOavGZPW9A7h+
 +MnLG7WmXTq6Sz0ZIQ6u0ZWb4kq9vUzMhEERE9cI9qLgunzkY6f2UDH/c6O11nOYM/m+
 vsfaYEbyLVZQVzcKp4M/V9/GWlWDHRP0g3TfuJrD7ip/hKGmHBDUcm0IwfhdlRXYGt4t
 Aepw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpEkBSFrKf5C2xmbw/4Uy40DT3mgZCkYeGa8uqsUYzMONmFSDfmevPTauZS9tjs1Rq7x3WU8xJB5k4@nongnu.org
X-Gm-Message-State: AOJu0Yxqw8fQRObIy45QNyqfIgAEdQmAPW+Iczdnobd7Lm6etJlQaDPo
 VZVaCs7/pwgORXOzvSs4S0PNpFtPN+FF34+fMCXvC0vO6tK4RTuBcqcF/yXWiqDJFDg=
X-Gm-Gg: ASbGncuppgTzeb/cdyg+AJvimLf+ufSH4cuRqDN6rJ+kCTojBlpgLJ6DQCyIazbdHDQ
 SQmyAwUyHeVZPsnCgjuHTQDvwVYu18jqpPyzb3neXFnC1QgRleYwyzl3FYR7HAp8Ve/CnJ/us5j
 +nEZlNgpV27OO7RZgSH4pBrLQdFTbZX/RXv9gPst3ZFz4O7Ky8Wm1ABVmYQuwOveMC/WLgUAUwP
 vQ+oreuivY2EETdl6QaxXOO9XN12WipOI0NZYDxx8r//jEgJVFh432kcT+JBacZEfv02Fop4bDz
 URetsbZjvzkpUggzIuJ2y1F9tqFM+6OLkW5rsFLx+J9MxiXXSN3HWAzOISLZN71Sm06B9vfNfje
 R0rEtX/ZC75Pvuglj+MyhBySgdE7sZlVomxmctmLRdpbO7cZsFMoWY9jFb1Swxsy3sSN5p6/yba
 qSn3nNfuTtt/xtaib+
X-Google-Smtp-Source: AGHT+IEvNWACknqItZpaq+r1ODrlvg/VLHgYnItB78EQeygV79b3i5waB62RKhrYC2X9XLRS6cUcFg==
X-Received: by 2002:a05:6e02:1486:b0:3e5:4287:2bcc with SMTP id
 e9e14a558f8ab-3e542872e0emr33793245ab.5.1754781988827; 
 Sat, 09 Aug 2025 16:26:28 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae99cf0ecsm1357861173.31.2025.08.09.16.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:26:28 -0700 (PDT)
Message-ID: <d7923560-58b8-4967-ae2b-2cabf5dfea7d@linaro.org>
Date: Sun, 10 Aug 2025 09:26:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] accel/tcg: introduce tcg_kick_vcpu_thread
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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

On 8/9/25 04:59, Paolo Bonzini wrote:
> +void tcg_kick_vcpu_thread(CPUState *cpu)
> +{
> +    /*
> +     * Ensure cpu_exec will see the reason why the exit request was set.
> +     * FIXME: this is not always needed.  Other accelerators instead
> +     * read interrupt_request and set exit_request on demand from the
> +     * CPU thread; see kvm_arch_pre_run() for example.
> +     */
> +    qatomic_store_release(&cpu->exit_request, 1);
> +
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
> +}

So, now both cpu_exit and cpu_kick set exit_request.

You ifdef this out again for user-only in patch 7, but this does suggest that kick and 
exit are essentially interchangeable.  You rearrange things a bit in patch 6, but it's 
still not clear to me what the difference between the two should be.  There's certainly 
nothing at all in include/hw/core/cpu.h to differentiate them.

Should we instead eliminate one of kick or exit, unifying the paths?


r~

