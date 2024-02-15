Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A006BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raamU-00023k-Om; Thu, 15 Feb 2024 07:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raamR-00022Q-8D
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:23:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raamO-00067E-OW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:23:54 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4121a8635a2so3675955e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707999831; x=1708604631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HWO41Cf1QFsVA3x804gSKNGLbkyqqnZElXZhINtswhI=;
 b=sjjy91ebpD0MADi8m6ii5FPbeG+b4nc3Gixagxq2N8BLq6VBXikU5cabwI+BEdfUac
 EiREWIs+qorieY0aYsCpmnptCgfOB3O02aLT/hpQ9zLlWnVWUmSopPT0z6OlHtJR6TRQ
 03uFOdcA1hqDi8k7oh1wrEMvelm8BYZVPNez41+KZjeQLqzswn0x1Ly8njyZYEJEdgcJ
 64jRrSKatBl0RA9R3fNCn3GtU3sJrbTKg9CKf6FdgCCFyOxoPro1NPdKRd9OshQ+K/o/
 jGERxfiZZVYpz7+IDVDMBGFmRp40ppOk8V0iBCRMOKRLRyV7kKhpacKcv48Hm8aDkWVj
 wKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707999831; x=1708604631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWO41Cf1QFsVA3x804gSKNGLbkyqqnZElXZhINtswhI=;
 b=luLr+LXDK0VfqXhh+OOZnJAdd1DsxTbn8lwmO76J8spY9C6jJ6/Wm/ihXSGaLKsGQE
 T5CT3iR1/ec6B0kiPODl9P7SnPsbpRVbt7KBQQMZwvwd5Rh2XTCEnUzwJ5sKgsF6CUVg
 IcJ+Q8lMH6UPxpEHd1Z1UXQnq69tRBvT+i0tMaPETI6V88HScCVJaU2pqdAOpXp99Use
 JcxjvldaSeLnPDSgB7HsQldEMflyUdxFpu/xHUCwqegqsTa6kcFX2syx0SW8icq4xa21
 J+WefttwxEqLMuy1Fl1sdgKiEWd98LcSyNxEmJhVEiIBadJQH00laivEo8gICDHW2L+c
 8PTA==
X-Gm-Message-State: AOJu0YyO3RNWy2lqbQAfDgs95a+12w38RVXo/KO3E38mARVOnNDfakFF
 FIoQj/m2fe67DG+d1aU2R7LPaCMOWuHzv47XEDRaxDhV5zcQ/QArvkuNDu9wGtQ=
X-Google-Smtp-Source: AGHT+IHZAsCDczXRCwHg8AWyckReQuFF3MUDIuop5ZPsK40CSrDFrVxZ0GkUKyo2rRQzo7MmSuKa3w==
X-Received: by 2002:a7b:c4c8:0:b0:411:fe7d:ac4 with SMTP id
 g8-20020a7bc4c8000000b00411fe7d0ac4mr1272220wmk.24.1707999830998; 
 Thu, 15 Feb 2024 04:23:50 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 e30-20020adf9bde000000b0033d13530134sm122675wrc.106.2024.02.15.04.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 04:23:50 -0800 (PST)
Message-ID: <0dd19e8e-7a9c-47eb-afc0-3a7590759d97@linaro.org>
Date: Thu, 15 Feb 2024 13:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] sparc/leon3: Add support for -smp
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240131085047.18458-1-chigot@adacore.com>
 <81348d06-49f0-4102-983e-d6cf80e876a1@linaro.org>
 <CAJ307EhF_6_ssOje4HaL6ASiCbtkdA5CY98gtkZfRLcmX4ubiA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ307EhF_6_ssOje4HaL6ASiCbtkdA5CY98gtkZfRLcmX4ubiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 10:17, Clément Chigot wrote:

>>> This series allows leon3 emulations to record up 4 CPUs.

>> What is your base commit to apply this series?
> 
> It's commit 11be70677c70fdccd452a3233653949b79e97908
>      Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu
> into staging

Thanks, series queued.


