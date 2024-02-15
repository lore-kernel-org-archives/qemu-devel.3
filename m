Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B1BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabDr-0005QA-B1; Thu, 15 Feb 2024 07:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rabDn-0005Pr-8k
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:52:11 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rabDg-0003uo-1U
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:52:09 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so813900a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 04:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708001400; x=1708606200;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E/rLBaguIXEtJ9muAzOpQrw2K+x/yS9ZQ72YCHt2WuQ=;
 b=LYzrG/+OKpe+dqrUDKC/DyiTxZhwPXudvKNTYIrPAPCjwzsimxYe9iv7MMa00IlwZO
 sGOK8Ti1MM7rH+NMIgXU/STm45+KgPV3gqR4ocl4XxVGlUTRIYrOeb6nKzqzYQgGWtJA
 b3s456gLzGW1uMaOjVmqjSB1HjAQNz1qEEhvAgONm7powJnnGn1xgdqLOYBxjAW2e/h3
 2DtwEj4SSg1FWrhCXOvknCDZSwJizAeaJhPsEqn0w2wQfuh2z7icsREDI/nXCdRlVGcD
 uwPaVnvLeknkcU6ntLroE8Vrau8muPRgnyQEAsnl0AAcc5tAv8LYzF1dxaoidV4ihGEz
 lO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708001400; x=1708606200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/rLBaguIXEtJ9muAzOpQrw2K+x/yS9ZQ72YCHt2WuQ=;
 b=OsEbS19G9y27xXYh0dcsfmECmuW0i/lZa8u/OgxtBgojPGyn9v122dSPcgl5QqNDJk
 bpJhG0ZACGsSM7F5IOSoDngRGQcT3nOXKafXMyuziasl7WWtgEwmknvfC0r7evdoLWC0
 ktjaZJ1s6HFMX1LBH0EyyihvZTtBjJE80jbjGhDcmqbphfLeGHPu8muwydrm2o7T3AF5
 ImQlHC7oB3sY8G0T+nonPHl4ddioxtpfcRkYbXaU6hHI08pyuJSbwbgF3+3G6OMvD2Qx
 tMU6EqprdJX9RpT2e8VryHmcI8RwkjrDByyRxbwHFGdLZS2tWCPXqx6qMcyLBTC/7u4c
 /7/A==
X-Gm-Message-State: AOJu0YxQAGXwK3PNhfBrq4QbTmp5p2Dr02IgyfZFH9HNJ4illMGjkYIw
 2gWJm8cUR8nGq/vm25pL3tD57b4AIZx7g5gDNLMSRxrR0QkRAWtSbUZi3/reVF87RETPPbFgufu
 +twVdjp9l+fsn9mki35IDJJGuYXNZ+C3DdTO4AQ==
X-Google-Smtp-Source: AGHT+IFkJ8Q//mZ4xnBheKQnuzT9ZjW8uiVH8BsRRfm6cgGfaRiZa7GC95KZTsw7d5zyAzF7KZykC5Zs0uj5vC6wMOo=
X-Received: by 2002:a17:90a:4381:b0:298:c136:2ffc with SMTP id
 r1-20020a17090a438100b00298c1362ffcmr1276124pjg.45.1708001397917; Thu, 15 Feb
 2024 04:49:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706883915.git.yong.huang@smartx.com>
 <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
 <20240213052542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213052542-mutt-send-email-mst@kernel.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 15 Feb 2024 20:49:41 +0800
