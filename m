Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0845CCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfrO-0004c6-BA; Thu, 11 Jun 2026 09:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXfrG-0004Xl-O4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:54:11 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXfrD-0003YM-UH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:54:10 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso1048330366b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781186046; cv=none;
 d=google.com; s=arc-20240605;
 b=K69m8egRImeiJZdG6PVwas41/aCOqrESN81uJmYzdVMTJhd/n3gYK//pWMdog8aVXF
 if+VkQRdlaBczf7it04Yadyl16vKf9FfsxBhpFzwB4P9mpACcfK18clG57lhKoD+Eg26
 xCwF/LHOZrroe+IMGPk38iomw9SIksfl9fP7lmXxwDZ6LHL3ouLKqiWX66LLB2M4ZIxk
 zfSH4DR4nAXJUqg8cYkfONNMSa5dkitoQcFE6MAfDooaqTPele4lCUoUs6aFb5w3Xnog
 SKKVWgpyo/NqHkiIJ0beScekFnwLeZny5MK7kCfFdbsrr/jmHGBhGMnavm8yPxyLYDCf
 6sCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yoC7f7fs2KBPujWHs7C4iGvN9nQyCG5Sl6ATXDF1Mw4=;
 fh=tyFbt0zbqDZt/UGefrVID+s2Gqd6hBFAn2motV8AunM=;
 b=kCfwGROvhoRZc2/UgMllwv9EK0zbZtNrcSz4nyJwXdusIA2+9ctAQt4Oz0Wx0Udb2v
 NQYDRYYQm3WX2Cwo0k84WGkEBfdgowYsNNYOC6jH3IhXNp8LWBMUF2MwcyLQRckhSz3h
 wVjl5UOQSPy9VeTfsoWL8BOOkfeL64nKEY/4EtBVh6Krt3btwZLLmEXWd6Ef+XPAbtbg
 wczcMC/cQYe6cHp+wEQRWJe9AWcPGHdebbGicmc38ZEFjSpHbRwFMQv2/zuUJGsU2n8u
 K8dx6HhPe5NIsh2OQhb1wiuaXU0n+o/seytqPfP/9wrrHEpJJV5v8Fh0PLrJnKQdkpKQ
 txFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781186046; x=1781790846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yoC7f7fs2KBPujWHs7C4iGvN9nQyCG5Sl6ATXDF1Mw4=;
 b=UnsYiXmLA0ueJewCGaIEMQrmGkXtjlcDt1zowXHh63HQ8Wlvlu86gWO55/GlfvxfN8
 v8YmJTA/Zx6a4roz13IwizJXPsNm4UA2oJXyp8J/jrLc0tbFFSProurDxl7x1xRxtST7
 YZW/OkpDHB14nCmDPHD75WPyEYPTs+PknksBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186046; x=1781790846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoC7f7fs2KBPujWHs7C4iGvN9nQyCG5Sl6ATXDF1Mw4=;
 b=oalXbKZiTiaChxsHPjw5CDLhlZ2mYUk3pHU1z0zPvzG/nKg0PAA1WgEnVn9I42XSJ6
 15Y5T4RfevXuO5tqs2TYGIZiupo38cTL82MqPW+r6YaR6HFcAIfiAhBu2DfCahx00D1b
 3gDYkzNJ0RuMOLAe3/+lbXoDvDWrMNVb4Ht/visw6co7FFsqguq8cAcN2HrUxUVvINps
 42crR7gPWusMuUr9dy6yIgn9FLL5adkERMfCjH0ZvHXo1/owH868TurQOkCC9RmymjKI
 cDt2QBJlyVliRq3APWPN8b/Zj42SzgtyOlpJXcRQieYvyT/MEn1CLmMKm+Pmqk5Lze5H
 jg5g==
X-Gm-Message-State: AOJu0YyHEzBzb/l1GPU025FrrUk/2piJjPINsM/cZ0K0+1Zhvu+I3fvH
 0qzJHPBWHsoyHqO80gWmgCDv84QJHFAuq5hhISOdyfAtxptAhKF9IJrQvbJkXKFtpGl6wDt+krX
 BsNFbOnEVFpNzbED37liCTHYV1LdmPgIRw5Zx/lMKqg==
