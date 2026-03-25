Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F6F103A9A4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Lpt-000532-BC; Wed, 25 Mar 2026 06:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5Lps-00052q-5L
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5Lpn-0004wZ-QS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774435894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U9VFzuEcjXje5ShW3zxAHxwlfNiTkjCNuQpsaDcFuZY=;
 b=GXcv/qTXGPhShuW4pw2H45MNZXq7tms3eCafyPVnj0UiL9/Sbz/tVhOINi4+gmaah/uuA+
 a6lGa7pv/W0fFkRrBOEDrPoeoDtyAgqTs90OozeiJDLxRaWjhjcat+f/MhyRX7RIvi8Isx
 KkCF4Ngr2KCWuhgwMwdke3bWVAEJYuc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-KYJ7iDHMOeKS5W5wvvaGrA-1; Wed, 25 Mar 2026 06:51:32 -0400
X-MC-Unique: KYJ7iDHMOeKS5W5wvvaGrA-1
X-Mimecast-MFC-AGG-ID: KYJ7iDHMOeKS5W5wvvaGrA_1774435891
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso52701225e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774435891; x=1775040691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U9VFzuEcjXje5ShW3zxAHxwlfNiTkjCNuQpsaDcFuZY=;
 b=ML1wpxmQR58PvuY7MUCdaq2/3yCsw/Rj5ykQqlYrInya0TaQVPG48pikM7GkRyeLdi
 qbDvW1bxEoyESirz2dK1HhJbEisJFzh2WqudS46UuKpU2c6cm9YyS/erb3jqXqkqS87U
 2sO3TnxukJqhtLKfc2mQ883Y2gwZYaAkxqi5b1bK1flEn+0wZG89PwnhGc7F4Qnxd427
 qegBjJmp36LcrGKtcbVGG3CfQ2CuoR9QbgVBJxomRY31L0zJFUr9XXF1MgEMTy7yqfU0
 eWXMBe+la5m8t/z0yHvHCHCpLMc8mGF2TjZA2ylK69kB5HHKW6IA3MG2+iWfA3RHc1jM
 i3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774435891; x=1775040691;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9VFzuEcjXje5ShW3zxAHxwlfNiTkjCNuQpsaDcFuZY=;
 b=fvOChjENUJ0QesWJWoeeXHr8oZR9iV4QYn8SlAlvhZJoGbe2k7ovOuz61dm16KfWLZ
 D71LumqMTFFOzK3IqNxLj0HcAO5BTyVW09l5GUwDnzvrw1A9/uQtw67u2VKKCkjvM0nu
 eVEJGEHAsR9VVv/Kag5oCxMvRrU18gwKKYrnIK6emL01D92CH/sm5sRCMVDxWYihB6Av
 oZUkvZReP58cUs7THREE/QC0PHUBJcBBFC1u8pyL9qwnehR/fuEton/2jd9uCuxjvOYP
 8YEOHSYoA8iLvkLzQXmlSSk0nJCZee9QxjsjRJjWm16sZ5TPjM7oVN5IKw519/jCPDsH
 SrQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTbXg3DhJwHJxCiC6yag/4HI0EuTQhVqqGTqmqvaVleYQqu9ERy7g0lKXJDntRvXhFToj0xTJi4Tt@nongnu.org
X-Gm-Message-State: AOJu0YxI1XF/2o6YAbTjlFJgZ/m4zSYhIaflUc9Q3bEIPRyGoEWtnQeg
 hI6oqWLhpQOaU7x+E2dw1wZPXtUZXyA5UeB4dZzDM32yJN29JRDxdOy7KLRV2ucTlEx/35hELro
 vMG1lQ059RHCtbm++p76OXCyw+b//G91bgfZrnas3da4WJnOlLgX7hA87
