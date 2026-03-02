Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5B9EB3632
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxAU5-0006l2-1M; Mon, 02 Mar 2026 16:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vxAU2-0006kO-D3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:07:19 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vxAU0-0001AL-0d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:07:18 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-679efb9eb0dso4029072eaf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 13:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772485634; cv=none;
 d=google.com; s=arc-20240605;
 b=TiYJ9QuMvnOujkBmTqeA6iKgSWlbfkq93QAlgckBN/oy14ugW+l10mssdLTZMqp+Hb
 n5TM1LaiE8vuJ6itV1NCtzQR4Hgcsanf13Aenx3xLBBipUjxxPmkrrTH97zY/UgwaG4E
 H3yDgzQ/dn6ZXsOtdalfSezI9OKvtSZ8pa4xNzpaGsjCE+/nk+EX8iWc7/noRcnv6Xt1
 qK9jOp0uLjWvq+0dSZzIlodqaGQLoPIhbBHhhZKIiCtnWYKPXRgc7S2i5wRK92W1D7FW
 qCQPYkC6eJJP3UPecGadPlIbQUowcmcha2cNXfAfsf46ELiLRkN6qEQ92OZWgRgRLJQj
 fKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VMXnQxj3qAUHWMDMrvfiRUeHzQgsxMC8GA7kER9QlAg=;
 fh=U39PmFavrHPjECQQd1GB3et4CkI7X+0j50odXDdWbyc=;
 b=cKRLYGZZkeAcZW8qwjo0IZ5MANA6QoIydzWuSy2+LTvIRofMJKvb1CP6u1l7DiG+6f
 VdhDl0sKLXamb/GFZvVMYzKLjeIkInNsPoeVw+IeP0ql62vuxFcwSE4nGPQxGKrttM8w
 7SsNT+4VxdqkvghndDws8zHRcj/NFOnH7PMgDqgde4sO6yY3AYvIVW/s17TdqBl4b9SS
 ESBDugTFw8q6EzGhpTZbrCc9snmHoSoDo5F1OkqwwJxoAg0mc+6vVMBBJOrNH5J20Inl
 EKqpkCXuSBiQNUFRPlNRlAa330T7HBwIFXZzqc2k7q3rTrsmDvxlTahxk4uQWtS8Bbi6
 RShA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772485634; x=1773090434; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMXnQxj3qAUHWMDMrvfiRUeHzQgsxMC8GA7kER9QlAg=;
 b=fMEn4jlO8U+oug5RqclDteBdhMbRaLJhfrcP5qUUGSCELEl13/K0rXaumZz2Xe1uRd
 FwX4NmHsQSjSol7Xaoh/5x+L31lADBxF9znIuPKYnNq92I56mXAXxxrxUuwDhst8KRvI
 eBqZvR4GmuZB1CYOx5c/1FnlVDJuwqTvZnUQw10ZZODC3YkoGg0cyefFb0j7pAg9YEZ0
 k6f9HhxpuZ1L0UzIWLaVJF/9hFOo10I56udyQxTcSnZdPJEEwT0AOr29lBIEC06GK5jV
 FQsqIhTBWTBnT7QIf6d3DPDU1Nd5DQoOZbxEKucNhS14nVuuoFcIhjzpD5PasI8jOIHc
 cWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772485634; x=1773090434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VMXnQxj3qAUHWMDMrvfiRUeHzQgsxMC8GA7kER9QlAg=;
 b=D4W/RAlim/A6vC6xf3xC7JkSKobcDiMiSCF4Vt2OzPP0geZc7KXVDXwZOTbdyED/tk
 ZDbLZhUigK1B0VyfEx36h2BJp61BjYPGeP6CludKRm5RB3H4TZ3zErgfgxJsiKv6G47R
 xCh8N+Xpq35tHjS6X44RDF+S+u9fhk5MfQ2XsoOIc/w0CSVC9YnGL1G28okUAC8tXo9t
 hzW0vRX1FXGHcNPmIM2VP1zmzuCHVm5HgHOkJsupOdA3EU0Y2wzd/QAyay17iyWpU+Kp
 nhhE7e/v9RaIjoD2En5rUxWjXCppIttPOUAGgYgsfgCDx5FWRPbv4h/ynhwfK9SRqDvE
 /0yA==
X-Gm-Message-State: AOJu0YxKY7yvJQ6+VwYXJWThrynMNAiDHF/inVTRmKIQdW7TcjrVhAHz
 uZmqgRb0BsOF3tG8JMlr/uhGoQhNMX9A4jcTpJKuVYOTiopPybxv7P9EzW3Ambx6xTFStX1v2rm
 ZcFCJPAxi400PQRg86Auvo8C7zmbCIdo=
X-Gm-Gg: ATEYQzzZ6iqcq1gZRv8JBtK3Xqch83wAHLHyCq9ws6ce7jHMxBOM8+7kBdNVeM1HQLj
 NxgLyhI2TjFh96DgKyeP3ema4NQMAb5y96yn1VMstG4URPDjbEEzqx2s/trXZS6+JUZyaztTzs9
 NqfUOfgc1zAY2tEMNq+o2ZhTMGEQhEiiAgEGPStK0xf4pRH4MGkfel0YOOPX8InLMOHS30mTG9W
 hLz4xGGSCG+WAuehuVkTxhrT5TeecT5BGh18943v8qLjgBPKSjXHFttDlGrW2j7+fkZa18FNRUA
 9PEQ7mlk
