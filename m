Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2881C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgA8-0002Nk-0o; Tue, 02 Jul 2024 12:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgA6-0002MP-8g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:15:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgA4-0006ds-4p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:15:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367601ca463so2544778f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936913; x=1720541713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kafpZzNPikCVXSY6I6GTZ3uNoei0so0bS6AO9UIGwCE=;
 b=qndOUNDvbTVVR2LBWAa2iyX2x13Vdorp8Z0DV/nk9c89Z0heCmr10QKeLYPno/dNOj
 R2YB2ON40VNoRls61usTI5pYB/8sRcjGkiiakExVKo/U6aUoi838NzXDpotdruCPMV7D
 lxD1Cc8YUzLnYFr/GBOPUOJkZzIYFEqvZ9+vjniBvrDxYZMGS6AGP3X+070dpzGoBVLA
 ftLFUCArB/SWswhzLY+7X3iA93HjQ2y1zBDAs+qybmgTywvL3eqdZsgp9UCxQ/TRBJ2+
 JAfNW6ah+ddPgmmga1VOoc1DBDHgGPq9zCd+/Hg5pwXka2V7nMlDJOapHv0cSRIqNKT8
 EXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936913; x=1720541713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kafpZzNPikCVXSY6I6GTZ3uNoei0so0bS6AO9UIGwCE=;
 b=JZFLfJEb39Ijp3WTB2SzsdGFdvKB8Y+33jtIDmkLQHDCli87BthYdwQURl+Uy8dvP4
 nSEU264pPlHq4x+XVvDpmKtQhDigTlcivCUShYyzho+Hr3LxKXTtsHgS9fX59wkbYo8D
 Hl+YDGwhS37s0aeBfST7f3RmNJ1J/d+PM8+LeUpG6B7wz5N1v06ucqmCy60FJdGpeKKo
 RY9Ns/vBOek15fLqGHIDDtwVD+Q66xjhIMR+PiEVap7nZKRe9kb6rMIF43s4m+x6HcNL
 HPx7afq2+PbBlW6aMVQSojGT8GNPwCdnRu7cz0ijRrvgVtPRWLhvLnGYoMAeyt2ATvZu
 UyPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBIbZnjbZ7pYBE3RUfCGrrfAg1dsAV4uWWRKk0YTOpqeSUMskyoadSkUooO5GpTqjaEtSf76ti1clUjHXpN1mUxntaTTs=
X-Gm-Message-State: AOJu0YwDuSB7yhqgtkURL09VeQOD+xOW2Z2G2dCCmoG9arAjadPTUa4d
 Txib9371mXRPJ68AoJG495NQMDJnsX/8GQKYeOmZDS5Z6CbLz4Y1XJxc3hThPWM=
X-Google-Smtp-Source: AGHT+IH3PfoX74QtSJdXP+gN0MitSovc6zNGLv59u7CnU/hLCsxFGuuJc1dgIe10tJvMUK6igVJtxg==
X-Received: by 2002:a5d:6483:0:b0:366:e89c:342e with SMTP id
 ffacd0b85a97d-3677571b6bcmr6624066f8f.53.1719936913238; 
 Tue, 02 Jul 2024 09:15:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8daasm13559315f8f.30.2024.07.02.09.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:15:12 -0700 (PDT)
Message-ID: <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
Date: Tue, 2 Jul 2024 18:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
 <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2/7/24 07:06, Andrew Jeffery wrote:
> On Fri, 2024-06-28 at 11:16 +0200, Cédric Le Goater wrote:
>> On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
>>> When booting U-boot/Linux on Aspeed boards via eMMC,
>>> some commands don't behave as expected from the spec.
>>>
>>> Add the 'x-aspeed-emmc-kludge' property to allow non
>>> standard uses until we figure out the reasons.
>>
>> I am not aware of any singularity in the eMMC logic provided by Aspeed.
>> U-Boot and Linux drivers seem very generic. May be others can tell.
> 
> I'm not aware of any command kludges. The main problem I had when I
> wrote the Linux driver for the Aspeed controller was the phase tuning,
> but that doesn't sound related.

Yeah I don't think anything Aspeed nor U-boot related, we
model CSD/CID registers per the SD spec, not MMC. Various
fields are identical, but few differ, this might be the
problem.

I rather respect the spec by default, so until we figure
the issue, are you OK to use a 'x-emmc-kludge' property
and set it on the Aspeed boards?