Message-ID: <CAK9dgmYu04F37==Ye4VgtmZjzh8-YXQ61FygtG5o_f0E=e6cmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to numeric
 encoding
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009960b106116b107f"
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--0000000000009960b106116b107f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Fri, Feb 02, 2024 at 10:32:15PM +0800, Hyman Huang wrote:
> > x-query-virtio-status returns several sets of virtio feature and
> > status flags.  It goes back to v7.2.0.
> >
> > In the initial commit 90c066cd682 (qmp: add QMP command
> > x-query-virtio-status), we returned them as numbers, using virtio's
> > well-known binary encoding.
> >
> > The next commit f3034ad71fc (qmp: decode feature & status bits in
> > virtio-status) replaced the numbers by objects.  The objects represent
> > bits QEMU knows symbolically, and any unknown bits numerically just lik=
e
> > before.
> >
> > Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command
> > "info virtio" (and a few more, which aren't relevant here).
> >
> > The symbolic representation uses lists of strings.  The string format i=
s
> > undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
> > explanation".
> >
> > This symbolic representation is nice for humans.  Machines it can save
> > the trouble of decoding virtio's well-known binary encoding.
> >
> > However, we sometimes want to compare features and status bits without
> > caring for their exact meaning.  Say we want to verify the correctness
> > of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can us=
e
> > QMP command x-query-virtio-status to retrieve vhost-user net device
> > features, and the "ovs-vsctl list interface" command to retrieve
> > interface features.  Without commit f3034ad71fc, we could then simply
> > compare the numbers.  With this commit, we first have to map from the
> > strings back to the numeric encoding.
> >
> > Revert the decoding for QMP, but keep it for HMP.
>
> Is there a way to maybe have both decoded and numerical one?
>


What if the next patch went back to this implementation in the following
patch? All you need to do is add a matching xxx_bits entry for each feature
and status.

https://patchew.org/QEMU/cover.1700319559.git.yong.huang@smartx.com/3c7161a=
47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com/


E.g. I mostly use QMP even when I read it myself.
>

Thus, it is recommended that both numerical and decoded types be kept for
QMP; this approach can be at odds with what was previously discussed.
What do you think about this, Markus?



> > This makes the QMP command easier to use for use cases where we
> > don't need to decode, like the comparison above.  For use cases
> > where we need to decode, we replace parsing undocumented strings by
> > decoding virtio's well-known binary encoding.
> >
> > Incompatible change; acceptable because x-query-virtio-status does
> > comes without a stability promise.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  hw/virtio/virtio-hmp-cmds.c |  25 +++--
> >  hw/virtio/virtio-qmp.c      |  23 ++---
> >  qapi/virtio.json            | 192 ++++--------------------------------
> >  3 files changed, 45 insertions(+), 195 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> > index 477c97dea2..721c630ab0 100644
> > --- a/hw/virtio/virtio-hmp-cmds.c
> > +++ b/hw/virtio/virtio-hmp-cmds.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "virtio-qmp.h"
> >  #include "monitor/hmp.h"
> >  #include "monitor/monitor.h"
> >  #include "qapi/qapi-commands-virtio.h"
> > @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >      monitor_printf(mon, "  endianness:              %s\n",
> >                     s->device_endian);
> >      monitor_printf(mon, "  status:\n");
> > -    hmp_virtio_dump_status(mon, s->status);
> > +    hmp_virtio_dump_status(mon,
> > +        qmp_decode_status(s->status));
> >      monitor_printf(mon, "  Guest features:\n");
> > -    hmp_virtio_dump_features(mon, s->guest_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->guest_features));
> >      monitor_printf(mon, "  Host features:\n");
> > -    hmp_virtio_dump_features(mon, s->host_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->host_features));
> >      monitor_printf(mon, "  Backend features:\n");
> > -    hmp_virtio_dump_features(mon, s->backend_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->backend_features));
> >
> >      if (s->vhost_dev) {
> >          monitor_printf(mon, "  VHost:\n");
> > @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >          monitor_printf(mon, "    log_size:       %"PRId64"\n",
> >                         s->vhost_dev->log_size);
> >          monitor_printf(mon, "    Features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id, s->vhost_dev->features))=
;
> >          monitor_printf(mon, "    Acked features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id,
> s->vhost_dev->acked_features));
> >          monitor_printf(mon, "    Backend features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id,
> s->vhost_dev->backend_features));
> >          monitor_printf(mon, "    Protocol features:\n");
> > -        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features=
);
> > +        hmp_virtio_dump_protocols(mon,
> > +            qmp_decode_protocols(s->vhost_dev->protocol_features));
> >      }
> >
> >      qapi_free_VirtioStatus(s);
> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> > index 1dd96ed20f..1660c17653 100644
> > --- a/hw/virtio/virtio-qmp.c
> > +++ b/hw/virtio/virtio-qmp.c
> > @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      status->name =3D g_strdup(vdev->name);
> >      status->device_id =3D vdev->device_id;
> >      status->vhost_started =3D vdev->vhost_started;
> > -    status->guest_features =3D qmp_decode_features(vdev->device_id,
> > -                                                 vdev->guest_features)=
;
> > -    status->host_features =3D qmp_decode_features(vdev->device_id,
> > -                                                vdev->host_features);
> > -    status->backend_features =3D qmp_decode_features(vdev->device_id,
> > -
>  vdev->backend_features);
> > +    status->guest_features =3D vdev->guest_features;
> > +    status->host_features =3D vdev->host_features;
> > +    status->backend_features =3D vdev->backend_features;
> >
> >      switch (vdev->device_endian) {
> >      case VIRTIO_DEVICE_ENDIAN_LITTLE:
> > @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char
> *path, Error **errp)
> >      }
> >
> >      status->num_vqs =3D virtio_get_num_queues(vdev);
> > -    status->status =3D qmp_decode_status(vdev->status);
> > +    status->status =3D vdev->status;
> >      status->isr =3D vdev->isr;
> >      status->queue_sel =3D vdev->queue_sel;
> >      status->vm_running =3D vdev->vm_running;
> > @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r
> *path, Error **errp)
> >          status->vhost_dev->n_tmp_sections =3D hdev->n_tmp_sections;
> >          status->vhost_dev->nvqs =3D hdev->nvqs;
> >          status->vhost_dev->vq_index =3D hdev->vq_index;
> > -        status->vhost_dev->features =3D
> > -            qmp_decode_features(vdev->device_id, hdev->features);
> > -        status->vhost_dev->acked_features =3D
> > -            qmp_decode_features(vdev->device_id, hdev->acked_features)=
;
> > -        status->vhost_dev->backend_features =3D
> > -            qmp_decode_features(vdev->device_id,
> hdev->backend_features);
> > -        status->vhost_dev->protocol_features =3D
> > -            qmp_decode_protocols(hdev->protocol_features);
> > +        status->vhost_dev->features =3D hdev->features;
> > +        status->vhost_dev->acked_features =3D hdev->acked_features;
> > +        status->vhost_dev->backend_features =3D hdev->backend_features=
;
> > +        status->vhost_dev->protocol_features =3D hdev->protocol_featur=
es;
> >          status->vhost_dev->max_queues =3D hdev->max_queues;
> >          status->vhost_dev->backend_cap =3D hdev->backend_cap;
> >          status->vhost_dev->log_enabled =3D hdev->log_enabled;
> > diff --git a/qapi/virtio.json b/qapi/virtio.json
> > index 19c7c36e36..26516fb29c 100644
> > --- a/qapi/virtio.json
> > +++ b/qapi/virtio.json
> > @@ -102,10 +102,10 @@
> >              'n-tmp-sections': 'int',
> >              'nvqs': 'uint32',
> >              'vq-index': 'int',
> > -            'features': 'VirtioDeviceFeatures',
> > -            'acked-features': 'VirtioDeviceFeatures',
> > -            'backend-features': 'VirtioDeviceFeatures',
> > -            'protocol-features': 'VhostDeviceProtocols',
> > +            'features': 'uint64',
> > +            'acked-features': 'uint64',
> > +            'backend-features': 'uint64',
> > +            'protocol-features': 'uint64',
> >              'max-queues': 'uint64',
> >              'backend-cap': 'uint64',
> >              'log-enabled': 'bool',
> > @@ -170,11 +170,11 @@
> >              'device-id': 'uint16',
> >              'vhost-started': 'bool',
> >              'device-endian': 'str',
> > -            'guest-features': 'VirtioDeviceFeatures',
> > -            'host-features': 'VirtioDeviceFeatures',
> > -            'backend-features': 'VirtioDeviceFeatures',
> > +            'guest-features': 'uint64',
> > +            'host-features': 'uint64',
> > +            'backend-features': 'uint64',
> >              'num-vqs': 'int',
> > -            'status': 'VirtioDeviceStatus',
> > +            'status': 'uint8',
> >              'isr': 'uint8',
> >              'queue-sel': 'uint16',
> >              'vm-running': 'bool',
> > @@ -217,41 +217,14 @@
> >  #          "name": "virtio-crypto",
> >  #          "started": true,
> >  #          "device-id": 20,
> > -#          "backend-features": {
> > -#              "transports": [],
> > -#              "dev-features": []
> > -#          },
> > +#          "backend-features": 0,
> >  #          "start-on-kick": false,
> >  #          "isr": 1,
> >  #          "broken": false,
> > -#          "status": {
> > -#              "statuses": [
> > -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> > -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> > -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> > -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> > -#              ]
> > -#          },
> > +#          "status": 15,
> >  #          "num-vqs": 2,
> > -#          "guest-features": {
> > -#              "dev-features": [],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> > -#              ]
> > -#          },
> > -#          "host-features": {
> > -#              "unknown-dev-features": 1073741824,
> > -#              "dev-features": [],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#              ]
> > -#          },
> > +#          "guest-features": 5100273664,
> > +#          "host-features": 6325010432,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 1,
> > @@ -279,147 +252,22 @@
> >  #              "max-queues": 1,
> >  #              "backend-cap": 2,
> >  #              "log-size": 0,
> > -#              "backend-features": {
> > -#                  "dev-features": [],
> > -#                  "transports": []
> > -#              },
> > +#              "backend-features": 0,
> >  #              "nvqs": 2,
> > -#              "protocol-features": {
> > -#                  "protocols": []
> > -#              },
> > +#              "protocol-features": 0,
> >  #              "vq-index": 0,
> >  #              "log-enabled": false,
> > -#              "acked-features": {
> > -#                  "dev-features": [
> > -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge
> receive buffers"
> > -#                  ],
> > -#                  "transports": [
> > -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event
> fields enabled",
> > -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect
> descriptors supported",
> > -#                      "VIRTIO_F_VERSION_1: Device compliant for v1
> spec (legacy)"
> > -#                  ]
> > -#              },
> > -#              "features": {
> > -#                  "dev-features": [
> > -#                      "VHOST_F_LOG_ALL: Logging write descriptors
> supported",
> > -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge
> receive buffers"
> > -#                  ],
> > -#                  "transports": [
> > -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event
> fields enabled",
> > -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect
> descriptors supported",
> > -#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on
> IOMMU platform",
> > -#                      "VIRTIO_F_VERSION_1: Device compliant for v1
> spec (legacy)",
> > -#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary
> desc. layouts",
> > -#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device
> runs out of avail. descs. on VQ"
> > -#                  ]
> > -#              }
> > -#          },
> > -#          "backend-features": {
> > -#              "dev-features": [
> > -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protoco=
l
> features negotiation supported",
> > -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#              ]
> > +#              "acked-features": 5100306432,
> > +#              "features": 13908344832,
> >  #          },
> > +#          "backend-features": 6337593319,
> >  #          "start-on-kick": false,
> >  #          "isr": 1,
> >  #          "broken": false,
> > -#          "status": {
> > -#              "statuses": [
> > -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device
> found",
> > -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with
> device",
> > -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation
> complete",
> > -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> > -#              ]
> > -#          },
> > +#          "status": 15,
> >  #          "num-vqs": 3,
> > -#          "guest-features": {
> > -#              "dev-features": [
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)"
> > -#             ]
> > -#          },
> > -#          "host-features": {
> > -#              "dev-features": [
> > -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protoco=
l
> features negotiation supported",
> > -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set throug=
h
> control channel",
> > -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending
> gratuitous packets supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN
> filtering supported",
> > -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode
> supported",
> > -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> > -#                  "VIRTIO_NET_F_STATUS: Configuration status field
> available",
> > -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive
> buffers",
> > -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> > -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with
> ECN",
> > -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> > -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> > -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> > -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO wit=
h
> ECN",
> > -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"=
,
> > -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"=
,
> > -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> > -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel
> offloading reconfig. supported",
> > -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets
> with partial checksum supported",
> > -#                  "VIRTIO_NET_F_CSUM: Device handling packets with
> partial checksum supported"
> > -#              ],
> > -#              "transports": [
> > -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event field=
s
> enabled",
> > -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors
> supported",
> > -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec
> (legacy)",
> > -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc=
.
> layouts",
> > -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs
> out of avail. descs. on VQ"
> > -#             ]
> > -#          },
> > +#          "guest-features": 5111807911,
> > +#          "host-features": 6337593319,
> >  #          "use-guest-notifier-mask": true,
> >  #          "vm-running": true,
> >  #          "queue-sel": 2,
> > --
> > 2.31.1
>
>

