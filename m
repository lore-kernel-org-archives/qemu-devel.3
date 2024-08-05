Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6339FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sax1q-0001LA-Ke; Mon, 05 Aug 2024 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sax1o-0001CN-70
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:41:32 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sax1m-0005LY-L0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:41:31 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso114834691fa.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722861688; x=1723466488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdLYvMBdwZXRyAq8zx7Lu0UhGl1/Y8CL4Ifn6yeBmeI=;
 b=wN6syAi/TY0NGlL1+aqAKQYWe/SRjw6GnSRgV/FkBvE7wWskF7kzAjfIRDGSdiLIDN
 JPmn957hTGXqzCKFMauC1+DwnMEj99XtCkGkkHBggR8/tkKrBgBSlVeVGfulAJFxZPSf
 Bm4NQ7L0gQpQ0KIqX0BK0qmDH3ToRNjbQbzg0HguMvYZeGWphG6dHs+PHz9phjOq6ACP
 UqhQ5PUC4IJfj4j2a+uIJjHns29POsNsA5pMoZjev0vQtg1u7TTod/f/VB7ze2xvQzkg
 YwhkAicCxODFnkOxsBurvM8Qa/nlRdcTnYs7hLtlGSPiKq9l5dzXJeApeoSGhWnkOXrm
 3G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861688; x=1723466488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdLYvMBdwZXRyAq8zx7Lu0UhGl1/Y8CL4Ifn6yeBmeI=;
 b=p2Y/PnZeW0vEjj45ZrcankATWX+RL5VVKb4GqdlqFK625TX7ciq1QYrJIibonm43ya
 v9Hf+bpMLoZxuJEtL+nqCWWLuI5sfiATA+GYsdsz66DI2uB9MVd++qGKx8zBrPIqxemI
 KCLfjeaeWrTP/hR9s76e1gZU8lK1mWyPTw0i5svZTRkHHRJNsTP2lMC6q8vY4e/SXcPJ
 +2AXih85IdcTm0fHNAv+SoXidQPJHJNMi8Cv4P44zTYRDwX8dw8JsqwTijURxStdAeem
 IvgiiYNSnrreorPoRUb6XkxaCndrg9KBmtCrxg35qPnK6Ye7+7k8nLzCjj7bo6FOPWmm
 FYew==
X-Gm-Message-State: AOJu0YzzOqrcq9c4CERO2IcLnAM6XRePgDqisxP0lPGDtVerfTll0EdG
 TO9WfExMoF+NSYFysjlRerWstxisksii22pFsszXAcUIfOzffRIhKavRZgyqdn0=
X-Google-Smtp-Source: AGHT+IH6B1yFUSo9VABE7ZNOOBXpMGvOHfhypqcK48TI2EFXl9vrx2TfYo0UbpW7tzV7fENmcZNMXQ==
X-Received: by 2002:a2e:87c3:0:b0:2ee:7bcd:a52 with SMTP id
 38308e7fff4ca-2f15ab53020mr73326171fa.46.1722861688312; 
 Mon, 05 Aug 2024 05:41:28 -0700 (PDT)
Received: from [192.168.1.102] (cor91-h02-176-184-30-132.dsl.sta.abo.bbox.fr.
 [176.184.30.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd059e18sm9719434f8f.68.2024.08.05.05.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 05:41:27 -0700 (PDT)
Message-ID: <3e93ed77-fa43-4f2e-923f-8d5578716a04@linaro.org>
Date: Mon, 5 Aug 2024 14:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/avocado: Re-enable gdbsim-r5f562n8 testing
 U-Boot
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240801172332.65701-1-philmd@linaro.org>
 <87r0b3e9yp.wl-ysato@users.sourceforge.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87r0b3e9yp.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 5/8/24 08:54, Yoshinori Sato wrote:
> On Fri, 02 Aug 2024 02:23:32 +0900,
> Philippe Mathieu-Daudé wrote:
>>
>> We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
>> rationalise unstable gitlab tests under FLAKY_TESTS") for
>> being flaky. However I don't recall the U-Boot test to fail
>> (the problematic line checking the 'version' string is already
>> commented out), and I'm running this test reliably, so re-enable
>> it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/avocado/machine_rx_gdbsim.py | 2 --
>>   1 file changed, 2 deletions(-)

> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks, I'll queue this patch for 9.2 to avoid messing
with the next release.

Regards,

Phil.


