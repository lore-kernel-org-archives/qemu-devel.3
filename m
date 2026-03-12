Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745FC106ACD6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lW2-0006K0-EB; Thu, 12 Mar 2026 15:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0lVm-00068i-UM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:15:58 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0lVe-0001nG-F5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:15:52 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so1507456d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342949; cv=none;
 d=google.com; s=arc-20240605;
 b=Um51Zm3ZVTnj5nYwyiSJpW6GxlTQiSCzkLAPMZe1ADEkeqZPBNO2nkiS3Ngx6UdHnP
 pvBsKsiczK3TWSdH6paMUv/CS7MNx2iC6/DlocxOoWqz0huvjz+WdareHCmBWI+IbjfZ
 RP1uPCcK/l/FV3sCdl71DESJyAhGphf1fEhFKoQ5FuXWivP1YMYFuRp6t5JFtIY2enGW
 jaMxV4SxcFE7Ej6VY4Og82XfIiZ5+KRKOjtrKMlEG5EqHeu/y7E9fQXd0+bTDuH7r7fA
 KBiN5986RG4CNlvS0T3raOLZVFtFej+1Z0BLUqtvNi/G24YQ+OQ4hV+45xkYF7Xezm06
 9cjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CZE1GVGw0o+3Uzw762xjq40tID5vsPfFCceSdf7m5RE=;
 fh=1WNUifhHDOjKS4z3nU6h08zGda5O3wux7NVFjd/K9IA=;
 b=N29X3aAHIwrauT2fywnYvS6ADE3w/VjzwJ40RgeZqHcYNIcnX1gb1IW3L8jgwEzTsN
 vz65rl2srzDmTpBb+1AzWfLxCPUTU5MF9foiUiXmNNmyIn2ZsVtYx1YhZjepNONJl4du
 HqjXXj7BM7akC6HSXwZt9EqG48BuxBi4HQ6RBVOGEWzl6RRJitokgBmbuonzU9KkusWh
 9FgKmCp67Nnw2S5VcvJIAlzo61racfTqf9ZF8OJGNRedzg+OBmoK4GeYkRw2l4gMCt62
 65pkJ6NEJ2GEhSnkXze8iAmlwLooWkayVda9eQk09FeeqqlrbuDnOtXsX/1uaEMPSmqu
 2txA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773342949; x=1773947749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CZE1GVGw0o+3Uzw762xjq40tID5vsPfFCceSdf7m5RE=;
 b=hNqmOb3ph21yuoPT+gu+q3lyHs8aaLsFhoMqzHYVZilMTHQBB1ilD3HudKwLgTo6zT
 xVpXulCgWnN8AYf3NdP/m0Ko9nJ4Qev6GALBtMbef1xBPhChvi7e42OgZDdUnz0u/xvu
 dJ87BjhHqiWZeE78L/TTGUO1J41d7eT+TCYc/UAW5JbzZanVqs859sLTRk+SNjGJ/rGW
 m2OJUrjhyF0265Z3q19a7mJFCOcp9bEJiFmp/0yY5AgepbReUV8qhbwvOfPOtZSZqiEW
 V0CrW8v89/ftf0/OwK9qpa3dl4uUo/W/nb7ys/J+pcwD39wjQ6cAAx9yHPXJI8whVp0f
 dYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773342949; x=1773947749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZE1GVGw0o+3Uzw762xjq40tID5vsPfFCceSdf7m5RE=;
 b=UKWStpYQTgr6CUFHI0PCFkaAEBEaYvqH1H+ycI2eCSP2lPDUveveFNIZXABjKjdx0K
 65EDMy+7rzqn7G5UXU7kr43zjEzoLIiY64YqdaQ35XHMr9Zh7T7DZA+FBH8MFb3TYszL
 ip54wITsHmz8fhYslqMxw8tqkUSIFCUU8N6RU6wMHUmL3ucz1MnP+cyhF15jwWpsnNBJ
 EVGcQAAKNGEpMsr5+5/4wM9DzbD2vfi3j26F/9QquTjHo/Du0QYEze10Dwb0T+wLlh1l
 3lW8gYkEcWjt+aL2nlqiCPSOu3v8ehKXcVELSGCuwv2lsWYeecGRqKAn5IqoXzCDG2tv
 1eEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaJAIi4d/800n2vrbNr7ylmhN4JeuFQXQI3SSlgozjtMnWOFYCtHHMFFB+afXQHAPk8LVvEZCVHeZq@nongnu.org
