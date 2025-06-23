Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEAFC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfl4-0001P5-0L; Mon, 23 Jun 2025 07:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfkz-0001Ol-9m
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:54:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfkx-0005Hf-Bj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:54:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso3557513f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750679672; x=1751284472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mA1bPn5/VKcYzEd4AJcMgbdM29kFbTpL6cqkZBp0IqU=;
 b=r6pcCw2DKxDbWNQOxQhi35uvyo10bYRwiIu3lXm2xlHkPQhEZTKksuqhPqqbXvWMk0
 2A/gyQgjQaN7+XeyPDuq2fIVIhevXPsuJnEruzDfHtBqHQ6aU8U4DrWo4jxoJCohdxql
 OaQzbjc49hd5bjsI9HSPjEQfG5D/+le/IMCdAg8yvhbJx2Zcu0q6zdv+1/FTWgvWmpMr
 760yomcmyjgdYGy552GDhB2vhEZYpj4GUpk7VeNJpwUq7pFLI/G7iRm8oLVI4QN5thB5
 CwWJMDRi+jeS+OZFrhiqp369PSZQNlQIIvC3fD6lqilXMWuF8Eye46Ti+0wBpadVXvs8
 gqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679672; x=1751284472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mA1bPn5/VKcYzEd4AJcMgbdM29kFbTpL6cqkZBp0IqU=;
 b=rh890lIHje2r0VFpfFENTbCt+jJHYa/6IaakpYSzZnWfmDPS0u7nA4xfxq94rwVjZ1
 GYcrK8ExKrsJudeiy70Dhydg/wBDbekovmfNUamo/v74DGTLvgGHKG344/2JpF6IMQop
 MyysRlpubERCu7lafGqtt7RSsHjIfF0EroHcuGXPPszbcii5EAFi94F7Wm8fbbaIfRfA
 H7Oa+sekaFKR/N51ScnAuIRNCnrsKBjSWGnmJXMNWapX3IAVjefc7wprWxPS6m3+4kzc
 pzmAE5YTZprmPJ/lHykvnk3Vf2iLFTT2+th7FHd6dHiTFcQMOp2C3tqtt5Doh0ax5ZWU
 3Ylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Tn5G466pske2y7LSMY/fJHrbEnLdzbUB3oxEeP3FYG0qK7RStvwRsXUw7RpoG72CpQDBvIU+Ynyp@nongnu.org
X-Gm-Message-State: AOJu0Yw5bvTru4zIepSq29pRe5uEsyYIUF3yKLx65s6Y6XV6GvbI8HLw
 jFQllo+pc460duOYKACwS2R+ipJrzfmgHWopb8csvflT8/sXxAA2TNlsYMHQ2MxO0po=
X-Gm-Gg: ASbGncswzhftzb/Neglyf8dIIGhibXltogMbGHk3STHTTVsXlOW16Ucb3DwCJZZxi8T
 5kAsZm34Anq5msepceH9FG2GUuxnSTXExhMx7M9x9EPzH7Pu9delc4y4Z341eO75MM4Q9rNxSPv
 hfS/ZEwbF3iXvGgS1f3P9Mu8RXxw1fZo7rIkn0lgYbDd90WBDF97UEDW4yppy9sGk+DNTyZtKvK
 7hYAYpMZ090VfRme5G/qxrG+XdLWD8qZWsioE4yXtgGGHyrHmXd4gmZJSec0XnbX9FvwHi/v3qi
 8V3c0RRAq0cyYIrBVxHW/2pEn5OKcq/sx4nSOlzWKlRoD1l04N4VsCSbrt3P2l7A3ZH7XncmKK8
 2tXZT6saHoiaR87KA+WcbBBh0CeUcDQ==
X-Google-Smtp-Source: AGHT+IECw1gIHOR0QOBsHa/SDc+jBWm8t+IURqICdiK8HE4kWpV03x7yosYd71lVv5bIijrW7Li9TQ==
X-Received: by 2002:adf:9c8c:0:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a6d1318226mr9569094f8f.59.1750679672219; 
 Mon, 23 Jun 2025 04:54:32 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19b30sm9469755f8f.37.2025.06.23.04.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 04:54:31 -0700 (PDT)
Message-ID: <76730787-f153-474d-859f-0f51ede79e93@linaro.org>
Date: Mon, 23 Jun 2025 13:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/26] tests/functional: Require TCG to run Aarch64
 imx8mp-evk test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-25-philmd@linaro.org>
 <3896c4a8-8b25-45e0-978c-1539648ab4cc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3896c4a8-8b25-45e0-978c-1539648ab4cc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 23/6/25 10:19, Thomas Huth wrote:
> On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
>> The imx8mp-evk machine is only built when TCG is available.
> 
> The rationale here sounds wrong. If the machine is only built with TCG, 
> then the set_machine() should be good enough to check whether it's 
> available.
> So I'd rather say:
> 
> "The imx8mp-evk machine can only run with the TCG accelerator".

Yes, you are correct.
> 
> With that update:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks :)

>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_aarch64_imx8mp_evk.py | 1 +
>>   1 file changed, 1 insertion(+)


