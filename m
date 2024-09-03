Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44DBCD3436
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:06:54 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slU4d-0008Ow-BB; Tue, 03 Sep 2024 10:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU3t-0008Dd-US
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:59:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU3H-0006i3-Ox
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:59:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso42952785e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725371825; x=1725976625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/J3s1WCd5IHhbCw5NkWJ0Lag6fROvedX/tz/g1GSR4=;
 b=DI8ZOcpPLkCKqPlEJ4qAZYvGZAXYK/uEqEGJbtbfYCT3uACGwr2heGzT2zPj/XejM4
 7xKh6E18Iq0V3XykbwKsElt15vkgHdiyay66ONuiXKDABVoDugztoVk5DSfzvTustYGw
 0Eq7joH/aNOTLHOmy+8zEcrkTAMX+KV+pp98mpXpvT3mR2jSY8tUuxWmhdivXMinf+fy
 qcifvI7ZYQJosn6WMT5ykdH8m8DnbaSzG6MXg08mQQkF8E3UdWGEJT6riLQuVUI7kfpx
 yb79QMxeN+SKz4rxyDw8iERyHz69tBTrBkbv6+CfqmHKhmiaIxCT6SWRbSSK21YBeB7l
 dmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725371825; x=1725976625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/J3s1WCd5IHhbCw5NkWJ0Lag6fROvedX/tz/g1GSR4=;
 b=j+N6aUhNHFNlI3w6VEleUG8CcJmchEf/W5s9bqOI41JdNHB+aT8FVITBFlwoiJTwsQ
 Yfen68hz+5FXCLQUfnoJCPUGS9+M9ccEYjUoAbXJ4Pa7Rbk+FNIaQllxByZzry7+EYSV
 dVKvSmXRbxKLCXS844EVRIT3YeOG7X4ID8jmIGVYhP1g24Hj+NLVAgYR+z6HukRUOzVS
 Z48F288YDtmBE8LwgvsxNv/ochfyhX4Qw36IsAL0GOzGO5/n8wKbIwWnLLzrROPRbkYa
 uHrxGk9R3gortrw+snv4+o3O8Nu+jhgozaYVkH1KmLAPQikck/k0MhWztqwhzafrp+j+
 2X/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRH+DIoE6jw7RTsZcjyuuHQ+WYJLfSalk0LASKSqn3qg6quzGAI+TIdWyxdCFAHxb5YJ2FBM0O7wl3@nongnu.org
X-Gm-Message-State: AOJu0Yy6exVaCv5+vomCCXnDh7CCbgcWYC2dQG08OFZAx2Cg4H6ce8f3
 dYr1CnVt2jcFmU9PiPmEyCLNBuBSVIKxD3A7ATQTEjn9kB8uDUaVE7nJufG6n0Mn9IfODGbOmM6
 b
X-Google-Smtp-Source: AGHT+IG4ZgE5qyHBuzMeaI7ScNcsMJYwiYR/FGDB0KfWaK1LkgabWDxjiGiWIpv9zGn/4Wf09ld6Ig==
X-Received: by 2002:adf:cd0a:0:b0:374:ba7b:42af with SMTP id
 ffacd0b85a97d-376dd15b687mr652456f8f.26.1725371462325; 
 Tue, 03 Sep 2024 06:51:02 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bdcbe0f0sm9857061f8f.117.2024.09.03.06.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:51:01 -0700 (PDT)
Message-ID: <df273147-17f9-4333-a357-5f032e652fb4@linaro.org>
Date: Tue, 3 Sep 2024 15:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/44] tests/functional: Convert Aarch64 SBSA-Ref
 avocado tests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-35-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830133841.142644-35-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 30/8/24 15:38, Thomas Huth wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Straight forward conversion. Since SBSA_FLASH files are not
> tarballs, use lzma_uncompress() method.
> 
> Avocado used to set a timeout of 11 tests * 180s = 1980s.
> Hopefully 600s should be sufficient.
> 
> Running on macOS Sonoma / Apple silicon M1:
> 
>    $ QEMU_TEST_TIMEOUT_EXPECTED=1 make check-functional-aarch64 V=1
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max              OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1      OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57          OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off       OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1         OK
>    1/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref        OK   241.79s  11 subtests passed
>    ...
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-ID: <20240823131614.10269-1-philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |   2 +-
>   tests/functional/meson.build                  |   5 +
>   .../test_aarch64_sbsaref.py}                  | 144 ++++++------------
>   3 files changed, 55 insertions(+), 96 deletions(-)
>   rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (56%)
>   mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14500cf8a5..e9aa174dc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -971,7 +971,7 @@ F: hw/misc/sbsa_ec.c
>   F: hw/watchdog/sbsa_gwdt.c
>   F: include/hw/watchdog/sbsa_gwdt.h
>   F: docs/system/arm/sbsa.rst
> -F: tests/avocado/machine_aarch64_sbsaref.py
> +F: tests/functional/test_aarch64_sbsaref.py
>   
>   Sharp SL-5500 (Collie) PDA
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 182d40e052..bfa04818cc 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -11,6 +11,7 @@ endif
>   
>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>   test_timeouts = {
> +  'aarch64_sbsaref' : 600,
>     'acpi_bits' : 240,
>     'netdev_ethtool' : 180,
>     'ppc_40p' : 240,
> @@ -32,6 +33,10 @@ tests_generic_linuxuser = [
>   tests_generic_bsduser = [
>   ]
>   
> +tests_aarch64_system_thorough = [
> +  'aarch64_sbsaref',
> +]
> +
>   tests_arm_system_thorough = [
>     'arm_canona1100',
>     'arm_integratorcp',
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
> old mode 100644
> new mode 100755
> similarity index 56%
> rename from tests/avocado/machine_aarch64_sbsaref.py
> rename to tests/functional/test_aarch64_sbsaref.py
> index f8bf40c192..e90566cdb8
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/functional/test_aarch64_sbsaref.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Functional test that boots a Linux kernel and checks the console
>   #
>   # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
> @@ -8,12 +10,11 @@
>   
>   import os
>   
> -from avocado import skipUnless
> -from avocado.utils import archive
> -
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> -from avocado_qemu import interrupt_interactive_console_until_pattern
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern
> +from qemu_test.utils import lzma_uncompress
> +from unittest import skipUnless
>   
>   
>   class Aarch64SbsarefMachine(QemuSystemTest):

Oops, I forgot to squash:

-- >8 --
diff --git a/tests/functional/test_aarch64_sbsaref.py 
b/tests/functional/test_aarch64_sbsaref.py
index e90566cdb8..f31c2a60b6 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -20,8 +20,4 @@
  class Aarch64SbsarefMachine(QemuSystemTest):
      """
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:sbsa-ref
-    :avocado: tags=accel:tcg
-
      As firmware runs at a higher privilege level than the hypervisor we
      can only run these tests under TCG emulation.
---

> @@ -28,6 +29,16 @@ class Aarch64SbsarefMachine(QemuSystemTest):
>   
>       timeout = 180