X-Gm-Message-State: AOJu0YwJepQB1aKnJswi6KmkhLmI1RRti/fc5GekvI5te/+ikyxXiXso
 KXpZuR4T4fc0Pl41fMrQ05Xc+Hb5As2TbC7UrO3ojTjOn/r4Uv7hNmQ2lLoSPYeNdOlqn9txCuA
 VF/HQbPswgzT0IOEav7SAcJFREuts9dqwpCB/u96uaw==
X-Gm-Gg: ATEYQzxcmND3d1LDkqJbZbbZ5DvE7rd2czlmv2jNBY7tZZPwRr042tbjXgzFLaUeoff
 HuKtgDKWC7l0lFLhWqkgwd3REuNk17pq5JnSL+o/I6S2K/nUtUWJKoI5y0ukGC/sBUlvCpude1t
 ynhDzyggXGYvKowkuM1fRwpjfR5wtrUilKkMRNKKRVpjADrngjHgJrczgW+cFMYxmj6urjyAW5P
 c6jkh5ofUcZsYz0zve92Wm0uRHsK3CG4ZAR0o4X7BitM7P5grqSRJnAdq7VJAHdGOO5htI5/Wnp
 +CBv+28MPBVORSb+Fu+bvk15aldNCW+gtCeapWGHt1nK1Rqz7Fq8UNlNPgTrlD4silU=
X-Received: by 2002:a05:690e:23cf:b0:64a:de2a:e6e9 with SMTP id
 956f58d0204a3-64e62fa3c62mr499452d50.24.1773342949091; Thu, 12 Mar 2026
 12:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
 <20260311154934.1575429-2-tangtao1634@phytium.com.cn>
In-Reply-To: <20260311154934.1575429-2-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 19:15:37 +0000
X-Gm-Features: AaiRm53Eecye_MD629qktofEP_ngHDSshnc9Jky8ktpJxKpIYVzlrUZVaesG0XE
Message-ID: <CAFEAcA8_ymW_5ZRYfJNdrajATYbNCsnD8xbV3-6t7fpecrhAdw@mail.gmail.com>
Subject: Re: [RFC v2 1/2] tests/qtest: Add attrs argument support to memory
 access commands
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
> Extend qtest memory access commands to accept an optional attrs argument.
>
> Supported attrs:
> - secure (ARM/x86-only, lowercase)
> - space=non-secure|secure|root|realm (ARM-only, lowercase)
>
> For memory commands, parse attrs and select AddressSpace via
> cpu_asidx_from_attrs(), then issue accesses with the corresponding
> MemTxAttrs.
>
> Expose matching libqtest APIs:
> - qtest_{read,write}{b,w,l,q}_attrs()
> - qtest_mem{read,write,set}_attrs()
>
> Also add libqtest-single wrappers for the *_attrs helpers.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  system/qtest.c                | 266 ++++++++++++++++++++++++++++------
>  tests/qtest/libqtest-single.h |  61 ++++++++
>  tests/qtest/libqtest.c        | 148 +++++++++++++++++++
>  tests/qtest/libqtest.h        |  25 ++++
>  4 files changed, 453 insertions(+), 47 deletions(-)

This is a pretty large patch. Please could you split it in two?
 (1) add support for the new commands to system/qtest.c
 (2) add support to libqtest for sending the new commands

