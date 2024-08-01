Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9450C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 21:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZdcR-0005wO-7K; Thu, 01 Aug 2024 17:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdcQ-0005vJ-4s
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:45:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdcO-0002kX-Al
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:45:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fdd6d81812so63671105ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722548750; x=1723153550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hc4xtEaiX30Nyl8erbHoU7MATPZiavrbhzAiAwpQ1b8=;
 b=Hg824RMXW2jRkd7BHbC6pelXwhqCgiae1oq1v5GhFNU3lkpS0wrgeIeVya4BJWFe6w
 IkI5OMcOqxBYarD85Jg2DDpeZawGLvmEp8/lyiSyifiHZ98Uh++Z3oyxS/sQ5j71y2M9
 0Lq1YnDWZXzTMIxkg57e351fa9TDlFU7ZBflY8OWksMZ5hBe4K88iD1EqHUv94Inxkyr
 LUmLpdp4m5N2JQ9y3B+Kq0rseiPMbX9mN1e79cfk9P8I6EdrPsXHfiVVWjGL3zeVsmhS
 PBfBRhWS+3VfUqQyCv98aPnqiyTCzSDmDSrNRnmE2SercEbfEjiUPa9PSzLSVnaKxv4o
 CSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722548750; x=1723153550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hc4xtEaiX30Nyl8erbHoU7MATPZiavrbhzAiAwpQ1b8=;
 b=LkLfNvDJC8VcqE5msJfdP+es0WmqgMG3NZPO0x5/MYThd7VnPCsSO/BeHeQOBHQ3/f
 uR97OJoVo/A8F6rsCg/dermesEZBVk99+r8LmmdTSTVp+ih/mwU3idgLXW5ihdYDBAmx
 bGGIpWSzQfYPH1kZEldxKoRLVQeEI2THTGO3UkBknTbHX7wG0DVHrIEuFsZI7JtkIJCs
 82GiESOgaqEg2dHhE5B3gMtF1ADCflEj6TQ/0woGV3LYPXtSGK/qjdxUeSJxTpy8hmQX
 p8wu7E5u/WT/JsjZtmbmXSfgi4U4RTKmaycaIVYNFQIukrK+DhdtMRbZ0K6Z5PA73Ca5
 xeJQ==
X-Gm-Message-State: AOJu0YxhSkxQ4yGk7ONCCHJO3bMX0OiQIuSxCCGhMMsu6iNru+lEy92W
 /gT/wzfTyZOflZJgcMcE493rDCsy4STJci9bONXFE/AZmUQEmpsBdFAe8JEHi9foK4BG07/Oh5V
 l/qv7Ug==
X-Google-Smtp-Source: AGHT+IHW+74B9IiwgpaatUYCfH/jh9MkuwK00Xlu+v+AG+N+z3JE+KMZJzBOCQgjt4FFCSHO0vSb9Q==
X-Received: by 2002:a17:903:1cb:b0:1fd:927e:7d23 with SMTP id
 d9443c01a7336-1ff5737e5e5mr18610035ad.42.1722548749613; 
 Thu, 01 Aug 2024 14:45:49 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ad79sm3576085ad.264.2024.08.01.14.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 14:45:49 -0700 (PDT)
Message-ID: <113a8d28-006c-4ab7-b66c-666c4cc52dde@linaro.org>
Date: Fri, 2 Aug 2024 07:45:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload: Fix pr_pid values in core files
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240801202340.21845-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240801202340.21845-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/2/24 06:23, Ilya Leoshkevich wrote:
> Analyzing qemu-produced core dumps of multi-threaded apps runs into:
> 
>      (gdb) info threads
>        [...]
>        21   Thread 0x3ff83cc0740 (LWP 9295) warning: Couldn't find general-purpose registers in core file.
>      <unavailable> in ?? ()
> 
> The reason is that all pr_pid values are the same, because the same
> TaskState is used for all CPUs when generating NT_PRSTATUS notes.
> 
> Fix by using TaskStates associated with individual CPUs.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header in one block")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Oops,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

