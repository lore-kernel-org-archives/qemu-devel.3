Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB17CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 23:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcWgY-0006WN-TH; Wed, 24 Jun 2026 19:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWgW-0006WA-Qw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 19:07:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWgU-0001ob-FY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 19:07:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c0c5d170ad4so186204566b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782342424; cv=none;
 d=google.com; s=arc-20240605;
 b=Xc1NstyM9INo1KKHM+HXFS7ezUDDXHNT4oM1oNqvcUUqxenZ0S69Loh2n57p4zExwF
 7iz+4bdPKxYYry/t5T4Nk0b9Oz/CQ997tpMPKhRvPGayVUK0wI8Q317KAOBQTmOwGAFT
 OGlPelrX6BfzMSfwpXKHZqeLc6FBrfin6TROkWSJpbgVOPA29dNoqZSXUTHyUWQGdLvW
 U3nDS/eFF0sUoHX9kPnIK77R2VNVAg7CvUKN4TsVT60wxdvSSYBPyTY7Ji/cUWAUMoLI
 0VKmMQcO/6hX+koR09naMFTEo76Cq6oUP6J9M49YAsClhSbUYQz/n9hv/O/DLSzlWeLm
 XmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TduP9b+d6EL8k9ZCvJ0zqFFHK5C1R3CDBlGzDZoElqQ=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=Cyr+d4If7c98opCWBwh4ttotSsqums8kvW2U//DdaSrZZzV5L96GH9CHWECVq1ByUR
 R9lLdZZkj6/nHp+hp8Vr/NU2fnnjJCgWW2zUUq7PNjd2ymu+0Nrahp/AGxOZgjfiXct0
 hnxg7DPrHJAufhZdpfqL1k/elHyPPHu5w47YkdKYPc6bReis0dH2+oZu3Qp0mnOiTG79
 GPFMgcrXTCp2Mj48n7m0d1Hz/cjL5q5BspG2eix4nDOu50cxzyM2oxtPU6sPipSIvfJ1
 SLtiF6hMxre3mLRchNVxp2g8tN4ox5o1dXhys3zAwQz3wS4OeDyDLLF53LGuQtcDCqs7
 P07Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782342424; x=1782947224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TduP9b+d6EL8k9ZCvJ0zqFFHK5C1R3CDBlGzDZoElqQ=;
 b=tImElDo69b75MPeE532cMzjKzHKzxys551G5MP/PEphF6U6Jo1qmm+sS89GqQvUq4u
 pLnySEtkSJkMWLwdN+BwGgJekq5HhgZtN63NbtIdXth23R2OpifgyWkmv2VlQovHLuc7
 ZMARqSmLxmW3p9dm1vGbKUc+wHYrFizO0RBDF4f5HLYMVuPKG79gi0Sn8ke4NCywvz0B
 go3haqyTWLxu3KtSViOAnJpXh0jEVsi9aE4L6tVRDrlHJCvDwWCFqzTvbcLYnByFbEEj
 4KCh/aLc7SqTSbD0RmYnH86K4gezruYt2d6mvyuBYe/DIdge7HC6ATdnDWeaiHHFDMst
 5XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782342424; x=1782947224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TduP9b+d6EL8k9ZCvJ0zqFFHK5C1R3CDBlGzDZoElqQ=;
 b=EplxLLVyLD9SXH2O8ANHk+YexjsxTrUj0RUHp98M4HFRwEEi0Zbed9gjzpX0Cizx8X
 +Gl/sfzIWQBX/9o8+2chm2qVCVskMy4rmuBOyNb0KtxFbokz9t17YTio97XTBs6oPUQu
 vUmsZm5UVBaBa+cOm1XvCqQbsq1T2p4YMe1etj5Y1nIaibc1WUK5tE4ys8W2QByZRA7d
 bSqhJwHhM2Sh8FGWbVOyjMMespZjLHnHZy6vXTC8D+Ujy/0miGCyUcsrDjqP8lccrjqE
 iRBj/8Sj57CYZXJKGh+VNnUJ//82d1Mok3/lsII73dc6FRz1x2J+cIIAWogEc/abbQqL
 uKrA==
X-Gm-Message-State: AOJu0YzGHx0TaCYis6yRuHthWEzj7zp17HnQutJzO2ph6nTysf1cB29Q
 Rl5tC2HTq9EyLqOcLFFyWcI41mNfBQWNVIYj5nmLUjeMcU3scpANmBEEfvvd8pAWl0buWnsGPlq
 919+C+D6buwYHsB65lCljzSR+IsgTsOg=
