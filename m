Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156FAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Sal-0006eO-TX; Thu, 02 May 2024 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Sag-0006dd-DL
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:18:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Sad-0002vt-Gb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:18:58 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso9839858a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641534; x=1715246334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMTlOuXw/w8ul+1mfZsUesTfYYUEXYhKpfU4N/4QUK8=;
 b=M2xL8WjzBFjGnDsPgNM/LRdblGzORr8dvFd4VVZHYnepN4ehDJkMqN0MjGW4j9HtM9
 YzJBgSzxgdg29U8xE5/xUF4P+aDsRUo3h+99DJ5C8S8rblyNBU42t9mlTeyI+mfmirUb
 snvqLTioY3TguX8ADXwkH4P9yNEwIStHS1hXhdMZm3G/PJvIkZV+YoqQV4dYpcTo+yM3
 otbHODtRnDHcdsPKQWj6nMR5lI9/Lcw22jAaqgVCxILUCG6wtGX7A1tBdktCQBuhBI1g
 lt/SV/zRFDT6ffzrC+wER0MXyRRuyW90JVfZd7v8FjQRqInJ1mhObDeFKNi3DVfjbr3h
 916w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641534; x=1715246334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMTlOuXw/w8ul+1mfZsUesTfYYUEXYhKpfU4N/4QUK8=;
 b=rKWAkVKaDn8fnCyZs2spD3QDbRDXj3slJWAiYhExrku/AjSdXnkmZfOTF1H5AcPaZN
 QSy7qzThzQqYAYTHJm7URjkGEMEGnlAzWpzJxMpvuHweTyc5utjKYgDaikZ/RbndTHB8
 KRjrYzZN95iWoGIVV/BnP3QpcXiCanHzVJGYY3dWdGjr+O/uAOvaqG8xwL14sCue97P5
 csdvcHRVWNFjXgJSwbqxDUOmtarwjpyw85qdE/99/zfRQ2xR517+B40ZSDkiIp68+Shx
 /jhKjAXCTVEV/ShIN9YkltapizKMtotgxRW1CPLfZU93BV4Rr5/je3OxZDqqRIgi+G3y
 bV0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKhjNNrsGVUSQW2NNqhApkg0w5SMxyTI2L4pw2cGNX4XkjAqkX+HPPdo1zEULw7gTfix/8ET65rjSJAVo7Mq7NGcUqjxg=
X-Gm-Message-State: AOJu0Ywk19NNwYT96YuDx385C7wQEXLWt+Q2GRC595mbnxlhQYeyVp1d
 95hResbNjuEjK6qm4OBMN1mM+ic8q8rn5U+jbF8WSwRdYxgvD89p7GQf/mx6EC0F3/SrMm08eLb
 hgi5hk+KFd5Aih/HqAgpjCUmuWqqEz2snBQAtwA==
X-Google-Smtp-Source: AGHT+IFf1m6yKAKc2SGjbWTwuJ4aovFbr6TnpT35iuSgSDHlIHqSIPH5R/AmsnceDqUpu8uqJOrvfd6oOFF+ZwMA3+E=
X-Received: by 2002:a50:cd15:0:b0:568:1882:651f with SMTP id
 z21-20020a50cd15000000b005681882651fmr998821edi.25.1714641533837; Thu, 02 May
 2024 02:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 10:18:43 +0100
Message-ID: <CAFEAcA_FO7BvUDbnJdUTkuatFse7bWR2mjL2OQ_vsB_dLdKbow@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Upgrade ACPI SPCR table to support SPCR table
 version 4 format
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 2 May 2024 at 06:12, Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
>
> Update the SPCR table to accommodate the SPCR Table version 4 [1].
> The SPCR table has been modified to adhere to the version 4 format [2].
>
> Meanwhile, the virt SPCR golden reference files have been updated to
> accommodate the SPCR Table version 4.
>
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
>
> Sia Jee Heng (2):
>   tests/qtest/bios-tables-test: Update virt SPCR golden references
>   hw/acpi: Upgrade ACPI SPCR table to support SPCR table version 4
>     format

This isn't the right way to make a change that requires
updates to the bios-tables-test reference files, because
"make check" will fail after patch 1 but before patch 2.

You need a three-patch approach. How to do that is documented
in the comment at the top of bios-tables-test.c. The resulting
three patches should look like:
 * patch 1 updates bios-tables-test-allowed-diff.h to
   mark the affected test or tests as "OK to fail"
 * patch 2 makes the changes to QEMU that alter the
   required table output
 * patch 3 updates the reference files and removes the
   tests from the allowed-diff file

See for instance commits 6c1c2e912fcf9, 1ec896fe7ca938,
ea2fde5bccc514 as an example.

Side note: if riscv virt has APCI tables now, maybe we
should add testing of them to the bios-tables-test ?

thanks
-- PMM

