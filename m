Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B750CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgSV-0005C6-JJ; Thu, 11 Jun 2026 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXgSL-0005AJ-Ua
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:32:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXgSI-00007V-Db
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:32:28 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bf0170c80f7so1388819466b.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781188344; cv=none;
 d=google.com; s=arc-20240605;
 b=k20c2iiz60exQ3mOi5Zh4tz4ZuNfOouhjGbJzPX+FAhjN+HbLb+BAVnuUbLORxMiXy
 FxeCrZvN9FP2KtigQv6FxJuLR72ClIlSTbJNfpUPzHlKYoMCVt7U6Uevs7bZvJ6Asm1J
 vMlT4SrzD6rSrwYvSzNRs/ikXFb98ewxs/W9kKFRP84zetY2sJMGtwRCUCkoJ0IGUe1/
 8HDKtAElzvoKay9UNV+J6ZqRLaePvUHKSJenKHzUQCTneuH4Ru2CGqKhZ/3ep2oQ/p26
 ySixYQgqDB4gfpvgcGEAtkEk3iYKY0Lbm9fe1F1mx8mRw30afgQHeCfyG6KXndk54o+s
 Zllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vf/k2Y7UmsvoSpdII/pFU/Y5It4XZcG4y+JsGCn+dfM=;
 fh=tyFbt0zbqDZt/UGefrVID+s2Gqd6hBFAn2motV8AunM=;
 b=J8uRNPuaL/H8DcGXla849F/g0yvs+5ZiQkYpt1hov3mpsSvTepiU6C6NTs55Y0if6w
 XcL2YT/ubDwDhAHPOSRsjs3VEgTqNKD4D5jw9FUvyvozB0hipfcMo+g4Sl2tdOm2+K1y
 bT2pxpeC0RR+Eqza/P1Q//bduiSDhbG6z0tXag9GA5/UcQh1YdFkJgLhYgzvsA/n+7SW
 QX6JgxNeW3wZny/50xtIOskuTfwhlgGuHr6xJCTAZm699/5Z+IdO5b1G5DILsuy79ua7
 9+BhbhcXPXkplC68HcQO5ZkwAke6UKvuH3E0KU1S9y9sXTsEOJixpJxPvjPm/V4b6mJ0
 mbGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781188344; x=1781793144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vf/k2Y7UmsvoSpdII/pFU/Y5It4XZcG4y+JsGCn+dfM=;
 b=T/RsoM4TSFtz8hEudOl1Efq80E9xIwctCO/njkIs6uBkI2Ssj9/JCssTDsS1HHm8Di
 HaqxJwZiWLaSrCkcqeu+HZWPFBjEP+oxuACMYBG+veoRAg8cxuxf6fNGkNDzYscKwl4X
 dNuIYkAhGJpiNNZEpp3QGmDe/KiCOF7gMpJWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781188344; x=1781793144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vf/k2Y7UmsvoSpdII/pFU/Y5It4XZcG4y+JsGCn+dfM=;
 b=TxNA7xz3LEN75cbK87KmJcoLRAahTOnsrz0wSkT4e7eQ/z7iPyY33dj9lULC//nFcB
 Z1wetnDICHECHIsRbTxmMBSImyBYSTKw/RVp0sJjvrMs26M/2QkvU/C2j1lrFfAfjltR
 P+8FpEa+y908qdkjM3IV7i6A4anq8B8hsFCYRGM0AqwhGDPA7CNbA5hoQZQIx1yPKime
 4DUh75IOAoZNeJUpRNOhAVMes67qeSg18fkkCNF7A2TZmlkqmv7nw20MHGyOfg95NADZ
 zS2RtM5oggnj4UcU1aghBAyGfIXIJh8+qAQm7Yxl95y0vmUtkVGYfeI8qvrHK2DEw9r/
 NoyA==
X-Gm-Message-State: AOJu0YzljpgPeW6jAmXAOGZiUhTBrgk+r7vedRlBun2YN9rSsp3GYG16
 90NgnVEq5FVRhh94PLCR3P8W2+F3PpGtqovhJ7qCpIfQuh9AxFNWB77HGvQ/pu+0j9oWhjpv3GC
 kD3vNPYJUTgwcWeHY0qhx49UjqxglH3Fw9s+W8by9/A==
