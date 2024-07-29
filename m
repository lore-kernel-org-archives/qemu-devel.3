Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F54EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 03:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYHPQ-0007kx-Bp; Sun, 28 Jul 2024 23:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYHPK-0007ib-IU
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYHPI-0003uY-56
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722225040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83nyxBL2pBrP9UBU5iQt//IZ+DC7BpYlv0LwvDAsb+k=;
 b=e+COS2zJ2Q+dtOqOK0phzCxwm9dcMnUR4WvNDKQNWVj1UuMcbEg2kZxbwximUw565W5Gm4
 2nf1Q6UsQbyWgswD+PZlxjQwIByZ6emntmOLPHcL9svhGhtb3uFeuW5YEn3ffqFeDLLgdX
 CH+2l2YbdTD+eMUaHq+FemiUooLdpWc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-b-mz19eKMjGi1Qnq6HG6DA-1; Sun, 28 Jul 2024 23:50:38 -0400
X-MC-Unique: b-mz19eKMjGi1Qnq6HG6DA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb77ab2074so2819404a91.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 20:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722225037; x=1722829837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83nyxBL2pBrP9UBU5iQt//IZ+DC7BpYlv0LwvDAsb+k=;
 b=O31oxojxLdGb/pWJxN2QxD7nz0vpN7drJU1CxPhic2nT7NktZodM9zNdU3KwAJIbOG
 HoWeRJ79YJk8mXAOMbgClq23jJHbR9QR60HvUvAqf0Esv8UK0nRa5GxylBOzkDqUS5jE
 TNRyC4su9ZZOfgnemga5uFQLQYJMxa7eaQBcdGcn8931y4TNWreUSbQXN0dxOo/ZL7fF
 /ORs2Ee96RbbzsHG+W2eDBZrfosAqGbeWR5uIdBpsiR/BT92Pzzw3yfVUZplJyWfZBE2
 2P4hNxiNHz8sOoY2x4uD6d57d+iJ4zwWhvn+/oDgtb4HDKX1vcP/BjPxBDXJiPM6baP6
 ankw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi0P2lEKu6xiutaV4MyHPgrcJ9YzCNC3N4EymUcSr2wduwIQ1qS26e+55wpqS9s13HhURzlImI57sWiqoxvznh+mnj4XA=
X-Gm-Message-State: AOJu0YxcvGcRm7zA46aLItCcfBwce+OUynrGLTZqO5yz+CNM4wlSv4Fs
 9ndDAUXcD503ooapr+bHtDdgiNPh9dDekz/KjqPdewwTDYxaZY+C7ScLOZYDci7hdzldyU9gLTT
 tUiqj8HkyWyOxsQ1ynDcGkiDsyEb3JXuzaqq7/RNO+gAH+ZuuoR7M13uFEKX0GibgEuE82nzWQH
 JBuL9Uw6qttiEVRRFCfB1noQNXJ8Y=
X-Received: by 2002:a17:90a:ca12:b0:2c9:6401:4d1d with SMTP id
 98e67ed59e1d1-2cf7e5e107emr4375131a91.34.1722225037025; 
 Sun, 28 Jul 2024 20:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzyDY35IEc0nfpyokOgpXT/s/ixkWXBkB3ZDKvWui9NQrzmkwZjmqYWJCabxWb+j7/IKzKujsZgcMmc75eQFs=
X-Received: by 2002:a17:90a:ca12:b0:2c9:6401:4d1d with SMTP id
 98e67ed59e1d1-2cf7e5e107emr4375111a91.34.1722225036466; Sun, 28 Jul 2024
 20:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com>
 <ZqQLbGxEW3XT7qL-@x1n> <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
In-Reply-To: <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 11:50:25 +0800
Message-ID: <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de, 
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 28, 2024 at 11:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/07/27 5:47, Peter Xu wrote:
> > On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> >> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> >>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> >>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> >>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> >>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> >>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> >>>>>>>> USO features of virtio-net device depend on kernel ability
> >>>>>>>> to support them, for backward compatibility by default the
> >>>>>>>> features are disabled on 8.0 and earlier.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> >>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >>>>>>>
> >>>>>>> Looks like this patch broke migration when the VM starts on a hos=
t that has
> >>>>>>> USO supported, to another host that doesn't..
> >>>>>>
> >>>>>> This was always the case with all offloads. The answer at the mome=
nt is,
> >>>>>> don't do this.
> >>>>>
> >>>>> May I ask for my understanding:
> >>>>> "don't do this" =3D don't automatically enable/disable virtio featu=
res in QEMU
> >>>>> depending on host kernel features, or "don't do this" =3D don't try=
 to migrate
