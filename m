Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0BFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgqX-0001Ls-82; Thu, 28 May 2026 15:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgqW-0001LQ-EW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:56:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgqU-0002YU-S7
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:56:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so54706615e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998205; x=1780603005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nju+bWqiSLv4j414+OVM3LqArzmjjxHIuUcGqQjDJ1M=;
 b=fc0VJWgOew6BcUyjnsR1oJpJwsyhboD3YO3BqYEOw/Nc7QGKlDENoD879KhuUPZETF
 8eqOslGwNdodTaszFXIl31hSoZ9YzbFUruSKZXVF+EYIPKIjui+wIVeT6OKnutHBiQ58
 XbfezvGiHKlvjG4xsl/w4hDkwBUhq3XTWIQGWA3/iFr2kUX/ksAvGiIvc0GYUZonD43O
 wFbyhMREFm9EboLtpfUBuOOW9rbsDxGt1nKrtCTW3rKADF6p7TYRqR5uHLSm4BuDk7rQ
 FXHmINNN2uzNDmkwhVpOE2jclETLMc2+8q4BkY+iUPUczgtz04B+YUnLTZKvUlbiixxb
 ckiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998205; x=1780603005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nju+bWqiSLv4j414+OVM3LqArzmjjxHIuUcGqQjDJ1M=;
 b=SbeAIN3UfYj7IXfBDEt01G/ZvX0Bd6iVvvS3k3ki43YHKVuef0r/dPOs2Ev4pNNNt9
 YKVtIKEdt94SoaHc+k4ap/k51Wh4Iju+sh6PoFi5dYybPr32A4j9800ikcZid4euMxPc
 KbwEJNXxxG/5C5ibSElsYV79s3joZpB3JxEgbQR77SXvGcyPJ0izzQudIziqgpNG91DJ
 oJ6xqUzK7GdA9I2uxbno5cPmMn37RPJPEUWm9Z1C+LlLq+ICkwnQKs+URMFdSCOLwGbb
 joCFiyR+RDXspiUzXZfnqzPsg1YnYnstxLjenhvVMDYsoZWXSssEBfeddPTRAKi1M+4j
 X+0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kzIFTBFr4zApscK3+B6IrSfHK/6qqWqKrn2mGIKuwwEVYT5tx2oRhD5kt6MHPJ2R32RE2f2FHjB1I@nongnu.org
X-Gm-Message-State: AOJu0Yy2jxdgeHxPKVNpKs9WxKunvKE3CtBE2lgpWZ6iE7q9YccVMucr
 /xxq5hgMum/o+g+51w3e/TNvixyNwmfy4tYgFu8YZHnPagTqYkxuIJ7K2fwf+snjHoI=
X-Gm-Gg: Acq92OFx9NIOUY+aNUsb0EnpzEVs2tP5ELKceogDfpXb/rzIrxKvsSeIx3iqASeB+n6
 RahLwceKn9rCcnjCH7/zvcQNUsELcQmriBctxHgqH91tVJ9+NbdqvYtarEDpRvNVmdIZVoO1HkE
 kXFXJ8BJYbqh5cRVGDsHTlvuQUFlsFD8H8c3N6zggaeyAAtReDQbi81Vpc2qhndMAAxYN17iSVz
 O6hpFzaS7P7MsYQGuYRIkD234tv/iAZgwJb07cmn/2TJWPHyrCB25QuJ8kSCJYa1Im1Qfwe6p0S
 +/Uw0Qyr2jCCc27lD6V+l7+qXX+62GVAeqDD0mCRXT1/lPrYIimGolTbsH2d5X+yFJEkcsPBWbc
 +GoeJRWiYDN0M8DCtFp4aStiXg3KuanGiTjw7Y28G/6hbimkYRhCu+vU/Wc19atgz2Pj7Hc0IFj
 0RhFdPgRBp3yhn78fzZIEgpxG/ASxLsTA6svgr84NCSvekcL6oxovMv/p49ZAkpVE/KVWmU4rbI
 E+k
X-Received: by 2002:a05:600d:60ab:b0:490:59cc:999f with SMTP id
 5b1f17b1804b1-4909bf8b18emr927605e9.4.1779998205068; 
 Thu, 28 May 2026 12:56:45 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909284a895sm56605965e9.8.2026.05.28.12.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:56:43 -0700 (PDT)
Message-ID: <e636c43a-a613-4819-a272-61fef832627c@linaro.org>
Date: Thu, 28 May 2026 21:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Anton Johansson <anjo@rev.ng>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
 <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9d0853dd-5c22-4c46-9c42-a76d18230271@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/5/26 21:40, Pierrick Bouvier wrote:
> On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
>> Rather than adapting the array endianness when it it
>> filled, directly initialize the CODE words with the
>> correct endianness.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/riscv/boot.c | 30 +++++++++++++-----------------
>>   1 file changed, 13 insertions(+), 17 deletions(-)
>>
> 
> One could argue original version is more readable.
> Any specific reason for rewriting things this way (performance, personal
> preference, other)?
> Not a blocker, just want to understand the original motivation.

Looking at the following changes, I think it makes more sense to
have the CODE section const little-endian, while the DATA section
is swapped. Otherwise we'd need 2 distinct loops.

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick


