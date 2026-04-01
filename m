Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8807E10F9305
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 03:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7miT-0004ND-Jp; Tue, 31 Mar 2026 23:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7miS-0004Mx-KT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 23:58:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7miR-0008CF-0U
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 23:58:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso107802066b.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 20:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775015881; cv=none;
 d=google.com; s=arc-20240605;
 b=fqShweCFKu3TEHpMObv0R5P2wz/rLtmbgpvlStjQsIoCDnaTyGpDUarHGwGfjIzNZV
 90gAIjxkMpinieHItIFq8btwztnQBcZoPRkReZ2bQ0nP5ossVlpyO1dAFDKhtG4zlegr
 YxqGwLTCWFJkN2KibUt9eiGYUZNeKa+M+eK/s52MZghlHGaQwx/Hagv3/rdFN5z+s5Mz
 G8V1HvgGPI8QEAohHes6uh77eyYquLVgwmumFmn1ItuqSGcRWQmwXThTKphSffaGlQ0p
 FmaK38neS/uSmXDikzRwAAb+ZqtLIYzCtywae63/GH8l84GBl38FcJGHbI+j7rSdBNkg
 CoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pWXjJKAbqherizOhm6WmmwyCBBNrgO7mTWzzWcWcIeg=;
 fh=l/9BzocXy/fsMd/Y9LZNIRifsmiTjZILfq38rkziok8=;
 b=TMn/PvruIM4b9MePYR2ZgowRhzew0OmE2dB38gEve+tUS5AMXO0LpiI9MVQBWv+o/G
 iPEU8Xx4UH/1Ufemrfceyu3dqg40UbXC023h64d4AQJ8qXfru3C/ukOUOI9WNT0cYmFB
 yb1X89faukgA61AYeEmDVuh2QXP630E6g9Mfta7LVnMnpEFQYgE73ieX8oT+uh3q29n9
 drZR/CZBLsR++uNnvz+RJWSKy0+bOYzcdHvxNmTFZhaW0fvd+GX64p5dhJ9lkKAERUIG
 yZHwrmgOPrlJkZGPnSTvVYMiSly3cDoo3/FSaR42s47MIiReWo3Aq8dW0mV863qlQJDP
 eJ9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775015881; x=1775620681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWXjJKAbqherizOhm6WmmwyCBBNrgO7mTWzzWcWcIeg=;
 b=Vtw8QU7DbnTF9OLHDuRqF0jM4wDO/AcTEviPz8d9WcxEGgJ7HBq6AQ+glTO5lAgST8
 7NSRGiGhm1mABmd+2PzBWTSX6HjbCmzN5ibeGuI64VFyrJ0s4VqFwtuq+Rn2TZaqPjzq
 yk5sl3ugMpCheL4ieBVla4M/hNwoo5chFEBHiRnS9rQBnVAraeBja/E3ghd19PsWs2dQ
 JFcmfQ3Oh11kSdHLIWlj/jMP/hWhWxDQDsuBWp+2Cb2PWFi3SmdDzgqgdz8qGFkO1BLc
 OMZno2563bUs0+I88V+zmBSqQKVcUh/+1r3q4q73i1MafnVbqPbNcT+vwkT38pzf3vaR
 dGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775015881; x=1775620681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWXjJKAbqherizOhm6WmmwyCBBNrgO7mTWzzWcWcIeg=;
 b=lBSIihh0J31yN1KAm3GF5KYWBCFN3a9D0HkSf9d5eDWlhB85jhJ6ujTK8NPDDcCeId
 k6J7qezks24gtXEpmPd7hk+yKzFClkkC98xOF6LbfG6jgDtIygoJqtvaw95S8Ys8qf+K
 d3DKSaIPjqILE1xaoaCAwFIiraV3PPfuyEO0F0TV9UhqFv4dcYcpreS3MBvD4if2s9a9
 rQPm94zEg7FeAg8pGjkcBUq4B0DAsOKAt3cl9Vk46VWZtY9gz4JlE4bfbToj9j7QUNsB
 3ulukRv86FbywaVdPkbFYXqWtFsFbKgeQYwYX9isy5sIq65VbGGedurtTUZMb7LyXVSI
 rFOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHqjDzKFV7LGzxnsnOj3HZ7jd4M1h+gmQ5dimd8/web6QxsB0kB1F/P4reJz4lyu/oUhBN80JtX++q@nongnu.org
X-Gm-Message-State: AOJu0YxrxQjAXXiqkIoB3ODUTzfrAyWbtVcB8nE5KGlrzrNBzCD55NT2
 VVJwMgycx5BI6E1hLXJQQwha5RdJrPJTcq7cYEk3IUqbgegDDQQNbToDDJQxucOK/VGVzv2R2Wu
 a5/fByG/wpqfjvPnr7276gH70YHf1778=
X-Gm-Gg: ATEYQzwLs9cfCPq9cv7C23khCkdof7PIk0eqFFfolOxEC5+vf5n8MWOUa9YpAIaGtuH
 0b3989RT3KiOTqPJXT6uN9xuqr6a5WZdHITPRZbZJF7r2Vamz/olPoJ+ymu8Q3ZDpWp76wvDk0h
 2x9G5EEa2+/SW/sMXDR6f5U4FWOhQlqHLV5+HfqXdlPnNWWqJmcTDihPs+gyiaU/q0yrx97U5yN
 qJoYpmAM/wsbm4cuDNmGNpkQ7Ct+54u8d7h44E6sFwh8JXOMmmOFwJuX6V1dCJYKujqQf8vYb47
 tki08JstF38tsYLfneRN37I3m8Fo4JBiAlehlA==
X-Received: by 2002:a17:907:1c23:b0:b9b:1ea2:e694 with SMTP id
 a640c23a62f3a-b9be8902586mr324569566b.31.1775015880270; Tue, 31 Mar 2026
 20:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260326144835.67911-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260326144835.67911-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 13:57:33 +1000
X-Gm-Features: AQROBzBST9tHcnO5O8MbcOp4-XMY_mDW4SC8nxRGuTu0orHxdpLOz572C1k6f2w
Message-ID: <CAKmqyKO671kh+-Wp8Z1iBq0Hq+L4OXSNsNA0PHb_h16GQp7vgg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/acpi: correct field sequence in SPCR table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Ani Sinha <anisinha@redhat.com>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, Mar 27, 2026 at 12:49=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On LoongArch and RISC-V invalid SPCR tables are created:
>
> Terrminal Type : 00
> Language : 03
>
> The correct values are:
>
> Terrminal Type : 03
> Language : 00
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
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2:
>         Mention the different specification versions used by our code.
> v1:
>         https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 4b37405088..a999320e61 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *l=
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
>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> --
> 2.53.0
>
>

