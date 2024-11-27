Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA407D6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGM7t-0008AH-W7; Wed, 27 Nov 2024 12:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM7h-00089m-GL
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:46:46 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM7c-0000Sg-U1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:46:45 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53de92be287so4230576e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732729598; x=1733334398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xKaFrHweJSPRQYKZFpGddfz8n0p/UHhhaJe4jbvvYk=;
 b=amCx5fYYg+bgs1Q/LRACDt1e6wmSeImANBLsBd3JcskmGaslCeKxvPfiFR2+9EwuNO
 8CJm30kjVoBh8/26u9ClxRPlEybanPtRi7ryHXF8ts4Eh7/lgS6Vd8j+oBoraLDMguec
 rXi6aj4F7qtyyzTJegG9ecijyzbqbsDC5OyS84ZhLous5yl4wUoo/6LKji0fQ2CkArZq
 Ne3uakNQHy38UdyP9UUsmcE1uJIj6a+i0L8D4w5k6lEcVz3zaRubEoFfO5wZbX3G9nzg
 F/+O4AB+1Xdcy3l9bDfri1PfLNViD6C+2buRRouChQSOuWAj8b1G0FDZTNlaZ9b03cX2
 IDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732729598; x=1733334398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0xKaFrHweJSPRQYKZFpGddfz8n0p/UHhhaJe4jbvvYk=;
 b=c16yq19AKyqxK4+3ksG4bOoTDmeh8YtLUukI3kki3iWMBkNXd7vfYrRjLwbFqLZdO0
 0TBiIjzjDEmjKEpT6PXY3U2BwcW7/foHD1KCFZvycBXNgaWG/AsIO8lkS0CUKlICF51t
 GnCuAee1Q6r/x9IPe9TxL6UUrY05sKCv2Hy+kRZqocXYsdM0MRo6qJCPH5+q7Sc/n27H
 WbdESRK3quRy4jZRUIR2lEYsUkzPeA9Qwbu4FfAVebiYWXbP1YOv3xIKKLHsFsG7pSjk
 jlxyNtBbfTAawpI2Qa5Hps+YjSCxTrWMvg4iya0bQnrBCy0OwO6b7UOjkeinmZ10mFeQ
 fZcw==
X-Gm-Message-State: AOJu0YylJJwN7c/dLd0VWatzjKD2qeR3ORjeBQcgpHZi/VKCTQRbun1y
 E5J3Tk2B85qU36wPGJTqN9OEdixDTbSYn3XMj50FzTBthWPDZYLFxL85+olSUCOnkNk8JqWoJbw
 p5E0=
X-Gm-Gg: ASbGncspKBFYpGfVkNEoW9O99/OuYbg/w0SFvskXwbuTqWnL2cogsxsbvGHCvQ1W31Y
 zKdq77pQgWngA8Mfs49f3qeFCjO2SMDxf3I2sBFzbwCuC5nl5hhGnCXi1wJbBNtAH2N0NO30a/I
 oz+TpnSC1zphOVIL4ZesFreVV26qxrb/VvbFC+ZOTZWqlcIGc30y3JE/8u/uOmGsqd4Vz08XmPK
 n1MpT688x9GBv+o5A7KwJ3TooYr4/VyeKD4ITDpeVf+C35vSs8DNMgfMAS9BCV3u1vN
X-Google-Smtp-Source: AGHT+IEKiesfDTwmivB1lXmADSMt07loWNQDAtg9vvmYeCH3bFqMInvBZ6w2eGXFib+DcGrlLFTxHw==
X-Received: by 2002:a05:6512:2389:b0:53d:dbc1:f332 with SMTP id
 2adb3069b0e04-53df00d9452mr2564080e87.25.1732729597801; 
 Wed, 27 Nov 2024 09:46:37 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd2480ec1sm2356272e87.166.2024.11.27.09.46.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:46:36 -0800 (PST)
Message-ID: <044d72c7-c135-40d7-945a-7aa2c8e89965@linaro.org>
Date: Wed, 27 Nov 2024 11:46:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: qemu-devel@nongnu.org
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
 <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
 <e0c904f2-8620-4f6f-8392-75971529080e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e0c904f2-8620-4f6f-8392-75971529080e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

On 11/26/24 18:15, Pierrick Bouvier wrote:
> Except for saving memory in *very* specific case (a structure allocated tens of millions 
> times for example), I hardly see a benefit vs using integer types.

Even then, 'uint32_t flags' can be just as easy to use as unsigned foo:1, bar:1, etc:1. 
Plus you get knowledge of the actual structure layout, which is presumably important 
*because* it's allocated millions of times.


r~

