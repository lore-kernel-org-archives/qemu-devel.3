Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB08CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1YY-0002IN-SC; Fri, 29 May 2026 14:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT1YV-0002I6-E4
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:03:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT1YT-0006pi-QR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:03:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso8160015ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780077811; x=1780682611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HQsth37jZ7WhOvCLf3JiWKwlAyFrWcy0VMD8TWm+aHI=;
 b=RiSHvYRD7XyX+j1d7B96yttUzS+Y83eNhUJTmgHbq/H0/r/aSEms7iN05g0d13iuDZ
 gTENYuyfDagkFjQW6cryMWyTWwhUg2i/2GiK3qI8XIYtsGnZFhxLLRI1RccteK7Mk/ym
 Eb1fpERrAjb8vc3p4MQmJDGUzFGlfPk6NaRD2jzNGMpGl1q2SJZwf54dnc1flCkQgvPD
 APcUnZHxQIBESm6NbNxCXa0Tnag5KJr7xZOdWhEn3lSWxXEF9cK//4rHRuMOBMqYaVQh
 ggfGrFiHVA/NSu6AlTS4JY3xou818eSQ59Ew26lbKi5veskEGFH4+1+vW66d34kBVyC4
 SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780077811; x=1780682611;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQsth37jZ7WhOvCLf3JiWKwlAyFrWcy0VMD8TWm+aHI=;
 b=rm17Fp8uTGqKrDORhWVfMKmRXkoSuk9GDghJMWt8qkkXHQ0bSmWjIST55ltPn2bgRa
 fqmulWA4Lp0QJMEzkhs4bS/670Hkq9oO6XZapLl6PVOuHjz6lDXaxeDuhLz3vU92P1W9
 UFNLw8Ne72UQbURKx90QLJ0CfuY2CI/Blph0d6/aSN0/3NtDSXmhCNm0rF4ZUDy/jokE
 r+l9bpXfrKXIaW6uE5a6BZD03Vkt5PHlsDUmsvrbpHaGK1UIgZ5oqbplaLDEdrhJsJqy
 mLpgD8T06nKHiUMAyXHtufnWWs+hxUUlGFPfft7My24q4nJwwnrDhv4oMYSzKtSsc60f
 cPsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nYE0MCMr4xjeOJ0HQ6arL82w2F0kexO+SXbnvP31PsNkgX5yLcItv5arIUFjFovHsG/fjON1ZZc6I@nongnu.org
X-Gm-Message-State: AOJu0Yx65RmBb0oA/xlhTu0cCe8Rr9q9ISmGoBlbX0WHsuqstzSylWfs
 CWuUDqH1HH8r34Xn5CDgKW31NH7e+gKXH7nKe5aCBTr+4qTlVAccovRUvV9BhJeL+A0=
X-Gm-Gg: Acq92OEmhTItPo4ugPsx6scosZZWXtStwYSjxkOCDpgz1M2A9WHqUZWPJGxsfSItY+j
 Wm51phrkKClu2ZKbNs/hoxN+oM4WPVmh4XyG7Mfnu8Mco2sHnCIyb82geWh8P5EuOHBR4n1eupD
 khCu/zO6pbd5VfnmNoxYWfXXvAJ/XTDR/ge02KyqUaJmLgPdstZxjvnXYNE56j0As9sOB5DAPV1
 JdV57RQ7JIiuDEGJk1lrhHwJEIAk1EHm3ct30aFpIWN8YnBKzF0U4PHf1I8s0jwPpazHGJZeDus
 XvG6RZRhV3bRc/AIW3ZEdoUtVX2j9TFmr22ayd8VMupzpAqvoXShIwo1WIpictu04kUiuzVnyiG
 w9BQhx04qsmj2rLeaSIG2iPNZTbIXULmC/rDw6l+wXRYYhrbNP27D2RCzW4n/eaWTZ0/PHIavB0
 KmyM19h2sWaP/E0np1eGBsJrCjUHIkvtciBonrsYsEohqO9Aw=
X-Received: by 2002:a17:902:e54c:b0:2ba:4e84:966 with SMTP id
 d9443c01a7336-2bf368ad611mr9916935ad.36.1780077811211; 
 Fri, 29 May 2026 11:03:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e7483sm25152255ad.14.2026.05.29.11.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:03:30 -0700 (PDT)
Message-ID: <01c2c74f-eea3-4344-8f47-019eb8693f5c@linaro.org>
Date: Fri, 29 May 2026 11:03:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] accel: Remove need for AccelCPUClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260529142434.87880-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 5/29/26 07:24, Philippe Mathieu-Daudé wrote:
> Move cpu_init/realize hooks from AccelCPUClass to
> AccelOpsClass. Specialize them for TCG in TCGCPUOps.
> 
> This drastically simplifies the need of per-binary QOM
> types per accelerator per target (see also the nice
> diff-stat).
> 
> Based-on: tag single-binary-20260528
> 
> Ignoring checkpatch.pl:
> 
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      accel/accel-target.c
>      include/accel/accel-cpu-target.h
>      include/accel/accel-cpu.h
> 
> Philippe Mathieu-Daudé (17):
>    target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
>    accel: RemoveAccelCPUClass::cpu_class_init()
>    accel: RenameAccelOpsClass::cpu_target_realize() -> cpu_realize()
>    accel/hvf: Remove need forAccelCPUClass::cpu_target_realize
>    accel/kvm: Remove need forAccelCPUClass::cpu_target_realize
>    accel: IntroduceAccelOpsClass::cpu_instance_init handler
>    accel/whpx: Convert AccelCPUClass ->AccelOpsClass::cpu_instance_init
>    accel/nvmm: Convert AccelCPUClass ->AccelOpsClass::cpu_instance_init
>    accel/hvf: Convert AccelCPUClass ->AccelOpsClass::cpu_instance_init
>    accel/kvm: Convert AccelCPUClass ->AccelOpsClass::cpu_instance_init
>    accel/tcg: Convert AccelCPUClass -> newTCGCPUOps::cpu_instance_init
>    accel: RemoveAccelCPUClass::cpu_instance_init()
>    accel/tcg: Convert AccelCPUClass -> newTCGCPUOps::cpu_realize
>    accel/tcg: Convert X86 AccelCPUClass ->TCGCPUOps::cpu_realize
>    accel/tcg: Convert RISCV AccelCPUClass ->TCGCPUOps::cpu_realize
>    accel: RemoveAccelCPUClass::cpu_target_realize()
>    accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'

Modulo patch description for patches 4 & 5, series
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

