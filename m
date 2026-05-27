Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDF2CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS6zl-0004dJ-4b; Wed, 27 May 2026 01:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS6zj-0004cx-Of
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:39:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS6zi-00053V-8L
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:39:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso31839355e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779860392; x=1780465192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W25TmiEHNn9ilvTS6Gkn9nXF1L+JHlp8f/zMoiVsxXA=;
 b=o8Ji3/IvVAcB1u6vR3jPjKEXzCmBLxYfmyle9M3rxU50dsFlRI9dNK1nJgkqmD3aIE
 hOGSLOTukPkjyV2q1+TqdFLMeku/vLhxXQEgtcC+Tzio8huTF2Y3kT0Cw0+awt8AnPII
 wrrsj/oDmr13/z9uFxvCJ9pswWCwMmpvWkDlJgnrdVDfqCi/84Pb2/sWuhKZcVyHpef3
 s2b4y/HspS2MVsdn3juRq9ZYzrh57/hbotG9YtfhRlcKXA/xGnaWcT8hqYaSCVOX0tl7
 5Yhh1JhcNKeXWnj+3wvrUpzYA9P1PPuAoNXSvsAh2W3EmrT/sN2QUSZouvOWM8qi7o5l
 BFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779860392; x=1780465192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W25TmiEHNn9ilvTS6Gkn9nXF1L+JHlp8f/zMoiVsxXA=;
 b=DNFFCLwHFomjAV6btv3WaGcYwBBq0eoEW5ELETzCth6c+HFk4BGA+7cg8u/V11HYjp
 zJ5SSCpJwEta/nannq8uLAAVdPT0j0SFJneVQh5hh0uXOHMQAgMtKD7GMEU6O+FvUjW9
 MxxT2qXT0KHxfjn3+eXiNXStApCREFQy+31Q9s/vcyESypnQaiYa5ap36PZBjqJVp5fQ
 mH6OqTDjM070Z4JDMp8JOYjid6t+7GljwPuvunB0ZmJPM1No5HxyphWeqcj8wtTp9l3S
 zKdy8xPkB/RAdQv7NWeP/UymBtDb9tL7VD5Fp52gV4Lyfoe36gAp/p58N4T0lzJarkr1
 jR/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7yCcLZ2TeDzvumFyaHo+cceSgpdudf+x+etsVvT2Qf6+VrM8u5AUu3sPFxe5iDjFZmHQ3gxVwKIyc@nongnu.org
X-Gm-Message-State: AOJu0YwVyeynH2SA7W5KxajLrGS3+8RUUbGUzMid/3C4Lz1QOTCN+vwV
 NSxyZdV8kstVL7TIGXUBjcbU8KEPvl1664BpCnp/X54VPy2VgLfDXAC/hnNXtGyq6ZA=
X-Gm-Gg: Acq92OFp3Hk1IlmvhXh3VvVUS9NbJHIsutkVDSH3AWorwVq2VOJjmCPNDlccXtQZWlD
 8mr1oBhK+m9SY/3p8SQMwDSCs5G5s8Lxt4mudZVKHV1sdHyVoAkFjxhTSSOSUlf5TFUCzB+AVrT
 qaDEXA087Acx5l7m66+a128x++P216FEyJZ35jSSFp5uBUG4O6nEsd+kPrRRpBY9qyv8YORKWkH
 RkknFKLXDmu72DkaMFYAJsU7P7gyJK5lx+Vi0Bi0VVvFftWoZfdEdFpZ3Ronp0MQl2Bn/nAi2YP
 3n8XK1jiTKXUBEHhkgzgzg3LLLidqyOAwZJrJh79TnoIFEqUpDlB5UuGXSHPvyMc2vggdIbj28h
 EuktZvJAYOZ/IXALuW+jS/avvY8efYxEAPBRH8g3leSn0snprff38YPOdNCEY9/g1RkxS+czsl0
 R1IENa/BMl7M4WpbU274AW3sUR9jD8gSwuTUIY6eg8CHq/pi8ItIxl++wYFn39n2+l1IqhOEkri
 3s5
X-Received: by 2002:a05:600c:1c10:b0:490:5380:f2cb with SMTP id
 5b1f17b1804b1-4905380f463mr310717185e9.0.1779860392244; 
 Tue, 26 May 2026 22:39:52 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490452765f5sm389807385e9.5.2026.05.26.22.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 22:39:51 -0700 (PDT)
Message-ID: <7da142d9-0b66-44d3-b944-f92bd284ce58@linaro.org>
Date: Wed, 27 May 2026 07:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Use float_raise
Content-Language: en-US
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "antonb@tenstorrent.com" <antonb@tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>
References: <20260521110824.1091323-1-antonb@tenstorrent.com>
 <876afba3ceedfbbb0675d98a450e229a275f6180.camel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <876afba3ceedfbbb0675d98a450e229a275f6180.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 27/5/26 02:46, Alistair Francis wrote:
> 
> You are missing a Signed-off-by line

v1 had it, I suppose v2 simply had a workflow issue:
https://lore.kernel.org/qemu-devel/20260521074016.1065645-1-antonb@tenstorrent.com/

I'll queue this single patch to save all of us time ;)

Thanks,

Phil.

> 
> Alistair
> 
> On Thu, 2026-05-21 at 11:08 +0000, Anton Blanchard wrote:
>> ---
>>   target/riscv/vector_helper.c | 35 +++++++++++++++++-----------------
>> -
>>   1 file changed, 17 insertions(+), 18 deletions(-)


