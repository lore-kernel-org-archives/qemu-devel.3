Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137BAC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBmT-0000C0-PZ; Thu, 06 Mar 2025 09:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBmO-00009U-00
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:00:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBmK-0008Hy-Vh
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:00:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso4461765e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741269647; x=1741874447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p8e+aTIsA5BuWm4hBuAs+wicLt1TmHRSHO0rAL2bOs8=;
 b=KZVRO5kzWnia/KIVW7eA4bt+HYcUzgVK6sXxzqbwDsqM2uw/MGYGvoRfX8E+FURJEV
 2A3IBq0IzlMaL67zPeU+ezV5r81Y5F2kd3EC9i7n5f7RXMfFQjjknerD+Pv1XanmryIL
 wD+Bk34D2nn1bqZbelqp80DABUWhfytlX6aedLATeHZcGV/GLdFSIAIzSct3OZaYEdqF
 UnLCRLmETO+wmbhTUm1s+HM+KJ2D/d/tgoaFmiaLZYDDBy0CyB/Kq5yh43R6WOQ6eiy2
 4alBvekatkA4OpfJ8nM3+dd5o/qSVzDFc0DmougSug2/Z29nKGYJ7A24ZexaHIvjtsKv
 seVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269647; x=1741874447;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8e+aTIsA5BuWm4hBuAs+wicLt1TmHRSHO0rAL2bOs8=;
 b=keWT94qsjVv5JeMEaVw7ov49U2YfOaEnTH+ZrQKsWryF2ynTv+kDaD69ipkMqhoucO
 qYqyUPxq7TsI3RQ1NEHlTwT3AqjJ8qPld1ybUejVxE5hWvMCmMGEpy8hCtFBHdlxy/Nv
 L4K8bXy4lu/V+H+fYLmwpFEiCYHZ1wsXsbAYGmYfZuusy0JxcyCf3ddqUUQNeXZU36N3
 Xjn+mqP6yHcC2XCMrAq9zVJKq94+Jvb+LjEpXaDwoFra4KCGH4hiuKINTU5LyI5L9ShF
 a8whFpXa8Ju3Yl/9Ziqv02VBUG+RNwoqwl93cVHg9m6De1otxQV2PATo1WjpvDatWYuS
 eE6g==
X-Gm-Message-State: AOJu0YxLkStgccl33riew/Mit5+z+4Bwr9QXUIxAGAptsVDCjao9DeG5
 tEEURe0aF2Wj7LzjREoVLbUWx36umbkhoBAobS2kvs9esvcGUnQL+nGj/sL0p8W2iKUMth/lCey
 UJIY=
X-Gm-Gg: ASbGncscralXVpRATepbFkH2a6gEVTQC/fbmSjM1JTjQa3j79kP5Ndqo68jPKVGua4h
 P6Jcv1lr6H7CtAN1YDabcE2lf1MVif9sDKL4gtz5f1wazdbx0AGak9a7N+xXEHKlbtqP3NYcYu7
 22iJ4ljkyPidusK9b8uBVOY2qIt/46xagT+QFYghrvmWz6uTar8DjC/AqW7d8jqoKXV78tL/K0v
 D/rFtKHm7nsJ0x2weRPXLQl2GIwHJV7RuD4RQx1vaXMh+4iCjiboM4rzWEJDdp0m9ViNr6fDsmb
 idysGHtfzMCZYiRa4CgfBpzMQaWtCrjcBVtx0P85+l1lul/y9n7pUrpZ9c9qbquaR348yGb+xBL
 WGGNOHwp8WEk2
X-Google-Smtp-Source: AGHT+IFLrgJiPtO92u/+ke83/gim0qfR6k0KL+HmfBu6+sIyF7p3ILkpsZrKqBJJmt/1DZFz6ZSxGA==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-3911f76f519mr7336775f8f.31.1741269646543; 
 Thu, 06 Mar 2025 06:00:46 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcdasm2104332f8f.23.2025.03.06.06.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:00:46 -0800 (PST)
Message-ID: <d400e5b0-530f-43b3-8a6e-8539672af60f@linaro.org>
Date: Thu, 6 Mar 2025 15:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] disas: Have CPUClass::disas_set_info() callback
 set the endianness
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <8a185083-0459-4108-bd57-4bae75d871c6@linaro.org>
Content-Language: en-US
In-Reply-To: <8a185083-0459-4108-bd57-4bae75d871c6@linaro.org>
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

On 6/3/25 14:58, Philippe Mathieu-Daudé wrote:
> On 10/2/25 22:29, Philippe Mathieu-Daudé wrote:
> 
>> Philippe Mathieu-Daudé (10):
>>    target: Set disassemble_info::endian value for little-endian targets
>>    target: Set disassemble_info::endian value for big-endian targets
>>    target/arm: Set disassemble_info::endian value in disas_set_info()
>>    target/microblaze: Set disassemble_info::endian value in
>>      disas_set_info
>>    target/mips: Set disassemble_info::endian value in disas_set_info()
>>    target/ppc: Set disassemble_info::endian value in disas_set_info()
>>    target/riscv: Set disassemble_info::endian value in disas_set_info()
>>    target/sh4: Set disassemble_info::endian value in disas_set_info()
>>    target/xtensa: Set disassemble_info::endian value in disas_set_info()
>>    disas: Remove target_words_bigendian() call in
>>      initialize_debug_target()
> 
> Series queued with rth's comments addressed, thanks!

Oops I meant to reply this on v3:
https://lore.kernel.org/qemu-devel/20250210221830.69129-1-philmd@linaro.org/

