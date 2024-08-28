Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071EFC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGVm-0004j4-P1; Wed, 28 Aug 2024 07:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sjGVl-0004eZ-GO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sjGVi-00013z-QZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724843204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5GCCcXPiaVUP0RLzBdI+IQvND7UeTVRkSpnaCwialk=;
 b=ftzaGnYKVzl/vDkrXeVH0SEFt4GfypMuSrF66qod+NPYuzlftYTCNeYwoq/8pAd6NsRxpE
 losQHIkxIWI5/a56oMqoNzFbsb4yOJHlnapP0zU8MlJBNrEmXAcYCuegSrjfVDf1oH0nnk
 tRus683TLM7d07BOa4aWpzWLmbBh4Ac=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-97OJP_f3M8uhnTUzZ-7NUw-1; Wed, 28 Aug 2024 07:06:43 -0400
X-MC-Unique: 97OJP_f3M8uhnTUzZ-7NUw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45677d056c3so2702101cf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 04:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724843202; x=1725448002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5GCCcXPiaVUP0RLzBdI+IQvND7UeTVRkSpnaCwialk=;
 b=lLB2YS2iRfynjS2cua5q6pjxmopyJ/mxA41qyPtBxAZeTq1vIeLcHGeaeDibchFbQh
 5IPxzALtvxqbHguZurDQbbdM9+3r4iJ5yCzqEISnff0NFRBmGH4ji+YmvrsdNEbVngQm
 2ZZ6V1AA/V2p89dLDR2dw/nVoMEamVDGtOqRJtF2NPTrTMI2du02M/fBYWxD+Srwx8QC
 ogvDsU9M1YRy11AMdyNmuWyv7ALMPyf0f78cFuKy/WNCZF2jpvwsi6NYr6tGYrjujR9s
 ds9Md3JrmkyPUn4m54XWAnr20PXyXyJ4hi36Gp2/xw++wl8BfSTyHmUHqQhuRPItMh9A
 BVMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuPb8wQIzmsJBQVvFwHMD3VaDUqDr+98KkwRjiOkRAc31FSXB1rOlvzKO6bM7OkFw+0Hdp7aeDauVV@nongnu.org
X-Gm-Message-State: AOJu0Yzptdw3RrjFULmpmuYggwCF5CczHCxhm1XIGAKktacjCq8vKqpS
 mPEe5LdOB/oLZSMKgldR5gwZfdrd8eJyoP1ErzjT/Kr1XC/qefQTlkZ8cHYG25hlOvXA9qktoVJ
 JYp+STFNdyWcGjAS4k6c9oiHtrgFrwPaSHo0i/8xO833Ixuva+sA2/S5fxDbMKeM7hJn/S/OqmP
 16Ki9OOrVFpfdJwN/TMnJPDxHzdfUSaBEE3VFItVyg
X-Received: by 2002:a05:622a:1dc5:b0:447:f4f6:7a1 with SMTP id
 d75a77b69052e-4566e6958cdmr17435331cf.52.1724843202459; 
 Wed, 28 Aug 2024 04:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpvuLONxvhpwl6XJlAdxXAZT8l3Q6N/17bZp8F98IMYSHObU2B/o15A6WQg3B48PVozjn3LjUfI71/2aqTdqM=
X-Received: by 2002:a05:622a:1dc5:b0:447:f4f6:7a1 with SMTP id
 d75a77b69052e-4566e6958cdmr17434991cf.52.1724843201867; Wed, 28 Aug 2024
 04:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
 <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
 <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
 <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
In-Reply-To: <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Wed, 28 Aug 2024 13:06:31 +0200
Message-ID: <CAC2qdxCJ3=OzAsnM-paMUmvGAMau2Mc_OxNjxpP3T-F=69Boaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On Tue, Aug 20, 2024 at 1:56=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 20 Aug 2024 at 12:40, David Hildenbrand <david@redhat.com> wrote:
> >
> > On 14.08.24 14:32, Juraj Marcin wrote:
> > > On Tue, Aug 13, 2024 at 6:37=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > >>
> > >> On Tue, 13 Aug 2024 at 16:39, Juraj Marcin <jmarcin@redhat.com> wrot=
e:
> > >>>
> > >>> Some devices need to distinguish cold start reset from waking up fr=
om a
> > >>> suspended state. This patch adds new value to the enum, and updates=
 the
> > >>> i386 wakeup method to use this new reset type.
> > >>>
> > >>> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > >>> Reviewed-by: David Hildenbrand <david@redhat.com>
> > >>> ---
> > >>>   docs/devel/reset.rst    | 8 ++++++++
> > >>>   hw/i386/pc.c            | 2 +-
> > >>>   include/hw/resettable.h | 2 ++
> > >>>   3 files changed, 11 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> > >>> index 9746a4e8a0..a7c9467313 100644
> > >>> --- a/docs/devel/reset.rst
> > >>> +++ b/docs/devel/reset.rst
> > >>> @@ -44,6 +44,14 @@ The Resettable interface handles reset types wit=
h an enum ``ResetType``:
> > >>>     value on each cold reset, such as RNG seed information, and whi=
ch they
> > >>>     must not reinitialize on a snapshot-load reset.
> > >>>
> > >>> +``RESET_TYPE_WAKEUP``
> > >>> +  This type is called for a reset when the system is being woken-u=
p from a
> > >>> +  suspended state using the ``qemu_system_wakeup()`` function. If =
the machine
> > >>> +  needs to reset its devices in its ``MachineClass::wakeup()`` met=
hod, this
> > >>> +  reset type should be used, so devices can differentiate system w=
ake-up from
> > >>> +  other reset types. For example, a virtio-mem device must not unp=
lug its
> > >>> +  memory during wake-up as that would clear the guest RAM.
> > >>> +
> > >>>   Devices which implement reset methods must treat any unknown ``Re=
setType``
> > >>>   as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount=
 of
