Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A0DCC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH0ca-0002Ul-T1; Wed, 14 Oct 2026 11:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xH0cV-0002UU-R4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:10:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xH0cQ-0006WY-RM
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:10:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so257465e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 08:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990611; cv=none;
 d=google.com; s=arc-20260327;
 b=snS2zwLlrMuM6AGYAZL/5Fksz5uI1igRfWjg6ievUlEH1gE1WDYewrSduHyROOnvkl
 PjcYNP1XdX/GkWpIAZzEbTP/NMfVSyFhKdciAeERaVdm46Sakr0fnqPpAxdlc5xvTCzp
 WmlktOGF0y8F0fGJ4kKmOCrDJO7Ef2PelkdtQfy3lnSO7bkTMAu9d+j2uu/ML3P/j0ir
 IsJOyEEwzcTB5IVt3JDITrzZAb3ZHRtwpqVhxjaGOtDe7VNf3U3f2UjblMbX7JHusNZg
 enV42m/43thfKEj3YIN342POx8Teit74A+ippvA+eNxSRUDTSjNboXlvIqimf0Yp03eA
 iNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PaQeSu2PuXsqVXkpUlPWQh9fedVglv+hKwc0y2Fprzc=;
 fh=kIMaH1p4WQKPaRtcLyk8jxVqnyj9ufCg+8lQuf1IepY=;
 b=X3P7AlwAWC1r6Az5PP7e3C8mxvGdjbAgq1kVruGIKFomNsIs11KR5aF3MyyRqCCfwp
 T8ii4jWP5DW8DHPToHNO9A6gMV6RzCF3vH42bXbpNZ+bFBRfzNgbM0o0sEPyLwFOJzUx
 9bTmcQyypPZ4FHOiq0p/+RSLoUdRimZUYsxyLdK90Ni1WgebS/2I67y2YJQCdGsCq+09
 oFDY6ATBpUeriiEGv52Yz39oYgxYa+/CSVFJ+bo1jq003MmGz0THnKjraLEqnMzG0HEG
 yLEMvi0g2BVs2/xgQ0DjegSC8Z5cNzuqVaT6C3VF7XGUEDzrMMOvhVtbqLESv3WhFbzw
 wG7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791990611; x=1792595411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PaQeSu2PuXsqVXkpUlPWQh9fedVglv+hKwc0y2Fprzc=;
 b=n/PFaeaB5ClcJUslGhipdlfZvU6e6wcaGQti3wD0Pz2L9UjUycp58QtWsZraK691BY
 SrrTAjMb7TINqoWwUdadfXw/cgtuYhh0An4xWewbf5Rjs/iOdcK3EVo7G7hqrDleq6Z6
 18hg3HJw7T4HBcSsqbG9vauQGRdEL9M7azHytTQgOzpSw0M78967fdO3Y8ZUsimeeIWA
 VEi/Cp1dLLkOcoht6TqFFoz3VEydjKUXvi0pMMKjab45tHdNRC+xUkT8CtY88NvxWR4f
 MO5gvn5nJwnz7iaqnN/5AqU0TKVQvW9VFkSNC0uAwOpL/OTxFKthg+sXgmJSxHHjUUA0
 BSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791990611; x=1792595411;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PaQeSu2PuXsqVXkpUlPWQh9fedVglv+hKwc0y2Fprzc=;
 b=fqkHok7+vToKQ9KlBN3LgpcamMOxjiJ3btp7cvEKBw4L6DdJXL6eWelWasl4JjCQve
 IMdMyzOblc7NFjGKL9j71yHYpWlrmDcO2LleA0v7eUSjiamVUXxp2IAXiyI0xq4oYWOo
 AbiXcSq/+HjHS9mflmryTOscaWnySt04FMIhr85kjUkpVJjyeBD23u1x7DfO1WhYtNx8
 idcNjcytqgXzNWokT29A556CvaraYlN4/VyIFOtAhlMUhCrMqM6CkGEyQ2iFXEa+b21U
 sNk/vjRy1pNsXOBoTdG1Kp687k1oeWCWpz77yt/A7YDkMeLyiARsbf4xPxxAsXyCdMr+
 uySg==