X-Gm-Gg: Acq92OHuQpB5fwqfU4CtW+7gCYfeqL6KCglQ05dI9/yvIBwr2vNr6TpbPC+FDziYGS1
 dC55ADsI6J7JC8GWZkEMtFTiWowGc1V3stMBUBFTZYvQ17omS1NhFlilNxQ3oEOzB7OSNIwOurE
 LWCzigncZzkWVMvDoIPWdcVRDWQmpNBjADCITOQNtpieKv9Ul5V8mKn/drErx0tv+bsefdCwjNb
 OSQtx5d0HkQ6EaArOTbuSXVc++tVT9YBebKjAnY30Kb3sRjGLd+vq0EI8zs4QrHnQfwGDV/4Qvk
 45n8WNaSf7igOV7rrMxa2tvhKXqPgY8jgvMvDVmE5jl8wgpB7Q==
X-Received: by 2002:a17:907:97c8:b0:bd3:1a18:cc64 with SMTP id
 a640c23a62f3a-bfc885ee02emr147622766b.31.1781188343363; Thu, 11 Jun 2026
 07:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260611112249.165012-1-alexander@mihalicyn.com>
 <20260611112249.165012-3-alexander@mihalicyn.com> <87mrx14314.fsf@suse.de>
 <CAJqdLrqr8BkFVxy6YsLVXYStKbAx9mKSd6xiV4cJEt6+n3-uYg@mail.gmail.com>
 <87jys540ky.fsf@suse.de>