> > >>>   existing code we need to change if we add more types in future.
> > >>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > >>> index ccb9731c91..49efd0a997 100644
> > >>> --- a/hw/i386/pc.c
> > >>> +++ b/hw/i386/pc.c
> > >>> @@ -1716,7 +1716,7 @@ static void pc_machine_reset(MachineState *ma=
chine, ResetType type)
> > >>>   static void pc_machine_wakeup(MachineState *machine)
> > >>>   {
> > >>>       cpu_synchronize_all_states();
> > >>> -    pc_machine_reset(machine, RESET_TYPE_COLD);
> > >>> +    pc_machine_reset(machine, RESET_TYPE_WAKEUP);
> > >>>       cpu_synchronize_all_post_reset();
> > >>>   }
> > >>
> > >> I'm happy (following discussion in the previous thread)
> > >> that 'wakeup' is the right reset event to be using here.
> > >> But looking at the existing code for qemu_system_wakeup()
> > >> something seems odd here. qemu_system_wakeup() calls
> > >> the MachineClass::wakeup method if it's set, and does
> > >> nothing if it's not. The PC implementation of that calls
> > >> pc_machine_reset(), which does a qemu_devices_reset(),
> > >> which does a complete three-phase reset of the system.
> > >> But if the machine doesn't implement wakeup then we
> > >> never reset the system at all.
> > >>
> > >> Shouldn't qemu_system_wakeup() do a qemu_devices_reset()
> > >> if there's no MachineClass::wakeup, in a similar way to
> > >> how qemu_system_reset() does a qemu_devices_reset()
> > >> if there's no MachineClass::reset method ? Having the
> > >> wakeup event be "sometimes this will do a RESET_TYPE_WAKEUP
> > >> but sometimes it won't" doesn't seem right to me...
> >
> > One thing one could consider would probably be to send a WARM reset to
> > all devices. The main issue here is that other devices will default to =
a
> > COLD device then, and that's precisely what the other machines that
> > implement suspend+resume do not want. And ...
> >
> > >
> > >  From my understanding that I have gathered from the code (but please=
,
> > > someone correct me if I am wrong), this is machine specific. Some
> > > machine types might not support suspend+wake-up at all. The support
> > > has to be explicitly advertised through qemu_register_wakeup_support(=
)
> > > (for example, aarch64 with a generic virt machine type does not
> > > advertise support). Even if the machine type advertises
> > > suspend+wake-up support, it might not need to do anything machine
> > > specific. This is the case of pSeries PowerPC machine (sPAPR) that
> > > advertises support, but does not implement MachineClass::wakeup()
> > > method as nothing needs to change in the machine state. [1]
> > >
> > > So, if a restart during wake-up happens, it can be differentiated wit=
h
> > > the wake-up reset type, and if the machine type does not need to rese=
t
> > > its devices during wake-up, there is no reset that needs to be
> > > differentiated.
> >
> > ... if the machine does not do any resets during suspend+wakeup, this
> > implies that there is not even a warm reset.
> >
> > I guess we should make that clearer in the documentation: it's up to a
> > machine implementation whether it wants to trigger a WARM reset during
> > suspend+wakeup. If not, not resets will be performed at all.
> >
> > @Peter, does that sound reasonable?
>
> Well, so far we've established that we need a "WAKEUP" reset
> type, but not that we need a "WARM" reset type. The latter
> would be something we'd need to trigger for quite a lot of
> reset-causes where we currently default to COLD reset, so
> I don't think we should do that until we need it.
>
> If suspend-and-wakeup really is supposed to be a reset event
> on some machines but not on others, that sounds unhelpfully
> nonstandard, but then hardware designers rarely make choices
> to make our lives easier :-) And yes, we should make sure
> that's clear in the documentation.

I have rewritten the documentation section to make it more explicit
that the reset might not happen. I would appreciate feedback if some
part still needs some care or if it is clear now.

  If the machine supports waking up from a suspended state and needs to
  reset its devices during wake-up (from ``MachineClass::wakeup()``
  method), this reset type should be used for such a request. Devices
  can utilize this reset type to differentiate the reset requested
  during machine wake-up from other reset requests. For example, a
  virtio-mem device must not unplug its memory blocks during wake-up as
  the contents of the guest RAM would get lost. However, this reset type
  should not be used for wake-up detection, as not every machine type
  issues a device reset request during wake-up.

>
> I think with adding new reset events it's going to be
> important that we're clear about what they are (and in
> particular what the triggering events that cause them
> are) so that we have a solid guide for what it means.
> The thing in particular I'm hoping to avoid here is that
> we vaguely define, for example, a "warm" reset type and then
> different parts of the system interpret "warm" in different
> ways.
>
> thanks
> -- PMM
>

Thank you!

--=20

Juraj Marcin


