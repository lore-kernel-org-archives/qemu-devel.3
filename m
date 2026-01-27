Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1650D2FEDF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 21:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkqWl-00052y-I4; Tue, 27 Jan 2026 16:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkqWh-0004x5-KX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:23:08 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkqWe-0003Bb-Km
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:23:07 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b884cb1e717so40247266b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 13:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769548983; cv=none;
 d=google.com; s=arc-20240605;
 b=H9D9uMGK4PrPiB5WPXealRYaxYQvpiAkJN9Mf22P/N93rB3hr2PuDdJI32BqwWwsSz
 HR/1qSBZ7qWsiB83PN960FW1ELxNFR/ifOEvJHYGYIWcEK8L1eOhkT3HEj86OXBqwgee
 hZvxYcoeBXnuha9nOr4RPTfEVNsYiZaV355GbiYHn+nPSMP8Z5UUU2c4lRmiH86hXpHA
 PAlGwJ1A0M0An4A5iwO9fgGs0sx4MzsD+LaLpH3W2GVgA7K9oPLDAyz8pYURzmIdjLOv
 vF4ZEEef2TJq8sNAeRl/7JDsG6t4RQxTP5cwHxl9mJScGazSxo5I809ZUEwuKhe+R9Kr
 P5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iXSQxroQRznR6VSz2PHJ5Hz2cFToY0WnX+1ahe4dCBk=;
 fh=6/UJkCMGwc3nS0Up/zW9U9C3JjxP4LxOyNdru6SeWKQ=;
 b=LMJsw6FLizsy1o5XhVM26mJiiI1pvXJlI7ed+QmaUoLizxpLOGFUjhEmdhDU3Gv0Q1
 guVJJmFuozPFkznwsHwTLJkLXoTxy2XwvYSMIvApkrazEApnEx7aHy0yX2uhk/SKSpWG
 3TY4tFfuEVUfiQMMsOkcDMT/1nlFlghlcmFWdoPW/hGXzDzpJPLlRRgnlGx01vyr2PKW
 tEb57B5rDnaqyMDTIu/W03HYy2YPiPVlRR9h86ujAMw3S01E0ApYzGaGqHgywbKII8QW
 CM8K/wn/vjIN3lgrVw5i0ttUBAKQQFwaxI1cEqrZABehELKk96TEZPb8xxCOto3p94ld
 vl3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769548983; x=1770153783; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXSQxroQRznR6VSz2PHJ5Hz2cFToY0WnX+1ahe4dCBk=;
 b=UGIsKFYaOI1/U68c0IAHWp2nvQoC5S+0znw8DHeFw8mGqqTiPALoAbkrO8ZaMxl4xU
 TAL5Xmvg6D1nL1q8Y9lK1q9vCXRE/pOCw01YQMNgEbHndunGZ+R++soQOJU0cOzDKWjY
 klqI683syzh+gGI6rdrYb9A9WEHXtLCGx9EQJ6lPTFYPnzDTKjs1OEpWEvx0vlj2kXe7
 P9iDXVGWdiLc9rteUX/LifG547tzW6YrGX/b3lPz+JXsAYwLekQUz7tzrCvbGZSVo3oi
 FjnujFWOd8Y8s63QMIC3sD47/edEX2aYEozI4yYpHQZyRfAkgLarM2k/XQmvB7FdR15D
 /EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769548983; x=1770153783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXSQxroQRznR6VSz2PHJ5Hz2cFToY0WnX+1ahe4dCBk=;
 b=cs6BEK80QrfpTySJppAcJC8QPO4RRqs9w3tTvSUwpNJQBbWFu2B+wqZyUzuPpXONOj
 ILXWigiLae1yD0PiMimb5HIuZf/lV5SYIRml49/qD6798An8CO3nJzUx+5PJ/pQ0wGDY
 geYvYWVeK2pPlaQHdpOSK+l2nNe8ukHXeCj8G459XMhwm2G/zIxgXHYT2geQ5wvDic1l
 IY6aWy1L08fsZpOr9ZkcoFas9+2QNwoNWeE/ytS8jgvdNQp7zubqDRbgbq5KhE1VAMM0
 1ynAMG2wcLaI1CCd2yXzCkBPOTFJCwJQlR9WR0oinBLOUBo6RLs35enWbaUm5sF+p/Xt
 oXVQ==
X-Gm-Message-State: AOJu0YwX6X/MgbxYuu9TxQPgpjJufweg6ajcoz3HlH6XrvXw/ksbXQyU
 FDa2ZyFwXwAkvKAEoTwkEHlqh9yv7fD9NA/Dqg206Sd5Kmjw+pq7+/Y+ipUpA0y3IEC1G0fZDKf
 4beIG3FhQ7ocx49C8IuZYFPnvob1aHJk=
