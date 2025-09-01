Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02847CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2ln-0008EJ-2K; Mon, 01 Sep 2025 07:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2lf-0008C5-BR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:32:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2la-0007Xh-RK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:32:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3cef6debedcso1807337f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726323; x=1757331123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GO9urr638LgUjRqwzWhN5G3kcWqYn59aypjCcRX6Fo8=;
 b=Cw9rsnzHPcydFXc+ACENeyXZ6CMGx1iUbu0EWyjpHKfNeVFG+9oPs3F/riKWLcFy5j
 Lt2dhctTxsY6QFOZDUKRCCwCncUzSZx5ZR3I8ugB8UxeM5nkoeWbz+vFlWySfpu6sPVv
 tXZZS60YW+sH5HoV59FvQCD/69Dvs0Kqw4kioPAMiifCSDWGAl1kfV6V2LLBEBRrWa0T
 GTy1Abaa7EN4ZwX/54oMH2OiNkBWnpULYoLTf68Awus0IoKIOL3GYZFRdUP3kfpocaL/
 yRxyg3E7HMCJEDvRUUi5LwGPQtH8kp4XEMWKrfDJEmwvrva4JfI2UYqRozABjAcSjRH0
 xhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726323; x=1757331123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GO9urr638LgUjRqwzWhN5G3kcWqYn59aypjCcRX6Fo8=;
 b=D4SxLFgywphu/jFKPPrsZxSAFIC9M4OR7OSmZ2Riv+xzBlBnkzSMAg8xVa2D2tHdSI
 iBnFQOUW32LHOerZABdYpCEyeRwfTSRW8UmUZUrYLVCBpo8nlc+FtE44E2JSWaGxQkqd
 j+p0t8xvvwQkUy67etx2J32PPwhR0N2/oQ+J9T3gr8TbFrnuYJ8JgrcLO2Y0/BcnSuwf
 dN7k1hamVCaSVhkRl67FkuwzT43ntzMI2qSAY4bJUWFkoorUEzaqvfVhrbkT7UtA1PGB
 1hLkUYnFOhFgeh0k/DYtCctOrB9Tz3BkDuoEOGIqzeXJ4mU6PdNMfukoX3rOJUxJYC1A
 4nvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbchn9V8biykbXSTWS7ADilK8hzeNkHEpJs6xN/A9B+zQVHosUrUz7DrvTp8nbqZRWDrJ0Tw1r9prX@nongnu.org
X-Gm-Message-State: AOJu0YxU6vPitIpPuO8gxtbwWnR4Y9YkQVYTNH4tt8Nfolbb8P67wWEI
 LMhxkqysrfXT0tCQXZ0+ve8H3Qvn0nNeUp86JWUSrlrqPnjiPYKS4fh+1fXwW3TxuvA=
X-Gm-Gg: ASbGncuHn0FXhmi80bCbShYpSyYUFW5GwH6xaHnuMR9vxnRQX8FPaYqfLyI8wmF5oeR
 sONYiP3ItTd6VavBVrhjgzH1UflJcf9ow/gx2Dof+c44QtDwASh/iFT6po6dFEf01IhjNdhVBjj
 A/r9PhLPestzTepOi8ZDSx8nvzY24epTicfS6cFne68VLhLPFboebJvm3MsVilH+gdfw625kMno
 tlP7l9KpHQ5YQU7HWGNiILmevImIwdudKCpVBznQP1Pdw9CgJm6QbfWY7wx3t4g/NDVMp27hiXF
 lfLi9AQENsfZEbx0AawefIJXnMGa8beDJH6K060vgqk3/qy7XCdK0yszo7HEbX/96kGIjGXJXUz
 FdLeWVWOy+ltVgcmFwDi/P13CsYw8QWS6M/Iy3SByKTmNnWKbf4rDDwdi4zECrxWMUg==
X-Google-Smtp-Source: AGHT+IHqrYsmnXeXNKWuXMkRIaHp7l4Dah/Z3I5UyzTnvckgPtsoSCdkcKdLTkIY+FbsELxJreWPfg==
X-Received: by 2002:a05:6000:2dc2:b0:3d1:6748:65fd with SMTP id
 ffacd0b85a97d-3d1df34f1e8mr5616301f8f.58.1756726323322; 
 Mon, 01 Sep 2025 04:32:03 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d66b013b7dsm4312096f8f.28.2025.09.01.04.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:32:02 -0700 (PDT)
Message-ID: <f3b29049-af6f-4478-862e-11e649e913d6@linaro.org>
Date: Mon, 1 Sep 2025 13:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] bsd-user, linux-user: introduce qemu_wait_io_event
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> Add a user-mode emulation version of the function.  More will be
> added later, for now it is just process_queued_cpu_work.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


