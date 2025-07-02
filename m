Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304ACC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX42y-0002HM-A3; Wed, 02 Jul 2025 16:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX42t-0002EF-Lg
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:27:07 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX42r-00082W-Vc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:27:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so5420415a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751488024; x=1752092824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1tT/Rgs5soHqEbee+5tJUEpNgjLe/joXcAgsboVByg=;
 b=T3JeesIc8Fe8Rm6kQeoyb2kGv9yjrtiOZWSVS+Tu0bOb3SYKP0JEK1GDFo7mYzGLTA
 da5rsVhTspqPqzuOh8FmnvUXkbU16Dy2pR4x2VV73OMYeJLS4pWe61cqDGJMCwru+lz3
 UnroxiWf+i5ChNBdPVjXBOfM+t5I6vQHEXZkVdI+8CTpuv8lWkChhMUzeJFj24Kz0PZ0
 HwXaCMV0AvgV7Tdld1zh9bljNCt1FC8QQsQJypUTFY3sRxFmotkFwWKpZaVKypyIgSJH
 mDSMLVbjAAvG08FoH/+ZFuX0w94o+e3me1721y9Pw2T2lAAniRee8Py1kY9IvNiE2HQu
 moTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751488024; x=1752092824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1tT/Rgs5soHqEbee+5tJUEpNgjLe/joXcAgsboVByg=;
 b=iHbpqXdE+CODX5TSkqdWP1AUGo0qui9M82QSc1YG56HMS79D/ehQcBkvfaBorLyuQf
 6YwbZmfpL3MzMSxEmq0aggAyBZBKrZaAvxEh+5+lyU6Xzd+DSKkaLpz+CddfOzqSV/8i
 3zyzl1K2ifEStJknvl2locdf1D16Sbokld13kwqD3Q9uSEMUr1ZlRTkHQRJ/MKLHudMo
 0Iw9viqCK9iFeVh1AckxmhH9261RVD2WcRk22eKRKRUd5OuBm+qC+3UZcjpQbI5vFYWN
 ScE5RUTLxViQjiltI0mtd1UckX0GQ4CUzLGWAru875Wb7fciqPIzLGdcDVRAd75Azdp/
 l5DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVId1o/Qwlg8a4Bc4KvRXVeZDGwDhoZBWPwAlL1S4tRuu4Sctmm/Emp2ZxBVrk0EmxNpNjTvVmVsMD2@nongnu.org
X-Gm-Message-State: AOJu0YyV+dzfDM9DNqX87CLGS7LU3J0TSi4SYWn8xJUFmsvcAOEpa2yO
 aryHbKu53UOWgsm3E7JGyN8fq5HDTofx/nt87FKbbQ03z0mMpvrzA3UTa5PM6mEfpA8=
X-Gm-Gg: ASbGnct7NFPguEnXfaMuNeD9sp+lIbNPEylB9EssKgeGFbRgav5NeTz2rNdDv0jJOZj
 sloICa1sO2KXhNgPnvaEoP7+8iCqYwcvkXcYpb0mx0mzuNPyZZL2oPmq4fZQQU/o6smkvWqCgqf
 dpUNnsqIrMB9t12M7AmfqVQHdhgQsc8AAF2mzZYM15I4ZIhsQe5YpZLhtJi07Xguy+G7tXxco68
 PR9ekbH9ccGLR2rsKA1HfufZaAtC/w2wFLpg37qy55M4kU2liResS3uB0s4P977Cs0F3ZuOSOKk
 LxTPUxaUz5B7EnxfNpCrpdb7+XVQfCcG+rs18hTYVG+Qq9iWiXWKEMU9OjzQMiLEvWsx//Hh/OU
 =
X-Google-Smtp-Source: AGHT+IF6FIku0U2/YBmtmzSxcYgShkeE0/DERmWSsUVoMxbJeBINXV/r1nwU/UGTT3GEdT/MKN5jIA==
X-Received: by 2002:a05:6a21:33a8:b0:220:5fd4:a882 with SMTP id
 adf61e73a8af0-222d7f0f2cemr6290555637.33.1751488023813; 
 Wed, 02 Jul 2025 13:27:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af56cb98asm15118228b3a.126.2025.07.02.13.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:27:03 -0700 (PDT)
Message-ID: <4a8b0d25-9ad5-4983-bd2c-00bca16a9907@linaro.org>
Date: Wed, 2 Jul 2025 13:27:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/65] accel/system: Introduce @x-accel-stats QMP
 command
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-24-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

On 7/2/25 11:52 AM, Philippe Mathieu-Daudé wrote:
> Unstable QMP 'x-accel-stats' dispatches to the
> AccelOpsClass::get_stats() and get_vcpu_stats() handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qapi/accelerator.json      | 17 +++++++++++++++++
>   include/qemu/accel.h       |  2 ++
>   include/system/accel-ops.h |  3 +++
>   accel/accel-qmp.c          | 34 ++++++++++++++++++++++++++++++++++
>   accel/accel-system.c       |  1 +
>   accel/meson.build          |  2 +-
>   6 files changed, 58 insertions(+), 1 deletion(-)
>   create mode 100644 accel/accel-qmp.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


