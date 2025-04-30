Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3133AC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA54y-0002QV-QT; Wed, 30 Apr 2025 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA54p-0002Pq-S3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:54:09 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uA54n-0005VV-P7
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:54:07 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30db1bd3bddso70361171fa.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746010443; x=1746615243; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FWfmqOeHXHty8t8J7NgQU6cblMe2MZXkV+Aw2HTi1k4=;
 b=KRFnrx4fNChMFmjqtXWvyU3aoqMewCCqMc6U9uYnv2yj6E9WOrnKbE6hlbgtLW6sqI
 ML8WYRRMLQx7yDip5VgGTbslfur008Yb/FCSYDFTF5zTA6BZL/QtjX3rv0mF9nmW0Lsm
 6WV1KVj+vezdMaifw/0R3beOlwnn5d4wy/J0V7U9YKO2+iBE2igQk4vVJtaRkLoPtK0+
 fmbTUH4Nld4g2LuLmEw4TJAzsJsoTzVkbOnWCQUHONjjV9Mfq3MotKKvcJvLXlVaJdr/
 L3w3gvF57jh8wsZadHYH/7RrU/4elSMZkwvsygLMxQUT52lHr4q9coD6pg5bVVDTm/uI
 7Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746010443; x=1746615243;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWfmqOeHXHty8t8J7NgQU6cblMe2MZXkV+Aw2HTi1k4=;
 b=MUxftKdAYmBbVXWxmvZSsewTfj+Z1d4svxuRI05MGuzREID0VbAb3250uik4DhjoWG
 7qp2XF0V7oOsXI7/hKMsU439oAEydtoEm+ocJQ1zffiYaBbXoRa5HthZFudIYr7aOp5P
 jRtPWtbibmjLFwPrU6YWlCUcJr+CPpbHmb98bVCgMUE/o2xe+it0wFogtS5yBT1DoVBX
 6JLt+3czJiPAsed1s1YFObwFWW80qMCWFie1PWcrTZSGHxex4iW6rUyq4snbJwbcKl6c
 X+a3SYjcxCZUkpInfO1IEAbVNJFWp+KCHr3o183EOGO2Y474Pt5SzVeyQ/ZAK6mjeAJb
 +cbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ3BZKvvnICvEWybKmfLcaxmPY5TlpmoWDB9ogmue9DRmaBGB5ERpc+hEyidcTJDLxYuHWOcz2L0DU@nongnu.org
X-Gm-Message-State: AOJu0YyR9mbfWgYVWd/XRBV7f2J/HrEJm1dzvREz+wySQwbMKTBGFYcc
 AK2zSwrnALVV3RUmNIN9F9FO3QNf1C0gkKFWN+0SYcDj8LyJ2tUw
X-Gm-Gg: ASbGncsWmi1z/FUqgZc9ZSjgowtR1tJJqdYVxRMY0+jrmjs5uFI5jVMbv2CVWy44z2a
 79mUtkXQaW9MF7sfTuhzk0bGpB1PZ51MPu3sjHHcuQ4cOhOg7B5VXFeZq1nhgkJv/I9GzuwL4g0
 NQmCTG7eC+1HJOuXdzs2UO6edDAOvGchRjt6nteCiUR5oO/77bocj5MQnNqDpp+JjZNjDC+snfl
 2iZk2WFL2NKRMAeGd809420Hmdn57LtuS4u8ly5cIdL4Pd81vuosLRBNMvJ3iuxo+k04RqIP5Gu
 0uGXgvv+IG2ONJ0cdJ8X5PWz7LdI2msAMeeCxJjv60QjpjCvmnCNdRcuwhsY0FqbDGjdEFOj7oQ
 MV+RiELwv65NO
X-Google-Smtp-Source: AGHT+IHLoooEo5r64tluR8H08sgCHJIR1i2COzb+bd68gEnBRaeHE2PQQlN/h4a2MbeeydMDqiI2TQ==
X-Received: by 2002:a05:651c:550:b0:308:f4cc:9519 with SMTP id
 38308e7fff4ca-31ea28d41bcmr5291151fa.5.1746010442898; 
 Wed, 30 Apr 2025 03:54:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-31e948536dasm2034071fa.62.2025.04.30.03.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 03:54:02 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:54:02 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
