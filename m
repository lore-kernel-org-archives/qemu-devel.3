Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D5EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snypo-0006Cu-D2; Tue, 10 Sep 2024 07:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snypm-00069E-EK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:14:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snypk-0001jU-PF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:14:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so244688366b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725966894; x=1726571694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x0pulItEXOWsNF3cDrfpo0O4UbhaQ8zuHUZw9W5EWUU=;
 b=LVH+LbXjsFw2mPrAe0WcCHbRkUGcQvrg7352ABSGpqCv7eopUTzKKe4pjT+hvjwhW7
 wDeStIEQtkHONyA98zCTwmIqtta2RoMIXwmY16NSgLG8KwFlKnzD0xHGy55vpRz+NKMQ
 GDOw89xJU4rAUH4ChHh1wPCPD3Rx9gN7xNv38kADDFuu/mkpNG9ae2vXkGF2ydlqW2qR
 Ge4zR1yRiM8sdPe6a1KvhDVeCULmL1sijNIht2Edy3k+ukqxVBLO2ylSLCxE6brbPrMQ
 SpCyFRw8Rse/gJc+EJpo1ll/ec8gLB0n70sJpF+jC6nUnTf6jQvCUsGqXTCuMG4zWTPK
 aJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725966894; x=1726571694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0pulItEXOWsNF3cDrfpo0O4UbhaQ8zuHUZw9W5EWUU=;
 b=k6yDeYwbLnAIUoB+xdnfsd6/PP8ld/Dh6fQZcJ3BI/mkWtl+YoO1eAaEwATxkp43mb
 yITsMCKENNzJ9KDjc+m5Q32yZp1X9HFX3KRsLeQ6+EmU6G3g3by4dQjaVzCqLPSRN9nK
 9IwKSFyxUBkNPeReToSoWeONX3gsxV7grFSAj7SEERCQsP0ymHFK8lADQ0yG6sAhaJdf
 OffyXuQz+UZ3ubtCrr2SlOwFMlLsZSPvKPYzLYFOJV+Ok3vnCkaPtN5g9dYK5yevU6vT
 PSuKZxvRPxnzX0iiJ4hp/B093DSLlT6pyaFZjbpho79ovU/psgL0SGBNm3tpiJJcUho4
 2YRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIZXT+zg16blfOvIafX/DMFQ2YWn8Eko0qliLnVssFElLikDlsNX/MnR6KCGVFFn2YNjPTkMpZbk2D@nongnu.org
X-Gm-Message-State: AOJu0YwGGxhUTHJ5/D+tj8myJzl3gxDz8b/5GVPHodABM2V5R/7MwqpW
 kLoSjOpUsSpPCqAINWWybE2vBnir/QsZsLWNnmTE4NMqxx9+slxiQ8kTOvOxpyU=
X-Google-Smtp-Source: AGHT+IFfXydW3Mp2LAuhCfQZPM2stAqYc/36zO99X91jjdv5XaslktHSlfrF6Gc2zPAJFfBewqWitA==
X-Received: by 2002:a17:907:1c0f:b0:a8d:2ab2:c9a0 with SMTP id
 a640c23a62f3a-a8ffae1d94cmr35933666b.53.1725966894513; 
 Tue, 10 Sep 2024 04:14:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2593d088sm469519966b.53.2024.09.10.04.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 04:14:54 -0700 (PDT)
Message-ID: <933410c1-686f-4ce6-b0c3-aea2f293814a@linaro.org>
Date: Tue, 10 Sep 2024 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix bad usage of has_cmd
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240910075820.51346-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910075820.51346-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/9/24 09:58, Thomas Huth wrote:
> has_cmd returns a tuple, not a boolean value. This fixes a crash when
> e.g. "tesseract" is not available in the test_m68k_nextcube test.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py       | 6 +++---
>   tests/functional/qemu_test/tesseract.py | 3 ++-
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


