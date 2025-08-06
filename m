Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15045C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 10:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujaz6-0005Vn-BH; Wed, 06 Aug 2025 06:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujaxj-0004mQ-GD; Wed, 06 Aug 2025 06:01:36 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujaxg-0000WD-Kp; Wed, 06 Aug 2025 06:01:35 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4af027d966eso54506061cf.3; 
 Wed, 06 Aug 2025 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754474491; x=1755079291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d0UPIInUU/G37It1zYjYe9bCh8kjZfymyFoZGzDuyw=;
 b=ma6sgRvqIA1Uqkgmz4l7lrjGvdOI4YvpKuSfFspvqi9ch+1iqvQRCclbSVHifuyprH
 /w+pFijhntttCZ9iZkfC4fBSZbImbQjFtrKG2uS6+/89QbGjl/bzWO4e22P68Z8w1gLJ
 xJS9/LycEF8iK3PwjAK0VsJJ6QqGBnLMHi+ngwX+clkrdfQ+i05rvlf87SV+L6H241zH
 kFl79CmoBcPISQoJEoyTQ9DaLboKA0mXQhrIA9yV2oQJekVbqaFON4pHwz0EgpGmZqjG
 Mq2yAmw5NOtQS3U5KLYcl0TGBPi15EecqQ/GR8B8mKLe3pG4CaGrkbF9kWT8Hb6oM0Pa
 n0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754474491; x=1755079291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9d0UPIInUU/G37It1zYjYe9bCh8kjZfymyFoZGzDuyw=;
 b=ofuphIxECNj2r1TovbCq+uf6U/NoYKqfYbzMjRe0AaJBj3dhXDpZP03kPWIeaxaiW0
 qFtlsvd23Sq5xKcye/ipE/+wwdoGoVcCtl6r2A2drvy97xyYHQ7aic77p6MtBrBfy8hV
 DdkUG0IOWWXknyVSldda5zCk4Na1KZOjOj1aDotarhwASRNue6fGTvphJaJuyTeVjfGf
 53V6Wv9Y0NQuPlFcnQe1y5aIwnmZUaMWhqu3TC9ViMgsIGOfQuo2SssaARB/biZp4o9u
 8ylHxvin+y2WsmuAp4WKwsGYmbUO2m1DI3sr+uSb3aRG9NnzV7B4QMZw3KAgyJYOImQu
 tkrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUNDbFuepCx7p3FwNK9ZvlUAs1E0T7vwFKyawxAwe9ZUhZNV/+E90akki/ffRzd3IZ8XQy6IJBlw==@nongnu.org,
 AJvYcCXTfLPKmQCHHyEAHqk6FlZiBdlDwy6Gz7mMwmMypIj3+mKGHMIOpyy2e3wy0wu9msbGO6VnttsFsUCUqA==@nongnu.org
X-Gm-Message-State: AOJu0Yw+5wG/2oQWu/YKR/uMqp8nwbMsm5v45vrCil6hztqXGb4gGyGH
 fxwKfNoQEVba1q8JiRT8WoSGefPzRxXNwyFZQ0Ihfv+lwCF6zkiF3H3CL/Bhvpu0Zy8/uDQeSH+
 9jajM2eTjfxbItnecibOa/FxlWM/CVek=
X-Gm-Gg: ASbGncvh/Y9Q/G1it8ys/o/M1fOuY0+EZ80hRb/etxq0UI3D0hYvvmwpJDe4oyiNok+
 X81QWdtoUWIWM393QqnHy4AJnpNSIpfqOLYosewnLosZyiP+Kzr37555+EK609q4K3HeIMA+cRu
 J4i6434iyXxCFuQ4DEFvDSTtHC68PXziP5RzEZhxQTmRILHdntFCeXPxyPdpc9ARFvaYfevzFK9
 XXt9Jzf