X-Gm-Gg: AfdE7ck5IcDnsV6c8CwkfhYT/iNDaR+xRNxtWeYMPIlBIRb4xkt5QVIxWvewJ/aB3It
 6PXvqx6PVP7hEReyDiJYFBK3Y6PsWULf7KfvBQm/GYnbp3VTFCnjbc4j6qS6w4z2nhsVPurteXV
 baLcCaliJ/PJMzbsioYxsyko7Foad3MyA9bU/ZH6vf1nM09ile/j1xaISHmzmFw+FBuZn1GGvyY
 wOa1pQ4iEEuLLCnWcf7waF5WgZ+nkwulhiQmBA8ceQWi238xRZw3UOpp2WpzwSr2Ox9Qq3T
X-Received: by 2002:a17:907:1c1e:b0:c0d:5c7b:cf0a with SMTP id
 a640c23a62f3a-c119e459f60mr318206766b.27.1782342423685; Wed, 24 Jun 2026
 16:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
 <20260624175143.GD109308@fedora>
In-Reply-To: <20260624175143.GD109308@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Jun 2026 07:06:26 +0800
X-Gm-Features: AVVi8Cc7gNFhgxbzcoD_6UJPPhk4S3L0JunkYurspJDPGjY4VtVJZaJMCPx0Qzc
Message-ID: <CAK3tnvLhx9HipFENkMm-pdOqvLZUYDdF=VuFzQ=gyD4TV__eSw@mail.gmail.com>
Subject: Re: [PATCH V9 05/17] block/export: track IOThread reference in
 BlockExport
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x629.google.com
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

On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:39PM +0800, Zhang Chen wrote:
> > Users currently lack visibility into which block exports
> > are utilizing specific IOThreads. This patch integrates IOThread
> > referencing into the BlockExport lifecycle.
> >
> > - Add iothreads array and holder_name to BlockExport struct.
> > - Use iothread_ref_and_get_aio_context during export creation.
> > - Implement proper cleanup in blk_exp_add fail path and blk_exp_delete_=
bh.
> > - Support both single and multi-iothread export configurations.
> >
> > This ensures IOThread 'holders' status correctly reflects active block
> > exports for better debugging and resource tracking.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++------
> >  include/block/export.h |  6 ++++
> >  2 files changed, 60 insertions(+), 9 deletions(-)
>
> If AI was used to generate this patch series, please see QEMU's AI
> policy:
> https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-gen=
erated-content
>
> This feels like AI generated code in that it is verbose and has lots of
> structure (e.g. commit messages that look like an AI summary of the code
> change), but the details are not correct (misleading comments, leaks,
> etc).
>
> I will pause my review at this patch and wait for your response.

I used the AI for parts of commit messages.
Please continue to review code parts and skip the commit message parts,
I will remove all AI-generated commit messages in next version.

Sorry, I just noticed the discussion:
[PATCH v2] docs/devel: relax policy on AI-generated contributions


>
> >
> > diff --git a/block/export/export.c b/block/export/export.c
> > index b733f269f3..b6c07f69b5 100644
> > --- a/block/export/export.c
> > +++ b/block/export/export.c
> > @@ -15,7 +15,6 @@
> >
> >  #include "block/block.h"
> >  #include "system/block-backend.h"
> > -#include "system/iothread.h"
> >  #include "block/export.h"
> >  #include "block/fuse.h"
> >  #include "block/nbd.h"
> > @@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, =
Error **errp)
> >      AioContext *ctx;
> >      AioContext **multithread_ctxs =3D NULL;
> >      size_t multithread_count =3D 0;
> > +    g_autofree IOThread **local_iothreads =3D NULL;
> > +    const char *holder_name =3D NULL;
> >      uint64_t perm;
> >      int ret;
> >
> > @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *expor=
t, Error **errp)
> >              goto fail;
> >          }
> >
> > -        new_ctx =3D iothread_get_aio_context(iothread);
> > +        holder_name =3D bdrv_get_node_name(bs);
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
>
> This is not a block node, this is a block export (a separate type of
> object). Reporting the export as a node is confusing because users will
> not know which block export id is assigned using this IOThread, they
> will only know the block node (which could be doing other things too).

OK, it looks need to change the type name from:
IO_THREAD_HOLDER_KIND_BLOCK_NODE
to:
IO_THREAD_HOLDER_KIND_BLOCK_EXPORT

>
> > +            .u.block_node.node_name =3D (char *)holder_name,
>
> To remove the suspicious-looking const cast, try:
>
>   const IOThreadHolder holder =3D {
>       .type =3D ...,
>       .u.block_node.node_name =3D holder_name,
>   };

OK.

