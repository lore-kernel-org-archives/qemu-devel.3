Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74866C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdfIo-0002w7-UX; Thu, 30 Jan 2025 19:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdfIm-0002vZ-N1; Thu, 30 Jan 2025 19:54:32 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdfIk-0003DQ-UA; Thu, 30 Jan 2025 19:54:32 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4affd0fb6adso502602137.1; 
 Thu, 30 Jan 2025 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738284869; x=1738889669; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KC5lXx2wNXi1mEWXm5ftAIzdWDc4jpA+IJ3/ggnMngY=;
 b=I92jMZR7zDxrA5wmf2FZ+k1xHGrkApdRWFVAJKfLtCbBPgc0VA+XtXPcBFnJWOt5jQ
 jainjQSsPCKXi2hCuaxDmMvp7d7H1xQuv1qDMtDkg8Tw4gOg3q8r7t45sxl3Mtb4mQTz
 ZJAssWPID+hHwrAfVn+9OAqNhlKca19AbtBkkRczHuxI75kDX4vUQ14x5p6nK9znQXSs
 eEQgiSQo/vzX9EJK72fJKFvN8kG/QDwfIwcWNcRBFByDRoOCMcRzVRRi0c8gjV+3Pltq
 hFlhuR0RlFGIghys/IrL0lSiu2TptAFzY5I7jWC9uOxzGW2bIjU7YtJy2Ju4dRoxcBoh
 iL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738284869; x=1738889669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KC5lXx2wNXi1mEWXm5ftAIzdWDc4jpA+IJ3/ggnMngY=;
 b=ZS+0zk0HqaJi7x9AaqPeBM9FAoT8Dnyb8XaHhSa+wbCosjGrI5YMGkyWc4+LPW7yW+
 yJBuuQhGWZG4kkQhEdXohd17HGBU2Vapu3vYebOqobMe67ZepJGLvj/8E5upIF2WVlRL
 oP1T0nyGXaFnXSQgvWjDct0m4G3dvnr0203yA9TWcjYmWNKuGRdzp1U4itW25z8k/7im
 onDWfTZ4Can8UZ7VQ21jORtF3tdP3HF0jZuZjZhiF82r8urLKjHTkBUOXlZ4jstIWg/5
 vsNAfVouKK/w+742WSPNIsLW8xx5jaM3wZI7UuZL8puAkq9eScxC3/OTkQFqRsuwBhCl
 R6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzI9h+2aE7ot/r67BGVEyJCt4JeCDznWAtcx9iQacTxLR68TfggZppUGwyhiK8RmPTo8Kry/60s+ftTg==@nongnu.org,
 AJvYcCXP/w4JirM4HgP4SwmUsIKxaBvp7RpmBarZYWFscIEWyliSIOwqmp6gKi1L1+m4etqqE2Srqk5f8YVn@nongnu.org
X-Gm-Message-State: AOJu0YwPk2XZufQnYQ/Oj1wjzCQEIIItLdeWlWNsDKcv/sMz0YTY9S4v
 Nli/+BmNaEdznnRTzNUJOtO2m3VhMlRkbOVpsr16Dx74AwZzM3mXgo0d/il0CjOZqPGsAM5zB/N
 zkq71BCQuBbyJzyioJxaLvzXWCnw=
X-Gm-Gg: ASbGnctEfocJ1jUG8zod4WmP+aoR6o3vpPWuD0uZgMTsdXMTwHxFCsFWhgx9UORvuw/
 9Mt4yK0vJ8w5HzzHiiZ03PafrdcN46Dwotuh6SxjB4hrzVO8scV+gSSuCrbICN8dUiPA4/KvKl+
 fNH2cUqJzz5QEFENoq1D8kQDivbIU=
X-Google-Smtp-Source: AGHT+IHFmXPHE4pkp9U3t6YEO9yaDu6LzU9xh6sR9sEFFg5ZHNiOBqNOVQ1Qc6zs1QF0M35WyBgXV/r4UnGXtZhgfkQ=
X-Received: by 2002:a05:6102:5e8b:b0:4af:e5fd:77fc with SMTP id
 ada2fe7eead31-4b9a4ebe487mr10043681137.3.1738284869594; Thu, 30 Jan 2025
 16:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20250114212150.228241-1-r@drigo.nl>