X-Gm-Message-State: AFq9FYKq0+s/TED1EEBwxYkYkLRPGyIP1taTz49XT46vaS49DCssDUNr
 R3lZfRjSdrEN7m7rb1jfns2HdYnwBQKPtY6UUf8b1xLfonhtexxjZFRRmLEZDNaX1TuIFaou6Lb
 jWxi49H51Je0BOuhKTEOA5xFd60vfxAViNBZ0GdXF
X-Gm-Gg: AYBFou2gncRqWtck2gBQfFYXcEqxcpfbDDIZLI/LVa2XXs8SLIWZagGwxP0DPAiEWW6
 X3WH/UbZBitp+TfiXWiw05VL4xLrcALpI2S9wQKu/0N9Y6H0M/rHj76+WeQR+EguW5OAmrL+Vwq
 m+Artvlu3GQfla3vTY1435zoG1RSjPQ21VUkqTUXnvj5Zst2DTcFlcgIcY+GaPYpNxiUW54vKvq
 B2LBKbxjs13w16Du7a1KoGkjaEZQAl6b6xZxAJXcL6KXDcSx8C2FxVexcf6z+9eq2b4Cbmiwhud
 cWNzmLWx0KALi/3EXu/JYETypM4dM1UW4ZyVjTz2rjqCFaJ2rs5WB723OrR6MvxU3iUugPhWGoG
 o1dcWurg1QpJF
X-Received: by 2002:a05:600c:8b61:b0:4a1:68a3:9c2e with SMTP id
 5b1f17b1804b1-4a1bc1a5731mr438115e9.5.1791990610588; Wed, 14 Oct 2026
 08:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
 <20261009175314.1823347-5-namangulati@google.com>
 <IA0PR02MB946209557BD92C193A0F1E298B902@IA0PR02MB9462.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB946209557BD92C193A0F1E298B902@IA0PR02MB9462.namprd02.prod.outlook.com>
From: Naman Gulati <namangulati@google.com>
Date: Wed, 14 Oct 2026 08:09:57 -0700
X-Gm-Features: AclHuK-WHvVQVOZ739DW8VDkkU2ntMRFeet_Iooz138SNT6UCKmGJBlneRCb2e8
Message-ID: <CAMP57yVprFyR3j3ams8L1sKT_zzAKD+0jwTp+M-yuaJfSMtohA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Levon <john.levon@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=namangulati@google.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Thanks for reviewing, agree with all other comments, and will respin
accordingly. Replying to one inline.

