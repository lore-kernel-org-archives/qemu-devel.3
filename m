Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10E0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 02:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyiS-0006eB-MJ; Tue, 30 Jul 2024 22:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYyiS-0006dN-2u
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYyiO-0003f9-So
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722391520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGDD77JUvU0/if8QVjUjPsul4GFukMRf+g0wAhX7b6I=;
 b=b21iTOM7V0UUliYgSBxG+vLcfrFPMfVn55KGTr6LXwsHrR9cOmbH1m6mbJ5gx/11pHVUD3
 l3MINTV9n8hXAy858jYJQt6sjcoveD+nWbGdrXBxUZ0M1sFN+zRNBKs31OKIUPushqO0Wk
 49WYgM5ZXmwT7Pf9xilGuEQMh900x5k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-DfjOBZyNO-eI25v7JG0XiA-1; Tue, 30 Jul 2024 22:05:18 -0400
X-MC-Unique: DfjOBZyNO-eI25v7JG0XiA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb81c562edso4981555a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 19:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722391517; x=1722996317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGDD77JUvU0/if8QVjUjPsul4GFukMRf+g0wAhX7b6I=;
 b=AnbHcKT7AqIdlWuI3vcLH9SWasWf6WbauxfzSOokMW6og2VXVeuDhHT3Yk6RHPc8XN
 vo5Jl+AWLpN2wjvDy9k+y3pmeliF1SDOegu7FM/cJpPUbCMUcXY4yOIWa1Dpw5BsWhyC
 Pbv2jA1uQGIgIwVPEepZTFdqfAVZdwE1iAO/0SeZzmfqwmdX7fz+KeIRX/UsSIaXWegI
 DOlK1ypOe/Ra98ed21R/6caqObuUzWjMSxtq3iETt3+N/U+rGC0z4/wErM9fq51VEXMf
 rcgnwPKyGjSD/+hWLvqFZYmdZe077XPL0gUDqqlKGACa/RXBXT5404L3u46Xtu9E5sqV
 Rx1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGcQuaT3lmUjQ+CVeKIS0dkDW5uXP+V8MpFOQkNYUsLxJb1uxEB0jezyLEVSoZyPQl8MgvWNtVuHCA4yV0hDrRCb+KQcI=
X-Gm-Message-State: AOJu0YxoqLKMN1tx8E+2bI+XaoIUrEEM6bW32D7Kn3kAyA/Y0uSRO95M
 gYUhbeHNFa2aorr2mIgLUKg7hUIsQ8g6vwS4IGhGAE1L7R5HU3e/MOS7XxYOxUZkxlajx+f0Upe
 PvDk8BFDWwqsxCifHEY37xdTE3JmONJsjbNsi6ohB3p2d3aJZ5/uGGhySi3Zy+sNv4/Yl5nq4uJ
 Q1IrKBAxHTx0ygDE32ZMCsYqPduXs=
X-Received: by 2002:a17:90b:8d2:b0:2c9:99e4:51bd with SMTP id
 98e67ed59e1d1-2cf7e5eb9admr10710326a91.29.1722391517387; 
 Tue, 30 Jul 2024 19:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc4NiqKEwNdSVjVMAQv9yeUJlMKPiJvs3V0JRGQkmBRaOjtnogWhcDaYP4XOPoVZ2Sd76WnrI4xVmEsyyf82g=
X-Received: by 2002:a17:90b:8d2:b0:2c9:99e4:51bd with SMTP id
 98e67ed59e1d1-2cf7e5eb9admr10710302a91.29.1722391516792; Tue, 30 Jul 2024
 19:05:16 -0700 (PDT)
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
 <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
 <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
 <CACGkMEvgYTjQ5orDJMbmE8-Kwqko9dFPerTnxsRgs0EtnmKKTQ@mail.gmail.com>
 <bc2ef42e-9003-4a3e-aee5-e65d34f205bf@daynix.com>
 <CACGkMEvZgihjP3o3o6iLVJ69hHVZDoZdn3rJ5wohK+OEceStcA@mail.gmail.com>
 <90f29246-f63f-4cc4-935a-bb874ecae1a0@daynix.com>
 <CACGkMEtbeWde4_AbEZyTmShaXyo-WwAt7=o1=uimD0zmrKK8pg@mail.gmail.com>
 <87ab434e-ae8c-4170-9d7f-8875ecf915c3@daynix.com>
