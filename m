Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48225F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBRm-0003CO-DX; Thu, 05 Mar 2026 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBRk-0003AN-2C
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:21:08 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBRi-000619-KE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:21:07 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cb40149037so853528285a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727665; x=1773332465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBRPf1cDaUGnvniYqNuCRGyQZfEGog0khal8AesIswk=;
 b=W4gMMpQ49t6tbd1YsrtFqsqp9ZfipcNHPQb+V8MDIq/0emW8JX61fcze+svHWwqJCV
 KG0Cfy95qA4Vd6zdYhaVQlnsqqWaanA4qwLlcVf4sx3Q/JCL0Nq+WB5BI34UWMHmVCw8
 PoeePgHaZ4fRcQEd9FPkTdj3wa1wTS+0vxcNs6jszTNPmxYhTKDoM80nWQpfUos4gUGm
 aTNt+8WFQrQbVHUvQvBvieN9V7km5qXltBGmKP8DAHsZxv98O3Dd03W+d2rR3gNfxLOL
 dofVGKtVzs2E/D9kxmmoMpxP79dgU5wvPUGlYVJc/Xh6sFWZLr8zUTULDQ+WpNY+apCz
 B7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727665; x=1773332465;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBRPf1cDaUGnvniYqNuCRGyQZfEGog0khal8AesIswk=;
 b=MIUlTQxCE9Pk6I/GtZ04p2qr9lYCJPfIURRWjZAHgMr1k62mUrq1LARafXL5hrPmaN
 SHRKYwzECf38CmTCWHeJBVMVJNwfr1Q0quy/mduOuN9AfZ2SY7HgCD7p89c2AzbDyzVq
 DU8bIDAZwi8qTv5FpWPsf+Xqh41zu7v6DCxhb2NI2fcE7HyD1n76nZy89vkXuQvqyBV3
 FEMaBBQ3y5W12fERWHoAy5VyRwTXE1cCkBBpXxEtppCQ9b4IALZxrQRq3Pha/+6dtrWq
 7i5UNNf57g1Z35zmwx68ouVjj2htDmAsHewtJLaBJ3BJ/MzRj3eAXjUcm/TrbI6Tr54v
 3vCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUusTtdMrg4TU4P4A6yF/nJVwjk7oe7xYG39prCPdU5fyOLxZv7Si0gGUB5ZDJNiJ3AbOacmtmJdBsK@nongnu.org
X-Gm-Message-State: AOJu0YwS53lW5IQQ/s6Cjxt029cpdCVd+N8gQWjlRyZNMuF6ljWgCQJY
 VrJ+jbo9etcYwcXaWj5FuD6tX9T1o4GhXe0OAAqJA0mCbBtWeTpqXiX5pqbYfTyJoSs=
X-Gm-Gg: ATEYQzw1J8ljT6H1lGA+wi6l+xLaPwLrSRHDpHaPdT0UMjvktPL0hoP+dPPecrEgwx2
 Vmzqd538iIZmV2b2yt5kDej4K2njvJKyKQMbSKn1zo7cdQaOhzZwqUp39aZSL1ekLsFIIMmVTU2
 Zo76q6hIVCPNS+mXOn8CVXSY2XeDjD5Tct5WN8L1z5YRjCOrWoEEXeXo/HMWtk6/4a9xr+EJ8na
 NCBLSrH8iQXjCv2S603h1po/T/Y6ApTCmN5/34GUFSJlnT6JS4u+V+3jy9UFV4NOzEa2G57Ecvs
 qZuhTteeqaWHNCWonZd4lAbSoP6jJTYy2hzv0M+PLkHVIbJwJU0UJlkcCh/mPGsA85sEwAvLiav
 g3U8wqim74lOkEyeYbuc4D7z3OZoH3TTk6GMsG+LmWMqEUAd/yQtNgIMcSQV4Cq3202Xp4+AIlb
 bDvcCCKLomkou+rumQI2P2jVLdRjJZZc7cHc/L81ZHsTEkfwxQypEcXhEn+lxeUKeyOPd6xsPnP
 ZjbR+8=
X-Received: by 2002:a05:620a:1a18:b0:8c9:f8e5:9f12 with SMTP id
 af79cd13be357-8cd5afa4e85mr825827885a.57.1772727665131; 
 Thu, 05 Mar 2026 08:21:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf64efafsm1918175485a.6.2026.03.05.08.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:21:04 -0800 (PST)
Message-ID: <37c7708f-aff1-4471-a475-32edb2353b74@linaro.org>
Date: Thu, 5 Mar 2026 08:21:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg/plugins: Fix sanitizer issues
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305161531.1774895-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
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

On 3/5/26 8:15 AM, Peter Maydell wrote:
> This patchset fixes some minor issues in the tests/tcg/plugins
> code which the sanitizers detected.
> 
> Patch 1 is the one I sent earlier today, and has been reviewed.
> Patches 2 and 3 are new.
> 
> thanks
> -- PMM
> 
> 
> Peter Maydell (3):
>    tests/tcg/plugins/mem: Don't access unaligned memory
>    tests/tcg/plugins/mem: Correct hash iteration code in plugin_exit()
>    tests/tcg/plugins/patch: Free read_data in patch_hwaddr()
> 
>   tests/tcg/plugins/mem.c   | 95 +++++++++++++++++----------------------
>   tests/tcg/plugins/patch.c |  2 +-
>   2 files changed, 42 insertions(+), 55 deletions(-)
> 

Thanks Peter,
I'll pick up this in next PR.

