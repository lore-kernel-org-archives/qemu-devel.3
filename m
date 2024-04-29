Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B410C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ssk-0003Gu-VK; Mon, 29 Apr 2024 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Ssi-0003Gf-4r
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:25:28 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Ssg-0006X2-E7
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:25:27 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so3111565a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714404325; x=1715009125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kvHfcWtO5ivHh6YS/yW2yxsNK9YBkGjscs6Ch2o0XQ4=;
 b=pO/vBD4bbhEnmAL2VlyNEi/PEjnMGrxYSGerSQbP26c/r382M8YBe13XQ150OY0SlW
 DrTqXuV6/7CXMhXZSoNR8uKyKUG7fO5KDz7dATo/qJkwHcqJpiW1F0Pw9lRbFufi6sJy
 nKzY+hmhpIOGltlF6CA7MD2YBRkulP4M6lNMOhcAEEOvVGHhPnegbTMuOmkVsTUxa8gJ
 MIesurIYDNjPp9OGWkgJEww+j7PYjosub0Ne7V3QI2RtllNhJ74wWig7RrqXsm9oRvxK
 tydfq0ckSu1kSHc/zLSUHwLvUCvdR0D1Rh7BL7Cb4IVPV93FuPWVVUmLDCKEssRKFmHJ
 WzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714404325; x=1715009125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvHfcWtO5ivHh6YS/yW2yxsNK9YBkGjscs6Ch2o0XQ4=;
 b=Pwka+6D3/UFk9UwPA823I2U9jKZbxEcvOIiWRdeDO3r7MitdqDlzGow3GV9vVMRx/I
 iFKVIrs/JohbFgIYut/vGTnRgSc+nm+krE2JD+xtTCQdMeXkdk86zRk4GUfGwrDBn7M4
 t4kRdZ2QHpu2s/wXx2vV0qCM5jZtxtJbsAw5Wed45o/Stya91K3WCqoz9l5bqfRV1LFe
 ZpHA7zBkWBZUroUWmJIk91XvQ12s2z/CdAM8bq9365hqpZOR55gRcpT0fOu5NOQ97NaQ
 bJtLilYeVNpyqkIzc8mowGS6tjln3ODzfscGy3eT857Q5weqLHogIi5lqkQY28RgMf3E
 yvfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/y8UnrRRwSydDdup88Wl6CAMfEh7J4U2kb1TTm0E7N2uFxB0HKwy+Ja4ENII9hufluvX2N5znI8tZYZ8hQoat5wzD7fE=
X-Gm-Message-State: AOJu0YxoHE34zgmHjuVfr0LpAFA2cccsAodPtwm/74QhPyVDdSAYL+G/
 /3tGTq/0QJcQFrnlsuJaS2odPsgqZULSto4x4rvBGHoa57mpoUlVrZLjiEhqPjU=
X-Google-Smtp-Source: AGHT+IFXzArRSSpIyTAqCRf01+8ATLP73a4Cs55R5DILaEkMmvAL66xX8dxnJpgx5pQOleYrm1c3Cg==
X-Received: by 2002:a17:90b:4f8f:b0:2a2:1900:493 with SMTP id
 qe15-20020a17090b4f8f00b002a219000493mr6401736pjb.40.1714404322726; 
 Mon, 29 Apr 2024 08:25:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 sb14-20020a17090b50ce00b002b1748ce618sm2713140pjb.24.2024.04.29.08.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 08:25:22 -0700 (PDT)
Message-ID: <57d73489-8df0-493f-a241-0eacdc45441c@linaro.org>
Date: Mon, 29 Apr 2024 08:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] accel/tcg: Move @iommu_notifiers from CPUState to
 TCG AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> @iommu_notifiers is specific to TCG system emulation, move it to
> AccelCPUState.
> 
> Restrict TCG specific code in system/physmem.c, adding an empty
> stub for tcg_register_iommu_notifier().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h |  3 +++
>   include/hw/core/cpu.h  |  3 ---
>   system/physmem.c       | 37 ++++++++++++++++++++++++++++---------
>   3 files changed, 31 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

