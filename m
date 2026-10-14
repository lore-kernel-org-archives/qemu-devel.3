Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C198DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH0P7-0000T9-83; Wed, 14 Oct 2026 10:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xH0P5-0000T1-KT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:56:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1xH0P3-0004u9-UY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:56:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so256155e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 07:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791989783; cv=none;
 d=google.com; s=arc-20260327;
 b=R6X4/Vq7wzRy/vvoamb3iCC02RmRqtFUaZra340t7XDTWmDEslXDnJEcPbQMbYOyDt
 fTSezoNj1oFvfx7PbrcArriM9wxn+UcTdDrRDTWAuoNG+hLoosEQBWZ+PMlKFeMXJ2w3
 tEqF68aWzUJfYOi9dENMtxqp949PQGbiC744dkDpVjKdn34UhtFfRs5GdFJzLpzGweIC
 9A+DU6wZjQOFmeuydpVWfIaykUOVCUrrx/86nJF9O6qfl50iFemESMh7dII+TYQ01m8X
 d8S+I15dsGOcgkEy6yRHOnoqEKYG6moiBma1TMwZu+nshM92LBq9XqKUB1TcD6EqObLf
 b7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x8zUJjf6RAoXebM+s3RYMUWWJ4sutHZIB3YG08N6kuI=;
 fh=KY4iSIvi5Jb/nm7e2MRTNVDqflN8B404np/L/XjplCE=;
 b=VWzLfYDmNvRRQ/tXpX2zFjgvqjt5S0XPvCc+B3wthpFzgVbCSlt2h4mUDm5Cv3aLrI
 ztHTdR9+Y1QbltxaqgOQlrchNzFwS1OgtRWpBpid7vL5/2zcW6yRYvrJ3LwRgkO2/MBd
 qdsJ4asODFVSayefNncJmdKoJuxbYQGcKlt0W5LMrs6RP+zY4637WsSLM1DF2NaTcD5x
 ibrNqJkM0Sh5y1AEBsZnlNomDF0gOce8BA8CgbyGAdjhqHwt7rQNmBsDcTb8Ti5zIyAm
 nyFjaCUO+GceyVs9IHKSLO77ChcdasszNzaZFgty2Yttlte8cfMROjJOwZuzrMcwCeXt
 bCwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791989783; x=1792594583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x8zUJjf6RAoXebM+s3RYMUWWJ4sutHZIB3YG08N6kuI=;
 b=JDtDXOxDcs2g/w8nrbXIimjANeQ6u3EPrlplAj8nQ97Wwo5TFSa02ql2RV/urTMyNl
 4IjCS+00NixqGWtzTSUFWRId0szfR7E/o8PsR9LnfBPKua3e0cfjOyG/PDBm2qvrgMK5
 qqglXltsXXkzzn4JbyLmVH9QH3pr4cvOlvivShbbYTbIIckLztbLW/Wo85iIL42L0h9J
 vF1ZfN+Mk3k/9YV8RHrp1dOHFJm4ipMxuYVN0hUv68FGG4X0sIkWidP2qUe0AwBw7f6N
 wvP+yBFu6xuxiMbjcpJL3296tPNlmCUGg9xojsXgB/mlUd1iac4ykOw9+UnK/mzarFwt
 WQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989783; x=1792594583;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x8zUJjf6RAoXebM+s3RYMUWWJ4sutHZIB3YG08N6kuI=;
 b=UQqrSRs6eAu7pCKFWcoRN3kKdGwUNGNN6NBY6VcHAMIM8vvTUjkmcfvjy5CD7IasFl
 KG7Yj+h/Ywux8gnawcPOGPKez+AeYp9lCg59XPYkBcx8yCsWDMq3SzGAH/Zk+Qki4W2o
 4FebKRXg0EQ8LA0MVDYona0nKth0nTaVQ0AIfIjEyQRvFR30Add/0fS74eRRMI4lW/OX
 6lpGNQm9sDoeIQUeY1oSYzh32DJQgWzfNv4fJqq/x0YO0djkMzCR+dDPve9UjndWtn8z
 cQT4jTRiat+KWSXPUSg4NaC1L1zckxGSKfRU+W+QmM+jjbircPfoTiZhW2KYqKc760PN
 fj0g==
X-Gm-Message-State: AFq9FYKjZYgd51kMnBM/iWUiFLwPpoW3P25N4wFb7QhruAGF7M7T+HPe
 8r0KtK6beTp4pWS3tbWPwDMXAgROrIbpT9cEGWboComYevNHHl1NUkP3e6kRs7ed0QOTNOdsp9n
 3aCoLO1Mg4vjkMVcWGukYnHdffPOYfRkQRO1istuR
X-Gm-Gg: AYBFou15TrIOtcaTI3BuR577gl9CaLQLyHxOrDJy9VBes+0eqYw8yA8JqM6oUqYGquB
 ZHle/XlHzwCCDJ1xFJKfXVqFCxdXy3zcuoBJHaDYIfO9wXsjy3inAJijHWQxJg6ePSUOCIh+K74
 n7CqOcihfS0wnKZVPthItGyRJlxzMMtJRIJ6Y0y6jsgR2E7EO1pcTAumd9SQnmUTKUNBArH3VI5
 34J619t9LvdUkV2D3j4B711/oZ68gTIQ8zLoToujZlJwAsXGoshJxqy2BPNbBvWByNQ+CSU4Uqv
 Qa+3R0We/B1bnzAUAxWAzQO6Pe8T+Aunc0olUbn17UWH6Mgq3xj+AnLCoLV0cFeqlIfWoaxohMv
 E2Uw8YiVq4zt6224Nu7gRQeY=