In-Reply-To: <20250114212150.228241-1-r@drigo.nl>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:54:03 +1000
X-Gm-Features: AWEUYZkgof_Qop6wgBUNCzIFJ7HgSxA6FzE7D2QbWZGG3fhhrayt4Pxt5_0qY_U
Message-ID: <CAKmqyKM+Nb=dRJ7+=3JK7+LXz0KTXEGLZqbKJGh1+wtgY5eJHw@mail.gmail.com>
Subject: Re: [PATCH] goldfish_rtc: Fix tick_offset migration
To: Rodrigo Dias Correa <r@drigo.nl>
Cc: anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Wed, Jan 15, 2025 at 7:23=E2=80=AFAM Rodrigo Dias Correa <r@drigo.nl> wr=
ote:
>
> Instead of migrating the raw tick_offset, goldfish_rtc migrates a
> recalculated value based on QEMU_CLOCK_VIRTUAL. As QEMU_CLOCK_VIRTUAL
> stands still across a save-and-restore cycle, the guest RTC becomes out
> of sync with the host RTC when the VM is restored.
>
> As described in the bug description, it looks like this calculation was
> copied from pl031 RTC, which had its tick_offset migration fixed by
> Commit 032cfe6a79c8 ("pl031: Correctly migrate state when using -rtc
> clock=3Dhost").
>
> Migrate the tick_offset directly, adding it as a version-dependent field
> to VMState. Keep the old behavior when migrating from previous versions.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2033
> Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  As a new field was added to VMState, after this patch, it won't be possi=
ble to
>  migrate to old versions. I'm not sure if this is needed. Please, let me =
know.
> ---
>  hw/rtc/goldfish_rtc.c | 43 +++++++++++++------------------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index fa1d9051f4..0f1b53e0e4 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -178,38 +178,21 @@ static void goldfish_rtc_write(void *opaque, hwaddr=
 offset,
>      trace_goldfish_rtc_write(offset, value);
>  }
>
> -static int goldfish_rtc_pre_save(void *opaque)
> -{
> -    uint64_t delta;
> -    GoldfishRTCState *s =3D opaque;
> -
> -    /*
> -     * We want to migrate this offset, which sounds straightforward.
> -     * Unfortunately, we cannot directly pass tick_offset because
> -     * rtc_clock on destination Host might not be same source Host.
> -     *
> -     * To tackle, this we pass tick_offset relative to vm_clock from
> -     * source Host and make it relative to rtc_clock at destination Host=
.
> -     */
> -    delta =3D qemu_clock_get_ns(rtc_clock) -
> -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    s->tick_offset_vmstate =3D s->tick_offset + delta;
> -
> -    return 0;
> -}
> -
>  static int goldfish_rtc_post_load(void *opaque, int version_id)
>  {
> -    uint64_t delta;
>      GoldfishRTCState *s =3D opaque;
>
> -    /*
> -     * We extract tick_offset from tick_offset_vmstate by doing
> -     * reverse math compared to pre_save() function.
> -     */
> -    delta =3D qemu_clock_get_ns(rtc_clock) -
> -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    s->tick_offset =3D s->tick_offset_vmstate - delta;
> +    if (version_id < 3) {
> +        /*
> +         * Previous versions didn't migrate tick_offset directly. Instea=
d, they
> +         * migrated tick_offset_vmstate, which is a recalculation based =
on
> +         * QEMU_CLOCK_VIRTUAL. We use tick_offset_vmstate when migrating=
 from
> +         * older versions.
> +         */
> +        uint64_t delta =3D qemu_clock_get_ns(rtc_clock) -
> +                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        s->tick_offset =3D s->tick_offset_vmstate - delta;
> +    }
>
>      goldfish_rtc_set_alarm(s);
>
> @@ -239,8 +222,7 @@ static const MemoryRegionOps goldfish_rtc_ops[2] =3D =
{
>
>  static const VMStateDescription goldfish_rtc_vmstate =3D {
>      .name =3D TYPE_GOLDFISH_RTC,
> -    .version_id =3D 2,
> -    .pre_save =3D goldfish_rtc_pre_save,
> +    .version_id =3D 3,
>      .post_load =3D goldfish_rtc_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
> @@ -249,6 +231,7 @@ static const VMStateDescription goldfish_rtc_vmstate =
=3D {
>          VMSTATE_UINT32(irq_pending, GoldfishRTCState),
>          VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
>          VMSTATE_UINT32(time_high, GoldfishRTCState),
> +        VMSTATE_UINT64_V(tick_offset, GoldfishRTCState, 3),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.34.1
>
>

