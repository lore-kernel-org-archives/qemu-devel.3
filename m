Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F0C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 06:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujXrX-0000Ka-RX; Wed, 06 Aug 2025 02:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXrV-0000HJ-9r
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:42:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXrT-0003vi-KY
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:42:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so30020455e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754462574; x=1755067374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXOo4clszBufZOM3iirg1ouL1wsCWk0T4FCE8oKrSSw=;
 b=uzza76iGadMAo7Yve4oUEfc2XaJzj5t/mzVP/4/nFKL8EN1S/Ww+NjcMhM6pxSJzR/
 O6D2ExA1qr5qwv/wpWigYkAjPgvUcWiFbrLhB/aaf82CYPIfH2om/HTa3gfFsnJxWV9i
 VwOKkQhAOoCrsqG7gJiTBKtugGxUnbgLnB73oTi1CJJlRJmJlvIV2CbR/rVSw2j+IsFU
 v23iH3nCfgvdksPzsJ6A/+iWCdz5Du/uxWlAlWq4QHpe16XBamL8e6ABGrq5fXv2jyzk
 qg84AwOvU8l1sWVrIHP31qcznJw6rnm1dOljbAtHsVDdX86nv+7YZ2pfuYXrxxdGxvyg
 /pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754462574; x=1755067374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXOo4clszBufZOM3iirg1ouL1wsCWk0T4FCE8oKrSSw=;
 b=uzib1LXf1uM0m9dvs+Q07achSNohPqUzyTTJ9ZLjhw+jUgM1n6jD2k80GX/YKteY2Z
 1Bhao4WmCoO3a4xmisrM2ZIGwoDg9SeFiJO3MDhtJuQI0TkjXJOR0+wv8sfUaqeQth2f
 MK9GxYSJeUX8bGQDz5KqKvMTWuEAea/w4dHtPaFrSpRnTOVK1HuKkye7H4ERooi4hqBi
 oBEErhRsSjk5kAgLytV/uJ1O7ie/utg9/yfCsC9RNTzirSTpXzHWrds+fUeULWpZiLUI
 F5UT6HuiWkOhf3hel14RWNTUbLoGwUSE9lASIaZKpZPO52uY+zf4JZRtIFvqphLnfAux
 P02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH2kGYykScItiQxmIkzj7FvgC36MMT3W/AOapuJifKREvJECXBfDm7mZmUyvlLQwcAoepnF2faE2MZ@nongnu.org
X-Gm-Message-State: AOJu0YwBv0j3oz8IhB5VWvN3s0WIJXU8ElIVu+9kcy822ClgbjyYMbN6
 cpmsq4FugGpMnqsrTIYElBmTwi9+7o0vu/8O1kP8oKPzUKgIsNryIR08y5VCLRWXQDs=
X-Gm-Gg: ASbGncuIJi5xPbfJrmiTRFiZEr7meGHa08t/cEUnKD/CZSFO+hufvg2/Cg3bgG3IMvY
 rIUlKw9NsqHIb9TxKRUapqyQpy9MRJbfJEmMn9gnnYFmEmubcasCvOhDL9rIW47Fo7rzEXBwhKf
 7qVbdoDvFAUkqbFWABtUdm2F4/RSLg1afqVJgfGHZiN/ceZ0B5Qjncjg8WtsJR/0+6KdIBt3KBF
 yzfhO/Rm4RuDoQ4xRGJk2hJe4cZrHaqsvFlBoCar1NbHNodsLmaYkUzyXijQ0eb/zIytkuIerK/
 USNOW2cIFtcQ8zQrTmqntvGoqtUptK1fNRoaaN9flSDcozlDUyFWC7II9xTW8daPT/mc3sGaUQ/
 LkNv4BnRcQhWlJZap+BPMSLIwA8lP9esnQ+jTGrJM5sJofw+jh3qUCSiceIM1kuE7ic0VCbzqBx
 eO
X-Google-Smtp-Source: AGHT+IGkIhEDrNs0tUttwxNZaCyROx/8mAIbp31ADbqQ/58RfFOdypQfJyhhzqQtODsDJ072UXJX3g==
X-Received: by 2002:a05:600c:420c:b0:459:d494:faf9 with SMTP id
 5b1f17b1804b1-459e709abcfmr9801095e9.10.1754462573638; 
 Tue, 05 Aug 2025 23:42:53 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf33sm21908245f8f.7.2025.08.05.23.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 23:42:53 -0700 (PDT)
Message-ID: <e9435ef1-43a1-416a-8009-5629a3161907@linaro.org>
Date: Wed, 6 Aug 2025 08:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tracetool: eliminate trailing whitespace in C format
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250805200334.629493-1-berrange@redhat.com>
 <20250805200334.629493-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250805200334.629493-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/8/25 22:03, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/tracetool/format/c.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


