Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A3CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMEC-0004AO-6p; Tue, 19 May 2026 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPMEA-00041p-If
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:19:26 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPME8-00073I-Bd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:19:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4247A6020F;
 Tue, 19 May 2026 15:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D53C2BCC6;
 Tue, 19 May 2026 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779203963;
 bh=c6iikp5bIksESua5fvx7pi42ccOi0MJq6BG5NtzchzQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kYBQWRhQhfiXWFg++9dFB2SBh5WfR7mzgkD64U2DOpMHt4hvh95VZdlfR1eNan+0G
 MgPnvGoxYxzeXDYVB9wiG2yBa3ejJX67d9csEmUBKb2sdM9h1+NiVQ9UanLW/8ynqu
 +JImpvLRdieAfz8hyJ9pofoPcrv6GFF4MlUW2kurG2hejbxG2c+Co3JROehGg84iel
 7058r/9hSId3giENOVAiaRQ5FM67UaYE+hmAFJ3gfniU9NOkQejagFlW0PLthDRtnF
 FK12DJq8ROoRDao97xUMyJZNEMGppmq0iLdJyPzLXaTS5S8nX25YuzZ76++vMvL6TU
 uNCMypm1YFKdg==
Date: Tue, 19 May 2026 16:19:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 05/10] cxl-vcs-switch: Initial support for CXL
 VCS.
Message-ID: <20260519161914.05f81703@jic23-huawei>
In-Reply-To: <20260429135717.3048713-6-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-6-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Apr 2026 14:48:39 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Add initial support for VCS (multi-USP/multi-logic-device) switch
> emulation in CXL. Currently the object only supports the identify/bind/unbind
> commands (0x5200/0x5201/0x5202), as well as support for device hiding
> listeners. This enables preliminary testing of the VCS capability,
> but will not allow for complete emulated flow as described in
> spec (CXL v3.2, 7.2.3). Nor will it allow for multiple USP's to be
> disributed over multiple QEMU instances.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>
> ---
>  hw/cxl/cxl-vcs-switch.c         | 524 ++++++++++++++++++++++++++++++++

We need to make it explicit this is a multiple-vcs switch
Or not bother given other switches don't have an explicit representation
so we could just call it cxl_switch :)


A few trivial things follow.

I'm trying to get my head around how we handle state given we ultimately 
can't wait to realise until binding because we need to be able to
do pre binding init of devices etc.

MLDs will be more fun at somepoint as well if we care to go that way.

Anyhow, this is very much first look rather than a detailed review.

