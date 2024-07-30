Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63786C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdMh-0001c2-QY; Mon, 29 Jul 2024 23:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdMf-0001ax-Sr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdMd-0007nl-P0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722309446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpLrSQ+FoY+JlnqVjIG+tUpPwiaJdD69Akow0wOWD/Q=;
 b=G1/dlvmBQfTeGzH5wNL5tb8HzAoOsK5fBvj7TSKRB1HjaUXZHvySpdfDba2O7nEf3vBmTR
 YRYlvgqeVNhaxOQ5Bef8KYosmDcFGovKovgfxNaNYr4g/SBIyk6PmruqAhLueOkTQYZpiA
 XbB8g5gGFxdgTC33BwYScMrRRPfMdmg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-ZhYKRfOfOF-vWq021Q6UDg-1; Mon, 29 Jul 2024 23:17:21 -0400
X-MC-Unique: ZhYKRfOfOF-vWq021Q6UDg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb696be198so3893363a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 20:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722309440; x=1722914240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpLrSQ+FoY+JlnqVjIG+tUpPwiaJdD69Akow0wOWD/Q=;
 b=cciC6hFjgfHW2FdPJegPWgR6SoZEIKBMU/xVPdoBJqNz14IwHAOPP6H4OPN/jy/DOT
 95ryiVIdZlN6kOaltCYUhqEv0xKd/o9Y4Ml2GanQEHLlice+wmSmFIaJlwypkAfcIeRT
 RowsmASItcLbBMVT1xCZjcEikfRr4Pzn6gcL0hqcdmXxUNlfgOBmHqJBzeXmJoBM7hq+
 t7l4NMjEzVQfqBwQrGduVrlvGVQSWSwNwNbB598OyFWCPRdhAs5CbHmSheA2FUTA/XbZ
 bgAWWZN+LL9N13pKe4d7k7/W71TkX5rUSy5evNAf/yg4p1Tod7DTIpNh0hsRUyZvvXOh
 5Zcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVepcxkzaLP+OsGzU8IF8uZ+j79GaDJY51wTZmX9QVx/YpMXHuxaOC4GYYU6A1VZjM5MyTnv8dKClBdJwz+W6jlnmny2v8=
X-Gm-Message-State: AOJu0Yxd9eEIZTrNnJ+Sx9dn/MrvobwKEpW+KW6qjpYIPeBcSBuMRsVS
 8mQR+SPvww13wd+i/pwtXrZ/3XNiAd+HAo7sT5VFFCZkTk4UPc8CYd3b3LDhxwpCU54a9LFmtEf
 7I/MD7hcFRTrLCzDrG8KkgGhVA0CxzncA4VZSISPvB/uoyhqTDySAI4sRbtJfNrZcNjSSnJ3Y6i
 nkjvqMjnowatbVv17VDejyzgFOHcQ=
X-Received: by 2002:a17:90a:bb8d:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2cf7e1f9f24mr7913164a91.18.1722309440195; 
 Mon, 29 Jul 2024 20:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3GeW3ghczlVCT0P+PPfc9KyXguKIC9+LPGlnDEGmMLURfFlqZc6HxFjUYotkux+vQHMTgjkIRIVv2KOEF1TE=
X-Received: by 2002:a17:90a:bb8d:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2cf7e1f9f24mr7913139a91.18.1722309439688; Mon, 29 Jul 2024
 20:17:19 -0700 (PDT)
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
In-Reply-To: <bc2ef42e-9003-4a3e-aee5-e65d34f205bf@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:17:07 +0800
Message-ID: <CACGkMEvZgihjP3o3o6iLVJ69hHVZDoZdn3rJ5wohK+OEceStcA@mail.gmail.com>
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

