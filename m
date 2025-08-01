Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECFAC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhq3Q-0003DD-Ds; Fri, 01 Aug 2025 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uhpxq-0003fi-KQ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uhpxo-0001YD-4W
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754055502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EGDSxAVxB79dNxsEJv9pLleaEdknWXN/zQye7ch6PnU=;
 b=MDFLQTto0TsTJIMHI00pFFJMKve62zPxIEiV+OqimtARAXukHwqcBdka3fuRysHZMDCsz0
 42M2dLfreSPXmE6+534TZXBXGxNqNQ8aNO2gYgx0zrFr8rDNAG4E05s/FK23UcHd5kOKp2
 5QNG4CgxBR5hF+LFRy+4Gwp0Le4XhEY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-LRlznFpnOpqb_svbuSXccQ-1; Fri, 01 Aug 2025 09:38:21 -0400
X-MC-Unique: LRlznFpnOpqb_svbuSXccQ-1
X-Mimecast-MFC-AGG-ID: LRlznFpnOpqb_svbuSXccQ_1754055501
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7074bad051fso28779606d6.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754055501; x=1754660301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGDSxAVxB79dNxsEJv9pLleaEdknWXN/zQye7ch6PnU=;
 b=c7ZFiwBp985ms8mDlz71GkhUHQhKygxauyKVtfAKP3fax53HhP9YKUSwqV8kpRF5rl
 t21MKf0OBW3duXLIzgBAuHBT4kzG/Gc18HzJUMVoFHN9xZMIX1Xrh/A+07pc4lyoaV9x
 VYLMReY0Gc3k2bIQd56m6SxeMuO1UU9e1ro5c2IFZ0IrF2mVUn2BZdi2LNHXfGHt2mWS
 g8gHWAO1CMltx3jRV7akFqLkfSwxCK4u969B9x2BgJ/6YrF45eSqUZVN3leCS9kWGevo
 WvdIRcn3r1vxW9kx2VGdX2Ak6IO36N8JsLMKHPHPNmsozMQNqn2fwKpDTKUhdo/CyuSc
 OWBA==
X-Gm-Message-State: AOJu0Yz9mHlDwcTPsWkfXl+UXt9vfrZIbn/fPje9OvGb3DonUA90wieC
 QT7zdE4IzCLkChBSwwjklfALuvWxjhyw70befS6hbyco4keomNGR8k5OCvwmuoiyBPhMAYLG+iO
 pv2pJ0LfbfBBKBmTmKZOGJdzmt20+tzRqY2xm5MYvOnZP/zIvu708aJA1
X-Gm-Gg: ASbGncuwGuDO6Q0J+pdeYvRzC9hCvFpN0u//pZv8nM8PSETEy6MGWqCCEG099HCLi5j
 oUCI2H8KwrGnYwtio3NRJHcxPttWTtGiTwiLEOJKll5CoL+j71np53Ex6/R855c6KAMAE+Hoz1y
 xO6nAbXvifSOzFzSEGLXNoKztXqyf9MJY/qnwNqg2RN6b07/JiBl5/zRiuqbu75Fq8RAr9qAkcu
 iufuL/Sub7CEoIWnoVGMRQF+JQQJpT7jYaZurkuJLVuLyT+v4fXjC95DayzDgEdyB9f6mIfTsys
 f9S29qptOsd7mJnbnRgRYwUm8tKRmC+twYAyEkjQsf5pXpS/Q36Rj0bnzxtgogpE/0wcADPVpy8
 5FKB2SIpOKbRtfRg=
X-Received: by 2002:ad4:5ce6:0:b0:705:1647:6dfa with SMTP id
 6a1803df08f44-7092658f805mr39993036d6.17.1754055500485; 
 Fri, 01 Aug 2025 06:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0REkdrqN/t2nj33tJ240I9NzqELKbvtEVgSpUudMQoDn4QfA3wLBuCvAz+lecsAO9HMpMPA==
X-Received: by 2002:ad4:5ce6:0:b0:705:1647:6dfa with SMTP id
 6a1803df08f44-7092658f805mr39992476d6.17.1754055499853; 
 Fri, 01 Aug 2025 06:38:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cd5a438sm21689176d6.48.2025.08.01.06.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:38:19 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:38:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com
Subject: Re: [RFC 2/2] q35: add virtio-mmio slots
Message-ID: <vwghqjigkdbdfqdcq5drh7apgtm2ghw6jx7jrqa7gjiwzcaqbe@i27sy3m2rmie>
References: <20250701121815.523896-1-osteffen@redhat.com>
 <20250701121815.523896-3-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701121815.523896-3-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 01, 2025 at 02:18:15PM +0200, Oliver Steffen wrote:
