Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047F6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhTT-0003tJ-4v; Thu, 13 Jun 2024 06:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHhTS-0003sm-57
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHhTQ-0006V2-I7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718273667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U9TqOQ3d9tpAIBh4M/ou7IR1CrTE4i2d0ftuymzPeps=;
 b=H9wPR4bBIqTp11Lc4BxG5+aFh6EvSj/IW5sDE0h2wMFrBezjTlH1XAWLgo/tEZgnPQ+0bI
 +Y9gdarLxbTZ20mnLRCL4CVtfgM/UhU3iUSTF9bvBo+62v4UWFcEIyr57ssszVoK3OTbET
 /RNzjluq+Sb99CtJOC2TOQhmbBoPuU4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-ZQqnKajAMxeohtCdnvQkTA-1; Thu, 13 Jun 2024 06:14:24 -0400
X-MC-Unique: ZQqnKajAMxeohtCdnvQkTA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c983f4285so759496e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 03:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273662; x=1718878462;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9TqOQ3d9tpAIBh4M/ou7IR1CrTE4i2d0ftuymzPeps=;
 b=UE/5bO45x1jmEwm3SdI/uvUtAhRhugB+tjHyTXsvz0HyGM63DFfVUWotyGJo3sbkl+
 33STxXVCv400GWdglzb+ZvferlqEX9L5XbiUmaRANwv1iX7pSx3yypY0AG64s9wiaNd6
 VyXXCRMrbFBTcfEsmRlo/9ONeDDvVTU4OJ74lJIU1By6KcGB+QuxuB4OtmC6sQyTw32V
 7EGcfpNs8SH/CwzMLo+kN4Bsnz/Y4hfRDkleJHbiCn19pLMifT2xLpfVQsHbxnjWk/pc
 Z2MVnk0P6Nr4Njd3tqRVOb4xWenwsSJKr5wF26AeZG8AW1osuudwTBaglGDmgm6typVW
 8Jxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7r3OSsxBp5auKYm95Bi5QiSYK0IIuNdTTQBb/y9PG0y1XLQR/U+6ogt1Y/19QvsH+KMb4HERSMN/0+kStBR0Mwr2kV9U=
X-Gm-Message-State: AOJu0YzmZOJSjCqLbG2VfhzbRUlc1XqQTjqWQnWTZRF9GPZOSYZIF0zU
 JAxEFayjNniP74RcZ06GRqhQYKRmieTSySHO2whjAFsAaR8p8KPyaPrugmA3qqW7+neCTuTIecU
 Cn5NBEac+UbctzvU0cQZPCZWjJ2Q/LNuj8FkmVrS4UucF4MEulWVw
X-Received: by 2002:a05:6512:3d18:b0:52c:8339:d09c with SMTP id
 2adb3069b0e04-52c9a3be48emr3758975e87.3.1718273662651; 
 Thu, 13 Jun 2024 03:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERvhu/sxfULwLgkNsxEpRtfrsM1lfSV3fkWVhH1rvWiReCDC/mtq6rldHRuiNJ05Rbjxcz7g==
X-Received: by 2002:a05:6512:3d18:b0:52c:8339:d09c with SMTP id
 2adb3069b0e04-52c9a3be48emr3758952e87.3.1718273662207; 
 Thu, 13 Jun 2024 03:14:22 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-242-210.web.vodafone.de.
 [109.43.242.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607510340fsm1255428f8f.93.2024.06.13.03.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 03:14:21 -0700 (PDT)
Message-ID: <ce50dc2f-2111-49a1-9b45-cb59a44a8239@redhat.com>
Date: Thu, 13 Jun 2024 12:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] QTest example for RISC-V CSR register
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240613095601.16299-1-ivan.klokov@syntacore.com>
 <20240613095601.16299-3-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240613095601.16299-3-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/06/2024 11.56, Ivan Klokov wrote:
> Added demo for reading CSR register from qtest environment.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>   tests/qtest/meson.build      |  2 ++
>   tests/qtest/riscv-csr-test.c | 68 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+)
>   create mode 100644 tests/qtest/riscv-csr-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 12792948ff..45d651da99 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -259,6 +259,8 @@ qtests_s390x = \
>   qtests_riscv32 = \
>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>   
> +qtests_riscv32 += ['riscv-csr-test']
> +
>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(
>     'ac97-test.c',
> diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
> new file mode 100644
> index 0000000000..715d5fe4b7
> --- /dev/null
> +++ b/tests/qtest/riscv-csr-test.c
> @@ -0,0 +1,68 @@
> +/*
> + * QTest testcase for RISC-V CSRs
> + *
> + * Copyright (c) 2024 Syntacore.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "qemu/error-report.h"
> +
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qobject.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qom/object_interfaces.h"

Do you really need all these headers for the short code below? Please double 
check and trim the list.

> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/qdev-properties.h"
> +
> +#include "qemu/osdep.h"

Duplicate include statement, please remove.

> +#include "qemu/cutils.h"
> +#include "libqtest.h"
> +
> +#include "libqos/csr.h"
> +#include "libqos/libqos.h"
> +
> +static void run_test_csr(void)
> +{
> +
> +    uint64_t res;
> +    uint64_t val = 0;
> +
> +    res = qcsr_get_csr(global_qtest, 0, 0xf11, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +    g_assert_cmpint(val, ==, 0x100);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/cpu/csr", run_test_csr);
> +
> +    qtest_start("--nographic -machine virt -cpu any,mvendorid=0x100");

You don't need --nographic, it's been taken care off by the libqtest 
framework already.

> +    g_test_run();
> +
> +    qtest_quit(global_qtest);
> +
> +    return 0;

You should return the result of g_test_run() here, otherwise your test will 
look like it always succeeds.

> +}

  Thomas