In-Reply-To: <87jys540ky.fsf@suse.de>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 11 Jun 2026 16:32:12 +0200
X-Gm-Features: AVVi8CdpfmUPEKldfWcVxvN5FeYC4ngSrB3OHZXqXvVyTZzK1aYOzRwJPK6RdSw
Message-ID: <CAJqdLrp9sK-0d+8Vw=AShXgQAFH0c-rf3+qVg1Mah6eCh3niSA@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] hw/nvme: add migration blockers for non-supported
 cases
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Do., 11. Juni 2026 um 16:24 Uhr schrieb Fabiano Rosas <farosas@suse.de>:
>
> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
>
> > Am Do., 11. Juni 2026 um 15:31 Uhr schrieb Fabiano Rosas <farosas@suse.de>:
> >>
> >> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
> >>
> >> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >> >
> >> > Let's block migration for cases we don't support:
> >> > - SR-IOV
> >> > - CMB
> >> > - PMR
> >> > - SPDM
> >> >
> >> > No functional changes here, because NVMe migration is
> >> > not supported at all as of this commit.
> >> >
> >> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> >> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >> > ---
> >> > v9:
> >> >     - check-patch trivial fixes
> >> > ---
> >> >  hw/nvme/ctrl.c       | 211 +++++++++++++++++++++++++++++++++++++++++++
> >> >  hw/nvme/nvme.h       |   3 +
> >> >  include/block/nvme.h |  12 +++
> >> >  3 files changed, 226 insertions(+)
> >> >
> >> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> >> > index 815f39173c8..7510a9e0296 100644
> >> > --- a/hw/nvme/ctrl.c
> >> > +++ b/hw/nvme/ctrl.c
> >> > @@ -209,6 +209,7 @@
> >> >  #include "hw/pci/msix.h"
> >> >  #include "hw/pci/pcie_sriov.h"
> >> >  #include "system/spdm-socket.h"
> >> > +#include "migration/blocker.h"
> >> >  #include "migration/vmstate.h"
> >> >
> >> >  #include "nvme.h"
> >> > @@ -252,6 +253,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
> >> >      [NVME_COMMAND_SET_PROFILE]      = true,
> >> >      [NVME_FDP_MODE]                 = true,
> >> >      [NVME_FDP_EVENTS]               = true,
> >> > +    /* if you add something here, please update nvme_set_migration_blockers() */
> >> >  };
> >> >
> >> >  static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
> >> > @@ -4603,6 +4605,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
> >> >          return 0;
> >> >      case NVME_IOMS_MO_RUH_UPDATE:
> >> >          return nvme_io_mgmt_send_ruh_update(n, req);
> >> > +    /* if you add something here, please update nvme_set_migration_blockers() */
> >> >      default:
> >> >          return NVME_INVALID_FIELD | NVME_DNR;
> >> >      };
> >> > @@ -7522,6 +7525,10 @@ static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> >> >
> >> >  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
> >> >  {
> >> > +    /*
> >> > +     * When adding a new dtype handling here,
> >> > +     * please also update nvme_set_migration_blockers().
> >> > +     */
> >> >      return NVME_INVALID_FIELD | NVME_DNR;
> >> >  }
> >> >
> >> > @@ -9233,6 +9240,204 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> >> >      }
> >> >  }
> >> >
> >> > +#define BLOCKER_FEATURES_MAX_LEN 256
> >> > +
> >> > +static inline void nvme_add_blocker_feature(char *blocker_features,
> >> > +                                            const char *feature)
> >> > +{
> >> > +    if (strlen(blocker_features) > 0) {
> >> > +        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> >> > +    }
> >> > +    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> >> > +}
> >> > +
> >> > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> >> > +                                        Error **errp)
> >> > +{
> >> > +    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> >> > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> >> > +    bool adm_cmd_security_checked = false;
> >> > +    bool cmd_io_mgmt_checked = false;
> >> > +    bool cmd_zone_checked = false;
> >> > +
> >> > +    /*
> >> > +     * Idea of this function is simple, we iterate over all Command Sets and
> >> > +     * for each supported command we provide a special handling logic to
> >> > +     * determine if we should block migration or not.
> >> > +     *
> >> > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> >> > +     * available to the guest, but if there is only 1 namespace, then it is
> >> > +     * safe to allow migration, but if there are more, then we need to block
> >> > +     * migration because we don't handle this in migration code yet.
> >> > +     */
> >> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.acs); opcode++) {
> >> > +        /* Is command supported? */
> >> > +        if (!n->cse.acs[opcode]) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        switch (opcode) {
> >> > +        case NVME_ADM_CMD_DELETE_SQ:
> >> > +        case NVME_ADM_CMD_CREATE_SQ:
> >> > +        case NVME_ADM_CMD_GET_LOG_PAGE:
> >> > +        case NVME_ADM_CMD_DELETE_CQ:
> >> > +        case NVME_ADM_CMD_CREATE_CQ:
> >> > +        case NVME_ADM_CMD_IDENTIFY:
> >> > +        case NVME_ADM_CMD_ABORT:
> >> > +        case NVME_ADM_CMD_SET_FEATURES:
> >> > +        case NVME_ADM_CMD_GET_FEATURES:
> >> > +        case NVME_ADM_CMD_ASYNC_EV_REQ:
> >> > +        case NVME_ADM_CMD_DBBUF_CONFIG:
> >> > +        case NVME_ADM_CMD_FORMAT_NVM:
> >> > +        case NVME_ADM_CMD_DIRECTIVE_SEND:
> >> > +        case NVME_ADM_CMD_DIRECTIVE_RECV:
> >> > +            break;
> >> > +        case NVME_ADM_CMD_NS_ATTACHMENT:
> >> > +            int namespaces_num = 0;
> >>
> >> Hi, clang flags this:
> >>
> >> ../hw/nvme/ctrl.c:9385:13: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
> >>  9385 |             int namespaces_num = 0;
> >>       |             ^
> >>
> >
> > Hi Fabiano,
> >
> > ugh, I'll handle this. Let me then burn even more CI minutes and run
> > every single test in the matrix :)
> >
>
> I'm not sure if the CI would catch this, I run different tests
> locally.
>
> > Sorry about making a noise by making submissions with a stupid mistakes :(
> >
>
> It's completely fine, don't worry. We're close to merging this, I was
> just running a final set of tests to give my ack. It's good that we
> caught it before merge.

thank you! ;)

I've also caught something now on Alpine (PAGE_SIZE macro redefinition
error), I've fixed this
and now running tests just to make sure all fine now.

I'll get back to this thread once I get everything green on CI.