On Tue, Jul 30, 2024 at 11:12=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/07/30 12:03, Jason Wang wrote:
> > On Tue, Jul 30, 2024 at 10:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/07/30 11:04, Jason Wang wrote:
> >>> On Tue, Jul 30, 2024 at 12:43=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> On 2024/07/29 23:29, Peter Xu wrote:
> >>>>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
> >>>>>> On 2024/07/29 12:50, Jason Wang wrote:
> >>>>>>> On Sun, Jul 28, 2024 at 11:19=E2=80=AFPM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2024/07/27 5:47, Peter Xu wrote:
> >>>>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrang=C3=
=A9 wrote:
> >>>>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> >>>>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrang=
=C3=A9 wrote:
> >>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> >>>>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> >>>>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> >>>>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovic=
h wrote:
> >>>>>>>>>>>>>>>> USO features of virtio-net device depend on kernel abili=
ty
> >>>>>>>>>>>>>>>> to support them, for backward compatibility by default t=
he
> >>>>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix=
.com>
> >>>>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Looks like this patch broke migration when the VM starts =
on a host that has
> >>>>>>>>>>>>>>> USO supported, to another host that doesn't..
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This was always the case with all offloads. The answer at =
the moment is,
> >>>>>>>>>>>>>> don't do this.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> May I ask for my understanding:
> >>>>>>>>>>>>> "don't do this" =3D don't automatically enable/disable virt=
io features in QEMU
> >>>>>>>>>>>>> depending on host kernel features, or "don't do this" =3D d=
on't try to migrate
> >>>>>>>>>>>>> between machines that have different host kernel features?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> Long term, we need to start exposing management APIs
> >>>>>>>>>>>>>> to discover this, and management has to disable unsupporte=
d features.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Ack, this likely needs some treatments from the libvirt sid=
e, too.
> >>>>>>>>>>>>
> >>>>>>>>>>>> When QEMU automatically toggles machine type featuers based =
on host
> >>>>>>>>>>>> kernel, relying on libvirt to then disable them again is imp=
ractical,
> >>>>>>>>>>>> as we cannot assume that the libvirt people are using knows =
about
> >>>>>>>>>>>> newly introduced features. Even if libvirt is updated to kno=
w about
> >>>>>>>>>>>> it, people can easily be using a previous libvirt release.
> >>>>>>>>>>>>
> >>>>>>>>>>>> QEMU itself needs to make the machine types do that they are=
 there
> >>>>>>>>>>>> todo, which is to define a stable machine ABI.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to en=
code
> >>>>>>>>>>>> sets of features which are tied to specific platform generat=
ions.
> >>>>>>>>>>>> As long as we don't have that we'll keep having these broken
> >>>>>>>>>>>> migration problems from machine types dynamically changing i=
nstead
> >>>>>>>>>>>> of providing a stable guest ABI.
> >>>>>>>>>>>
> >>>>>>>>>>> Any more elaboration on this idea?  Would it be easily feasib=
le in
> >>>>>>>>>>> implementation?
> >>>>>>>>>>
> >>>>>>>>>> In terms of launching QEMU I'd imagine:
> >>>>>>>>>>
> >>>>>>>>>>        $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args..=
.
> >>>>>>>>>>
> >>>>>>>>>> Any virtual machine HW features which are tied to host kernel =
features
> >>>>>>>>>> would have their defaults set based on the requested -platform=
. The
> >>>>>>>>>> -machine will be fully invariant wrt the host kernel.
> >>>>>>>>>>
> >>>>>>>>>> You would have -platform hlep to list available platforms, and
> >>>>>>>>>> corresonding QMP "query-platforms" command to list what platfo=
rms
> >>>>>>>>>> are supported on a given host OS.
> >>>>>>>>>>
> >>>>>>>>>> Downstream distros can provide their own platforms definitions
> >>>>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
> >>>>>>>>>> diverges from upstream due to backports.
> >>>>>>>>>>
> >>>>>>>>>> Mgmt apps won't need to be taught about every single little QE=
MU
> >>>>>>>>>> setting whose default is derived from the kernel. Individual
> >>>>>>>>>> defaults are opaque and controlled by the requested platform.
> >>>>>>>>>>
> >>>>>>>>>> Live migration has clearly defined semantics, and mgmt app can
> >>>>>>>>>> use query-platforms to validate two hosts are compatible.
> >>>>>>>>>>
> >>>>>>>>>> Omitting -platform should pick the very latest platform that i=
s
> >>>>>>>>>> cmpatible with the current host (not neccessarily the latest
> >>>>>>>>>> platform built-in to QEMU).
> >>>>>>>>>
> >>>>>>>>> This seems to add one more layer to maintain, and so far I don'=
t know
> >>>>>>>>> whether it's a must.
> >>>>>>>>>
> >>>>>>>>> To put it simple, can we simply rely on qemu cmdline as "the gu=
est ABI"?  I
> >>>>>>>>> thought it was mostly the case already, except some extremely r=
are
> >>>>>>>>> outliers.
> >>>>>>>>>
> >>>>>>>>> When we have one host that boots up a VM using:
> >>>>>>>>>
> >>>>>>>>>        $QEMU1 $cmdline
> >>>>>>>>>
> >>>>>>>>> Then another host boots up:
> >>>>>>>>>
> >>>>>>>>>        $QEMU2 $cmdline -incoming XXX
> >>>>>>>>>
> >>>>>>>>> Then migration should succeed if $cmdline is exactly the same, =
and the VM
> >>>>>>>>> can boot up all fine without errors on both sides.
> >>>>>>>>>
> >>>>>>>>> AFAICT this has nothing to do with what kernel is underneath, e=
ven not
> >>>>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  B=
ut if it
> >>>>>>>>> didn't, I thought the ABI should be guaranteed.
> >>>>>>>>>
> >>>>>>>>> That's why I think this is a migration violation, as 99.99% of =
other device
> >>>>>>>>> properties should be following this rule.  The issue here is, w=
e have the
> >>>>>>>>> same virtio-net-pci cmdline on both sides in this case, but the=
 ABI got
