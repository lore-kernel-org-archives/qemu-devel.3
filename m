Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF8C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmHw-00058C-QC; Thu, 27 Feb 2025 17:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmHv-00055D-1w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmHt-0002R1-CB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390dc0a7605so821237f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740695003; x=1741299803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pGOEac6/oJsONdfzBlfSR6QH6lKZTWAL29EPkt8F1I=;
 b=kYVmT/Ox8YNXs2JFTj2L9IDxiYY2qy6OjNYc8wvbQ5S22f229jRKxZnyvOj5j0phiw
 CiTaY+VgtNSci0TPWlUq0I7RljARAQd6NGXA06u6r8r7/wfxN+gWiM+7cFpJCSJM+gC+
 8sE1A7gzutXWR4XiHZVdIUjH7jHmiXV0kaq5qq4M+/yWMj72pUQcv26SXg+vGiOa198Y
 K++Zk8pQ4+J8ocRY8MQK/0hPV35ZPFivxwdfrLz2kAKJWGL3nj0OZTruN2aZaySPxpw2
 QyFGlV8rVuikLXmvTxSqdpqtEHk8saAFF7T1PBI462b75FemsbNA3w75S4fPQhROUfue
 tO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740695003; x=1741299803;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3pGOEac6/oJsONdfzBlfSR6QH6lKZTWAL29EPkt8F1I=;
 b=ESIYITqrsMS+rTF6RjiKMqPufZdZGfxbSHwLqgVBXA0FNeSnHVVQ5ye4v5+4vEF8nm
 ewWr7XlpV31dkWlkx26INFKSykJ0+bYSfzZHRxqkhvdTlWF4ZoIvUpF3rVcV67CPpCRT
 eNH2o8DFwJfP4TfgM5FN9JffnOzl0b64ROAAhixdhTOaDzvzfa3gDWNq1H3Xpr3JVNvt
 oKx9GRv83SjN9+ffNce+XBQbgcd3zNDat/FPkw8cpbvEVmlyHtZ6dZdTx1/sakG2x3jZ
 mRDpAG21YnxKLSPln1Bw1Hgyg3QshYuB+W2cRs3zv/+ZjWG+BffLqJwfhthkMA2k8W+w
 6QDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJAOznNO2sk4SAn7VIfjRHzRLi9m0a/2NOxyYL+05i0/YoRsDh+gSLv8ku5BCYk0BjcKSqW7qPWHA0@nongnu.org
X-Gm-Message-State: AOJu0Yzqg9igp/uIVtoT5X3DTlkbmQNMlVOg9eG+b+B2jDKOe4JezvGV
 d13YGrrtPUlYw74tURWqN8xaOcipfK8tmipRcZLzRmCcV1L2TyOzT1ZEHLMgZOP3+/mTyPZShkA
 nFQUwgQ==
X-Gm-Gg: ASbGncvZsir741iBEyq2xnxX2/6xWZEXwOkuMZXB/BF6aBVNF36Y3b6wDcxKjrVpoUn
 aNMOOkkERa47wPGwY+pwWOheJNuA1J4y9GgLTe42wZk6LXDtvXihJPp4HEKOSjMTnXBNYHMJjHh
 5ukrzFgxbQfizfu/0p6SudAAv/379gmU9lXVMfscWXUp0ZHbAXyDDvZkKgyaBYD5senHwbzNElm
 +Ihkp7YvL+suTeOG9IfjFOHnkVD2YBfaKLuDIDqS0DhmlPnFvci1gDDxhZrgawIrlS3fx27DJD6
 VXvwBeObS18Mt886BfxhAYQMflm2P6euHVY0ioMM0UIySF8it7pTo5rlESG+1ZqjO3sotw==
X-Google-Smtp-Source: AGHT+IEUVlxZvsY6kyQ8oh4IYiDxD5JM/pwb8mU594q4Pe21lyTrsfx3aYR2WegI8TYwiGqeWjxLTA==
X-Received: by 2002:a5d:5848:0:b0:38f:295e:6331 with SMTP id
 ffacd0b85a97d-390ec7d09abmr655889f8f.19.1740695003585; 
 Thu, 27 Feb 2025 14:23:23 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d0asm3203562f8f.27.2025.02.27.14.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:23:23 -0800 (PST)
Message-ID: <9abaa8f1-b2bc-41f7-913e-0c427106de7e@linaro.org>
Date: Thu, 27 Feb 2025 23:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Drop unused address_offset from
 op_addr_{rr, ri}_post()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227142746.1698904-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 27/2/25 15:27, Peter Maydell wrote:
> All the callers of op_addr_rr_post() and op_addr_ri_post() now pass in
> zero for the address_offset, so we can remove that argument.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