--=20
Best regards

--0000000000009960b106116b107f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 13, 20=
24 at 6:26=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.c=
om">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Fri, Feb 02,=
 2024 at 10:32:15PM +0800, Hyman Huang wrote:<br>
&gt; x-query-virtio-status returns several sets of virtio feature and<br>
&gt; status flags.=C2=A0 It goes back to v7.2.0.<br>
&gt; <br>
&gt; In the initial commit 90c066cd682 (qmp: add QMP command<br>
&gt; x-query-virtio-status), we returned them as numbers, using virtio&#39;=
s<br>
&gt; well-known binary encoding.<br>
&gt; <br>
&gt; The next commit f3034ad71fc (qmp: decode feature &amp; status bits in<=
br>
&gt; virtio-status) replaced the numbers by objects.=C2=A0 The objects repr=
esent<br>
&gt; bits QEMU knows symbolically, and any unknown bits numerically just li=
ke<br>
&gt; before.<br>
&gt; <br>
&gt; Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command=
<br>
&gt; &quot;info virtio&quot; (and a few more, which aren&#39;t relevant her=
e).<br>
&gt; <br>
&gt; The symbolic representation uses lists of strings.=C2=A0 The string fo=
rmat is<br>
&gt; undocumented.=C2=A0 The strings look like &quot;WELL_KNOWN_SYMBOL: hum=
an readable<br>
&gt; explanation&quot;.<br>
&gt; <br>
&gt; This symbolic representation is nice for humans.=C2=A0 Machines it can=
 save<br>
