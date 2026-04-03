Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC924E8538B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8iHU-0004rV-Kd; Fri, 03 Apr 2026 13:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8iHQ-0004qA-Nu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 13:26:01 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8iHO-0003hV-Rw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 13:26:00 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1825797a34.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 10:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775237157; cv=none;
 d=google.com; s=arc-20240605;
 b=iTQvDYhpU54AZMUfxoR2XkGhjVDceYcD+W8WMIGfD7oa8UfgWJnAjvwHcwJZ06UjFP
 co77n8P7TsoO0r4eANcC24zYoU+Fw5PANc/fgoErxwz3uTF9ye3wYVHnHTavHtE0KL4i
 QOs9GIgdS28NaqMmkF3thXICxLB0BhKuXcs3NOtIlqylU1WmrloSmGHEqom5zYidH6X7
 aj9zsj5rkF4RVM//lZlzrQ5HWklH0yrSys4ETOwCX6A+u39WHAKZ4bMCVyQVhTRJGStE
 7V+mCrIl6kdFktRR8rbFNl521SBSU2M8hXXGK0pSHCnuRP9h9Oyb07tSKLE9/DRZmKml
 Uqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pDmghM8ARRiPsj8Q17aW1dNVR7bL8LTO6qYzIbK58Og=;
 fh=U39PmFavrHPjECQQd1GB3et4CkI7X+0j50odXDdWbyc=;
 b=ObDEQA01TyOi40rsDFj/G9G9VZZmLIhQgggCw8GgZyLOfwnsyHe0RiRgHHbrqLEE56
 yM37npK/+gGY1iM2x1VInjgeRZ2/8NtQN3ECMxd7r+NbivQTVLFFfQqfRD4MEGdNNw/u
 Qu7K0NYV7AMpjE0rLFYbpo4wYHpffRRIwlWyJVTlzx6kuVYjd2BSRo5u9L0DlyKyG8BN
 ji+5Mmw7BZf4GxpUwXw0pn8K3qbwdcz0MLRHKXxFhS0kzRHO5fc1jwhwpC3z5NE+Xz6C
 ZH2okIu5Tlwm9lwR+4I8wtRIyd8JaDYTfOMLDLdeMYdLbyD1+LuJqa3k6gmrNJOFVCgf
 KETg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775237157; x=1775841957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDmghM8ARRiPsj8Q17aW1dNVR7bL8LTO6qYzIbK58Og=;
 b=V1LJ2eHSCnFhOTjY54D8FwSrf3EJ0ZNiqrWSRmIlwxyX9G93vqkCRI+BbIbTQEgizP
 U4QlUnQ+soBpxyNxNv+FwyGxyG8soZjLEXgSvDUeBxCT6gEytUahNa5ta+Z6l0tyBVlh
 hs20P8R2YnKEu+CXLhaI+4u+KWZfE9YHcejgFzldWexCI/hxCOwxn4hWMJIwESNbrBb7
 DubUVfP9RtGjl9ylgNEOxMcs6LAfgNgkEhtK/Tu1rxBtq+mQf0LhuiPMlVgmCv1vLqIE
 hMViKV6Xi1cCdfQuYzjBBd9c8nGzl6ejVmTgeO5VFaeCc16UVtFApBYf1w7YZBoQCDkn
 FDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775237157; x=1775841957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDmghM8ARRiPsj8Q17aW1dNVR7bL8LTO6qYzIbK58Og=;
 b=LpLhmNNviXSJJjzsQDTLnH4rTs087iTR+eymT0pf9OtxdCGkLWSydDC8dVLbeE3D1m
 VbIoBD1VwI/5tFffExgfPQtrbGSPq56iMoDlBF0dFmdyyZGTzsnRCovZRTyZ3vojOUQG
 7l06KY4UkVr3YjZ/HfQzpPKLgk6ZTbOTkcVqGN3VYYcyHVMFxTbPbfVKX2fiYMOtw8cT
 /6xsIGJ/YUgyFzm3W8BC14O9bWxVxK8MzT6QfsmkhGY9qqHrcXYnNrgpNSvSm6zy8o0V
 zEgNQLuW9J+SKE2w9PkQahCczope4SKIsPap0y1aVCX+M3AxOGi/M+dUrsPnKlYJkKwR
 lueg==
