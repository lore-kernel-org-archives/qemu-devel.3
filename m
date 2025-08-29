Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925DBCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjC-000681-4E; Sat, 30 Aug 2025 11:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Jj-00079B-Jq
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:11:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Ji-000865-0s
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:11:31 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2445806df50so21207275ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756505488; x=1757110288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBgbeqmakXJZ94NcJp1dL0IUXP+TER7E5qmbIvunW2c=;
 b=OHSMD2Y3hE5VJpR6L6kbM5UOCw9Wt9S5bU6/8XgNtHGINRNpNf3QlC8S1xfigSRP74
 SwSOJr2OjPe1LWPqTELMqtkcjw0OtEdzx/5pXqiYWnz3OlQX4HBVwU9eIeHjQHdrV3O8
 LjUnId+qqZ89pgjHZDuMpsLhaBiSlSBj5TbbUtMwMz/kpVGpbnVKZQ9sGYCg8qHqQRFi
 Jhuz/Ft7k1h6M1/77f06fIvpwQaWFMX2PZSauZwMR4xrcZp5T8npngkemqE7z6bWB1ez
 +6TLpwjvWbuutLCmXthWM2LnK/NG2CQrVCCSgvHMV1mw4zyAeF3T2X5t7MVLNAbT/RP8
 7gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756505488; x=1757110288;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBgbeqmakXJZ94NcJp1dL0IUXP+TER7E5qmbIvunW2c=;
 b=KX9g18msDIAOaAS4HTRGjl8yNDGCijCbdi9wdD67e6hmDCG4f0gQFbcgARDdmxepe+
 dUod7DWARZY2u9ARThtQ8suUnSrR+lzEfpq49V0f7MZIIrfGvnvipNIPqxBbknq8UxT1
 6xEIF4NvzDmsHV64iVCx4tQz1L9ANbl5gpM5oSCZtxLByIVPCBwY3ICtpW0R0+fIGD6D
 AVH8RBWlI5Mtmu1gaXtFbsp9ShPc0kzD8lIiTVt8zgv37j85sdrQsWO8FFndMjx3VuWW
 mOOOH+2VEqWJa5oB5fjSVnL28ZwtY5/3GLXWD8BewqJdrYQ3gCK4Vgoj5gQcgBIhf/yt
 1BOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiNssexcGyMcqS+hMfv7v2Wy+otVge9fNSOF0vgSmbMNHX+P/gsSraX+XOzqYOEkLP35MKxBMx/d/s@nongnu.org
X-Gm-Message-State: AOJu0Yx5xVy22kPemjV3pgSQwI6beFZ1Cb34fU+6oQQb+qhWPSSbuCSx
 lZTg481E2Ed/QprH2e7W/pgJjsgU72xLGR76P5OyEFLx/xORr1KGN+19BzkQI+B452o=
X-Gm-Gg: ASbGncvYFtXhQpRpdlqpvZliXVBK9+k/sVJmXFEhAsFqhK8aZDLhK41CWqxfhfln7+x
 ps0g9nRtVP/60qvtm0pP83bIrLnZjk3lJx4zz2dQ7F4IkmXY5biSjz2hdcgVSRRje5L+jwGIMVg
 RONDG3T5M4yALzPE72T8FdU29JWH0GBxRkbJpRk7SR5yMdD3vWiUpwsyqCDDKSQm04xJltU3U/W
 Wp6mEjOuX2oO58RN+6Qz3qb+rff/Xdg4Ar94ImJzt+aMh0BCM+WQh4heZEGhhSV7r5pf2uc2Lkt
 Cy49S74qTKeipeSYgoxRjVKuQXN4+Fpv5T5R92PObC7sQhWwfWhcG4Oasm5fTng0QpB3fCG3SVm
 eEz5S79PtA+v9IMrGqtVGdzyFF5ez+rkqAGIPp4vfr331PvnUbK/VUkO+vazHAAi2W2o7vvzh
X-Google-Smtp-Source: AGHT+IGr5EM3eq3hqL35f+cFtM83sGm/I/fkqvb5kPaBD5iK65HQipxIzqfICuozLg1CbKG1zGqdGA==
X-Received: by 2002:a17:902:f549:b0:249:19b0:d3d4 with SMTP id
 d9443c01a7336-24944b63e3amr2125845ad.52.1756505488331; 
 Fri, 29 Aug 2025 15:11:28 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249037223d7sm34018435ad.32.2025.08.29.15.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 15:11:27 -0700 (PDT)
Message-ID: <c673489c-f0fc-4ddb-8b67-0db8b39c5a49@linaro.org>
Date: Sat, 30 Aug 2025 08:11:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] bsd-user, linux-user: introduce qemu_wait_io_event
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Add a user-mode emulation version of the function.  More will be
> added later, for now it is just process_queued_cpu_work.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   bsd-user/aarch64/target_arch_cpu.h | 2 +-
>   bsd-user/arm/target_arch_cpu.h     | 2 +-
>   bsd-user/i386/target_arch_cpu.h    | 2 +-
>   bsd-user/riscv/target_arch_cpu.h   | 2 +-
>   bsd-user/x86_64/target_arch_cpu.h  | 2 +-
>   include/hw/core/cpu.h              | 9 +++++++++
>   include/system/cpus.h              | 1 -
>   accel/tcg/user-exec.c              | 5 +++++
>   linux-user/aarch64/cpu_loop.c      | 2 +-
>   linux-user/alpha/cpu_loop.c        | 2 +-
>   linux-user/arm/cpu_loop.c          | 2 +-
>   linux-user/hexagon/cpu_loop.c      | 2 +-
>   linux-user/hppa/cpu_loop.c         | 2 +-
>   linux-user/i386/cpu_loop.c         | 2 +-
>   linux-user/loongarch64/cpu_loop.c  | 2 +-
>   linux-user/m68k/cpu_loop.c         | 2 +-
>   linux-user/microblaze/cpu_loop.c   | 2 +-
>   linux-user/mips/cpu_loop.c         | 2 +-
>   linux-user/openrisc/cpu_loop.c     | 2 +-
>   linux-user/ppc/cpu_loop.c          | 2 +-
>   linux-user/riscv/cpu_loop.c        | 2 +-
>   linux-user/s390x/cpu_loop.c        | 2 +-
>   linux-user/sh4/cpu_loop.c          | 2 +-
>   linux-user/sparc/cpu_loop.c        | 2 +-
>   linux-user/xtensa/cpu_loop.c       | 2 +-
>   25 files changed, 36 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

