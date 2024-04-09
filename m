Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526FCCD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBTV-0001gd-QE; Tue, 09 Apr 2024 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBTU-0001gT-Me
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:25:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBTS-00063F-GK
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:25:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so11186776a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669116; x=1713273916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvTWnpbEaz4AwHIlzcpNyHp0dTR+1sW3AStMwKqDmNc=;
 b=d9/kbPcuFWjZTB954Tin6+4bVXOn/7Npgq1aydcFzGetTBbIcupD7H8viaeFRrqoAh
 itsYRm5IlaAhwKp189tR5eMp97mrvICw2H155pBq4FKHIgvKESqw/foF7k5S4FChozdH
 QL+6yJw1c6ATewq9X7Imgrn6PhgH51DMW3bUNNk3CYRqtYdOnfVxpAXPjPNkb9I5Rh4l
 71s+E+uUKJ+qIYcaAjMgRHOgubihdQCJZG7szNoR++YkRFbtIOwJTlyPUvMa9sf66Zud
 HcZqrVgJF0SnRr1Qx+ajLiJoPfzmLwP6GGHnyOqCOSJuBmjDybAQTdymJjyNJ0Soff5G
 cNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669116; x=1713273916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvTWnpbEaz4AwHIlzcpNyHp0dTR+1sW3AStMwKqDmNc=;
 b=l9BUIaUkdEqvyobsh1E41gwbtPMhiNd1TpdEk66E84Fzgyw/HfD17lt9sIcW3fDDQb
 JgX+9YLp6pVCsms6UyOr1NW0SM2WwaEfCEmRiuhbeRtHu40WxkoW/yUy35HwL1EsmS1Q
 HRB9TX3oxp98nG0lwxJZHyVdjvXbuPXJMfbxeaaWQk2ycvb+sKx59XvcHdkyCHbdPwm8
 IYsjTCLxy75xlLKczv1lWQxw+lNQNeji/npql7i1ttrhKfkcAgmXLOCc9E8eEnf3UBWQ
 bweNxiIiQcmtds6wxQx55olzuw0oB/jLBCQMVysqY16sSCwNLCdCUR9M6GUm/ggsV3vI
 eDbA==
X-Gm-Message-State: AOJu0YzJ9SvZK+0VD5gGXapiH2uVS9+CwULumZ6P8pg+OHmGaU6iPvEJ
 HtRmjt+Xo7sGJiJ8cfbzB3SItwZftRFAQf7PCiUsbuS07nRyllac3hMrSi+4d1c=
X-Google-Smtp-Source: AGHT+IHsDLu/CijEMLrscgJvOnQE5/k/3XgnJB/dFPe3/vJ1fbj5wS3fFbYmIWEh7yjPt1mRElRsvA==
X-Received: by 2002:a17:906:b2c7:b0:a51:abd8:8621 with SMTP id
 cf7-20020a170906b2c700b00a51abd88621mr2125373ejb.19.1712669116587; 
 Tue, 09 Apr 2024 06:25:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170906830500b00a4734125fd2sm5695144ejx.31.2024.04.09.06.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 06:25:16 -0700 (PDT)
Message-ID: <96058800-45ca-4bef-ba14-e0ed34155669@linaro.org>
Date: Tue, 9 Apr 2024 15:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
To: Peter Maydell <peter.maydell@linaro.org>,
 Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>,
 sdl.qemu@linuxtesting.org
References: <20240409115301.21829-1-abelova@astralinux.ru>
 <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 9/4/24 14:02, Peter Maydell wrote:
> On Tue, 9 Apr 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru> wrote:
>>
>> ch->num can reach values up to 31. Add casting to
>> a larger type before performing left shift to
>> prevent integer overflow.
> 
> If ch->num can only reach up to 31, then 1 << ch->num
> is fine, because QEMU can assume that integers are 32 bits,
> and we compile with -fwrapv so there isn't a problem with
> shifting into the sign bit.
> 
> And I agree that we shouldn't ever have a ch->num greater
> than 31, because the worst case here is when we call
> soc_dma_init() with an argument of 32, which sets up
> soc_dma_ch_s structs with values of num from 0 to 31.
> 
> So this doesn't seem to me to be fixing an active bug.
> Am I missing something?

Maybe this path?

omap2420_mpu_init():
  -> omap_dma4_init(chans=32);
      -> soc_dma_init(n=32);
          -> s->chnum = 32;

