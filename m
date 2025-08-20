Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A10CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uokgU-00082G-Le; Wed, 20 Aug 2025 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uokgS-00081x-B1
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:25:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uokgK-00070I-3s
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:25:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F351E1FDCF;
 Wed, 20 Aug 2025 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755703493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcWhZ8OvFAYEahhKm1yk/BEDQ5NTa7vZ1cD7hWF4YQU=;
 b=XmAaJoJDenN9YhwEQ/tutdLuqv0+ajLus7v00djrf5CAHWz8+kDCPTgwM8Pdqv2FaLTj40
 DPtNIegY78+yXs5T8XUlkMlXG+VL4zqmGiZGhpAmemnN8y3+CKuyPAoA8QkBiFCkY0uPni
 K+zk5JHtuAiucuH42KyY04t14ObbKAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755703493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcWhZ8OvFAYEahhKm1yk/BEDQ5NTa7vZ1cD7hWF4YQU=;
 b=7VJOwZik2df0/Oji36Nz6nzhQw6Z86ky7XvjlXAIKqI0NZaWHJqUqEizStq5aq0dz5aB15
 TnOyD0P2xY1K3tDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755703493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcWhZ8OvFAYEahhKm1yk/BEDQ5NTa7vZ1cD7hWF4YQU=;
 b=XmAaJoJDenN9YhwEQ/tutdLuqv0+ajLus7v00djrf5CAHWz8+kDCPTgwM8Pdqv2FaLTj40
 DPtNIegY78+yXs5T8XUlkMlXG+VL4zqmGiZGhpAmemnN8y3+CKuyPAoA8QkBiFCkY0uPni
 K+zk5JHtuAiucuH42KyY04t14ObbKAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755703493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcWhZ8OvFAYEahhKm1yk/BEDQ5NTa7vZ1cD7hWF4YQU=;
 b=7VJOwZik2df0/Oji36Nz6nzhQw6Z86ky7XvjlXAIKqI0NZaWHJqUqEizStq5aq0dz5aB15
 TnOyD0P2xY1K3tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 288F713867;
 Wed, 20 Aug 2025 15:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WfzQCcTopWjibQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Aug 2025 15:24:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Be?=
 =?utf-8?Q?nn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia
 Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v11 02/27] migration: push Error **errp into
 vmstate_load_state()
In-Reply-To: <aKWDWabj0wJJXanL@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-2-b470a374b42d@redhat.com>
 <87o6sgzj5t.fsf@suse.de> <aKWDWabj0wJJXanL@armenon-kvm.bengluru.csb>
Date: Wed, 20 Aug 2025 12:24:49 -0300
Message-ID: <87ldnevwvy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[31];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,xfusion.com,linux.vnet.ibm.com];
 R_RATELIMIT(0.00)[to_ip_from(RL96jwb13nk98k7j3ws9zhxhn8)];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Arun Menon <armenon@redhat.com> writes:

