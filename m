Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECEA106ACE1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ldC-00087e-Ii; Thu, 12 Mar 2026 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ld6-00087I-PN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:23:34 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ld3-00046f-Pf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:23:31 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so1223547d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773343408; cv=none;
 d=google.com; s=arc-20240605;
 b=Zum9pl/rb2BWV6ljJhSiZGNVuDADUj3SlWlZWbIkA3goU/5/c7VmaANy+aBlMECjE5
 5EZ7XibQPk6kXya58kaC82DxIAQvWL4WwWlsAneP1YHKzHLDMl7ody9HbCWuJzWU2KZN
 yaCZlz6TKDjFr1kKzVj1MTid21aSSY1usIVaADHD7WliREh8kOH/vOIKI6nQpaOZJMmj
 9Rc7jV4lH8Fj9LII5qfcWFpaPEBWVEyVxGMD1CiCkCpy4rJFNEb9bYIJTP6HMOBY/OPz
 buMJgLiQSKjBEP3btGGRq73VAm1PLMa6f/EuYiVQQlQXJ1Bx5Umr8md/GE5lJHBwxlc+
 7mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=guCvf9N/EXv9zX+nWdqCr2sGMnAPCZsaNwa34jA1JhM=;
 fh=YZ4+q4udaZA2X9LZgots578Fh7VXJjLlDbHusn/+Hu0=;
 b=em2Is69kMpxc4iNrmWt6aOsNOwzXLt8CL8/rDGVDQ5qlamTKBm9eMZd+Sk1fOEdDJh
 CziE7vW4eYisfJjISLhWDC/YUO1WKVckHTHgrS18hq/5vfsw6nwhDNJpQ1XcWB5ICrht
 LRF+qe7Z1ein+YiDy3MrgGqyWV2T8GZiQw/g/KYEqYGlahHKtQurp8r7Bxt8bay65mOK
 H9RjnlmcjhUMWzNKX//99WbgDrQ3M0QRkC1kTg7VYkosjmnC7m/0QnX+s/1KujYdRByp
 vtqaGIhnGq6VGt3sr25egVMZrdy6EwszKJBEkyzZ4R8uyi+zikOGdwUUrEfB1vDxiU3l
 TEyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773343408; x=1773948208; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=guCvf9N/EXv9zX+nWdqCr2sGMnAPCZsaNwa34jA1JhM=;
 b=nP0yk0RYmOP4PtTvBSTx8ITaxnyXmvzqBZdFpXkR4wYML/X+7l2sjw6ddXnRbcpoLa
 CFyl3PkMaMDMFcOczqJ5NGlnZjBdE9yik/H01Q/GKizJ4d0SBwybRobEoQTCQKiJeaGD
 A+dw6poqXCC53MDMrsWwk5YMusQiWRCRlp1GKQBLUObuRhb+zQ2J4T5kfAQ0B/hRswK5
 HlysneVgw935B5ooEjJcNK3n7KSkRsvi/cZDjDUF1b+PQOWLprSJ6OKWsauIyJQYfTZd
 gAng6DsWv3cKclUWayKBtySzjup7280dsE2LCLtEZayA8VmO5f2EYmfpBDNLgahI4zSl
 diaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343408; x=1773948208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guCvf9N/EXv9zX+nWdqCr2sGMnAPCZsaNwa34jA1JhM=;
 b=V1MRN4I3AU1Uf5SLgAgSw8+OhA+T3ixnG/51aszHHNCe3iXDwjfaMTD7TGGqIAvsf3
 DbHSMtx47KbIKDMwS7A4Bddfs5Sky6oLudH53+CMNP8myDMWM+cu2lRNp1WLnICHBySs
 +7LtGjnxaY+GN4dyfKZ6xhg4w0xFABubg0Yo6/LtCXyvHRIjzsph26UIfe7H5nIoAXqf
 Nku4WtA7CtHXX2gh9PtYjsBaC/hSEtcnE8X4G9Mla09fWLkDfgzzFGzsQW/ay7pYP/BB
 g03P4+4oKR6/QXCf5DZbK8/f8fu3hndcRbfu77r3ZGstv3UGpOHI1mPX/r4sG18V5P/F
 OM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJZVa4NTQkMxin8B2M+yeQgc5iXatVjuwEQhCa1MV5ufks3Zz724rgGXypRo4vV67nIZH+GmjPRzbD@nongnu.org
X-Gm-Message-State: AOJu0YxF5cESUaNmjiYLZVn354NRibSciii7brCE0y8wJBIJn/GoOWJo
 KOqNaszMqpCmy3pfCSZoJAa2N3YTYS+MOgWHMCSFUQVTfM2kZcCHlvoh10ICBa/1MaN3M4Z2U4V
 z1f4TliPzO/gSTie6VpHkcph08TcNEtFotBuVzQwFjQ==
