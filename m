Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemQW-0003Fn-NJ; Wed, 01 Jul 2026 00:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemQU-0003FS-Vw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:19:55 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemQT-0000lN-3c
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:19:54 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664cb440f9eso214140d50.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782879592; cv=none;
 d=google.com; s=arc-20260327;
 b=bNm99nWaFc7P0NntrFlgHq/Hag+RCteWy3+/Xnf+HNLWZq0o1wEUmeboDE1qeHAwvl
 PPvKObOQX+K8LYVNGCahBETgL1xyqgB7PQAU96NjO6Xc3T7n1rU7KH6mGMNJ7dj+H4uk
 YYevJ/3TRNRiGfiBZs45DGBuxxGHALoS6za/X3TU54pPenVt63bkKYP0kUFobdjaFYIS
 VwQsgtPtU/EEmqGDiS1pLrcTQgZF+zer4hdIL/6OLnDFp2UwHgnc2n8ddAjwIGmejciN
 lSnVPWMo1QkJBnDyFgfBGIbwW6g/UwToiWE/ZTWQXRUxLmtspNfZYFU2lwidjPB2VXF/
 SBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CvgvBLihmNPjprZvfpqDIX5qq/Rjw5o8gsVoLpnBKA8=;
 fh=zNczsUAc7VUo12MdnrCOj5W1HTnGpzz3yepcOBqIM0g=;
 b=h4Q4voLl76Ul/UW2Erqt3a3za2aEY+QrPSgsMpq7LzgGADtzMBrN2ijiVLeqMMLoYm
 rZcHGaCCUrTYrxXuUSuKqOF+hfoFIvEEFIQN80I4kM33UlqReSbfP+1PVfdFD/147exs
 cu71Q5G/CkZuGmsWAbtIo9mAt0crac/3+oUu8Oc1viffDuRU14EQvyYZxlMPrQXgWpW8
 SErN/io84snqXksCIXLS+IgmJPtnLRK42zwk0suhPX/7ASqGZygDyKGdSIfEYogpdOj4
 ShKyYaWv1lpzr0MWCSzGLVfTUFSgNZPf04YqXH4zF41DMZpjaPPpW/LnsuS7O+0FVaza
 YMRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782879592; x=1783484392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CvgvBLihmNPjprZvfpqDIX5qq/Rjw5o8gsVoLpnBKA8=;
 b=fq3x21xTz7rlr9XCaL7T2Bmr2wxxk4n0qDoW8OPMh3/7ZLQcxFn3bhHX1zmw1KfwBE
 dvtwuzLBdAmFvSQKQxcL+IcpQOE1+4GeJKcVtCOY/jGdqJCcnYQf3kUGoEPAfaCSrUnf
 P+oeQpDmseVqL0405NSpPN3wKCDaxVn/tvS3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782879592; x=1783484392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvgvBLihmNPjprZvfpqDIX5qq/Rjw5o8gsVoLpnBKA8=;
 b=ARD/lD5ccmh0SZjwu+utaVFiK6Qx62pXhZztZdNtiPxB/z/NSEWrz4ToSuEPXRisP5
 YVzrzq6a7x+OABSOmWSPIfO7JjhQ2Z8nPc/TFwJ0X4+4k++4GOwIQQP1uCQAWTsV5IlZ
 0y/IqGEMFjQGrfLGWEhNwATxUpM7zW6xzO6H/8J/oeXcwbi4yPnnUspLdYyYDweTtLmS
 wfFrHkS9P0kf+XYTzLJKULPVOa4DjYDLtyvY4olV36QFotBPGFOFz/Wxe5NizepYESv0
 G3/04lP5E2aKVq9Q1stEswAooJpkLTztWuFAYskJX40scylUE/76muEmNWFrkwgb8F4s
 G82g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeF+5qfQO1OoXHjO1Qf8LeIad3vAeymfkeK4eNV/1B7qVa6TEoz9APHd4jMPd8XyrmXgBpvR4OSi9q@nongnu.org
