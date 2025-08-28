Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOeQ-0008SR-Ox; Sat, 30 Aug 2025 12:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkpI-0006mn-D1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:10:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkpG-0005Wp-9R
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:10:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b55ed86b9so8331145e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756419032; x=1757023832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4IgyS4bdUdJEXom4nT0B8vFEDGGCP198DulKAudY4JM=;
 b=h07LdAOCELZFnR7Eq4HZtIErdMdAV2NuhlINLzm2Y+QmqaE1QKeJWAbx0Jd2Vzejqm
 Dn3zAX0Ifjc0/+JJ2ICToyA28byxum7P1FLWJAFEgKuWq1OsD6yYNEqCIvp1LMbHI79M
 YyKQPo8pFL/SqeHzJ6nJJQpcCJ43AdRmxWolDOkixsSs9baORSpJeFJTBHNaQVnCeIG8
 3h4zWXm7wR4uq17ONzS55T+hjYp12CUNyCoLSXxYvg6o2Gm+4c7L55TiriNPOQuZagLj
 y/XJwhAcKoP2YJk5JfiZVqOZ5xruJ41CUcH3d4kHwV1BZZp/3Aj1lABkAXY1WsqNLLOt
 WvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756419032; x=1757023832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4IgyS4bdUdJEXom4nT0B8vFEDGGCP198DulKAudY4JM=;
 b=nccgR5fY72vrpfRe3cOhFRDQvDSP5I58buKsVn2S8JktrJD2vgDrzKm3iwBhy8j+Sn
 IhgSGwuJNAS85P0YvTlHTCkI0w4Rkpch4q5amjSSuSIewD3EsSUMSGZF7ra1HBdMDmMU
 6er38e7GhF8gYC7dXRXGKmpiOXpQ/9/RH0DsqIPGRkBBgWMAOA5ytQwc0IXI3CyG48uF
 kfwV3B73HU0UoAIbs/VwIvcqoGwKyA92p7JB6LayLE4pQ3DdbE7zWjcFsIdF3JJJ8psb
 rR9KEbjjR5Krd1Bew6mWyaqSWj2+X4pOiJkJu/sQpmGl0oefxX59ciwVIOYtVkhUriNY
 yfvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7JnZzryzyWP2r8xhX6vQbZ3iXv8vO4KQ/WZhfrvpT53hJll5c5vwUBQ7ECQhDIWA50lTWlOEUuHol@nongnu.org
X-Gm-Message-State: AOJu0YxTeVghPpS9J5OjUFH4JosSSMSJgkiQPcZCyQ++eMwtLQrXQyT5
 xXqtCozqf9/rqvwj4X1fT3BZdIuerRLyTRcCLNz2EdDbl/+9jOgcVPH6m9vAX3eNRUs=
X-Gm-Gg: ASbGncsXW8x4GR/i6MwT4c9/hGak+E+dVycTJg5eox+Kz42oCMNYbiKaqUgzGlPMYJT
 lyJ6A0cJR+C3wKOThuNpKCaztH6VnZ8dBVuAl955O3TUtkO0H744dFJqubEgTdPhJgWp8Bx0Zah
 qYtFHmq1HtUSeRBDnN6mtiHQlUY/oHxJV7VJDjn/Sdkos2Q58u99IDjH7MzWOLExrKCt5CGbyB6
 tGi8VKzNY8p9nBLzrF8/PQ6SC7zJj1yNWBnQwje3uIYTJiYInNjI7IEeVX1Dmq4p55Oce7yNld8
 BhB7eDqkBF9VVqt1NgdvvSGmno5JZDRKgJlc/9BboOy3WuWMCYyUlCONaRrbdS3DsWeR/4ruOHH
 i3FrYoKl4Pqh/gvBQzbPejgKWGIdlm7+LhiWwvZX0biZf49pogeVAHMYwj3FEfJCCO6zvx86uDd
 9R
X-Google-Smtp-Source: AGHT+IHScl1KSy8c6rgO/fZq1i52I8Tb+tOJ0kvl4c72DlD6QicoGVNLCVHONIw9rIcPPOjYu4mJTA==
X-Received: by 2002:a05:6000:2508:b0:3c7:df1d:3d9 with SMTP id
 ffacd0b85a97d-3c7df1d0518mr13968837f8f.39.1756419031814; 
 Thu, 28 Aug 2025 15:10:31 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf346811b3sm794670f8f.63.2025.08.28.15.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:10:31 -0700 (PDT)
Message-ID: <5ae93843-0059-4077-8158-6fd272f2e10d@linaro.org>
Date: Fri, 29 Aug 2025 00:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/47] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-13-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-13-luc.michel@amd.com>
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

On 22/8/25 17:15, Luc Michel wrote:
> Improve the IRQ index in the VersalMap structure to turn it into a
> descriptor:
>     - the lower 16 bits still represent the IRQ index
>     - bit 18 is used to indicate a shared IRQ connected to a OR gate
>     - bits 19 to 22 indicate the index on the OR gate.
> 
> This allows to share an IRQ among multiple devices. An OR gate is
> created to connect the devices to the actual IRQ pin.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   hw/arm/xlnx-versal.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


