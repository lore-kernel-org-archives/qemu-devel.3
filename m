Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AE4F8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcgB-0001wc-Bq; Fri, 17 Apr 2026 02:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcfq-0001sg-Gp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:27:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcfn-0006oF-OS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:27:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so3899375e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776407245; x=1777012045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r1aQWtljP4T08PYKYn6pXoqGHAbzEgpMRj1mHWqy4mU=;
 b=GL0/SMsMcI8+ALM8VnLgVk8gCStL+VEncu6aYsJZO2vwa3KWvPMk+Wu8rUv9JwEzpU
 AJwHWTI9g5gHT78U4ti99Zjbe3YHrDspiD6KPwSOL9FRO5pnMlyx4fHJDuUWVBcDhlR0
 IkjR3oTINJ5g93rPAsRPZymOFcuN7SulDQ6P75DFnwngyaaLVEWK7C/zCw4aVkw2zHWv
 ExXNTnTUQhvw48dXDRP239p8jfJ/7GusIV7wXtnqSMq148WVOLocJ+klcE6ncAWNdwt+
 Oxruvc4AUrNbiu8wsUj6IrnZ4Zk++JqZijpmrOokuqP6/Iec6q2EgOQDgTqvcq48PFqh
 IPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776407245; x=1777012045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1aQWtljP4T08PYKYn6pXoqGHAbzEgpMRj1mHWqy4mU=;
 b=flMtKtQ3jlNAhijCG/PIZALB2UpCVPFjvA1vO5DrUOGtapkGa663LoMXr2w1vr+PpG
 dgLiZLkjnD3ZVmzVW2aRxe5Pe4MV8+3rHPbvFHKsohbP/w4QfqwBVWjlZn4Q8AmTlXPu
 dZ1312CltuJhJnFVMhypTkoObOobrRp7cCq4lMTD44bvcMZs5yK1clfYmiNaw5p1kRT8
 jDQdSDXWeD7gDESOWQ1O7KKRDHx8YdiaqSHB/D94XFJBCGYIGK83oenGGGRZyy5UtOS6
 zOP6FlCHedGCCgx7FD/te11cufqd5LpVMlAvUEMYLH1KMVAcge7+/oKb95uQfPVcUwb3
 Perw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eeocK64epq46eCqQilEgFpk4K0Q4c67zDiBx187VaWWxSCeqSoiXaOuIVzBjGjD/uZOxsasg1mnNd@nongnu.org
X-Gm-Message-State: AOJu0Yyafg7jgo9F5Sc09h8cuoO5whhRgetR9K0OMjOl7+mwvfeqVzd/
 wOA01QN9k+D9abcoSpl2UoWaNmr1NWLIEv8Tl8jYnzXdP0bQpLhhAfVgyFjJbC3DjGI=
X-Gm-Gg: AeBDieuwtoOsYaT1mClklumh8n+hSzwGYOOp5QQEf0G/BS4qwarnEhlA7O9klkH4kzF
 cYZwY+J2kPyi8AFAVDMr/E5huH3fAepztCC0U6nlEJUggT9+ulBwQiXuV9d94m355EoPlmjqt9+
 03y0K/KU+j2HGwPEBX0z7/gS2uPWNC7Yt0KIqnlUWKRD70fnHD6SElhGRoL6++dHwv4yhEADIRo
 2fOe+yIKd3GoXEBrovQjYRzMn/Asjw4+ncT4j5jbKoAl8KP3UudPyYtIjaDtOcRPP1Hjnx+1iYf
 LeRzFeGmEU8vNmN669I8FIOl7pSGyxImi6vqmlLYadBeWuzURoxzMtd/Nv+fc5lvfqnxN0YaCUy
 F9MNWYnUqeuwIBbp/wGj+IllEnmSyDaXO2wdKSoYqEoifiVF4IM6B/WA7zLc97atbKEuY824le8
 KMOKcsm+eBvsnzujBY70geyJVNFYBuuf1H1AGgNim5oEcGenhah7EGzzIE0Ka7XYOCVG9ty+Ddo
 tY8
X-Received: by 2002:a05:600c:5492:b0:488:b1c7:b432 with SMTP id
 5b1f17b1804b1-488fb787a6fmr20210645e9.24.1776407245488; 
 Thu, 16 Apr 2026 23:27:25 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm33007075e9.3.2026.04.16.23.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:27:25 -0700 (PDT)
Message-ID: <9908e77f-2c9e-4337-a2ed-cad837c6d845@linaro.org>
Date: Fri, 17 Apr 2026 08:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-18-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/4/26 03:50, Jamin Lin wrote:
> Add a functional test to verify USB EHCI support on the AST2700 A2/A1
> by attaching a USB keyboard device and checking its
> enumeration via lsusb.
> 
> This introduces a helper routine that runs lsusb in the guest
> and validates that the emulated "QEMU USB Keyboard" is detected.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++
>   tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++
>   2 files changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

