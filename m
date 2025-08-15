Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7DCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umwZK-0004E4-UB; Fri, 15 Aug 2025 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umwZJ-0004Dn-0h
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 11:42:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umwZF-0003K2-Og
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 11:42:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1189F21224;
 Fri, 15 Aug 2025 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755272526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heCHhBV9ElHXhR66G9az+sxw+e4U7QOBVL07f+uuB4M=;
 b=U9o24XXU0kKyLVn48DJAQfAlVhX68XskPUUcDfujYAIiJr7HxKyAYiScfWEW4meoDwBPFD
 TH39lV7WRHCMn1PD+zTh9TP8yDVCxLFK30+ZNjogHstZ3VgNA8V6p1cbl/Y0wtjfCQrOW7
 iyjh9vSsWWPLlw7UmzIvMT9N8dN3yO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755272526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heCHhBV9ElHXhR66G9az+sxw+e4U7QOBVL07f+uuB4M=;
 b=8DAyRXue/kAZnNTM3cfI4ArcC05NP/ao+Dqm1KHObVS8JJtFVApmJf8sWwpL3+fyLmG8dR
 vrYt07JXN82OAcDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SZBcpvCY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zogtLd3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755272525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heCHhBV9ElHXhR66G9az+sxw+e4U7QOBVL07f+uuB4M=;
 b=SZBcpvCYUn8HwlKL29zqz9kzJcZAKYr9nYhcloVoH8NrcYxazBslXmBC6BwWdkAtSRbNkc
 6uXfMPU8RNwEFjmDi4s6HefU1Rz1HsNGK1cxNVlaZnd02RHA5pxT00MwokX+MlvzWXijyX
 vhSxeim5SOSmSGW4d1gOS7YyMlRoBL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755272525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heCHhBV9ElHXhR66G9az+sxw+e4U7QOBVL07f+uuB4M=;
 b=zogtLd3ehJzisKV/UVjh31MPnAToy9uPCTgQrrvqckCT5ZoaQIQyEJCunhTGGVg8x+qSb1
 CjesffDgJNy7PgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 063BD1368C;
 Fri, 15 Aug 2025 15:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AkcxAUxVn2gZHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 15:42:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
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
 qemu-arm@nongnu.org, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v11 02/27] migration: push Error **errp into
 vmstate_load_state()
