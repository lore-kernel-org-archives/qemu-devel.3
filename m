Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49E9CF9C72
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 17:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8N0-0006JL-TL; Thu, 20 Nov 2025 12:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8Mw-0006IQ-CT
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:22:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8Mu-0006rQ-Sc
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:22:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so6809175e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763659371; x=1764264171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w7/bhTBuqXygs3SjeD1vsbq+BPLEUDnZ/PFf53GOgrU=;
 b=wCJofuS3sLg8v8VSSWr5Q/NR96mBvLYKOYDcCZmBBl1hQ58jazFj2FA2cukEKkBEIN
 kHRk43nkI06ds+zE3D4MkzyWvXjfq2ZiUhZlhOUz0K6RUfDZjXgW5+DYmdw/XaNJxJxV
 JPjBoPV5c+McvkpWKrCBal12VG3LXpqLQsXXN6u5uz/TnKZGZfJydABeVDsWGeKi0tYX
 CxHCcXelsBtRwl9OEHYJIXufWvs24cKWSp/i2bz1maiC/tA0dceq2KdgkAgfB2T74KaM
 189daputrCgegXUzOF/9AxcCwTGrFoCOujvZNWiBHC/JG9ZPDJKGPmpuQ/VslON1OR5f
 TbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763659371; x=1764264171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w7/bhTBuqXygs3SjeD1vsbq+BPLEUDnZ/PFf53GOgrU=;
 b=QSAE1Yw6fl+jGnmvw2uhrukJ5CgqoriFd0Oz3Qp4Rn7zjLsg/UvShXcV0kobWC0e5E
 0qeB1dQJedvwJovlimFr2Qb3IBB8y8S6EPZWJrpW2iOnGrhicIsjjDphsCyiCFdobGLG
 v+UYPbgXkdthNlO9L/laYOleCb2gm1ENY/IZAXCZEVWGAX3K2S/ShigiU4hH7md5nRGM
 C99NDH4kdTytllCEz52pcNkAJD8ccpDf0H6e/u6RiHKj9Hk6LkVIUc78MzJjrMTEAxCv
 cfuRDDPVyujpYSdR01XwOQURF8Nmx3NqWfuSbI5/92zMXHHOirtV7m8Fgfiigy65Ep6B
 UTDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVouelcJJB9hDy3y3iW+37CqKeozeGeh4jP5aAVdiZ0wJBxLbdIHifcjgJ4p2EhyLr5v19wk0usCtGL@nongnu.org
X-Gm-Message-State: AOJu0YwutCJy+m3S1tjsyOSbfpKptAoCp3pkwTUEO4+rp2YBWAIDR1VS
 BOL8oZAvGrZcQMJ5ZdDV8Fya7Arf9JutrAH9BJ6F7oMnavpCDvJ5Z4N2sOiDA8VZXbI=
X-Gm-Gg: ASbGnctPYQpL2LfMBWfrJRTU+K3kRmi2biGFl9oahVUkT8RJ+Ic+CcgnRa1uZ7nOLHr
 ARVoEeFjC1G+A27vjU74ir+z0HQuGx8J43qq50XE2+hXXwIBo0WPt5d+b9ZDMaCNk+tN2ELN0ls
 YMl/tV/kqY26+K56bUEdzuQyS4EOLJ+5pJUgepjTHjl7CsxvpLOBmXH4RiUjwmjh2bRnZB05r6v
 kC/F77WZCtcvEgkCISnlIfcEsdHVYPm4PSUnCr9aup2PSdVNEKofE1R26FBNoTbLCZSL7Krg0Io
 +KsG0awCYsnuvkhRfsZ6qzilJe8MtykXn99HrfQLRkZKBtMiyYc3jRUaNEPWEbbiR7lEQm2dIsk
 LIoVAe9T4o3zyheZlddHahvkeLR+GSOamBjy+5ixf0yz9HYo1FOS167+lbBf3Z59aL4fq8/GI29
 x3Wid7JS34Tx/7qYa0w1uPeWeRyrJdKYEynMPwnM2YV985J97vG20CYg==
X-Google-Smtp-Source: AGHT+IFq/IC6HIHdkvBHZrN14+pdaYwnzGykBqCSe0/5aCe4Z4mTjUEnqW9xMyOt9I2a9w2/mav5dg==
X-Received: by 2002:a05:600c:470a:b0:477:1bb6:17e5 with SMTP id
 5b1f17b1804b1-477b8d8b887mr45018945e9.30.1763659371030; 
 Thu, 20 Nov 2025 09:22:51 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf207709sm616155e9.13.2025.11.20.09.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 09:22:50 -0800 (PST)
Message-ID: <af42913c-32a7-46b8-8787-c9ca08578466@linaro.org>
Date: Thu, 20 Nov 2025 18:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/intc/riscv_aclint: implement the
 register_time_change_notifier method
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-10-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-10-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Implement the register_time_change_notifier method of the
> RISCVCPUTimeSrcIf interface in the ACLINT. Keep a notifier list and
> notify it upon `time' register modification. This effectively replaces
> the explicit calls to the internal riscv_timer_write_timecmp CPU
> functions as this is now done by the corresponding CPU notifier.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   include/hw/intc/riscv_aclint.h |  1 +
>   hw/intc/riscv_aclint.c         | 16 +++++++++++-----
>   2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