X-Gm-Gg: ATEYQzx6aOHJ+UsuZcTNLBFR7kn3jFfJrWNPTeS0iqsr89qqRcTLTzE2SR13NXKSNgR
 sDoypMVE+66v/ntwwv6+Sqy1p+goHYkBIYel5fRT0kWaLhKLq0HlUuvKh/SnmVAYb50IZr54iVv
 PWLy4x8Q+dLtrJyaFptmfKo9q/m6LfQY8J7w5WM/YCFknjoHLq+NzzR7sKlOV7//oWZA8+nFwuv
 Fu9OEsmV4jchgIwDChIy9yJnQNh2/IAI2i2xk13GxMBYEVcEzcBvLAnzEvUTDt0nDdMSXikkKBD
 hlVY1M15gfEAi3poJvmqDDf3jpSzHM2HS+Fh4vb5rL8BTiFLm0E3azZzBnDIHDcmP9Y=
X-Received: by 2002:a53:b45e:0:b0:649:412a:dd11 with SMTP id
 956f58d0204a3-64e630ceb0bmr619428d50.74.1773343408461; Thu, 12 Mar 2026
 12:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
 <20260311154934.1575429-3-tangtao1634@phytium.com.cn>
In-Reply-To: <20260311154934.1575429-3-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 19:23:16 +0000
X-Gm-Features: AaiRm50JZDf5rc6NzkRv-BAqy5vqz-zq5Y5e16lDzZ_SlNusYvA_Xa3wr5UQsNw
Message-ID: <CAFEAcA938c9iwZ9oMfd9b_X840PvWFPExmWUxArYssotosDWGg@mail.gmail.com>
Subject: Re: [RFC v2 2/2] tests/qtest: Add qtest-attrs-test for memory access
 with attrs
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 11 Mar 2026 at 15:50, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Add qtest-attrs-test to exercise qtest memory commands with optional attrs
> on aarch64 (virt, secure=on) and x86 (pc, tcg).
>
> The test covers:
> - ARM (virt machine): exercises all supported ARM security spaces
>   (non-secure, secure, root, realm).
> - x86 (pc machine): exercises secure attrs accesses
>   (SMM address-space path).
>
> The test also covers libqtest-single *_attrs shortcut wrappers and
> verifies that space=non-secure behaves like omitting attrs.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  tests/qtest/meson.build        |   4 +-
>  tests/qtest/qtest-attrs-test.c | 234 +++++++++++++++++++++++++++++++++
>  2 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/qtest-attrs-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index be4fa627b5..c11759e23f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -115,6 +115,7 @@ qtests_i386 = \
>     'drive_del-test',
>     'cpu-plug-test',
>     'migration-test',
> +   'qtest-attrs-test',
>    ]
>
>  if dbus_display and config_all_devices.has_key('CONFIG_VGA')
> @@ -270,7 +271,8 @@ qtests_aarch64 = \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',
> -   'migration-test']
> +   'migration-test',
> +   'qtest-attrs-test']
>
>  qtests_s390x = \
>    qtests_filter + \
> diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
> new file mode 100644
> index 0000000000..ce204c2c95
> --- /dev/null
> +++ b/tests/qtest/qtest-attrs-test.c
> @@ -0,0 +1,234 @@
> +/*
> + * QTest for memory access with transaction attributes
> + *
> + * Verify optional attrs argument support for qtest memory commands.
> + *
> + * Copyright (c) 2026 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqtest-single.h"
> +
> +/*
> + * Default RAM size is 128 MiB on both machines used below.
> + * Keep test addresses in low RAM and away from device MMIO regions.
> + */
> +#define TEST_ADDR_OFFSET    0x1000ULL
> +#define TEST_ARM_BASE       0x40000000ULL
> +#define TEST_X86_BASE       0x0ULL
> +
> +#define TEST_ADDR_ARM       (TEST_ARM_BASE + TEST_ADDR_OFFSET)
> +#define TEST_ADDR_X86       (TEST_X86_BASE + TEST_ADDR_OFFSET)
> +
> +#define ARM_MACHINE_ARGS    "-machine virt,secure=on -cpu cortex-a57"
> +#define X86_MACHINE_ARGS    "-machine pc -accel tcg"

You start a virt machine with secure=on, but you are only
testing the RAM, which is mapped regardless of the security
space, so this will not notice any bugs where we don't actually
access with the correct attributes.

It would be more interesting to look at the secure-only
RAM (which is at 0x0e00_0000), which should only be accessible
via the secure or root spaces. (I'm not sure what qtest will
do for attempted access via non-secure and realm, where the
address will have nothing mapped there. You'll have to check.)

I don't know if the x86 PC machine has a similar bit of RAM
or whatever that behaves differently for secure and non-secure
accesses.

thanks
-- PMM

