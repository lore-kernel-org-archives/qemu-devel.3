Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3563AF459E7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDMs-00041I-0E; Fri, 10 Apr 2026 11:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wBCvi-00046m-Cy
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:33:54 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wBCve-0000pS-59
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:33:54 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7a2b6adbfa6so22178417b3.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 07:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831628; cv=none;
 d=google.com; s=arc-20240605;
 b=avSEpH3+zFldZyMSsK//pR6cwUiD1YcgvhmV71wgkJB5EsUaS9ZLmVc3Cx1rS7yZgS
 tDKwl+qUf0EuRo/gPPX7EqF9EfKDQir+JImmUYzMI70KqoTuxaFqqG7lGL+3IuOzxf66
 r0nQF5iPhxKmdV+EUAMICzUzCGORYdXQURuTbDGOSxzFhDawObwGgnx5imyK62odU/K9
 CyKuc1WsWugKCfx7vpUvtZIaeNte/k59geNg3XWetzRkO0XIgozlaAEuJ5wunrca4178
 g0rik7AoqflVh/k5tvTLfEMwrsQ47lYogRjZ1XGWyqLu9qFMI3ytdVrQg17f3gdSvF/p
 HZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GZwI283SZQaa0dyiXo9BsmOvi6JFFeCreV3KCgBwUiI=;
 fh=9C8b47AA3jRU8pFAOLE7idlWOvz7eHtUQmw1RT/4b0k=;
 b=T+Td0VmTvSRgKsrtFtXq0d4xCvql206i7Uk2xiDW7PqZ43Tu9j0W3v+G2poQKOdOPV
 qf5ENVQFgO4ZGTeopc10rCvkutLhYLngnM5KVlUiSfnCSlEkeaNZBgjckfD4FxkdSWbK
 YfXLsm/eiaHkLn7j6MpT4MoLNjtc0IIg6DGhyCyfDUH58EDUNCY3ZfXyYakAveoQ67Gq
 HpnRTAAxC4KkrVdp9/gtRe3vHJBWp9NWQ4zRjFSyFENh/k9g2Fhxuld5G3ozNUwMTKgJ
 5LDLrMtdq2j2KtwZCW0xKqi3n52fnMA0YeCvsdkcYvwc6FaD+7TSibnOg2Tgssl2m9mU
 fjlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775831628; x=1776436428; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZwI283SZQaa0dyiXo9BsmOvi6JFFeCreV3KCgBwUiI=;
 b=nZy/s4OVu9wuixVyf7TpQa6XdcViV2kEstRisc3zsqo9Cn3i+hcTHFMrZ1L2bAWvHL
 BWn3NgSUFXIDRDNZ6ueGoHGZDZAptBNsO3vyw2xyomfzCzSYzK7J2SaUaZ6Ew0YXxtLR
 /NhOGqCq0idaNvYs8w2CmDq3GQ5cOsUYTO9wm9AwiGaf+1QIe4B+DpABrIaYF0GvAe5I
 GS/4VaN9px7+KJr0AXPn0LiuafJX/Adx5glvduTpF46s2gWHBDxoxD+qByWjnPDGAs0i
 vLyMdcGhgoK0kb/dnNSkA+obCDHQC2sUfsYj5xMZM82AaAQBHIcl4yn3aCtQ9QZ2Rk9/
 WojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831628; x=1776436428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZwI283SZQaa0dyiXo9BsmOvi6JFFeCreV3KCgBwUiI=;
 b=iR7Ei99/B3gZBvLW9hUnMnbULHp+XhnOjZaKXJBp9GfYFtH9ZbakHWlWqSd1EwJNr/
 c5KxgFYM8XzDk0usfUEuzAB/D6lcUvCC+fb739cJisou7O2xm8hejJ8UkMi4za1bj4OO
 Wz6rUiuuCj+w6fAD+BoULeJ1SEoiPOeF3FnRGhDkL0Scn4Qe9ieTJm9EYs0Y5UEyLG9t
 V36vMVR1gNa0nnSOYmbQnqiB/+CvA6hm84xP8806eUrrRh4M4iKeWoPTR/CHqXVFNJT1
 IJWcV9LgbFiFsUabmiIPlMZq7HW9XkX44XxkLVlCSX3w1rXFmX8SncazruG4JDc0eZIx
 S5Bw==
