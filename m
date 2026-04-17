Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F68F43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfmP-0006q0-Px; Fri, 17 Apr 2026 05:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDflu-0006gS-Tr
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:46:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDfls-00078b-5u
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:45:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so4126175e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776419154; x=1777023954; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+rG1tA44kts1GfLhbQcUoT5U71ff49S492gxbzoowUY=;
 b=FiwEvuJoxkZk5Vvfyb4m7XLPXiKmo/EhHMFDLNP57g+YyskFypNkAR3YhKY8sdkyfg
 vhjudswIQXZF9Rutcct8XUp1r36ctIAgVSRNT3eV6Mbkh1Nt5gbHJnpjJR7/IFFckAlN
 fNbmDdQgUIikKVorYt8RrcezgMfZiaYaf2DwrUmMM6lsfumSNV80vpVMAXKwaUAYZhhY
 xR8zYeeP7PZY5D3kobV78qdTZ9ZK11s2IuKYYGnZqknRPctst6ybX9lhCKtlLF9m+Ir1
 oq/R1F4FunJOz/jELVLUZ1AFYHs2uxjekmVp0P7DbWZwEW0DXxoOSHY1m4ZYYyChFUaw
 3LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776419154; x=1777023954;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rG1tA44kts1GfLhbQcUoT5U71ff49S492gxbzoowUY=;
 b=Y5eCTUdK+h/7EwBuBX7sOTK0OYUBx20nmG8w0yfN3CgXuenI16cP0fpxtOGmJq7D29
 YAQkWTgh6aquzr8QlrtCeE3iEawjEDlp1FSlQP879Df2w2Lmn7A8O0FoLzbaH0vZAzdU
 lQjymehuoq/Qvnaq+rGdRoMtk1fJFMhN0xKw459o8ASZFrdWWhDlxo/Pigk/XSQqG8+r
 7qGHykXL6LO+iKwr7yIkZ4ceRvqzVrSWShEY+wqQ35E0g1GzVznhgcyX2XbmzPkKKdUD
 8H1cvbNFSPMRMzbtEJM4ow6QWZKLUOi6DDm12y6z2n6cwL4BOrf35OvvABE7jGWP3jJc
 Qu8A==
X-Gm-Message-State: AOJu0Yw+FUoOGlUjQYHtHnnFp23UMPbYXQIDGK7TosQlO+1gPfZiipvJ
 xo/lq1z0CHUHwIAxm4JbhP+0hOWpsJABYRa4P80O1p+nrK9vZBIHWTXFQfAOdyrNbS0=
X-Gm-Gg: AeBDietT1kiID0ov6sQMW2tNuc0g0VmjEEvoOwSloOOS6qR6UJxxJkWZRspBGMsV6K0
 ZyKFULoE8D+uJvEL/LK9OsTxhK0WwOuHOznH2YxCzXqXSsMi6kf3OC+fPvxpGmwLyA8nhO7xwUT
 P0QpJwWhs/vNnYOPYKWQ9JeFZc4j2fsBIw/mIyHBNnCRd+PQb1zU3/3CDSRZn2lOLYIZoSrLtRV
 CnFaD2D/sUfqEXWws0aqZo4dTHbYydMF3fGj2raLcRhppD69/fd1w6VvhLMU9hyNQuaXpWfD74P
 Dvy8CCstWduNABK+blE9RKhXuPaMgFnipQsd2ZYxHaNyVFM9xoHjFwrWwls1DNsVYdXQAfthQXB
 QCiFVyJyr4aH7UjCiizRvG10oxcVsxT9mUtsVH3uYeDI3SW25v8xGwkEg14gN2QwG3XBno+sS6i
 WbqVuRfE10rlIvyStN9DbVi1Q/aS1LEJ1EbExk6I+8XPHQoIGCf5BomRPL94FXhGxHBRzzdfHsH
 2PsR+J7F3s+zEg4QMIrsbtiL/qrEUK6M+Un/absx7aYWnryshEbUkWYfTDfDD6jHgQFdHN/1mte
 paUoesc=
