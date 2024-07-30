Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD69C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcEX-0003mB-Pq; Mon, 29 Jul 2024 22:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYcEV-0003km-3V
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYcET-0002IR-2c
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722305094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0I4Z4CSyOZJWHtXUjCfyDWSPf8WRpW7TC6VAsYzyc8w=;
 b=aXcQ+1hb/QYnrYzIoLUpCXKcKj3YkDL/AQM0CpYS+7IfGbmQa5VyW5sSwfA5S9j83nLqE0
 qcGpWWo8wproL+JTwziv8XYFTT+ZSXq9x4goiw1aO/5J9Fp9sNf9G4zh6pDbbOZ1KIiCPM
 KAMx964i64FZjG9DV5+Jxdp0+T4v9RI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Ddi7rnD9MuO8vUUmyu_CPg-1; Mon, 29 Jul 2024 22:04:51 -0400
X-MC-Unique: Ddi7rnD9MuO8vUUmyu_CPg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-781cc721188so4061569a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305090; x=1722909890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0I4Z4CSyOZJWHtXUjCfyDWSPf8WRpW7TC6VAsYzyc8w=;
 b=EQ/whyMLqC0BW5SxR1SfgjmOAT8q+zDb+lwdVhSyw3rgryuHh11f4vvg/L/Li9TWw0
 /DL8v5XvtJQv23IuvRusd6pd1E8h/VzVvVdUcFCqENM1wTObnx54oSfXpL37iZzDVQkk
 YXzAlNLtEKsLoW58blpNIHHoA9+JOHiKmoBfsUviHcqr91PLiEfQirulqNnj3myT2w71
 yCyEMSKy+JbgqYkgxWHil9tTqriy0KRr+nKIbfnPgWQocI/x3m4tPDuyDnREWjW6INTa
 DfsguLN0+Rb1/NJf/gcaR0p17mIJlPy13lfkmMBNMnJcEdKa3hSC5pH9WpCgfBEBw3Ot
 psUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl2jgWzYJoM4tf/vItmGv6irabvfBDvcuvtVl0hsqwFUCfBSesAvoZXFTmdETnLAT7ShcfHAWGtTjXwRmcevWOuH/KL9Q=
X-Gm-Message-State: AOJu0YzQ8czbAjoOQFBMuwPTBnE0C1x+GFzg3sBJ6yu3G0yoBjH8641K
 LkRvhQ1xyfNARKu8l0dLBks9xZeOVb26XsPzkgk9/Qz/mktH/o6w+sm1K4KCEAZQLVkFb+OODKh
 Tb6k0MLcEH7oYu+Au7qYxayebA2++RZz9nshs8yxDwQywzpwmGIpc+OiWaxW8wCi4+rftkOcxkx
 o+Te2SGx/Je+L6gt619VG/EKXlDZs=
X-Received: by 2002:a17:90a:67c5:b0:2c9:79d3:a15d with SMTP id
 98e67ed59e1d1-2cf7e5f4f11mr10322915a91.29.1722305090312; 
 Mon, 29 Jul 2024 19:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWV7qwc5Fus4kGKbW/L3ei0qFUfSX1tlKbd8NEbLGUY135IgoxzEPiSqj/fFvffcbf4L6HJmQzcOe9hufWMlI=
X-Received: by 2002:a17:90a:67c5:b0:2c9:79d3:a15d with SMTP id
 98e67ed59e1d1-2cf7e5f4f11mr10322892a91.29.1722305089805; Mon, 29 Jul 2024
 19:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com>
 <ZqO2HvFJ8v7hZFOd@x1n> <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com> <ZqenSQHzniN14g7G@x1n>
 <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
In-Reply-To: <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 10:04:38 +0800
Message-ID: <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
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

On Tue, Jul 30, 2024 at 12:43=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/07/29 23:29, Peter Xu wrote:
> > On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
> >> On 2024/07/29 12:50, Jason Wang wrote:
> >>> On Sun, Jul 28, 2024 at 11:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> On 2024/07/27 5:47, Peter Xu wrote:
> >>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> >>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> >>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrang=C3=A9=
 wrote:
> >>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> >>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> >>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> >>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wr=
ote:
> >>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
> >>>>>>>>>>>> to support them, for backward compatibility by default the
> >>>>>>>>>>>> features are disabled on 8.0 and earlier.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com=
>
> >>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Looks like this patch broke migration when the VM starts on a=
 host that has
> >>>>>>>>>>> USO supported, to another host that doesn't..
> >>>>>>>>>>
> >>>>>>>>>> This was always the case with all offloads. The answer at the =
moment is,
> >>>>>>>>>> don't do this.
> >>>>>>>>>
> >>>>>>>>> May I ask for my understanding:
> >>>>>>>>> "don't do this" =3D don't automatically enable/disable virtio f=
eatures in QEMU
> >>>>>>>>> depending on host kernel features, or "don't do this" =3D don't=
 try to migrate
