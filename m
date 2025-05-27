Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD1BC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 06:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJnZW-0003P0-GL; Tue, 27 May 2025 02:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJnZN-0003Nq-R8
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJnZM-0004HY-3Z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748326425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6TXmvmH3pbolGcVU7gABc4dMjrh68BkTdQCfs3ANnko=;
 b=NlAdltBB2yzHrRJh/pTjqpuLnjFRHxdlpuYxGveIP3cdDfJbtUtsnLv3DRrJ3y9LMNB5eY
 MgsQeyG4DFgpGcGSsWNpyg7xt2cjSa9YU8i+YqaVDjzwjMaQpytCFtsfYu4hoT3GIPFUkO
 n17DsFAKULHOrKJzDK7oQ+W+OgU60vE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313--_20j-saNLysNGPANWg6xw-1; Tue, 27 May 2025 02:13:43 -0400
X-MC-Unique: -_20j-saNLysNGPANWg6xw-1
X-Mimecast-MFC-AGG-ID: -_20j-saNLysNGPANWg6xw_1748326423
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a367b3bb78so1567383f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 23:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748326422; x=1748931222;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6TXmvmH3pbolGcVU7gABc4dMjrh68BkTdQCfs3ANnko=;
 b=Y7jwP8rUY1LE1do6l1yN2I85VhECpuDpNdV/hx6XkdiuzG3pQK4UE4uHQcgyR/7nGF
 Q2/bkfjjOy//ZDG3FIQrqYu9HbFXTfukwP1oxejOB5V4Vz/HSSgslodZnsgRTls/Jio6
 jVX9mDGOOxK3pYdRCh+owgSaSFvu0ZF25MbD7LR5vIk5N7+AGI8H/+YUhDjP8Rp3Iddw
 Y4n8ei/KrFmIEzI+92sCF3fzTi+iCTeGUz26cwVrCWGbbXgOnrFz0UVeikvmHPouX4Ye
 Ir8vpq+ulrVJMugF+EnvKvJd1o3ryFqb9cy0exMn+++H9v57yWKH4sBriN9vleLwopGK
 gqzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVChMYkXti3KXYmHC8TqHLyXj/0vdenYwiOMJfuMJfbqTg/N6Pw9H5Bsq9I2F/W88Tx47AMzgk8vf33@nongnu.org
X-Gm-Message-State: AOJu0YwziUnhu1xHCEj/5myeTqCaKETPQZlEzs8QiIE5xe6eYEveofjB
 HZ6MXTNqvFPW56Kdt/eBJSEBoNNXBicfUbDcqZKgPXHfsabp5d/QqDR/ID18yIEDU2rBfUj0ehM
 N2LTZWMV5G4mC7hctuthm2ghgXXcr2fjCxkeaEJ/K7O18EgIIf0JEYake
X-Gm-Gg: ASbGncu/4jOX1RbDIoVE1sMKssoJykwN2h1S5/IdGl5udpivFjCdfbK2pifRpdB34yC
 ZpX0p1u2SFVEQGdPUUt9xlNgDJ6JxlBH5+jkMsSRbIPZN2DtwFd/dYvvzLKueh+bKpI4vac3L5g
 gNXvA+jwRCA8mylAKOsdMKfIOM7zmb4IIz88i2loh7cmoSF/1qhz4twOIvfi/vv2JcOhcdha4Fv
 MuPnHBci9NMgSPzxkIkVPBpm5zYh6Dcc2sCFDKajvXvc3iMcBgXXdVu4GcWGyyEYIguZiplBIMB
 fT7y4VrNJPNVX2aTTkhMUz5mSiLMeki52SEM1Sq/
X-Received: by 2002:a5d:63cf:0:b0:3a4:cddc:d3f7 with SMTP id
 ffacd0b85a97d-3a4cddcd62bmr6289321f8f.24.1748326422588; 
 Mon, 26 May 2025 23:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTslvkB6uPp1ewkqLCZOgnJ4wMEzWcYVsv6/O2LF7GGTni6uxTGL4gbXgerJJzoDhjnTlZpA==
X-Received: by 2002:a5d:63cf:0:b0:3a4:cddc:d3f7 with SMTP id
 ffacd0b85a97d-3a4cddcd62bmr6289302f8f.24.1748326422185; 
 Mon, 26 May 2025 23:13:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-26.web.vodafone.de. [109.42.50.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d0d708b4sm8133363f8f.50.2025.05.26.23.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 23:13:41 -0700 (PDT)
Message-ID: <7d28ddbd-9d8b-4c3a-9c72-d6c54638d4d7@redhat.com>
Date: Tue, 27 May 2025 08:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250525070737.54267-1-dtalexundeer@yandex-team.ru>
 <20250525070737.54267-3-dtalexundeer@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250525070737.54267-3-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/05/2025 09.07, Alexandr Moshkov wrote:
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/status` file to check in VmSize, VmRSS and VmLck
> values:
> 
> * if `memlock=off`, then VmLck = 0;
> * if `memlock=on`, then VmLck > 0 and almost all memory is resident;
> * if `memlock=on-fault`, then VmLck > 0 and only few memory is resident.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   tests/functional/meson.build     |  1 +
>   tests/functional/test_memlock.py | 79 ++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100755 tests/functional/test_memlock.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cfe..13079f58b6 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -68,6 +68,7 @@ tests_generic_system = [
>     'empty_cpu_model',
>     'info_usernet',
>     'version',
> +  'memlock',
>   ]
>   
>   tests_generic_linuxuser = [
> diff --git a/tests/functional/test_memlock.py b/tests/functional/test_memlock.py
> new file mode 100755
> index 0000000000..83cb5394cd
> --- /dev/null
> +++ b/tests/functional/test_memlock.py
> @@ -0,0 +1,79 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that check overcommit memlock options
> +#
> +# Copyright (c) Yandex Technologies LLC, 2025
> +#
> +# Author:
> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import re
> +
> +from typing import Dict
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import skipLockedMemoryTest
> +
> +
> +STATUS_VALUE_PATTERN = re.compile(r'^(\w+):\s+(\d+) kB', re.MULTILINE)
> +
> +
> +@skipLockedMemoryTest(2_097_152)  # 2GB
> +class MemlockTest(QemuSystemTest):
> +    """
> +    Boots a Linux system with memlock options.

Nit: I'd maybe change this into "Runs a guest with..." since it does not 
really boot a Linux here. I could change it while picking up the patch if 
you like.

Apart from that: Works for me now, and the patch looks much simpler, thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>