X-Received: by 2002:a05:600c:1389:b0:485:9a50:338d with SMTP id
 5b1f17b1804b1-488fb739d3amr31022795e9.3.1776419154237; 
 Fri, 17 Apr 2026 02:45:54 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb001411480048dbebc40db84a7b.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:48db:ebc4:db8:4a7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc16f784sm27612495e9.1.2026.04.17.02.45.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2026 02:45:53 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <9474C609-F00D-4ADF-9F5C-3103388C9434@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_15B4B559-EF24-4AEC-9D0B-4541285F1D3C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v4] hw/nvme: add namespace hotplug support
Date: Fri, 17 Apr 2026 11:45:54 +0200
In-Reply-To: <aeH9YOHJjrbt6x5F@AALNPWKJENSEN.aal.scsc.local>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org,
 stefanha@redhat.com, mr-083 <matthieu@min.io>
To: Klaus Jensen <its@irrelevant.dk>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260415173852.71135-1-matthieu@min.io>
 <aeH9YOHJjrbt6x5F@AALNPWKJENSEN.aal.scsc.local>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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


--Apple-Mail=_15B4B559-EF24-4AEC-9D0B-4541285F1D3C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Klaus,

Thank you for your feedback. I also created =
https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg02613.html =
if you are interested.=20

BR,

	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 17, 2026, at 11:29=E2=80=AFAM, Klaus Jensen <its@irrelevant.dk> =