In-Reply-To: <20250813-propagate_tpm_error-v11-2-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-2-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 12:41:50 -0300
Message-ID: <87o6sgzj5t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1189F21224
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[32];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Arun Menon <armenon@redhat.com> writes:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  hw/display/virtio-gpu.c     |  2 +-
>  hw/pci/pci.c                |  3 ++-
>  hw/s390x/virtio-ccw.c       |  2 +-
>  hw/scsi/spapr_vscsi.c       |  2 +-
>  hw/vfio/pci.c               |  3 ++-
>  hw/virtio/virtio-mmio.c     |  3 ++-
>  hw/virtio/virtio-pci.c      |  2 +-
>  hw/virtio/virtio.c          |  4 +--
>  include/migration/vmstate.h |  2 +-
>  migration/cpr.c             |  5 ++--
>  migration/savevm.c          |  6 +++--
>  migration/vmstate-types.c   | 22 ++++++++++++----
>  migration/vmstate.c         | 61 ++++++++++++++++++++++++++++++---------=
----
>  tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++++-=
------
>  ui/vdagent.c                |  3 ++-
>  15 files changed, 136 insertions(+), 47 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab=
10de2595a4bedf7 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
>      }
>=20=20
>      /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fat=
al);
>=20=20
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db=
2a7b6378a90e82b 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>  int pci_device_load(PCIDevice *s, QEMUFile *f)
>  {
>      int ret;
> -    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> +    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> +                             &error_fatal);
>      /* Restore the interrupt status bit. */
>      pci_update_irq_status(s);
>      return ret;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9=
deffc0cc303bcff 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, =
QEMUFile *f)
>  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error=
_fatal);
>  }
>=20=20
>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 20f70fb2729de78b9636a6b8c869695dab4f8902..8c896022d324f51962605288d=
6d6df1648c83cde 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequ=
est *sreq)
>      assert(!req->active);
>=20=20
>      memset(req, 0, sizeof(*req));
> -    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> +    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &erro=
r_fatal);
>      if (rc) {
>          fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->=
tag);
>          return NULL;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..0be54762cdcbdb4780b8228b0=
bdf7fc6bd74dd57 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2795,7 +2795,8 @@ static int vfio_pci_load_config(VFIODevice *vbasede=
v, QEMUFile *f)
>          old_addr[bar] =3D pdev->io_regions[bar].addr;
>      }
>=20=20
> -    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> +                             &error_fatal);
>      if (ret) {
>          return ret;
>      }
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde93366=
7ae8c309ab527d0 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -34,6 +34,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "trace.h"
> +#include "qapi/error.h"
>=20=20
>  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>  {
> @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *=
opaque, QEMUFile *f)
>  {
>      VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);
>=20=20
> -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_=
fatal);
>  }
>=20=20
>  static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec4=
1d92422d16bfc13 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d=
, QEMUFile *f)
>  {
>      VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
>=20=20
> -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_f=
atal);
>  }
>=20=20
>  static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e013fc254899c4e55cff1f76a6112a4..6bcafb338d1b5becadcacf092=
ba33a6ae4c3d194 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3327,14 +3327,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
>      }
>=20=20
>      if (vdc->vmsd) {
> -        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> +        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id, &erro=
r_fatal);
>          if (ret) {
>              return ret;
>          }
>      }
>=20=20
>      /* Subsections */
> -    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1, &error_fatal=
);
>      if (ret) {
>          return ret;
>      }
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594=
d9f88b32adfd674 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
>      }
>=20=20
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id);
> +                       void *opaque, int version_id, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, JSONWriter *vmdesc);
>  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *v=
msd,
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..bdb24736f44e91ba59b6e622a=
315597c97e7f64d 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -202,6 +202,7 @@ int cpr_state_save(MigrationChannel *channel, Error *=
*errp)
>=20=20
>  int cpr_state_load(MigrationChannel *channel, Error **errp)
>  {
> +    ERRP_GUARD();
>      int ret;
>      uint32_t v;
>      QEMUFile *f;
> @@ -233,9 +234,9 @@ int cpr_state_load(MigrationChannel *channel, Error *=
*errp)
>          return -ENOTSUP;
>      }
>=20=20
> -    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, err=
p);
>      if (ret) {
> -        error_setg(errp, "vmstate_load_state error %d", ret);
> +        error_prepend(errp, "vmstate_load_state error %d: ", ret);
>          qemu_fclose(f);
>          return ret;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296ae987d0c06ba6dafda63720205fecfd..cb64f2855d46aaa7c617b3e40=
79a2c9e566079b2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *=
se)
>      if (!se->vmsd) {         /* Old style */
>          return se->ops->load_state(f, se->opaque, se->load_version_id);
>      }
> -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_=
id);
> +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_=
id,
> +                              &error_fatal);
>  }
>=20=20
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>              error_report("Configuration section missing");
>              return -EINVAL;
>          }
> -        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm_st=
ate, 0);
> +        ret =3D vmstate_load_state(f, &vmstate_configuration, &savevm_st=
ate, 0,
> +                                 &error_fatal);
>=20=20
>          if (ret) {
>              return ret;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..f41670cc853c5b41ccc8def35=
4886a8e5c1451fd 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -19,6 +19,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "trace.h"
> +#include "qapi/error.h"
>=20=20
>  /* bool */
>=20=20
> @@ -543,13 +544,17 @@ static int get_tmp(QEMUFile *f, void *pv, size_t si=
ze,
>                     const VMStateField *field)
>  {
>      int ret;
> +    Error *local_err =3D NULL;
>      const VMStateDescription *vmsd =3D field->vmsd;
>      int version_id =3D field->version_id;
>      void *tmp =3D g_malloc(size);
>=20=20
>      /* Writes the parent field which is at the start of the tmp */
>      *(void **)tmp =3D pv;
> -    ret =3D vmstate_load_state(f, vmsd, tmp, version_id);
> +    ret =3D vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      g_free(tmp);
>      return ret;
>  }
> @@ -626,6 +631,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t u=
nused_size,
>                        const VMStateField *field)
>  {
>      int ret =3D 0;
> +    Error *local_err =3D NULL;
>      const VMStateDescription *vmsd =3D field->vmsd;
>      /* size of a QTAILQ element */
>      size_t size =3D field->size;
> @@ -649,8 +655,9 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t u=
nused_size,
>=20=20
>      while (qemu_get_byte(f)) {
>          elm =3D g_malloc(size);
> -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
> +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, &local_err);
>          if (ret) {
> +            warn_report_err(local_err);
>              return ret;
>          }
>          QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
> @@ -772,6 +779,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t un=
used_size,
>      GTree *tree =3D *pval;
>      void *key, *val;
>      int ret =3D 0;
> +    Error *local_err =3D NULL;
>=20=20
>      /* in case of direct key, the key vmsd can be {}, ie. check fields */
>      if (!direct_key && version_id > key_vmsd->version_id) {
> @@ -803,18 +811,20 @@ static int get_gtree(QEMUFile *f, void *pv, size_t =
unused_size,
>              key =3D (void *)(uintptr_t)qemu_get_be64(f);
>          } else {
>              key =3D g_malloc0(key_size);
> -            ret =3D vmstate_load_state(f, key_vmsd, key, version_id);
> +            ret =3D vmstate_load_state(f, key_vmsd, key, version_id, &lo=
cal_err);
>              if (ret) {
>                  error_report("%s : failed to load %s (%d)",
>                               field->name, key_vmsd->name, ret);
> +                warn_report_err(local_err);
>                  goto key_error;
>              }
>          }
>          val =3D g_malloc0(val_size);
> -        ret =3D vmstate_load_state(f, val_vmsd, val, version_id);
> +        ret =3D vmstate_load_state(f, val_vmsd, val, version_id, &local_=
err);
>          if (ret) {
>              error_report("%s : failed to load %s (%d)",
>                           field->name, val_vmsd->name, ret);
> +            warn_report_err(local_err);
>              goto val_error;
>          }
>          g_tree_insert(tree, key, val);
> @@ -872,6 +882,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t un=
used_size,
>                       const VMStateField *field)
>  {
>      int ret =3D 0;
> +    Error *local_err =3D NULL;
>      const VMStateDescription *vmsd =3D field->vmsd;
>      /* size of a QLIST element */
>      size_t size =3D field->size;
> @@ -892,10 +903,11 @@ static int get_qlist(QEMUFile *f, void *pv, size_t =
unused_size,
>=20=20
>      while (qemu_get_byte(f)) {
>          elm =3D g_malloc(size);
> -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
> +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, &local_err);
>          if (ret) {
>              error_report("%s: failed to load %s (%d)", field->name,
>                           vmsd->name, ret);
> +            warn_report_err(local_err);
>              g_free(elm);
>              return ret;
>          }
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 6108c7fe283a5013ce42ea9987723c489aef26a2..1cd609a1d598995af1e51d1f4=
d58d68133f1426d 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -132,29 +132,34 @@ static void vmstate_handle_alloc(void *ptr, const V=
MStateField *field,
>  }
>=20=20
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id)
> +                       void *opaque, int version_id, Error **errp)
>  {
> +    ERRP_GUARD();
>      const VMStateField *field =3D vmsd->fields;
>      int ret =3D 0;
>=20=20
>      trace_vmstate_load_state(vmsd->name, version_id);
>      if (version_id > vmsd->version_id) {
> -        error_report("%s: incoming version_id %d is too new "
> -                     "for local version_id %d",
> -                     vmsd->name, version_id, vmsd->version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too new "
> +                   "for local version_id %d",
> +                   vmsd->name, version_id, vmsd->version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
>      if  (version_id < vmsd->minimum_version_id) {
> -        error_report("%s: incoming version_id %d is too old "
> -                     "for local minimum version_id  %d",
> -                     vmsd->name, version_id, vmsd->minimum_version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too old "
> +                   "for local minimum version_id %d",
> +                   vmsd->name, version_id, vmsd->minimum_version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
>      if (vmsd->pre_load) {
>          ret =3D vmsd->pre_load(opaque);
>          if (ret) {
> +            error_setg(errp, "VM pre load failed for: '%s', "

"VM" pre load is a little ambiguous. Simply "pre load" or "pre load
hook" is better.

> +                       "version_id: %d, minimum version_id: %d, ret: %d",
> +                       vmsd->name, vmsd->version_id, vmsd->minimum_versi=
on_id,
> +                       ret);
>              return ret;
>          }
>      }
> @@ -192,13 +197,20 @@ int vmstate_load_state(QEMUFile *f, const VMStateDe=
scription *vmsd,
>=20=20
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret =3D vmstate_load_state(f, inner_field->vmsd, cur=
r_elem,
> -                                             inner_field->vmsd->version_=
id);
> +                                             inner_field->vmsd->version_=
id,
> +                                             errp);
>                  } else if (inner_field->flags & VMS_VSTRUCT) {
>                      ret =3D vmstate_load_state(f, inner_field->vmsd, cur=
r_elem,
> -                                             inner_field->struct_version=
_id);
> +                                             inner_field->struct_version=
_id,
> +                                             errp);
>                  } else {
>                      ret =3D inner_field->info->get(f, curr_elem, size,
>                                                   inner_field);
> +                    if (ret < 0) {
> +                        error_setg(errp,
> +                                   "Failed to get info for %s: %d",
> +                                   inner_field->name, ret);

"get info" is not correct. This is the type-specific getter
invocation. Because the migration (for the most part) is a stream, each
type provides it's own getter which knows about the size of the field
and any particularities such as magic values. So:

error_setg(errp, "Failed to load element of type %s for %s: %d",
           info->name, inner_field->name, ret);

> +                    }
>                  }
>=20=20
>                  /* If we used a fake temp field.. free it now */
> @@ -208,30 +220,42 @@ int vmstate_load_state(QEMUFile *f, const VMStateDe=
scription *vmsd,
>=20=20
>                  if (ret >=3D 0) {
>                      ret =3D qemu_file_get_error(f);
> +                    if (ret < 0) {
> +                        error_setg(errp, "Failed to load %s state: %d",
> +                                   vmsd->name, ret);

We could go a little more specific here, it's useful to know whether the
error was on the transport side, rather than something logical with the
migrated data. I don't really care about the actual string, but one
suggestion is "stream error":

error_setg(errp, "Failed to load %s state: stream error: %d",
           vmsd->name, ret);

> +                    }
>                  }
>                  if (ret < 0) {
>                      qemu_file_set_error(f, ret);
> -                    error_report("Failed to load %s:%s", vmsd->name,
> -                                 field->name);
> +                    error_prepend(errp,
> +                                  "Failed to load %s:%s version_id: %d: =
",

Usage of : is inconsistent with below /

> +                                   vmsd->name, field->name, vmsd->versio=
n_id);
>                      trace_vmstate_load_field_error(field->name, ret);
>                      return ret;
>                  }
>              }
>          } else if (field->flags & VMS_MUST_EXIST) {
> -            error_report("Input validation failed: %s/%s",
> -                         vmsd->name, field->name);
> +            error_setg(errp, "Input validation failed: %s/%s version_id:=
 %d",

here

> +                       vmsd->name, field->name, vmsd->version_id);
>              return -1;
>          }
>          field++;
>      }
>      assert(field->flags =3D=3D VMS_END);
> -    ret =3D vmstate_subsection_load(f, vmsd, opaque, &error_fatal);
> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, errp);
>      if (ret !=3D 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
>      if (vmsd->post_load) {
>          ret =3D vmsd->post_load(opaque, version_id);
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "VM Post load failed for: %s, version_id: %d, "
> +                       "minimum_version: %d, ret: %d",
> +                       vmsd->name, vmsd->version_id, vmsd->minimum_versi=
on_id,
> +                       ret);
> +        }
>      }
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
>      return ret;
> @@ -568,6 +592,7 @@ vmstate_get_subsection(const VMStateDescription * con=
st *sub,
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription=
 *vmsd,
>                                     void *opaque, Error **errp)
>  {
> +    ERRP_GUARD();
>      trace_vmstate_subsection_load(vmsd->name);
>=20=20
>      while (qemu_peek_byte(f, 0) =3D=3D QEMU_VM_SUBSECTION) {
> @@ -607,12 +632,12 @@ static int vmstate_subsection_load(QEMUFile *f, con=
st VMStateDescription *vmsd,
>          qemu_file_skip(f, len); /* idstr */
>          version_id =3D qemu_get_be32(f);
>=20=20
> -        ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id);
> +        ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id, errp=
);
>          if (ret) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child=
)");
> -            error_setg(errp,
> -                       "Loading VM subsection '%s' in '%s' failed: %d",
> -                       idstr, vmsd->name, ret);
> +            error_prepend(errp,
> +                          "Loading VM subsection '%s' in '%s' failed: %d=
: ",
> +                          idstr, vmsd->name, ret);
>              return ret;
>          }
>      }
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 63f28f26f45691a70936d33e7341d16477a3471f..cfab58c7f45ba50f70af164c3=
e58b01aaf9cc656 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -30,6 +30,7 @@
>  #include "../migration/savevm.h"
>  #include "qemu/module.h"
>  #include "io/channel-file.h"
> +#include "qapi/error.h"
>=20=20
>  static int temp_fd;
>=20=20
> @@ -108,14 +109,16 @@ static int load_vmstate_one(const VMStateDescriptio=
n *desc, void *obj,
>  {
>      QEMUFile *f;
>      int ret;
> +    Error *local_err =3D NULL;
>=20=20
>      f =3D open_test_file(true);
>      qemu_put_buffer(f, wire, size);
>      qemu_fclose(f);
>=20=20
>      f =3D open_test_file(false);
> -    ret =3D vmstate_load_state(f, desc, obj, version);
> +    ret =3D vmstate_load_state(f, desc, obj, version, &local_err);
>      if (ret) {
> +        warn_report_err(local_err);
>          g_assert(qemu_file_get_error(f));
>      } else{
>          g_assert(!qemu_file_get_error(f));
> @@ -355,6 +358,8 @@ static const VMStateDescription vmstate_versioned =3D=
 {
>=20=20
>  static void test_load_v1(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      uint8_t buf[] =3D {
>          0, 0, 0, 10,             /* a */
>          0, 0, 0, 30,             /* c */
> @@ -365,7 +370,10 @@ static void test_load_v1(void)
>=20=20
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .b =3D 200, .e =3D 500, .f =3D 600 };
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
> +    ret =3D vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &lo=
cal_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 200);
> @@ -378,6 +386,8 @@ static void test_load_v1(void)
>=20=20
>  static void test_load_v2(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      uint8_t buf[] =3D {
>          0, 0, 0, 10,             /* a */
>          0, 0, 0, 20,             /* b */
> @@ -391,7 +401,10 @@ static void test_load_v2(void)
>=20=20
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj;
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
> +    ret =3D vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &lo=
cal_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
>      g_assert_cmpint(obj.c, =3D=3D, 30);
> @@ -467,6 +480,8 @@ static void test_save_skip(void)
>=20=20
>  static void test_load_noskip(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      uint8_t buf[] =3D {
>          0, 0, 0, 10,             /* a */
>          0, 0, 0, 20,             /* b */
> @@ -480,7 +495,10 @@ static void test_load_noskip(void)
>=20=20
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .skip_c_e =3D false };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    ret =3D vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &loc=
al_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
> @@ -493,6 +511,8 @@ static void test_load_noskip(void)
>=20=20
>  static void test_load_skip(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      uint8_t buf[] =3D {
>          0, 0, 0, 10,             /* a */
>          0, 0, 0, 20,             /* b */
> @@ -504,7 +524,10 @@ static void test_load_skip(void)
>=20=20
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .skip_c_e =3D true, .c =3D 300, .e =3D 500 };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    ret =3D vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &loc=
al_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
> @@ -744,6 +767,8 @@ static void test_save_q(void)
>=20=20
>  static void test_load_q(void)
>  {
> +    int ret;
> +    Error *local_err =3D NULL;
>      TestQtailq obj_q =3D {
>          .i16 =3D -512,
>          .i32 =3D 70000,
> @@ -773,7 +798,10 @@ static void test_load_q(void)
>      TestQtailq tgt;
>=20=20
>      QTAILQ_INIT(&tgt.q);
> -    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
> +    ret =3D vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      char eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(tgt.i16, =3D=3D, obj_q.i16);
> @@ -1115,6 +1143,8 @@ static void diff_iommu(TestGTreeIOMMU *iommu1, Test=
GTreeIOMMU *iommu2)
>=20=20
>  static void test_gtree_load_domain(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      TestGTreeDomain *dest_domain =3D g_new0(TestGTreeDomain, 1);
>      TestGTreeDomain *orig_domain =3D create_first_domain();
>      QEMUFile *fload, *fsave;
> @@ -1127,7 +1157,11 @@ static void test_gtree_load_domain(void)
>=20=20
>      fload =3D open_test_file(false);
>=20=20
> -    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
> +    ret =3D vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
> +                             &local_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(orig_domain->id, =3D=3D, dest_domain->id);
> @@ -1230,6 +1264,8 @@ static void test_gtree_save_iommu(void)
>=20=20
>  static void test_gtree_load_iommu(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      TestGTreeIOMMU *dest_iommu =3D g_new0(TestGTreeIOMMU, 1);
>      TestGTreeIOMMU *orig_iommu =3D create_iommu();
>      QEMUFile *fsave, *fload;
> @@ -1241,7 +1277,10 @@ static void test_gtree_load_iommu(void)
>      qemu_fclose(fsave);
>=20=20
>      fload =3D open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
> +    ret =3D vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &lo=
cal_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(orig_iommu->id, =3D=3D, dest_iommu->id);
> @@ -1363,6 +1402,8 @@ static void test_save_qlist(void)
>=20=20
>  static void test_load_qlist(void)
>  {
> +    Error *local_err =3D NULL;
> +    int ret;
>      QEMUFile *fsave, *fload;
>      TestQListContainer *orig_container =3D alloc_container();
>      TestQListContainer *dest_container =3D g_new0(TestQListContainer, 1);
> @@ -1376,7 +1417,11 @@ static void test_load_qlist(void)
>      qemu_fclose(fsave);
>=20=20
>      fload =3D open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
> +    ret =3D vmstate_load_state(fload, &vmstate_container, dest_container=
, 1,
> +                             &local_err);
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index c0746fe5b168fdc7aeb4866de2ba0c3387566649..b699658c06cc3765bae2e5eff=
a34f66b7cfd4ead 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -1008,7 +1008,8 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t=
 size,
>=20=20
>      vdagent_clipboard_peer_register(vd);
>=20=20
> -    ret =3D vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
> +    ret =3D vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
> +                             &error_fatal);
>      if (ret) {
>          return ret;
>      }

Unreachable?

