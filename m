Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083D9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6B8-0004gr-7t; Wed, 12 Aug 2026 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6B6-0004gK-Iu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:27:20 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6B5-0002WA-7u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:27:20 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6689402c7bfso1023821d50.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786530438; cv=none;
 d=google.com; s=arc-20260327;
 b=nM3UJYec5FGH3gIafbiJUi/0BHsxCa/Zc4Ohv3ASltZYdT4m26kAc3phOXp5gjC7tS
 tUoMFwbvRq68M11ho8a0ntyPzwpNiu5P51b12qo2vKVvhcpLpw00lGWIDhd3xlBH0jyf
 teUkOgGRgse2qPMDtr7wIqaX4XM0ZBgwfb597+y4kCakxEMTS3UoK9TJKJ4OtfGSkWA2
 w+87WeiyQR8dNGBjzxmzgFBJrrvfYdvJjX1TgMzItIZZOdLhTWkMkeLKkcGOcPLgDPhF
 Sj6tMI/JacnNJGq3oTRjBJJ8x1EM9UD3kC78ExGaJPLnaTM+AT+Xx4BAqnMcgoH8r+Ss
 LJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6uBHImK2q22eZBBbSau2GPOmrCcmb9MHcdbO31DQD0s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=POXDXUJe6OsU0x57Ik271Xt5CrwyKogzkiKr1yEttksSkN8lfNz8GCiLqDVYOe7dK/
 +B8vIRDSpr1dfsI3zBNCFN4hwsGwDkBku1Uy4PYEx8h52LF9amrE/b6NPw3WJuoeDPBb
 G57CyYYN8joWn45OmiaSuGbOW2655iUMB7rgKXQhfi3m99QoMG3qKJ5xe/FSQkOg6dAg
 jMwTsqqig3dwcqjaTiPHBqz5q4JYgQKTu2xHEDuhR7E9we8rf2q84cQs3oyp/+03R7Mi
 YdJLa7lSTklMRC2+6fWUi0PMsJ8xEfK62X9O7kEk4/M24BsuBo6d+A50OHb4+mHOpFMp
 /wuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786530438; x=1787135238; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6uBHImK2q22eZBBbSau2GPOmrCcmb9MHcdbO31DQD0s=;
 b=uMbG0y2qZiPZQPIFhuSnRcW18jcT+QrGdGQEMvG1c/pfYSLPgJPOMq8QO5q14BeVTs
 0PucAql+io1zoHthtWGnEt1kpElb9oRJntN29KvZfhzaZe+C2MSx+hqx6EafufU/NJhx
 /ltxUj9oHx2enD08Glpe4U77FVpNXsS3BNG2Or95MyDAFdQ4I+gcpGce/Z8CCSWsonXz
 j0/kAhyz05bNDxYYhz76IQllHZ66hblXy8qw1BV6kf1LAvRRN3C5Eq5F4bGd4ar+XpST
 hJUpciBPZR8Ghw4/0ZE4LSTqGIoMD3GAdXhTzb+mtfKVyrbQm73tw1aSDBYPbpork+U1
 jLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530438; x=1787135238;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6uBHImK2q22eZBBbSau2GPOmrCcmb9MHcdbO31DQD0s=;
 b=nptwWb8TBzWQ3eeQK08zsIRMosBwjaQU6SU8XUFAr3GB4CCaltXD6rGOfZ7hCDwpyN
 ADLHwPiR6UwpSYiH0NgEuoGZIO+q2CatiPodk5gRGpu8vy11dmzrf1fSax9sLcDluitF
 FcHrWNBL0d5RLVkJjjAOBXwE6rR1WFSvamkrNVlR1yRsqXZjvBKjly9R/NpB6h9AfXCx
 v9UXA8sFYtBt3wYFFR27dIJzWSkZ5PM4+Bq6awoQASIsgzkbdPUqK0EFFXbaJJFMPhmy
 fsUPwWXjUugy0E9cq+S1FvFP1lxcmrxL8JIzRP7Hdsn7GTrFbOWaB1hyNrtZhqNJpYJ1
 Ujlg==
X-Gm-Message-State: AOJu0YwweKs1OG1jz5dm4TFVEd+0vC+lb9O4DJMO+F0Xpf4RYDzSg9Y2
 FB5WRSL3a8AOJC4ZFu6XOKcENRSwGSVCHImp0qwX301lUufHWbm51qfCoDQjO1ifj3WxD8JTZ2e
 8KJOHqUUQLv/Bk105OCdJ3E7UcXF78qznsa8imvHxlQ==
X-Gm-Gg: AR+sD115rBkaAJ8EI5oIG8Zm6aTwAWF35fbctfQ2XhsIKkLhN+dcgPWE8oHjCPU+nFJ
 J7rtwaA9tkNYPehWekVvPGLeIVJ7BBg14EX6P3hk0C/F7OQINvD03jmgUJpFjemRVX2Ap+7unCG
 cMNQrjMOOB5HZqO9UMRUqWkSQrW5AteryLD2EE6ZhmLw0tksBQjuA3MOo63oM2A5f+h7b2iqU5v
 2xQUGdzbWcL/y/1ThjXsP/q9GxJkpPTUoyWNLA8DVkvBh14SJ4l+mue+p715CRSQRbQZUNa0ASP
 2aBlDXs38ycTfqWVtft5WvhwjQmLqaEMk1+SZMCOJyJn/1QBIc6guDZsVCFynB8F3qImkmDONeq
 yBfdYToQ+Wbram3Iiqz4XG93JYqkX
X-Received: by 2002:a05:690e:c41:b0:669:484d:52c2 with SMTP id
 956f58d0204a3-66b3435501emr1894005d50.36.1786530436579; Wed, 12 Aug 2026
 03:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260806163939.328201-1-richard.henderson@linaro.org>
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Aug 2026 11:27:05 +0100
X-Gm-Features: AUfX_my8DCGJ7Qq84Clv4Tuokm9LRf3FqNjYvMbskE7ET7s3uiakhj8pjdAGD68
Message-ID: <CAFEAcA8stJZ6JZW1un++6zj+CDwkR-zTpA4G9ksTetO-xOn01w@mail.gmail.com>
Subject: Re: [PATCH 0/7] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 6 Aug 2026 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is something that we've talked about for quite some time,
> having separate "max" cpu types for Armv{8,9}, because Armv9
> prohibits some deprecated Armv8 features.  Retaining all features
> simultaneously has the potential to cause confusion.
>
> r~
>
> Richard Henderson (7):
>   target/arm: Tidy cpu_max_initfn
>   target/arm: Pass ARMCPU to aarch64_aa32_a57_init
>   target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
>   target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn

I've taken these first four cleanup patches into target-arm.next.

thanks
-- PMM