wrote:
>=20
> On Apr 15 19:38, mr-083 wrote:
>> Add hotplug support for nvme-ns devices on the NvmeBus. This enables
>> NVMe namespace-level hot-add and hot-remove via device_add and
>> device_del with proper Asynchronous Event Notification (AEN), so the
>> guest kernel can react to namespace topology changes.
>>=20
>> Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
>> hotplug handler with proper plug and unplug callbacks:
>>=20
>> - plug: attach namespace to all started controllers and send an
>>  Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
>>  the guest kernel rescans namespaces and adds the block device
>> - unplug: drain in-flight I/O, detach from all controllers, send
>>  AEN, then unrealize the device. The guest kernel rescans and
>>  removes the block device.
>>=20
>> The plug handler skips controllers that haven't started yet
>> (qs_created =3D=3D false) to avoid interfering with boot-time =
namespace
>> attachment in nvme_start_ctrl().
>>=20
>> The unplug handler drains in-flight I/O via nvme_ns_drain() before
>> detaching the namespace from controllers, so pending requests can
>> complete normally without touching freed state.
>>=20
>> For symmetry with nvme_ns_realize() which sets =
subsys->namespaces[nsid],
>> nvme_ns_unrealize() now clears that slot too making the namespace
>> lifecycle complete.
>>=20
>> Both the controller bus and subsystem bus are configured as hotplug
>> handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
>> may reparent to the subsystem bus during realize.
>>=20
>> Example hot-swap sequence using the NVMe subsystem model:
>>=20
>>  # Boot with: -device nvme-subsys,id=3Dsubsys0
>>  #            -device nvme,id=3Dctrl0,subsys=3Dsubsys0
>>  #            -device nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D=
1
>>=20
>>  device_del ns0             # guest receives AEN, removes =
/dev/nvme0n1
>>  drive_del drv0
>>  drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone
>>  device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1
>>                              # guest receives AEN, adds /dev/nvme0n1
>>=20
>> Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
>> namespace list automatically).
>>=20
>> Signed-off-by: Matthieu <matthieu@min.io>
>> ---
>> hw/nvme/ctrl.c   | 88 =
++++++++++++++++++++++++++++++++++++++++++++++++
>> hw/nvme/ns.c     |  8 +++++
>> hw/nvme/subsys.c |  2 ++
>> 3 files changed, 98 insertions(+)
>>=20
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>> index be6c7028cb..2024b0ff75 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -206,6 +206,7 @@
>> #include "system/hostmem.h"
>> #include "hw/pci/msix.h"
>> #include "hw/pci/pcie_sriov.h"
>> +#include "hw/core/qdev.h"
>> #include "system/spdm-socket.h"
>> #include "migration/vmstate.h"
>>=20
>> @@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, =
Error **errp)
>>     }
>>=20
>>     qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
>> +    qbus_set_bus_hotplug_handler(BUS(&n->bus));
>>=20
>>     if (nvme_init_subsys(n, errp)) {
>>         return;
>> @@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info =3D {
>>     },
>> };
>>=20
>> +static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, =
DeviceState *dev,
>> +                              Error **errp)
>> +{
>> +    NvmeNamespace *ns =3D NVME_NS(dev);
>> +    NvmeSubsystem *subsys =3D ns->subsys;
>> +    uint32_t nsid =3D ns->params.nsid;
>> +    int i;
>> +
>> +    /*
>> +     * Attach to all started controllers and notify via AEN.
>> +     * Skip controllers that haven't started yet (boot-time realize) =
=E2=80=94
>> +     * nvme_start_ctrl() will attach namespaces during controller =
init.
>> +     */
>> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
>> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
>> +        if (!ctrl || !ctrl->qs_created) {
>> +            continue;
>> +        }
>> +
>> +        if (nvme_csi_supported(ctrl, ns->csi) && =
!ns->params.detached) {
>> +            nvme_attach_ns(ctrl, ns);
>> +            nvme_update_dsm_limits(ctrl, ns);
>> +
>> +            if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
>> +                nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
>> +                                   =
NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
>> +                                   NVME_LOG_CHANGED_NSLIST);
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, =
DeviceState *dev,
>> +                               Error **errp)
>> +{
>> +    NvmeNamespace *ns =3D NVME_NS(dev);
>> +    NvmeSubsystem *subsys =3D ns->subsys;
>> +    uint32_t nsid =3D ns->params.nsid;
>> +    int i;
>> +
>> +    /*
>> +     * Drain in-flight I/O before tearing down the namespace.
>> +     * This must happen while the namespace is still attached to the
>> +     * controllers so any pending requests can complete normally.
>> +     */
>> +    nvme_ns_drain(ns);
>> +
>> +    /*
>> +     * Detach from all controllers and notify the guest via AEN.
>> +     * The guest kernel will rescan namespaces and remove the block =
device.
>> +     */
>> +    for (i =3D 0; i < NVME_MAX_CONTROLLERS; i++) {
>> +        NvmeCtrl *ctrl =3D nvme_subsys_ctrl(subsys, i);
>> +        if (!ctrl || !nvme_ns(ctrl, nsid)) {
>> +            continue;
>> +        }
>> +
>> +        nvme_detach_ns(ctrl, ns);
>> +        nvme_update_dsm_limits(ctrl, NULL);
>> +
>> +        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
>> +            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
>> +                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
>> +                               NVME_LOG_CHANGED_NSLIST);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * Unrealize: removes from subsystem (in nvme_ns_unrealize), =
flushes,
>> +     * cleans up structures, and removes from QOM.
>> +     */
>> +    qdev_unrealize(dev);
>> +}
>> +
>> +static void nvme_bus_class_init(ObjectClass *klass, const void =
*data)
>> +{
>> +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
>> +    hc->plug =3D nvme_ns_hot_plug;
>> +    hc->unplug =3D nvme_ns_hot_unplug;
>> +}
>> +
>> static const TypeInfo nvme_bus_info =3D {
>>     .name =3D TYPE_NVME_BUS,
>>     .parent =3D TYPE_BUS,
>>     .instance_size =3D sizeof(NvmeBus),
>> +    .class_init =3D nvme_bus_class_init,
>> +    .interfaces =3D (const InterfaceInfo[]) {
>> +        { TYPE_HOTPLUG_HANDLER },
>> +        { }
>> +    },
>> };
>>=20
>> static void nvme_register_types(void)
>> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
>> index b0106eaa5c..f4f755c6fc 100644
>> --- a/hw/nvme/ns.c
>> +++ b/hw/nvme/ns.c
>> @@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
>> static void nvme_ns_unrealize(DeviceState *dev)
>> {
>>     NvmeNamespace *ns =3D NVME_NS(dev);
>> +    NvmeSubsystem *subsys =3D ns->subsys;
>> +    uint32_t nsid =3D ns->params.nsid;
>>=20
>>     nvme_ns_drain(ns);
>>     nvme_ns_shutdown(ns);
>>     nvme_ns_cleanup(ns);
>> +
>> +    /* Symmetric with nvme_ns_realize() which sets =
subsys->namespaces[nsid]. */
>> +    if (subsys && nsid && subsys->namespaces[nsid] =3D=3D ns) {
>> +        subsys->namespaces[nsid] =3D NULL;
>> +    }
>> }
>>=20
>> void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
>> @@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, =
const void *data)
>>     dc->bus_type =3D TYPE_NVME_BUS;
>>     dc->realize =3D nvme_ns_realize;
>>     dc->unrealize =3D nvme_ns_unrealize;
>> +    dc->hotpluggable =3D true;
>>     device_class_set_props(dc, nvme_ns_props);
>>     dc->desc =3D "Virtual NVMe namespace";
>> }
>> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
>> index 777e1c620f..fa35055d3c 100644
>> --- a/hw/nvme/subsys.c
>> +++ b/hw/nvme/subsys.c
>> @@ -9,6 +9,7 @@
>> #include "qemu/osdep.h"
>> #include "qemu/units.h"
>> #include "qapi/error.h"
>> +#include "hw/core/qdev.h"
>>=20
>> #include "nvme.h"
>>=20
>> @@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev, =
Error **errp)
>>     NvmeSubsystem *subsys =3D NVME_SUBSYS(dev);
>>=20
>>     qbus_init(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, =
dev->id);
>> +    qbus_set_bus_hotplug_handler(BUS(&subsys->bus));
>>=20
>>     nvme_subsys_setup(subsys, errp);
>> }
>> --=20
>> 2.53.0
>>=20
>>=20
>=20
> As an out-of-band mechanism to hot-plug namespaces, this looks good.
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> I'll pick it up for 11.1. Thanks!


