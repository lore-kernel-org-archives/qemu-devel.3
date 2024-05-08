Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F01C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jfM-0000w4-Uh; Wed, 08 May 2024 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4jfH-0000vU-U6
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4jfB-0007If-Vm
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715183820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=keVpmsvArJ3iV/LvUq0G/CvBUjEYxnhcdK9Zx/oJu3Q=;
 b=F2H35X5m9QqaZb/t/yzlILr4C5n/LqyUYAvDi0Vjfn3wuTmMqdqS/mRc5RdWVdzEFwngcM
 kqEiKou+6hi958Kq1/gRojlcowgPOFKUKplxr+tHEL2Vit/JeODS5/juTQWQfrTsD/E7YD
 fi8Mm7/JrV0XCvpNr/kGDaRVk/MFM24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-coZg0nHEOcaFWRK9qh7xyg-1; Wed, 08 May 2024 11:56:59 -0400
X-MC-Unique: coZg0nHEOcaFWRK9qh7xyg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34c99c419e7so2864239f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715183798; x=1715788598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keVpmsvArJ3iV/LvUq0G/CvBUjEYxnhcdK9Zx/oJu3Q=;
 b=o3bgsZWya5vPDZPp9mroxhbumwYfchfV3AtpNPIvTS7ToYjlGFs3+Lh29pFVYBWynf
 LWC+/lF3fGlz6uhNNFBKQFtpNVV3/c2dZBRr+b7luLrdJ081Eh3DSdvSfkGflTXa9afL
 83DDnm0noB926j2P/WWLq22v5QnRdmbOqrdo60C0nlnbmlFf7H8zrHVNPIlooLpGJJbr
 m8Ls8gXEz8LBXV4/6t+SDmmzOeJjE+hdG2jsarUmbuWruRdMSl7HF4KRX0sJcwPqUZZX
 02kaTFSq76yJUZKzfbjgPHNqJ4InEg2/jvefb82ayeYEHjOqurdEpH8EcUo4UqV6bZ9D
 jZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0pjy6sVVzPeazd2s7z/fyL153QcKA6DbwOdQsCE7XQHJ+d5hUSKa6B94FRnZBOdRYGdXGvUysrdOJP4Q+681/cywqGH8=
X-Gm-Message-State: AOJu0YynnaITK2HAZXuajb8LgerqIp8FT9RL9DHXwHlrhv4Ubu2Zur3h
 IgHrCjQadDxvHUUhITuwbptwBNhhn/i2o6FgKoJpLk/jOvUW5k699pgiHzFiocIf+PqQaAr4dYo
 KOd70RRRHT8i9ihmWs5VoLEmyovASIzCo1HlbKZPOgnopKakE5rxKPHyOQrjxeKuEHd/PjBVW1g
 vvNvlT4vODivubhdv+9/0YD/cTfQE=
X-Received: by 2002:a5d:4ac4:0:b0:34d:93a0:96b with SMTP id
 ffacd0b85a97d-34fca80d28emr2530837f8f.62.1715183798588; 
 Wed, 08 May 2024 08:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX2gTV6CBoUmBgBt7BW7na+JAmr1OWIVQhQfOj4i+Bfeg70IvB5MJjhC/3vorhvczEdUXIMC0KimqgM7Ja7/U=
X-Received: by 2002:a5d:4ac4:0:b0:34d:93a0:96b with SMTP id
 ffacd0b85a97d-34fca80d28emr2530823f8f.62.1715183798226; Wed, 08 May 2024
 08:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-7-shentey@gmail.com>
 <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
In-Reply-To: <65316058-d2e1-4250-91e6-4da22c1279ed@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 May 2024 17:56:23 +0200
Message-ID: <CABgObfb+cLcZzxTW2one0+Vtb=E7GkPtPeBx6Jmtxg1sZzfaXQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] hw/i386/pc_sysfw: Alias rather than copy isa-bios
 region
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 30, 2024 at 5:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> I'm still not convinced we need a migration back compat for this...

It's absolutely needed,

    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                           &error_fatal);

will register a RAM region for migration, and when the destination
receives data from an older source, it will not find it it will fail.
On the other hand, if migrating backwards isa-bios will not be
populated and the guest may fail after reboot.

Paolo

> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index 82d37cb376..ac88ad4eb9 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -135,6 +135,7 @@ static void pc_system_flash_map(PCMachineState *pcm=
s,
> >                                   MemoryRegion *rom_memory)
> >   {
> >       X86MachineState *x86ms =3D X86_MACHINE(pcms);
> > +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> >       hwaddr total_size =3D 0;
> >       int i;
> >       BlockBackend *blk;
> > @@ -184,7 +185,12 @@ static void pc_system_flash_map(PCMachineState *pc=
ms,
> >
> >           if (i =3D=3D 0) {
> >               flash_mem =3D pflash_cfi01_get_memory(system_flash);
> > -            pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem);
> > +            if (pcmc->isa_bios_alias) {
> > +                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_=
mem,
> > +                                  true);
> > +            } else {
> > +                pc_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_m=
em);
> > +            }
> >
> >               /* Encrypt the pflash boot ROM */
> >               if (sev_enabled()) {
>