X-Gm-Message-State: AOJu0YxrFX7IOS6qkQ+AMvdUGB01I1bLkRd/sGZloqeLpb+Egj1laAVI
 O4ZT+qzlQNpmwyDvUrnkhO8XrbSvZ6J+fuCw3fgoJrgrfcm9UWiR0VO8EJGcKc/z/icnDKLljIG
 bHnN0g3A3d51AcLr5zRtLGhfzkFs+FuTS+RTA3EIbk4IzzsqnhcpKVgWfNA==
X-Gm-Gg: AeBDievpR0tw3LvjdRmivYx9JLCBkcOeYIi6FbRiQxq325/pkRPzce43M85jKrJUlt/
 /H6ZHQbpeS9frq4AVCs0WREmqnbjxCSDlZXK/xBAY5v4G1xX8c7pmJSaJgY27L6J9i+Um4KbOct
 sNXTtKsm6Sdw9rJVH+DptkyAjt2yDw+b+bFfgS0eNJA+rkfiUyArVwJz+L34dJTDnQ3lG33cjFO
 ZRWC5evbTg1sr4llxwFIo74aXFJtYRyYXuT70Z8NA2Hq1xaGSxP8BdcqwLbHe8nWkQluug4lzYv
 1VlAu1GunQfLfHYZeaSed6lLbOml1+0h0ZeUtrecyXAO7sccPwSLgKQn6VizSP8yIsAzR0UEcg=
 =
X-Received: by 2002:a05:690c:d96:b0:79a:5466:bb93 with SMTP id
 00721157ae682-7af71d44373mr38595047b3.41.1775831627848; Fri, 10 Apr 2026
 07:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260409060155.94704-1-matthieu@min.io>
 <20260410143000.86708-1-matthieu@min.io>
In-Reply-To: <20260410143000.86708-1-matthieu@min.io>
From: Matthieu Rolla <matthieu@minio.io>
Date: Fri, 10 Apr 2026 16:33:47 +0200
X-Gm-Features: AQROBzD5tfel07yPxYlZGc1I9WZodwvef4eLayGZrCCXxn1IoG1_g1I1h9wOHes
Message-ID: <CAPSO8Mx2pXp1UGvrsqTL86b=920os62MYSGn-ryv-YV4kRN4NA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/nvme: add namespace hotplug support
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com, 
 mr-083 <matthieu@min.io>
Content-Type: multipart/alternative; boundary="0000000000005bef3a064f1c05c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=matthieu@minio.io; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Apr 2026 11:01:56 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005bef3a064f1c05c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello @Stefan Hajnoczi <stefanha@redhat.com> ,


Thanks for the review! v3 sent.


Wording: Fixed in v3, no more "physical PCIe slot" claim. Now describes it
as NVMe namespace-level hotplug.


I/O drain: Moved nvme_ns_drain() to the start of the unplug handler so
in-flight I/O completes before detach. Tested under warp load (16
concurrent 1MiB uploads via MinIO/DirectPV)  device_del returns in ~400ms
with clean removal, no use-after-free.


Symmetry:  moved subsys->namespaces[nsid] =3D NULL into nvme_ns_unrealize()
so the namespace lifecycle is complete (mirrors what nvme_ns_realize() sets
up).


I don't have a working Windows test setup, I'd really appreciate if you
could test it next week as you offered.

Thanks again for your time

On Fri, Apr 10, 2026 at 4:29=E2=80=AFPM mr-083 <matthieu@minio.io> wrote:

