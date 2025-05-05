Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C92C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBtDO-0008Ol-DJ; Mon, 05 May 2025 06:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtDM-0008IE-Ij
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:38:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBtDK-0002ng-Qs
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:38:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso36927185e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746441501; x=1747046301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNSgMskR6RjtIyHUsyID0fTWhrdcy5O8WWTT6GLBX7Q=;
 b=ocQTS3GohN2XByoLYV7dFvXGJDAdTSzjxYwzs7+GjacuQdiaOMZI0atxzbc76WepBi
 7/4Ydz3IQl8NBUB4qbo3XfccM2IwF1KGB1Psow5Ui0ZWd3oIUN2bm/IQk0cqQRdMMdS8
 jFmBi6Bc8wD0gPUvokvSVFcCCp1w4x8KcqjiauhqbHGnpLSB6WBuOTNwpEbIFacysQRl
 9eFJWqlCcvUhS8MrzvUARiFPQluQGtAfV3jVOx7Mz1rM+sVYxnBwDVCCLlGyj8RHx4/8
 3Ez/3hSkAViXTX6LZRtDasQ9K1lqNhkPyShMysbnAEkrGlJRL+xHrQ0iEI4xSOvNejpv
 dV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746441501; x=1747046301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gNSgMskR6RjtIyHUsyID0fTWhrdcy5O8WWTT6GLBX7Q=;
 b=jLOk+qf2DostxOaIhudVBGbUeU0NL+GjPhziiMzP+W6zahanbTbBlzw1gBdZyFOpZd
 wOmbk1xCy/RAkja6pB8gX/vwaIm+VkECWH4minzrNCD357ecSNplFfPRJ1yh3OMfhJIM
 JXWH6pi7rvltESRccZOAnbnAJNyIMKWxCBWfWUji2k20hHAfz1UQc4psTtE1rdUr5C6Y
 fR+Qdt2qBRDvvjjUH3j2A+7eKmHR9DpGHopTuE4fWMfQvWZOaf+ERDRSrk6Q2mTqeqtZ
 9k7I1XhVxUAoaiq5JKK9dX0K5ck2OZGLDm5/u7fzHf3+VyP3h7FSj9wtcsbtsCJ3qDod
 Xccg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkBJjmi2V2lqgA+/PVNgmPWnR097hdDm5Q7B2lEpIwRxROs/Q5OiFKxap6q/93mP0WOtJF3FJFLcC7@nongnu.org
X-Gm-Message-State: AOJu0Yy32dHvY9VTjm30R8m/o5kjZemS8y+dWAg6wVTONlERnnRPc8wz
 n/UwTcLlx4Qpt0cFiHoQ+yIHneFHE6njCgSFmrKgSJucMuZDthfS25WhQUD3kHg=
X-Gm-Gg: ASbGncvibNFpViwMppwgJZAl7VHA3Ko8RB9TAvLxcLyYRTT4XqE7bAWfEa+3qYJDNGP
 RxnhwKHEg5J4fFgwE20pJK7ejIWujlAseB1IYLZ2aBbTWm8g9E85PnoY0QkiUSF3wjAVilQ6lqf
 iQeZ70M5TlsIlPXskCjfMq+Zq9ym6JW9v2pTXc+JLRHfMou1nOa7ZLkhig/XIP2iikgp/kYixEV
 y5TIZC6LH971xrNOl/MLJ9X2ubkSkxcVTxfoZmRBSa+MXAsrgzWe1uDYTomUjSQ62Ea3jrIPEqF
 UxgWPCb93iPKx/v66trM2wiphaIBZuOJnbfmExcxW4rDXvhnkJBZtFKexKl4EJjMbV3LGnbB3qk
 HsVkrruFK8Xvklq8bPMc4lTc=
X-Google-Smtp-Source: AGHT+IEVJcPGJFJKXIu0lUc1W0W91fMyqnJ3bg/n0s1L5Or/z/2w1kLWeopb+ojJ+Q5kcvoMyAi4aw==
X-Received: by 2002:a05:600c:b90:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-441c48d58ebmr62579505e9.15.1746441500865; 
 Mon, 05 May 2025 03:38:20 -0700 (PDT)
Received: from [10.194.152.213] (219.red-95-127-56.dynamicip.rima-tde.net.
 [95.127.56.219]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20aa6sm176790255e9.27.2025.05.05.03.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:38:19 -0700 (PDT)
Message-ID: <b854d7e6-a338-4236-bc88-527d5df635f0@linaro.org>
Date: Mon, 5 May 2025 12:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-9-philmd@linaro.org>
 <fe7f930d-e729-4ba7-b19a-342bd47048d4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fe7f930d-e729-4ba7-b19a-342bd47048d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/5/25 12:35, Thomas Huth wrote:
> On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
>> These machines has been supported for a period of more than 6 years.
>> According to our versioned machine support policy (see commit
>> ce80c4fa6ff "docs: document special exception for machine type
>> deprecation & removal") they can now be removed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc_piix.c |  9 ---------
>>   hw/i386/pc_q35.c  | 10 ----------
>>   2 files changed, 19 deletions(-)
> 
> Please also remove the related code from tests/qtest/test-x86-cpuid- 
> compat.c!

Considered in v3 ;)
https://lore.kernel.org/qemu-devel/97eadaef-7c1b-4561-af9a-bd887e00d19c@linaro.org/

