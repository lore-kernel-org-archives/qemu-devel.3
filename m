Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDBED735FD
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 10:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKQK-0004Cn-95; Sat, 30 Nov 2024 05:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKQJ-0004Cf-HM
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKQH-0004mW-UM
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732961396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JZDzKxypWj5dMFIYSrUdhUtroh+poBTBz8r0T96U+Ik=;
 b=BiKl8O8OWAkHhpvwDwyQeuo67/nsgq+5L/zDbyU5OWnBi4CD8BL0vvOcrTLoG1wY1lQPcz
 lRuaBAGw5pKSUq6WL/FfyWwNgOgiOn6NVTJUAdkLa0hLJC3zN8QE+AXcTR4bGkETFNvxf2
 vcilxrA/1NOWgW65fatpMPUOZxXTvD4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-nxpEMdWsNyS_B4GZXMgMrQ-1; Sat, 30 Nov 2024 05:09:53 -0500
X-MC-Unique: nxpEMdWsNyS_B4GZXMgMrQ-1
X-Mimecast-MFC-AGG-ID: nxpEMdWsNyS_B4GZXMgMrQ
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d0ccbbc4a7so327063a12.0
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 02:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732961392; x=1733566192;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZDzKxypWj5dMFIYSrUdhUtroh+poBTBz8r0T96U+Ik=;
 b=CsSTFBL3dJ6Fxe0FVHwvU3r0ChMMmFcNS+PQeQiXtFENHfCuPJFEoXf3wDkZSLXAfx
 MQmn1VXqFQ2MCENCf6ah/02XpIAmMqXssegm0binIgYbZqSavM6+Hw34qTv8M/ixMpCd
 rFvQ2g7gYSfOwoJ+Km8AWlLt5Oz71VhdvibFBcdrTx5LCOR1K42vRneoB6JK8rT0wLeY
 A+NFeYyGfJOdNkWIwMRwR3ZQ2BZw3GrbePrNWP9pBmojbvtDgdNXfHHhgo0ZSJLlX/vo
 b2O63gyPA+0ceeBkSrHbab15fwaMIJbIyfrFdLrVljoUY6T3Cv4FgY0GMEG25DUAgRyh
 jPgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFiFu+VuJpasjwRSPho6PZpZM0zFB3S/Bg4dnXx7a303+t1EX8/fsq1Z2HtM15XI+jzXpivt00WN18@nongnu.org
X-Gm-Message-State: AOJu0YwNh+Azbsq2CbH0pxJ4avG/dIWjLgdILnbPQvYjhiMBfa5Joz/2
 DgLWRL6DyD5byVxSbInkya6v3QZE8DByBDForu63H34kdRyJr+Pur8LQoDqV8Mto5XQN9yo24NV
 Z+YqVtLbRtEAxqQlNg+RruPKoBqtutdJ46q4jVehAZE5at+XrbBFo
X-Gm-Gg: ASbGnctCC9FV3yT6Yu64XkjWLAywP0FvKllcfww1v6wNiLb6uXH9vMXBZY3PX8TKH5j
 tlZQHWF/aoCPqJ+thD1lbHv/kRd76WFFBLLGrjfN0d7QQGm94Sq4t/ZTYHieEsoUtevg2t27Ju/
 co9/kQ7V8GEbpz3PGdzHsgwgYV/I+1f1oZTwM2TWuUbgZugDvalLXeSvtgry3uk1G2hiTX+1nZ6
 jkb5k/yCo8EgqI015IvnxwIY8DePxp94+cK88srdg9HutBr34BeUEX1URa8RPxogTM+PFDZcz+Q
 mJMFoQ==
X-Received: by 2002:a05:6402:3210:b0:5d0:bd2a:fc1d with SMTP id
 4fb4d7f45d1cf-5d0bd2afe30mr6039036a12.23.1732961391896; 
 Sat, 30 Nov 2024 02:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB+eOvJ1nrsvBcs5g/JqZZbRrdRu9ADIyeYDS5nbNxLPF8LKFZ8uUu72vwHDSdzEJxEiaa0Q==
X-Received: by 2002:a05:6402:3210:b0:5d0:bd2a:fc1d with SMTP id
 4fb4d7f45d1cf-5d0bd2afe30mr6039009a12.23.1732961391508; 
 Sat, 30 Nov 2024 02:09:51 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0d0a026e6sm229717a12.80.2024.11.30.02.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 02:09:50 -0800 (PST)
