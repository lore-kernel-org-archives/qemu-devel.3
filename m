Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18574C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKOb-00010a-4Z; Tue, 05 Aug 2025 12:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujKOZ-0000zr-Pb
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:20:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujKOY-0002AK-7Q
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:20:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso23811815e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754410807; x=1755015607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pndJ/oCc9J2sT2To0zaFh5pDewG2/tVhcrCLG/4h3aM=;
 b=RHfiDZYkhlzi5pRPftkCKidpWaL/gkDcckC2p9+GPdeUX4uQ6/V+HfopiqPNjNbeM5
 c2v+TF0WTCHV83RXi3RGP6fEbjsS45ymPHIFrZHPChPuqBMXH4+WCqQ4pa/2Dx5EZ7mv
 Dc2UFVJKIjU8lTL8mvTBLVT0+sV+MIfC8lMLxe94sGEKLUbOQ+5xzoTFirHbmxytq5aF
 +egDiGWBOFOkPt+mkDVm+CPnucGPUW0aGlI2W3EGHy4sA7czy9JljC+9k6R6mewl0xTw
 dWlNFc5zbN/mvll5alCUnPW7Caai1riuXoPxOSATvxGw4MIkV2H1fzNQyzwVdzOG7RXN
 iTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754410807; x=1755015607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pndJ/oCc9J2sT2To0zaFh5pDewG2/tVhcrCLG/4h3aM=;
 b=Qp8v/KLlwFfaDeSUr+U/jo04c2anIQG+glvtW+d39hFkow+tMcf9tOF/TllIjLFT5O
 vqF9zIenpe2H9JP3wjV/7Legft0x6PtSv3X4IMJp7kCW5C0e8HtVHaxl1KaHpe3ubp9i
 0nvBCy5jBxbYY4xqo4oe/xmLUSU4brApIvvwoE5j0YXcL2SbxOJ2Ige2Q21+Tct87NbS
 J/riFw0yo1NB4Qc2+xXmCpRKGVPe1bmhtSgUt4QZdwtXg+FrSukfRg9tRr8rOr9z9PkV
 Zpadh2K3mIe8Kub8wbtFZsDiSB3fkwYiRiHuO/pE09ZBf+CidcGtkloArzuBWxfrHcz+
 MAjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuj+AUPg0F9tpgvrDtYvs3043kaiobE9edewFnqbhfvajTEr2Gi6yPJMxGlaM6S18Z3hXUosJvFSm0@nongnu.org
X-Gm-Message-State: AOJu0YztAykQlGvFpuK5HnXCfuuOOxk6lF8lgxyd4Es+VZHz+gXovhlH
 XqrtN5j1K+t2GbHmdaikaKaE3pb0+L1c1m24xPX8Ai1os0B3CsvskOaC0dcTYqzcoFQ=
X-Gm-Gg: ASbGncuWzjXAvG65T/xNc8XBKGu0I5lFBZBBMeeBLTe+/e+qhLFhA7AiL5Be1oumSdW
 MN7UzJWDr1KMm8SChqA/lcI5PdTgePsvMBJnH0wF8JJsY0TbKQ3j4MquJEsu2AowoTHO/WpdISW
 xHciQF7w9DT8TEl3fhb5Yzu7OQuJFWdrDx7iOIiKKPaBsCYkcYbZRFvEIvU7EuKnCqbErdR/1/i
 3lYIn/2Hie9SRTpvkzQCtoL9F8oCGGgixps71M+SKs8FN2rndR/P5axY19oQRWoFabqMQTxMrXD
 1AHk31PpgRZ6yl+fj+tFhz9o8l++I6yG6sZ185IgApPgH7SrRBRjh2Uz/N5I/N7RQYY+8WjXbHC
 al1eyc0A834kHbIPzYrxut6/N9HQcyBSUeVxrC4xJhHkWj8s+F5iw6whmcCbShBJoQS18mpuIE5
 hT
X-Google-Smtp-Source: AGHT+IFQqnFVR0W3ddeHFq7evp/ZjsGpsqj6Q2CoaggHt7UeHYJruMK77S+DvxlTy+cXjkpKOs//sw==
X-Received: by 2002:a05:6000:26d0:b0:3b7:886b:fb76 with SMTP id
 ffacd0b85a97d-3b8d946ad32mr9972439f8f.12.1754410807279; 
 Tue, 05 Aug 2025 09:20:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c4d02sm19339182f8f.33.2025.08.05.09.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 09:20:06 -0700 (PDT)
Message-ID: <4a1b080c-e3fb-461f-bb02-50a78a74b0cc@linaro.org>
Date: Tue, 5 Aug 2025 18:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Asking for an account on the Qemu wiki
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <A9FEEF2A-5443-4BB1-8C4B-5B6F974D1D66@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <A9FEEF2A-5443-4BB1-8C4B-5B6F974D1D66@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/8/25 17:18, Mohamed Mediouni wrote:
> Hello,
> 
> Just a random email to ask for an account there :)

Done (credentials sent off-list).


