Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6B0E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQrp4-0004PR-SU; Thu, 26 Dec 2024 12:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQrp3-0004PI-SQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 12:38:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQrp1-0004Ld-Om
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 12:38:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so4054731f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735234734; x=1735839534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVvpml95TRv2qPGlLfGrtOe5vcvsTIQwLtKTFgxSvPo=;
 b=yo00fG8esa5WTJMSjVpxpMZiYb4V4Ywa7mRosggUkLq5RrHpkMfbRJE3WVd7g9qgfm
 d0oBG/XTh7jHfXNPkx1Apqmrd7excSrLwZdhOYiCJ4UtS4p3QcNimTVHl5EY6ojNRBxi
 U8t3Jx7n/O5uwMVzs/Qz/vqiBcdFz/F/gil8G7/XNsWdjHs4bfKUoz3dd77+u8c2noCl
 rY7nM9ig+eszap+Li+lOFO6wtj0eXDiiFb7HFz/sSO7k0QlCzWNu3jWQUscl4uusd2ql
 N4Kq/cwHpEf2FHmySqQKdpbaSWYcTJ+5h6FFqzFfWCiSh8z4Uk3hWegpGnoO6W6xDSEq
 VMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735234734; x=1735839534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVvpml95TRv2qPGlLfGrtOe5vcvsTIQwLtKTFgxSvPo=;
 b=A3wwwVsNNCcxnjomGZH1F+wDppUasWIj45Gx40vLpORxuBRSgGmBK9NQpmpz8BA8Zc
 2zowlpBqGQ44wKgWaoRlJoxPhMsqt7X+hUw2wA7Q95Ww4OIRPhw+Dd5D9iq7haKwu30O
 LIHK+5Xo3rClYZIt2FlI87uSlBbfLs3YNcJotEv4UoI3P4PHXY30i0gNh0I9s8M9oIWt
 aRqrEOfKBO4bOZNh9u18HLPAHzZyEvxLJb9a7C4PQh6zSjYqd7luvM1njL3+rpW9wclN
 jxT3mMm99Y7dlQx5afvQN+N2VX59Yq/L0J6yAaDvRre0vqtC5UbfjpY/d+Crqg+D7dPq
 SVmw==
X-Gm-Message-State: AOJu0Yybfgur8n1PIMY+JQ6JwXk1en5ra8UDxXPbzfe9+wiKf1O9nx/u
 wtVvR3wzg8DBL/lKeT3gxn0IhX0JjPKedDla7xNzkqRGnTMg1cP8dQN46uzrU6U=
X-Gm-Gg: ASbGncsZdsvvPGXQxovEehUnGt1eOcCORMJxj2vDf3YpxXTu/pg+QabjaZCL3rlQ2zy
 SwRuT+kYZbvNj0stAvScynp6+Nv7n22doG4q0TeSEHoR0YbUNuX53nPGSnrDv6gU5XXVllikO7m
 muU7dimwMBRA4fwVPjY2dAjtoPqKe1gpbOAulSO87dcFeSjDCztje/P2z+XMsP08/ao5lCrr3Bj
 VUv23zsIm6/386Ku4g60CHQ2nI4dyi5tGJ6UpNac3FYg7SIwLFIdxJfd9FCK46IP4jf9IWo6Sr+
 WX+CF8PaAS8yrVYP21eFlxil271q3BUr3KGM
X-Google-Smtp-Source: AGHT+IHcQCybfNPxSP3d07MsAAxZSvJsl94Uz253IVQFNRlDEQog8TM6gibKf8q/Z5duM3U+OPNeWw==
X-Received: by 2002:a05:6000:4612:b0:385:f984:2cbc with SMTP id
 ffacd0b85a97d-38a22201929mr18202367f8f.34.1735234734080; 
 Thu, 26 Dec 2024 09:38:54 -0800 (PST)
Received: from [10.217.61.213] (180.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.180]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a28f17315sm14704537f8f.108.2024.12.26.09.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 09:38:53 -0800 (PST)
Message-ID: <0083ebbd-2f94-4212-b138-8839630ea9c3@linaro.org>
Date: Thu, 26 Dec 2024 18:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/6] target/loongarch: Fix vldi inst
To: bibo mao <maobibo@loongson.cn>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241225024008.486236-1-maobibo@loongson.cn>
 <20241225024008.486236-2-maobibo@loongson.cn>
 <b691d979-848e-4fc9-8ede-3b16c6de732f@linaro.org>
 <db21ace6-a4b1-adaf-7f7b-6d4aae312de9@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <db21ace6-a4b1-adaf-7f7b-6d4aae312de9@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 26/12/24 05:22, bibo mao wrote:
> 
> 
> On 2024/12/25 下午7:32, Philippe Mathieu-Daudé wrote:
>> Hi Bibo,
>>
>> On 25/12/24 03:40, Bibo Mao wrote:
>>> From: ghy <2247883756@qq.com>
>>
>> Is this authorship correct? Should it be:
>> From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
> yes, this is better.
>>
>>>
>>> Refer to the link below for a description of the vldi instructions:
>>> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/ 
>>> #synopsis_88
>>> Fixed errors in vldi instruction implementation.
>>>
>>> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
>>
>> to match the S-o-b?
> Guo Hongyu submits the first version with attachment, xianglai tests it 
> and submit again with plain text. I added them both with S-o-b -:)
> 
> What to do in this condition?

IIUC the technical issue, you can fix the authorship using:

git commit --amend --author='Guo Hongyu <guohongyu24@mails.ucas.ac.cn>'

> 
> Regards
> Bibo Mao
>>
>>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 