> >>>>>>>>> break.
> >>>>>>>>>
> >>>>>>>>> That's also why I was suggesting if the property contributes to=
 the guest
> >>>>>>>>> ABI, then AFAIU QEMU needs to:
> >>>>>>>>>
> >>>>>>>>>        - Firstly, never quietly flipping any bit that affects t=
he ABI...
> >>>>>>>>>
> >>>>>>>>>        - Have a default value of off, then QEMU will always all=
ow the VM to boot
> >>>>>>>>>          by default, while advanced users can opt-in on new fea=
tures.  We can't
> >>>>>>>>>          make this ON by default otherwise some VMs can already=
 fail to boot,
> >>>>>>>>
> >>>>>>>> It may not be necessary the case that old features are supported=
 by
> >>>>>>>> every systems. In an extreme case, a user may migrate a VM from =
Linux to
> >>>>>>>> Windows, which probably doesn't support any offloading at all. A=
 more
> >>>>>>>> convincing scenario is RSS offloading with eBPF; using eBPF requ=
ires a
> >>>>>>>> privilege so we cannot assume it is always available even on the=
 latest
> >>>>>>>> version of Linux.
> >>>>>>>
> >>>>>>> I don't get why eBPF matters here. It is something that is not no=
ticed
> >>>>>>> by the guest and we have a fallback anyhow.
> >>>>
> >>>> It is noticeable for the guest, and the fallback is not effective wi=
th
> >>>> vhost.
> >>>
> >>> It's a bug then. Qemu can fallback to tuntap if it sees issues in vho=
st.
> >>
> >> We can certainly fallback to in-QEMU RSS by disabling vhost, but I wou=
ld
> >> not say lack of such fallback is a bug.
> >
> > Such fallback is by design since the introduction of vhost.
> >
> >> We don't provide in-QEMU
> >> fallback for other offloads.
> >
> > Yes but what I want to say is that eBPF RSS is different from those
> > segmentation offloads. And technically, Qemu can do fallback for
> > offloads (as RSC did).
>
> Well, I couldn't find any code disabling vhost for the in-QEMU RSC
> implementation.

It should be a bug (and I remember we disabled vhost when the patches
were merged). Have you tested it in a guest to see if it can see RSC
when vhost is enabled?

I suspect we need to add the RSC bit into current kernel_feature_bits:

/* Features supported by host kernel. */
static const int kernel_feature_bits[] =3D {
    VIRTIO_F_NOTIFY_ON_EMPTY,
    VIRTIO_RING_F_INDIRECT_DESC,
    VIRTIO_RING_F_EVENT_IDX,
    VIRTIO_NET_F_MRG_RXBUF,
    VIRTIO_F_VERSION_1,
    VIRTIO_NET_F_MTU,
    VIRTIO_F_IOMMU_PLATFORM,
    VIRTIO_F_RING_PACKED,
    VIRTIO_F_RING_RESET,
    VIRTIO_NET_F_HASH_REPORT,
    VHOST_INVALID_FEATURE_BIT
};

As RSC won't be provided by TUN/TAP anyhow.

>
> Looking at the code, I also found the case of vhost-vdpa. vhost can be
> simply disabled if it is backed by tuntap, but it is not the case for vDP=
A.

True, technically, vDPA can fallback to SVQ, but it's another topic.

Thanks

>
> Regards,
> Akihiko Odaki
>