>From: Gerd Hoffmann <kraxel@redhat.com>

I would mention SVSM in the commit title.

>
>Add virtio-mmio slots to the q35 machine model, intended to be used by
>an SVSM.
>
>Disabled by default, enable using '-machine q35,x-svsm-virtio-mmio=on'.

I guess we should remove the `x-` after the RFC, right?
And add some documentation.

In the future, we may have several things to configure for SVSM. Should 
we think of some specific object (e.g., svsm-cfg), or rather add 
properties to the machine type as in this case?

>
>When enabled it is possible to plug up to 4 virtio devices into the
>slots virtio-mmio using '-device virtio-${kind}-device'.
>
>The devices can be found at base address 0xfef00000, each slot on a

Disclaimer: I don't have much experience in allocating mmio addresses, 
but why that address?

Should we make it configurable/dynamic?

Thanks,
Stefano

>separate page.  No IRQ is wired up, the SVSM has to drive the devices
>in polling mode.
>
>The base addresses are communicated to the SVSM via the etc/hardware-info
>fw_cfg file.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> hw/i386/pc.c         | 18 +++++++++++++++++-
> hw/i386/pc_q35.c     | 15 +++++++++++++++
> include/hw/i386/pc.h |  1 +
> 3 files changed, 33 insertions(+), 1 deletion(-)
>
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index 432ab288a8..e1dbf8846d 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1584,6 +1584,21 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
>     visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
> }
>
>+static bool pc_machine_get_svsm_virtio_mmio(Object *obj, Error **errp)
>+{
>+    PCMachineState *pcms = PC_MACHINE(obj);
>+
>+    return pcms->svsm_virtio_mmio;
>+}
>+
>+static void pc_machine_set_svsm_virtio_mmio(Object *obj, bool value,
>+                                            Error **errp)
>+{
>+    PCMachineState *pcms = PC_MACHINE(obj);
>+
>+    pcms->svsm_virtio_mmio = value;
>+}
>+
> static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
>                                             const char *name, void *opaque,
>                                             Error **errp)
>@@ -1844,7 +1859,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>                                           "Set IGVM configuration");
> #endif
>
>-
>+    object_class_property_add_bool(oc, "x-svsm-virtio-mmio",
>+        pc_machine_get_svsm_virtio_mmio, pc_machine_set_svsm_virtio_mmio);
> }
>
> static const TypeInfo pc_machine_info = {
>diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>index cf871cfdad..b8511ae52a 100644
>--- a/hw/i386/pc_q35.c
>+++ b/hw/i386/pc_q35.c
>@@ -60,7 +60,9 @@
> #include "hw/mem/nvdimm.h"
> #include "hw/uefi/var-service-api.h"
> #include "hw/i386/acpi-build.h"
>+#include "hw/uefi/hardware-info.h"
> #include "target/i386/cpu.h"
>+#include "exec/target_page.h"
>
> /* ICH9 AHCI has 6 ports */
> #define MAX_SATA_PORTS     6
>@@ -335,6 +337,19 @@ static void pc_q35_init(MachineState *machine)
>         }
>     }
> #endif
>+
>+    if (pcms->svsm_virtio_mmio) {
>+        for (int dev = 0; dev < 4; dev++) {
>+            HARDWARE_INFO_SIMPLE_DEVICE hwinfo = {
>+                .mmio_address = cpu_to_le64(0xfef00000 + dev * TARGET_PAGE_SIZE),
>+            };
>+            sysbus_create_simple("virtio-mmio", hwinfo.mmio_address,
>+                                 /* no irq */ NULL);
>+            hardware_info_register(HardwareInfoVirtioMmioSvsm,
>+                                   &hwinfo, sizeof(hwinfo));
>+        }
>+    }
>+
> }
>
> #define DEFINE_Q35_MACHINE(major, minor) \
>diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>index 79b72c54dd..9c9f947087 100644
>--- a/include/hw/i386/pc.h
>+++ b/include/hw/i386/pc.h
>@@ -51,6 +51,7 @@ typedef struct PCMachineState {
>     bool i8042_enabled;
>     bool default_bus_bypass_iommu;
>     bool fd_bootchk;
>+    bool svsm_virtio_mmio;
>     uint64_t max_fw_size;
>
>     /* ACPI Memory hotplug IO base address */
>-- 
>2.50.0
>


