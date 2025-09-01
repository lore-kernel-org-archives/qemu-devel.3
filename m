Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E11CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBUX-0005t4-H5; Mon, 01 Sep 2025 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBUW-0005sY-Ev
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:51:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBUT-0003eK-NN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:51:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3cf48ec9fa4so2424779f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756759859; x=1757364659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1KFB1tWZdhySBc97No5Pn4pnNpz5554Ov13PB1hYww=;
 b=K09KR/KJ3qCHjyLfp/VRPg5q8OV68xHkubqB3a8d0MfUYry7PGjcCrrCeJoh7+/onU
 vDs3lBr0lCYkzmFFSfAhbk4ZIuHxUqkVaAN7IBeXP0ocTHVYYCKJafSkIw9KT0cG0k5h
 8+w08p964iR3+tfJTWuFsF7kqjNvK//EeM71qR4/rraCul2My2fGuuiCpxYzcaj0cjkt
 04Yv3WJ+Hc7njOZvFJoIHVXJDRvrvkeNjIWdFXHSocJZ1NbIYITCCkS5O5sTtjhMxRGK
 lO0C2sQ47J32TtqHoesghHNvAk3RVzgBOKo7FB/gv9EuEPMjWCkNmqd5xLO9eHZge8Fq
 ty9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756759859; x=1757364659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1KFB1tWZdhySBc97No5Pn4pnNpz5554Ov13PB1hYww=;
 b=jYNReoEqMu7X5KhvUjxu6Cdu1sJt+S3UQbvnkhRm1QLgdEqkkFO9J2PDkqGgPPCqv6
 jrOECcrBxwrMKRIZvtuf9SJEnJZAp4Vf/9JWiot3vLk6y6tYv6U+i+gXVW1BG8kV3V0H
 sdUyCvTY55teLTP0hD+vkef5QkN2qvrSpA2R5zkOZh97C5Cfy7A8zVVLbVpC8SzSOhKR
 EkTc777QzZRC6pcR6+Hb+wovvf8gOU7mteH+9qF6INS7VhAe05mBidXixVQSWrMQqQk5
 /tWJs+I6D3bICEDymVZOfU48jD48dV+7GFIFI4+qSfFWkWVZ4lgNLHhhAcCUhpV/05gI
 e2Cg==
X-Gm-Message-State: AOJu0YzqYVlydbCV4Q0s4Bur6OVtVVg+3tgsmrxzXI05hT7Dr7ZOgdhY
 dVQaRkyzizwIWpAPPl6vV8+vq/x8qunmDI5khWROOILI0H5uYDijiYTJkmS1jBmvm8M=
X-Gm-Gg: ASbGncvzP4QJYvlZDSlx3ZxBBlaW3sooKIhOFGwc2XUXejUUAxjZQwRk1/mmar0Xab6
 z8zgnlST77cQi8s3vfoMJ9FnBd0rXpWJ+ZVec+opSj/S0Ag+mme8G7+RwLK7i68mlhk/62cjPXx
 v3XCpqLmA77y/wE/qGyWv0xgiDs+DbwCJDMxee6LdAM9ieBthol+kWfk8aB74Xm6TwsfOWPK0u9
 h5NmcUYptO3c+NePyHZxuCujsmsY7X2Uh4Rr0yFUwCN2EiR4lzhDOUO5Evet19i9NiWMNg1+Zn1
 /MQMMOtQRPT450GkXQpCOC0eTonBRwvxOKEOgyjSAlWIEEXlYPWxMu67RBjraYxuXXXVDbR8ZM7
 jcxRTZwws96J7ZBXvdL8jTWTef5lPT5iYafXd1YNGsSh4v6ppehA2RGW+V3oN0UXTZraMq70Xrg
 qK
X-Google-Smtp-Source: AGHT+IGGMMw//c77Aq7nktUa+n8ml0M74uW9fLD7hPFGq1abIM2yLnVkdCSLaebKPD49duehSTD9IA==
X-Received: by 2002:a05:6000:18ab:b0:3d6:a2d1:8e9a with SMTP id
 ffacd0b85a97d-3d6a2d1927fmr3711254f8f.15.1756759859139; 
 Mon, 01 Sep 2025 13:50:59 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9dbfsm16632172f8f.43.2025.09.01.13.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:50:58 -0700 (PDT)
Message-ID: <d9b4f4ee-7e25-4cfb-821c-bb12ce8d4e32@linaro.org>
Date: Mon, 1 Sep 2025 22:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: compile hw/intc/arm* files once
To: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
 <3ca7be1f-267e-45c9-9894-67e920ad5ee9@linaro.org>
 <CAFEAcA991uW624qVvQe9Q+6JY7Qu7w+ksWJH6AExYghD8UtSFw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA991uW624qVvQe9Q+6JY7Qu7w+ksWJH6AExYghD8UtSFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 1/9/25 18:23, Peter Maydell wrote:
> On Fri, 22 Aug 2025 at 15:31, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 2025-08-01 10:40, Pierrick Bouvier wrote:
>>> We simply compile them as target common code, without moving them to hw/arm.
>>>
>>> Pierrick Bouvier (2):
>>>     hw/meson: enter target hw first
>>>     hw/intc: compile some arm related source once
>>>
>>>    hw/intc/meson.build |  6 +++---
>>>    hw/meson.build      | 45 +++++++++++++++++++++++----------------------
>>>    2 files changed, 26 insertions(+), 25 deletions(-)
>>>
>>
>>
>> Ping on this series.
>> I'll be out next week, but it should be ready to be pulled once the
>> trunk reopens.
> 
> Philippe -- I'm assuming you'll pick this up as part of
> the single-binary work. Let me know if you'd rather it
> goes via target-arm.

Oh, since the topic is ARM devices, I thought you'd take it,
or provide an Acked-by otherwise ;) I'll queue it directly to
save us time. Thanks!