> Hi Fabiano,
>
> Thanks for the review.
>
> On Fri, Aug 15, 2025 at 12:41:50PM -0300, Fabiano Rosas wrote:
>> Arun Menon <armenon@redhat.com> writes:
>>=20
>> > This is an incremental step in converting vmstate loading
>> > code to report error via Error objects instead of directly
>> > printing it to console/monitor.
>> > It is ensured that vmstate_load_state() must report an error
>> > in errp, in case of failure.
>> >
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Signed-off-by: Arun Menon <armenon@redhat.com>
>> > ---
>> >  hw/display/virtio-gpu.c     |  2 +-
>> >  hw/pci/pci.c                |  3 ++-
>> >  hw/s390x/virtio-ccw.c       |  2 +-
>> >  hw/scsi/spapr_vscsi.c       |  2 +-
>> >  hw/vfio/pci.c               |  3 ++-
>> >  hw/virtio/virtio-mmio.c     |  3 ++-
>> >  hw/virtio/virtio-pci.c      |  2 +-
>> >  hw/virtio/virtio.c          |  4 +--
>> >  include/migration/vmstate.h |  2 +-
>> >  migration/cpr.c             |  5 ++--
>> >  migration/savevm.c          |  6 +++--
>> >  migration/vmstate-types.c   | 22 ++++++++++++----
>> >  migration/vmstate.c         | 61 ++++++++++++++++++++++++++++++------=
-------
>> >  tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++=
++-------
>> >  ui/vdagent.c                |  3 ++-
>> >  15 files changed, 136 insertions(+), 47 deletions(-)
>> >
>> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> > index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a436=
4ab10de2595a4bedf7 100644
>> > --- a/hw/display/virtio-gpu.c
>> > +++ b/hw/display/virtio-gpu.c
>> > @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *op=
aque, size_t size,
>> >      }
>> >=20=20
>> >      /* load & apply scanout state */
>> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
>> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_=
fatal);
>> >=20=20
>> >      return 0;
>> >  }
>> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> > index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c480870=
7db2a7b6378a90e82b 100644
>> > --- a/hw/pci/pci.c
>> > +++ b/hw/pci/pci.c
>> > @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>> >  int pci_device_load(PCIDevice *s, QEMUFile *f)
>> >  {
>> >      int ret;
>> > -    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_=
id);
>> > +    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_=
id,
>> > +                             &error_fatal);
>> >      /* Restore the interrupt status bit. */
>> >      pci_update_irq_status(s);
>> >      return ret;
>> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> > index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7c=
eb9deffc0cc303bcff 100644
>> > --- a/hw/s390x/virtio-ccw.c
>> > +++ b/hw/s390x/virtio-ccw.c
>> > @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *=
d, QEMUFile *f)
>> >  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>> >  {
>> >      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
>> > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
>> > +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &er=
ror_fatal);
>> >  }
>> >=20=20
>> >  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
>> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>> > index 20f70fb2729de78b9636a6b8c869695dab4f8902..8c896022d324f519626052=
88d6d6df1648c83cde 100644
>> > --- a/hw/scsi/spapr_vscsi.c
>> > +++ b/hw/scsi/spapr_vscsi.c
>> > @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIR=
equest *sreq)
>> >      assert(!req->active);
>> >=20=20
>> >      memset(req, 0, sizeof(*req));
>> > -    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
>> > +    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &e=
rror_fatal);
>> >      if (rc) {
>> >          fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sre=
q->tag);
>> >          return NULL;
>> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> > index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..0be54762cdcbdb4780b822=
8b0bdf7fc6bd74dd57 100644
>> > --- a/hw/vfio/pci.c
>> > +++ b/hw/vfio/pci.c
>> > @@ -2795,7 +2795,8 @@ static int vfio_pci_load_config(VFIODevice *vbas=
edev, QEMUFile *f)
>> >          old_addr[bar] =3D pdev->io_regions[bar].addr;
>> >      }
>> >=20=20
>> > -    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
>> > +    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
>> > +                             &error_fatal);
>> >      if (ret) {
>> >          return ret;
>> >      }
>> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>> > index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde93=
3667ae8c309ab527d0 100644
>> > --- a/hw/virtio/virtio-mmio.c
>> > +++ b/hw/virtio/virtio-mmio.c
>> > @@ -34,6 +34,7 @@
>> >  #include "qemu/error-report.h"
>> >  #include "qemu/log.h"
>> >  #include "trace.h"
>> > +#include "qapi/error.h"
>> >=20=20
>> >  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>> >  {
>> > @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceStat=
e *opaque, QEMUFile *f)
>> >  {
>> >      VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);
>> >=20=20
>> > -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
>> > +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &err=
or_fatal);
>> >  }
>> >=20=20
>> >  static bool virtio_mmio_has_extra_state(DeviceState *opaque)
>> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> > index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54=
ec41d92422d16bfc13 100644
>> > --- a/hw/virtio/virtio-pci.c
>> > +++ b/hw/virtio/virtio-pci.c
>> > @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState=
 *d, QEMUFile *f)
>> >  {
>> >      VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
>> >=20=20
>> > -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
>> > +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &erro=
r_fatal);
>> >  }
>> >=20=20
>> >  static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
>> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> > index 9a81ad912e013fc254899c4e55cff1f76a6112a4..6bcafb338d1b5becadcacf=
092ba33a6ae4c3d194 100644
>> > --- a/hw/virtio/virtio.c
>> > +++ b/hw/virtio/virtio.c
>> > @@ -3327,14 +3327,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
>> >      }
>> >=20=20
>> >      if (vdc->vmsd) {
>> > -        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id);
>> > +        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id, &e=
rror_fatal);
>> >          if (ret) {
>> >              return ret;
>> >          }
>> >      }
>> >=20=20
>> >      /* Subsections */
>> > -    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
>> > +    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1, &error_fa=
tal);
>> >      if (ret) {
>> >          return ret;
>> >      }
>> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> > index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081=
594d9f88b32adfd674 100644
>> > --- a/include/migration/vmstate.h
>> > +++ b/include/migration/vmstate.h
>> > @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
>> >      }
>> >=20=20
>> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>> > -                       void *opaque, int version_id);
>> > +                       void *opaque, int version_id, Error **errp);
>> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>> >                         void *opaque, JSONWriter *vmdesc);
>> >  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription=
 *vmsd,