X-Received: by 2002:a05:600d:644e:20b0:49f:e1d3:fe03 with SMTP id
 5b1f17b1804b1-4a1b67831dbmr673835e9.3.1791989782826; Wed, 14 Oct 2026
 07:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
 <20261009175314.1823347-4-namangulati@google.com>
 <9bfb90b4-7ed5-4400-abf6-d01e110e840d@redhat.com>
In-Reply-To: <9bfb90b4-7ed5-4400-abf6-d01e110e840d@redhat.com>
From: Naman Gulati <namangulati@google.com>
Date: Wed, 14 Oct 2026 07:56:10 -0700
X-Gm-Features: AclHuK82akNIiwRWo3l4lOcKwuEBOoYWec9-zbdioGlbe-1HleX3XynKHHRJdxk
Message-ID: <CAMP57yXMP8mpdo98pcBhx6bwYh--bL0hVwMQ1gEf3BOAPE-ntg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=namangulati@google.com; helo=mail-wm1-x32b.google.com
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

On Sun, Oct 11, 2026 at 10:39=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
>
> On 10/9/26 19:53, Naman Gulati wrote:
> > Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
> > backends (such as vfio-user) can parse custom sparse mmap capabilities,
> > falling back to vfio_default_setup_sparse_mmaps() to process shared
> > VFIO mmap capabilities.
> >
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> >   hw/vfio/vfio-region.h         |  5 +++++
> >   include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
> >   hw/vfio/region.c              | 25 ++++++++++++++++++++++---
> >   3 files changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> > index 9f6a5cf7d5..a0c9533f9f 100644
> > --- a/hw/vfio/vfio-region.h
> > +++ b/hw/vfio/vfio-region.h
> > @@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region=
, bool enabled);
> >   void vfio_region_exit(VFIORegion *region);
> >   void vfio_region_finalize(VFIORegion *region);
> >
> > +struct vfio_region_info;
> > +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> > +                                    struct vfio_region_info *info,
> > +                                    Error **errp);
> > +
> >   #endif /* HW_VFIO_REGION_H */
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-devic=
e.h
> > index 8472420d3f..3136e152f2 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -43,6 +43,7 @@ enum {
> >
> >   typedef struct VFIODeviceOps VFIODeviceOps;
> >   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> > +typedef struct VFIORegion VFIORegion;
> >   typedef struct VFIOMigration VFIOMigration;
> >
> >   typedef struct IOMMUFDBackend IOMMUFDBackend;
> > @@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
> >       int (*get_region_info)(VFIODevice *vdev,
> >                              struct vfio_region_info *info, int *fd);
> >
> > +    /**
> > +     * @setup_sparse_mmaps
> > +     *
> > +     * Parse sparse mmap capabilities for a region and initialize regi=
on->mmaps.
> > +     *
> > +     * @region: #VFIORegion to set up
> > +     * @info: region info struct containing capabilities
> > +     * @errp: pointer to Error*, to store an error if it happens
> > +     *
> > +     * Returns 0 on success, -ENODEV if not sparse, or negative error =
code.
> > +     */
> > +    int (*setup_sparse_mmaps)(VFIORegion *region,
> > +                              struct vfio_region_info *info,
> > +                              Error **errp);
> > +
> >       /**
> >        * @get_irq_info
> >        *
> > diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> > index 16efed2fce..d6cd5d4743 100644
> > --- a/hw/vfio/region.c
> > +++ b/hw/vfio/region.c
> > @@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, =
const void *b)
> >       return 0;
> >   }
> >
> > -static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> > -                                          struct vfio_region_info *inf=
o,
> > -                                          Error **errp)
> > +int vfio_default_setup_sparse_mmaps(VFIORegion *region,
> > +                                    struct vfio_region_info *info,
> > +                                    Error **errp)
> >   {
> >       struct vfio_info_cap_header *hdr;
> >       struct vfio_region_info_cap_sparse_mmap *sparse;
> > @@ -198,6 +198,25 @@ static int vfio_setup_region_sparse_mmaps(VFIORegi=
on *region,
> >
> >       region->nr_mmaps =3D j;
> >       region->mmaps =3D g_realloc(region->mmaps, j * sizeof(VFIOMmap));
> > +    return 0;
> > +}
> > +
> > +static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> > +                                          struct vfio_region_info *inf=
o,
> > +                                          Error **errp)
> > +{
> > +    int ret, i;
> > +
> > +    if (region->vbasedev->io_ops &&
> > +        region->vbasedev->io_ops->setup_sparse_mmaps) {
>
> Every other hook is a mandatory field. This should add :
>
>    .setup_sparse_mmaps =3D vfio_default_setup_sparse_mmaps
>
> in the kernel VFIO io_ops to be consistent with the rest of the code.
>
> Thanks,
>
> C.
>

Thanks, missed that, will fix.

> > +        ret =3D region->vbasedev->io_ops->setup_sparse_mmaps(region, i=
nfo, errp);
> > +    } else {
> > +        ret =3D vfio_default_setup_sparse_mmaps(region, info, errp);
> > +    }
> > +
> > +    if (ret) {
> > +        return ret;
> > +    }
> >
> >       /*
> >        * Sort sparse mmaps by offset to ensure proper handling of gaps
>

