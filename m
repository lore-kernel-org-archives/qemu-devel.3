Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25897CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO5Y-0004Kh-SA; Sat, 30 Aug 2025 12:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkia-0005P4-Aj
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:03:41 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkiY-0002tW-Dp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:03:40 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4c738ee2fbso658260a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418615; x=1757023415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4M9cm8Aazb+KJpA5IGIdk2z8pOTonrvhPx7widSniyM=;
 b=UgMpIIAh8fsA126b2mU0h9YjiYxPaKTwvHDJi5o4/lI8UifirYIViLb4/vvJrSMo7i
 MHr/BjU06GLIQQ/SVbgXBNWwFQymOfq20o/Q7TVFsuWtFOxHmkWBqGU38gGvEf+mKKtS
 2ADxBv16lXYFf+CPjlZUV8FEUTEOKZFzL9fImBrg+JiwToGRJPFvEWvOZGCpKAyOg6ZA
 M86jLGMqoYMHlG6rahaPzzH9GaSdu+v+Ruw057HpLB+4Zj6rL31thmm1pazryELLfNrM
 OCx2VJsjEyW3ZpMJrdkOzoWq1bSfmaPRpx6roHq8Me8634Rg0IU2qDXH/UzZjWNxBSkb
 sDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418615; x=1757023415;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4M9cm8Aazb+KJpA5IGIdk2z8pOTonrvhPx7widSniyM=;
 b=dC+gYFGBx05VN1uNwJulGnKTyJRDS3+0xSVQ6Z544nqsHUirkC+ULF8yXnjcU0orTG
 5BLg48zUQOpvAldWdVM3yDi802aG8q22rBKYGRL7XFtuJiPqbs4PxecAmVH8CqSRR1uQ
 O/VdPUo/49+5pGISztfSv4AzYgX2Qtn4qv9FvTNztL/u05dmuxaiNwA1ZxVZ1lj0ei/O
 bIKM1JZ858TO6ItwnM4ZSyBWjdfi2IZ8Lahf7qBixWVG9CEvR1sI1XR4XoSbVg7sj1Hg
 FxhoorRwvahUDzYgPQuBvz1C/4242rUt5YtHsRaG0bPnfsf5BpPK8Pk3M02zTlDunCQq
 1keg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo0CAmdhlRW0Y1Y/pnZVcAaNjkDdEtzVPbSHnDm1b1l3jkpqDbab3BZtFtpf55NXQf//BW/YJYPVpn@nongnu.org
X-Gm-Message-State: AOJu0YxvSTm2/7iDndzqSNA7pftFoU9RS0Yt8Ym016Py+wqrbQ9NrfrA
 EpP0+4L3GvrrNQI0Lrio5wid9R/fakuQ86Czxr3zmo+LuvGgia9DTWFapzBzA/VY9XONMNj4mte
 5GyB2WVk=
X-Gm-Gg: ASbGncsy4XJeBgEVmkgD/d/VOrsocAVAy8jJHKFGaeFPjkKbH4tTGtf75Zri6asHWXk
 6VOTwRPMWYNLEuvIuqV56W+5+rHP88QjQ3U9E07KU3/khu94jegGc4IZ+uU6+nGVdTdMxP9+ozU
 TMOwczUMXfX4zMGzQba1mU8gBXH+ai8ollIoUzP+nd44GZ4QeNkhbQYVlSOdMrR/l4J6hjCwXM2
 0sxXi3S+FHkg4TMNWALcZ6VY/rSsFbaAmA5juLJgVTn4DXyXk46Uz83gEIr9EHCASC+SJR6w1Il
 N+V8rFoaj0jTPSGhwMXLWQBWgR51WKqq18pA29ywVwcTrnz1q8SZkqon2DHFYOU5M/cd4WXCR1f
 lsCegQw21PNXUQpVlaOjHNQw/uwuIYPbVvSQi
X-Google-Smtp-Source: AGHT+IH77HgtphMfUjDHKo0mPZwZLG1fwVuEfdqHuo1XrojWzDdV3y1JPJ/b6Odi6n+kC0DrGfpXwQ==
X-Received: by 2002:a17:902:f543:b0:246:7a11:3775 with SMTP id
 d9443c01a7336-2467a113b1amr258167335ad.48.1756418614818; 
 Thu, 28 Aug 2025 15:03:34 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065d1ef4sm5032555ad.134.2025.08.28.15.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:03:34 -0700 (PDT)
Message-ID: <fec1ee2a-f141-4c5f-b7a8-debe404b9d47@linaro.org>
Date: Fri, 29 Aug 2025 08:03:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/arm: Remove deprecated pxa CPUs and
 xscale/iwmmxt code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828140422.3271703-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/29/25 00:04, Peter Maydell wrote:
> Peter Maydell (5):
>    target/arm: Remove deprecated pxa CPU family
>    target/arm: Remove XScale and iWMMXt translate.c code
>    target/arm: Remove iwmmxt helper functions
>    target/arm: Drop ARM_FEATURE_XSCALE handling
>    target/arm: Drop ARM_FEATURE_IWMMXT handling

Woohoo!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