Message-ID: <aBIBSv_xWgbWYqB0@zapote>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
 <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
 <bbc031c4-c025-460c-b185-5858f5b0d729@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbc031c4-c025-460c-b185-5858f5b0d729@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Apr 30, 2025 at 09:29:20AM +0200, Philippe Mathieu-Daudé wrote:
> On 30/4/25 08:26, Philippe Mathieu-Daudé wrote:
> > Hi,
> > 
> > On 13/2/25 13:37, Philippe Mathieu-Daudé wrote:
> > > +AMD folks
> > > 
> > > On 12/2/25 23:01, Richard Henderson wrote:
> > > > Use out-of-line helpers to implement extended address memory ops.
> > > > With this, we can reduce TARGET_LONG_BITS to the more natural 32
> > > > for this 32-bit cpu.
> > > 
> > > I thought about something similar 2 months ago, but then realized
> > > MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
> > > not much missing (I'd say effort would be to add 20% more of what
> > > we currently have). Just wanted to mention before taking the
> > > decision to restrict to 32-bit. OTOH if there are no plan for
> > > adding 64-bit support at AMD, then I'm more than happy to simplify
> > > by considering only 32-bit.
> > 
> > I gave this series another go, and figured the microblaze target
> > addition was done way before the 64-bit. C_DATA_SIZE value was fixed
> > as 32, and C_ADDR_SIZE was not mentioned. Later C_DATA_SIZE became
> > configurable as [32, 64] and C_ADDR_SIZE appeared.
> 
> FTR C_ADDR_SIZE starts to be mentioned in Vivado 2016.1 release as
> 
>   • Included description of address extension, new in version 9.6.
> 
> Commit 72e387548534 (Jun 18 2015) made explicit supported versions
> were 5.00.a up to 9.3 (per Vivado 2014.1 release).
> 
> Commit d79fcbc298b0 (Jan 11 2017) "Add CPU versions 9.4, 9.5 and 9.6",
> and commit feac83af3be6 (Jun 15 2017) "Add CPU version 10.0" (released
> in Vivado 2016.3, but MMU Physical Address Extension 'PAE' came in
> Vivado 2017.1).
> 
> Vivado 2018.3 added MicroBlaze 64-bit implementation "new in version 11.0".
> 
> IIUC current implementation is correct w.r.t. v9.5.
> 
> I'm not so sure we can announce v9.6 and v10.0 as correctly implemented.
> 

Hi Phil,

The version of a MicroBlaze CPU core is orthogonal with the 64bit support,
new cores can be used with or without 64bit support.

There may be optional features missing but I don't think it's necessary to
remove the versions.


> Looking at what our machines uses, latest is v8.40.b:
> 
> hw/microblaze/petalogix_ml605_mmu.c:88: object_property_set_str(OBJECT(cpu),
> "version", "8.10.a", &error_abort);
> hw/microblaze/petalogix_s3adsp1800_mmu.c:78:
> object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
> hw/microblaze/xlnx-zynqmp-pmu.c:95: object_property_set_str(OBJECT(&s->cpu),
> "version", "8.40.b",
> 
> Maybe we can deprecate / remove v9.6 & v10.0 to better add them with
> a proper microblaze64 target implementation?

IIRC, there're Xilinx internal verification suites that check for exact
versions of cores, so for the Xilinx models with platform cores
(e.g CSU, PMU, PPU's etc) we try to instantiate them with versions
matching real HW even though most of the time there's no SW visible
difference (other than the ID) and no difference to QEMU.

Cheers,
Edgar

> 
> > Indeed what this series does is correctly implement the current
> > target as C_DATA_SIZE=32 (C_ADDR_SIZE=32 implied).
> > 
> > I had a quick look at what is missing for C_DATA_SIZE > 32 and it
> > is more than the 20% I first roughly estimated. So with the current
> > implementation, this series is doing the right thing IMHO.
> > 
> > Regards,
> > 
> > Phil.
> 

