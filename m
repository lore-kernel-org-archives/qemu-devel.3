Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B365CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX1mG-0007AB-QE; Sun, 12 Jan 2025 12:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1mF-00079o-6e
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:29:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1mD-0008JR-4b
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:29:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso24960475e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736702966; x=1737307766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uM3ByAZmLlXOF286StyrwlwT9FweE+IfLhYTQ6nCIzk=;
 b=dPHQJZC0ypIZhdKtDcNaDwL+G2aczL6tFM14/rT9A25Forz235A4Ej4dIljrqLgP+d
 5PHSbMFMhWW4TiBzh9atRVadF/IATVQScDEy9O2GexhzarIqE9VqYBzsnTAtT0r+iJBC
 lZpNNDs+3P3K+n4umfBmMLGHllutIegE6/N3CAVhzssO9tdnBmi+XgHQtPNJ1vAsoabU
 akcZ8ZBMpcKgaV5Ive1aJVxhmNuvlFAHJySU7FXampCs4Jee0uBmrF86pdgBAZh427TE
 ZNmioRdWh5ycVQovrMGh5bxvX4i7HrCwjNfntbFk2ys3zkDt0PuG2ZPFd8xbb2NS8AHl
 CAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736702966; x=1737307766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uM3ByAZmLlXOF286StyrwlwT9FweE+IfLhYTQ6nCIzk=;
 b=eMZRijDZOrDXEtYmVwYRiBlzE1QDUG7ejr6w9Q1yiL7v5P2QDgqqodTBfTbO6dpEpx
 27WukrE6Tg2jEtiCf1kxabUEn3briDal7g3LiSwoY/UFophFI6UWlm9h2PJsgO7K3p/k
 RixatUndljG8uwCofMpUZEWtvVxUfj0tSYS0pBIzbgrLcgzUxU2uaSa88GCxZJbhPJ79
 kXV944yj9U/ZvDrMrXudxgj1rEVbld7gOMO4gEGk/jQXuN0xh0joqM2zBJkVNRxY1kJ/
 9IMvzLv/JKllvBxzwm60Yzf/1flnokmVGBI1N/n6FA+M8RbwyiOCvXXf3CnAYSLJj//m
 kxYw==
X-Gm-Message-State: AOJu0YxWUSW6ZBmqCPPXQcMg3LhJqW/5JU6wCW5ZKjaMZN6ntpBAC+eF
 fsGveIXPGmP4LsvNVhsETaY99JdFXYsP7otro4HYrVWJkExUgoxbkuclKrnnggFxGTxkAmebcxx
 R9V8=
X-Gm-Gg: ASbGncvn9MfGQ0ueN+ZQxqUFBpNnXqmTMkAsOVAAMYD6XpQiEX+lba6/7Ht+uuj0KIU
 2mZdt1ALbI4ebj7WnBimLiLhzDX+dQi7toSAJ5ggdiz8OA8Hyn15w9dNHlfziiFfRtmoNvqLLue
 y9yMe0ZemnlvGUCfgrv8BrnI3pe10GvBKFaMbzJsqVOg5wVeAT4u3VXcQ/OjHdxplIbAhCHHhMn
 BkW1hP68GYvccbtI3QsCnCNbUMGtbu5hGzm6C9Y64Z/bEH25r3qwzTHbR0eqEtyVPvWlWTzGNqL
 tLJGmOKWBGhmHzQ/QoJbtAGZ
X-Google-Smtp-Source: AGHT+IFHCEaooveHLEyBssPwd9nYysNGPnet1JedvbM18hHoKTKgZKzm0ucOtIrb/F7vot93oocj3Q==
X-Received: by 2002:a05:600c:354e:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-436e26a175cmr193795695e9.16.1736702966578; 
 Sun, 12 Jan 2025 09:29:26 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08eesm153739815e9.10.2025.01.12.09.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 09:29:26 -0800 (PST)
Message-ID: <43315ee4-3a0b-44fd-9562-99a761b1db41@linaro.org>
Date: Sun, 12 Jan 2025 18:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/tricore/triboard: Remove use of &first_cpu
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250110180909.83165-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110180909.83165-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/1/25 19:09, Philippe Mathieu-Daudé wrote:
> triboard_machine_init() has access to the single CPU via:
> 
>    TriBoardMachineState {
>      TC27XSoCState {
>        TriCoreCPU cpu;
>        ...
>      } tc27x_soc;
>    } ms;
> 
> Pass it as argument to tricore_load_kernel() so we can
> remove the &first_cpu global use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/tricore/triboard.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Patch queued.

