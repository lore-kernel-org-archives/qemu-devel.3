Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19612C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvcQ-0003cu-8H; Thu, 20 Aug 2026 01:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwvcN-0003ch-8R
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:47:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwvcL-00058u-Hs
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:47:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so304564a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 22:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787204827; cv=none;
 d=google.com; s=arc-20260327;
 b=eEilD56HVMykFfmhEzk6iDjnp0+CgD3IkQghoYqDPBAXAKLCbzEojjKUA+FSF3MVSH
 wnQEjV6vt8Kpo+YGOwvU7QO2HXOg0yUBBDWbbJ2hkIdBXnBB/2BuxHmm+pkkp1DrGB6T
 fzqmpPxyiB8K0mEWWe06YxFJW9wNfO3WCN/IqDSaH/oJ2EZDEjP26l/qUoVxN8Bu3OZH
 VJtj4GAv/mYGOM3JWi2ijFrxmFsXYXNcowllEvtpfR3aVVmmpvMzKAknuVd+wdP0p5Jh
 wHAC/ysmG0sQJ+PKEVayCB3swv807KCB3Gh4JIODknV/uilrV/cB+CtZCTroeysrSuGn
 +6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UNa2wv58vg48628LwERxNUNYy4Ouarul0nS3MGWZbNA=;
 fh=0OrEgs2AR2ZyZFpA0iVTzhEwZS9fM9hbxZNweVjg8tA=;
 b=kbC+Wj28dxITOsu0AtGYTx9teHAf98R6Q3tv4i2jpUh+Vo9K/xWQMdl4mxIZ2Q7MRJ
 hgm0OGlnN9PiuYHtJY6L6Udr7bE3a9VBZGdQGFxAe3Z7unjbDo1UdqZMcDRD/4w30DZa
 ddB7RGjmnNeMm74txSv7K12o1nkqNUcSUfl8CNhCyN9RGGDAA0Wbh+TlZ3NDhD3YiCtO
 lvSmGih85C27nZewEVaLoMRFRWrOm1CbDI6X9hWIs8APhrCwRFzKPEK5Jb+Sj332yN8n
 p+NT2g/cfTxnPR167jqQnXD+s7xmwzHyooeQ//S2Jzr1r2pRfd52f/l1btiJzLzCFFW5
 3KrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787204827; x=1787809627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UNa2wv58vg48628LwERxNUNYy4Ouarul0nS3MGWZbNA=;
 b=d9xdxv210g73nvaRd+7GTJ04hQx7MoEFqyrAN92lXK+0ZSxFohem57SAeZU7s2EqVH
 by1/SFmU4ZEo0YhhXFzn+DQ3OYtiOlE3X423A/HvlgY9ioaMXGIdzBlw2TBXyRxuBAOJ
 o95atMe3LzndN5VeW6XGKgbhFRRQ90CoAHt1upaH+kuJOIaM+5USMig9NJC+mhE4ilOY
 PNuiwdfTGJwE2iyjmulcYQQs3v3rhTgxXlpPwu86ndXsz4d09jTc4RH7iiGt9dNPWx69
 LB+QbP+Xj/hirIuir63rTNCeNSDFri8msAZUk0V2A6mI0ALSYDBADD7qVUkU9zdHT+sT
 +2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787204827; x=1787809627;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNa2wv58vg48628LwERxNUNYy4Ouarul0nS3MGWZbNA=;
 b=q1hfm3fz9k9gDUFElqqgoZO20IboD5SFJANDvfsQDoqD2lHgK3LJFPEaYYPk7fQyr6
 whaA7jnfrYspe6k5wu1emCW2c2NQcuuBkIvjJoyMxFKxrmXwMompNnn/UODr0q5RYan8
 rDpCOFI0YVNlptraQh+vuCE6pw64UI5bxvPzcovNYiIhgsRDm4zMIQy3ztDcoW7DU8ZY
 A7uAay9CJrvuvEbzmgUdf6SKhBuep4jM1qd2J+H7VZ4D4Mal2URX0ETVykPSYts5hmqR
 zlFNebJRTyn+od1CELDeYK4jXCmRnTYRG924YqVFRMhHy3qqvwBB60vj9wT5rgA/sZ0d
 dqhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiB9NLVpVUf9p53+YfX/IxNaBW6DL/Ufc2m6+AJlOXcJfxcWatBn6bLGB7x2gWiocJj8CkW1nZAFM/@nongnu.org