>
> > Kind regards,
> > Alex
> >
> >>
> >> > +            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> >> > +                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
> >> > +                if (!ns) {
> >> > +                    continue;
> >> > +                }
> >> > +
> >> > +                namespaces_num++;
> >> > +            }
> >> > +
> >> > +            if (namespaces_num > 1) {
> >> > +                nvme_add_blocker_feature(blocker_features,
> >> > +                                         "Namespace Attachment");
> >> > +            }
> >> > +
> >> > +            break;
> >> > +        case NVME_ADM_CMD_VIRT_MNGMT:
> >> > +            if (n->params.sriov_max_vfs) {
> >> > +                nvme_add_blocker_feature(blocker_features, "SR-IOV");
> >> > +            }
> >> > +
> >> > +            break;
> >> > +        case NVME_ADM_CMD_SECURITY_SEND:
> >> > +        case NVME_ADM_CMD_SECURITY_RECV:
> >> > +            if (adm_cmd_security_checked) {
> >> > +                break;
> >> > +            }
> >> > +
> >> > +            if (pci_dev->spdm_port) {
> >> > +                nvme_add_blocker_feature(blocker_features, "SPDM");
> >> > +            }
> >> > +
> >> > +            adm_cmd_security_checked = true;
> >> > +
> >> > +            break;
> >> > +        default:
> >> > +            g_assert_not_reached();
> >> > +        }
> >> > +    }
> >> > +
> >> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.nvm); opcode++) {
> >> > +        if (!n->cse.iocs.nvm[opcode]) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        switch (opcode) {
> >> > +        case NVME_CMD_FLUSH:
> >> > +        case NVME_CMD_WRITE:
> >> > +        case NVME_CMD_READ:
> >> > +        case NVME_CMD_COMPARE:
> >> > +        case NVME_CMD_WRITE_ZEROES:
> >> > +        case NVME_CMD_DSM:
> >> > +        case NVME_CMD_VERIFY:
> >> > +        case NVME_CMD_COPY:
> >> > +            break;
> >> > +        case NVME_CMD_IO_MGMT_RECV:
> >> > +        case NVME_CMD_IO_MGMT_SEND:
> >> > +            if (cmd_io_mgmt_checked) {
> >> > +                break;
> >> > +            }
> >> > +
> >> > +            /* check for NVME_IOMS_MO_RUH_UPDATE */
> >> > +            if (n->subsys->params.fdp.enabled) {
> >> > +                nvme_add_blocker_feature(blocker_features, "FDP");
> >> > +            }
> >> > +
> >> > +            cmd_io_mgmt_checked = true;
> >> > +
> >> > +            break;
> >> > +        default:
> >> > +            g_assert_not_reached();
> >> > +        }
> >> > +    }
> >> > +
> >> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.zoned); opcode++) {
> >> > +        /*
> >> > +         * If command isn't supported or we have the same command
> >> > +         * in n->cse.iocs.nvm, then we can skip it here.
> >> > +         */
> >> > +        if (!n->cse.iocs.zoned[opcode] || n->cse.iocs.nvm[opcode]) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        switch (opcode) {
> >> > +        case NVME_CMD_ZONE_APPEND:
> >> > +        case NVME_CMD_ZONE_MGMT_SEND:
> >> > +        case NVME_CMD_ZONE_MGMT_RECV:
> >> > +            if (cmd_zone_checked) {
> >> > +                break;
> >> > +            }
> >> > +
> >> > +            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> >> > +                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
> >> > +                if (!ns) {
> >> > +                    continue;
> >> > +                }
> >> > +
> >> > +                if (ns->params.zoned) {
> >> > +                    nvme_add_blocker_feature(blocker_features,
> >> > +                                             "Zoned Namespace");
> >> > +                    break;
> >> > +                }
> >> > +            }
> >> > +
> >> > +            cmd_zone_checked = true;
> >> > +
> >> > +            break;
> >> > +        default:
> >> > +            g_assert_not_reached();
> >> > +        }
> >> > +    }
> >> > +
> >> > +    /*
> >> > +     * Try our best to explicitly detect all not supported caps,
> >> > +     * to let users know what features cause migration to be blocked,
> >> > +     * but in case we miss handling here, everything else will be
> >> > +     * covered by unsupported_cap check.
> >> > +     */
> >> > +    if (NVME_CAP_CMBS(cap)) {
> >> > +        nvme_add_blocker_feature(blocker_features, "CMB");
> >> > +        cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
> >> > +    }
> >> > +
> >> > +    if (NVME_CAP_PMRS(cap)) {
> >> > +        nvme_add_blocker_feature(blocker_features, "PMR");
> >> > +        cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
> >> > +    }
> >> > +
> >> > +    unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
> >> > +    if (unsupported_cap) {
> >> > +        nvme_add_blocker_feature(blocker_features, "unknown capability");
> >> > +    }
> >> > +
> >> > +    assert(n->migration_blocker == NULL);
> >> > +    if (strlen(blocker_features) > 0) {
> >> > +        error_setg(&n->migration_blocker,
> >> > +                   "Migration is not supported for %s", blocker_features);
> >> > +        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
> >> > +            return false;
> >> > +        }
> >> > +    }
> >> > +
> >> > +    return true;
> >> > +}
> >> > +
> >> >  static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
> >> >  {
> >> >      int cntlid;
> >> > @@ -9338,6 +9543,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >> >
> >> >          n->subsys->namespaces[ns->params.nsid] = ns;
> >> >      }
> >> > +
> >> > +    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
> >> > +        return;
> >> > +    }
> >> >  }
> >> >
> >> >  static void nvme_exit(PCIDevice *pci_dev)
> >> > @@ -9390,6 +9599,8 @@ static void nvme_exit(PCIDevice *pci_dev)
> >> >      }
> >> >
> >> >      memory_region_del_subregion(&n->bar0, &n->iomem);
> >> > +
> >> > +    migrate_del_blocker(&n->migration_blocker);
> >> >  }
> >> >
> >> >  static const Property nvme_props[] = {
> >> > diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> >> > index 5ef3ebee29e..05aee24a15c 100644
> >> > --- a/hw/nvme/nvme.h
> >> > +++ b/hw/nvme/nvme.h
> >> > @@ -668,6 +668,9 @@ typedef struct NvmeCtrl {
> >> >
> >> >      /* Socket mapping to SPDM over NVMe Security In/Out commands */
> >> >      int spdm_socket;
> >> > +
> >> > +    /* Migration-related stuff */
> >> > +    Error *migration_blocker;
> >> >  } NvmeCtrl;
> >> >
> >> >  typedef enum NvmeResetType {
> >> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> >> > index e4e7be51205..17a7c7818d7 100644
> >> > --- a/include/block/nvme.h
> >> > +++ b/include/block/nvme.h
> >> > @@ -141,6 +141,18 @@ enum NvmeCapMask {
> >> >  #define NVME_CAP_SET_CMBS(cap, val)   \
> >> >      ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
> >> >
> >> > +#define NVME_MIGRATION_SUPPORTED_CAP_BITS ( \
> >> > +      ((uint64_t)CAP_MQES_MASK   << CAP_MQES_SHIFT)   \
> >> > +    | ((uint64_t)CAP_CQR_MASK    << CAP_CQR_SHIFT)    \
> >> > +    | ((uint64_t)CAP_AMS_MASK    << CAP_AMS_SHIFT)    \
> >> > +    | ((uint64_t)CAP_TO_MASK     << CAP_TO_SHIFT)     \
> >> > +    | ((uint64_t)CAP_DSTRD_MASK  << CAP_DSTRD_SHIFT)  \
> >> > +    | ((uint64_t)CAP_NSSRS_MASK  << CAP_NSSRS_SHIFT)  \
> >> > +    | ((uint64_t)CAP_CSS_MASK    << CAP_CSS_SHIFT)    \
> >> > +    | ((uint64_t)CAP_MPSMIN_MASK << CAP_MPSMIN_SHIFT) \
> >> > +    | ((uint64_t)CAP_MPSMAX_MASK << CAP_MPSMAX_SHIFT) \
> >> > +)
> >> > +
> >> >  enum NvmeCapCss {
> >> >      NVME_CAP_CSS_NCSS    = 1 << 0,
> >> >      NVME_CAP_CSS_IOCSS   = 1 << 6,

