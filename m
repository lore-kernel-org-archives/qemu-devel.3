Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDFFC87FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf70R-0006no-6T; Thu, 24 Jul 2025 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uf6zx-0006Mh-Et
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:13:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uf6zv-0003tF-Vf
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:13:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-315cd33fa79so1052720a91.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753405997; x=1754010797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mlr0Rl/oYzxzJWALypTT5LOL1eb2LynbzxFo+Y5slcI=;
 b=SMbUpI7JYtDYM/qP8+PVvRX5jLn9FLGoAwoRUYtsMvO6b+I31L5dIERTpF9VTjswQu
 1Mkywih/V8tMzXPAXK68L2cpmRLCfSjrfzGTnwYc297PGIOXazWN0n3PSPfk5rHBsT04
 Aa5p8AkX/lMfn76TkUz45/PHjT4fHppWVm4Vxhp8wI0kZozYcgfPxpp7glIle9c/BP98
 kmqHfWEx2DvQmN528/c+/tVT1Fl3TErTAz4wsV2ZnXuHA6FgzB63455lVYT7HmgUEC4i
 DXJqxRhAoilFfU5/1FaH1ZImk4QsW/vWc6a0ANl145QId8cvANu/XFBq27CNLjxEEJ8D
 1XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753405997; x=1754010797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlr0Rl/oYzxzJWALypTT5LOL1eb2LynbzxFo+Y5slcI=;
 b=QPJOCf58E+lDEbHvvvolRMt+KA07QZPIs1KQNG4O9HdOJ5S3cIytNm4uG4SDhdr3iO
 PiCmbdfXD8q5f8GBFXvoZGErLhXdDgz+l+O+wvyp2/lMPxOR0/XO5TDqlKlOMdzcpH09
 59S+Vi1pBh6miYcwSYhYZKE/q0O2R5Ico0RWTDnZC3QFyR/CU0p+v76mf+2qQd8rs1v/
 M4H47633x9NwOgQF8flu+pX6Iou62aIrrIVWBHfhg3ksdJI5HrTMiN6nA2P76EycJYV9
 JP2IUkECFax/iLacgP2MaLSMgbAnO6FBF8yKPDCfaqn4z1CLB65W9jeWQsrpyDslCJfn
 Q4GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnitmq9Ylaw2n455dT6ynR3RoUqIRfXTpXPN4XsfiuP6VleTEfnNztdi+2JvR4gVWdOJztxgBdVXLP@nongnu.org
X-Gm-Message-State: AOJu0Yz6SI1T9QEBPSZw0xVyyUcDolhacwPNh75gemn2ychDC2OJL4WM
 J4Oq0J4sJc0iOlIqfw46wVoZc69XDmgmESEWKefn0+CuQwaCebE1YRQmot+APdzh3Y8=
X-Gm-Gg: ASbGncujDHHA1lSy4P1yr5VKg+d4n+lBVtC3s6AN5q93Tlr4WeGOUIli3GYPm0fx79V
 KzmNhWw4Zhl+PxdO/0Mnusc0QnlgbOQc4O7DZ3PPXgRGaWKBVB7K/gtXf1JAedZVuf/bWlJxNzG
 0PCKRibsaOeD0xJojoNyoqCXdPQjbP+W0DNKPV+G85lCzF7KLRGHRWC6s6aFkvqBhq0ifK20sBZ
 ohVg4YOeops9o9b57QJ1XNkjnU5FGfjPQIYdRIP90FknLujZNZ+5RLOewe4zYh6YSmKr74m7tso
 ZYAeyODzeIE/HapN442UicmwVhYFSytkJSTz4QfVMWwA7sF1ujyVn89sC6Eou2pB8TFae1ASZkc
 9I3MP7Dmen7AaPT4BMCpiX2ggPeea0T7S7djxhSlaLj1OVrDfa82UQVZU4J6RYoxFpk52YHv/4d
 Pr8Djgp8XZmwVW
X-Google-Smtp-Source: AGHT+IGMoEcRvAci26ilgEt0JyBkUEF7eHANKq/Ev9txY6M0SoTFcYltePs2o65jz5cvxUkGB+F/LQ==
X-Received: by 2002:a17:90b:5284:b0:311:9c1f:8522 with SMTP id
 98e67ed59e1d1-31e50769752mr12159395a91.10.1753405997531; 
 Thu, 24 Jul 2025 18:13:17 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635f10esm2256825a91.21.2025.07.24.18.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 18:13:17 -0700 (PDT)
Message-ID: <0d977125-473e-49f1-be25-c8221a3601bb@linaro.org>
Date: Thu, 24 Jul 2025 15:13:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1 03/13] docs/user: clean up headings
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250724105939.2393230-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/24/25 00:59, Alex Bennée wrote:
> +Threading
> +~~~~~~~~~
> +
> +On Linux, QEMU can emulate the ``clone`` syscall and create a real
> +host thread (with a separate virtual CPU) for each emulated thread.


We might say something here about limited emulation of clone.
See CLONE_INVALID_THREAD_FLAGS.

> +Note that not all targets currently emulate atomic operations
> +correctly. x86 and Arm use a global lock in order to preserve their
> +semantics.

Wow, that's out of date.


r~


