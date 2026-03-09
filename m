Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD0CFCA192
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzi79-0004iW-Q1; Mon, 09 Mar 2026 17:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi78-0004iO-Ac
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:26:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi76-0006yl-SM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:26:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso6769705e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773091567; x=1773696367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYqB2vbW5D6vM8b6WFJIHXrwRsC4vaUby4/7qyD+SRk=;
 b=uuuOucZO/j1JsNkAo9D7I3w8jqYP+M8sMI+JJK/UdSobvCzqq12QLoGah6swgI/4RS
 /me5vQiBeOH06GX43CcUSSfI2KUDoe3ro1SgXF8Nl6LsQ30CMhB0NcYsPy2c4rMF4m4N
 ErcJT8vvHAWFir2qM8s49W8AxrYWtYBuqsNxeGT6Ff+LAAHSmXpuEgy0kZMHjPubFUwn
 Q+0wUNcKelMw9r1ojed1k9FpJNlPnuJYuIqyB9UykdVU97Upb1vuKHgO0C1I5oviPsDb
 lUhL2bo2ywlWWhRBZAuHH8iOndoRdPXxiuVifLkuXHZjb1S/CqtnNpnVOd4DxPTeIEEg
 O7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091567; x=1773696367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYqB2vbW5D6vM8b6WFJIHXrwRsC4vaUby4/7qyD+SRk=;
 b=dJ/Fx+MXtRrz9e1yhdQU9MMgws9rAWEHFuS5mD7h+tdK7FGGoChhs+GfA5W3uKEwCn
 FiP/0Ak5u4KZUW4ZkBDucozoGMr0tmF3kNVEzgXRTdMSO2FD1EqaPucWwcPphFDJZlNr
 Lgb0GXLI096iavfTwo3zDuacfhQKPc7koQaJXJ7yfEeAokqjVPDRFebDT4dcJ06290Tg
 CfmVKV21T2+wtbbq/vZvZiFSbGuZD8d2L0XBZDVYZxaJ7/feE5r+ESc5b70ideuvEBmA
 hc/onytomQgooLL7nOPJBQh0wm36NG7A31apPBx5LdbKGjGZ8HGB98X2LyhaJ/16POj1
 gK/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFn352iGxWOW9EeyhPvYyzKr87lsSZYbWj6B9+v5sd/ywB9/ADXWcK4VnIYPJzicdFbjwWsmbyzMc2@nongnu.org
X-Gm-Message-State: AOJu0Yx6mfeNBbzDoZqfHPTvYJlgDiKbbm+LLBlz19w198WOAWCAjdPB
 UqWkjhjwSDqZW7VHMHRy0r0+TuuHkjzSiBsbrBJgVDBXadDOHDeeVQnj4ngNkrHJ3QE=
X-Gm-Gg: ATEYQzytKtfOCcZvS84FwzP8cuZjjeV81F4VZkG92zVcn0us/KCXkTbaMHs1hXUCWo5
 eemWqIY6TNxG0U4J8UiwHIz9CWQ0BEWBaFzOoRpwFgHXefenyFiihKE6l5B1QeypdozmpRH1Bmk
 2DSOTBwfEszXeKGLoD29kqitz7uUlg0gYS1viOEgO1BPkulv2zF/RD7Y10KffwW/qNpOkcpZfL3
 vPdzmNG8Az/+snP9Ohujr+rJwAReNfVJtsBehzHkbd+o7VjeezKjhPRCpT3aGLzCty2emI5ZBuo
 HYmRblYF4h8QQDJHAwRubCeB6nSF7McvW228t6Wz5Rj/qu/IaZeYBb7IbYzHB/JprG3zmyYNub8
 63nyBjYK1qoXfenwm5VNt5Vv3BDnhfRgjvglvINip770dICR/4lzrEEOwU+g0F/Nrvbvcyh5zp9
 HgA1W+LaSS0UXKJNimriS7MqFJBgu+HJUZ6+NrUYdbyM7/TRnJuqybk3BeFTi6vESIKw==
X-Received: by 2002:a05:600c:4fcc:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-48526964a1fmr204172795e9.24.1773091567156; 
 Mon, 09 Mar 2026 14:26:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48534fa65a6sm111079225e9.2.2026.03.09.14.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 14:26:06 -0700 (PDT)
Message-ID: <c50bc9b9-cee9-4b5c-8a90-95fce2e2e5f5@linaro.org>
Date: Mon, 9 Mar 2026 22:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tcg: target-dependent lowering of extract to
 shr/and
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
 <20260303010833.1115741-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303010833.1115741-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/3/26 02:08, Richard Henderson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Instead of assuming only small immediates are available for AND,
> consult the backend in order to decide between SHL/SHR and SHR/AND.
> 
> Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [rth: Split from a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 36 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