--Apple-Mail=_15B4B559-EF24-4AEC-9D0B-4541285F1D3C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Hello Klaus,<div><br></div><div>Thank =
you for your feedback. I also =
created&nbsp;https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg0=
2613.html if you are =
interested.&nbsp;</div><div><br></div><div>BR,<br><div>
<br>
<table>
   <tbody>
       <tr>
           <td style=3D"padding: 0 50px 0 0;"><img =
src=3D"https://cdn.bfldr.com/Q955TODV/at/f5h9pjj8f8t3ng5t6vxs2n/emailsigna=
ture-logo-standalone.png?auto=3Dwebp&amp;format=3Dpng" height=3D"34"></td>=

           <td style=3D"width: 1px; padding: 0; background-color: =
#D6DAE1; color: #D6DAE1; font-size: 1px;">.</td>
           <td style=3D"padding:0 20px 0 50px;">
               <div style=3D"margin-top: -6px; margin-bottom: -4px;">
                   <strong><span =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: =
1.1em; color: #353638;" color=3D"#353638">Matthieu</span></strong><br>
                   <div style=3D"height: 6px;"></div>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">www.min.io</a><br>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">matthieu@min.io</a>
               </div>
           </td>
       </tr>
   </tbody>
</table>

</div>
<div><br><blockquote type=3D"cite"><div>On Apr 17, 2026, at 11:29=E2=80=AF=
AM, Klaus Jensen &lt;its@irrelevant.dk&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Apr 15 19:38, mr-083 =
wrote:<br><blockquote type=3D"cite">Add hotplug support for nvme-ns =
devices on the NvmeBus. This enables<br>NVMe namespace-level hot-add and =
hot-remove via device_add and<br>device_del with proper Asynchronous =
Event Notification (AEN), so the<br>guest kernel can react to namespace =
topology changes.<br><br>Mark nvme-ns devices as hotpluggable and =
register the NvmeBus as a<br>hotplug handler with proper plug and unplug =
callbacks:<br><br>- plug: attach namespace to all started controllers =
and send an<br> &nbsp;Asynchronous Event Notification (AEN) with =
NS_ATTR_CHANGED so<br> &nbsp;the guest kernel rescans namespaces and =
adds the block device<br>- unplug: drain in-flight I/O, detach from all =
controllers, send<br> &nbsp;AEN, then unrealize the device. The guest =
kernel rescans and<br> &nbsp;removes the block device.<br><br>The plug =
handler skips controllers that haven't started yet<br>(qs_created =3D=3D =
false) to avoid interfering with boot-time namespace<br>attachment in =
nvme_start_ctrl().<br><br>The unplug handler drains in-flight I/O via =
nvme_ns_drain() before<br>detaching the namespace from controllers, so =
pending requests can<br>complete normally without touching freed =
state.<br><br>For symmetry with nvme_ns_realize() which sets =
subsys-&gt;namespaces[nsid],<br>nvme_ns_unrealize() now clears that slot =
too making the namespace<br>lifecycle complete.<br><br>Both the =
controller bus and subsystem bus are configured as hotplug<br>handlers =
via qbus_set_bus_hotplug_handler() since nvme-ns devices<br>may reparent =
to the subsystem bus during realize.<br><br>Example hot-swap sequence =
using the NVMe subsystem model:<br><br> &nbsp;# Boot with: -device =
nvme-subsys,id=3Dsubsys0<br> &nbsp;# =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-device =
nvme,id=3Dctrl0,subsys=3Dsubsys0<br> &nbsp;# =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-device =
nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1<br><br> =
&nbsp;device_del ns0 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# =
guest receives AEN, removes /dev/nvme0n1<br> &nbsp;drive_del drv0<br> =
&nbsp;drive_add 0 file=3Ddisk.qcow2,format=3Dqcow2,id=3Ddrv0,if=3Dnone<br>=
 &nbsp;device_add nvme-ns,id=3Dns0,drive=3Ddrv0,bus=3Dctrl0,nsid=3D1<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;# guest receives AEN, adds =