X-Google-Smtp-Source: AGHT+IH2Ih25rcPJ242xLk7vQf+D9gXscU4dHwGre/xZhxElysFxhasXDyGw2pzROQPPj5o859iP2dOVGBI7NDQvxK4=
X-Received: by 2002:a05:622a:2b0a:b0:4ab:887c:8b with SMTP id
 d75a77b69052e-4b0926c92ebmr29360321cf.42.1754474490508; Wed, 06 Aug 2025
 03:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-25-123450810db7@redhat.com>
 <CAMxuvayZkKyaTwj0orFx3k73=R0uesW2g-kZWVBDyoAiubP0WQ@mail.gmail.com>
 <aJMkWOWgeURCksd7@armenon-kvm.bengluru.csb>
In-Reply-To: <aJMkWOWgeURCksd7@armenon-kvm.bengluru.csb>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Aug 2025 14:01:18 +0400
X-Gm-Features: Ac12FXwz6KEyS9CHAi-cF4YhbS2RtoXy7wXGqqlCC4GsNrLuE_brEetnMxJiJDQ
Message-ID: <CAJ+F1CLL9dt+fbOjGsxZR05L++Xtee6EvcPYt1TXyzE-DQ-M4Q@mail.gmail.com>
Subject: Re: [PATCH v9 25/27] migration: Remove error variant of
 vmstate_save_state() function
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Aug 6, 2025 at 1:47=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> Hi Marc-Andr=C3=A9,
> Thanks for the review.
>
> On Wed, Aug 06, 2025 at 12:28:54PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Aug 5, 2025 at 10:31=E2=80=AFPM Arun Menon <armenon@redhat.com>=
 wrote:
> >
> > > This commit removes the redundant vmstate_save_state_with_err()
> > > function.
> > >
> > > Previously, commit 969298f9d7 introduced vmstate_save_state_with_err(=
)
> > > to handle error propagation, while vmstate_save_state() existed for
> > > non-error scenarios.
> > > This is because there were code paths where vmstate_save_state_v()
> > > (called internally by vmstate_save_state) did not explicitly set
> > > errors on failure.
> > >
> > > This change unifies error handling by
> > >  - updating vmstate_save_state() to accept an Error **errp argument.
> > >  - vmstate_save_state_v() ensures errors are set directly within the =
errp
> > >    object, eliminating the need for two separate functions. Specifica=
lly
> > >    errors are handled by storing them in errp in vmstate_save_dispatc=
h()
> > >
> > > All calls to vmstate_save_state_with_err() are replaced with
> > > vmstate_save_state(). This simplifies the API and improves code
> > > maintainability.
> > >
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > >
> >
> > I realize that vmstate_save_state() callers progressively became silent=
 on
> > error with this series (switching to error_report to error_set). I sugg=
est
> > you make a preliminary patch to make vmstate_save_state() verbose by
> > passing &error_warn to vmstate_save_state_v. wdyt?
>
> I am sorry, I did not understand the suggestion completely.
> vmstate_save_state() callers have always been silent before. Even before =
this series.
> Because, by default NULL was passed in vmstate_save_state_v().

But inner functions were calling error_report()

>
> This commit in the series changes that by passing &error_warn to vmstate_=
save_state_v()
> inside vmstate_save_state() and removing the need for alternate vmstate_s=
ave_state_with_err().
>
> Do you mean that we need to pass &error_warn to vmstate_save_state_v() in=
 vmstate_save_state()
> as a preliminary patch before this patch? Please correct me if I am wrong=
.

I think so, then errors are still reported until the parent handles
the error reporting itself.

