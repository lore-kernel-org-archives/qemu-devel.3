Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2513BCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBITG-0002XV-8X; Tue, 21 Oct 2025 15:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBITE-0002X5-55
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:56:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBITC-0008BG-8O
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:56:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3e234fcd4bso1077663366b.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076590; x=1761681390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSNk3fQC7FUJp+xwNXZk/ZRMBwI7o4RgTmRYh+T11Xs=;
 b=sjc8lFr0VMrRGR6f8RP7QlVICRWEX1b1wgUrqSP9Tzzyb11pvTBaTo6ZUmAQ7zyfCn
 xByJhVrxfw1345NCa+9cx4NgCDQz9KmepDbrYzPxU4xSJquunS2KMPOK4BY5Fo714paz
 wk6vkT3PqvRO8xyEmcAYLSSu0flQNKGUR80xpBXoUJxvdbsxDN2mMxnuhOwAWB8EDu3V
 SmLHK+pa1q21/kLG8c+dlFzPL1lYVcARpUdm0rap4zPmOkxp8ZL7cg7Di82cgjCgYK2D
 z+ixYYdecvcCqnJSsFFP7iy/O/oh5wkM6G9uWH/KLfP/197vfS8Dto4RtI959KW1dAKV
 1HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076590; x=1761681390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSNk3fQC7FUJp+xwNXZk/ZRMBwI7o4RgTmRYh+T11Xs=;
 b=Xu5patFBG/n8Ff4+c5lj+4awFtL4Ta3BLBMYx2ikh6/8Hn3Bi/Ci1hH4BlLTli66bP
 SUJ1vWre4yEybbCTUx61bksMyX29XGX46jYj4fuJm9lWxOjIvv25CAqVrdAp/beqWGMr
 cE7O7NnGavybtEU8xf9RNNMpP/Lj2H5+85Zpf8gN6hqUN61HVSPR1dIKwGbIDbAwUVNj
 implZW7Q6jTsTVEYI17dc3bWCHgkAFUF1Y+y1/gA6XnDBBwNxdLiQSOMIDLbbzUkh3bS
 EL+BAU4DleTwO89vcJXrJy2WgNAr6Cxm5O08U/BjsCxirFJuNdC+AIkSHLa3LsPVIn1Q
 sZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU8VqJUmyhpQVhca+7lYkgeXV8BMXzs+Ue9xqctg89eyndbaqMdTEQlcLIeKdpA+luRONzBAVTiabQ@nongnu.org
X-Gm-Message-State: AOJu0Yy6BXEh6YEtyUY41r4SmXvR7C7GSETo6i84GQ8ZnSfSe+PXz7SG
 ZBU5P7YI9bYCWG8QrRG/fS/aG5aMNbOZZgHmrfMMzO2gA9MhgnNSRkTbe4MeyFszBfY=
X-Gm-Gg: ASbGnct9SszuF6oFxtluowytEP/3UDH85aLcS4uPsNwTox/AL/MRVDbjNRq72waBV20
 TKHS8FIl0qJ2w0XppDWOIILQcPWeYhzLxKdugF4gzSGJtg/8vbjI1gjGIvy0fVip1XsPCY0HiOI
 Dq6+1XO09rOQkzdaHT+T9ys5/OyGldNZhj9opm7bpmxf4sIe5Zwd/r8SgP0IuZYaQjYrdSf6u+7
 lRcSpvEJ6aMObTQr3Abr4+Jy2pBnY9GWeHZqp8JMYHKPFcQ6S3Jrgx3ouUKUU6OgrbQd5epcIyd
 WLFttZJa/JFxocRcAe2/vKhCRCjAhylGTaJffN0CYV1SUHLwJQrtKiqihNx/5hJXBc4uXpC5/P/
 wAEFE5YpnYu5/XDox1FsxDD5Km2TJanvIr/3cjTMztf1Uynhm7cu8+HCaPqYZ8QCfhBjNAWOHRz
 b9GPh3w0rTcc2P0Mcljy0Ue+qyT2aMgAeB7aV/5QYStQs=
X-Google-Smtp-Source: AGHT+IEtUe0Yx+i8/DatB18gYd3+BKP8adC5t27eNmTCL2v5sHiqbRdI3G1pFl9syjJgWvubVwOHUw==
X-Received: by 2002:a17:907:1c0a:b0:b49:96e4:1832 with SMTP id
 a640c23a62f3a-b6474637f5emr2067228066b.65.1761076589981; 
 Tue, 21 Oct 2025 12:56:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e7da35c3sm1135694966b.4.2025.10.21.12.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:56:29 -0700 (PDT)
Message-ID: <5e2ee9bf-b5cc-42eb-929d-f31efc1193f8@linaro.org>
Date: Tue, 21 Oct 2025 21:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] target/hppa: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <cover.1760884672.git.neither@nut.email>
 <f34973e93815d100d8216173eddb7d4f72cea847.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f34973e93815d100d8216173eddb7d4f72cea847.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 19/10/25 17:14, Julian Ganz wrote:
> We identified a number of exceptions as interrupts, and we assume every
> other exception is a (syncroneous) exceptions. PA-RISC appears to not

Typo "synchronous".

> have any form of host-call.
> 
> This change places the hook for PA-RISC targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/hppa/int_helper.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


