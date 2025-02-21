Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB44C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSrK-00008C-EX; Fri, 21 Feb 2025 08:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSrH-00007H-K5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:14:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlSrF-0005SE-7P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:14:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso18376845e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740143659; x=1740748459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MwHjk9Sbu7J28Td7nAJZPKBSKMyF0LuqJ/6K2xgFiAY=;
 b=IOjuyEzzmiQFHY1PbsurImYityF80dMnI7HxCWSqZTDvcDEUGwslXnG2OmjkTjOayw
 gmrHrpJ2G9YYc/838mHxljC791zXrA1SIJMhFvWKvBgshVNC82DAQiK0egDO8AhHWspB
 PBXO0YTfkWF+DMrWn1ba2CGOxnx5ZCpVstGbmCSyWRp7pTuabpS3Im3edL6JEy1i1vYc
 9nuODy2YHY1I1cMFn7WbBwGHZeSLI3sa6o++CoKVqNlIbjPMCzdbBtAwq0oQw8lZtk9N
 zFCPGEY++aft8tIjX1ghlh0DPqDuaRU60NVh6XGJBpVMefP7bHsKGKvziTUzHz0Kny+g
 FfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740143659; x=1740748459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MwHjk9Sbu7J28Td7nAJZPKBSKMyF0LuqJ/6K2xgFiAY=;
 b=S5P0G0MguoONruNMd6KoVJ2/Omn33PyOLZf6r4/td8Pyk4DpX09PLvdKTpw8IUTdUH
 JsGJV4ji9v7PvV4aCxhqQPKbfwV58eYKi63m8W9Dqx87fEW6i/vq6PFv7G5L26GvqzZw
 7fRK3V2WkiFcDsMK8pVKtrKT6Hp1j28KkxzEYpRuSUCTLfbKa/lmXaH8PSC40w5OAdAu
 VMJ2JpXr12YHihliOEYE95hjp4BYN2x1ICqsFJ75ih62TdxScywAbwfA0wiE3GAy9QlN
 MlnhrWLWXVujckYTeUEK2Pe90OHhUZkU6ZDJ2I5To2IHj8YB93t2Mc3wuuceKRT7rb9G
 u8Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKMHbW+It6xXeGPQfiUAdtB1rnMDQ+AzocFJ6VQ2K+tQuTejxKWrkq3Ga77OQQOcuLdiYzQiVS2aK@nongnu.org
X-Gm-Message-State: AOJu0YxgfJVILX/mbnXUAx/YOp3djPpyRozIO+zpXw5GxlpSQMWvjmAz
 fxlezS7P0o++Y+G9yJjEIBfCRmyA2EhgeR/QnZA/+EK6RW44TCTyfBniqsctzkU=
X-Gm-Gg: ASbGncs3phAUuMAUmWJwHxNlPILvzgykgIBs+J74UVRaVxj2DNGTJpEAMlziPEPdGwG
 a1yQf0G0mChNUxsRGrSfVfC+ukzSgkF8R5/6WNxI2EdjJmsq4FYE1QQTAKoVVZ0cLlR3/ja74p2
 lfzB4Jv97bTcfPogaARXnvTx1lKGiRFLOqZCSK1Z/o6WnI6KPyIBxiFnbHr0de+YJs5zHoblVkB
 UtkX2EdrBqLynnw+MS3FPFoOIfFh9+uQMTADDECt0iNboQO+YyiOA7CWtGsZHxaJaDd5i9U425p
 L1zdlvyiBatHWfVDaVntxU5pD1FgfPsxOVafcmgADloPyL3AXch6h9Hye0PP8qlbdtRc4g==
X-Google-Smtp-Source: AGHT+IESeCMoZYyfTVJ7mAZeV9omg7ykJZoKxTNowWaYaWds3e5DFOSLbnttRqHtDAzvIElX0C11rA==
X-Received: by 2002:a05:600c:3b08:b0:439:5da7:8e0 with SMTP id
 5b1f17b1804b1-439ae1f30dbmr33251005e9.16.1740143659442; 
 Fri, 21 Feb 2025 05:14:19 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b41b5sm23689847f8f.14.2025.02.21.05.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:14:18 -0800 (PST)
Message-ID: <3c87db9f-230e-4bec-96a0-e8b41bf2333d@linaro.org>
Date: Fri, 21 Feb 2025 14:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] fpu: Make floatx80 invalid encoding settable at
 runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> Because floatx80 has an explicit integer bit, this permits some
> odd encodings where the integer bit is not set correctly for the
> floating point value type. In In Intel terminology the
>   categories are:
>    exp == 0, int = 0, mantissa == 0 : zeroes
>    exp == 0, int = 0, mantissa != 0 : denormals
>    exp == 0, int = 1 : pseudo-denormals
>    0 < exp < 0x7fff, int = 0 : unnormals
>    0 < exp < 0x7fff, int = 1 : normals
>    exp == 0x7fff, int = 0, mantissa == 0 : pseudo-infinities
>    exp == 0x7fff, int = 1, mantissa == 0 : infinities
>    exp == 0x7fff, int = 0, mantissa != 0 : pseudo-NaNs
>    exp == 0x7fff, int = 1, mantissa == 0 : NaNs
> 
> The usual IEEE cases of zero, denormal, normal, inf and NaN are always valid.
> x87 permits as input also pseudo-denormals.
> m68k permits all those and also pseudo-infinities, pseudo-NaNs and unnormals.
> 
> Currently we have an ifdef in floatx80_invalid_encoding() to select
> the x86 vs m68k behaviour.  Add new floatx80_behaviour flags to
> select whether pseudo-NaN and unnormal are valid, and use these
> (plus the existing pseudo_inf_valid flag) to decide whether these
> encodings are invalid at runtime.
> 
> We leave pseudo-denormals as always-valid, since both x86 and m68k
> accept them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   include/fpu/softfloat-types.h | 14 +++++++
>   include/fpu/softfloat.h       | 70 ++++++++++++++++++-----------------
>   fpu/softfloat.c               |  2 +-
>   target/i386/tcg/fpu_helper.c  | 24 ++++++------
>   target/m68k/cpu.c             | 28 +++++++++++++-
>   5 files changed, 92 insertions(+), 46 deletions(-)

Again, passing float_status argument to floatx80_invalid_encoding
in a preliminary patch:

     3 files changed, 77 insertions(+), 33 deletions(-)

