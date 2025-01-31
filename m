Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC7DC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 01:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdfuE-0007lP-S3; Thu, 30 Jan 2025 20:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdfuC-0007ks-QO; Thu, 30 Jan 2025 20:33:12 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdfuA-0005ck-M9; Thu, 30 Jan 2025 20:33:12 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86112ab1ad4so415903241.1; 
 Thu, 30 Jan 2025 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738287189; x=1738891989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv/KvuhRvbySap8GuLV5BDwbdH7TRKlmTCEiZsrf8Q4=;
 b=NBP9/O5XUPQOC5/mk8prEcwykG+jPG1OSEx0nsHLSM+ySSWP/GayEp6MqtL5mdypX8
 sTN2UjP5epNsqeovbdPZ3REPK00Qsq4CpCl2q+1G6c4ST0T79VH6KcMglNo6zEAVosYQ
 RZ5fXBWgLNFtcO5tKqnau68BDVDvIG6OBg0/bbSOx+ND0v1yx1KYZmLK7hNoQdruqEN7
 p1wYd+rP3zae8Z60UPqRGFW+XT7eJsbLDI1lSoUIom9EvxJx38Je81RfuYiQ1K3Mk6Hp
 nr2IpLkYebsFlh1PvTewMNMBaGt+hka+fA5Z8yLxVXzyjA3d4LrdD+mu8upiEpzg/ZsN
 Icgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738287189; x=1738891989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nv/KvuhRvbySap8GuLV5BDwbdH7TRKlmTCEiZsrf8Q4=;
 b=v1LdkaGb+WofUVKNbjpc4TZie6ljNuRGK6b93WcAPoY6TMR8QI+SsfpZNd/T1dwpcV
 16hdAUY5QuLVXGmRUvkZSJa7hl8UOTTSjt/sOOPfCgKVZJDye05LsZZjqCvBTY4jQ8eP
 ivOiEBasfe94gzmrwdp3o6P2nKu2+t8NZfoiKRAc8B66SWWD8jLl5puOJD8MFgioYWGi
 n29LXZ9zeWIaYH3ixq8e7Geb+6fsFbwIxAB3EMrzWyMfyVST+anF99YvB2Erj0rrcBgD
 8E1wy7+k9sQ43icVMxKpD4SUfrl+663OQanRBfrpNIvmAVzvvjQ6ya8PIwvO82OAYqAS
 2lLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfDXXn3HekPHcRQX+ZIFflVco4RenEBuBNILZpqbk47p8mVNoUGX071c14ZvqDhDP21Y5D8hFzR6Ri9g==@nongnu.org,
 AJvYcCXppD8V2dcB1ryTMA6DPwSYRE8ZsF6VLaGXBDzxCJ5aB1VzIkl5XUgkBxm3zzq2B+mOmJOQy3gN9bfI@nongnu.org
X-Gm-Message-State: AOJu0YyMfYRTanAcEuP+iWkuLtteJcEwO1bXyJXyq1la14E5HepAFsPH
 u3jorwVgUaC8G4soxAiuzyzBPV3tQnfjYbMrCfA/yZ2T9G4ZFUb3np2AXt8zrS5DzUqNWpb8L02
 +n5j/VNhD0KYyqBanKmWrZVvmrBs=
X-Gm-Gg: ASbGncsHeZHMi/jKbKcO6A2Q4VCXENbcu+aasdkUb1N0jic4DTdkmPwYCWCPH5bjIf6
 tBO5X7xZ8UdH9AwrDp/XDw+xY0laijAd68GViuIS9ExHasQIEmbCmHZ70D/pZt8VYwhxL70H7yQ
 F7081kYEjgS/6jQqIycpIo7/hvbcs=
X-Google-Smtp-Source: AGHT+IEbNkHI8CQVo0YzIOv2BXHD60vj558Ow6k2rK2Ubq59GqKUYSyqDTrqFfbW6UqMy2FLpoSZC77p8yyDSzuw8XE=
X-Received: by 2002:a05:6102:148e:b0:4af:f3bd:51cd with SMTP id
 ada2fe7eead31-4b9a51ecee6mr8776968137.16.1738287189184; Thu, 30 Jan 2025
 17:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20250114212150.228241-1-r@drigo.nl>
In-Reply-To: <20250114212150.228241-1-r@drigo.nl>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 11:32:43 +1000
X-Gm-Features: AWEUYZm4-A3cnlq7KLdX4ARcbNix3NwEWlO_3nAzhDoKSrBrO2yQlIkW-B03ZFI
Message-ID: <CAKmqyKOZwd_SqKu9fUfhLtWCUoDZ3=XzkS8VTk3xAcvf_is5_Q@mail.gmail.com>
Subject: Re: [PATCH] goldfish_rtc: Fix tick_offset migration
To: Rodrigo Dias Correa <r@drigo.nl>
Cc: anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