In-Reply-To: <87ab434e-ae8c-4170-9d7f-8875ecf915c3@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 10:05:05 +0800
Message-ID: <CACGkMEths1RGBAfS4Pba2=zDat9RoWRCN1BB=9MzjWCnfjL8XA@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 6:23=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/07/30 12:45, Jason Wang wrote:
> > On Tue, Jul 30, 2024 at 11:29=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/07/30 12:17, Jason Wang wrote:
> >>> On Tue, Jul 30, 2024 at 11:12=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> On 2024/07/30 12:03, Jason Wang wrote:
> >>>>> On Tue, Jul 30, 2024 at 10:57=E2=80=AFAM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2024/07/30 11:04, Jason Wang wrote:
> >>>>>>> On Tue, Jul 30, 2024 at 12:43=E2=80=AFAM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2024/07/29 23:29, Peter Xu wrote:
> >>>>>>>>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
> >>>>>>>>>> On 2024/07/29 12:50, Jason Wang wrote:
> >>>>>>>>>>> On Sun, Jul 28, 2024 at 11:19=E2=80=AFPM Akihiko Odaki <akihi=
ko.odaki@daynix.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2024/07/27 5:47, Peter Xu wrote:
> >>>>>>>>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrang=
=C3=A9 wrote:
> >>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> >>>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berra=
ng=C3=A9 wrote:
> >>>>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wr=
ote:
> >>>>>>>>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> >>>>>>>>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wro=
te:
> >>>>>>>>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Bendit=
ovich wrote:
> >>>>>>>>>>>>>>>>>>>> USO features of virtio-net device depend on kernel a=
bility
> >>>>>>>>>>>>>>>>>>>> to support them, for backward compatibility by defau=
lt the
> >>>>>>>>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@da=
ynix.com>
> >>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.co=
m>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> Looks like this patch broke migration when the VM sta=
rts on a host that has
> >>>>>>>>>>>>>>>>>>> USO supported, to another host that doesn't..
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> This was always the case with all offloads. The answer=
 at the moment is,
> >>>>>>>>>>>>>>>>>> don't do this.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> May I ask for my understanding:
> >>>>>>>>>>>>>>>>> "don't do this" =3D don't automatically enable/disable =
virtio features in QEMU
> >>>>>>>>>>>>>>>>> depending on host kernel features, or "don't do this" =
=3D don't try to migrate
> >>>>>>>>>>>>>>>>> between machines that have different host kernel featur=
es?
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Long term, we need to start exposing management APIs
> >>>>>>>>>>>>>>>>>> to discover this, and management has to disable unsupp=
orted features.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Ack, this likely needs some treatments from the libvirt=
 side, too.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> When QEMU automatically toggles machine type featuers ba=
sed on host
> >>>>>>>>>>>>>>>> kernel, relying on libvirt to then disable them again is=
 impractical,
> >>>>>>>>>>>>>>>> as we cannot assume that the libvirt people are using kn=
ows about
> >>>>>>>>>>>>>>>> newly introduced features. Even if libvirt is updated to=
 know about
> >>>>>>>>>>>>>>>> it, people can easily be using a previous libvirt releas=
e.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> QEMU itself needs to make the machine types do that they=
 are there
> >>>>>>>>>>>>>>>> todo, which is to define a stable machine ABI.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, t=
o encode
> >>>>>>>>>>>>>>>> sets of features which are tied to specific platform gen=
erations.
> >>>>>>>>>>>>>>>> As long as we don't have that we'll keep having these br=
oken
> >>>>>>>>>>>>>>>> migration problems from machine types dynamically changi=
ng instead
> >>>>>>>>>>>>>>>> of providing a stable guest ABI.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Any more elaboration on this idea?  Would it be easily fe=
asible in
> >>>>>>>>>>>>>>> implementation?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> In terms of launching QEMU I'd imagine:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>          $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...=
args...
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Any virtual machine HW features which are tied to host ker=
nel features
> >>>>>>>>>>>>>> would have their defaults set based on the requested -plat=
form. The
> >>>>>>>>>>>>>> -machine will be fully invariant wrt the host kernel.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> You would have -platform hlep to list available platforms,=
 and