> +
> +/* When a device is instantiated downstream of a VCS's PPB, we
> + * store the qdicts from the CLI, to realize the device at a
> + * future time.
> + */
> +bool cxl_vcs_hide_device_listener(DeviceListener *listener, const QDict *opts,
> +                        bool from_json, Error **errp)
> +{
> +    CXLVCSSwitch *vcs = container_of(listener, CXLVCSSwitch, listener);
> +    const char *vcs_id_str   = qdict_get_try_str(opts, "vcs");
stray space.

> +    const char *ppb_str = qdict_get_try_str(opts, "dsppb");
> +    int ppb;
> +

> +
> +static void vcs_set_usp_ppbs(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
> +    uint8_t val;
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +    vcs->num_usp_ppbs = val;
> +}
Blank line between functions.

> +static void vcs_get_dsp_ppbs(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
> +    uint8_t val = vcs->num_dsp_ppbs;
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void vcs_set_dsp_ppbs(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    CXLVCSSwitch *vcs = CXL_VCS_SWITCH(obj);
> +    uint8_t val;
Blank line - same in similar places. Normally separate declarations and
body of code.

> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +    vcs->num_dsp_ppbs = val;
> +}
> +
> +static void cxl_vcs_class_init(ObjectClass *oc, const void *data)
> +{
> +    CXLVCSSwitchClass *cc = CXL_VCS_SWITCH_CLASS(oc);
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);

Bank line here.

> +    ucc->complete = cxl_vcs_switch_complete;
> +    ucc->can_be_deleted = cxl_vcs_switch_can_be_deleted;
> +    cc->identify_switch_device = cxl_vcs_identify_switch_device;
> +    cc->get_physical_port_state = cxl_vcs_get_physical_port_state;
> +    cc->physical_port_control = cxl_vcs_physical_port_control;
> +    cc->get_virtual_switch_info = cxl_vcs_get_virtual_switch_info;
> +    cc->bind_vppb = cxl_vcs_bind_vppb;
> +    cc->unbind_vppb = cxl_vcs_unbind_vppb;
> +
> +    object_class_property_add_bool(oc, "local-fm",
> +                              cxl_vcs_get_local_fm, cxl_vcs_set_local_fm);
As below - drop for now.

> +    object_class_property_set_description(oc, "local-fm",
> +        "true = FM authority (mctp connected guest), \
> +        false = slave listener (IPC)");
Likewise.

> +    object_class_property_add(oc, "usp-ppbs", "uint8",
> +                          vcs_get_usp_ppbs, vcs_set_usp_ppbs,
> +                          NULL, NULL);
> +    object_class_property_set_description(oc, "usp-ppbs",
> +        "Number of upstream ports in the switch");
> +    object_class_property_add(oc, "dsp-ppbs", "uint8",
> +                          vcs_get_dsp_ppbs, vcs_set_dsp_ppbs,
> +                          NULL, NULL);
> +    object_class_property_set_description(oc, "dsp-ppbs",
> +        "Number of downstream ports in the switch");
> +}
>
> diff --git a/include/hw/cxl/cxl_vcs_switch.h b/include/hw/cxl/cxl_vcs_switch.h
> new file mode 100644
> index 0000000000..6576870bf3
> --- /dev/null
> +++ b/include/hw/cxl/cxl_vcs_switch.h
> @@ -0,0 +1,134 @@
> +/*
> + * CXL VCS Capable Switch Object Header
No point in stating it's a header.

> + *
> + * Copyright(C) 2026 University of Manchester
> + * Author: Joshua Lant <joshualant@gmail.com>.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.

If you are fine with many folk just use SPDX on it's own now.

> + *
> + * SPDX-License-Identifier: GPL-v2-only
> + */
> +
> +#ifndef CXL_VCS_SWITCH_H
> +#define CXL_VCS_SWITCH_H
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object.h"
> +#include "qom/object_interfaces.h"
> +#include "hw/pci-bridge/cxl_upstream_port.h"
> +#include "hw/pci-bridge/cxl_downstream_port.h"
> +#include "include/hw/cxl/cxl_device.h"
> +
> +#define TYPE_CXL_VCS_SWITCH "cxl-vcs-switch"
> +OBJECT_DECLARE_TYPE(CXLVCSSwitch, CXLVCSSwitchClass, CXL_VCS_SWITCH);
> +
> +#define CXL_VPPB_BINDING_STATUS_UNBOUND        0x00
> +#define CXL_VPPB_BINDING_STATUS_IN_PROGRESS    0x01
> +#define CXL_VPPB_BINDING_STATUS_BOUND_PORT     0x02
> +#define CXL_VPPB_BINDING_STATUS_BOUND_LD       0x03
> +#define CXL_VPPB_BINDING_STATUS_BOUND_PID      0x04
> +
> +#define CXL_VPPB_UNBIND_WAIT_FOR_LINK_DOWN      0x0
> +#define CXL_VPPB_UNBIND_MANAGED_HOT_REMOVE      0x1
> +#define CXL_VPPB_UNBIND_SURPRISE_HOT_REMOVE     0x2
> +
> +#define CXL_UNSUPPORTED_LD_ID 0xFFFF
> +#define CXL_INVALID_BOUND_LD_ID 0xFF
> +
> +#define CXL_VCS_STATE_INVALID_ID        0xFF
> +#define CXL_VCS_STATE_DISABLED 0x0
> +#define CXL_VCS_STATE_ENABLED 0x1
> +
> +#define CXL_MAX_VCS_PORTS 0x8
> +#define CXL_MAX_VPPB_PER_VCS 0x8
> +#define CXL_MAX_USP_PPBS CXL_MAX_VCS_PORTS
> +#define CXL_MAX_DSP_PPBS CXL_MAX_VPPB_PER_VCS
> +
> +#define CXL_MAX_PPBS (CXL_MAX_USP_PPBS + CXL_MAX_DSP_PPBS)
> +#define VPPB_LIST_LIMIT 8
> +
> +struct CXLVCSSwitchClass {
> +    ObjectClass parent_class;
> +    void (*identify_switch_device)(CXLVCSSwitch *sw);
> +    void (*get_physical_port_state)(CXLVCSSwitch *sw);
> +    void (*physical_port_control)(CXLVCSSwitch *sw);
> +    void (*get_virtual_switch_info)(CXLVCSSwitch *sw);
> +    CXLRetCode (*bind_vppb)(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
> +            uint8_t dsppb_id, uint16_t ld_id);
> +    CXLRetCode (*unbind_vppb)(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
> +            uint16_t option);
> +};
> +
> +/* CXL r3.2 Table 7-32: Get Virtual CXL Switch Info VCS Info Block Format */
We tend to use latest available spec for new stuff. So if you can
reference CXL 4.0 that would preferred.

This is driven by the silly policy of now making old specs easily
available.

> +typedef struct CXLVPPBInfo {
> +        PCIDevice *dsp;
> +        uint8_t binding_status;
> +        uint8_t bound_port_id;
> +        uint8_t bound_ld_id;
> +        uint8_t rsv1;
> +} CXLVPPBInfo;
> +
> +typedef struct CXLVCSInfoBlock {
> +        uint8_t vcs_id;
> +        uint8_t vcs_state;
> +        uint8_t usp_id;
> +        uint8_t num_vppbs;
> +        struct CXLVPPBInfo *vppbs[CXL_MAX_VPPB_PER_VCS];
> +} CXLVCSInfoBlock;
> +
> +/* Physical Upstream and Downstream PCI-PCI Bridge (PPBs) structs */

I'd split the comment in two. Kind of obvious but I misread
it as referring to this struct for both of them.

> +typedef struct CXLUpstreamPPB {
> +    CXLUpstreamPort   *usp;
> +    struct CXLVCSInfoBlock *info;
> +} CXLUpstreamPPB;
> +
> +typedef struct CXLDownstreamPPB {
> +    DeviceState *dev;
> +    PCIDevice   *pdev;
> +    // store opts and json in case of simple device hiding.
> +    QDict       *opts;
> +    bool        from_json;
> +    bool        is_bound;
> +    uint8_t     bound_vcs_id;
> +    uint8_t     bound_vppb_id;
> +} CXLDownstreamPPB;
> +
> +typedef struct CXLVCSSwitch {
> +    Object parent;
> +    uint8_t num_usp_ppbs;
> +    uint8_t num_dsp_ppbs;
> +    uint8_t num_vppbs_per_vcs;
> +    CXLCCI swcci;
> +    CXLCCI mctpcci;
> +    DeviceListener listener;
> +    CXLUpstreamPPB *usp_ppbs[CXL_MAX_USP_PPBS];
> +    CXLDownstreamPPB *dsp_ppbs[CXL_MAX_DSP_PPBS];
> +    // true if FM is in this guest, false if remote FM.
> +    bool local_fm;

As mentioned in comments on cover letter. Drop this for now.

> +} CXLVCSSwitch;
> +
> +// Called by USP/DSP/EP CXL devices to build the VCS structures.
> +void cxl_vcs_register_usp(CXLVCSSwitch *sw, CXLUpstreamPort *usp, Error **errp);
> +void cxl_vcs_register_vppb(CXLVCSSwitch *sw, CXLUpstreamPort *usp,
> +        CXLDownstreamPort *dsp, Error **errp);
> +void cxl_vcs_register_dsppb(CXLVCSSwitch *sw, const QDict *opts,
> +        bool from_json, Error **errp);
> +void cxl_vcs_register_qdict_dsppb(CXLVCSSwitch *sw, const QDict *opts,
> +        bool from_json, Error **errp);
> +bool cxl_vcs_hide_device_listener(DeviceListener *listener,
> +        const QDict *device_opts, bool from_json, Error **errp);
> +
> +
> +// Called by the CCI mailbox utils for FMAPI control of VCS.
> +CXLRetCode cxl_vcs_bind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id, uint8_t vppb_id,
> +        uint8_t dsppb_id, uint16_t ld_id);
> +CXLRetCode cxl_vcs_unbind_vppb(CXLVCSSwitch *sw, uint8_t vcs_id,
> +        uint8_t vppb_id, uint16_t option);
> +void cxl_vcs_identify_switch_device(CXLVCSSwitch *sw);
> +void cxl_vcs_get_physical_port_state(CXLVCSSwitch *sw);
> +void cxl_vcs_physical_port_control(CXLVCSSwitch *sw);
> +void cxl_vcs_get_virtual_switch_info(CXLVCSSwitch *sw);


