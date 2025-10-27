Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC9CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMae-0004Kf-1W; Mon, 27 Oct 2025 08:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMaR-0004JJ-I3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:44:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMaN-00081V-0E
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:44:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42966ce6dbdso3321400f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761569065; x=1762173865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcfkUom/MFuUAQ2HDK1FZ+JloUZapqNhO5zz1GlSmhI=;
 b=JHCJj5qr580ysg/b7EqEfxCcJermQi2HDN5njq5mLjV4zdhT2eviVSah0O9cmhDuwW
 Re9u3OtaRR9A8dapoSvRZmYeudABKLZ15jAJlCYg6+A0zPZ2y9gcjWp5/5J9feI4s75O
 U+77h6BMeiBp341dGPwjyxG4N6KvXHZIxvAv4+ZzxGHZpwiLGV6Dzw16x5RpkptxBBKs
 ttJWq3Etpolkp2GhxgNaUeVvkNsL5LSpU+Nlpg+UJl/1pI566YNnjbMiiaBV9AXFgWL/
 cPOWKKFP73FLu/vT4bxdDL1nTaQbk2QKYn8/N0t0TG6QUna3a0XU1qj8bcwsYSx4Rqya
 BN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761569065; x=1762173865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcfkUom/MFuUAQ2HDK1FZ+JloUZapqNhO5zz1GlSmhI=;
 b=mbcdnty8mhpplLZB7cHV0Kycet4c5qk+r8syL0bszc91bWJrMKR3+yp88KPnuOwrch
 S2jxoN7KlT/T+G7Ik8P3kcHhf63DRTPYI9x359CwnZ6JfksaUkYAXShZSvXN02s+m4Tf
 4D//9IGQWOv6lilHu+l89w6Tir9k1Ta05Cb0vfa59LLGmaaTn/YGkOavk8wL4bdWLdkO
 1nbmSQnq075sNoopalVwBaDT2IjzKXzJJcZjhkbiXquDWetJlCP8YzMr9XNb94I4TsHJ
 11fxMpbaMyEV4t1veQPHXdzyc1/qF/sbsgxZPJQWjIzsAy5h+xRw1GCOBDcTkuaE9ZN4
 HcaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0OnK21wunfA5b7ASDHQn49CEzht29qIfmnibc470Wzx27Z2laX+n7RPObisWFDvbeRK1yGhmBG0vN@nongnu.org
X-Gm-Message-State: AOJu0YzuVU8xfOmHztx8+FYg7lRQy6Ag/6vPwZ8x1Kn5Rwow/xM1Jjem
 HFuVxb47pbeXv7cAG8qIuFpZcx/wmgtkm8FsIZkjZZsH3L6JTy7DQo6xpuLRbygRrUA=
X-Gm-Gg: ASbGncuw1o2UbVgThfARxUrd6N3YZifwtEPVwtG6vBLYyXD0+qTZHWlonxicoq7gYFN
 2aTAtKI6oEFEPpRHwyFwxtAFgt+T7uS3EeLZTIFAPHKwUneOcIwKsmwv5/Tcwjf8iL70Zz5xZjt
 gNPwsNfpnUKYP6SpCacxlP6hRmgrNgp0P5Arz2khsG2q7e4AfX8LcwlewCilVl/FVhRBgnKT1NC
 HG3Cj2PclhJVxYzEB3UWhYk+rHqkTipc6iLYDdxmGP7CjjBy8jkwh69h0Nxq/EDUgQx0WSciT7Y
 6B1ygMhJVDlfsxcscRP8JxBEqIEk6nz985l5E1SFD3hCoThsqhdXzdezqapaYyo0kdIvPgCj5zm
 du+bQgq58Wf785tN5mJ/h308i8KmmzFhA8fmE2+YT+617SpGCjWac1KgDl3m28oD0T21xJ0AZJx
 V3IfZF9PR+5OqSwOV3trbpZxWY7MYGZwiAH3c/KEWXZD4hiuOOfz6wDw==
X-Google-Smtp-Source: AGHT+IExEvZCeuvLtxeBioiqP3vMkv2XmwF7BgQ6I+q9nBvMzXpsciDj/5f+Uo/0itKx+V6ZXkMmUQ==
X-Received: by 2002:a5d:5c89:0:b0:425:7406:d298 with SMTP id
 ffacd0b85a97d-42704d7e9ebmr30595927f8f.5.1761569065157; 
 Mon, 27 Oct 2025 05:44:25 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7e8sm14428346f8f.19.2025.10.27.05.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:44:24 -0700 (PDT)
Message-ID: <e37fa4ac-b1c9-4b95-8904-7435d351f5a6@linaro.org>
Date: Mon, 27 Oct 2025 13:44:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
 <aP9dvF1unTtLrSdQ@redhat.com>
 <9d287284-1cb2-4126-b7d7-9c57b32ce408@linaro.org>
 <aP9nCeWC-qr248iZ@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aP9nCeWC-qr248iZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 27/10/25 13:35, Daniel P. Berrangé wrote:
> On Mon, Oct 27, 2025 at 01:23:56PM +0100, Philippe Mathieu-Daudé wrote:
>> On 27/10/25 12:55, Daniel P. Berrangé wrote:
>>> On Fri, Oct 17, 2025 at 02:03:54PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Enable user-instantiation so that PCI-attached eMMCs can be created for
>>>> virt machines, for QA purposes for the eMMC model itself and for complex
>>>> firmware/OS integrations using the upcoming RPMB partition support.
>>>
>>> IIUC, the 'emmc' device wants an 'sd-bus' but this commit talks about
>>> it being PCI-attached ?
>>
>> Sigh, it should not, but it got introduced this way and we didn't
>> have time / energy / good reason to rework the code, which currently
>> just works.
>>
>> SD / MMC cards -> plugged over external SD bus
>>
>> embedded MMC cards -> no SD bus, directly mmio-mapped.
>>
>>>
>>> Can you elaborate on / illustrate the usage example for an end user ?
>>
>> Saving time by testing virtual hardware, without having to implement a
>> real model.
> 
> Ok, more specifically, what are the suggested QEMU command line
> args to make use of this with PCI ?

See patch #6 documentation:

+    -drive file=emmc.img,if=none,format=raw,id=emmc-img
+    -device sdhci-pci
+    -device 
emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-partition-size=2097152