>> > diff --git a/migration/cpr.c b/migration/cpr.c
>> > index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..bdb24736f44e91ba59b6e6=
22a315597c97e7f64d 100644
>> > --- a/migration/cpr.c
>> > +++ b/migration/cpr.c
>> > @@ -202,6 +202,7 @@ int cpr_state_save(MigrationChannel *channel, Erro=
r **errp)
>> >=20=20
>> >  int cpr_state_load(MigrationChannel *channel, Error **errp)
>> >  {
>> > +    ERRP_GUARD();
>> >      int ret;
>> >      uint32_t v;
>> >      QEMUFile *f;
>> > @@ -233,9 +234,9 @@ int cpr_state_load(MigrationChannel *channel, Erro=
r **errp)
>> >          return -ENOTSUP;
>> >      }
>> >=20=20
>> > -    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
>> > +    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, =
errp);
>> >      if (ret) {
>> > -        error_setg(errp, "vmstate_load_state error %d", ret);
>> > +        error_prepend(errp, "vmstate_load_state error %d: ", ret);
>> >          qemu_fclose(f);
>> >          return ret;
>> >      }
>> > diff --git a/migration/savevm.c b/migration/savevm.c
>> > index fabbeb296ae987d0c06ba6dafda63720205fecfd..cb64f2855d46aaa7c617b3=
e4079a2c9e566079b2 100644
>> > --- a/migration/savevm.c
>> > +++ b/migration/savevm.c
>> > @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntr=
y *se)
>> >      if (!se->vmsd) {         /* Old style */
>> >          return se->ops->load_state(f, se->opaque, se->load_version_id=
);
>> >      }
>> > -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_versi=
on_id);
>> > +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_versi=
on_id,
>> > +                              &error_fatal);
>> >  }
>> >=20=20
>> >  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
>> > @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>> >              error_report("Configuration section missing");
>> >              return -EINVAL;
>> >          }
>> > -        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm=
_state, 0);
>> > +        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm=
_state, 0,
>> > +                                 &error_fatal);
>> >=20=20
>> >          if (ret) {
>> >              return ret;
>> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> > index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..f41670cc853c5b41ccc8de=
f354886a8e5c1451fd 100644
>> > --- a/migration/vmstate-types.c
>> > +++ b/migration/vmstate-types.c
>> > @@ -19,6 +19,7 @@
>> >  #include "qemu/error-report.h"
>> >  #include "qemu/queue.h"
>> >  #include "trace.h"
>> > +#include "qapi/error.h"
>> >=20=20
>> >  /* bool */
>> >=20=20
>> > @@ -543,13 +544,17 @@ static int get_tmp(QEMUFile *f, void *pv, size_t=
 size,
>> >                     const VMStateField *field)
>> >  {
>> >      int ret;
>> > +    Error *local_err =3D NULL;
>> >      const VMStateDescription *vmsd =3D field->vmsd;
>> >      int version_id =3D field->version_id;
>> >      void *tmp =3D g_malloc(size);
>> >=20=20
>> >      /* Writes the parent field which is at the start of the tmp */
>> >      *(void **)tmp =3D pv;
>> > -    ret =3D vmstate_load_state(f, vmsd, tmp, version_id);
>> > +    ret =3D vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
>> > +    if (ret < 0) {
>> > +        warn_report_err(local_err);
>> > +    }
>> >      g_free(tmp);
>> >      return ret;
>> >  }
>> > @@ -626,6 +631,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_=
t unused_size,
>> >                        const VMStateField *field)
>> >  {
>> >      int ret =3D 0;
>> > +    Error *local_err =3D NULL;
>> >      const VMStateDescription *vmsd =3D field->vmsd;
>> >      /* size of a QTAILQ element */
>> >      size_t size =3D field->size;
>> > @@ -649,8 +655,9 @@ static int get_qtailq(QEMUFile *f, void *pv, size_=
t unused_size,
>> >=20=20
>> >      while (qemu_get_byte(f)) {
>> >          elm =3D g_malloc(size);
>> > -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
>> > +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, &local_e=
rr);
>> >          if (ret) {
>> > +            warn_report_err(local_err);
>> >              return ret;
>> >          }
>> >          QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
>> > @@ -772,6 +779,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t=
 unused_size,
>> >      GTree *tree =3D *pval;
>> >      void *key, *val;
>> >      int ret =3D 0;
>> > +    Error *local_err =3D NULL;
>> >=20=20
>> >      /* in case of direct key, the key vmsd can be {}, ie. check field=
s */
>> >      if (!direct_key && version_id > key_vmsd->version_id) {
>> > @@ -803,18 +811,20 @@ static int get_gtree(QEMUFile *f, void *pv, size=
_t unused_size,
>> >              key =3D (void *)(uintptr_t)qemu_get_be64(f);
>> >          } else {
>> >              key =3D g_malloc0(key_size);
>> > -            ret =3D vmstate_load_state(f, key_vmsd, key, version_id);
>> > +            ret =3D vmstate_load_state(f, key_vmsd, key, version_id, =
&local_err);
>> >              if (ret) {
>> >                  error_report("%s : failed to load %s (%d)",
>> >                               field->name, key_vmsd->name, ret);
>> > +                warn_report_err(local_err);
>> >                  goto key_error;
>> >              }
>> >          }
>> >          val =3D g_malloc0(val_size);
>> > -        ret =3D vmstate_load_state(f, val_vmsd, val, version_id);
>> > +        ret =3D vmstate_load_state(f, val_vmsd, val, version_id, &loc=
al_err);
>> >          if (ret) {
>> >              error_report("%s : failed to load %s (%d)",
>> >                           field->name, val_vmsd->name, ret);
>> > +            warn_report_err(local_err);
>> >              goto val_error;
>> >          }
>> >          g_tree_insert(tree, key, val);
>> > @@ -872,6 +882,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t=
 unused_size,
>> >                       const VMStateField *field)
>> >  {
>> >      int ret =3D 0;
>> > +    Error *local_err =3D NULL;
>> >      const VMStateDescription *vmsd =3D field->vmsd;
>> >      /* size of a QLIST element */
>> >      size_t size =3D field->size;
>> > @@ -892,10 +903,11 @@ static int get_qlist(QEMUFile *f, void *pv, size=
_t unused_size,
>> >=20=20
>> >      while (qemu_get_byte(f)) {
>> >          elm =3D g_malloc(size);
>> > -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
>> > +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, &local_e=
rr);
>> >          if (ret) {
>> >              error_report("%s: failed to load %s (%d)", field->name,
>> >                           vmsd->name, ret);
>> > +            warn_report_err(local_err);
>> >              g_free(elm);
>> >              return ret;
>> >          }
>> > diff --git a/migration/vmstate.c b/migration/vmstate.c
>> > index 6108c7fe283a5013ce42ea9987723c489aef26a2..1cd609a1d598995af1e51d=
1f4d58d68133f1426d 100644
>> > --- a/migration/vmstate.c
>> > +++ b/migration/vmstate.c
>> > @@ -132,29 +132,34 @@ static void vmstate_handle_alloc(void *ptr, cons=
t VMStateField *field,
>> >  }
>> >=20=20
>> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>> > -                       void *opaque, int version_id)
>> > +                       void *opaque, int version_id, Error **errp)
>> >  {
>> > +    ERRP_GUARD();
>> >      const VMStateField *field =3D vmsd->fields;
>> >      int ret =3D 0;
>> >=20=20
>> >      trace_vmstate_load_state(vmsd->name, version_id);
>> >      if (version_id > vmsd->version_id) {
>> > -        error_report("%s: incoming version_id %d is too new "
>> > -                     "for local version_id %d",
>> > -                     vmsd->name, version_id, vmsd->version_id);
>> > +        error_setg(errp, "%s: incoming version_id %d is too new "
>> > +                   "for local version_id %d",
>> > +                   vmsd->name, version_id, vmsd->version_id);
>> >          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>> >          return -EINVAL;
>> >      }
>> >      if  (version_id < vmsd->minimum_version_id) {
>> > -        error_report("%s: incoming version_id %d is too old "
>> > -                     "for local minimum version_id  %d",
>> > -                     vmsd->name, version_id, vmsd->minimum_version_id=
);
>> > +        error_setg(errp, "%s: incoming version_id %d is too old "
>> > +                   "for local minimum version_id %d",
>> > +                   vmsd->name, version_id, vmsd->minimum_version_id);
>> >          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>> >          return -EINVAL;
>> >      }
>> >      if (vmsd->pre_load) {
>> >          ret =3D vmsd->pre_load(opaque);
>> >          if (ret) {
>> > +            error_setg(errp, "VM pre load failed for: '%s', "
>>=20
>> "VM" pre load is a little ambiguous. Simply "pre load" or "pre load
>> hook" is better.
> Sure, will do this.
>>=20
>> > +                       "version_id: %d, minimum version_id: %d, ret: =
%d",
>> > +                       vmsd->name, vmsd->version_id, vmsd->minimum_ve=
rsion_id,
>> > +                       ret);
>> >              return ret;
>> >          }
>> >      }
>> > @@ -192,13 +197,20 @@ int vmstate_load_state(QEMUFile *f, const VMStat=
eDescription *vmsd,
>> >=20=20
>> >                  if (inner_field->flags & VMS_STRUCT) {
>> >                      ret =3D vmstate_load_state(f, inner_field->vmsd, =
curr_elem,
>> > -                                             inner_field->vmsd->versi=
on_id);
>> > +                                             inner_field->vmsd->versi=
on_id,
>> > +                                             errp);
>> >                  } else if (inner_field->flags & VMS_VSTRUCT) {
>> >                      ret =3D vmstate_load_state(f, inner_field->vmsd, =
curr_elem,
>> > -                                             inner_field->struct_vers=
ion_id);
>> > +                                             inner_field->struct_vers=
ion_id,
>> > +                                             errp);
>> >                  } else {
>> >                      ret =3D inner_field->info->get(f, curr_elem, size,
>> >                                                   inner_field);
>> > +                    if (ret < 0) {
>> > +                        error_setg(errp,
>> > +                                   "Failed to get info for %s: %d",
>> > +                                   inner_field->name, ret);
>>=20
>> "get info" is not correct. This is the type-specific getter
>> invocation. Because the migration (for the most part) is a stream, each
>> type provides it's own getter which knows about the size of the field
>> and any particularities such as magic values. So:
>>=20
>> error_setg(errp, "Failed to load element of type %s for %s: %d",
>>            info->name, inner_field->name, ret);
> yes, will change the message. Thanks.
>>=20
>> > +                    }
>> >                  }
>> >=20=20
>> >                  /* If we used a fake temp field.. free it now */
>> > @@ -208,30 +220,42 @@ int vmstate_load_state(QEMUFile *f, const VMStat=
eDescription *vmsd,
>> >=20=20
>> >                  if (ret >=3D 0) {
>> >                      ret =3D qemu_file_get_error(f);
>> > +                    if (ret < 0) {
>> > +                        error_setg(errp, "Failed to load %s state: %d=
",
>> > +                                   vmsd->name, ret);
>>=20
>> We could go a little more specific here, it's useful to know whether the
>> error was on the transport side, rather than something logical with the
>> migrated data. I don't really care about the actual string, but one
>> suggestion is "stream error":
>>=20
>> error_setg(errp, "Failed to load %s state: stream error: %d",
>>            vmsd->name, ret);
> yes, will add stream error. Thanks.
>>=20
>> > +                    }
>> >                  }
>> >                  if (ret < 0) {
>> >                      qemu_file_set_error(f, ret);
>> > -                    error_report("Failed to load %s:%s", vmsd->name,
>> > -                                 field->name);
>> > +                    error_prepend(errp,
>> > +                                  "Failed to load %s:%s version_id: %=
d: ",
>>=20
>> Usage of : is inconsistent with below /
> Since we used error_prepend here, we need an extra space after the colon =
':'
> That way the next error string looks readable.

Right, that's not what I'm talking about. What's inconsistent is: %s:%s
vs. %s/%s

>>=20
>> > +                                   vmsd->name, field->name, vmsd->ver=
sion_id);
>> >                      trace_vmstate_load_field_error(field->name, ret);
>> >                      return ret;
>> >                  }
>> >              }
>> >          } else if (field->flags & VMS_MUST_EXIST) {
>> > -            error_report("Input validation failed: %s/%s",
>> > -                         vmsd->name, field->name);
>> > +            error_setg(errp, "Input validation failed: %s/%s version_=
id: %d",

here^