> >>>>> between machines that have different host kernel features?
> >>>>>
> >>>>>> Long term, we need to start exposing management APIs
> >>>>>> to discover this, and management has to disable unsupported featur=
es.
> >>>>>
> >>>>> Ack, this likely needs some treatments from the libvirt side, too.
> >>>>
> >>>> When QEMU automatically toggles machine type featuers based on host
> >>>> kernel, relying on libvirt to then disable them again is impractical=
,
> >>>> as we cannot assume that the libvirt people are using knows about
> >>>> newly introduced features. Even if libvirt is updated to know about
> >>>> it, people can easily be using a previous libvirt release.
> >>>>
> >>>> QEMU itself needs to make the machine types do that they are there
> >>>> todo, which is to define a stable machine ABI.
> >>>>
> >>>> What QEMU is missing here is a "platform ABI" concept, to encode
> >>>> sets of features which are tied to specific platform generations.
> >>>> As long as we don't have that we'll keep having these broken
> >>>> migration problems from machine types dynamically changing instead
> >>>> of providing a stable guest ABI.
> >>>
> >>> Any more elaboration on this idea?  Would it be easily feasible in
> >>> implementation?
> >>
> >> In terms of launching QEMU I'd imagine:
> >>
> >>    $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> >>
> >> Any virtual machine HW features which are tied to host kernel features
> >> would have their defaults set based on the requested -platform. The
> >> -machine will be fully invariant wrt the host kernel.
> >>
> >> You would have -platform hlep to list available platforms, and
> >> corresonding QMP "query-platforms" command to list what platforms
> >> are supported on a given host OS.
> >>
> >> Downstream distros can provide their own platforms definitions
> >> (eg "linux-rhel-9.5") if they have kernels whose feature set
> >> diverges from upstream due to backports.
> >>
> >> Mgmt apps won't need to be taught about every single little QEMU
> >> setting whose default is derived from the kernel. Individual
> >> defaults are opaque and controlled by the requested platform.
> >>
> >> Live migration has clearly defined semantics, and mgmt app can
> >> use query-platforms to validate two hosts are compatible.
> >>
> >> Omitting -platform should pick the very latest platform that is
> >> cmpatible with the current host (not neccessarily the latest
> >> platform built-in to QEMU).
> >
> > This seems to add one more layer to maintain, and so far I don't know
> > whether it's a must.
> >
> > To put it simple, can we simply rely on qemu cmdline as "the guest ABI"=
?  I
> > thought it was mostly the case already, except some extremely rare
> > outliers.
> >
> > When we have one host that boots up a VM using:
> >
> >    $QEMU1 $cmdline
> >
> > Then another host boots up:
> >
> >    $QEMU2 $cmdline -incoming XXX
> >
> > Then migration should succeed if $cmdline is exactly the same, and the =
VM
> > can boot up all fine without errors on both sides.
> >
> > AFAICT this has nothing to do with what kernel is underneath, even not
> > Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> > didn't, I thought the ABI should be guaranteed.
> >
> > That's why I think this is a migration violation, as 99.99% of other de=
vice
> > properties should be following this rule.  The issue here is, we have t=
he
> > same virtio-net-pci cmdline on both sides in this case, but the ABI got
> > break.
> >
> > That's also why I was suggesting if the property contributes to the gue=
st
> > ABI, then AFAIU QEMU needs to:
> >
> >    - Firstly, never quietly flipping any bit that affects the ABI...
> >
> >    - Have a default value of off, then QEMU will always allow the VM to=
 boot
> >      by default, while advanced users can opt-in on new features.  We c=
an't
> >      make this ON by default otherwise some VMs can already fail to boo=
t,
>
> It may not be necessary the case that old features are supported by
> every systems. In an extreme case, a user may migrate a VM from Linux to
> Windows, which probably doesn't support any offloading at all. A more
> convincing scenario is RSS offloading with eBPF; using eBPF requires a
> privilege so we cannot assume it is always available even on the latest
> version of Linux.

I don't get why eBPF matters here. It is something that is not noticed
by the guest and we have a fallback anyhow.

>
> >
> >    - If the host doesn't support the feature while the cmdline enabled =
it,
> >      it needs to fail QEMU boot rather than flipping, so that it says "=
hey,
> >      this host does not support running such VM specified, due to XXX
> >      feature missing".
>
> This is handled in:
>
> "virtio-net: Convert feature properties to OnOffAuto"
> https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/

I may miss something but I think "Auto" doesn't make sense to libvirt.

>
> >
> > That's the only way an user could understand what happened, and IMHO th=
at's
> > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > while in which the machine type is the fundation of such definition, as=
 the
> > machine type can decides many of the rest compat properties.  And that'=
s
> > the whole point of the compat properties too (to make sure the guest AB=
I is
> > stable).
> >
> > If kernel breaks it easily, all compat property things that we maintain=
 can
> > already stop making sense in general, because it didn't define the whol
> > guest ABI..
> >
> > So AFAIU that's really what we used for years, I hope I didn't overlook
> > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > keep up with this rule?
>
> I think a device which cannot conform to that rule should be
> non-migratable. For example, virtio-gpu-gl does not conform to it, and
> does not support migration either.
>
> Regards,
> Akihiko Odaki
>

Thanks