X-Gm-Message-State: AOJu0YwLwnOc9C/iTL2M6lzB8Fcb5QKp3Iz+v3qiGfeMv/t2rbmrRkg+
 uvX/2FIObQEbkmnvTk04vWHvcLCj5aqNDQoLa8i04qzw1T3c6Apn0O+SczgD+ZSs2vkaeZs7U9v
 Rd4Mq8Ttsho+0vjCbPjPTzjk98nfRels=
X-Gm-Gg: ATEYQzxdzOezXI2QpxqgHX1UU42RhAUGMcSt16lRT7l13qYVzFR5/mYqInnAZJ0QDaN
 2dBICRLI1xGbgC/LkV/I9iiAZAHyZUMHDXexlS4YH6bAQH/+HhT8VTfy17L7j+PrYCgFGHBcMbj
 +Y/mQBbcI9yLBB/cGbeS4VSGTmYy+haP5UfhjqLzgLvxTS0xYQ4Zt4jibSe1lhyK/h5+23QYLOr
 R78idY9rTm28clWyptQpEaOf437dnVpmuGCNKr1DGAOlsR4VI+1SPQRWP4ME2D2NdYZf28lLaPz
 Tg8RnNc=
X-Received: by 2002:a05:6830:6c10:b0:7d7:bf70:af2 with SMTP id
 46e09a7af769-7dbb732ffc9mr2221895a34.1.1775237156928; Fri, 03 Apr 2026
 10:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
 <20260402215629.745866-3-ruslichenko.r@gmail.com> <ac8PO_EpAiWxczDy@zatzit>
In-Reply-To: <ac8PO_EpAiWxczDy@zatzit>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 3 Apr 2026 19:25:45 +0200
X-Gm-Features: AQROBzCLkjDP733gcPutaBWRl8O4OViTBh3PcJ-axO0TuztlCvj5kfUZY9WTwoQ
Message-ID: <CAN-aV1H92A6OS8C12b2rij+kC84=EdxAoxH3ARW+rq9GvRsz_A@mail.gmail.com>
Subject: Re: [PATCH v3 02/33] system/device_tree: add few parsing and
 traversal helpers
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 peter.maydell@linaro.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com,
 balaton@eik.bme.hu, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Apr 3, 2026 at 2:52=E2=80=AFAM David Gibson <david@gibson.dropbear.=
id.au> wrote:
>
> On Thu, Apr 02, 2026 at 11:55:47PM +0200, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > The patch adds few utility functions for parsing FDT nodes.
> > The helpers are required for upcoming Hardware device tree
> > feature.
>
> If you're building an entire fdt based machine type, it really seems
> like you might want a "live" dt representation - the flattened format
> is great for communicating between things, but it's not a good data
> structure if you're actively consulting it.
>

Hi David,

Thank you for the feedback.
I will look into switching to a live DT representation for the next
version of the series.

BR,
Ruslan

> >
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  include/system/device_tree.h |  22 ++++
> >  system/device_tree.c         | 194 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 216 insertions(+)
> >
> > diff --git a/include/system/device_tree.h b/include/system/device_tree.=
h
> > index 5667ff9538..bc378d38d0 100644
> > --- a/include/system/device_tree.h
> > +++ b/include/system/device_tree.h
> > @@ -116,6 +116,11 @@ const void *qemu_fdt_getprop(void *fdt, const char=
 *node_path,
> >  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
> >                                 const char *property, int cell_id,
> >                                 Error **errp);
> > +
> > +const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_pat=
h,
> > +                             const char *property, int *lenp, Error **=
errp);
> > +uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_p=
ath,
> > +                               const char *property, int cell_id, Erro=
r **errp);
> >  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
> >  uint32_t qemu_fdt_alloc_phandle(void *fdt);
> >  int qemu_fdt_nop_node(void *fdt, const char *node_path);
> > @@ -191,6 +196,23 @@ int qemu_fdt_setprop_sized_cells_from_array(void *=
fdt,
> >                                                  qdt_tmp);             =
    \
