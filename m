Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E588FD2B926
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JVd-00067L-A5; Tue, 05 Nov 2024 08:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JVY-00066Y-Lx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:22:09 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JVX-0006FT-26
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:22:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so34101305e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730812925; x=1731417725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6wgqD+0FjdO6hWqjVzrKgK5jrcU6kuaYq0bd+BuPK8=;
 b=LtCiubfy/UfvabTQdHkHlO3DqomUyj3my9l6GGM3WFdZbsW8SZBYlJuvHeYbY4St86
 fnwtknhIF6SeAPluQ61H8V+kG9joVDl/ace9KHZGpM6ByMrBVWsU3Iv/hYq51fhQTaSt
 URtArny1TVobVxoPhGHupwBU7POoau8ykYaES0PBoPu0uPLGANB+DbW7rF5ajLFIAnsH
 EvZtqr8sv4VYNeQdBXQv2F8O6WW/N2ownkHeWG933YTb7XLEwEOduhO4q1LqJ9odwNfL
 zQs9DfPgEaMwKlrNTjCQI8kUS8JShqYuaC86G2v8EyZz0YLXLpdvjFNf9Jxg/DPboAH5
 5U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812925; x=1731417725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6wgqD+0FjdO6hWqjVzrKgK5jrcU6kuaYq0bd+BuPK8=;
 b=BJnhCbj8JdgPo/+8Pyi+UagubbsHvmFdgr14mN1wDA3EHddFvMZVyCQrVAL5ML8VOg
 wuIbC2NqzAiEZ6Bc2pb8FXjLezv9BXiLogdnHkFYlKl5PddUdA7+/U3frz554g4zGhFO
 lD+9qjX7fq00k9jG+fsG6owrBqHTkvFng3pJDgmgUpUMglESaXRyD+V5YGN+SXV3neej
 YzKFxNWtmNEnZotGXDn//EmcbqcnFg2BXOv9KLJWhC9cvBC4LAUxzjlMtDHmrYK8pjob
 DIBOZ5zfJn07oTYmzlNxwF0zXirJ30jIxJUTG1SXxRO6dyfRTaCD1PNIP4yxGuQtF47M
 pXZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXOKiEYLA8GWtEpg8NBqniz8d2UxFW3g4Qm5FCY+Kl2KIjic0ZcbplCTvBRN1GRPk0CB+5n/zPCDxM@nongnu.org
X-Gm-Message-State: AOJu0Yyjrrp81Q0MXNhNXUJCaRhNXqk+K6nnZHPZTM2yl8u8IWjCCXVl
 JvtkmRaEr2BEZIvDuE4qDFCWemDEHgo6r1GN7bcxw6GpEtt8+wijPeWdx9Z+k+8=
X-Google-Smtp-Source: AGHT+IHh/0iXDLWCa/1nyrXnyuo6rbqU2yMyPJLwSNTB6XWGCmTK0OTLJrCmliMJuC0J5oTRWW5Xcw==
X-Received: by 2002:a05:600c:35c5:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-4327dab3f6cmr161568325e9.9.1730812925263; 
 Tue, 05 Nov 2024 05:22:05 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d20sm16415297f8f.7.2024.11.05.05.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:22:04 -0800 (PST)
Message-ID: <31bf5682-d478-45aa-82b4-094ac95c2614@linaro.org>
Date: Tue, 5 Nov 2024 13:22:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] hw/microblaze/s3adsp1800: Explicit CPU endianness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> By default the machine's CPU endianness is 'big' order
> ('little-endian' property set to %false).
> 
> This corresponds to the default when this machine was added;
> see commits 6a8b1ae2020 "microblaze: Add petalogix s3a1800dsp
> MMU linux ref-design." and 72b675caacf "microblaze: Hook into
> the build-system." which added:
> 
>    [ "$target_cpu" = "microblaze" ] && target_bigendian=yes
> 
> Later commit 877fdc12b1a ("microblaze: Allow targeting
> little-endian mb") added little-endian support, forgetting
> to set the CPU endianness to little-endian. Not an issue
> since this property was never used, but we will use it soon,
> so explicit the endianness to get the expected behavior.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