>
> > +        };
> > +
> > +        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder=
);
> > +        multithread_count =3D 1;
> > +        local_iothreads =3D g_new0(IOThread *, 1);
> > +        local_iothreads[0] =3D iothread;
> >
> >          /* Ignore errors with fixed-iothread=3Dfalse */
> >          set_context_errp =3D fixed_iothread ? errp : NULL;
> > @@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions *expor=
t, Error **errp)
> >              return NULL;
> >          }
> >
> > +        local_iothreads =3D g_new0(IOThread *, multithread_count);
> >          multithread_ctxs =3D g_new(AioContext *, multithread_count);
> >          i =3D 0;
> > +        holder_name =3D bdrv_get_node_name(bs);
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> > +            .u.block_node.node_name =3D (char *)holder_name,
> > +        };
> > +
> >          for (strList *e =3D iothread_list; e; e =3D e->next) {
> >              IOThread *iothread =3D iothread_by_id(e->value);
> >
> > @@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
, Error **errp)
> >                  error_setg(errp, "iothread \"%s\" not found", e->value=
);
> >                  goto fail;
> >              }
> > -            multithread_ctxs[i++] =3D iothread_get_aio_context(iothrea=
d);
> > +            local_iothreads[i] =3D iothread;
> > +            multithread_ctxs[i++] =3D iothread_ref_and_get_aio_context=
(iothread,
> > +                                                                     &=
holder);
> >          }
> >          assert(i =3D=3D multithread_count);
> >      }
> > @@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions *expo=
rt, Error **errp)
> >      assert(drv->instance_size >=3D sizeof(BlockExport));
> >      exp =3D g_malloc0(drv->instance_size);
> >      *exp =3D (BlockExport) {
> > -        .drv        =3D drv,
> > -        .refcount   =3D 1,
> > -        .user_owned =3D true,
> > -        .id         =3D g_strdup(export->id),
> > -        .ctx        =3D ctx,
> > -        .blk        =3D blk,
> > +        .drv                  =3D drv,
> > +        .refcount             =3D 1,
> > +        .user_owned           =3D true,
> > +        .id                   =3D g_strdup(export->id),
> > +        .ctx                  =3D ctx,
> > +        .blk                  =3D blk,
> > +        .iothreads            =3D g_steal_pointer(&local_iothreads),
> > +        .iothread_count       =3D multithread_count,
> > +        .iothread_holder_name =3D g_strdup(holder_name),
> >      };
> >
> >      ret =3D drv->create(exp, export, multithread_ctxs, multithread_cou=
nt, errp);
> > @@ -253,6 +275,18 @@ fail:
> >          g_free(exp->id);
> >          g_free(exp);
> >      }
> > +    if (local_iothreads) {
>
> This doesn't handle the drv->create() goto fail code path where
> g_steal_pointer(&local_iothreads) has moved the pointer into exp.
> local_iothreads will be leaked.
>
> iothread_holder_name will also be leaked (it should be handled like
> g_free(exp->id) above).

OK, will fix in next version.

>
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> > +            .u.block_node.node_name =3D (char *)holder_name,
> > +        };
> > +
> > +        for (size_t j =3D 0; j < multithread_count; j++) {
> > +            if (local_iothreads[j]) {
> > +                iothread_put_aio_context(local_iothreads[j], &holder);
> > +            }
> > +        }
> > +    }
> >      g_free(multithread_ctxs);
> >      return NULL;
> >  }
> > @@ -269,6 +303,17 @@ static void blk_exp_delete_bh(void *opaque)
> >      BlockExport *exp =3D opaque;
> >
> >      assert(exp->refcount =3D=3D 0);
> > +    if (exp->iothreads) {
> > +        IOThreadHolder holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> > +            .u.block_node.node_name =3D (char *)exp->iothread_holder_n=
ame,
> > +        };
> > +
> > +        for (size_t i =3D 0; i < exp->iothread_count; i++) {
> > +            iothread_put_aio_context(exp->iothreads[i], &holder);
> > +        }
> > +        g_free(exp->iothreads);
> > +    }
>
> iothread_holder_name is leaked.

Will fix in next version.

Thanks
Chen

>
> >      QLIST_REMOVE(exp, next);
> >      exp->drv->delete(exp);
>
> iothread_put_aio_context() must be moved after ->delete() since exports
> may still need to do some AioContext cleanup (e.g.
> vduse_blk_detach_ctx()).
>
> >      blk_set_dev_ops(exp->blk, NULL, NULL);
> > diff --git a/include/block/export.h b/include/block/export.h
> > index ca45da928c..2bb98aae31 100644
> > --- a/include/block/export.h
> > +++ b/include/block/export.h
> > @@ -16,6 +16,7 @@
> >
> >  #include "qapi/qapi-types-block-export.h"
> >  #include "qemu/queue.h"
> > +#include "system/iothread.h"
> >
> >  typedef struct BlockExport BlockExport;
> >
> > @@ -89,6 +90,11 @@ struct BlockExport {
> >
> >      /* List entry for block_exports */
> >      QLIST_ENTRY(BlockExport) next;
> > +
> > +    /* The iothreads list for block_exports */
>
> This comment is confusing: block_export is the global list of
> BlockExports. This iothreads[] array is not for block_exports, it's for
> this specific BlockExport only.
>
> > +    IOThread **iothreads;
> > +    size_t iothread_count;
> > +    char *iothread_holder_name;
> >  };
> >
> >  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> > --
> > 2.49.0
> >

