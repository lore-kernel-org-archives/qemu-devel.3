Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8394CD65544
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0LO-0007n9-Vz; Tue, 26 Nov 2024 13:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0LF-0007lZ-2G
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:31:18 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0L9-00041q-Ju
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:31:13 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-724f383c5bfso2973792b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732645868; x=1733250668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6ZaJ7dt7R/g+nKGnFSXP7pvbKBHN9lmThzElkpxBi0=;
 b=cW9dXeQiStkwZgv5FIdR3Ooe+ytJx07C3aa35XkHNLH088fJa2IUNY2QDF6OvebQuQ
 yeuejgvq3SKU+5mzy8uqw8kK329vtu5Y7G/Q8Cizc+3JirOEq96cwAogUb17Cc+0WciI
 /gcak4ndyCfAmgSwocW1jmLtaXlKNp/htixpgfZGBXT+q98BAQMImleHqRSEtyq3VXXy
 684T2vCqlYZSm52nLUX1S0lLth0IsPb2yX2/mvZpJInLQinIEyhPGEzh9agM+CtUviUg
 aRFdvXm5bMaUL5tPB8khmC7okatJzKi2aMbles+2RsP85QNZRdfCeE3iYxgiGs1D1Ell
 eiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732645868; x=1733250668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6ZaJ7dt7R/g+nKGnFSXP7pvbKBHN9lmThzElkpxBi0=;
 b=qNEECWGl9tJaoqaAfHS7r9ruNqEfvbUNadCOrtKKyDxx80kCQ0ZuwpC/1WpLte6qsJ
 NHP/Y0kcrzq6fw78vAvQ4kJnF84KhRW1RyRhX4tpLpZXvzWi0jKUgAFMkN2Vhfw+Icp1
 Oc5ekO22opNhtJpPRbulb9a/0/o3gXKmZPHYKO5Ybb8vg4XfUKf2qF04Ko/FWFD/LdMQ
 fuyOp7GfoMRus5K46f63fdVC0Kirq3qYtKOIJ7mBB35LE6Dn/moKZ7M6BA2dFSeO+9rj
 yS0JfKZc9c4s2mwBM4QE5O4PGwp/Bsb+NG409OJiZitcm+r8vTjpBg0Tg+DNMWFDuHO8
 kM6A==
X-Gm-Message-State: AOJu0YyuRtUaAgt5bOdZ10am0ikvh2TuPhoCjSyymy753QW+J9CJHGSA
 OdvTw7bXlgmMWQhtAO+PRKvVtEjXUN1synAHHMPo8jzjba7euYDTgsA+FCFfw9g=
X-Gm-Gg: ASbGnctWeqbEeWr8Xf3uNUB4qLXReRgjfE4B9Pw7AFbp8tiKN1aPnFXsCeJzL6xBW6W
 ObfZ6QcntORRLo3XIJbQzoxGQS6VfxMzsaixgOT1MGpqfcmh1IhwQAjCTDwj/I1cJAV1OxbEZcc
 BZZOf0q8cAsncWo+oqO/cz9Fu25sSfBf1P0mMm14EqjmHLkLTA8surBOQowJfD16kQpWbTNTC4+
 vxsXDdMe4Xm+HiBPNu2c/CT9PaR/Y6QB8Jw8nlp3fuCERYDCbJ/wzxr2KSyV8Csoz1iVS0pD69+
 3HuFYJgIK+qfeCBd/zYehQ==
X-Google-Smtp-Source: AGHT+IH3i2elc/feDQWrCukhSHeIyxmuSz1JMpLqGYQdrfU2ufUUoCbJLJW3PbiWYuHr/hUM9g5RcA==
X-Received: by 2002:a17:90a:d647:b0:2ea:a737:60ab with SMTP id
 98e67ed59e1d1-2ee08eb5c26mr516738a91.12.1732645866793; 
 Tue, 26 Nov 2024 10:31:06 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ead02ea3ddsm12753102a91.3.2024.11.26.10.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 10:31:06 -0800 (PST)
Message-ID: <c29584a0-527e-455d-bd3f-001b4e2ce765@linaro.org>
Date: Tue, 26 Nov 2024 10:31:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Minor fixes for Arm documentation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <CAFEAcA907AJ_x73wG83HYk1xyMksx7ij2TpLpOaVKgrOffA6og@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA907AJ_x73wG83HYk1xyMksx7ij2TpLpOaVKgrOffA6og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/26/24 08:24, Peter Maydell wrote:
> On Fri, 22 Nov 2024 at 22:52, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Reviewed following things:
>> - system/arm/cpu-features (options)
>> - system/arm/virt (options)
>> - boards documented and listed with -machine help (arm and aarch64)
>> - grep object_class_property_set_description hw/arm: ensure all options are
>>    documented
>> - reviewed boards description
>> - reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/
>>
>> The Arm section of the documentation is in very good shape, and this series only
>> has minors fixes.
>>
>> Pierrick Bouvier (12):
>>    docs/system/arm/emulation: mention armv9
>>    docs/system/arm/emulation: fix typo in feature name
>>    docs/system/arm/emulation: add FEAT_SSBS2
>>    target/arm/tcg/: fix typo in FEAT name
>>    docs/system/arm/: add FEAT_MTE_ASYNC
>>    docs/system/arm/: add FEAT_DoubleLock
>>    docs/system/arm/fby35: update link to product page
>>    docs/system/arm/orangepi: update links
>>    docs/system/arm/fby35: document execute-in-place property
>>    docs/system/arm/xlnx-versal-virt: document ospi-flash property
>>    docs/system/arm/virt: document missing properties
>>    docs/system/arm/aspeed: add missing model supermicrox11spi-bmc
> 
> I have taken the reviewed ones of these (1-7 and 12)
> so I can put them in for rc2.
> 
> thanks
> -- PMM

Thanks Peter.

