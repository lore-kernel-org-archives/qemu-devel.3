Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97CC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWx7K-0002Aw-Bj; Thu, 25 Jul 2024 07:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx7F-0001rP-8q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:58:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx7D-0006M1-AE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:58:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367963ea053so598415f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908714; x=1722513514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fw15GzZcTHTDv/fxWdELoem1xszdI39hrdYstoDZCb8=;
 b=G/WBGQyhRzeznHJXqPD7Fu2RpdGp1/XtHAb7G0goXLrYZnvwPPyZe+aatvjaYZacKO
 fAbX84DZG+VqE/YDFlpBEEiQ08sPTJ18DQUVvpwjZvwFnJYBmJOIJAn87cqg4El84TcZ
 G/P6pfA7ulsK7hCLM6rw6iMYGD72mNOIpw8NcDJZgSVjRwH3wsi1Q4RXmcxzwU7f+L48
 2DF6LnIXl/tQc1mnYjwMxWOUpr979SNpo9oAasELWsRwbPTNd800206Mih9lPyYdLhLK
 S43LuGpJvM3hWyoFOZo3n5KzQPsDegK3MnUMwPeZhSlUNNG727xcyjwkEz5TP23r8bLp
 Vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908714; x=1722513514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fw15GzZcTHTDv/fxWdELoem1xszdI39hrdYstoDZCb8=;
 b=X7h8Q8RbSAhjlXgFHKTATj7D0jkKWeKsYIix8BFBiBsk/88NKzqcUDL5lGnb7mqobx
 D5sdvBiHlTms6LGVxHwG1DijZjgQURk6ifA0mPZwOsmFcxjyb3vDEiodm9ViA+VTtn/i
 zuof4SvkY1swlwVUhEUidYYbEqN0m/cyyUFyhIX2sIGzT3diNUBZcqCANwuLJY4Ise9r
 Vj9De4Sy82V3zlIZYTs+JD5QuMzXZIkFJTU2q+jFZJX1C3AxjMx5INdzjKu5dzNArWDh
 0s5OQVsCLRIyTU4d9gXmQqMQrr4KzMlX3QfNuYtUBPN23HYWl3AQYG4Tp2GWSiRe+/Dq
 zwbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhSznVwW5ALLmjZGsud1lGmiBfWfHqhYWpHhdRSJmxEb5eggzpABy3eyV6gfIuR4spg21r8CZNd4S5tcT0WrvSZ/7qzBA=
X-Gm-Message-State: AOJu0Yysvf5oWPMT2Doihro9133HcEpAyzanp0OU/EB4LfUEPsR0d4/c
 hRkUuEycf6eTxlIrLG+OCPX3KxoMT5Av0TXQ1ndEzrUvrTLHWtIqGZNrpDeI14E=
X-Google-Smtp-Source: AGHT+IEfav/E0JoL4fs8XJFFpNJslWceXmd0GzWTgePcCtMhg85iwOXixhhiYOJAzgHo2s/++2rggw==
X-Received: by 2002:adf:fe0c:0:b0:366:ec30:adcd with SMTP id
 ffacd0b85a97d-36b363afb47mr1634775f8f.7.1721908713785; 
 Thu, 25 Jul 2024 04:58:33 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857fd1sm1943629f8f.69.2024.07.25.04.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:58:33 -0700 (PDT)
Message-ID: <124b4dd0-abe6-485a-b7ed-cfa2bd8e071e@linaro.org>
Date: Thu, 25 Jul 2024 13:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] tests/functional: Convert simple avocado tests
 into standalone python tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> These test are rather simple and don't need any modifications apart
> from adjusting the "from avocado_qemu" line. To ease debugging, make
> the files executable and add a shebang line and Python '__main__'
> handling, too, so that these tests can now be run by executing them
> directly.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  5 ++
>   .../test_cpu_queries.py}                      |  7 ++-
>   .../test_empty_cpu_model.py}                  |  7 ++-
>   .../test_mem_addr_space.py}                   | 52 +++----------------
>   .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>   .../test_virtio_version.py}                   |  8 +--
>   6 files changed, 34 insertions(+), 56 deletions(-)
>   rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
>   mode change 100644 => 100755
>   rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
>   mode change 100644 => 100755
>   rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
>   mode change 100644 => 100755
>   rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
>   mode change 100644 => 100755
>   rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
>   mode change 100644 => 100755


> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/functional/test_mem_addr_space.py
> old mode 100644
> new mode 100755
> similarity index 93%
> rename from tests/avocado/mem-addr-space-check.py
> rename to tests/functional/test_mem_addr_space.py
> index d3974599f4..bb0cf062ca
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/functional/test_mem_addr_space.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Check for crash when using memory beyond the available guest processor
>   # address space.
>   #
> @@ -8,7 +10,7 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -from avocado_qemu import QemuSystemTest
> +from qemu_test import QemuSystemTest
>   import time
>   
>   class MemAddrCheck(QemuSystemTest):
> @@ -22,9 +24,6 @@ class MemAddrCheck(QemuSystemTest):
>       # for all 32-bit cases, pci64_hole_size is 0.
>       def test_phybits_low_pse36(self):
>           """
> -        :avocado: tags=machine:q35

Pre-existing, we should use set_machine('q35') in this file tests.
(Can be cleaned later.)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


