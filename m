Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78911CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwXr-0007IH-Vq; Thu, 23 Oct 2025 10:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwXq-0007Hh-Km
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:44:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwXo-0003Ys-Dc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:44:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso7098495e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761230637; x=1761835437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0GkunwaYJfPU7MzKyQJ2pDB2ftQas/xWZgu4jC5154=;
 b=vXLX5ywBt6lDrKIxxBttS9MXGnPaESMJ0VywPfkh22irefSdZkQF8UQZzbCigasK6A
 c3/ZgeCVx+gkSbs6r0NuDCcCjBxwhsHLGyMNgX+EYxLfH1K9spGOQLQUQp2oeD9y5XtG
 zXe90peZcNaZuF5gLe+KU/wx63MmqoSV4rFVaNU7IBECPy8S5/KtMkAjsIAnlIZOlJXN
 vVY7H3nL8FClCGzVs1g0N4VOWpigy4ABoVlIRRdUKzsGE+Ntw0+WYwbyUZlHRWLZqYss
 sLFT4dIqKowS/I3ficD3ZAQ6enllLBU3Qt66VZbRLUsGOig949uNlLFmvcvK4ofMmCLh
 Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230637; x=1761835437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0GkunwaYJfPU7MzKyQJ2pDB2ftQas/xWZgu4jC5154=;
 b=J+vtY/fJeeb23rAkiNlFEsfex5yJgsm/ZKvpaq9DEWtyyPmQfor69apuM7qvCbIqo6
 BpVWuaHFVJ+eZeNFWksHWJfw5ZfvmhmdAejHhgwxnyq5ckU87jFMHhYoiPN3iNXP/DAP
 BlTphZmMcQWmZ+ukwUN2/no/GDE5DyxafdRw0acb7JV379POzE1l37U16CccENNnzkrx
 VVEgk+meZ0fCYNeIaPc1hwa2WRIJZaERAL0dPf6Asb4yQUcnvZmPaSKvsWEjWjSZYOq3
 5m780XUUSdxs9EQOayWEpRPZCHptw2iXHxvQRSAfgBcm545duQt9N6sqqMViKNY1GBVv
 ThAQ==
X-Gm-Message-State: AOJu0Yy7uzbTB+tosyAj9QxlbPa9d4xDaNG9m3miOg89IDfmO/DVuNc/
 nu53pyJ/J/fTNHOHMa0gsnNQ+nCE+5+D1ZC0AaxsT0jdzhlxzdE/7kPnnoZVIorTJqdGOPN2PL6
 jSvo/sts=
X-Gm-Gg: ASbGnctf/arbeZDj5iRNJZn5yOWO0O9UkQoncG6C5NGduWREelcsQEi8HAXxCFA5pSK
 Nz7Hx9vI9G5n1aC8qb+V5fnC29oHzFFydPgDJmyqudzjFzUx8oY0C/VgylBMW98Sc18Dyja0bMz
 02mvz42i9lK331IHVk7AGDFcJF7ws1CtaFPcRZCbL5EeDqn3IhQYF3Sv5CH1OfLlkbfgiFbkbea
 bC/OzyQejZA+ZokZ6kUYGLvBOz/x8Xm1VijbdMjQXt7ivL2e3RnOpxynaR3bXaNbJE6ZTiDEl18
 f94wmLpj+CbhmCuRXuyPdZdBRp9URHs5D9GsVLP8y1ILKCuasdg/Dz3J9tgMcYA0jHqk8nJlrT0
 VvtSMzIOAy3+HQpuG1K21PWAQvkl6vSVe6XB4oxrI5vLLoeLp/GzUV165wksvZGFAMpxtvb7wCM
 HlU6MBlGnb8NmPPsi2fu2NVN+bie6ta5+0nigPPMCcAKV5WUkHXwlMeg==
X-Google-Smtp-Source: AGHT+IGPbo7DCDFRtSy4p7AJbG7cKw20bKzivdV9cDWtrFO/3ZZAZDl2KErnfmJPgQjR362CMa7ZMg==
X-Received: by 2002:a05:600c:858c:b0:46d:b665:1d95 with SMTP id
 5b1f17b1804b1-47117917bb6mr164645055e9.32.1761230636991; 
 Thu, 23 Oct 2025 07:43:56 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428e9b2sm100877545e9.5.2025.10.23.07.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:43:56 -0700 (PDT)
Message-ID: <0607976a-657d-407e-a226-07744a437bf6@linaro.org>
Date: Thu, 23 Oct 2025 16:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/58] target/arm/hvf: Implement dirty page tracking
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023130625.9157-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023130625.9157-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/10/25 15:06, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Notice writes to pages which are being monitored.  Mark the page dirty,
> re-enable writes, and retry the instruction without emulation.
> 
> Assert the fault is not from a stage1 page table walk.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 9 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