> Add hotplug support for nvme-ns devices on the NvmeBus. This enables
> NVMe namespace-level hot-add and hot-remove via device_add and
> device_del with proper Asynchronous Event Notification (AEN), so the
> guest kernel can react to namespace topology changes.
>
> Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
> hotplug handler with proper plug and unplug callbacks:
>
> - plug: attach namespace to all started controllers and send an
>   Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
>   the guest kernel rescans namespaces and adds the block device
> - unplug: drain in-flight I/O, detach from all controllers, send
>   AEN, then unrealize the device. The guest kernel rescans and
>   removes the block device.
>
> The plug handler skips controllers that haven't started yet
> (qs_created =3D=3D false) to avoid interfering with boot-time namespace
> attachment in nvme_start_ctrl().
>
> The unplug handler drains in-flight I/O via nvme_ns_drain() before
> detaching the namespace from controllers, so pending requests can
> complete normally without touching freed state.
>
> For symmetry with nvme_ns_realize() which sets subsys->namespaces[nsid],
> nvme_ns_unrealize() now clears that slot too =E2=80=94 making the namespa=
ce
> lifecycle complete.
>
> Both the controller bus and subsystem bus are configured as hotplug
> handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
> may reparent to the subsystem bus during realize.
>
> Example hot-swap sequence using the NVMe subsystem model:
>
>   # Boot with: -device nvme-subsys,id=3Dsubsys0
>   #            -device nvme,id=3Dctrl0,subsys=3Dsubsys0
>   #            -device nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>
>   device_del ns0             # guest receives AEN, removes /dev/nvme0n1
>   drive_del drv0
>   drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone
>   device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>                               # guest receives AEN, adds /dev/nvme0n1
>
> Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
> namespace list automatically).
>
> Signed-off-by: Matthieu <matthieu@min.io>
> ---
>  hw/nvme/ctrl.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c     |  8 +++++
>  hw/nvme/subsys.c |  2 ++
>  3 files changed, 98 insertions(+)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index be6c7028cb..2024b0ff75 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -206,6 +206,7 @@
>  #include "system/hostmem.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_sriov.h"
> +#include "hw/core/qdev.h"
>  #include "system/spdm-socket.h"
>  #include "migration/vmstate.h"
>
> @@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error
> **errp)
>      }
>
>      qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
> +    qbus_set_bus_hotplug_handler(BUS(&n->bus));
>
>      if (nvme_init_subsys(n, errp)) {
>          return;
> @@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info =3D {
>      },
>  };
>
> +static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState
> *dev,
> +                              Error **errp)
> +{
> +    NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
> +    int i;
> +
> +    /*
> +     * Attach to all started controllers and notify via AEN.
> +     * Skip controllers that haven't started yet (boot-time realize) =E2=
=80=94
> +     * nvme_start_ctrl() will attach namespaces during controller init.
> +     */
> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
> +        if (!ctrl || !ctrl->qs_created) {
> +            continue;
> +        }
> +
> +        if (nvme_csi_supported(ctrl, ns->csi) && !ns->params.detached) {
> +            nvme_attach_ns(ctrl, ns);
> +            nvme_update_dsm_limits(ctrl, ns);
> +
> +            if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
> +                nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
> +                                   NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> +                                   NVME_LOG_CHANGED_NSLIST);
> +            }
> +        }
> +    }
> +}
> +
> +static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState
> *dev,
> +                               Error **errp)
> +{
> +    NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
> +    int i;
> +
> +    /*
> +     * Drain in-flight I/O before tearing down the namespace.
> +     * This must happen while the namespace is still attached to the
> +     * controllers so any pending requests can complete normally.
> +     */
> +    nvme_ns_drain(ns);
> +
> +    /*
> +     * Detach from all controllers and notify the guest via AEN.
> +     * The guest kernel will rescan namespaces and remove the block
> device.
> +     */
> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
> +        if (!ctrl || !nvme_ns(ctrl, nsid)) {
> +            continue;
> +        }
> +
> +        nvme_detach_ns(ctrl, ns);
> +        nvme_update_dsm_limits(ctrl, NULL);
> +
> +        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
> +            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
> +                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
> +                               NVME_LOG_CHANGED_NSLIST);
> +        }
> +    }
> +
> +    /*
> +     * Unrealize: removes from subsystem (in nvme_ns_unrealize), flushes=
,
> +     * cleans up structures, and removes from QOM.
> +     */
> +    qdev_unrealize(dev);
> +}
> +
> +static void nvme_bus_class_init(ObjectClass *klass, const void *data)
> +{
> +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
> +    hc->plug =3D nvme_ns_hot_plug;
> +    hc->unplug =3D nvme_ns_hot_unplug;
> +}
> +
>  static const TypeInfo nvme_bus_info =3D {
>      .name =3D TYPE_NVME_BUS,
>      .parent =3D TYPE_BUS,
>      .instance_size =3D sizeof(NvmeBus),
> +    .class_init =3D nvme_bus_class_init,
> +    .interfaces =3D (const InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { }
> +    },
>  };
>
>  static void nvme_register_types(void)
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index b0106eaa5c..f4f755c6fc 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
>  static void nvme_ns_unrealize(DeviceState *dev)
>  {
>      NvmeNamespace *ns =3D NVME_NS(dev);
> +    NvmeSubsystem *subsys =3D ns->subsys;
> +    uint32_t nsid =3D ns->params.nsid;
>
>      nvme_ns_drain(ns);
>      nvme_ns_shutdown(ns);
>      nvme_ns_cleanup(ns);
> +
> +    /* Symmetric with nvme_ns_realize() which sets
> subsys->namespaces[nsid]. */
> +    if (subsys && nsid && subsys->namespaces[nsid] =3D=3D ns) {
> +        subsys->namespaces[nsid] =3D NULL;
> +    }
>  }
>
>  void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
> @@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const
> void *data)
>      dc->bus_type =3D TYPE_NVME_BUS;
>      dc->realize =3D nvme_ns_realize;
>      dc->unrealize =3D nvme_ns_unrealize;
> +    dc->hotpluggable =3D true;
>      device_class_set_props(dc, nvme_ns_props);
>      dc->desc =3D "Virtual NVMe namespace";
>  }
> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
> index 777e1c620f..fa35055d3c 100644
> --- a/hw/nvme/subsys.c
> +++ b/hw/nvme/subsys.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "hw/core/qdev.h"
>
>  #include "nvme.h"
>
> @@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev,
> Error **errp)
>      NvmeSubsystem *subsys =3D NVME_SUBSYS(dev);
>
>      qbus_init(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id=
);
> +    qbus_set_bus_hotplug_handler(BUS(&subsys->bus));
>
>      nvme_subsys_setup(subsys, errp);
>  }
> --
> 2.53.0
>
>