> >>>>>>>>>>>>>> corresonding QMP "query-platforms" command to list what pl=
atforms
> >>>>>>>>>>>>>> are supported on a given host OS.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Downstream distros can provide their own platforms definit=
ions
> >>>>>>>>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature s=
et
> >>>>>>>>>>>>>> diverges from upstream due to backports.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Mgmt apps won't need to be taught about every single littl=
e QEMU
> >>>>>>>>>>>>>> setting whose default is derived from the kernel. Individu=
al
> >>>>>>>>>>>>>> defaults are opaque and controlled by the requested platfo=
rm.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Live migration has clearly defined semantics, and mgmt app=
 can
> >>>>>>>>>>>>>> use query-platforms to validate two hosts are compatible.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Omitting -platform should pick the very latest platform th=
at is
> >>>>>>>>>>>>>> cmpatible with the current host (not neccessarily the late=
st
> >>>>>>>>>>>>>> platform built-in to QEMU).
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This seems to add one more layer to maintain, and so far I =
don't know
> >>>>>>>>>>>>> whether it's a must.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> To put it simple, can we simply rely on qemu cmdline as "th=
e guest ABI"?  I
> >>>>>>>>>>>>> thought it was mostly the case already, except some extreme=
ly rare
> >>>>>>>>>>>>> outliers.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> When we have one host that boots up a VM using:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          $QEMU1 $cmdline
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Then another host boots up:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          $QEMU2 $cmdline -incoming XXX
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Then migration should succeed if $cmdline is exactly the sa=
me, and the VM
> >>>>>>>>>>>>> can boot up all fine without errors on both sides.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> AFAICT this has nothing to do with what kernel is underneat=
h, even not
> >>>>>>>>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail=
.  But if it
> >>>>>>>>>>>>> didn't, I thought the ABI should be guaranteed.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> That's why I think this is a migration violation, as 99.99%=
 of other device
> >>>>>>>>>>>>> properties should be following this rule.  The issue here i=
s, we have the
> >>>>>>>>>>>>> same virtio-net-pci cmdline on both sides in this case, but=
 the ABI got
> >>>>>>>>>>>>> break.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> That's also why I was suggesting if the property contribute=
s to the guest
> >>>>>>>>>>>>> ABI, then AFAIU QEMU needs to:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          - Firstly, never quietly flipping any bit that aff=
ects the ABI...
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>          - Have a default value of off, then QEMU will alwa=
ys allow the VM to boot
> >>>>>>>>>>>>>            by default, while advanced users can opt-in on n=
ew features.  We can't
> >>>>>>>>>>>>>            make this ON by default otherwise some VMs can a=
lready fail to boot,
> >>>>>>>>>>>>
> >>>>>>>>>>>> It may not be necessary the case that old features are suppo=
rted by
> >>>>>>>>>>>> every systems. In an extreme case, a user may migrate a VM f=
rom Linux to
> >>>>>>>>>>>> Windows, which probably doesn't support any offloading at al=
l. A more
> >>>>>>>>>>>> convincing scenario is RSS offloading with eBPF; using eBPF =
requires a
> >>>>>>>>>>>> privilege so we cannot assume it is always available even on=
 the latest
> >>>>>>>>>>>> version of Linux.
> >>>>>>>>>>>
> >>>>>>>>>>> I don't get why eBPF matters here. It is something that is no=
t noticed
> >>>>>>>>>>> by the guest and we have a fallback anyhow.
> >>>>>>>>
> >>>>>>>> It is noticeable for the guest, and the fallback is not effectiv=
e with
> >>>>>>>> vhost.
> >>>>>>>
> >>>>>>> It's a bug then. Qemu can fallback to tuntap if it sees issues in=
 vhost.