X-Gm-Gg: AZuq6aLX005qjkJPi2/SXOUikNdNLVRitLY9x9OTt5I2D8DLX/odbU9x+qaQvywdVoX
 ydPVNKCZGZqzh7t51Orp0Ka+vWo4MZ27joD37Yak1VxpNQ7umx5WzZzp9MI3TP32w8+DpQ6vq6r
 nxPXSO7X6KG3CZ41Lb4DY9xuagOkoE0mm268FIHQc+2uSHI419mOJ2If9eHgZqYN8FZTM3tehC6
 Mw1kH5GwXagRotQyvXHboiQma5jYgmbczXRQa7X5IUYApL8hhv0ljX9AxxE4UacTzMAX8kQx4Qz
 9nQ1sLk=
X-Received: by 2002:a17:907:3ea7:b0:b87:e76:67a5 with SMTP id
 a640c23a62f3a-b8dacca9517mr219854666b.24.1769548982406; Tue, 27 Jan 2026
 13:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <20260126174313.1418150-3-ruslichenko.r@gmail.com> <aXggp66YwLpvM0_4@zatzit>
In-Reply-To: <aXggp66YwLpvM0_4@zatzit>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Tue, 27 Jan 2026 22:22:50 +0100
X-Gm-Features: AZwV_QjIZxLOcbRSx3jpoYKSeDsGZCuSMt-_EAIN3rYsv-v1AWv4UJrk3JjhzYk
Message-ID: <CAN-aV1GOxSoPVJ9rmLEKthEpRJrpt0UB3yzAzUs_9UHgFw3ckA@mail.gmail.com>
Subject: Re: [PATCH 02/27] system/device_tree: add few parsing and traversal
 helpers
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jan 27, 2026 at 3:19=E2=80=AFAM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Mon, Jan 26, 2026 at 06:42:48PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > The patch adds few utility functions for parsing FDT nodes.
> > The helpers are required for upcoming Hardware device tree
> > feature.
> >
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  include/system/device_tree.h |  30 ++++++
> >  system/device_tree.c         | 203 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 233 insertions(+)
> >
> > diff --git a/include/system/device_tree.h b/include/system/device_tree.=
h
> > index f34b8b7ef9..458dbb74b4 100644
> > --- a/include/system/device_tree.h
> > +++ b/include/system/device_tree.h
> > @@ -90,6 +90,13 @@ int qemu_fdt_setprop_string_array(void *fdt, const c=
har *node_path,
> >  int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
> >                               const char *property,
> >                               const char *target_node_path);
> > +
> > +uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
> > +                                     const char *property, int offset,
> > +                                     int size, Error **errp);
> > +const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
> > +                                    const char *property, int cell,
> > +                                    bool inherit, Error **errp);
> >  /**
> >   * qemu_fdt_getprop: retrieve the value of a given property
> >   * @fdt: pointer to the device tree blob
> > @@ -193,9 +200,32 @@ int qemu_fdt_setprop_sized_cells_from_array(void *=
fdt,
> >                                                  qdt_tmp);             =
    \
> >      })
> >
> > +typedef struct QEMUDevtreeProp {
> > +    char *name;
> > +    int len;
> > +    void *value;
> > +} QEMUDevtreeProp;
> > +
> > +/* node queries */
> > +
> > +char *qemu_devtree_get_node_name(void *fdt, const char *node_path);
> > +int qemu_devtree_get_num_children(void *fdt, const char *node_path, in=
t depth);
> > +char **qemu_devtree_get_children(void *fdt, const char *node_path, int=
 depth);
