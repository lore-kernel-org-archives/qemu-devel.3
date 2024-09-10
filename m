Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51C4ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1wY-0002jX-AP; Tue, 10 Sep 2024 10:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1wQ-0002Si-Dy
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:34:02 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1wO-0001Vl-TH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:34:02 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d29b7edc2so448939666b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725978839; x=1726583639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LuQOXsZmhBvhlFdXkQhwG9jubmnqYTr/GtKVU1B7PsQ=;
 b=COaeUjEGzw2y8TVlOJJREshnyEgdc4BGx+yHVSN0l27jfV6XjofzQlCVa25SA8d6aH
 Mwst91SFR2CtUiGCmZG4Y34Uc38XD8xC9HdaoiV2iid5VuWC9GN2Gg2ehQcG0b5WSvQW
 v2gAx/cw4VGSt6uY77FyxYvTf6WtxG9G8V61nmRo3kUaud0IgL5wdZz8JhHP8RR6SsUw
 mgfkcXj5iZWJ5WsfAOtfii62MtCBjT8CKiskN8RyMbXOOKQ4e0/J1/M/v0j+HWCay9MF
 pqk39cnAigebrz9eS7S6fbngPE2nozFQ53sfS8MWH09czU3raYHhKQOXwkCStJO7W4xJ
 NrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725978839; x=1726583639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LuQOXsZmhBvhlFdXkQhwG9jubmnqYTr/GtKVU1B7PsQ=;
 b=d1VlWU7iAVuWjx4vftCxMBGDMjgWNH0GITYKvdIEA2/JzeyIivDsif3YZiSKVqHmVM
 KHKDIagHdNksuNQwDqtSI2ckbni00S8J57JCuU96RIkhC3fQZMh+69+QlhfT0gyhYlE+
 YlACIb8Xw3PauEv0AtyP+5nNeYcejUXYIxZ0qgdk2B7I61DOcyY0OPDUYJWZ3slLF20R
 wDmLXS3OmtwRh2BD1gHQR0Xx33bGjM+QWkcOihWVMCvZP1+rwGBkhoUk588/DApuG00/
 bWkzeF3Ic/+WDF94nxnmu73jPDUNFv3dHERbxDE9lomamCUS0da5fXPxyxsINy+d9hLL
 ZaFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVssxBjvezSdrHaRJgb5IZoQJvwX5ZFUux8vAAEnKlC2qHp5PyOJJ1FFuZMlqeLS7oNDjm7Uky4ruEu@nongnu.org
X-Gm-Message-State: AOJu0YxSMO6znSy025yHOpICTO7KZLfu77tU+G8y0Xp5YsGbVCrjgpOU
 z2Nh0M044c25yfknZx3eQAg1bE4pNk+hL65vHS0GAbQdd2qk3fq6c4F5u4KydoU=
X-Google-Smtp-Source: AGHT+IHBXyYofeLN0dABoGVXGBAABn/FFxzf9QVFO9ZDv+bxiXNtgmjH1D0BT36yjfmtpzYjmOHGcA==
X-Received: by 2002:a17:907:869f:b0:a86:78fd:1df0 with SMTP id
 a640c23a62f3a-a8ffab8353amr86117466b.34.1725978838480; 
 Tue, 10 Sep 2024 07:33:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ceaf86sm487678966b.155.2024.09.10.07.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:33:57 -0700 (PDT)
Message-ID: <0a00b59d-fdd7-47de-b3bd-62aed07d295e@linaro.org>
Date: Tue, 10 Sep 2024 16:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/pci-host/designware: Declare CPU QOM types using
 DEFINE_TYPES() macro
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-2-philmd@linaro.org>
 <2f3df725-0d99-97d0-af7b-7054036e4228@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2f3df725-0d99-97d0-af7b-7054036e4228@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 19/8/24 06:21, Gustavo Romero wrote:
> Hi Phil,
> 
> On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
>> When multiple QOM types are registered in the same file,
>> it is simpler to use the the DEFINE_TYPES() macro. In
>> particular because type array declared with such macro
>> are easier to review.
>>
>> Remove a pointless structure declaration in "designware.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   include/hw/pci-host/designware.h |  2 --
>>   hw/pci-host/designware.c         | 39 ++++++++++++++------------------
>>   2 files changed, 17 insertions(+), 24 deletions(-)


> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> 
> This patch can get merged independently of this series.

OK, thank you!


