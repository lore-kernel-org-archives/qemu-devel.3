Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ9Hn-0002OT-7c; Wed, 12 Nov 2025 06:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ9Gq-0001yW-8J
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:44:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ9Go-0006Pe-CU
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:44:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso4340285e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762947853; x=1763552653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mkqehCx9KgP9OGG9kKTzY7TnQIwijMHUv6d8vGDQBmk=;
 b=nKyurma7FeO9uTM9OTyPU4AIYGRwTCRfwOBjTvzKLjyjjZAZYd+6+6ZYXZuDnEpBl7
 111lXE4oa1IFufVwcoOhl8CPQj41hi6yNjihx2X92DxGjtj4E7aD77wkuhir+YkhZvj0
 3cVGkxIy9kNuC1Qfpxx5xS+FszAXvEPBgzCuNoSarjS9AwOLDWbmPTY6YYI0H0ralkU1
 GJ4HNLeH3u5/USo8iOHXIEw6C+duyVUghEy3BHyDG8CKTzOC4xHXz3QobImjTK2371rM
 raGqyrlOpH5ALqld2cnMot57fqoog4RN0dfzCs3ylj237CpYC9zpaLowhXy4d467vwrg
 Opvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762947853; x=1763552653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mkqehCx9KgP9OGG9kKTzY7TnQIwijMHUv6d8vGDQBmk=;
 b=d2b4jSnJBgcbGG7jeyuwnUUmA8DsUgr/lNXj/QnrXXMuPGES9mN5L9knM9Q0tzE/0F
 F2Oc4TjHJ7Jqgw2UiTyaEX4AlRCe7S92W4pqG5ye8dtIaNE4mGVklPm+KpDf4/AtVYGX
 aU0JSzBJ7qIjawf3N1Cp+eXuVktSQYD9K500QeBSpiHhEIBxpTCW4zITcipaFXg/wBd0
 W5DjJnnADHd5+gqhJnJBmKL+Iz5CkE4UsidHyC2R0W1ebfjQ7DvIISegNXqT8PIZJ1lJ
 vY9k2GS4yAIOg2JnSHkM2Z76oXCKBjeRX3ZI0iFYIXZqyPz1+M+9PP++zK0IfWoev/R5
 TAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfAqQy0YV5RQSE/7eA2U2D5vWbm87+LSth9fS+Cy7hw7PgFRB1mtGAsVPipEPM5EYBo3eV8QQPW13x@nongnu.org
X-Gm-Message-State: AOJu0Ywumn4SISY2XJogZD7N0PBN6QjZEjFYY4qHJEQE5Cv4b89PwDme
 gHqnrIAMa95uvz3FNTg3qGnIY4Uk+1VxmGFCmhTYtYlL7RinJSyGBl3olzu2WxGZ9Cw=
X-Gm-Gg: ASbGncv28S4GdC2ubKvVP2MxhKtyAO3PZVxYX3XmjniSWxB2tt6U8kzudzNKvQrIjmL
 /glQSB8R6C6Sn95EaRGiUFQYPNNRtTAVSwscBmf0zb6kG4NAxpl+xO3TShdK31cNHZVeupGVqmh
 LX6Ef5TgBfsOWM6pAlIJmMhNh+7IQDLs6wLv9GauzQJvHhvLOzNPu4iZffbrJ9GQDbGR2eCqXUo
 rndcGGiIJ0y3MbHZpFfd0hjQhdQkE2pkqmuSmH7klp7M+4bTXWexA5+yD48ga5YW9rgu9xUTrce
 h0UJQi3dzSh6/NdMNQFoetalldlmyOl9MQg4ld6qM0rtytHAJH6o3gQR+xex4QOz5TFUiS7NPDP
 /tfZkPaAayST80BqMEsTENhY3tmN3rI51J06rPmXOVaC8lB8UVN5Lq/r+vm5Gqtp7IrQwCvnB4V
 XkAIv1s6i1gAs9+/0ItbR4SqEhIz4fIEgmpAkUrxgBdPep//Xvqo7WZBPD3PY=
X-Google-Smtp-Source: AGHT+IF3wH8GByi82OeaO026oyfWz3r6pdl6MJgn8nE63GBqpUgdfDA0MR3M97Io2/Op/i2b2E1iLQ==
X-Received: by 2002:a05:600c:3145:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-477870718cdmr27043695e9.2.1762947852564; 
 Wed, 12 Nov 2025 03:44:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e52046sm29769185e9.9.2025.11.12.03.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:44:12 -0800 (PST)
Message-ID: <dae06a78-2afd-43d0-ae88-2d2401d97cdd@linaro.org>
Date: Wed, 12 Nov 2025 12:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] tests/functional: Add a Beckhoff CX7200 test
Content-Language: en-US
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-15-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-15-corvin.koehne@gmail.com>
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

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> TODO
> ---
>   tests/functional/test_arm_beckhoff_cx7200.py | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 tests/functional/test_arm_beckhoff_cx7200.py
> 
> diff --git a/tests/functional/test_arm_beckhoff_cx7200.py b/tests/functional/test_arm_beckhoff_cx7200.py
> new file mode 100644
> index 0000000000..a7fb88ac30
> --- /dev/null
> +++ b/tests/functional/test_arm_beckhoff_cx7200.py
> @@ -0,0 +1,19 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a bare metal application on the Beckhoff CX7200
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest
> +
> +class CX7200Test(LinuxKernelTest):
> +    def test_baremetal_elf(self):
> +        self.set_machine('beckhoff-cx7200')
> +        elf_path = '/home/yannickv/git/build-TCRTOS/FreeRTOS/Zynq7000/DriveZynq_Fsbl/build/CX7200/Optg/ZYNQ7000S/CX7200_Zynq_Fsbl.elf'

Could you upload this file in some git forge repository like github?

> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', elf_path, '-nographic')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot mode is SD')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
> \ No newline at end of file