> >      })
> >
> > +/* node queries */
> > +
> > +int qemu_devtree_get_num_children(void *fdt, const char *node_path);
> > +int qemu_devtree_get_children(void *fdt, const char *node_path,
> > +                                     int max_paths, char **returned_pa=
ths);
> > +int qemu_devtree_num_props(void *fdt, const char *node_path);
> > +
> > +/* node getters */
> > +
> > +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int p=
handle);
> > +char *qemu_devtree_getparent(void *fdt, const char *current);
> > +
> > +/* misc */
> > +
> > +int devtree_get_num_nodes(void *fdt);
> > +
> > +#define DT_PATH_LENGTH 1024
> >
> >  /**
> >   * qemu_fdt_randomize_seeds:
> > diff --git a/system/device_tree.c b/system/device_tree.c
> > index d2db7bd355..1a70223712 100644
> > --- a/system/device_tree.c
> > +++ b/system/device_tree.c
> > @@ -464,6 +464,96 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const ch=
ar *node_path,
> >      return be32_to_cpu(p[cell_id]);
> >  }
> >
> > +const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_pat=
h,
> > +                             const char *property, int *lenp, Error **=
errp)
> > +{
> > +    const void *found_val =3D NULL;
> > +    int found_len =3D 0;
> > +    int curr_offset =3D 0;
> > +    int temp_len;
> > +    char **tokens;
> > +    char **iter;
> > +
> > +    found_val =3D fdt_getprop(fdt, 0, property, &found_len);
> > +
> > +    tokens =3D g_strsplit(node_path + 1, "/", -1);
> > +
> > +    for (iter =3D tokens; *iter !=3D NULL; iter++) {
> > +        if (**iter =3D=3D '\0') {
> > +            continue;
> > +        }
> > +
> > +        curr_offset =3D fdt_subnode_offset(fdt, curr_offset, *iter);
> > +        if (curr_offset < 0) {
> > +            error_setg(errp, "%s: Path '%s' not found",
> > +                       __func__, *iter);
> > +            g_strfreev(tokens);
> > +            return NULL;
> > +        }
> > +
> > +        const void *val =3D fdt_getprop(fdt, curr_offset, property, &t=
emp_len);
> > +        if (val) {
> > +            found_val =3D val;
> > +            found_len =3D temp_len;
> > +        }
> > +    }
> > +    g_strfreev(tokens);
> > +
> > +    if (!found_val) {
> > +        error_setg(errp, "%s: Property '%s' not found",
> > +                   __func__, property);
> > +        return NULL;
> > +    }
> > +
> > +    if (lenp) {
> > +        *lenp =3D found_len;
> > +    }
> > +
> > +    return found_val;
> > +}
> > +
> > +uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_p=
ath,
> > +                               const char *property, int cell_id, Erro=
r **errp)
> > +{
> > +    int len;
> > +    const uint32_t *p;
> > +
> > +    p =3D qemu_fdt_getprop_inherited(fdt, node_path, property, &len, e=
rrp);
> > +    if (!p) {
> > +        return 0;
> > +    }
> > +    if (len < (cell_id + 1) * 4) {
> > +        error_setg(errp,
> > +                   "%s: %s/%s is too short, need %d bytes for cell ind=
 %d",
> > +                   __func__, node_path, property, (cell_id + 1) * 4, c=
ell_id);
> > +        return 0;
> > +    }
> > +    return be32_to_cpu(p[cell_id]);
> > +}
> > +
> > +char *qemu_devtree_getparent(void *fdt, const char *current)
> > +{
> > +    const char *sep;
> > +    int len;
> > +
> > +    if (!current || !strcmp(current, "/")) {
> > +        return NULL;
> > +    }
> > +
> > +    sep =3D strrchr(current, '/');
> > +    if (!sep) {
> > +        return NULL;
> > +    }
> > +
> > +    if (sep =3D=3D current) {
> > +        len =3D 1;
> > +    } else {
> > +        len =3D sep - current;
> > +    }
> > +
> > +    return g_strndup(current, len);
> > +}
> > +
> >  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
> >  {
> >      uint32_t r;
> > @@ -631,6 +721,110 @@ out:
> >      return ret;
> >  }
> >
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
> > +int qemu_devtree_get_children(void *fdt, const char *node_path,
> > +                                     int max_paths, char **returned_pa=
ths)
> > +{
> > +    int count =3D 0;
> > +    int subnode;
> > +    const char *name;
> > +    int offset =3D fdt_path_offset(fdt, node_path);
> > +
> > +    if (offset < 0) {
> > +        return offset;
> > +    }
> > +
> > +    bool is_root =3D (strcmp(node_path, "/") =3D=3D 0);
> > +
> > +    fdt_for_each_subnode(subnode, fdt, offset) {
> > +        if (count >=3D max_paths) {
> > +            break;
> > +        }
> > +        name =3D fdt_get_name(fdt, subnode, NULL);
> > +        if (returned_paths) {
> > +            returned_paths[count] =3D g_strdup_printf("%s/%s",
> > +                                                is_root ? "" : node_pa=
th, name);
> > +        }
> > +
> > +        ++count;
> > +    }
> > +
> > +    return count;
> > +}
> > +
> > +int qemu_devtree_get_num_children(void *fdt, const char *node_path)
> > +{
> > +    int count =3D 0;
> > +    int subnode;
> > +    int offset =3D fdt_path_offset(fdt, node_path);
> > +
> > +    if (offset < 0) {
> > +        return offset;
> > +    }
> > +
> > +    fdt_for_each_subnode(subnode, fdt, offset) {
> > +        ++count;
> > +    }
> > +
> > +    return count;
> > +}
> > +
> > +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int p=
handle)
> > +{
> > +    int offset =3D 0, cur_depth =3D 0;
> > +    int path_lens[64] =3D { 0 };
> > +
> > +    for (offset =3D 0; offset >=3D 0; offset =3D fdt_next_node(fdt, of=
fset,
> > +                                                         &cur_depth)) =
{
> > +        if (cur_depth >=3D 64) {
> > +            break;
> > +        }
> > +        const char *name =3D fdt_get_name(fdt, offset, NULL);
> > +
> > +        int parent_len =3D (cur_depth > 0) ? path_lens[cur_depth - 1] =
: 0;
> > +        int len =3D snprintf(node_path + parent_len,
> > +                             DT_PATH_LENGTH - parent_len,
> > +                             "%s%s",
> > +                             (parent_len > 1) ? "/" : "",
> > +                             (cur_depth =3D=3D 0) ? "/" : name);
> > +
> > +        path_lens[cur_depth] =3D parent_len + len;
> > +
> > +        if (fdt_get_phandle(fdt, offset) =3D=3D phandle) {
> > +            return 0;
> > +        }
> > +    }
> > +
> > +    return -FDT_ERR_NOTFOUND;
> > +}
> > +
> > +int devtree_get_num_nodes(void *fdt)
> > +{
> > +    int num_nodes =3D 0;
> > +    int depth =3D 0, offset =3D 0;
> > +
> > +    for (;;) {
> > +        offset =3D fdt_next_node(fdt, offset, &depth);
> > +        num_nodes++;
> > +        if (offset <=3D 0 || depth <=3D 0) {
> > +            break;
> > +        }
> > +    }
> > +    return num_nodes;
> > +}
> > +
> >  void qmp_dumpdtb(const char *filename, Error **errp)
> >  {
> >      ERRP_GUARD();
> > --
> > 2.43.0
> >
>
> --
> David Gibson (he or they)       | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you, not the other wa=
y
>                                 | around.
> http://www.ozlabs.org/~dgibson

