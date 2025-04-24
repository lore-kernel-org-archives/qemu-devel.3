Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B0FC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tEV-0000CU-PU; Thu, 24 Apr 2025 05:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tEU-0000BG-CQ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tES-0002wq-EQ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c14016868so736549f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488258; x=1746093058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsXZIYaRmo2+Zyqhkbaujh4Q38THW6hETikCJQhi8mY=;
 b=iVKHhnXOPp7N0HF5Apd+fiwNJDuu3HawmD7zswJohPsa8XQsI/6B/ByRxvFbWQ9zcy
 epQdiwgBtKvqg+HNwQATFP83qxLA602FjpxdlHa/oPDjcG2EhUTFHLKT8zTIGiDlmDz3
 WG+fp+SqmvYeSHepbfmOJjfYiiWqxzcz79Ey2bDgV4ll+pqejYxldxZ5KdlfRCoADQx7
 dzjcfx3lgZZZ37XFlDapJ4JOzrPqb3OeGo8RDpf1+od+Cfgb3Nsp0owEHoRGcFx1R+mi
 bC2Dmf3wZuQop2EivKxk6VjBeJ09nHI/KUyLVJxdVZH1azcs0joI9Mo6MQ4O/s4qcyxv
 IF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488258; x=1746093058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YsXZIYaRmo2+Zyqhkbaujh4Q38THW6hETikCJQhi8mY=;
 b=qVdJBXGTDHrbgT50KX1QpwzJe8dtxCf4dL/Im2NliAUnCp/TwfySkTho5nhdGJK6Z0
 vOLc8O4BgAlJdSRlQeGP7OBSWBHugU3K6bNYCR23OWa0abpdQi+bv/rACl7mUE4hd0Gp
 HAjafXmGlq0nWXzMHrtuaCPDEtlbk05weg+p2GmQI+VuBbuJki4vQGQfIRLl7YsMKBpi
 3W8xhnm3ldquPWPc+mEvYBizw0MCDAEhZea2qNnAMfA4TYW04WCmJUgstOnMzark11TA
 1/TcrpEDoLFJ6BrNZNNCKVIaV/op61Az5BYjezH28NWmqpcSA47tEfJNTqX0nlRbOiqG
 L7Aw==
X-Gm-Message-State: AOJu0YzyWuWmQHrxqUIjSzQ9RHB7kKJ4/mKQOI3YkbJkmlfQPQbx8+kI
 WkmjqF+LclYEcjymkJ0PIs22pHVPM4i3Eex5QxZAPRF88eImaFuecmTGHdXjG3El4k806F3X0vm
 Q
X-Gm-Gg: ASbGncs0+pydYfIFXc8Jb93GXYZ5+ygIfvl8qmbsGG5s7oFe226bCjoZje5ogEXf7UT
 5VbU75KLq5JNtVKkLmhwpzRM0emFlAXYwq//n/wPuraZTggtcJAV2ntryeDXapo/5hPMhPcoAU9
 AdiEvEbwyoVY6pf7kR0jebxqvUJS7MEjn9FBN3FuuGpjqDvn9ExnCBdF/yOxVS4tH3CIw0arD4a
 Op6Bf9Wp4kJ5SWRbW4AYkShyiSdX47L2ng+hI9a4zCzmLRQ+a5gZaX8yXMO6pASo0/MDOvzogc4
 9q33iqz9rVoY8anjlSBvYNYBK02R+0498eBAEHhsUKvVbgGidAo7AxCVjkMlN9x/nHeHUmK6dDx
 RYX4bYRCMeLpypw==
X-Google-Smtp-Source: AGHT+IHAZiuzoSH6MM1swwFuD5jWs322oqZxsZXJhz90ISBIJd7gJswfcXxaop6KqnrqoxG9Sk2e3Q==
X-Received: by 2002:a05:6000:2212:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-3a06cf56518mr1663951f8f.13.1745488257770; 
 Thu, 24 Apr 2025 02:50:57 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54ea37sm1527445f8f.90.2025.04.24.02.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:50:57 -0700 (PDT)
Message-ID: <6b685fec-d024-45ab-b723-1fdf345c65e2@linaro.org>
Date: Thu, 24 Apr 2025 11:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] accel/tcg: Extract probe API out of
 'exec/exec-all.h'
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-13-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424094653.35932-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 24/4/25 11:46, Philippe Mathieu-Daudé wrote:
> Declare probe methods in "accel/tcg/probe.h" to emphasize
> they are specific to TCG accelerator.
> 
> target/arm/ptw.c is the only non-TCG specific file, its
> call to the probe API is already guarded within CONFIG_TCG
> checks.
> 

Forgot to include:

Suggested-by: Richard Henderson <richard.henderson@linaro.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/probe.h            | 110 +++++++++++++++++++++++++++
>   include/exec/exec-all.h              | 100 ------------------------
>   target/hexagon/mmvec/macros.h        |   1 +
>   accel/tcg/cputlb.c                   |   1 +
>   accel/tcg/user-exec.c                |   1 +
>   semihosting/uaccess.c                |   1 +
>   target/arm/helper.c                  |   1 +
>   target/arm/ptw.c                     |   3 +
>   target/arm/tcg/helper-a64.c          |   1 +
>   target/arm/tcg/mte_helper.c          |   1 +
>   target/arm/tcg/op_helper.c           |   1 +
>   target/arm/tcg/sve_helper.c          |   1 +
>   target/hexagon/op_helper.c           |   1 +
>   target/hppa/mem_helper.c             |   1 +
>   target/hppa/op_helper.c              |   1 +
>   target/i386/tcg/access.c             |   1 +
>   target/i386/tcg/seg_helper.c         |   1 +
>   target/i386/tcg/system/excp_helper.c |   1 +
>   target/mips/tcg/msa_helper.c         |   1 +
>   target/ppc/mem_helper.c              |   1 +
>   target/riscv/op_helper.c             |   1 +
>   target/riscv/vector_helper.c         |   1 +
>   target/s390x/tcg/mem_helper.c        |   1 +
>   target/xtensa/mmu_helper.c           |   1 +
>   24 files changed, 134 insertions(+), 100 deletions(-)
>   create mode 100644 include/accel/tcg/probe.h