X-Gm-Gg: Acq92OHeY0EduIN5cfuUP2hOF3k6FJPjvUifnf3D2bUwcFCJKpstGGackO3B2NWEbYo
 oTr4/PHrrw3yOZeUt6+VIyihy5te7N9mypj+eOBBnmnQDay3ahklOsSi18bCWAGqHvX2FN3MNqw
 9B04hpfvY+QbBrjiXVtwcK6b8WxIPNuiIFqW3mWZIReITCQco9OMigp5v6n5PDlZ5DWJGZNEv0r
 AQebmEOm9EQ4zC0sDvvwvbvJndrx4EddTF1b7tCPwGmOSE16ArWEO+xm/BlhfdEfiR/Vm8TtJs0
 4sZYgUJXp15UGovQRMRq/Wbhs60IMMf45RT2byZ/Xm54FNjiZg==
X-Received: by 2002:a17:906:4fd1:b0:bec:929b:cedb with SMTP id
 a640c23a62f3a-bfc884ef0abmr156512666b.46.1781186045856; Thu, 11 Jun 2026
 06:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260611112249.165012-1-alexander@mihalicyn.com>
 <20260611112249.165012-3-alexander@mihalicyn.com> <87mrx14314.fsf@suse.de>
In-Reply-To: <87mrx14314.fsf@suse.de>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 11 Jun 2026 15:53:53 +0200
X-Gm-Features: AVVi8CczkLrWM46t8yan40td2-GGJmP0XhAGZ51i8fxwL3sQdoog6dPZ6q4T_vU
Message-ID: <CAJqdLrqr8BkFVxy6YsLVXYStKbAx9mKSd6xiV4cJEt6+n3-uYg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Do., 11. Juni 2026 um 15:31 Uhr schrieb Fabiano Rosas <farosas@suse.de>:
>
> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
>
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Let's block migration for cases we don't support:
> > - SR-IOV
> > - CMB
> > - PMR
> > - SPDM
> >
> > No functional changes here, because NVMe migration is
> > not supported at all as of this commit.
> >
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > ---
> > v9:
> >     - check-patch trivial fixes
> > ---
> >  hw/nvme/ctrl.c       | 211 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/nvme/nvme.h       |   3 +
> >  include/block/nvme.h |  12 +++
> >  3 files changed, 226 insertions(+)
> >
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 815f39173c8..7510a9e0296 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -209,6 +209,7 @@
> >  #include "hw/pci/msix.h"
> >  #include "hw/pci/pcie_sriov.h"
> >  #include "system/spdm-socket.h"
> > +#include "migration/blocker.h"
> >  #include "migration/vmstate.h"
> >
> >  #include "nvme.h"
> > @@ -252,6 +253,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
> >      [NVME_COMMAND_SET_PROFILE]      = true,
> >      [NVME_FDP_MODE]                 = true,
> >      [NVME_FDP_EVENTS]               = true,
> > +    /* if you add something here, please update nvme_set_migration_blockers() */
> >  };
> >
> >  static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
> > @@ -4603,6 +4605,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
> >          return 0;
> >      case NVME_IOMS_MO_RUH_UPDATE:
> >          return nvme_io_mgmt_send_ruh_update(n, req);
> > +    /* if you add something here, please update nvme_set_migration_blockers() */
> >      default:
> >          return NVME_INVALID_FIELD | NVME_DNR;
> >      };
> > @@ -7522,6 +7525,10 @@ static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> >
> >  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
> >  {
> > +    /*
> > +     * When adding a new dtype handling here,
> > +     * please also update nvme_set_migration_blockers().
> > +     */
> >      return NVME_INVALID_FIELD | NVME_DNR;
> >  }
> >
> > @@ -9233,6 +9240,204 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> >      }
> >  }
> >
> > +#define BLOCKER_FEATURES_MAX_LEN 256
> > +
> > +static inline void nvme_add_blocker_feature(char *blocker_features,
> > +                                            const char *feature)
> > +{
> > +    if (strlen(blocker_features) > 0) {
> > +        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> > +    }
> > +    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> > +}
> > +
> > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> > +                                        Error **errp)
> > +{
> > +    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> > +    bool adm_cmd_security_checked = false;
> > +    bool cmd_io_mgmt_checked = false;
> > +    bool cmd_zone_checked = false;
> > +
> > +    /*
> > +     * Idea of this function is simple, we iterate over all Command Sets and
> > +     * for each supported command we provide a special handling logic to
> > +     * determine if we should block migration or not.
> > +     *
> > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> > +     * available to the guest, but if there is only 1 namespace, then it is
> > +     * safe to allow migration, but if there are more, then we need to block
> > +     * migration because we don't handle this in migration code yet.
> > +     */
> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.acs); opcode++) {
> > +        /* Is command supported? */
> > +        if (!n->cse.acs[opcode]) {
> > +            continue;
> > +        }
> > +
> > +        switch (opcode) {
> > +        case NVME_ADM_CMD_DELETE_SQ:
> > +        case NVME_ADM_CMD_CREATE_SQ:
> > +        case NVME_ADM_CMD_GET_LOG_PAGE:
> > +        case NVME_ADM_CMD_DELETE_CQ:
> > +        case NVME_ADM_CMD_CREATE_CQ:
> > +        case NVME_ADM_CMD_IDENTIFY:
> > +        case NVME_ADM_CMD_ABORT:
> > +        case NVME_ADM_CMD_SET_FEATURES:
> > +        case NVME_ADM_CMD_GET_FEATURES:
> > +        case NVME_ADM_CMD_ASYNC_EV_REQ:
> > +        case NVME_ADM_CMD_DBBUF_CONFIG:
> > +        case NVME_ADM_CMD_FORMAT_NVM:
> > +        case NVME_ADM_CMD_DIRECTIVE_SEND:
> > +        case NVME_ADM_CMD_DIRECTIVE_RECV:
> > +            break;
> > +        case NVME_ADM_CMD_NS_ATTACHMENT:
> > +            int namespaces_num = 0;
>
> Hi, clang flags this:
>
> ../hw/nvme/ctrl.c:9385:13: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
>  9385 |             int namespaces_num = 0;
>       |             ^
>

Hi Fabiano,

ugh, I'll handle this. Let me then burn even more CI minutes and run
every single test in the matrix :)

Sorry about making a noise by making submissions with a stupid mistakes :(

Kind regards,
Alex

>
> > +            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> > +                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
> > +                if (!ns) {
> > +                    continue;
> > +                }
> > +
> > +                namespaces_num++;
> > +            }
> > +
> > +            if (namespaces_num > 1) {
> > +                nvme_add_blocker_feature(blocker_features,
> > +                                         "Namespace Attachment");
> > +            }
> > +
> > +            break;
> > +        case NVME_ADM_CMD_VIRT_MNGMT:
> > +            if (n->params.sriov_max_vfs) {
> > +                nvme_add_blocker_feature(blocker_features, "SR-IOV");
> > +            }
> > +
> > +            break;
> > +        case NVME_ADM_CMD_SECURITY_SEND:
> > +        case NVME_ADM_CMD_SECURITY_RECV:
> > +            if (adm_cmd_security_checked) {
> > +                break;
> > +            }
> > +
> > +            if (pci_dev->spdm_port) {
> > +                nvme_add_blocker_feature(blocker_features, "SPDM");
> > +            }
> > +
> > +            adm_cmd_security_checked = true;
> > +
> > +            break;
> > +        default:
> > +            g_assert_not_reached();
> > +        }
> > +    }
> > +
> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.nvm); opcode++) {
> > +        if (!n->cse.iocs.nvm[opcode]) {
> > +            continue;
> > +        }
> > +
> > +        switch (opcode) {
> > +        case NVME_CMD_FLUSH:
> > +        case NVME_CMD_WRITE:
> > +        case NVME_CMD_READ:
> > +        case NVME_CMD_COMPARE:
> > +        case NVME_CMD_WRITE_ZEROES:
> > +        case NVME_CMD_DSM:
> > +        case NVME_CMD_VERIFY:
> > +        case NVME_CMD_COPY:
> > +            break;
> > +        case NVME_CMD_IO_MGMT_RECV:
> > +        case NVME_CMD_IO_MGMT_SEND:
> > +            if (cmd_io_mgmt_checked) {
> > +                break;
> > +            }
> > +
> > +            /* check for NVME_IOMS_MO_RUH_UPDATE */
> > +            if (n->subsys->params.fdp.enabled) {
> > +                nvme_add_blocker_feature(blocker_features, "FDP");
> > +            }
> > +
> > +            cmd_io_mgmt_checked = true;
> > +
> > +            break;
> > +        default:
> > +            g_assert_not_reached();
> > +        }
> > +    }
> > +
> > +    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.zoned); opcode++) {
> > +        /*
> > +         * If command isn't supported or we have the same command
> > +         * in n->cse.iocs.nvm, then we can skip it here.
> > +         */
> > +        if (!n->cse.iocs.zoned[opcode] || n->cse.iocs.nvm[opcode]) {
> > +            continue;
> > +        }
> > +
> > +        switch (opcode) {
> > +        case NVME_CMD_ZONE_APPEND:
> > +        case NVME_CMD_ZONE_MGMT_SEND:
> > +        case NVME_CMD_ZONE_MGMT_RECV:
> > +            if (cmd_zone_checked) {
> > +                break;
> > +            }
> > +
> > +            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
> > +                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
> > +                if (!ns) {
> > +                    continue;
> > +                }
> > +
> > +                if (ns->params.zoned) {
> > +                    nvme_add_blocker_feature(blocker_features,
> > +                                             "Zoned Namespace");
> > +                    break;
> > +                }
> > +            }
> > +
> > +            cmd_zone_checked = true;
> > +
> > +            break;
> > +        default:
> > +            g_assert_not_reached();
> > +        }
> > +    }
> > +
> > +    /*
> > +     * Try our best to explicitly detect all not supported caps,
> > +     * to let users know what features cause migration to be blocked,
> > +     * but in case we miss handling here, everything else will be
> > +     * covered by unsupported_cap check.
> > +     */
> > +    if (NVME_CAP_CMBS(cap)) {
> > +        nvme_add_blocker_feature(blocker_features, "CMB");
> > +        cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
> > +    }
> > +
> > +    if (NVME_CAP_PMRS(cap)) {
> > +        nvme_add_blocker_feature(blocker_features, "PMR");
> > +        cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
> > +    }
> > +
> > +    unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
> > +    if (unsupported_cap) {
> > +        nvme_add_blocker_feature(blocker_features, "unknown capability");
> > +    }
> > +
> > +    assert(n->migration_blocker == NULL);
> > +    if (strlen(blocker_features) > 0) {
> > +        error_setg(&n->migration_blocker,
> > +                   "Migration is not supported for %s", blocker_features);
> > +        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
> >  {
> >      int cntlid;
> > @@ -9338,6 +9543,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >
> >          n->subsys->namespaces[ns->params.nsid] = ns;
> >      }
> > +
> > +    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
> > +        return;
> > +    }
> >  }
> >
> >  static void nvme_exit(PCIDevice *pci_dev)
> > @@ -9390,6 +9599,8 @@ static void nvme_exit(PCIDevice *pci_dev)
> >      }
> >
> >      memory_region_del_subregion(&n->bar0, &n->iomem);
> > +
> > +    migrate_del_blocker(&n->migration_blocker);
> >  }
> >
> >  static const Property nvme_props[] = {
> > diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> > index 5ef3ebee29e..05aee24a15c 100644
> > --- a/hw/nvme/nvme.h
> > +++ b/hw/nvme/nvme.h
> > @@ -668,6 +668,9 @@ typedef struct NvmeCtrl {
> >
> >      /* Socket mapping to SPDM over NVMe Security In/Out commands */
> >      int spdm_socket;
> > +
> > +    /* Migration-related stuff */
> > +    Error *migration_blocker;
> >  } NvmeCtrl;
> >
> >  typedef enum NvmeResetType {
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index e4e7be51205..17a7c7818d7 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -141,6 +141,18 @@ enum NvmeCapMask {
> >  #define NVME_CAP_SET_CMBS(cap, val)   \
> >      ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
> >
> > +#define NVME_MIGRATION_SUPPORTED_CAP_BITS ( \
> > +      ((uint64_t)CAP_MQES_MASK   << CAP_MQES_SHIFT)   \
> > +    | ((uint64_t)CAP_CQR_MASK    << CAP_CQR_SHIFT)    \
> > +    | ((uint64_t)CAP_AMS_MASK    << CAP_AMS_SHIFT)    \
> > +    | ((uint64_t)CAP_TO_MASK     << CAP_TO_SHIFT)     \
> > +    | ((uint64_t)CAP_DSTRD_MASK  << CAP_DSTRD_SHIFT)  \
> > +    | ((uint64_t)CAP_NSSRS_MASK  << CAP_NSSRS_SHIFT)  \
> > +    | ((uint64_t)CAP_CSS_MASK    << CAP_CSS_SHIFT)    \
> > +    | ((uint64_t)CAP_MPSMIN_MASK << CAP_MPSMIN_SHIFT) \
> > +    | ((uint64_t)CAP_MPSMAX_MASK << CAP_MPSMAX_SHIFT) \
> > +)
> > +
> >  enum NvmeCapCss {
> >      NVME_CAP_CSS_NCSS    = 1 << 0,
> >      NVME_CAP_CSS_IOCSS   = 1 << 6,