> diff --git a/system/qtest.c b/system/qtest.c
> index cf90cd53ad..dbf3a63c57 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -22,6 +22,7 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/cpu.h"
> +#include "hw/arm/arm-security.h"
>  #include "qemu/accel.h"
>  #include "system/cpu-timers.h"
>  #include "qemu/config-file.h"
> @@ -218,6 +219,39 @@ static void *qtest_server_send_opaque;
>   * B64_DATA is an arbitrarily long base64 encoded string.
>   * If the sizes do not match, the data will be truncated.
>   *
> + * Memory access with MemTxAttrs:
> + * """"""""""""""""""""""""""""""
> + *
> + * The following commands allow specifying memory transaction attributes,
> + * which is useful for testing devices that behave differently based on
> + * security state (e.g., ARM TrustZone/CCA or System Management Mode in x86).

A small nit, but "Arm" is not all-caps these days.

> + *
> + * The memory access commands above support one optional ATTRS argument:
> + *
> + * .. code-block:: none
> + *
> + *  > writeb ADDR VALUE
> + *  < OK
> + *  > writeb ADDR VALUE secure
> + *  < OK
> + *  > writeb ADDR VALUE space=realm
> + *  < OK
> + *  > readb ADDR secure
> + *  < OK VALUE
> + *  > readb ADDR space=root
> + *  < OK VALUE
> + *  > read ADDR SIZE space=secure
> + *  < OK DATA
> + *  > write ADDR SIZE DATA secure
> + *  < OK
> + *  > memset ADDR SIZE VALUE space=non-secure
> + *  < OK
> + *
> + * ``secure`` sets MemTxAttrs.secure=1 (x86/ARM).
> + * ``space=...`` is ARM-specific and accepts:
> + * non-secure, secure, root, realm.
> + * ``space=non-secure`` is equivalent to omitting ATTRS.

If the test specifically asks for the non-secure space, this is
not the same as "doesn't specify attributes".

> + *
>   * IRQ management:
>   * """""""""""""""
>   *
> @@ -353,6 +387,135 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
>      *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
>  }
>
> +static bool qtest_parse_mem_attrs(CharFrontend *chr, const char *arg,
> +                                  MemTxAttrs *attrs)
> +{
> +    if (!arg) {
> +        *attrs = MEMTXATTRS_UNSPECIFIED;
> +        return true;
> +    }
> +
> +    if (strcmp(arg, "secure") == 0) {
> +        *attrs = (MemTxAttrs){ .secure = 1 };
> +        return true;
> +    }
> +
> +    if (strncmp(arg, "space=", 6) == 0) {
> +        const char *space = arg + 6;
> +        ARMSecuritySpace sec_space;
> +
> +        if (!target_arm() && !target_aarch64()) {
> +            qtest_send(chr, "ERR space=<...> is ARM-specific\n");
> +            return false;
> +        }
> +
> +        if (strcmp(space, "non-secure") == 0) {
> +            *attrs = MEMTXATTRS_UNSPECIFIED;
> +            return true;

Here we should set sec_space = ARMSS_NonSecure and determine
the attributes the same way as for the other spaces.

> +        } else if (strcmp(space, "secure") == 0) {
> +            sec_space = ARMSS_Secure;
> +        } else if (strcmp(space, "root") == 0) {
> +            sec_space = ARMSS_Root;
> +        } else if (strcmp(space, "realm") == 0) {
> +            sec_space = ARMSS_Realm;
> +        } else {
> +            qtest_send(chr, "ERR invalid space value. Valid space: "
> +                            "secure/non-secure/root/realm\n");
> +            return false;
> +        }
> +
> +        *attrs = (MemTxAttrs){
> +            .space = sec_space,
> +            .secure = arm_space_is_secure(sec_space),
> +        };
> +        return true;
> +    }
> +
> +    qtest_send(chr, "ERR invalid attrs argument\n");
> +    return false;
> +}

Other than that the system/qtest.c changes look good to me.

> diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
> index 851724cbcb..38d05ee61e 100644
> --- a/tests/qtest/libqtest-single.h
> +++ b/tests/qtest/libqtest-single.h
> @@ -291,6 +291,67 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
>      qtest_memwrite(global_qtest, addr, data, size);
>  }
>
> +/*
> + * Memory commands with optional attrs argument.
> + */
> +static inline void writeb_attrs(uint64_t addr, uint8_t value, const char *attrs)
> +{
> +    qtest_writeb_attrs(global_qtest, addr, value, attrs);
> +}
> +
> +static inline void writew_attrs(uint64_t addr, uint16_t value, const char *attrs)
> +{
> +    qtest_writew_attrs(global_qtest, addr, value, attrs);
> +}

All the other functions in this file have their own individual
documentation comments describing them. Your new ones should too.

I wonder if we should have these functions take the attrs
as a MemTxAttrs rather than a string? Not sure.

> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 051faf31e1..a548331f7c 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1447,6 +1447,154 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
>      qtest_rsp(s);
>  }
>
> +static bool qtest_has_attrs(const char *attrs)
> +{
> +    return attrs && attrs[0];
> +}
> +
> +static void qtest_write_attrs(QTestState *s, const char *cmd,
> +                              uint64_t addr, uint64_t value,
> +                              const char *attrs)
> +{
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %s\n",
> +                    cmd, addr, value, attrs);
> +    } else {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
> +    }
> +    qtest_rsp(s);
> +}
> +
> +static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
> +                                 uint64_t addr, const char *attrs)
> +{
> +    gchar **args;
> +    int ret;
> +    uint64_t value;
> +
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "%s 0x%" PRIx64 " %s\n", cmd, addr, attrs);
> +    } else {
> +        qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
> +    }
> +    args = qtest_rsp_args(s, 2);
> +    ret = qemu_strtou64(args[1], NULL, 0, &value);
> +    g_assert(!ret);
> +    g_strfreev(args);
> +
> +    return value;
> +}
> +
> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
> +                        const char *attrs)
> +{
> +    qtest_write_attrs(s, "writeb", addr, value, attrs);
> +}

You should also make the existing qtest_write(), qtest_writeb(), etc
go through the new code path, by:
  qtest_writeb() calls qtest_writeb_attrs(s, addr, value, NULL)
  similarly qtest_writew etc etc
  qtest_write() can be deleted as it will have no callers

> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data,
> +                         size_t size, const char *attrs)
> +{
> +    uint8_t *ptr = data;
> +    gchar **args;
> +    size_t i;
> +
> +    if (!size) {
> +        return;
> +    }
> +
> +    if (qtest_has_attrs(attrs)) {
> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
> +    } else {
> +        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
> +    }
> +    args = qtest_rsp_args(s, 2);
> +
> +    for (i = 0; i < size; i++) {
> +        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
> +        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
> +    }
> +
> +    g_strfreev(args);
> +}

Similarly, the qtest_memread(), qtest_memwrite(), qtest_memset()
functions should all become wrappers that pass NULL to the
_attrs version of the functions.

> +/*
> + * Memory commands with optional attrs argument.
> + */
> +
> +void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
> +                        const char *attrs);
> +void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
> +                        const char *attrs);
> +void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
> +                        const char *attrs);
> +void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
> +                        const char *attrs);
> +
> +uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
> +
> +void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
> +                         const char *attrs);
> +void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
> +                          size_t size, const char *attrs);
> +void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
> +                        const char *attrs);

Here also you should give each function its own doc comment,
to match the way the existing functions in this header do it.

> +
>  /**
>   * qtest_clock_step_next:
>   * @s: #QTestState instance to operate on.
> --
> 2.34.1

thanks
-- PMM

