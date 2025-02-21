Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7C3C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQZp-0004p8-8C; Fri, 21 Feb 2025 05:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQZo-0004os-0L
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:48:12 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlQZm-0002O6-Ew
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:48:11 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f73e6ed7fso172860f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740134889; x=1740739689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vy0qCxrOpiMAyoWqj0F1HGdfdV+DMbSlkyQlbHUWGTM=;
 b=ASi1ArUePgcVQHNfDfp58wIj2gXSYLdFXtlMZBCSbB0uZYLUPc19BnY96bIVOJ9v0w
 JUgG1iJ96JpnIk9XztDS37bBl9uTxqAx0y3ueiawFhip1/qv93GuHqw9zQ19VN4ftwBY
 7E6Gz04cFi6ewtg7RpmF9WI3DUaUrYeCuyZ2wdTIsq3dqT5lZGrUAyQpYsK/nExClDY4
 JwFt6MCda5uIjfykR6sOKL0CYS0+1aY2kpVn/vz4b5cPFZ7GJk1CAH4T4VW5hy9pFE1q
 aFlU88xZeDtCf4DSjYaQY+W6+K/f7q29q2a0tePNNjOtlz6CmZI8ChW1w/8cBvF9u0eo
 C4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740134889; x=1740739689;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vy0qCxrOpiMAyoWqj0F1HGdfdV+DMbSlkyQlbHUWGTM=;
 b=pPIK+JXei/5fdIa0Oqjv2AAPsf7lsWlTFSiKaRIJKDg+VD+EubRM66USMA/1LCwsgT
 Br4/W6GSPQZFtfH7KB4PcRum7ox9py4SqX4MSn04IUwwCLMedk1vswnJ0JnasCeS+FfS
 jR78AvMdKkLvpWtpbmOSRqW6TkLUbdThOko6OOXRghJT9vLtP8bZWazosApjvG3OdUWr
 yZEYlfj4y6BiPxPJPN57pS5++RtClOe+Z9VwnS0vqqowGnaY/egMQUOXNS3i0IRjN2kT
 gCxE8lD5BXJMawCc3znDACKFMNL8ikFIlvtsljE8b/g5IsWkWB44QDv1RxmQhUxZheWl
 wWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcGmMGd32Fv/7J+wt89YesoIYv7awFsE/1A+CC7ATTEEz593J0m05F+wN897OUgy0cPPBy1dpT75fI@nongnu.org
X-Gm-Message-State: AOJu0YwAmq9ZIFerGN6OXa8Imoup1Yy4tKYt/CgsIfGNKxt5hhrALi9V
 vVOXSW5mLCIS+1k7pKGJbI+Ib4JN9WUbhCnGzLNPOyIpVLXLtiFigdWfjtykkLE=
X-Gm-Gg: ASbGncuujUJBhtoBBE1D2mgN+yO4T9BCstT38x/4/ioeEe2/QXFwWdY087hmduOXrxU
 EVD77oUTv7pWo63TTkh2WeFgptkslXObnUZapgRHhgKjAfN0L2zgU7DcrEpM1nGwQ48PNoy7Gwi
 YgiZ/Tsw1cHoHiemI47Uy/Oc0eefHS2oGpmdZ+eLukAWwzv375T+LBdpsoMGa8QClza95TTt6Fw
 YzavPTYszODDSjCDmYKxtEIp3Wahk/jf2GpnlJr3sFyAi5SuDD4RrE7SP2R/MCvZcGybwgZjueC
 +HcCu6eeNXl6YHZ9DRXWZ2qTi+QHr/LImp2emLzNJdxxXE+7namXCxJzVxFcd8PQLarVwg==
X-Google-Smtp-Source: AGHT+IEiT0eu0daGJIBEZWObNWk8PKRBVhc6iApf/IOuIOgA359K9af1dXjr3iC7TKAdndrXIsWbOw==
X-Received: by 2002:a5d:47c9:0:b0:38f:31fe:6d23 with SMTP id
 ffacd0b85a97d-38f6e967ed3mr2321546f8f.23.1740134888643; 
 Fri, 21 Feb 2025 02:48:08 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5c36sm23328886f8f.67.2025.02.21.02.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:48:08 -0800 (PST)
Message-ID: <8cbdce37-a0df-4dc7-be42-e395f4e0c642@linaro.org>
Date: Fri, 21 Feb 2025 11:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <d71e392b-d828-42ca-8f9a-0661701653d5@linaro.org>
Content-Language: en-US
In-Reply-To: <d71e392b-d828-42ca-8f9a-0661701653d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 20/2/25 09:48, Philippe Mathieu-Daudé wrote:
> On 17/2/25 13:50, Peter Maydell wrote:
>> The work I needed to do to make various softfloat emulation behaviours
>> runtime-selectable for Arm FEAT_AFP has left the fpu code with very
>> few remaning target ifdefs. So this series turns the last remaning
>> ones into runtime behaviour choices and switches the fpu code into
>> "build once" rather than "build per target". The main driver of this
>> is that we're going to want to do this for the "multiple targets in
>> one binary" work.


> FWIW:
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Oops, that tag is only for patch 10 (meson buildsys change), not for
the whole series.