X-Received: by 2002:a05:6820:3088:b0:679:e5a2:1603 with SMTP id
 006d021491bc7-679faf4f360mr7357340eaf.63.1772485634105; Mon, 02 Mar 2026
 13:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219143332.3316679-3-ruslichenko.r@gmail.com> <aaTqq27wf7i9bzKy@zatzit>
In-Reply-To: <aaTqq27wf7i9bzKy@zatzit>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Mon, 2 Mar 2026 22:07:02 +0100
X-Gm-Features: AaiRm50BJpRBfXjqxnhKeRsypZ0FZj1e6ugToygVf_iB6kgA9r8NSe7VjQbqHng
Message-ID: <CAN-aV1FMEO8haqv_ddQRO_9=JevMmDW=cdJcDuj93epaLDuFjg@mail.gmail.com>
Subject: Re: [PATCH v2 02/33] system/device_tree: add few parsing and
 traversal helpers
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 peter.maydell@linaro.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com,
 balaton@eik.bme.hu, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Mon, Mar 2, 2026 at 2:41=E2=80=AFAM David Gibson <david@gibson.dropbear.=
id.au> wrote:
>
> On Thu, Feb 19, 2026 at 03:33:01PM +0100, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > The patch adds few utility functions for parsing FDT nodes.
> > The helpers are required for upcoming Hardware device tree
> > feature.
> >
> > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > ---
> >  include/system/device_tree.h |  30 +++++
> >  system/device_tree.c         | 221 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 251 insertions(+)
> >
> > diff --git a/include/system/device_tree.h b/include/system/device_tree.=
h
> > index 5667ff9538..9d6b570bdb 100644
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
> > @@ -191,6 +196,31 @@ int qemu_fdt_setprop_sized_cells_from_array(void *=
fdt,
> >                                                  qdt_tmp);             =
    \
> >      })
> >
> > +typedef struct QEMUDevtreeProp {
> > +    const char *name;
> > +    int len;
> > +    const void *value;
> > +} QEMUDevtreeProp;
>
> If you need this, it really starts to seem to me that keeping the data
> structure in fdt is not the right choice any more.  I've thought for a
> while that with increasing handling of the device tree by qemu, we
> should maybe have a "live" device tree representation (with pointers)
> that we use for manipulation.  Right before boot, that can be
> serialized into fdt.
>
> fdt is, fundamentally, a serialization format.  Direct fdt
> manipulation with libfdt was really only intended as something to
> allow firmwares and similarly minimal programs to make small tweaks.
> Once manipulation becomes extensive, fdt is no longer a good choice of
> data structure.
>

For this series, the generic machine is strictly read-only regarding the FD=
T
(we only parse it to instantiate devices, we don't manipulate or
rewrite the tree).

So to simplify things, I can drop the QEMUDevtreeProp wrapper and just
use standard
libfdt iteration macros (like fdt_for_each_property_offset) to keep
the footprint
as small as possible.

Would this approach be acceptable for now? I can prepare this modification =
along
with other review comments for v3 patch series.

> > +
> > +/* node queries */
> > +
> > +int qemu_devtree_get_num_children(void *fdt, const char *node_path);
> > +int qemu_devtree_get_children(void *fdt, const char *node_path,
> > +                                     int max_paths, char **returned_pa=
ths);
> > +int qemu_devtree_num_props(void *fdt, const char *node_path);
> > +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_pa=
th);
> > +
> > +/* node getters */
> > +
> > +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int p=
handle);
> > +int qemu_devtree_getparent(void *fdt, char *node_path,
> > +                           const char *current);
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
> > index d2db7bd355..fc34c660db 100644
> > --- a/system/device_tree.c
> > +++ b/system/device_tree.c
> > @@ -464,6 +464,103 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const c=
har *node_path,
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
> > +int qemu_devtree_getparent(void *fdt, char *node_path, const char *cur=
rent)
> > +{
> > +    const char *sep;
> > +    int len;
> > +
> > +    if (!current || !node_path) {
> > +        return -FDT_ERR_NOTFOUND;
> > +    }
> > +
> > +    if (current[0] =3D=3D '/' && current[1] =3D=3D 0) {
>
> strcmp() against "/" is maybe marginally more costly, but clearer in
> meaning.
>
> > +        return -FDT_ERR_NOTFOUND;
> > +    }
> > +
> > +    sep =3D strrchr(current, '/');
> > +    if (!sep) {
> > +        return -FDT_ERR_BADPATH;
> > +    }
> > +
> > +    if (sep =3D=3D current) {
> > +        len =3D 1;
> > +    } else {
> > +        len =3D sep - current;
> > +    }
> > +
> > +    memcpy(node_path, current, len);
> > +    node_path[len] =3D '\0';
>
> This assumes node_path points to a long enough buffer.  Returning a
> g_strndup()ed copy of the parent path might be a nicer interface?
>
> > +
> > +    return 0;
> > +}
> > +
> >  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
> >  {
> >      uint32_t r;
> > @@ -631,6 +728,130 @@ out:
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
> > +        ret[i].name =3D propname;
> > +        ret[i].value =3D val;
> > +        i++;
> > +    }
> > +    return ret;
> > +}
> > +
> > +int qemu_devtree_get_children(void *fdt, const char *node_path,
> > +                                     int max_paths, char **returned_pa=
ths) {
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
> > +        if (cur_depth > 64) {
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

--
BR,
Ruslan Ruslichenko

