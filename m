Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C33C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXdm-0005vd-Tx; Mon, 12 May 2025 14:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXc4-0003QB-5G
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:10:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXc2-0000rs-9s
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:10:51 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so3519255a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073448; x=1747678248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ih1/WMG/Bvz6RkifhE4YJa1IDYAyJ8Bjd0bveBKxKIM=;
 b=pGNBIU7XkC9Yd/hZeXaorqaECfP5T+LOk7rXwUhylxYgkDEC257UWi3VFcS1ePVLq1
 to24Uh1UiHMHnvGimpkPkoPK35gOKAgvHYiMK94rvl7u4IBWVmZ5+wBCF4rELVO5u32k
 jumJozzb3F15Rt7pMFjRAWqKqWsNyhUzLZ+iOxskv1OHm3QT03ooYjtt98aVDyOWCs3N
 jczs8XEa/e6Sa2PRrkm2yViZr4ZW4NPLY4cqGSoODhXqHRilAp23XqA3aCtEXtA+3jRa
 ej2wG20fKYVeIyEtoosRF6ecM4ZkQnnlkRmKzlBP4WvGY9F0352FeTDiCkI3WfevYs1n
 W1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073448; x=1747678248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ih1/WMG/Bvz6RkifhE4YJa1IDYAyJ8Bjd0bveBKxKIM=;
 b=cs5igfY0jHhdsOqVTVwrluAu6Nke+Lb2kCjIIwj1YgjNJ3g3v1nwqKYA8P0GUU4S3w
 Im/iT9U+1uXZgyNuMrpSblFkDY3ZhfyFoU6couXyvyLhISImkn5aYjoQG76pj0lbfwJG
 zVXI2uNIIN6ClZ1hzgc68qPlUz+Hh8vMt6Q9q8004Y5R7R2WMdN03NAo9fnfYdjlf7VC
 GzmN18uQwZFRMpy0h+VvlYugEIoLY9HG6bwjH0HLGElhUyJ9/d0B+szgu4hvEF1rAOi2
 Am4CPSlkr34Xp0ovU97KtRC/bE8TPOV9UWLuXAELru5NofwG4uMwXlDWJ8TATsarmrz/
 VxhQ==
X-Gm-Message-State: AOJu0YwT3TxQ/4Rej/AaNV8N/ZtqUwn4J8VndP0l4kNnUYzLdaDNX8lT
 xwCENtGF03nRsNt54PESA8Ds6e3HmTH8w5OvxmIZhiDSCwx8CTqdzkYQ6jtqFmo=
X-Gm-Gg: ASbGncui1lztIFg1DeJCEN3Cge8p3r81g0wtTSxMwC3IgCtajwynaGdrJVoRlu7vQv3
 NzfeSeaLPXNBEcgpAtUeeBd0fmeCzy2uOo6+Yw9IBfMJeZ67zapBFSP3hEW5obX9K80B0hE8rt0
 xSd+7uNo0x+6IQR5mC4U5rkPZD4HLZW/JSMByWqwd/pU4JAQDLcufjEUxeoT7gC3mxsulHq58Fx
 oiCjeEPKoxN2DyYnN4UJ94kYV2ZJYot0NJVk94ooVziu1nrJddLmKRGvhEDpdpd5D48beKYf3Xd
 /kzcjG9yIzqm2O4IB+nzK6lRiznRz2LiC9tkgySbDOzXcgLx+L6E5H/tQOS4cojI
X-Google-Smtp-Source: AGHT+IF7cjh160/3os9miThpQ3cQjhGE0+bC4mKm0ylUowD5kJcPEGlWgg7VcP5nTdLVEsStyUuIzw==
X-Received: by 2002:a17:903:2f89:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-22fc8b51ac5mr168985615ad.18.1747073447682; 
 Mon, 12 May 2025 11:10:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc829f354sm65646295ad.213.2025.05.12.11.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 11:10:47 -0700 (PDT)
Message-ID: <4bc309ba-ecd1-4a4f-a717-d9ca71b77333@linaro.org>
Date: Mon, 12 May 2025 11:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] single-binary: compile target/arm twice
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, anjo@rev.ng,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_NgJw=eu+M5WJty0gsq240b8gK3-ZcJ1znwYZz5WC=wA@mail.gmail.com>
 <726ecb14-fa2e-4692-93a2-5e6cc277c0c2@linaro.org>
 <CAFEAcA_WtAAba9QBS_zOPUPtjdeDv+0mDJiTEepHS2+61aZERA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_WtAAba9QBS_zOPUPtjdeDv+0mDJiTEepHS2+61aZERA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/12/25 10:05 AM, Peter Maydell wrote:
> 
> I had a go, but it seems to depend on some other patch
> or series that isn't in upstream git yet. Specifically,
> the changes to include/system/hvf.h assume it has an
> include of "cpu.h": you can see it in the context in
> patch 2:
> https://lore.kernel.org/qemu-devel/20250507234241.957746-3-pierrick.bouvier@linaro.org/
> but that include isn't there in upstream git yet, so the
> patches touching that file eventually fail to apply cleanly.
> I assume that's "accel/hvf: Include missing 'hw/core/cpu.h' header",
> but is there anything else this series was based on?
>

Sorry about that, and wasting your time.
I rebased, checked patches apply, built, and sent v8:
https://lore.kernel.org/qemu-devel/20250512180502.2395029-1-pierrick.bouvier@linaro.org/T/#mc1b30cb98e11932458c1566ebe50a4efbc10473e

Regards,
Pierrick

> thanks
> -- PMM


