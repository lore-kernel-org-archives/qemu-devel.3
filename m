Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC7CF34D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUwK-0002jz-3t; Thu, 03 Oct 2024 19:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUwI-0002jh-AU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:08:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUwG-0004iW-Se
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:08:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b9b35c7c3so15327785ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727996931; x=1728601731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fq49TKAL9KYj/9vFkhY/8M25ZrgzMs6TnCNYxCvIdD8=;
 b=Vlj61hEIDFddcLEBlQs72O0EnQde2cUzXac0EthxSG8JfCUGPnbXYkkBLZly6Y/ij9
 SR6hFwgyEW3KiIbamtKhROb6Z/bdO5/uPjdDSa36clB4t4XsWT0qOBluDm3i8yrSd+tq
 c78R909jS6Y6NmZRCkisHH15Nsv3Je8NBkAoRQYPnf7h3wRbuJU1IOAXCwu5LWJ3w5Lg
 RTRDHvw7H1gD4WqaVvDn2kaBIyj++I2YIyQcHn/qWR8I1CfbeXtlE8UGMe/wq5mk/LJd
 jG1D4aFsFeuhk6DN7KSU12ZgQL9o2+Z1OrjtADl4+Df7mMGLBpXMBLbbqFatJ5zOQIeH
 mZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727996931; x=1728601731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fq49TKAL9KYj/9vFkhY/8M25ZrgzMs6TnCNYxCvIdD8=;
 b=vsqB1RQVzY1xEozi/97tOCPf6z2IFDl3YHYyVGdVFJ6ANxUQurXwaw7sqIi9UDWCxI
 KIIOi5UpcBrvjhoCGxCgCoUdXTMXy/eCZ6mOlyXmtiXd79LcvR4Q4kxuQ8p+U6v2uXiS
 sj4NL8MvizrtcFRqSIa0O1HDhP19yPKIJmFw42b/GY120evFL0Ztw9ozEydydXrOz/4a
 3W9tmGbt47UFE77Ih+knWexwjD6hzgJ84P7oNUq/U54I5PMHptzh9HtibnNjPN52EGVv
 ajmR0HyP4EXs0gpB2cKwkKwPEBwOOxBVa660ERrPgfuP4PyOAnZ4/A4YLrE+Lb3bhG5P
 xURg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBVPS68PwiCy3YqOtaOpvakDhovUxwVZHmVNOQCTlv2g0lBHvkc8VvIDgf67iL9X/LmuiuRmsBV1b4@nongnu.org
X-Gm-Message-State: AOJu0Yx569AdvQ+T1EmssxczzYDx0GHWa3gDJp7vZby0trZH8kSLDyig
 Sd7DKV+O80LXnQ5bO9Opsiz3DMwbEKyMsWzRRnSw4d66pYhxvclsJ7s/ta2iT9Y=
X-Google-Smtp-Source: AGHT+IH6OJ4/Uk3BY0xSOJOLFONofUTjInCargyH5ZqquWtNHXAf25T/7/V34A8Fz0nm7YlN0wT8gA==
X-Received: by 2002:a17:902:f688:b0:20b:6308:fd2f with SMTP id
 d9443c01a7336-20bfdf6bdc6mr10331065ad.11.1727996931083; 
 Thu, 03 Oct 2024 16:08:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beef8ea48sm13719805ad.149.2024.10.03.16.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 16:08:50 -0700 (PDT)
Message-ID: <9635d3ed-b60f-4406-aa57-3d8764b4f5bb@linaro.org>
Date: Thu, 3 Oct 2024 16:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org,
 linux-parisc@vger.kernel.org
References: <Zvyx1kM4JljbzxQW@p100> <87cykimsb9.fsf@draig.linaro.org>
 <CAFEAcA81YtAGO0iFZRWXGjJb91DhWEDTGr+cjWbNWEW4yJDksQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA81YtAGO0iFZRWXGjJb91DhWEDTGr+cjWbNWEW4yJDksQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/2/24 08:47, Peter Maydell wrote:
> There's also something curious going on here -- this patch
> says "we check alignment before permissions, and that's wrong
> on PARISC". But there's a comment in target/arm/ptw.c that
> says "we check permissions before alignment, and that's
> wrong on Arm":
> 
>       * Enable alignment checks on Device memory.
>       *
>       * Per R_XCHFJ, this check is mis-ordered. The correct ordering
>       * for alignment, permission, and stage 2 faults should be:
>       *    - Alignment fault caused by the memory type
>       *    - Permission fault
>       *    - A stage 2 fault on the memory access
>       * but due to the way the TCG softmmu TLB operates, we will have
>       * implicitly done the permission check and the stage2 lookup in
>       * finding the TLB entry, so the alignment check cannot be done sooner.
> 
> So do we check alignment first, or permissions first, or does
> the order vary depending on what we're doing?

There are two different alignment fault checks.  The one for 'alignment fault caused by 
memory type' is later, after we verify that the TLB entry is for the correct page, which 
implicitly tests r/w permissions.


r~

