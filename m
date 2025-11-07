Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A330CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 16:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHP3y-0004df-Hy; Fri, 07 Nov 2025 11:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vHP3p-0004dJ-J9
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 11:11:39 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vHP3n-00052H-Fm
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 11:11:37 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64124e430adso170367a12.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762531893; x=1763136693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uomCj2IBPlnNgmkcD8XLLPqP6HfDMWHIyOyHt3by6lE=;
 b=g1x/VgHMNNZdmgTl18sjsxzx6ucJeuJD86yjo0DfV5CSWcJFEuvsxFpH+cl00c/7rP
 jkVGUfkOG9BqjPmdKjbSKXOQPRsh6z4ToV9w0KakkkSgPh8kU64qNIgOAJBNO9k+thwh
 yPALN6R4MjAU3OnuyXxW9tvfNSoNIlrBnOWj3E1ncijVcrf4DXnuliXrHj0QBx/QVjHo
 fAQ+RhcBGIxZPONNPiDgrpD3PM1P3XVUDBEm+xOXCe8CXsl7aHWIui5RWF5EGqnIvv+t
 FQUhIwoBfLFOD4IGq1bKRm4BPpkMO9BSuMWWT3J86qh4OUklo7QZ8bZ7TftSMHk22+ag
 hZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531893; x=1763136693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uomCj2IBPlnNgmkcD8XLLPqP6HfDMWHIyOyHt3by6lE=;
 b=mNo1KuliG17Kv84lRywOXn/P1AYp4nFBF2gTnqKsZtvUoQBABqtZh8kGUVTd9DgKgn
 fxLBB+2s/qoxK2k0M8KTnw913WNEZM0F8sA+YY1mO+GvzEPVjKKLgSbSghiGSVohu5U0
 6ggbOAgSYWxT2/s9F2ZUOh/G9IbNo0oXl9TroetSveRMXhJMF132NswVQdbI+SEl8UK9
 Y852VdFED4FYgiV9XpVj4D+H1DTXWmwvpYK6/CfvrKFeLABkg1Ji0p29Wqm03JuunRmI
 p9WUD0sDSUcIFBAQCf7J1cMLM2q+IMRE8uEQVuh3Bq8UAlkBBzRL1utPIEvDa0GK1jCi
 w+aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnuEoqZiERfgBHXblY+fide8mW3kYxubTZzcbMcAkjisTFqdfzUhKUiTxpVlb1Nh9YH+KK0wrpT0W@nongnu.org
X-Gm-Message-State: AOJu0YyglVkwQpeQa/Nlc2DzEs1CpVG+ZmIb6ITsusaPMIuyA35vGBs9
 XI94Zy9x5YnE2F+sQ7Ura5XOCyNO9tBznxO7ECCsxUb2Ay1KeWAIV8/mR6LD4H+6qmfvLk3bCQH
 wnNsR/D6xbvGXZwxrQYwCpWaMKpwR8sKJMqaTtUUFDw==
X-Gm-Gg: ASbGncsRSSzZ0Z2XD3HDsg8uHK1PA19StRRb7gYkF3pkf8BawHBYtSEO5iD6+LOr0ce
 gGFFfIPG6CldwIqYcuOUylpKkYWXkbvfheGGgrZs3EK6F+HbTDIQgq04Q391yZK2qw5tEUuSLwB
 oe8JIfVE9r5N+2yKwSNTdSOHrW6z6L4Y30TdLj1o0KQlEJuUAPjpz6D1+q8hBUwf5bVMEwZDfJu
 GyRZoEcTb6oa/tMEfzcltcw8kg3G9ln0MnP3zHz6FkSNnaBIdcOqWKQZ6AL4USgNdPmIRCOjE05
 jK76nK9MXVqxRCf23A==