X-Gm-Message-State: AOJu0Yxfc06tH2IZIcWQxfnUs5/ys015ipNOemJYe6Ho0TJmqFHwb5AE
 0gvGIW7ZRsSdg/wjMLyZviHTuRvH+HSLjtN4sf7p5lrdq2d6qqUTgSyV5ndQiz1+Jrl9gh6k4wa
 Qcmmt+SE+2PQo2dIGPKjMFSd3pIRifz8=
X-Gm-Gg: AfdE7cmKk+47H2YY2M7yBhM5pvvix3fZExZrcQX44x3/tJzGmW8fxxnScW0gGMUxxYo
 9xW/cIg2Zf5+jXARuediC0sVWvG6sG+1YqyndBJ3Qrzj+paSBq3B6TOgZ60Q8MU7HOJSpsxBchh
 6FAyEIAYZjTRPJ6f9QxZCAUaI0/TZ3pynNZZblpMVtunPGOGarGr001seaiJYMz6TtaFU3NG6Uf
 3wXGZuLz6g3yrbHmpHF3sYtaaYBxngoJLm+XUw1puyNIOqTBFyXRSbmC8IK5mzQAh7HXWkFin+U
 TH/z2JmnsizeQFXSfLGoVAO11AE+PhfOi1AO8kPoUMoki02vJ6FY5o9WaQFkGYZ6q6xBs4EvGw7
 MZUbEtV/BbLggDQ==
X-Received: by 2002:a05:690e:190d:b0:664:b514:a06f with SMTP id
 956f58d0204a3-66521958471mr37504d50.15.1782879591794; Tue, 30 Jun 2026
 21:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-4-visitorckw@gmail.com>
In-Reply-To: <20260616190147.1286316-4-visitorckw@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 13:49:40 +0930
X-Gm-Features: AVVi8Cd48M5qRjkGNLjxwKG1Gr3rOgK6CT4OdqS_FmrqEQlT4LaGWZSMTfJP-c4
Message-ID: <CACPK8Xe5DUNiBn1PLvDD3tBWFqaCzD0TUEGcK8UmV14gsRvWTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] hw/riscv: Add Sophgo CV1800B SoC support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 17 Jun 2026 at 04:31, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> diff --git a/hw/riscv/cv1800b.c b/hw/riscv/cv1800b.c
> new file mode 100644
> index 0000000000..c6749e1202
> --- /dev/null
> +++ b/hw/riscv/cv1800b.c
> @@ -0,0 +1,168 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Sophgo CV1800B SoC
> + *
> + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/riscv/cv1800b.h"
> +#include "hw/core/qdev-properties.h"
> +#include "target/riscv/cpu-qom.h"
> +#include "system/system.h"
> +#include "hw/char/serial.h"

Unused?

> +#include "hw/intc/riscv_aclint.h"
> +#include "system/address-spaces.h"
> +#include "hw/intc/sifive_plic.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/sd/sdhci.h"
> +#include "hw/misc/unimp.h"

> +
> +static void cv1800b_soc_instance_init(Object *obj)
> +{
> +    CV1800BSoCState *s = CV1800B_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
> +    object_initialize_child(obj, "clk", &s->clk, TYPE_CV1800B_CLK);
> +}
> +
> +static void cv1800b_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    CV1800BSoCState *s = CV1800B_SOC(dev);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint32_t num_harts = ms->smp.cpus;
> +    MemoryRegion *system_memory = get_system_memory();
> +    char *plic_hart_config;
> +    DeviceState *uart, *sdhci;
> +
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
> +    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type", TYPE_RISCV_CPU_THEAD_C906);
> +
> +    qdev_prop_set_uint64(DEVICE(&s->cpus), "resetvec",
> +                         cv1800b_memmap[CV1800B_DEV_ROM].base);

These could go in cv1800b_soc_instance_init. I think num-harts can
stay here, as it relies on the machine details.

> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +

