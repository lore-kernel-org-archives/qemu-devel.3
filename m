Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F3CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSAtd-0004FC-Rn; Wed, 27 May 2026 05:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wSAtW-00040J-PQ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wSAtS-00036D-66
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779875379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3flipIOJcYS/WTn8tC8uOZMFqYtfQ8v1mziQO9fQLVA=;
 b=UOdIfEg8l64ivAvv17WbpGWjPf/4OjUSG5Kh5Q/zzy1cjho9eunZ0sF+FZHvrXn48kqFE/
 Jv9PK3pbGrFVw5YIMtoBsyAsl9XkF4ZT59445OBjzd0TI47jZz+QvQK0KsOO1eHuPPHK9/
 GgnzGyNtZFOLJabYyeVUolx8fjyq5Pc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-4cmk8-9IMD61e0A1l4NX4A-1; Wed, 27 May 2026 05:49:37 -0400
X-MC-Unique: 4cmk8-9IMD61e0A1l4NX4A-1
X-Mimecast-MFC-AGG-ID: 4cmk8-9IMD61e0A1l4NX4A_1779875377
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e60737a964so4916707a34.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 02:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779875377; cv=none;
 d=google.com; s=arc-20240605;
 b=AulgEM3TOBp23CzE3sdMoioCGVxOYII+enMo1tlLV2vVOjUGBwCameCiGdp6WIdUu3
 HirMflAsXvMR2zhzqK9Mx4+1V8462XTgolasrWbOS4wXI6NcD8qVHN8Q8604XpfKolLO
 8bbjgRC/np5iklaTEvgom20CD2lrD+rRC+1W6ZClZzOaBA8Jf6twz3IB/pPXYLbCxGoU
 3TZBD54tScLBEb8fxrRPdM48Dsx5PBIsDMliGGv9wAOamFZ/KrKE9wTsvxPXuWVOQIBI
 ZR7pc5qSTMnLGr5wPmt/T8FjyfhaCjXIyPkC86gGHjVxsQJVnCTRpLZQ3qybwJ/a9UW+
 1nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3flipIOJcYS/WTn8tC8uOZMFqYtfQ8v1mziQO9fQLVA=;
 fh=Sg4yoVLXQ2+r81l25AY5ejjboC7QHX8oYMc6MHQCkiY=;
 b=VuBZxvP4NrpopxZYgUEVdjKI1x9+brGUlq/Rat24USk5Dx3g4aGJFDrOf7cniayUX/
 i766SxHjdeB4s4hI5nNz6cJizaNkPkSejbvm4vMfkMu3QDoC8FtKKyHIuSs04UyI7od0
 YH+hktWx/nVsNBkNz7upZTRAa7puMo0cK2vbpUTJ33rVWs/PnTE5XPCNqfFqMZ8ucW4f
 hs/JdMx8PrfIH7c7SGhTBFRatbokscVV71eS8S4HaPI0iDbRaD4KaRQTeJa0ZMt74NPq
 z2PUnRywhy1Uu3lHdUwYiLzd9KrTNGzg7BHDVzMsTrghJEKoB1nqYAL/5UzkPeKeKq+l
 dsRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779875377; x=1780480177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3flipIOJcYS/WTn8tC8uOZMFqYtfQ8v1mziQO9fQLVA=;
 b=NX8IuMnc0j62MC2Wa/DXEP04WAclMZveumKXQv/CmrvEueT0uxFvO/E/uWk/3DgvZC
 UtGl9me56++0XSVtE9p9GbOxPv9NTfGlxunMc67Ti5emsng34hmN8m+HfWgI/RoZbF53
 I3y6/+cfJjnh6FSJ9poiJrShfd0zRdtnhk8nLPR1cLpzluxVjAh17myDQagxgQDsqlSU
 kQxgPrLvnia7JMWP1UWRBRJTa96O3H9MeOL8Bmd2fG1hJUEAnxO9Kij9ZEckGq5DInTK
 C1fmi6pC7h7zSAcmJvR/LPu6bHadbs8lenWY1Te/fwxEmndq1pSKl4RA51T5Jpt2YryZ
 Kjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875377; x=1780480177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3flipIOJcYS/WTn8tC8uOZMFqYtfQ8v1mziQO9fQLVA=;
 b=ILmz+Mi6PicSC1fAONOli95S5cmYz5mXWEvJ9yV2M1wfjB+1wDoArJ1pm2BYM3eaLx
 qZSIFaCAWewlJNMhih0y25t9rvT8blWwbO4/+LW7q7vQU5PB7Lnbx5HzpiZDxN/ZTd2c
 ebsMFeDG3uaRALEhOVOsOJN2dPGzNp0JN2hrNtqAZM4Big/0Yff61HBckqS2sE0J0s/h
 uaDv4UVcuxr4HuDFC5y0KJv99aMpw43sqMVQim72ycd973CAApmCwnS0s6cw+BMzHSec
 o9BEQgMRBKkdWd/XQs8PJYQdd79mPwvaq2uoC07NSLy50VdTpe/GzpGSgxVGFB2Er5lQ
 6Ahw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99ihsXZTcNjIpm5QdrU0ebNxHcCIsaKIzTU6dPsVVArus5VSCjEwdF+pL7eHR/c/khEgej32MKak+f@nongnu.org
X-Gm-Message-State: AOJu0Yw/ImN/rKxXFOzz1PbNKYfhnj/LheE9UtjuIs9meckXnYyXDOyK
 uZZ2FzysogcgjYR7vrGZYAdeJChnbIcY4MUi7vPn14HROsPMK0uLwu+BZxp/39kPKAiTTIub1LG
 HFDtK8BaDW17zLx2Dy0/eDlWf5m1bllkZizL3N23+p+6RdLRT6SAxfUYTqy9nkvwGEgwlfSXimR
 p15+lmfGF/izFFIy4xGdKIFfwoVRprnD4=
X-Gm-Gg: Acq92OFKuNQ5YcWvOTrSJW6qsLuZTC969HI9O3lcOr4W4NB69yXDl70bInWopW9VlSc
 +8lcGbc5Htv6/WFwSofmjnqrrBJHa05ZjwSJWzpHD0XOLvRrz2ikGC/bFyGTwJTWuMZN8eU5O5x
 xLOPtEZQruxPHjhQS7nMpZDqo8eCiAytfXkHzu+xmZjyJHC9EuoC9B3WaSwTiUkaxMdvKKdCrpF
 XIJkkVDOVQfya8=
X-Received: by 2002:a05:6820:4c07:b0:69d:521d:a4eb with SMTP id
 006d021491bc7-69d7ead4fbbmr12235087eaf.5.1779875376841; 
 Wed, 27 May 2026 02:49:36 -0700 (PDT)
X-Received: by 2002:a05:6820:4c07:b0:69d:521d:a4eb with SMTP id
 006d021491bc7-69d7ead4fbbmr12235076eaf.5.1779875376356; Wed, 27 May 2026
 02:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260526164716.689664-1-mbawa@redhat.com>
 <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
 <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
 <aa810589-f2ab-43ac-a3a9-7717d06df92d@linaro.org>
 <ae5c24c8-fa04-4368-8baf-9d56762c64cd@linaro.org>
 <a50cad08-56d4-49db-ac14-2ad588617420@linaro.org>
In-Reply-To: <a50cad08-56d4-49db-ac14-2ad588617420@linaro.org>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Wed, 27 May 2026 15:19:20 +0530
X-Gm-Features: AVHnY4J0kGTJc6wPGxIvUYezMhWtZuMfrCtzoJkdo98J2unUT6jzN5Vlgw2aS8M
Message-ID: <CAJg9KkyFUeSxyx9kjVLVv3fHqL1zCF3kUVV-EcvArQ-z8FT-dw@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 1:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 26/5/26 22:16, Philippe Mathieu-Daud=C3=A9 wrote:
> > +Paolo/Peter
> >
> > On 26/5/26 21:45, Philippe Mathieu-Daud=C3=A9 wrote:
> >> +Richard/Pierrick
> >>
> >> On 26/5/26 20:07, Mohammadfaiz Bawa wrote:
> >>> On Tue, May 26, 2026 at 11:13=E2=80=AFPM Peter Maydell
> >>> <peter.maydell@linaro.org> wrote:
> >>>>
> >>>> On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com>
> >>>> wrote:
> >>>>>
> >>>>> memory_region_init_ram_device_ptr() requires the target page
> >>>>> size to be finalized, which has not happened during
> >>>>> instance_init. Calling it from tpm_tis_sysbus_initfn() causes
> >>>>> an assertion failure when the device is introspected without
> >>>>> being realized, for example:
> >>>>>
> >>>>>    $ qemu-system-aarch64 -device tpm-tis-device,help
> >>>>>    qemu-system-aarch64: ../system/physmem.c:2524:
> >>>>>    qemu_ram_alloc_internal:
> >>>>>    Assertion 'target_page.decided' failed.
> >>>>>    Aborted (core dumped)
> >
> > I can not reproduce this error, however en macOS this command triggers:
> >
> > (lldb) bt
> > * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D hit pro=
gram
> > assert
> >      frame #0: 0x000000019c642388 libsystem_kernel.dylib`__pthread_kill=
 + 8
> >      frame #1: 0x000000019c67b848 libsystem_pthread.dylib`pthread_kill =
+
> > 296
> >      frame #2: 0x000000019c584b50 libsystem_c.dylib`abort + 124
> >      frame #3: 0x000000019c583d84 libsystem_c.dylib`__assert_rtn + 284
> >    * frame #4: 0x0000000100a3870c qemu-system-
> > aarch64`qemu_mutex_lock_impl.cold.1 at qemu-thread-posix.c:107:5
> >      frame #5: 0x0000000100981e78 qemu-system-
> > aarch64`qemu_mutex_lock_impl(mutex=3D<unavailable>, file=3D<unavailable=
>,
> > line=3D<unavailable>) at qemu-thread-posix.c:107:5
> >      frame #6: 0x0000000100345d08 qemu-system-
> > aarch64`qemu_mutex_lock_ramlist at physmem.c:1454:5
> >      frame #7: 0x0000000100345ce4 qemu-system-
> > aarch64`ram_block_add(new_block=3D0x0000000133104f10,
> > errp=3D0x000000016fdfe650) at physmem.c:2161:5
> >      frame #8: 0x0000000100346c34 qemu-system-
> > aarch64`qemu_ram_alloc_internal(size=3D16384, max_size=3D16384,
> > resized=3D0x0000000000000000, host=3D0x000000013380c000, ram_flags=3D1,
> > mr=3D0x000000013380a910, errp=3D0x0000000101c37c20) at physmem.c:2540:5
> >      frame #9: 0x00000001003469c8 qemu-system-
> > aarch64`qemu_ram_alloc_from_ptr(size=3D<unavailable>, host=3D<unavailab=
le>,
> > mr=3D<unavailable>, errp=3D<unavailable>) at physmem.c:2552:12 [artific=
ial]
> >      frame #10: 0x000000010033b56c qemu-system-
> > aarch64`memory_region_set_ram_ptr(mr=3D0x000000013380a910, size=3D1024,
> > ptr=3D0x000000013380c000) at memory.c:1664:20 [inlined]
> >      frame #11: 0x000000010033b550 qemu-system-
> > aarch64`memory_region_init_ram_device_ptr(mr=3D0x000000013380a910,
> > owner=3D<unavailable>, name=3D<unavailable>, size=3D1024,
> > ptr=3D0x000000013380c000) at memory.c:1684:5
> >      frame #12: 0x00000001002ca594 qemu-system-
> > aarch64`tpm_tis_sysbus_initfn(obj=3D0x0000000133809400) at
> > tpm_tis_sysbus.c:114:5
> >      frame #13: 0x00000001007e8e58 qemu-system-
> > aarch64`object_initialize_with_type(obj=3D0x0000000133809400, size=3D56=
80,
> > type=3D0x0000000131f4e250) at object.c:504:5
> >      frame #14: 0x00000001007e964c qemu-system-
> > aarch64`object_new_with_type(type=3D0x0000000131f4e250) at object.c:707=
:5
> >      frame #15: 0x00000001007e95fc qemu-system-
> > aarch64`object_new_with_class(klass=3D<unavailable>) at object.c:716:12
> > [artificial]
> >      frame #16: 0x00000001008ca264 qemu-system-
> > aarch64`qmp_device_list_properties(typename=3D"tpm-tis-device",
> > errp=3D0x000000016fdfe8a0) at qom-qmp-cmds.c:206:11
> >      frame #17: 0x000000010034c7a0 qemu-system-
> > aarch64`qdev_device_help(opts=3D<unavailable>) at qdev-monitor.c:315:17
> >      frame #18: 0x000000010033179c qemu-system-
> > aarch64`device_help_func(opaque=3D<unavailable>, opts=3D<unavailable>,
> > errp=3D<unavailable>) at vl.c:1209:12 [artificial]
> >      frame #19: 0x000000010098aa10 qemu-system-
> > aarch64`qemu_opts_foreach(list=3D<unavailable>, func=3D(qemu-system-
> > aarch64`device_help_func at vl.c:1208), opaque=3D0x0000000000000000,
> > errp=3D0x0000000000000000) at qemu-option.c:1148:14
> >      frame #20: 0x000000010032d45c qemu-system-
> > aarch64`qemu_process_help_options at vl.c:2642:9 [inlined]
> >      frame #21: 0x000000010032d408 qemu-system-
> > aarch64`qemu_init(argc=3D<unavailable>, argv=3D0x000000016fdff148) at
> > vl.c:3738:5
> >      frame #22: 0x00000001008dcef8 qemu-system-
> > aarch64`main(argc=3D<unavailable>, argv=3D<unavailable>) at main.c:71:5
> >      frame #23: 0x000000019c2dab98 dyld`start + 6076
> >
Hi Philippe,

I looked into this, the target_page.decided assertion only
shows up with CONFIG_DEBUG_TCG enabled, which is I guess how I hit it.

I rebuilt with --disable-debug-tcg and got the same crash as
your macOS backtrace, mutex assert in ram_block_add().

> >>>>>
> >>>>> Property introspection only calls instance_init, never
> >>>>> realizefn, so moving the memory region setup to realizefn
> >>>>> avoids the crash while keeping the device fully functional
> >>>>> when actually used in a VM.
> >>>>>
> >>>>> Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
> >>>>> and the corresponding sysbus_init_mmio() from
> >>>>> tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
> >>>>> them just before the existing vmstate_register_ram() call.
> >>>>>
> >>>>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> >>>>> ---
> >>>>>   hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
> >>>>>   1 file changed, 6 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> >>>>> index 6bec30c36f..33fe9e332c 100644
> >>>>> --- a/hw/tpm/tpm_tis_sysbus.c
> >>>>> +++ b/hw/tpm/tpm_tis_sysbus.c
> >>>>> @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
> >>>>>   {
> >>>>>       TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
> >>>>>       TPMState *s =3D &sbdev->state;
> >>>>> -    size_t host_page_size =3D qemu_real_host_page_size();
> >>>>
> >>>> This is asking about the host page size, so why does it wind up
> >>>> asserting about the target page size not being fixed ?
> >>>>
> >>>> thanks
> >>>> -- PMM
> >>>
> >>> The host_page_size line itself doesn't cause the crash -
> >>> qemu_real_host_page_size() is safe to call anywhere. It was
> >>> moved simply because it has no other consumers in initfn.
> >>>
> >>> The actual crash comes from memory_region_init_ram_device_ptr()
> >>> - which calls qemu_ram_alloc_internal(). In there, line 2522
> >>> evaluates TARGET_PAGE_SIZE: align =3D MAX(align, TARGET_PAGE_SIZE);
> >>>
> >>> With CONFIG_DEBUG_TCG, TARGET_PAGE_SIZE expands through
> >>> TARGET_PAGE_MASK which contains: assert(target_page.decided)
> >>>
> >>> That's where it blows up: the target page size hasn't been
> >>> finalized yet during instance_init.
>
> When a realize() can fail, deferring resources allocation to it
> (after checking any failure) is indeed preferred pattern (but it
> should come with these resources being released in a unrealize
> handler, which this file lacks -- pre-existing).
>
> With that in mind I'd also move tpm-tis-mmio allocation:

Makes sense, will do in v2.

> -- >8 --
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 6bec30c36fc..aae9ffd8392 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -102,7 +102,2 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>       TPMState *s =3D &sbdev->state;
> -    size_t host_page_size =3D qemu_real_host_page_size();
> -
> -    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
> -                          s, "tpm-tis-mmio",
> -                          TPM_TIS_NUM_LOCALITIES <<
> TPM_TIS_LOCALITY_SHIFT);
>
> @@ -111,6 +106,2 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>
> -    s->ppi.buf =3D qemu_memalign(host_page_size,
> -                                ROUND_UP(TPM_PPI_ADDR_SIZE,
> host_page_size));
> -    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
> -                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
> @@ -122,2 +113,3 @@ static void tpm_tis_sysbus_realizefn(DeviceState
> *dev, Error **errp)
>       TPMState *s =3D &sbdev->state;
> +    const size_t host_page_size =3D qemu_real_host_page_size();
>
> @@ -133,2 +125,10 @@ static void tpm_tis_sysbus_realizefn(DeviceState
> *dev, Error **errp)
>
> +    s->ppi.buf =3D qemu_memalign(host_page_size,
> +                               ROUND_UP(TPM_PPI_ADDR_SIZE,
> host_page_size));
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
> +                          s, "tpm-tis-mmio",
> +                          TPM_TIS_NUM_LOCALITIES <<
> TPM_TIS_LOCALITY_SHIFT);
> +
> +    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi=
",
> +                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
>       vmstate_register_ram(&s->ppi.ram, dev);
> ---
>
> At any rate the commit description has to be reworded.
>
Will update thank you for the review.

Thanks
--Faiz