On Sat, Oct 10, 2026 at 11:53=E2=80=AFPM Thanos Makatos
<thanos.makatos@nutanix.com> wrote:
>
> > -----Original Message-----
> > From: Naman Gulati <namangulati@google.com>
> > Sent: 09 October 2026 18:53
> > To: qemu-devel@nongnu.org
> > Cc: John Levon <john.levon@nutanix.com>; Thanos Makatos
> > <thanos.makatos@nutanix.com>; C=C3=A9dric Le Goater <clg@redhat.com>; A=
lex
> > Williamson <alex@shazbot.org>; Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com>; Matt Evans <matt@ozlabs.org>;
> > Naman Gulati <namangulati@google.com>
> > Subject: [PATCH v4 4/4] vfio-user: support multiple FDs for sparse
> > mmap regions
> >
> > !-------------------------------------------------------------------|
> >   CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > Add client support for capability VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> > (capability ID 0x8001) in vfio-user, and advertise support via the
> > "sparse_mmap_fds" capability in VFIO_USER_VERSION.
> >
> > Update vfio_user_device_io_get_region_info() to receive multiple file
> > descriptors passed in SCM_RIGHTS ancillary data for a region, store
> > them
> > in VFIOUserProxy, and implement setup_sparse_mmaps in
> > vfio_user_device_io_ops_sock to validate and populate per-area file
> > descriptors and fd_offset values.
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >  hw/vfio-user/protocol.h |  35 +++++++++++---
> >  hw/vfio-user/proxy.h    |   2 +
> >  hw/vfio-user/device.c   | 102 +++++++++++++++++++++++++++++++++++++--
> > -
> >  hw/vfio-user/proxy.c    |  46 ++++++++++++++++--
> >  4 files changed, 168 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> > index c478d1353f..b823689254 100644
> > --- a/hw/vfio-user/protocol.h
> > +++ b/hw/vfio-user/protocol.h
> > @@ -15,6 +15,8 @@
> >   * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> > +#define VFIO_USER_MAX_REGIONS 100
> > +
> >  typedef struct {
> >      uint16_t id;
> >      uint16_t command;
> > @@ -69,12 +71,13 @@ typedef struct {
> >  #define VFIO_USER_CAP           "capabilities"
> >
> >  /* "capabilities" members */
> > -#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
> > -#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
> > -#define VFIO_USER_CAP_PGSIZES   "pgsizes"
> > -#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
> > -#define VFIO_USER_CAP_MIGR      "migration"
> > -#define VFIO_USER_CAP_MULTI     "write_multiple"
> > +#define VFIO_USER_CAP_MAX_FDS           "max_msg_fds"
> > +#define VFIO_USER_CAP_MAX_XFER          "max_data_xfer_size"
> > +#define VFIO_USER_CAP_PGSIZES           "pgsizes"
> > +#define VFIO_USER_CAP_MAP_MAX           "max_dma_maps"
> > +#define VFIO_USER_CAP_MIGR              "migration"
> > +#define VFIO_USER_CAP_MULTI             "write_multiple"
> > +#define VFIO_USER_CAP_SPARSE_MMAP_FDS   "sparse_mmap_fds"
> >
> >  /* "migration" members */
> >  #define VFIO_USER_CAP_PGSIZE            "pgsize"
> > @@ -166,6 +169,26 @@ typedef struct {
> >      uint64_t offset;
> >  } VFIOUserRegionInfo;
> >
> > +/*
> > + * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> > + */
> > +#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 0x8001
> > +
> > +struct vfio_region_sparse_mmap_fd_area {
> > +    uint64_t offset;
> > +    uint64_t fd_offset;
> > +    uint64_t size;
> > +    uint32_t fd_index;
> > +    uint32_t pad;
> > +};
> > +
> > +struct vfio_region_info_cap_sparse_mmap_fds {
> > +    struct vfio_info_cap_header header;
> > +    uint32_t nr_areas;
> > +    uint32_t reserved;
> > +    struct vfio_region_sparse_mmap_fd_area areas[];
> > +};
> > +
> >  /*
> >   * VFIO_USER_DEVICE_GET_IRQ_INFO
> >   * imported from struct vfio_irq_info
> > diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> > index 7b97460cc5..4b9834a436 100644
> > --- a/hw/vfio-user/proxy.h
> > +++ b/hw/vfio-user/proxy.h
> > @@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
> >      AioContext *ctx;
> >      QEMUBH *req_bh;
> >      bool async_ops;
> > +    VFIOUserFDs *region_fds[VFIO_USER_MAX_REGIONS];
>
> Doesn't this logically belong to each region?
>

That is what the original implmentation did but in v2 Cedric asked
that since the per region set of FDs is a vfio-user specific
construct, it should be kept out of the core VFIODevice / VFIORegion
structs.

> >
> >      /*
> >       * above only changed when BQL is held
> > @@ -111,6 +112,7 @@ bool vfio_user_validate_version(VFIOUserProxy
> > *proxy, Error **errp);
> >
> >  VFIOUserFDs *vfio_user_getfds(int numfds);
> >  void vfio_user_putfds(VFIOUserMsg *msg);
> > +void vfio_user_free_fds(VFIOUserFDs *fds);
> >
> >  void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
> >
> > diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> > index 1a01e748cd..5c63c83a7c 100644
> > --- a/hw/vfio-user/device.c
> > +++ b/hw/vfio-user/device.c
> > @@ -14,12 +14,14 @@
> >
> >  #include "hw/vfio-user/device.h"
> >  #include "hw/vfio-user/trace.h"
> > +#include "hw/vfio/vfio-region.h"
> > +#include "hw/vfio/vfio-helpers.h"
> > +#include "hw/vfio/trace.h"
> >
> >  /*
> >   * These are to defend against a malign server trying
> >   * to force us to run out of memory.
> >   */
> > -#define VFIO_USER_MAX_REGIONS   100
> >  #define VFIO_USER_MAX_IRQS      50
> >
> >  bool vfio_user_get_device_info(VFIOUserProxy *proxy,
> > @@ -209,14 +211,17 @@ static int
> > vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
> >                                                 struct
> > vfio_region_info *info,
> >                                                 int *fd)
> >  {
> > -    VFIOUserFDs fds =3D { 0, 1, fd};
> > -    int ret;
> > +    int fds[VFIO_USER_MAX_MAX_FDS];
> > +    VFIOUserFDs user_fds =3D { 0, VFIO_USER_MAX_MAX_FDS, fds };
> > +    int i, ret;
> > +
> > +    *fd =3D -1;
> >
> >      if (info->index > vbasedev->num_initial_regions) {
> >          return -EINVAL;
> >      }
> >
> > -    ret =3D vfio_user_get_region_info(vbasedev->proxy, info, &fds);
> > +    ret =3D vfio_user_get_region_info(vbasedev->proxy, info,
> > &user_fds);
> >      if (ret) {
> >          return ret;
> >      }
> > @@ -225,10 +230,29 @@ static int
> > vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
> >      if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
> >          (info->cap_offset < sizeof(*info)
> >           || info->cap_offset + sizeof(struct vfio_info_cap_header) >
> > info->argsz)) {
> > -        return -EINVAL;
> > +        ret =3D -EINVAL;
> > +    } else if (vfio_get_region_info_cap(info,
> > +
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS)) {
> > +        if (info->index < VFIO_USER_MAX_REGIONS && user_fds.recv_fds
> > > 0) {
> > +            VFIOUserFDs *saved =3D vfio_user_getfds(user_fds.recv_fds)=
;
> > +
> > +            saved->recv_fds =3D user_fds.recv_fds;
> > +            memcpy(saved->fds, fds, user_fds.recv_fds * sizeof(int));
> > +            vfio_user_free_fds(vbasedev->proxy->region_fds[info-
> > >index]);
> > +            vbasedev->proxy->region_fds[info->index] =3D saved;
> > +            return 0;
> > +        }
> > +    } else if (user_fds.recv_fds > 0) {
> > +        *fd =3D fds[0];
> > +        fds[0] =3D -1;
> >      }
> >
> > -    return 0;
> > +    for (i =3D 0; i < user_fds.recv_fds; i++) {
> > +        if (fds[i] >=3D 0) {
> > +            close(fds[i]);
> > +        }
> > +    }
> > +    return ret;
> >  }
> >
> >  static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
> > @@ -518,12 +542,76 @@ static int
> > vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> >  /*
> >   * Socket-based io_ops
> >   */
> > +static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
> > +                                                  struct
> > vfio_region_info *info,
> > +                                                  Error **errp)
> > +{
> > +    struct vfio_info_cap_header *hdr;
> > +    struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds;
> > +    VFIOUserFDs *user_fds =3D NULL;
> > +    int i;
> > +
> > +    hdr =3D vfio_get_region_info_cap(info,
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
> > +    if (!hdr) {
> > +        return vfio_default_setup_sparse_mmaps(region, info, errp);
> > +    }
> > +
> > +    if (vfio_get_region_info_cap(info,
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP)) {
> > +        error_setg(errp, "%s: region %d cannot specify both "
> > +                   "SPARSE_MMAP and SPARSE_MMAP_FDS", __func__,
> > region->nr);
> > +        return -EINVAL;
> > +    }
> > +
> > +    sparse_fds =3D container_of(hdr, struct
> > vfio_region_info_cap_sparse_mmap_fds,
> > +                              header);
> > +
> > +    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
> > +                                         region->nr, sparse_fds-
> > >nr_areas);
> > +
> > +    if (region->nr < VFIO_USER_MAX_REGIONS) {
> > +        user_fds =3D region->vbasedev->proxy->region_fds[region->nr];
> > +    }
> > +    if (!user_fds || user_fds->recv_fds > sparse_fds->nr_areas) {
> > +        error_setg(errp, "%s: invalid fd count %d for %u sparse mmap
> > areas "
> > +                   "in region %d", __func__,
> > +                   user_fds ? user_fds->recv_fds : 0,
> > +                   sparse_fds->nr_areas, region->nr);
> > +        return -EINVAL;
> > +    }
> > +
> > +    region->mmaps =3D g_new0(VFIOMmap, sparse_fds->nr_areas);
> > +
> > +    for (i =3D 0; i < sparse_fds->nr_areas; i++) {
> > +        struct vfio_region_sparse_mmap_fd_area *area =3D &sparse_fds-
> > >areas[i];
> > +
> > +        if (area->size =3D=3D 0 || area->offset > region->size ||
> > +            area->size > region->size - area->offset ||
> > +            area->fd_index >=3D user_fds->recv_fds) {
> > +            error_setg(errp, "%s: invalid sparse mmap area %d in
> > region %d",
> > +                       __func__, i, region->nr);
> > +            g_free(region->mmaps);
> > +            region->mmaps =3D NULL;
> > +            return -EINVAL;
> > +        }
> > +
> > +        trace_vfio_region_sparse_mmap_entry(i, area->offset,
> > +                                            area->offset + area->size
> > - 1);
> > +        region->mmaps[i].offset =3D area->offset;
> > +        region->mmaps[i].fd_offset =3D area->fd_offset;
> > +        region->mmaps[i].size =3D area->size;
> > +        region->mmaps[i].fd =3D user_fds->fds[area->fd_index];
> > +    }
> > +
> > +    region->nr_mmaps =3D sparse_fds->nr_areas;
> > +    return 0;
> > +}
> > +
> >  VFIODeviceIOOps vfio_user_device_io_ops_sock =3D {
> >      .device_feature =3D vfio_user_device_io_device_feature,
> >      .get_region_info =3D vfio_user_device_io_get_region_info,
> > +    .setup_sparse_mmaps =3D vfio_user_device_io_setup_sparse_mmaps,
> >      .get_irq_info =3D vfio_user_device_io_get_irq_info,
> >      .set_irqs =3D vfio_user_device_io_set_irqs,
> >      .region_read =3D vfio_user_device_io_region_read,
> >      .region_write =3D vfio_user_device_io_region_write,
> > -
> >  };
> > diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> > index 197aee07bf..44e2a839b0 100644
> > --- a/hw/vfio-user/proxy.c
> > +++ b/hw/vfio-user/proxy.c
> > @@ -363,6 +363,8 @@ static int vfio_user_recv_one(VFIOUserProxy
> > *proxy, Error **errp)
> >          }
> >
> >          memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> > +    } else if (msg->fds !=3D NULL) {
> > +        msg->fds->recv_fds =3D 0;
> >      }
> >
> >      /*
> > @@ -740,6 +742,10 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy,
> > VFIOUserHdr *hdr,
> >
> >      qemu_mutex_unlock(&proxy->lock);
> >
> > +    if (!ok && fds !=3D NULL) {
> > +        fds->recv_fds =3D 0;
> > +    }
> > +
> >      return ok;
>
> A comment why fds->recv_fds is set to zero in these two cases would be he=
lpful.
>
> >  }
> >
> > @@ -867,17 +873,30 @@ void vfio_user_send_error(VFIOUserProxy *proxy,
> > VFIOUserHdr *hdr, int error)
> >  }
> >
> >  /*
> > - * Close FDs erroneously received in an incoming request.
> > + * Close and free received FDs.
> >   */
> > -void vfio_user_putfds(VFIOUserMsg *msg)
> > +void vfio_user_free_fds(VFIOUserFDs *fds)
> >  {
> > -    VFIOUserFDs *fds =3D msg->fds;
> >      int i;
> >
> > +    if (!fds) {
> > +        return;
> > +    }
> > +
> >      for (i =3D 0; i < fds->recv_fds; i++) {
> > -        close(fds->fds[i]);
> > +        if (fds->fds[i] >=3D 0) {
> > +            close(fds->fds[i]);
> > +        }
> >      }
> >      g_free(fds);
> > +}
> > +
> > +/*
> > + * Close FDs erroneously received in an incoming request.
> > + */
> > +void vfio_user_putfds(VFIOUserMsg *msg)
> > +{
> > +    vfio_user_free_fds(msg->fds);
> >      msg->fds =3D NULL;
> >  }
> >
> > @@ -967,6 +986,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
> >  void vfio_user_disconnect(VFIOUserProxy *proxy)
> >  {
> >      VFIOUserMsg *r1, *r2;
> > +    int i;
> >
> >      qemu_mutex_lock(&proxy->lock);
> >
> > @@ -1027,6 +1047,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
> >          vfio_user_iothread =3D NULL;
> >      }
> >
> > +    for (i =3D 0; i < VFIO_USER_MAX_REGIONS; i++) {
> > +        vfio_user_free_fds(proxy->region_fds[i]);
> > +    }
> > +
> >      g_free(proxy->sockname);
> >      g_free(proxy);
> >  }
> > @@ -1214,6 +1238,18 @@ static bool check_multi(VFIOUserProxy *proxy,
> > QObject *qobj, Error **errp)
> >      return true;
> >  }
> >
> > +static bool check_sparse_mmap_fds(VFIOUserProxy *proxy, QObject
> > *qobj,
> > +                                  Error **errp)
> > +{
> > +    QBool *qb =3D qobject_to(QBool, qobj);
> > +
> > +    if (qb =3D=3D NULL) {
> > +        error_setg(errp, "malformed %s",
> > VFIO_USER_CAP_SPARSE_MMAP_FDS);
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> >  static struct cap_entry caps_cap[] =3D {
> >      { VFIO_USER_CAP_MAX_FDS, check_max_fds },
> >      { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
> > @@ -1221,6 +1257,7 @@ static struct cap_entry caps_cap[] =3D {
> >      { VFIO_USER_CAP_MAP_MAX, check_max_dma },
> >      { VFIO_USER_CAP_MIGR, check_migr },
> >      { VFIO_USER_CAP_MULTI, check_multi },
> > +    { VFIO_USER_CAP_SPARSE_MMAP_FDS, check_sparse_mmap_fds },
> >      { NULL }
> >  };
> >
> > @@ -1280,6 +1317,7 @@ static GString *caps_json(void)
> >      qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES,
> > VFIO_USER_DEF_PGSIZE);
> >      qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX,
> > VFIO_USER_DEF_MAP_MAX);
> >      qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
> > +    qdict_put_bool(capdict, VFIO_USER_CAP_SPARSE_MMAP_FDS, true);
> >
> >      qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
> >
> > --
> > 2.56.0.385.gd3acb90ef8-goog
>