> >
> > patch lgtm otherwise
> >
> >
> >
> >
> > > ---
> > >  hw/display/virtio-gpu.c     |  3 ++-
> > >  hw/pci/pci.c                |  2 +-
> > >  hw/s390x/virtio-ccw.c       |  2 +-
> > >  hw/scsi/spapr_vscsi.c       |  2 +-
> > >  hw/vfio/pci.c               |  4 ++--
> > >  hw/virtio/virtio-mmio.c     |  2 +-
> > >  hw/virtio/virtio-pci.c      |  2 +-
> > >  hw/virtio/virtio.c          |  4 ++--
> > >  include/migration/vmstate.h |  2 --
> > >  migration/cpr.c             |  5 +++--
> > >  migration/savevm.c          |  7 ++++---
> > >  migration/vmstate-types.c   | 12 +++++++-----
> > >  migration/vmstate.c         | 18 ++++++++----------
> > >  tests/unit/test-vmstate.c   |  8 +++++---
> > >  ui/vdagent.c                |  3 ++-
> > >  15 files changed, 40 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > > index
> > > 5ff9f5e6dc0b6b112e36170318c900f893a73c5e..bddb26fa21312e5d0b2b6412cdf=
2a6c28dd06eb3
> > > 100644
> > > --- a/hw/display/virtio-gpu.c
> > > +++ b/hw/display/virtio-gpu.c
> > > @@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void
> > > *opaque, size_t size,
> > >      }
> > >      qemu_put_be32(f, 0); /* end of list */
> > >
> > > -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NU=
LL);
> > > +    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NU=
LL,
> > > +                              &error_warn);
> > >  }
> > >
> > >  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index
> > > 80545189980f176ca6a3dc9abce7043c8bc2708c..f7fb3931ff190c25ffa665ba80a=
be7737dbefdb6
> > > 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> > >       * This makes us compatible with old devices
> > >       * which never set or clear this bit. */
> > >      s->config[PCI_STATUS] &=3D ~PCI_STATUS_INTERRUPT;
> > > -    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
> > > +    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_warn)=
;
> > >      /* Restore the interrupt status bit. */
> > >      pci_update_irq_status(s);
> > >  }
> > > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > > index
> > > bafcb9b76d81749925e31b5a0a1320b3332ad2cf..14304fd3e8901d28a7788266df2=
c7ef7334b691c
> > > 100644
> > > --- a/hw/s390x/virtio-ccw.c
> > > +++ b/hw/s390x/virtio-ccw.c
> > > @@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d=
, int
> > > n, QEMUFile *f)
> > >  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> > >  {
> > >      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> > > -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
> > > +    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL,
> > > &error_warn);
> > >  }
> > >
> > >  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> > > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > > index
> > > a4812afd0cc7c495080ef03a531c7d279af29b33..2204beb40c7cdc827db2bf86fb8=
612d8c09999ed
> > > 100644
> > > --- a/hw/scsi/spapr_vscsi.c
> > > +++ b/hw/scsi/spapr_vscsi.c
> > > @@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f,
> > > SCSIRequest *sreq)
> > >      vscsi_req *req =3D sreq->hba_private;
> > >      assert(req->active);
> > >
> > > -    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
> > > +    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL,
> > > &error_warn);
> > >
> > >      trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
> > >                                     req->cur_desc_offset);
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index
> > > 04d385d7674f444844beeee7364ee0424f762758..8e2b6d611de8efdf98235355226=
f5e5a6fd87b19
> > > 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice
> > > *vbasedev, QEMUFile *f, Error **errp)
> > >  {
> > >      VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vb=
asedev);
> > >
> > > -    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, =
vdev,
> > > NULL,
> > > -                                       errp);
> > > +    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NUL=
L,
> > > +                              errp);
> > >  }
> > >
> > >  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > > index
> > > f14f0487fec3ed30d2cc3aec96950c2121265716..58957990743f061e78d0eafcfcb=
6cc5989252edc
> > > 100644
> > > --- a/hw/virtio/virtio-mmio.c
> > > +++ b/hw/virtio/virtio-mmio.c
> > > @@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceSt=
ate
> > > *opaque, QEMUFile *f)
> > >  {
> > >      VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);
> > >
> > > -    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
> > > +    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_=
warn);
> > >  }
> > >
> > >  static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFil=
e *f)
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index
> > > 07f144d6d1bfbb561b28015de71762601080dc23..0826399cdfbf09b5b3f9acd9967=
de3417858c9d2
> > > 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceSta=
te
> > > *d, QEMUFile *f)
> > >  {
> > >      VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> > >
> > > -    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
> > > +    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_w=
arn);
> > >  }
> > >
> > >  static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index
> > > aac317a93c3cd55ece9b0fd858c7b2459f8242f9..552e167529e9c22fb4cba2b445f=
fad85fef619f3
> > > 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3025,14 +3025,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile =
*f)
> > >      }
> > >
> > >      if (vdc->vmsd) {
> > > -        int ret =3D vmstate_save_state(f, vdc->vmsd, vdev, NULL);
> > > +        int ret =3D vmstate_save_state(f, vdc->vmsd, vdev, NULL,
> > > &error_warn);
> > >          if (ret) {
> > >              return ret;
> > >          }
> > >      }
> > >
> > >      /* Subsections */
> > > -    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> > > +    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL,
> > > &error_warn);
> > >  }
> > >
> > >  /* A wrapper for use as a VMState .put function */
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.=
h
> > > index
> > > 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54c=
c516dbe8dc32a
> > > 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
> > >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > >                         void *opaque, int version_id, Error **errp);
> > >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> > > -                       void *opaque, JSONWriter *vmdesc);
> > > -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescriptio=
n
> > > *vmsd,
> > >                         void *opaque, JSONWriter *vmdesc, Error **err=
p);
> > >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd=
,
> > >                           void *opaque, JSONWriter *vmdesc,
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index
> > > bdb24736f44e91ba59b6e622a315597c97e7f64d..d48f013dac21b531e41a26f4bb3=
3eefe32097757
> > > 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -163,6 +163,7 @@ bool cpr_is_incoming(void)
> > >
> > >  int cpr_state_save(MigrationChannel *channel, Error **errp)
> > >  {
> > > +    ERRP_GUARD();
> > >      int ret;
> > >      QEMUFile *f;
> > >      MigMode mode =3D migrate_mode();
> > > @@ -182,9 +183,9 @@ int cpr_state_save(MigrationChannel *channel, Err=
or
> > > **errp)
> > >      qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
> > >      qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
> > >
> > > -    ret =3D vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0)=
;
> > > +    ret =3D vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0,=
 errp);