&gt; the trouble of decoding virtio&#39;s well-known binary encoding.<br>
&gt; <br>
&gt; However, we sometimes want to compare features and status bits without=
<br>
&gt; caring for their exact meaning.=C2=A0 Say we want to verify the correc=
tness<br>
&gt; of the virtio negotiation between guest, QEMU, and OVS-DPDK.=C2=A0 We =
can use<br>
&gt; QMP command x-query-virtio-status to retrieve vhost-user net device<br=
>
&gt; features, and the &quot;ovs-vsctl list interface&quot; command to retr=
ieve<br>
&gt; interface features.=C2=A0 Without commit f3034ad71fc, we could then si=
mply<br>
&gt; compare the numbers.=C2=A0 With this commit, we first have to map from=
 the<br>
&gt; strings back to the numeric encoding.<br>
&gt; <br>
&gt; Revert the decoding for QMP, but keep it for HMP.<br>
<br>
Is there a way to maybe have both decoded and numerical one?<br></blockquot=
e><div><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">What if the next patc=
h went back to this implementation in the following patch? All you need to =
do is add a matching xxx_bits entry for each feature and status.</div><div =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif"><a href=3D"https://patchew.org/QEMU/cover.17=
00319559.git.yong.huang@smartx.com/3c7161a47b141af04b1f8272e8e24c5faa46ddb2=
.1700319559.git.yong.huang@smartx.com/">https://patchew.org/QEMU/cover.1700=
319559.git.yong.huang@smartx.com/3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1=
700319559.git.yong.huang@smartx.com/</a><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex">
E.g. I mostly use QMP even when I read it myself.<br></blockquote><div><br>=
</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">Thus, it is recommended that both numerical and decoded =
types be kept for QMP; this approach can be at odds with what was previousl=
y discussed.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">What do you think about this, Markus?<=
br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif"><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; This makes the QMP command easier to use for use cases where we<br>
&gt; don&#39;t need to decode, like the comparison above.=C2=A0 For use cas=
es<br>
&gt; where we need to decode, we replace parsing undocumented strings by<br=
>
&gt; decoding virtio&#39;s well-known binary encoding.<br>
&gt; <br>
&gt; Incompatible change; acceptable because x-query-virtio-status does<br>
&gt; comes without a stability promise.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/virtio-hmp-cmds.c |=C2=A0 25 +++--<br>
&gt;=C2=A0 hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++---<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 192 =
++++--------------------------------<br>
&gt;=C2=A0 3 files changed, 45 insertions(+), 195 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c=
<br>
&gt; index 477c97dea2..721c630ab0 100644<br>
&gt; --- a/hw/virtio/virtio-hmp-cmds.c<br>
&gt; +++ b/hw/virtio/virtio-hmp-cmds.c<br>
&gt; @@ -6,6 +6,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;virtio-qmp.h&quot;<br>
&gt;=C2=A0 #include &quot;monitor/hmp.h&quot;<br>
&gt;=C2=A0 #include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qapi-commands-virtio.h&quot;<br>
&gt; @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 endianness:=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;device_endian);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 status:\n&quot;);=
<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_status(mon, s-&gt;status);<br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_status(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_status(s-&gt;status));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Guest features:\n=
&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;guest_features);<br=
>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;guest_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Host features:\n&=
quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;host_features);<br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;host_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 Backend features:=
\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;backend_features);<=
br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;backend_features));<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;vhost_dev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 VHo=
st:\n&quot;);<br>
&gt; @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 log_size:=C2=A0 =C2=A0 =C2=A0 =C2=A0%&quot;PRId64&quot;\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;vhost_dev-&gt;log_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Acked features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;acked_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;acked_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Backend features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;backend_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;backend_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 monitor_printf(mon, &quot;=C2=A0 =C2=
=A0 Protocol features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_protocols(mon, s-&gt;vhos=
t_dev-&gt;protocol_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_protocols(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_protocols(s-&gt;=
vhost_dev-&gt;protocol_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qapi_free_VirtioStatus(s);<br>
&gt; diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c<br>
&gt; index 1dd96ed20f..1660c17653 100644<br>
&gt; --- a/hw/virtio/virtio-qmp.c<br>
&gt; +++ b/hw/virtio/virtio-qmp.c<br>
&gt; @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const cha=
r *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;name =3D g_strdup(vdev-&gt;name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;device_id =3D vdev-&gt;device_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_started =3D vdev-&gt;vhost_starte=
d;<br>
&gt; -=C2=A0 =C2=A0 status-&gt;guest_features =3D qmp_decode_features(vdev-=
&gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;guest_features);<br>
&gt; -=C2=A0 =C2=A0 status-&gt;host_features =3D qmp_decode_features(vdev-&=
gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vdev-&gt;host_features);<br>
&gt; -=C2=A0 =C2=A0 status-&gt;backend_features =3D qmp_decode_features(vde=
v-&gt;device_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;backend_features);<br>
&gt; +=C2=A0 =C2=A0 status-&gt;guest_features =3D vdev-&gt;guest_features;<=
br>
&gt; +=C2=A0 =C2=A0 status-&gt;host_features =3D vdev-&gt;host_features;<br=
>
&gt; +=C2=A0 =C2=A0 status-&gt;backend_features =3D vdev-&gt;backend_featur=
es;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (vdev-&gt;device_endian) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VIRTIO_DEVICE_ENDIAN_LITTLE:<br>
&gt; @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char=
 *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;num_vqs =3D virtio_get_num_queues(vdev)=
;<br>
&gt; -=C2=A0 =C2=A0 status-&gt;status =3D qmp_decode_status(vdev-&gt;status=
);<br>
&gt; +=C2=A0 =C2=A0 status-&gt;status =3D vdev-&gt;status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;isr =3D vdev-&gt;isr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;queue_sel =3D vdev-&gt;queue_sel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 status-&gt;vm_running =3D vdev-&gt;vm_running;<br>
&gt; @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const ch=
ar *path, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;n_tmp_secti=
ons =3D hdev-&gt;n_tmp_sections;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;nvqs =3D hd=
ev-&gt;nvqs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;vq_index =
=3D hdev-&gt;vq_index;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;features =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;acked_features =
=3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;acked_features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_features=
 =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(vdev-&g=
t;device_id, hdev-&gt;backend_features);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;protocol_feature=
s =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_protocols(hdev-&=
gt;protocol_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;features =3D hde=
v-&gt;features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;acked_features =
=3D hdev-&gt;acked_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_features=
 =3D hdev-&gt;backend_features;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;protocol_feature=
s =3D hdev-&gt;protocol_features;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;max_queues =
=3D hdev-&gt;max_queues;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;backend_cap=
 =3D hdev-&gt;backend_cap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status-&gt;vhost_dev-&gt;log_enabled=
 =3D hdev-&gt;log_enabled;<br>
&gt; diff --git a/qapi/virtio.json b/qapi/virtio.json<br>
&gt; index 19c7c36e36..26516fb29c 100644<br>
&gt; --- a/qapi/virtio.json<br>
&gt; +++ b/qapi/virtio.json<br>
&gt; @@ -102,10 +102,10 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;n-tmp-sections&#3=
9;: &#39;int&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;nvqs&#39;: &#39;u=
int32&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vq-index&#39;: &#=
39;int&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;Vi=
rtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features&#39;: &=
#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features&#39;=
: &#39;VhostDeviceProtocols&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;features&#39;: &#39;ui=
nt64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;acked-features&#39;: &=
#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;protocol-features&#39;=
: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;max-queues&#39;: =
&#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-cap&#39;:=
 &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;log-enabled&#39;:=
 &#39;bool&#39;,<br>
&gt; @@ -170,11 +170,11 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-id&#39;: &=
#39;uint16&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vhost-started&#39=
;: &#39;bool&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;device-endian&#39=
;: &#39;str&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features&#39;: &=
#39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features&#39;: &#=
39;VirtioDeviceFeatures&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;VirtioDeviceFeatures&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;guest-features&#39;: &=
#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;host-features&#39;: &#=
39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backend-features&#39;:=
 &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;num-vqs&#39;: &#3=
9;int&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;Virt=
ioDeviceStatus&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;uint=
8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;isr&#39;: &#39;ui=
nt8&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;queue-sel&#39;: &=
#39;uint16&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;vm-running&#39;: =
&#39;bool&#39;,<br>
&gt; @@ -217,41 +217,14 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;virt=
io-crypto&quot;,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;started&quot;: true,<b=
r>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;device-id&quot;: 20,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: {<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: 0,<=
br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;start-on-kick&quot;: f=
alse,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;isr&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;broken&quot;: false,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot=
;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num-vqs&quot;: 2,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;unknown-dev-f=
eatures&quot;: 1073741824,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: 51002=
73664,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: 632501=
0432,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 1,<br=
>
&gt; @@ -279,147 +252,22 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max-queu=
es&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-=
cap&quot;: 2,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;log-size=
&quot;: 0,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-featu=
res&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-featu=
res&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvqs&quo=
t;: 2,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol-feat=
ures&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;protocols&quot;: []<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;protocol-feat=
ures&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vq-index=
&quot;: 0,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;log-enab=
led&quot;: false,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acked-feature=
s&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&q=
uot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields en=
abled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supporte=
d&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&=
quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features&quot=
;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;dev-features&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VHOST_F_LOG_ALL: Logging write descriptors supported&quot;=
,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&q=
uot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;transports&quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields en=
abled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supporte=
d&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platf=
orm&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&=
quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layout=
s&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of a=
vail. descs. on VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: {<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation s=
upported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GSO: Handling GSO-type packets supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;acked-feature=
s&quot;: 5100306432,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;features&quot=
;: 13908344832,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;backend-features&quot;: 633=
7593319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;start-on-kick&quot;: f=
alse,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;isr&quot;: 1,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;broken&quot;: false,<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;statuses&quot=
;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;status&quot;: 15,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;num-vqs&quot;: 3,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: {<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev-features&=
quot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation s=
upported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GSO: Handling GSO-type packets supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel&quot;,=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported&q=
uot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported&quot;,<br=
>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_VQ: Control channel available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_STATUS: Configuration status field available&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_UFO: Device can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_MAC: Device has given MAC address&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum sup=
ported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported=
&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;transports&qu=
ot;: [<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_EVENT_IDX: Used &amp; avail. event fields enabled&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on =
VQ&quot;<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-features&quot;: 51118=
07911,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host-features&quot;: 633759=
3319,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;use-guest-notifier-mas=
k&quot;: true,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vm-running&quot;: true=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queue-sel&quot;: 2,<br=
>
&gt; -- <br>
&gt; 2.31.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000009960b106116b107f--

