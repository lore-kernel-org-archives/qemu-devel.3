Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B538D10BE3
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YbT-0000vN-JM; Sat, 26 Oct 2024 00:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YbO-0000pq-HL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:40:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YbL-0001H5-Rd
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:40:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cbcd71012so27095225ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917634; x=1730522434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RmuO6LemlOy23kX5W4IYXwDTu+5KnaCskorosCuINQ=;
 b=ez8Pqq5D1e5hOrRRzedL2q+TiIS6aYfbKmYMwKrEs8PFE0Odlc8+CR533HIEyl8wob
 QRzOdLWGpT2OL3Lb+zDyLcZiLxKiy8r4wgZ7yA/ti1OF3jExFbgg2Iau7FDoxsCaBW8Y
 KNtpVO4QR9JIaidstr0+GcHPo8pdSXjIYz3WfN3sVCbPErNFsP6XH+bfi5mYXnYMQAh8
 gR4mT3IxfSpp/hRwJc9U/3zgxC72h9X4Sk5WSTDsgjuH7NqkHr8YpdYh+sSRx6NWBfXD
 bq9hvXTt9gKG8n5mPE3GlbDVqP9PFKdWbBJFznVqqqMuHXPinw4pmWLpDAht8/RbXNK9
 gpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917634; x=1730522434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RmuO6LemlOy23kX5W4IYXwDTu+5KnaCskorosCuINQ=;
 b=gawJ5wdpGp8DGpArxb72S0zTCr4qpAQgRW67ZKoEl0FZoQusIp42LXal7LYkk+G2m4
 AYOhYDE0yLxqfpL0dxZ1Dd/eZjHBeJ3veZ5PqFwg8X7umsnf2VXE4C1X7Ek8tE55e7b4
 QAfyVlB/jmSr2bV9HpHXJ7C5zPwG36AplF+TVNYVHqfTu0n3dCCVcBfK5EwPNcdjLy4T
 ORZOubB0qDL4ZrGVGb7dKSn8kUCIXDGP7Azbtww7iFoXR6jqYzWja1Yxdqfd61ihavvj
 Iqz3n35y00D8NwQW48pM1XeUTn85yvYDwOmudis+m1JgjgrByCqnP4OMDojuaq+hIKpu
 8IEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU4STLeVuJrMvNRSg1+69V97nwabKHuD5nwgLgwCAapoCqUa8vV5TCJo8dydpQOnIml+Pi5+btamHM@nongnu.org
X-Gm-Message-State: AOJu0Yw8q7O0/xD5TKXqTiafYyN+Kl/25mkHvCDY+6oNCN6N9lGuWoHw
 gJ1YLgLysIEujFPxgs6Y+V/RnU7qoAj+XOa8kgCl+a9MqeD8m6iJ0cocFPRo/G/5vy9CY/o2eFU
 x
X-Google-Smtp-Source: AGHT+IHVhL+alcOrMMwvs3VCt3CaEx/8TgbCrJSDHTxncDhDIi3QoShfBQSU3bxE3uXYOTD/xVm4og==
X-Received: by 2002:a17:903:2306:b0:20c:9d79:cf82 with SMTP id
 d9443c01a7336-210c6ccfad1mr15870575ad.58.1729917633954; 
 Fri, 25 Oct 2024 21:40:33 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc0133acsm17240735ad.130.2024.10.25.21.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:40:33 -0700 (PDT)
Message-ID: <57e94c7c-fd6f-4036-abf2-24926e9619f0@linaro.org>
Date: Sat, 26 Oct 2024 01:40:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] target/s390x: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the 2-NaN propagation rule explicitly in env->fpu_status.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/s390x/cpu.c             | 1 +
>   fpu/softfloat-specialize.c.inc | 5 ++---
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