> >>>>>>>>> between machines that have different host kernel features?
> >>>>>>>>>
> >>>>>>>>>> Long term, we need to start exposing management APIs
> >>>>>>>>>> to discover this, and management has to disable unsupported fe=
atures.
> >>>>>>>>>
> >>>>>>>>> Ack, this likely needs some treatments from the libvirt side, t=
oo.
> >>>>>>>>
> >>>>>>>> When QEMU automatically toggles machine type featuers based on h=
ost
> >>>>>>>> kernel, relying on libvirt to then disable them again is impract=
ical,
> >>>>>>>> as we cannot assume that the libvirt people are using knows abou=
t
> >>>>>>>> newly introduced features. Even if libvirt is updated to know ab=
out
> >>>>>>>> it, people can easily be using a previous libvirt release.
> >>>>>>>>
> >>>>>>>> QEMU itself needs to make the machine types do that they are the=
re
> >>>>>>>> todo, which is to define a stable machine ABI.
> >>>>>>>>
> >>>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
> >>>>>>>> sets of features which are tied to specific platform generations=
.
> >>>>>>>> As long as we don't have that we'll keep having these broken
> >>>>>>>> migration problems from machine types dynamically changing inste=
ad
> >>>>>>>> of providing a stable guest ABI.
> >>>>>>>
> >>>>>>> Any more elaboration on this idea?  Would it be easily feasible i=
n
> >>>>>>> implementation?
> >>>>>>
> >>>>>> In terms of launching QEMU I'd imagine:
> >>>>>>
> >>>>>>      $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> >>>>>>
> >>>>>> Any virtual machine HW features which are tied to host kernel feat=
ures
> >>>>>> would have their defaults set based on the requested -platform. Th=
e
> >>>>>> -machine will be fully invariant wrt the host kernel.
> >>>>>>
> >>>>>> You would have -platform hlep to list available platforms, and
> >>>>>> corresonding QMP "query-platforms" command to list what platforms
> >>>>>> are supported on a given host OS.
> >>>>>>
> >>>>>> Downstream distros can provide their own platforms definitions
> >>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
> >>>>>> diverges from upstream due to backports.
> >>>>>>
> >>>>>> Mgmt apps won't need to be taught about every single little QEMU
> >>>>>> setting whose default is derived from the kernel. Individual
> >>>>>> defaults are opaque and controlled by the requested platform.
> >>>>>>
> >>>>>> Live migration has clearly defined semantics, and mgmt app can
> >>>>>> use query-platforms to validate two hosts are compatible.
> >>>>>>
> >>>>>> Omitting -platform should pick the very latest platform that is
> >>>>>> cmpatible with the current host (not neccessarily the latest
> >>>>>> platform built-in to QEMU).
> >>>>>
> >>>>> This seems to add one more layer to maintain, and so far I don't kn=
ow
> >>>>> whether it's a must.
> >>>>>
> >>>>> To put it simple, can we simply rely on qemu cmdline as "the guest =
ABI"?  I
> >>>>> thought it was mostly the case already, except some extremely rare
> >>>>> outliers.
> >>>>>
> >>>>> When we have one host that boots up a VM using:
> >>>>>
> >>>>>      $QEMU1 $cmdline
> >>>>>
> >>>>> Then another host boots up:
> >>>>>
> >>>>>      $QEMU2 $cmdline -incoming XXX
> >>>>>
> >>>>> Then migration should succeed if $cmdline is exactly the same, and =
the VM
> >>>>> can boot up all fine without errors on both sides.
> >>>>>
> >>>>> AFAICT this has nothing to do with what kernel is underneath, even =
not
> >>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But i=
f it
> >>>>> didn't, I thought the ABI should be guaranteed.
> >>>>>
> >>>>> That's why I think this is a migration violation, as 99.99% of othe=
r device
> >>>>> properties should be following this rule.  The issue here is, we ha=
ve the
> >>>>> same virtio-net-pci cmdline on both sides in this case, but the ABI=
 got
> >>>>> break.
> >>>>>
> >>>>> That's also why I was suggesting if the property contributes to the=
 guest
> >>>>> ABI, then AFAIU QEMU needs to:
> >>>>>
> >>>>>      - Firstly, never quietly flipping any bit that affects the ABI=
...
> >>>>>
> >>>>>      - Have a default value of off, then QEMU will always allow the=
 VM to boot
> >>>>>        by default, while advanced users can opt-in on new features.=
  We can't
> >>>>>        make this ON by default otherwise some VMs can already fail =
to boot,
> >>>>
> >>>> It may not be necessary the case that old features are supported by
> >>>> every systems. In an extreme case, a user may migrate a VM from Linu=
x to
> >>>> Windows, which probably doesn't support any offloading at all. A mor=
e
> >>>> convincing scenario is RSS offloading with eBPF; using eBPF requires=
 a
> >>>> privilege so we cannot assume it is always available even on the lat=
est
> >>>> version of Linux.
> >>>
> >>> I don't get why eBPF matters here. It is something that is not notice=
d
> >>> by the guest and we have a fallback anyhow.
>
> It is noticeable for the guest, and the fallback is not effective with
> vhost.

It's a bug then. Qemu can fallback to tuntap if it sees issues in vhost.

Thanks


