Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C15C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0L9-0002tR-7G; Sun, 28 Jun 2026 20:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0L7-0002tJ-SS
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:59:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0L5-0007Aj-UR
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:59:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso2604659a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694746; cv=none;
 d=google.com; s=arc-20260327;
 b=hHmIBj30fGynKw4pQVYLzjCHP15ZCfStkCQT8BHbu8Q5bjT6aFV5R6UW+AZyaV9xo5
 Jcu5D9yNpIe6cCLfkXYYFWDH2veJlASVGv1RVC6aAK3JJ0zVcI4bEOiUmAQ/td/RF8UM
 g8Yrgy00FwyHvPoG46xehSO3eED+R5Yahe2Elnkv0PgeP2Y8LJkF7lBApMIutuy2ssFl
 XFAD2nv2RL6DXh1woVc+Pb3kBrehUptwaVLOWDe5ejw/hbCrVmQSTGcHed3r1z+e5bEZ
 Grm0oUBr5QcWeW+lNYYPjlDGxQlEnhxgLlHR7xSDuCwfGFZfuptVqKBeNBkChNQb1L/s
 g4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hwVeEYNgVQgyFW2aUDWJIV2zBqhewtlX+aYJV9yPBnw=;
 fh=+u1hM+A0XLwC4z0mynhZbSV73ebLavvqyRisWwhIlOM=;
 b=qb9SKghhesSThh78er9GBj72hD1ebocMEpO10nSh/7bB+YremLXgu7TG7cxX4iZLwg
 djilhB151DNzupFr3mp2fba/t+mOtXtuaIMKzazuqxhCq/68rtQI+N4/FtXMuPTBt4Xo
 MbkZk886oUO+RyyKUTbj/ttysQrf/aI8RcJLNXml2WObgUnqca1c35AozKtjiaQ02x1p
 54Sx69Ut9Ng3HmpqVmmC7UhaDpjJ4lIZTpx2SqJrM/0kgfyrxDfa7PzNvpKzXVK8IY+Z
 5VYCpHJd6nw5DaQGvY9TU8K1J3TZw/Wm8w4OqlyQOcICfbQWgFaVh/HQnCDKVESLjV9V
 +uVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694746; x=1783299546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwVeEYNgVQgyFW2aUDWJIV2zBqhewtlX+aYJV9yPBnw=;
 b=I49cZD7oLIbvsuYbhITVsYx0bkHjuDA9JqxBofoyJpYW3XAjrAu5xUKbqXEHa6RPj2
 5nEfyed1xYECL3IjGDGYKBwRMAbgBFPP2AJ9yq44XQC1qv+/w5R3pImcJMcyluQ7kLdx
 iS7SPL+RH6J7FcYZhAhYh87oxf+7g6w9/MYvXCuElIDi6X2JzcN5x3iH2N2po5VHIl0O
 +aolIlHpc/i+0MATs7k6GJ+JNKvxeXyW5LeEJSAiscGY8vvRIu1TR7UsjtXzCqlEoHMd
 6W/WEWbM+NC7hSHoS+vi7XyHA+OCwd2QxIrTmqLFOUhpL25PjGur5YMDwo+2TV07ov8g
 ywUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694746; x=1783299546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwVeEYNgVQgyFW2aUDWJIV2zBqhewtlX+aYJV9yPBnw=;
 b=pNYthTpc9XxdXztobv34ydC+PZxPfgPAC+yx0AfT/KSf+/dXi9beWfCIooShJfVqpi
 VtiMARl5ICGzR66gejozQ8LgL091thzBGzBRF4xCWPgLFqKZPyHxZvnWIZU8JlgojiSB
 l03W+1MUAENw4n5/nrczYg/J3ryV7euV7OOUocG1jFtQIllSCY3h9cpZdXtpjuNoCZYO
 9OkNOo6c+6bGE+c736TkaA4OVNPMteWQQrC8e7RubwGZ9BQxO+mcbrAAr9sVnKigOEMp
 zYmbD3e2JQlpe9w/k1Y7nUm53q69B9xhZJEqtOsrNtxWuDLlzjipzi1v6raIAYcc1hR6
 YD8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoibFw09vHm+XgIeahc2oxDVqGyMY98KMcywH8F1VhzJ+0TsdsB/o6VosO1qZhuFd5G6Yy0rPm/lMjR@nongnu.org
X-Gm-Message-State: AOJu0YxqS1QmA2rFGJi8nCrqBNBLQPnenmKg2yQWdz4OiVjB8gBrQR6e
 tIYSD5+0/OcaAflCO8CtEKbkppfFV1Xc7WDJzj2zIjy8NC4ipHsaghHCSG+GVngN9hNxWHckySr
 aJHnH5EivrJQDC0+7lY+mT814p5yFio0=
X-Gm-Gg: AfdE7clOb46hvFKjHnIBzTmr9FH2wE5wFZFzjvNogXbQ9Fvjy0D9GoKrJNrcZp5kPUI
 Qb+PEjfrhdIpgu0H1Z2oL/IlEBiSciHpQ6mQlO5yKqcHBG2j4QTswq7v3zANqowup6y0GeC/07q
 x5/KXUl9Up75JVayjZqCo1edXAxzoIBP7DMbII7Y8wKWyZpRIOAo1JsDNo3jvcmsafJJnxVOp7c
 A5wSb8rF5nliDGGPD3Uj+pQsXB/q4hAUl4gf5uL54kLDyvLJeJIy713Z9Bngi1SZdUnbBgHoygF
 Blyjara3zrRUHkOVkB30Auexlic=
X-Received: by 2002:a05:6402:5207:b0:697:df4c:13f4 with SMTP id
 4fb4d7f45d1cf-69810a17dbfmr5387236a12.5.1782694745838; Sun, 28 Jun 2026
 17:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260622111843.34056-1-heinrich.schuchardt@canonical.com>
 <20260622111843.34056-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260622111843.34056-2-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:58:38 +1000
X-Gm-Features: AVVi8CdtaZyiZyVa-aBfT2EBHbSQ-d-8NKUihhwoaPwUlvdDzRuXWJ3zXqfhUEA
Message-ID: <CAKmqyKPeK-nCsemLAru6nkWP7V8qtA=XgW3ALuOJ5nFegF5F4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hw/acpi: correct field sequence in SPCR table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jun 22, 2026 at 9:18=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On LoongArch and RISC-V invalid SPCR tables are created:
>
>     Terminal Type : 00
>     Language : 03
>
> The correct values are:
>
>     Terminal Type : 03
>     Language : 00
>
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
>
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial=
-port-console-redirection-table
>
> This page shows version 1.10. But the sequence of the fields was not chan=
ged
> since version 1.0.
>
> Our LoongArch and ARM code uses version 1.07 of the specification.
> Our RISC-V code uses version 1.10 of the specification.
>
> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to =
common location")
> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         Reproduce the test data changes using rebuild-expected-aml.sh
>         creating the same diff as v3 but in two separate patches.
> v3:
>         Update test data
> v2:
>         Mention the different specification versions used by our code
>         https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinric=
h.schuchardt@canonical.com/
> v1:
>         https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 9b3cdd3781..990abc64cd 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *l=
inker,
>      build_append_int_noprefix(table_data, f->stop_bits, 1);
>      /* Flow Control */
>      build_append_int_noprefix(table_data, f->flow_control, 1);
> -    /* Language */
> -    build_append_int_noprefix(table_data, f->language, 1);
>      /* Terminal Type */
>      build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);

Won't this break tests? Don't you need to disable the test first (then
re-enable it and fix it in patch 3)

Alistair

>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> --
> 2.53.0
>

