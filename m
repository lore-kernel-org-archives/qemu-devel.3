Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712F4D10399
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MFf-0006uM-AW; Fri, 25 Oct 2024 11:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4MFc-0006tf-Vh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:29:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4MFb-0000ht-Ea
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:29:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cd76c513cso19974175ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729870157; x=1730474957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzuhAgdqdQ2uO/zzhrhEmfLedOTWnoQz4CUWNrhhTJI=;
 b=PB78vaf9XuoUu/EmdIF8J+iZXsBpBZTCBRiAMrFxGB/E45HnLktc2Z9lFboXwHikjQ
 hCZQSNosYm+iT3grXZ1Nu9gjpOXhmxZ7/8+me2c1vLuQ6sl9SBnW6onA2TE18ju/tteP
 js/L2Gsk/GNzrgcXYRYt2cphTveEvF6c1rW+bRvNAn9kRg6+qBAC60CsE7XvFN558eqG
 DiaaboOyGSxNqrkNroCefyUEFi9lVGptEdjYm7kXS459s4RJJF+j1galh28H16C0EKr1
 3Li2IPqy001jtyEOEv3Yki1gjBCkSv+dhQUrrIKWnyiqHkjg8kwGmZJXFg0of1POdS4t
 ma0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729870157; x=1730474957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzuhAgdqdQ2uO/zzhrhEmfLedOTWnoQz4CUWNrhhTJI=;
 b=qMZUH+LiKsqkY1Ohxas0+01vhvAKj0zlZnowDWQCCkSzvHoQ3q1Vn2tqjjhZL0sozI
 W1sS7c+4iPNymwcvC+eKohO+y6KBmOXiQ6fYIGYAZdOqyhtHdFN/usGvQa4PV3MEx3vY
 q7UUPNzMR4j1NDF+yROocYCAIPqUFJNscFj/gUv8mF7s4xfWrrNjlxqgnfkrx/NOJo5w
 7Xn7dP5+A/hZz9O2c9LHYGVyO0Umv+B43D18BxFMbLMSjils6J9neJVseLTBwN6lguC+
 +jYDYB1TqpmztiJ5It6F9nuJgLX3KZlxs1vGHxCqDIXq2/dWAeYDPP8TPqfBCaolX1WP
 OmKQ==
X-Gm-Message-State: AOJu0YzjuY3giuOAqGs6ZTV5ZdFzDQkxTveu6niqnEhXS+ZPHwf2fK96
 ZD2mDv/0wr2qq5Ec96TOIO7ul0m6r5/+2TATOTVuSOclkzQfHP3gjCZr7is4bPc=
X-Google-Smtp-Source: AGHT+IEuYSmXrJWoyzYFao2/R2aemKQsXSBwDmYO01lc55Yq3SzRsYWcTbWqT6LupgkMffaflewXCw==
X-Received: by 2002:a17:903:1cc:b0:20f:c225:f288 with SMTP id
 d9443c01a7336-20fc225f627mr38930725ad.23.1729870157460; 
 Fri, 25 Oct 2024 08:29:17 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02ea58sm10539485ad.196.2024.10.25.08.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 08:29:17 -0700 (PDT)
Message-ID: <ac44d70d-2f57-4845-8638-f0939b0c1ea3@linaro.org>
Date: Fri, 25 Oct 2024 12:29:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'make check-functional' uses lots of disk space in build tree
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA8DE=i5X_=GxqrupOMqrQ6-BoL2HWo_GPe1pNhL15QU5g@mail.gmail.com>
 <ZxujrN9bHOboZzZT@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZxujrN9bHOboZzZT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
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

On 25/10/24 10:57, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 02:50:50PM +0100, Peter Maydell wrote:
>> I notice that with the recent migration to check-functional we
>> seem to be using a lot of disk space in the build tree: for
>> one of my build trees
>>   du -h build/arm-clang/tests/functional/
>> returns a total of 4.5GB used, for instance, most of which seems
>> to be guest binary files.
>>
>> Shouldn't something be cleaning these up after a test run?
> 
> The big problem seems to be tests/functional/test_aarch64_sbsaref.py
> which is creating a pair of 256 MB firmware files on every test
> and not deleting them.
> 
> The tests/functional/test_arm_raspi2.py is also uncompressing some
> archives and not deleting them.

Some files could be added back to the cache (with the proper hash)
so we don't need to re-extract or re-create them everytime.

> Perhaps we need to define a standard "scratch dir" in the framework
> that files can be put into, and then have the framework force delete
> them at the end.
> 
> With regards,
> Daniel