> >>>>>>
> >>>>>> We can certainly fallback to in-QEMU RSS by disabling vhost, but I=
 would
> >>>>>> not say lack of such fallback is a bug.
> >>>>>
> >>>>> Such fallback is by design since the introduction of vhost.
> >>>>>
> >>>>>> We don't provide in-QEMU
> >>>>>> fallback for other offloads.
> >>>>>
> >>>>> Yes but what I want to say is that eBPF RSS is different from those
> >>>>> segmentation offloads. And technically, Qemu can do fallback for
> >>>>> offloads (as RSC did).
> >>>>
> >>>> Well, I couldn't find any code disabling vhost for the in-QEMU RSC
> >>>> implementation.
> >>>
> >>> It should be a bug (and I remember we disabled vhost when the patches
> >>> were merged). Have you tested it in a guest to see if it can see RSC
> >>> when vhost is enabled?
> >>>
> >>> I suspect we need to add the RSC bit into current kernel_feature_bits=
:
> >>>
> >>> /* Features supported by host kernel. */
> >>> static const int kernel_feature_bits[] =3D {
> >>>       VIRTIO_F_NOTIFY_ON_EMPTY,
> >>>       VIRTIO_RING_F_INDIRECT_DESC,
> >>>       VIRTIO_RING_F_EVENT_IDX,
> >>>       VIRTIO_NET_F_MRG_RXBUF,
> >>>       VIRTIO_F_VERSION_1,
> >>>       VIRTIO_NET_F_MTU,
> >>>       VIRTIO_F_IOMMU_PLATFORM,
> >>>       VIRTIO_F_RING_PACKED,
> >>>       VIRTIO_F_RING_RESET,
> >>>       VIRTIO_NET_F_HASH_REPORT,
> >>>       VHOST_INVALID_FEATURE_BIT
> >>> };
> >>>
> >>> As RSC won't be provided by TUN/TAP anyhow.
> >>
> >> Adding the RSC bit does not let QEMU disable vhost for RSC, but instea=
d
> >> it implicitly disables RSC in my understanding.
> >
> > Yes.
> >
> >> It is still better than
> >> advertising the availability of that feature while it is missing.
> >
> > Down the road, we probably need to change the behaviour of disabling vh=
ost-net.
> >
> >>
> >>>
> >>>>
> >>>> Looking at the code, I also found the case of vhost-vdpa. vhost can =
be
> >>>> simply disabled if it is backed by tuntap, but it is not the case fo=
r vDPA.
> >>>
> >>> True, technically, vDPA can fallback to SVQ, but it's another topic.
> >>
> >> My point of this discussion is that we cannot enable features just
> >> because they are sufficiently old or because the user claims QEMU runs
> >> on Linux sufficiently new. eBPF requires privilege, and vDPA requires
> >> hardware feature. A fallback is not a silver bullet either, and there
> >> are situations that providing a fallback is not a trivial task.
> >
> > To make sure we are on the same page. I just want to point out that
> > eBPF RSS is not a good example in this context.
> >
> > It works only for tuntap, so we should stick to the behaviour of
> > trying to fallback to userspace if we can as we've already had a
> > userspace fallback. This is the fundamental difference with other
> > features (like segmentation offload) or backend (vDPA) that doesn't
> > have an existing fallback.
>
> Some (probably not all) offloads are implemented in hw/net/net_tx_pkt.c.
> They are not wired up to behave as a fallback when tuntap's vhost is
> enabled as the in-QEMU RSS is not. In either case, we need to pay some
> effort to wiring things.
>
> I'm not sure it is worthwhile. I think there is a high chance that
> selectively disabling vhost and keeping RSS enabled with fallback will
> result in worse performance than keeping vhost enabled and disabling
> RSS. Such a fallback can still function as an emergency escape hatch,
> but it is also incomplete as we don't have fallbacks for other features.

The reason is that we depend on ioctl to configure and negotiate with
tuntap correctly.

> I would rather make any features missing in the vhost backend fail to
> keep things consistent.

You might be right but it's too late to do that.

Thanks

>
> Regards,
> Akihiko Odaki
>


