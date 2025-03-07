Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36422C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqesw-0003xQ-5D; Fri, 07 Mar 2025 16:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqesu-0003wb-1Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:05:32 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqess-00069j-CY
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:05:31 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so19456025e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381529; x=1741986329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eh/eSkvEhMuR9LFURDFTZyMNRdILZ8HJGeVMKDceQY8=;
 b=FOTBhxa9CY515VdLSmTQfE3k+KjWbnsMY38PhnDtuhxvXXnIJNpzdPprIEuipernxo
 KS1xiF3rW8QJNuzuXkFLLToFCd4Atw+t78q/wsPEevRtZT3AvJhlh+ehgns/JIpErkTa
 Lb/FD/2R42mV6ku78PM70tlO+vPqYeumEuBp4UVjq3iBinLeAOaAdAs1gpIOdnqwj9CG
 Ynq2ltM7U2cDpiKDWmcDADAwtiOvsGsnDtPh2C40DBkqvGxeF+RwWPzGxhcc7cVGL4Lc
 dbv5qKkaKjIpa+s0E9t/FohKLKNHVEjrqea+Fb578OlaxzMC+Mln6/tdMsL014OSwJk4
 deUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381529; x=1741986329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eh/eSkvEhMuR9LFURDFTZyMNRdILZ8HJGeVMKDceQY8=;
 b=n1KnqMLnZxAnRwLiZugmAWdvrf6NRO84jf6ExUOMd8U0Iu615bD2e8DV9moZ7cEBWx
 8PK7FnwniD9plxDS9H5liScVRZJ3A9ASda/tGrqoGfYYcVhl2eJDu/1Hi01my9ulZuLd
 OewjnNbqJ0slmhsLKfcVId0XX0zJIFQpfd/wYLbSvUL8wWgUr3b0pQNQ4gBp5qRHjsgn
 HaH88dr5R80uqjNF0UopFAuWdVvIe/ZOMt8TVKzFOvcAf6i0x9kCgiMYDfkCzpLStZCp
 voCSXIAZrh/rsXo9haeUfGVb+NgN8jvINHiLQBfSsbkO/U6de4TVia3qPzYmgA6wbqfN
 gQqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeS+er+hesP3r8VDJUzvZNEXaV1U0XddWRcjv4dlrJ4bPnJ8BNfhE6y4o5Di7NjoZFUvSc920r4OJi@nongnu.org
X-Gm-Message-State: AOJu0YxnXq+Vrvvbz4sU1QzPW5VM5gJWcrbyf9p4LOfJwAxGsBPlY7Ae
 pHDgVDAsnqna12VfrLX4B3wpro8JYjW2GH797G+pf6BtJ3jX2K1gSIhvK/+Q/t8=
X-Gm-Gg: ASbGncsCF7LcPdsg/5X6d91SAao9RFWHWiD5X4SR/9+IyQqXk9ZQA1MRQA1wR9hTJEz
 xjR2qPVcxmfgTbgooTDewiQAITTuYJcDkCR9HJujq1aDc3jbXP8sjjbilLdb7RaYo5DIKMXDDAU
 QhfaUhprOvEDdVsVzsB2EyAf88eGeicsCJP8ZqdEpRBsMpRoHRJ0Lg3uXxa3QkZGiIBi1t6JDml
 rG+88IUFve8PKpJvnvoAvSNtfZqBALaosSV4OWPITomxKlJ1m8BkagocJzNGmmYDo2QbLHJXKZE
 NjZd+7jdadafYthk+xVr2IuYCg5dH/lNt3HwopFLSWk5GtoqRDJw3saPpI23Ry4McnB5WBG/i9I
 S38z+I5SP+AEF
X-Google-Smtp-Source: AGHT+IEhPEPL6QXJEBz8w/KPp20Tep5Qz1wXk1qBL5ntKWMnmoekiCpBQK3shdEMdKA3hUH+vlvj4w==
X-Received: by 2002:a05:600c:4f82:b0:43b:ca31:fcfd with SMTP id
 5b1f17b1804b1-43c601e18e1mr37233545e9.18.1741381528646; 
 Fri, 07 Mar 2025 13:05:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfa52sm6296136f8f.21.2025.03.07.13.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:05:28 -0800 (PST)
Message-ID: <3f777e6a-01bc-44eb-8eac-7ff685a3fbee@linaro.org>
Date: Fri, 7 Mar 2025 22:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/20] scripts/ghes_inject: add a script to generate
 GHES error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 linux-kernel@vger.kernel.org, Thomas Huth <thuth@redhat.com>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <3045b51edaf2d07eb0c513249fd1c621562ee3d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3045b51edaf2d07eb0c513249fd1c621562ee3d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Mauro,

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
> 
> Add a helper script with subcommands to prepare such data.
> 
> Currently, only ARM Processor error CPER record is supported, by
> using:
> 	$ ghes_inject.py arm
> 
> which produces those warnings on Linux:
> 
> [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [  774.866583] {4}[Hardware Error]: event severity: recoverable
> [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> [  774.867189] {4}[Hardware Error]:   running state: 0x0
> [  774.867321] {4}[Hardware Error]:   Power State Coordination Interface state: 0
> [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> [  774.867679] {4}[Hardware Error]:   num errors: 2
> [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> [  774.868280] {4}[Hardware Error]:     cache error, operation type: Data write
> [  774.868465] {4}[Hardware Error]:     cache level: 2
> [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> 
> Such script allows customizing the error data, allowing to change
> all fields at the record. Please use:
> 
> 	$ ghes_inject.py arm -h

It should be easy enough to add a functional test covering this,
do you mind having a look?

> 
> For more details about its usage.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   MAINTAINERS                    |   3 +
>   scripts/arm_processor_error.py | 476 ++++++++++++++++++++++
>   scripts/ghes_inject.py         |  51 +++
>   scripts/qmp_helper.py          | 703 +++++++++++++++++++++++++++++++++
>   4 files changed, 1233 insertions(+)
>   create mode 100644 scripts/arm_processor_error.py
>   create mode 100755 scripts/ghes_inject.py
>   create mode 100755 scripts/qmp_helper.py