Message-ID: <c9dd8d50-734e-4322-8ad4-c77544705916@redhat.com>
Date: Sat, 30 Nov 2024 11:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] tests/functional: remove duplicated 'qemu_test'
 import statements
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Group all imports that originate in the 'qemu_test' package into
> one statement.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/tuxruntest.py         |  9 +++++----
>   tests/functional/test_aarch64_raspi4.py          |  4 ++--
>   tests/functional/test_aarch64_sbsaref.py         |  5 ++---
>   tests/functional/test_aarch64_sbsaref_alpine.py  |  5 ++---
>   tests/functional/test_aarch64_sbsaref_freebsd.py |  5 ++---
>   tests/functional/test_aarch64_virt.py            |  6 ++----
>   tests/functional/test_arm_aspeed.py              |  7 +++----
>   tests/functional/test_arm_bflt.py                |  3 +--
>   tests/functional/test_arm_bpim2u.py              |  8 ++++----
>   tests/functional/test_arm_canona1100.py          |  3 +--
>   tests/functional/test_arm_integratorcp.py        |  3 +--
>   tests/functional/test_arm_orangepi.py            | 10 +++++-----
>   tests/functional/test_arm_raspi2.py              |  4 ++--
>   tests/functional/test_loongarch64_virt.py        |  6 +++---
>   tests/functional/test_microblaze_s3adsp1800.py   |  5 ++---
>   tests/functional/test_microblazeel_s3adsp1800.py |  5 ++---
>   tests/functional/test_mips64el_fuloong2e.py      |  7 ++++---
>   tests/functional/test_mips64el_loongson3v.py     |  3 +--
>   tests/functional/test_mips64el_malta.py          |  4 ++--
>   tests/functional/test_mipsel_malta.py            |  6 +++---
>   tests/functional/test_multiprocess.py            |  4 ++--
>   tests/functional/test_netdev_ethtool.py          |  3 +--
>   tests/functional/test_ppc64_hv.py                |  4 ++--
>   tests/functional/test_ppc64_powernv.py           |  3 +--
>   tests/functional/test_ppc64_pseries.py           |  3 +--
>   tests/functional/test_ppc_405.py                 |  6 +++---
>   tests/functional/test_ppc_40p.py                 |  3 +--
>   tests/functional/test_ppc_74xx.py                |  3 +--
>   tests/functional/test_ppc_amiga.py               |  3 +--
>   tests/functional/test_ppc_bamboo.py              |  6 +++---
>   tests/functional/test_ppc_mpc8544ds.py           |  3 +--
>   tests/functional/test_ppc_virtex_ml507.py        |  3 +--
>   tests/functional/test_riscv_opensbi.py           |  4 ++--
>   tests/functional/test_rx_gdbsim.py               |  6 +++---
>   tests/functional/test_s390x_ccw_virtio.py        |  6 +++---
>   tests/functional/test_s390x_topology.py          |  7 +++----
>   tests/functional/test_sh4eb_r2d.py               |  4 ++--
>   tests/functional/test_sparc64_sun4u.py           |  3 +--
>   tests/functional/test_virtio_gpu.py              | 10 ++++------
>   39 files changed, 85 insertions(+), 107 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> index ab3b27da43..7c0456923e 100644
> --- a/tests/functional/qemu_test/tuxruntest.py
> +++ b/tests/functional/qemu_test/tuxruntest.py
> @@ -13,10 +13,11 @@
>   import stat
>   import time
>   
> -from qemu_test import QemuSystemTest
> -from qemu_test import exec_command, exec_command_and_wait_for_pattern
> -from qemu_test import wait_for_console_pattern
> -from qemu_test import has_cmd, run_cmd, get_qemu_img
> +from qemu_test import (QemuSystemTest, exec_command,
> +                       exec_command_and_wait_for_pattern,
> +                       wait_for_console_pattern,
> +                       has_cmd, run_cmd, get_qemu_img)

Is there a real advantage in writing it this way? For most files, this not 
seem to reduce the lines of code, so at a quick glance, it rather looks like 
unnecessary code churn to me...?

  Thomas