> > >      if (ret) {
> > > -        error_setg(errp, "vmstate_save_state error %d", ret);
> > > +        error_prepend(errp, "vmstate_save_state error %d: ", ret);
> > >          qemu_fclose(f);
> > >          return ret;
> > >      }
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index
> > > 4df50fb5c674e56c0173c357c1e23367373e2114..3cb9c34efb22fdcb2b05cf1fefc=
b6fbd80cadca5
> > > 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateE=
ntry
> > > *se, JSONWriter *vmdesc,
> > >      if (!se->vmsd) {
> > >          vmstate_save_old_style(f, se, vmdesc);
> > >      } else {
> > > -        ret =3D vmstate_save_state_with_err(f, se->vmsd, se->opaque,=
 vmdesc,
> > > -                                          errp);
> > > +        ret =3D vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
> > > +                                 errp);
> > >          if (ret) {
> > >              return ret;
> > >          }
> > > @@ -1303,7 +1303,8 @@ void qemu_savevm_state_header(QEMUFile *f)
> > >              json_writer_start_object(vmdesc, "configuration");
> > >          }
> > >
> > > -        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> > > vmdesc);
> > > +        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> > > vmdesc,
> > > +                           &error_warn);
> > >
> > >          if (vmdesc) {
> > >              json_writer_end_object(vmdesc);
> > > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > > index
> > > e2020a733d0921d748b6f832a193e5de8d302d5f..2b88dc145ab32072f09845cee95=
b79aad7ac3cb2
> > > 100644
> > > --- a/migration/vmstate-types.c
> > > +++ b/migration/vmstate-types.c
> > > @@ -564,7 +564,7 @@ static int put_tmp(QEMUFile *f, void *pv, size_t =
size,
> > >
> > >      /* Writes the parent field which is at the start of the tmp */
> > >      *(void **)tmp =3D pv;
> > > -    ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc);
> > > +    ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc, &error_warn);
> > >      g_free(tmp);
> > >
> > >      return ret;
> > > @@ -675,7 +675,7 @@ static int put_qtailq(QEMUFile *f, void *pv, size=
_t
> > > unused_size,
> > >
> > >      QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
> > >          qemu_put_byte(f, true);
> > > -        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
> > > +        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn=
);
> > >          if (ret) {
> > >              return ret;
> > >          }
> > > @@ -712,7 +712,8 @@ static gboolean put_gtree_elem(gpointer key, gpoi=
nter
> > > value, gpointer data)
> > >      if (!capsule->key_vmsd) {
> > >          qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key =
*/
> > >      } else {
> > > -        ret =3D vmstate_save_state(f, capsule->key_vmsd, key,
> > > capsule->vmdesc);
> > > +        ret =3D vmstate_save_state(f, capsule->key_vmsd, key,
> > > capsule->vmdesc,
> > > +                                 &error_warn);
> > >          if (ret) {
> > >              capsule->ret =3D ret;
> > >              return true;
> > > @@ -720,7 +721,8 @@ static gboolean put_gtree_elem(gpointer key, gpoi=
nter
> > > value, gpointer data)
> > >      }
> > >
> > >      /* put the data */
> > > -    ret =3D vmstate_save_state(f, capsule->val_vmsd, value,
> > > capsule->vmdesc);
> > > +    ret =3D vmstate_save_state(f, capsule->val_vmsd, value, capsule-=
>vmdesc,
> > > +                             &error_warn);
> > >      if (ret) {
> > >          capsule->ret =3D ret;
> > >          return true;
> > > @@ -856,7 +858,7 @@ static int put_qlist(QEMUFile *f, void *pv, size_=
t
> > > unused_size,
> > >      trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
> > >      QLIST_RAW_FOREACH(elm, pv, entry_offset) {
> > >          qemu_put_byte(f, true);
> > > -        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
> > > +        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn=
);
> > >          if (ret) {
> > >              error_report("%s: failed to save %s (%d)", field->name,
> > >                           vmsd->name, ret);
> > > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > index
> > > ef78a1e62ad92e9608de72d125da80ea496c8dd1..569e66ea983f833e6a0d651d2a7=
51f34a64e8f5c
> > > 100644
> > > --- a/migration/vmstate.c
> > > +++ b/migration/vmstate.c
> > > @@ -403,12 +403,6 @@ bool vmstate_section_needed(const VMStateDescrip=
tion
> > > *vmsd, void *opaque)
> > >
> > >
> > >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> > > -                       void *opaque, JSONWriter *vmdesc_id)
> > > -{
> > > -    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> > > vmsd->version_id, NULL);
> > > -}
> > > -
> > > -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescriptio=
n
> > > *vmsd,
> > >                         void *opaque, JSONWriter *vmdesc_id, Error **=
errp)
> > >  {
> > >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> > > vmsd->version_id, errp);
> > > @@ -530,7 +524,7 @@ static int vmstate_save_dispatch(QEMUFile *f,
> > >
> > >                  if (inner_field->flags & VMS_STRUCT) {
> > >                      ret =3D vmstate_save_state(f, inner_field->vmsd,
> > > -                                             curr_elem, vmdesc_loop)=
;
> > > +                                             curr_elem, vmdesc_loop,
> > > errp);
> > >                  } else if (inner_field->flags & VMS_VSTRUCT) {
> > >                      ret =3D vmstate_save_state_v(f, inner_field->vms=
d,
> > >                                                 curr_elem, vmdesc_loo=
p,
> > > @@ -539,6 +533,10 @@ static int vmstate_save_dispatch(QEMUFile *f,
> > >                  } else {
> > >                      ret =3D inner_field->info->put(f, curr_elem, siz=
e,
> > >                                                   inner_field,
> > > vmdesc_loop);
> > > +                    if (ret) {
> > > +                        error_setg(errp, "Save of field %s failed",
> > > +                                   inner_field->name);
> > > +                    }
> > >                  }
> > >
> > >                  written_bytes =3D qemu_file_transferred(f) - old_off=
set;
> > > @@ -551,8 +549,8 @@ static int vmstate_save_dispatch(QEMUFile *f,
> > >                  }
> > >
> > >                  if (ret) {
> > > -                    error_setg(errp, "Save of field %s/%s failed",
> > > -                                vmsd->name, field->name);
> > > +                    error_prepend(errp, "Save of field %s/%s failed:=
 ",
> > > +                                  vmsd->name, field->name);
> > >                      ps_ret =3D post_save_dispatch(vmsd, opaque, &loc=
al_err);
> > >                      if (ps_ret) {
> > >                          ret =3D ps_ret;
> > > @@ -723,7 +721,7 @@ static int vmstate_subsection_save(QEMUFile *f, c=
onst
> > > VMStateDescription *vmsd,
> > >              qemu_put_byte(f, len);
> > >              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
> > >              qemu_put_be32(f, vmsdsub->version_id);
> > > -            ret =3D vmstate_save_state_with_err(f, vmsdsub, opaque, =
vmdesc,
> > > errp);
> > > +            ret =3D vmstate_save_state(f, vmsdsub, opaque, vmdesc, e=
rrp);
> > >              if (ret) {
> > >                  return ret;
> > >              }
> > > diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> > > index
> > > 807deb3531f3079864ac99567d4dece7122571dd..5f31ed4b6969c4ebf72b298f965=
bcbdc752ff87f
> > > 100644
> > > --- a/tests/unit/test-vmstate.c
> > > +++ b/tests/unit/test-vmstate.c
> > > @@ -69,7 +69,7 @@ static void save_vmstate(const VMStateDescription *=
desc,
> > > void *obj)
> > >      QEMUFile *f =3D open_test_file(true);
> > >
> > >      /* Save file with vmstate */
> > > -    int ret =3D vmstate_save_state(f, desc, obj, NULL);
> > > +    int ret =3D vmstate_save_state(f, desc, obj, NULL, &error_warn);
> > >      g_assert(!ret);
> > >      qemu_put_byte(f, QEMU_VM_EOF);
> > >      g_assert(!qemu_file_get_error(f));
> > > @@ -429,7 +429,8 @@ static void test_save_noskip(void)
> > >      QEMUFile *fsave =3D open_test_file(true);
> > >      TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =3D 4, .e =
=3D 5, .f =3D 6,
> > >                         .skip_c_e =3D false };
> > > -    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, N=
ULL);
> > > +    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, N=
ULL,
> > > +                                 &error_warn);
> > >      g_assert(!ret);
> > >      g_assert(!qemu_file_get_error(fsave));
> > >
> > > @@ -451,7 +452,8 @@ static void test_save_skip(void)
> > >      QEMUFile *fsave =3D open_test_file(true);
> > >      TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =3D 4, .e =
=3D 5, .f =3D 6,
> > >                         .skip_c_e =3D true };
> > > -    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, N=
ULL);
> > > +    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, N=
ULL,
> > > +                                 &error_warn);
> > >      g_assert(!ret);
> > >      g_assert(!qemu_file_get_error(fsave));
> > >
> > > diff --git a/ui/vdagent.c b/ui/vdagent.c
> > > index
> > > b9a22a689d9acfeafb862ae73308db6fbd52331e..e0fc7ff71468bfe667613853876=
53c742c375f05
> > > 100644
> > > --- a/ui/vdagent.c
> > > +++ b/ui/vdagent.c
> > > @@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size=
_t
> > > size,
> > >          }
> > >      }
> > >
> > > -    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmd=
esc);
> > > +    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmd=
esc,
> > > +                              &error_warn);
> > >  }
> > >
> > >  static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
> > >
> > > --
> > > 2.50.1
> > >
> > >
>
>
> Regards,
> Arun
>
>


--=20
Marc-Andr=C3=A9 Lureau