--0000000000005bef3a064f1c05c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-he=
ight:15px">Hello=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" h=
ref=3D"mailto:stefanha@redhat.com" tabindex=3D"-1">@Stefan Hajnoczi</a>=C2=
=A0,</p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;"><br>T=
hanks for the review! v3 sent.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-he=
ight:15px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">Wordi=
ng: Fixed in v3, no more &quot;physical PCIe slot&quot; claim. Now describe=
s it as NVMe namespace-level hotplug.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-he=
ight:15px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">I/O d=
rain: Moved nvme_ns_drain() to the start of the unplug handler so in-flight=
 I/O completes before detach. Tested under warp load (16 concurrent 1MiB up=
loads via MinIO/DirectPV)=C2=A0 device_del returns in ~400ms with clean rem=
oval, no use-after-free.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-he=
ight:15px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">Symme=
try:=C2=A0 moved subsys-&gt;namespaces[nsid] =3D NULL into nvme_ns_unrealiz=
e() so the namespace lifecycle is complete (mirrors what nvme_ns_realize() =
sets up).</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-he=
ight:15px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">I don=
&#39;t have a working Windows test setup, I&#39;d really appreciate if you =
could test it next week as you offered.<br><br>Thanks again for your time</=
p></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 10, 2026 at 4:29=E2=80=AFPM mr-083 &lt;=
<a href=3D"mailto:matthieu@minio.io">matthieu@minio.io</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Add hotplug support f=
or nvme-ns devices on the NvmeBus. This enables<br>
NVMe namespace-level hot-add and hot-remove via device_add and<br>
device_del with proper Asynchronous Event Notification (AEN), so the<br>
guest kernel can react to namespace topology changes.<br>
<br>
Mark nvme-ns devices as hotpluggable and register the NvmeBus as a<br>
hotplug handler with proper plug and unplug callbacks:<br>
<br>
- plug: attach namespace to all started controllers and send an<br>
=C2=A0 Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so<br>
=C2=A0 the guest kernel rescans namespaces and adds the block device<br>
- unplug: drain in-flight I/O, detach from all controllers, send<br>
=C2=A0 AEN, then unrealize the device. The guest kernel rescans and<br>
=C2=A0 removes the block device.<br>
<br>
The plug handler skips controllers that haven&#39;t started yet<br>
(qs_created =3D=3D false) to avoid interfering with boot-time namespace<br>
attachment in nvme_start_ctrl().<br>
<br>
The unplug handler drains in-flight I/O via nvme_ns_drain() before<br>
detaching the namespace from controllers, so pending requests can<br>
complete normally without touching freed state.<br>
<br>
For symmetry with nvme_ns_realize() which sets subsys-&gt;namespaces[nsid],=
<br>
nvme_ns_unrealize() now clears that slot too =E2=80=94 making the namespace=
<br>
lifecycle complete.<br>
<br>
Both the controller bus and subsystem bus are configured as hotplug<br>
handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices<br>
may reparent to the subsystem bus during realize.<br>
<br>
Example hot-swap sequence using the NVMe subsystem model:<br>
<br>
=C2=A0 # Boot with: -device nvme-subsys,id=3Dsubsys0<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device nvme,id=3Dctrl0,s=
ubsys=3Dsubsys0<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device nvme-ns,id=3Dns0,=
drive=3Ddrv0,bus=3Dctrl0,nsid=3D1<br>
<br>
=C2=A0 device_del ns0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# gues=
t receives AEN, removes /dev/nvme0n1<br>
=C2=A0 drive_del drv0<br>
=C2=A0 drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone<br>
=C2=A0 device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # guest receives AEN, adds /dev/nvme0n1<br>
<br>
Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans<br>
namespace list automatically).<br>
<br>
Signed-off-by: Matthieu &lt;<a href=3D"mailto:matthieu@min.io" target=3D"_b=
lank">matthieu@min.io</a>&gt;<br>
---<br>
=C2=A0hw/nvme/ctrl.c=C2=A0 =C2=A0| 88 +++++++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0hw/nvme/ns.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++<br>
=C2=A0hw/nvme/subsys.c |=C2=A0 2 ++<br>
=C2=A03 files changed, 98 insertions(+)<br>
<br>
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c<br>
index be6c7028cb..2024b0ff75 100644<br>
--- a/hw/nvme/ctrl.c<br>
+++ b/hw/nvme/ctrl.c<br>
@@ -206,6 +206,7 @@<br>
=C2=A0#include &quot;system/hostmem.h&quot;<br>
=C2=A0#include &quot;hw/pci/msix.h&quot;<br>
=C2=A0#include &quot;hw/pci/pcie_sriov.h&quot;<br>
+#include &quot;hw/core/qdev.h&quot;<br>
=C2=A0#include &quot;system/spdm-socket.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
<br>
@@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qbus_init(&amp;n-&gt;bus, sizeof(NvmeBus), TYPE_NVME_BU=
S, dev, dev-&gt;id);<br>
+=C2=A0 =C2=A0 qbus_set_bus_hotplug_handler(BUS(&amp;n-&gt;bus));<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nvme_init_subsys(n, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
+static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 NvmeNamespace *ns =3D NVME_NS(dev);<br>
+=C2=A0 =C2=A0 NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>
+=C2=A0 =C2=A0 uint32_t nsid =3D ns-&gt;params.nsid;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Attach to all started controllers and notify via AEN=
.<br>
+=C2=A0 =C2=A0 =C2=A0* Skip controllers that haven&#39;t started yet (boot-=
time realize) =E2=80=94<br>
+=C2=A0 =C2=A0 =C2=A0* nvme_start_ctrl() will attach namespaces during cont=
roller init.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NVME_MAX_CONTROLLERS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ctrl || !ctrl-&gt;qs_created) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nvme_csi_supported(ctrl, ns-&gt;csi) &amp;=
&amp; !ns-&gt;params.detached) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_attach_ns(ctrl, ns);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_update_dsm_limits(ctrl, ns)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!test_and_set_bit(nsid, ctrl=
-&gt;changed_nsids)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_enqueue_event=
(ctrl, NVME_AER_TYPE_NOTICE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_AER_INFO_NOTICE_NS=
_ATTR_CHANGED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_LOG_CHANGED_NSLIST=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 NvmeNamespace *ns =3D NVME_NS(dev);<br>
+=C2=A0 =C2=A0 NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>
+=C2=A0 =C2=A0 uint32_t nsid =3D ns-&gt;params.nsid;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Drain in-flight I/O before tearing down the namespac=
e.<br>
+=C2=A0 =C2=A0 =C2=A0* This must happen while the namespace is still attach=
ed to the<br>
+=C2=A0 =C2=A0 =C2=A0* controllers so any pending requests can complete nor=
mally.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 nvme_ns_drain(ns);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Detach from all controllers and notify the guest via=
 AEN.<br>
+=C2=A0 =C2=A0 =C2=A0* The guest kernel will rescan namespaces and remove t=
he block device.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; NVME_MAX_CONTROLLERS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ctrl || !nvme_ns(ctrl, nsid)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_detach_ns(ctrl, ns);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_update_dsm_limits(ctrl, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!test_and_set_bit(nsid, ctrl-&gt;changed_n=
sids)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_enqueue_event(ctrl, NVME_AE=
R_TYPE_NOTICE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NVME_LOG_CHANGED_NSLIST);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Unrealize: removes from subsystem (in nvme_ns_unreal=
ize), flushes,<br>
+=C2=A0 =C2=A0 =C2=A0* cleans up structures, and removes from QOM.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 qdev_unrealize(dev);<br>
+}<br>
+<br>
+static void nvme_bus_class_init(ObjectClass *klass, const void *data)<br>
+{<br>
+=C2=A0 =C2=A0 HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);<br=
>
+=C2=A0 =C2=A0 hc-&gt;plug =3D nvme_ns_hot_plug;<br>
+=C2=A0 =C2=A0 hc-&gt;unplug =3D nvme_ns_hot_unplug;<br>
+}<br>
+<br>
=C2=A0static const TypeInfo nvme_bus_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_NVME_BUS,<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_BUS,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(NvmeBus),<br>
+=C2=A0 =C2=A0 .class_init =3D nvme_bus_class_init,<br>
+=C2=A0 =C2=A0 .interfaces =3D (const InterfaceInfo[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { TYPE_HOTPLUG_HANDLER },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
+=C2=A0 =C2=A0 },<br>
=C2=A0};<br>
<br>
=C2=A0static void nvme_register_types(void)<br>
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c<br>
index b0106eaa5c..f4f755c6fc 100644<br>
--- a/hw/nvme/ns.c<br>
+++ b/hw/nvme/ns.c<br>
@@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)<br>
=C2=A0static void nvme_ns_unrealize(DeviceState *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0NvmeNamespace *ns =3D NVME_NS(dev);<br>
+=C2=A0 =C2=A0 NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>
+=C2=A0 =C2=A0 uint32_t nsid =3D ns-&gt;params.nsid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0nvme_ns_drain(ns);<br>
=C2=A0 =C2=A0 =C2=A0nvme_ns_shutdown(ns);<br>
=C2=A0 =C2=A0 =C2=A0nvme_ns_cleanup(ns);<br>
+<br>
+=C2=A0 =C2=A0 /* Symmetric with nvme_ns_realize() which sets subsys-&gt;na=
mespaces[nsid]. */<br>
+=C2=A0 =C2=A0 if (subsys &amp;&amp; nsid &amp;&amp; subsys-&gt;namespaces[=
nsid] =3D=3D ns) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 subsys-&gt;namespaces[nsid] =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,<br>
@@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const v=
oid *data)<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;bus_type =3D TYPE_NVME_BUS;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D nvme_ns_realize;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;unrealize =3D nvme_ns_unrealize;<br>
+=C2=A0 =C2=A0 dc-&gt;hotpluggable =3D true;<br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, nvme_ns_props);<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;Virtual NVMe namespace&quot;;<br>
=C2=A0}<br>
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c<br>
index 777e1c620f..fa35055d3c 100644<br>
--- a/hw/nvme/subsys.c<br>
+++ b/hw/nvme/subsys.c<br>
@@ -9,6 +9,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/core/qdev.h&quot;<br>
<br>
=C2=A0#include &quot;nvme.h&quot;<br>
<br>
@@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0NvmeSubsystem *subsys =3D NVME_SUBSYS(dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qbus_init(&amp;subsys-&gt;bus, sizeof(NvmeBus), TYPE_NV=
ME_BUS, dev, dev-&gt;id);<br>
+=C2=A0 =C2=A0 qbus_set_bus_hotplug_handler(BUS(&amp;subsys-&gt;bus));<br>
<br>
=C2=A0 =C2=A0 =C2=A0nvme_subsys_setup(subsys, errp);<br>
=C2=A0}<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--0000000000005bef3a064f1c05c2--