X-Gm-Message-State: AOJu0Yw72wQa20nkatyzZW4UkrE/9t+fqpwbn74lI2w22csRrMj/pf4Z
 mJNEPuQpadX3oYZMQ0JIyL3KC9ujhbUojwsnij2Hh2cFT6WVsapIrhVTc47cHiK4Uc5AMGwU+eh
 gAr6H13xwwWXHt6hnw5Tg4LFLRF6DbzZkVtrgr9P6yA==
X-Gm-Gg: AR+sD13gAKSDO0iTAhGPNrD62uAcZSSNnwjB2Yd5L2MK8WhX5Aexf98+o0k14EFSzNC
 Oz6zEKKV54F1r3kJQoBpyKnklbYofgHrUZBF+1S3oOLK/22BOQ1j2UUJKty7WpnVoCrsdOKIjsw
 AFwQIoWVt3k1juqac0iVOuPyf1GpRz193F98YPSGNpnUPShyPuAJWGoHXGFnWnP9MNjuz1BsAm9
 5l1M1X1RWh8/ul1Dze0sEyvDlWSPKuxoO0lLdNa8EeWto5/XBrqt3D7jnZZfdaQHL6oTEHXiHFZ
 /iIGjCW1UBfg5uHOJqgheBrylDQ68W+4NyJKM4kd2cwjaYX3Pg6HgeM3gM9U/S8psuz9fhaMblx
 Dpw==
X-Received: by 2002:a17:907:d19:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c242e3877c8mr324754566b.4.1787204826883; Wed, 19 Aug 2026
 22:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-3-yanfei.xu@bytedance.com> <aoYBIaisgpP6lklk@x1.local>
In-Reply-To: <aoYBIaisgpP6lklk@x1.local>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Thu, 20 Aug 2026 07:46:54 +0200
X-Gm-Features: AcwNN1W9k7V6PCDJflo7zv43ogh9U76gpkktVH1Wt_A155tHRuDBQ6SG7pIFAaY
Message-ID: <CAMGffEmTC03Ao5Ttt6rC1Hh-mLqFR0RA62KwyUaFNxjs6Dt08A@mail.gmail.com>
Subject: Re: [PATCH 2/3] migration/rdma: Post initial receive before accepting
To: Peter Xu <peterx@redhat.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org, farosas@suse.de,
 lizhijian@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::536;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 19, 2026 at 9:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Aug 17, 2026 at 06:51:16PM +0800, Yanfei Xu wrote:
> > The source return-path thread can send READY before the destination has
> > posted its initial receive.  Since RNR retries default to zero, the sen=
d
> > can fail and abort migration.
> >
> > Post the initial receive before rdma_accept() to close this window.
> >
> > Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma=
 return path")
> > Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
>
> This one looks correct to me,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> Do you have way to reproduce it, or is this theory (or can be reproduced =
by
> adding delays)?
>
> > ---
> >  migration/rdma.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index e17ace62b0..6e8436ccc1 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3263,6 +3263,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> >          }
> >      }
> >
> > +    ret =3D qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
> > +    if (ret < 0) {
> > +        error_report_err(err);
> > +        goto err_rdma_dest_wait;
> > +    }
> > +
> >      /* Accept the second connection request for return path */
> >      if ((migrate_postcopy() || migrate_return_path())
> >          && !rdma->is_return_path) {
> > @@ -3295,12 +3301,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> >      rdma_ack_cm_event(cm_event);
> >      rdma->connected =3D true;
> >
> > -    ret =3D qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
> > -    if (ret < 0) {
> > -        error_report_err(err);
> > -        goto err_rdma_dest_wait;
> > -    }
> > -
> >      qemu_rdma_dump_gid("dest_connect", rdma->cm_id);
> >
> >      return 0;
> > --
> > 2.20.1
> >
>
> --
> Peter Xu
>