X-Google-Smtp-Source: AGHT+IGvWkWHmRx1s1UfXRVM6FZFJZclWnIZFL4mv08Fm1P4iNlVAMQdGhSwJJpeodARJXPeOJn/GwlmfARFaaWgTis=
X-Received: by 2002:a05:6402:13cb:b0:63c:5eef:c8c9 with SMTP id
 4fb4d7f45d1cf-6413f24fa92mr2019179a12.8.1762531893349; Fri, 07 Nov 2025
 08:11:33 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
 <CAMGffE=VdsQSTOOpBvaDc=RQ98cMDHYemF7nS5pnqJ7Rsvafug@mail.gmail.com>
 <CACGkMEtMK1_QJM7x33sLO-QOtdttV=8hBfH8YbYSB_-GDE6CTg@mail.gmail.com>
 <CAMGffE=Z=tRJG9knPURmPDHtANQa5szysXvpmpes57f2C228Og@mail.gmail.com>
In-Reply-To: <CAMGffE=Z=tRJG9knPURmPDHtANQa5szysXvpmpes57f2C228Og@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 7 Nov 2025 17:11:22 +0100
X-Gm-Features: AWmQ_bn_vSGtTBj4l3TuzIyIF-zhZuV6PhtuQcMfBuN2CRuGEFhQgpYbIh2w3X0
Message-ID: <CAMGffEmEAZ0ksKJmo982EHYr8j=QN5BHKUL1q0vq5kov6hHFCw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52c;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Nov 7, 2025 at 4:06=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Hi Jason,
>
> On Fri, Nov 7, 2025 at 2:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Nov 6, 2025 at 10:28=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.co=
m> wrote:
> > >
> > > Hi Peter,
> > > On Wed, Nov 5, 2025 at 11:17=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > > > > These are not present (or not supported) on QEMU 8.2.10, whic=
h causes
> > > > > > > the migration state load to fail.
> > > > > >
> > > > > > Interesting, we've already done the compat work:
> > > > > >
> > > > > > GlobalProperty hw_compat_8_1[] =3D {
> > > > > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true=
" },
> > > > > >     { "ramfb", "x-migrate", "off" },
> > > > > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > > > > >     { "igb", "x-pcie-flr-init", "off" },
> > > > > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > > > > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > > > > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > > > > };
> > > > > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > > > > Yeah, I noticed the same.
> > > >
> > > > AFAICT, this is a known issue..
> > > >
> > > > Thomas and I used to suggest we should not turn on USO* by default =
by
> > > > probing kernel, but only allow user choosing it explicitly in a VM
> > > > setup. IOW, dest qemu should stop booting at all when kernel is too=
 old
> > > > (when user chose the feature).
> > > I feel this is the approach we should have picked.
> > > >
> > > > See:
> > > >
> > > > https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
> > > Is there any effort to allow migration from new OS support the USO
> > > features to old OS doesn't support it?
> >
> > You can teach your management to disable USO via the qemu command line.
>
> I added "host_uso=3Dfalse,guest_uso4=3Dfalse,guest_uso6=3Dfalse" for -dev=
ice
> virtio-net-pci
> But migration still fails with slightly different error:
> char device redirected to /dev/pts/1 (label charserial0)
> 2025-11-07T15:00:45.528098Z qemu-8.2: Features 0x10130afffa7
> unsupported. Allowed features: 0x179bfffe7
> 2025-11-07T15:00:45.528245Z qemu-8.2: Failed to load virtio-net:virtio
> 2025-11-07T15:00:45.528253Z qemu-8.2: error while loading state for
> instance 0x0 of device '0000:00:02.0:06.0/virtio-net'
>
> I suppose it is VIRTIO_F_RING_RESET?
> Any idea? I didn't find option to disable it
Found it,  "host_uso=3Dfalse,guest_uso4=3Dfalse,guest_uso6=3Dfalse,queue_re=
set=3Dfalse"
is needed to allow migration from new OS to old OS
> >
> > > Any hint to make it work?
> >
> > Thanks
>
> Thx!
> >
> > > >
> > > > Thanks,
> > > >
> > > > --
> > > > Peter Xu
> > > >
> > > Thx for the help.
> > >
> >

