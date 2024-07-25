Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D5CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxDr-0002nD-ME; Thu, 25 Jul 2024 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWxDk-0002jW-S9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:05:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWxDi-0000pB-85
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:05:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36844375001so466553f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721909116; x=1722513916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1v93K5wb0mqRwfvxVKYLdKURPCLFwznmmur8Qg1Qb8=;
 b=Bpul0iUVMKtuExIDA/mCKUFAnYf10ZOdGOrjv6+22OTNup7wmFtcyCofFQxcu0J1mJ
 wxCgY0pWbhon04SXkkD79+Gez3jVmkuU5xZEa0+d03+rSqW4deAo8E9D+96jC64Q7pHd
 0qpSnwdZNc+o0EEn3SClHJFfrb3Wh7sB9DVAr65l9shMvsXjHGkDn7AuVmmKhaYPwYdq
 8gHavtKWdYNUTjyslpaWFm7nkE6ipnUGCMu/RDL+EfPSHO2tt3f6VEco1BZHpzVMiwnj
 zz13MP1gwkRex8NPuyZNMCp9+0e2aacBdQe1GsvZZAXu1tcF+iKttpNlMB4e8VFVafGH
 zDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721909116; x=1722513916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1v93K5wb0mqRwfvxVKYLdKURPCLFwznmmur8Qg1Qb8=;
 b=LF1W00bnZbhLFvlBwhDqS5/uxrtMAlMMXR19uwg53lubyrfDPxDPKJ+QQIV84hlLll
 gnD60WRhkhpPqoF3MY4c1SRCWWRnZKdxyBPVQe8PIgHTQzHCSLch9P/YbnsmBg8JWw5e
 sfLLYEqp7xetpTkabLoH+syO8et4Tt2u4sIpmsaqW2Q9bFAxcGA0JsCMOy+z2b552N0q
 bjBwc0ZTmf9/bzwBNpqabw97gEGz7RA8ajaDqK3gqV8HRhQWdXLaGPIigOs6zcPPwJLH
 oG9sREYVBqHOTD64IPkZ4PLRR1K4yqzUf0ebg6VRYe2aDDM+J5euQRr05xPYHJYNJJ8X
 IWqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYhOEsyXC6n4jqtg6Z0I0HMp37RKyO0SNSoZ5sQv/+Hv40Hp/ajxnoRF0yPQck54dVUfpUHEDxdIhsVkcNWjnDYcFlJXY=
X-Gm-Message-State: AOJu0YyTY39MbR63JwuAye1wDyB/A60ZJMt/mIIH3WHclqmowAmJTcHE
 9xViY+/hrmSV0DQT+5RAxGsvrCdZyxCeps1jYKtNDz6I+iHh/OUAPy2kUuQj7BI=
X-Google-Smtp-Source: AGHT+IE4VEarCitsqMKIXcuX9TynqbHaUkVpp48wv98B33pGrp30DbbirUpribYaPkOhlzH7+ltEzg==
X-Received: by 2002:a5d:4ecf:0:b0:36b:3395:5378 with SMTP id
 ffacd0b85a97d-36b339555b5mr1455979f8f.18.1721909116172; 
 Thu, 25 Jul 2024 05:05:16 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42807246ca4sm24922965e9.11.2024.07.25.05.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 05:05:15 -0700 (PDT)
Message-ID: <607efb85-caea-4158-918a-7e4f1df73884@linaro.org>
Date: Thu, 25 Jul 2024 14:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/23] tests/functional: Convert some tests that
 download files via fetch_asset()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-9-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> Now that we've got a working fetch_asset() function, we can convert
> some Avocado tests that use this function for downloading their
> required files.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   | 12 +++----
>   tests/functional/meson.build                  | 22 +++++++++++++
>   .../test_arm_n8x0.py}                         | 25 +++++++--------
>   .../test_avr_mega2560.py}                     | 11 ++++---
>   .../test_loongarch64_virt.py}                 | 16 ++++++----
>   .../test_mips64el_loongson3v.py}              | 26 +++++++--------
>   .../test_netdev_ethtool.py}                   | 32 ++++++-------------
>   .../ppc_405.py => functional/test_ppc_405.py} | 19 ++++++-----
>   8 files changed, 86 insertions(+), 77 deletions(-)
>   rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (71%)
>   mode change 100644 => 100755
>   rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (90%)
>   mode change 100644 => 100755
>   rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (89%)
>   mode change 100644 => 100755
>   rename tests/{avocado/machine_mips_loongson3v.py => functional/test_mips64el_loongson3v.py} (55%)
>   mode change 100644 => 100755
>   rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (81%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (73%)
>   mode change 100644 => 100755


> diff --git a/tests/avocado/machine_arm_n8x0.py b/tests/functional/test_arm_n8x0.py
> old mode 100644
> new mode 100755
> similarity index 71%
> rename from tests/avocado/machine_arm_n8x0.py
> rename to tests/functional/test_arm_n8x0.py
> index 12e9a6803b..d451c80a73
> --- a/tests/avocado/machine_arm_n8x0.py
> +++ b/tests/functional/test_arm_n8x0.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Functional test that boots a Linux kernel and checks the console
>   #
>   # Copyright (c) 2020 Red Hat, Inc.
> @@ -10,9 +12,9 @@
>   
>   import os
>   
> -from avocado import skipUnless
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> +from unittest import skipUnless
> +from qemu_test import QemuSystemTest
> +from qemu_test import wait_for_console_pattern
>   
>   class N8x0Machine(QemuSystemTest):
>       """Boots the Linux kernel and checks that the console is operational"""
> @@ -32,18 +34,15 @@ def __do_test_n8x0(self):
>           self.vm.launch()
>           wait_for_console_pattern(self, 'TSC2005 driver initializing')
>   
> -    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')

We need to update docs/devel/testing.rst which lists the "most used
[test] variables". But the functional testing chapter need to be
completely revamped, so meanwhile:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