X-Gm-Gg: ATEYQzwE2i06zjFUMr/Qhsp7RR+G99RdWO+1IA/xkJ/eDNYMFMa+kCig88M92k0Wlyx
 lKvzvZ74uOShfXCO35p7wEGXbbLqcAVG63sczhiTfsVVck7zfIYg8H8cIImReNpFiVI9c8AH/zN
 NFxK3JOszAPwu3ZqSUeIaVyYIkLkahy4QQyBFU6rmC8wejvyV/4w/5EVae5lyCXeRINeVsTyTUB
 U4TIgFKv7O7xOJtkqiW+ynfZ4hr3mBeDAAXyn7Xdyh81qVoMHiwLY0CjFnTl+tZWfcnKwl7SrDU
 easy6+zCl7hqO6CeyGhYiSoprEWssJbLmhDoPfc5Vfza1CkoVbQ4Q8HQP4hKk0OSh1CNtM1YFwG
 K9TcHBRskf6Ups4oFvA==
X-Received: by 2002:a05:600c:46c6:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-4871609d044mr47842645e9.30.1774435890958; 
 Wed, 25 Mar 2026 03:51:30 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-4871609d044mr47842175e9.30.1774435890461; 
 Wed, 25 Mar 2026 03:51:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117732a1sm116329925e9.15.2026.03.25.03.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:51:30 -0700 (PDT)
Message-ID: <1002958d-783e-4fad-9a89-65d53f1f6e84@redhat.com>
Date: Wed, 25 Mar 2026 11:51:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] target/riscv: Add test for RISC-V BE
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-8-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260324164007.549397-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/03/2026 17.40, Djordje Todorovic wrote:
> Add functional test for RISC-V big-endian.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   tests/functional/riscv64/meson.build       |  1 +
>   tests/functional/riscv64/test_bigendian.py | 57 ++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100644 tests/functional/riscv64/test_bigendian.py
> 
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index b996c89d7d..d06d6ea112 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -11,6 +11,7 @@ tests_riscv64_system_quick = [
>   ]
>   
>   tests_riscv64_system_thorough = [
> +  'bigendian',
>     'boston',
>     'sifive_u',
>     'tuxrun',
> diff --git a/tests/functional/riscv64/test_bigendian.py b/tests/functional/riscv64/test_bigendian.py
> new file mode 100644
> index 0000000000..9e0b3b7db5
> --- /dev/null
> +++ b/tests/functional/riscv64/test_bigendian.py
> @@ -0,0 +1,57 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests for RISC-V big-endian support
> +#
> +# Copyright (c) 2026 MIPS
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class RiscvBigEndian(QemuSystemTest):
> +    """
> +    Tests for RISC-V runtime big-endian data support.
> +
> +    Uses a bare-metal RV64 ELF that detects data endianness at runtime
> +    by storing a 32-bit word and reading back byte 0. Prints "ENDIAN: BE"
> +    or "ENDIAN: LE" to the NS16550A UART on the virt machine.
> +    """
> +
> +    timeout = 10
> +
> +    ASSET_BE_TEST = Asset(
> +        'https://github.com/MIPS/linux-test-downloads/raw/main/'
> +        'riscvbe-baremetal/be-test-bare-metal.elf',
> +        '9ad51b675e101de65908fadbac064ed1d0564c17463715d09dd734db86ea0f58')
> +
> +    def _run_bare_metal(self, big_endian=False):
> +        self.set_machine('virt')
> +        kernel = self.ASSET_BE_TEST.fetch()
> +        self.vm.add_args('-bios', 'none')
> +        self.vm.add_args('-kernel', kernel)
> +        if big_endian:
> +            self.vm.add_args('-cpu', 'rv64,big-endian=on')
> +        self.vm.set_console()
> +        self.vm.launch()
> +        expected = 'ENDIAN: BE' if big_endian else 'ENDIAN: LE'
> +        wait_for_console_pattern(self, expected)
> +
> +    def test_bare_metal_littleendian(self):
> +        """
> +        Boot bare-metal ELF on virt with default little-endian CPU.
> +        Expects "ENDIAN: LE" on UART.
> +        """
> +        self._run_bare_metal(big_endian=False)
> +
> +    def test_bare_metal_bigendian(self):
> +        """
> +        Boot bare-metal ELF on virt with big-endian=on CPU property.
> +        Expects "ENDIAN: BE" on UART.
> +        """
> +        self._run_bare_metal(big_endian=True)
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Thanks for adding this!

Reviewed-by: Thomas Huth <thuth@redhat.com>