/dev/nvme0n1<br><br>Tested with Linux 6.1 guest (NVMe driver processes =
AEN and rescans<br>namespace list automatically).<br><br>Signed-off-by: =
Matthieu &lt;matthieu@min.io&gt;<br>---<br> hw/nvme/ctrl.c &nbsp;&nbsp;| =
88 ++++++++++++++++++++++++++++++++++++++++++++++++<br> hw/nvme/ns.c =
&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;8 +++++<br> hw/nvme/subsys.c | &nbsp;2 =
++<br> 3 files changed, 98 insertions(+)<br><br>diff --git =
a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c<br>index be6c7028cb..2024b0ff75 =
100644<br>--- a/hw/nvme/ctrl.c<br>+++ b/hw/nvme/ctrl.c<br>@@ -206,6 =
+206,7 @@<br> #include "system/hostmem.h"<br> #include =
"hw/pci/msix.h"<br> #include "hw/pci/pcie_sriov.h"<br>+#include =
"hw/core/qdev.h"<br> #include "system/spdm-socket.h"<br> #include =
"migration/vmstate.h"<br><br>@@ -9293,6 +9294,7 @@ static void =
nvme_realize(PCIDevice *pci_dev, Error **errp)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;qbus_init(&amp;n-&gt;bus, sizeof(NvmeBus), =
TYPE_NVME_BUS, dev, dev-&gt;id);<br>+ =
&nbsp;&nbsp;&nbsp;qbus_set_bus_hotplug_handler(BUS(&amp;n-&gt;bus));<br><b=
r> &nbsp;&nbsp;&nbsp;&nbsp;if (nvme_init_subsys(n, errp)) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>@@ -9553,10 =
+9555,96 @@ static const TypeInfo nvme_info =3D {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;},<br> };<br><br>+static void =
nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;NvmeNamespace *ns =3D NVME_NS(dev);<br>+ =
&nbsp;&nbsp;&nbsp;NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t nsid =3D ns-&gt;params.nsid;<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Attach to all started controllers and notify =
via AEN.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* Skip controllers that haven't =
started yet (boot-time realize) =E2=80=94<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* =
nvme_start_ctrl() will attach namespaces during controller init.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
NVME_MAX_CONTROLLERS; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NvmeCtrl *ctrl =3D =
nvme_subsys_ctrl(subsys, i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!ctrl || =
!ctrl-&gt;qs_created) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;continue=
;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (nvme_csi_supported(ctrl, =
ns-&gt;csi) &amp;&amp; !ns-&gt;params.detached) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nvme_att=
ach_ns(ctrl, ns);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nvme_upd=
ate_dsm_limits(ctrl, ns);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!test_and_set_bit(nsid, ctrl-&gt;changed_nsids)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NVME_AER_INFO_NOTI=
CE_NS_ATTR_CHANGED,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NVME_LOG_CHANGED_N=
SLIST);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;NvmeNamespace *ns =3D NVME_NS(dev);<br>+ =
&nbsp;&nbsp;&nbsp;NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t nsid =3D ns-&gt;params.nsid;<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Drain in-flight I/O before tearing down the =
namespace.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* This must happen while the =
namespace is still attached to the<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* =
controllers so any pending requests can complete normally.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;nvme_ns_drain(ns);<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Detach from all controllers and notify the =
guest via AEN.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* The guest kernel will =
rescan namespaces and remove the block device.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
NVME_MAX_CONTROLLERS; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NvmeCtrl *ctrl =3D =
nvme_subsys_ctrl(subsys, i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!ctrl || !nvme_ns(ctrl, =
nsid)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;continue=
;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nvme_detach_ns(ctrl, ns);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nvme_update_dsm_limits(ctrl, =
NULL);<br>+<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!test_and_set_bit(nsid, ctrl-&gt;changed_nsids)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nvme_enq=
ueue_event(ctrl, NVME_AER_TYPE_NOTICE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,<br>+=
 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NVME_LOG_CHANGED_NSLIST);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Unrealize: removes from subsystem (in =
nvme_ns_unrealize), flushes,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* cleans up =
structures, and removes from QOM.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;qdev_unrealize(dev);<br>+}<br>+<br>+static void =
nvme_bus_class_init(ObjectClass *klass, const void *data)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;HotplugHandlerClass *hc =3D =
HOTPLUG_HANDLER_CLASS(klass);<br>+ &nbsp;&nbsp;&nbsp;hc-&gt;plug =3D =
nvme_ns_hot_plug;<br>+ &nbsp;&nbsp;&nbsp;hc-&gt;unplug =3D =
nvme_ns_hot_unplug;<br>+}<br>+<br> static const TypeInfo nvme_bus_info =3D=
 {<br> &nbsp;&nbsp;&nbsp;&nbsp;.name =3D TYPE_NVME_BUS,<br> =
&nbsp;&nbsp;&nbsp;&nbsp;.parent =3D TYPE_BUS,<br> =
&nbsp;&nbsp;&nbsp;&nbsp;.instance_size =3D sizeof(NvmeBus),<br>+ =
&nbsp;&nbsp;&nbsp;.class_init =3D nvme_bus_class_init,<br>+ =
&nbsp;&nbsp;&nbsp;.interfaces =3D (const InterfaceInfo[]) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ TYPE_HOTPLUG_HANDLER },<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ }<br>+ =
&nbsp;&nbsp;&nbsp;},<br> };<br><br> static void =
nvme_register_types(void)<br>diff --git a/hw/nvme/ns.c =
b/hw/nvme/ns.c<br>index b0106eaa5c..f4f755c6fc 100644<br>--- =
a/hw/nvme/ns.c<br>+++ b/hw/nvme/ns.c<br>@@ -719,10 +719,17 @@ void =
nvme_ns_cleanup(NvmeNamespace *ns)<br> static void =
nvme_ns_unrealize(DeviceState *dev)<br> {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;NvmeNamespace *ns =3D NVME_NS(dev);<br>+ =
&nbsp;&nbsp;&nbsp;NvmeSubsystem *subsys =3D ns-&gt;subsys;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t nsid =3D ns-&gt;params.nsid;<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;nvme_ns_drain(ns);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;nvme_ns_shutdown(ns);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;nvme_ns_cleanup(ns);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;/* Symmetric with nvme_ns_realize() which sets =
subsys-&gt;namespaces[nsid]. */<br>+ &nbsp;&nbsp;&nbsp;if (subsys =
&amp;&amp; nsid &amp;&amp; subsys-&gt;namespaces[nsid] =3D=3D ns) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subsys-&gt;namespaces[nsid] =3D =
NULL;<br>+ &nbsp;&nbsp;&nbsp;}<br> }<br><br> void =
nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,<br>@@ -937,6 =
+944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void =
*data)<br> &nbsp;&nbsp;&nbsp;&nbsp;dc-&gt;bus_type =3D =
TYPE_NVME_BUS;<br> &nbsp;&nbsp;&nbsp;&nbsp;dc-&gt;realize =3D =
nvme_ns_realize;<br> &nbsp;&nbsp;&nbsp;&nbsp;dc-&gt;unrealize =3D =
nvme_ns_unrealize;<br>+ &nbsp;&nbsp;&nbsp;dc-&gt;hotpluggable =3D =
true;<br> &nbsp;&nbsp;&nbsp;&nbsp;device_class_set_props(dc, =
nvme_ns_props);<br> &nbsp;&nbsp;&nbsp;&nbsp;dc-&gt;desc =3D "Virtual =
NVMe namespace";<br> }<br>diff --git a/hw/nvme/subsys.c =
b/hw/nvme/subsys.c<br>index 777e1c620f..fa35055d3c 100644<br>--- =
a/hw/nvme/subsys.c<br>+++ b/hw/nvme/subsys.c<br>@@ -9,6 +9,7 @@<br> =
#include "qemu/osdep.h"<br> #include "qemu/units.h"<br> #include =
"qapi/error.h"<br>+#include "hw/core/qdev.h"<br><br> #include =
"nvme.h"<br><br>@@ -205,6 +206,7 @@ static void =
nvme_subsys_realize(DeviceState *dev, Error **errp)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;NvmeSubsystem *subsys =3D =
NVME_SUBSYS(dev);<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;qbus_init(&amp;subsys-&gt;bus, sizeof(NvmeBus), =
TYPE_NVME_BUS, dev, dev-&gt;id);<br>+ =
&nbsp;&nbsp;&nbsp;qbus_set_bus_hotplug_handler(BUS(&amp;subsys-&gt;bus));<=
br><br> &nbsp;&nbsp;&nbsp;&nbsp;nvme_subsys_setup(subsys, errp);<br> =
}<br>-- <br>2.53.0<br><br><br></blockquote><br>As an out-of-band =
mechanism to hot-plug namespaces, this looks good.<br><br>Reviewed-by: =
Klaus Jensen &lt;k.jensen@samsung.com&gt;<br><br>I'll pick it up for =
11.1. Thanks!<br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_15B4B559-EF24-4AEC-9D0B-4541285F1D3C--