> > +int qemu_devtree_num_props(void *fdt, const char *node_path);
> > +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_pa=
th);
> >
> > +/* node getters */
> > +
> > +int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
> > +                                  const char *cmpname);
> > +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int p=
handle);
> >  int qemu_devtree_getparent(void *fdt, char *node_path,
> >                             const char *current);
> > +int qemu_devtree_get_root_node(void *fdt, char *node_path);
> > +
> > +/* misc */
> > +
> > +int devtree_get_num_nodes(void *fdt);
> >
> >  #define DT_PATH_LENGTH 1024
> >
> > diff --git a/system/device_tree.c b/system/device_tree.c
> > index 41bde0ba5a..7091a4928e 100644
> > --- a/system/device_tree.c
> > +++ b/system/device_tree.c
> > @@ -451,6 +451,50 @@ const void *qemu_fdt_getprop(void *fdt, const char=
 *node_path,
> >      return r;
> >  }
> >
> > +const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
> > +                                    const char *property, int cell,
> > +                                    bool inherit, Error **errp)
> > +{
> > +    int len;
> > +    const void *prop;
> > +    Error *err =3D NULL;
> > +
> > +    if (!errp) {
> > +        errp =3D &err;
> > +    }
> > +
> > +    prop =3D qemu_fdt_getprop(fdt, node_path, property, &len, inherit,=
 errp);
> > +    if (*errp) {
> > +        return NULL;
> > +    }
> > +    while (cell) {
>
> In DT context, "cell" refers specifically to a 32-bit integer value.
> It's not the right word for which string in a stringlist you retrieve.
>
> Also, most of this is re-implementing fdt_stringlist_get() from libfdt.
>
> > +        void *term =3D memchr(prop, '\0', len);
> > +        size_t diff;
> > +
> > +        if (!term) {
> > +            error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
> > +                      node_path, property, fdt_strerror(len));
> > +            return NULL;
> > +        }
> > +        diff =3D term - prop + 1;
> > +        len -=3D diff;
> > +        assert(len >=3D 0);
> > +        prop +=3D diff;
> > +        cell--;
> > +    }
> > +
> > +    if (!len) {
> > +        return NULL;
> > +    }
> > +
> > +    if (!*(char *)prop) {
> > +        error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
> > +                  node_path, property, fdt_strerror(len));
> > +        return NULL;
> > +    }
> > +    return prop;
> > +}
> > +
> >  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
> >                                 const char *property, int offset,
> >                                 bool inherit, Error **errp)
> > @@ -471,6 +515,22 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const ch=
ar *node_path,
> >      return be32_to_cpu(p[offset]);
> >  }
> >
> > +uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
> > +                                     const char *property, int offset,
> > +                                     int size, Error **errp)
> > +{
>
> Again, "cell" is 32-bits in DT context, you need a different word.
>
> > +    uint64_t ret =3D 0;
>
> Since ret is a u64, 'size' must be either 1 or 2.  So you might as
> well just have a get_u64() helper (getprop_cell already does u32).
>
> > +    for (; size; size--) {
> > +        ret <<=3D 32;
> > +        ret |=3D qemu_fdt_getprop_cell(fdt, node_path, property, offse=
t++, false,
> > +                                     errp);
> > +        if (errp && *errp) {
> > +            return 0;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> >  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
> >  {
> >      uint32_t r;
> > @@ -638,6 +698,117 @@ out:
> >      return ret;
> >  }
> >
> > +char *qemu_devtree_get_node_name(void *fdt, const char *node_path)
> > +{
> > +    const char *ret =3D fdt_get_name(fdt, fdt_path_offset(fdt, node_pa=
th), NULL);
>
> This does a full scan of the fdt, which may be unexpected.
>
> > +    return ret ? strdup(ret) : NULL;
> > +}
> > +
> > +int qemu_devtree_num_props(void *fdt, const char *node_path)
> > +{
> > +    int offset =3D fdt_path_offset(fdt, node_path);
> > +    int ret =3D 0;
> > +
> > +    for (offset =3D fdt_first_property_offset(fdt, offset);
> > +            offset !=3D -FDT_ERR_NOTFOUND;
> > +            offset =3D fdt_next_property_offset(fdt, offset)) {
> > +        ret++;
> > +    }
> > +    return ret;
> > +}
> > +
> > +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_pa=
th)
> > +{
> > +    QEMUDevtreeProp *ret =3D g_new0(QEMUDevtreeProp,
> > +                                    qemu_devtree_num_props(fdt, node_p=
ath) + 1);
> > +    int offset =3D fdt_path_offset(fdt, node_path);
> > +    int i =3D 0;
> > +
> > +    for (offset =3D fdt_first_property_offset(fdt, offset);
> > +            offset !=3D -FDT_ERR_NOTFOUND;
> > +            offset =3D fdt_next_property_offset(fdt, offset)) {
> > +        const char *propname;
> > +        const void *val =3D fdt_getprop_by_offset(fdt, offset, &propna=
me,
> > +                                                    &ret[i].len);
> > +
> > +        ret[i].name =3D g_strdup(propname);
> > +        ret[i].value =3D g_memdup2(val, ret[i].len);
> > +        i++;
> > +    }
> > +    return ret;
>
> How does the caller free the structure?  Using g_free() will leak all
> the copied names and values.
>
> > +}
> > +
> > +static void qemu_devtree_children_info(void *fdt, const char *node_pat=
h,
> > +        int depth, int *num, char **returned_paths) {
> > +    int offset =3D fdt_path_offset(fdt, node_path);
> > +    int root_depth =3D fdt_node_depth(fdt, offset);
>
> "root" implies the root of the whole tree, not of the node where you
> started.  Also, two full scans of the tree above.
>
> > +    int cur_depth =3D root_depth;
> > +
> > +    if (num) {
> > +        *num =3D 0;
> > +    }
> > +    for (;;) {
> > +        offset =3D fdt_next_node(fdt, offset, &cur_depth);
> > +        if (cur_depth <=3D root_depth) {
> > +            break;
> > +        }
> > +        if (cur_depth <=3D root_depth + depth || depth =3D=3D 0) {
> > +            if (returned_paths) {
> > +                returned_paths[*num] =3D g_malloc0(DT_PATH_LENGTH);
>
> No test to avoid overrunning the length of the returned_paths[] array
> here.
>
> > +                fdt_get_path(fdt, offset, returned_paths[*num], DT_PAT=
H_LENGTH);
>
> Another full tree scan for every entry here.
>
> > +            }
> > +            if (num) {
> > +                (*num)++;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +char **qemu_devtree_get_children(void *fdt, const char *node_path, int=
 depth)
> > +{
> > +    int num_children =3D qemu_devtree_get_num_children(fdt, node_path,=
 depth);
> > +    char **ret =3D g_malloc0(sizeof(*ret) * num_children);
> > +
> > +    qemu_devtree_children_info(fdt, node_path, depth, &num_children, r=
et);
> > +    return ret;
> > +}
> > +
> > +int qemu_devtree_get_num_children(void *fdt, const char *node_path, in=
t depth)
> > +{
> > +    int ret;
> > +
> > +    qemu_devtree_children_info(fdt, node_path, depth, &ret, NULL);
> > +    return ret;
> > +}
> > +
> > +int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
> > +        const char *cmpname) {
>
> The semantics of this make no sense to me.  It finds the first node
> with the name after the given node, whether it's a child, sibling or
> unrelated node.   I'm guessing you want something based on
> fdt_subnode_offset() instead.
>
> > +    int offset =3D 0;
> > +    char *name =3D NULL;
> > +
> > +    do {
> > +        char *at;
> > +
> > +        offset =3D fdt_next_node(fdt, offset, NULL);
>
> No test for error here, before using 'offset'.
>
> > +        name =3D (void *)fdt_get_name(fdt, offset, NULL);
> > +        if (!name) {
> > +            continue;
>
> The only errors from fdt_get_name() indicate either a corrupted DT, or
> bad parameters.  continuing at this point will not do anything useful.
>
> > +        }
> > +        at =3D memchr(name, '@', strlen(name));
> > +        if (!strncmp(name, cmpname, at ? at - name : strlen(name))) {
> > +            break;
> > +        }
> > +    } while (offset > 0);
> > +    return offset > 0 ?
> > +        fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH) : 1;
> > +}
> > +
> > +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int p=
handle)
> > +{
> > +    return fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle),
> > +                            node_path, DT_PATH_LENGTH);
>
> Two full tree scans.
>
> > +}
> > +
> >  int qemu_devtree_getparent(void *fdt, char *node_path, const char *cur=
rent)
> >  {
> >      int offset =3D fdt_path_offset(fdt, current);
> > @@ -648,6 +819,38 @@ int qemu_devtree_getparent(void *fdt, char *node_p=
ath, const char *current)
> >          fdt_get_path(fdt, parent_offset, node_path, DT_PATH_LENGTH) : =
1;
> >  }
> >
> > +int qemu_devtree_get_root_node(void *fdt, char *node_path)
> > +{
> > +    return fdt_get_path(fdt, 0, node_path, DT_PATH_LENGTH);
>
> The root node's path is "/" by definition, you don't need this
> function.
>
> > +}
> > +
> > +static void devtree_scan(void *fdt, int *num_nodes)
>
> "scan" is vague.  The name should reflect what this actually does.
>
> > +{
> > +    int depth =3D 0, offset =3D 0;
> > +
> > +    if (num_nodes) {
> > +        *num_nodes =3D 0;
> > +    }
> > +    for (;;) {
> > +        offset =3D fdt_next_node(fdt, offset, &depth);
> > +        if (num_nodes) {
> > +            (*num_nodes)++;
> > +        }
> > +        if (offset <=3D 0 || depth <=3D 0) {
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +int devtree_get_num_nodes(void *fdt)
> > +{
> > +    int ret;
> > +
> > +    devtree_scan(fdt, &ret);
> > +    return ret;
> > +}
> > +
> > +
> >  void qmp_dumpdtb(const char *filename, Error **errp)
> >  {
> >      ERRP_GUARD();
> > --
> > 2.43.0
> >
>

Hi David!
Thank you for the detailed review for this and previous patches.
I will follow up your comments in the v2 patch series.



> --
> David Gibson (he or they)       | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you, not the other wa=
y
>                                 | around.
> http://www.ozlabs.org/~dgibson

