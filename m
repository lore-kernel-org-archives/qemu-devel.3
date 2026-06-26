Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D9DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd55n-0001wf-FE; Fri, 26 Jun 2026 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd55l-0001wN-DF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:51:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd55j-0007rb-L9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:51:29 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37d826e9811so413267a91.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 04:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782474686; cv=none;
 d=google.com; s=arc-20260327;
 b=GbL0gPtnNGCbCZzzriMDhhy+WiFXpK8W6KMa8jHG6YKeBts5fsP8FoQKrM/3lzbaXe
 UuIDB3sZlRfkfGbLryQeuVvU9NKDa7nUpPJRI+dLFfSyCMBO78tpVqWVLtJAQXUmA4GP
 BUURytDSVroZqoj/nGK8gd3pKAANmD3NFy0De2uZultgV0w918SVRcg3lbclnqc6G9c+
 lAigh21d302udxzIce9DUGrB9mSHtSz9QZR5ZgfWiYR/lxojpUVnHvTum4LVXAkDf+Hi
 cntfm0Q14Wy0imNZQwrQb8hayWEt9zaXGJ5LbufrYI0Ij8vtT2ubbxLqsW6dXKPrVNRX
 ADeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VWw2peGomJNgX4zQa6FywBg/BFgwhqzmuVSnxtTpNOQ=;
 fh=uTkvGJng4tHFjwqkiJVLBmPe0shYaUVChu5ajQcJYpQ=;
 b=DkAvdEf+O0opUJymodM4dpjURjAyadheAopR8ROn5j5/2+5BTsvKtjdfMh6TgOKMmU
 bPZyrF+eKy91YeTImoVJ0zXYDXTOb7wWtirca25lI7R+dwiwTAJFOMnbfxZn3ISvVFK3
 SdhZu+XbdOOwxBPL2zisgc1pMKoQsvw5bC59wdnaDbZnxp1C8TEIncqzmD7mnJDfn5b0
 cKrG8vR6OCc1bM3lvOrj+cZrWcI4tz2YrjT2EnW78ZutkktGCJDM7zT7Hep4UtrgDyk6
 0MDkLAWFmtCj/GULuRzElehljoJBPBJMRDyYnWGvkkjm1bm16/eTinIIfgOWDiIQWag2
 ZDuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782474686; x=1783079486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWw2peGomJNgX4zQa6FywBg/BFgwhqzmuVSnxtTpNOQ=;
 b=Q4PeYPx5QdmaYQ5ftBIvn0YUTCFoCxCtjLoFihC6ve1CvVPuo6ig7VkrGBvJ9IA0qB
 dboVPFDqRgZxrHUI8kyfkKoVYMwkz0BrIqgj4o75YG2z4S7qjSIq69o9Mwvtz1aLxWMV
 CUsY/jHF3k6WDpIStW9mjwfc/1vvJ7PvQ49UQ8qn7ZPS2SRJJ2TXNvbr1AhbXlwQu2CT
 Bsb/QzgPPVtUyCcRFP9sjxT+n/ghw2+ZUtryNOxDHa9LOk1cM1QRo49o+UKLBgXECsBO
 3MpdMbU0TR33UBrkswnRX9ASw5Us01Xk34M8SWrIVz8hWQ88QVFVwmRyyGLLpFLdTkOD
 Q2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782474686; x=1783079486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VWw2peGomJNgX4zQa6FywBg/BFgwhqzmuVSnxtTpNOQ=;
 b=gE27RFFnnskFMtc59WeVYlVVbGJztQGyqCdMuHKlJNoPn6CdimJ2RCUsTzNnBNzYDV
 KrZigcHKsjMWAqNuHf4VNuW6aS275N3SVI6LO0vkXOsVzcE4lWfxos0J+ImAZs0e2QW1
 F3f/hapeqvvmVxO7jV4difGfFjb8J10bYF1GFq1eCfRxjEZG68+KZSjbmTRZOzaBMOTl
 L4V+69v2TAj3sIMQCSig+xBIgt7wK/GrAK3zEyILgclE70bEs1cTlPEiWm5HURqVlZgF
 43fnHRlhMwlrzGabh3G3zPkupzh9i7w6qMnGXx5209gYzkYElnl/YkZaMN/5YZk3pcQ4
 k2Zw==
X-Gm-Message-State: AOJu0YwoEITuIAwjeBXQcOkgej+G8vtupHBClScF2I0WUlt8/QFNYz0d
 oz9UqlmN+XeCyaNwqMBJjFyl7Z7qilvKXTRo+RTuZHbxf29B+5PyLz1sxwJ0qQOL/fYiALYtk/d
 e0Dn1qtUEEp0ujLXaWD308oxpP1jznDc=
X-Gm-Gg: AfdE7clzJLb1Uatwc3LUsytoWm7Pj+U8qn6sz7gGpAtTCCl8aqm+mjVFBLCPPX7xMPR
 8ASoNe5Beq3DBcvXfNEDHLJwiA6zNQNCoF6/sFY7jIpVXwLJO5Q4+sBz5sS/nyQylNYetkDZmKA
 2FF/SQ7qlHePKcrKNAi+jkN9G9gKIGZiJbuSyZmvbw35lf/f5N0LYIFx18kdY0ZWh0ZJZM6ry2y
 nhnXMsyAXvK91a4p2iaEKf7VmAZmkqBLdZBelFezlljA0+uFA4uNLUtOqzAt09gogKBU/nn71l3
 clWBllQIOz2wBuLNGnJsB0uKxyvicL9F5NzfP7W26qJgpatSfKcYvkoOT4vt4g0=
X-Received: by 2002:a17:90a:d888:b0:36d:ae6a:22fe with SMTP id
 98e67ed59e1d1-37dfa1d5614mr6154247a91.16.1782474686073; Fri, 26 Jun 2026
 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-4-faithilikerun@gmail.com> <aj5mCUdALSdJUdCL@ryzen>
In-Reply-To: <aj5mCUdALSdJUdCL@ryzen>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 26 Jun 2026 13:50:59 +0200
X-Gm-Features: AVVi8CellUnyqSubxJc93IJnmiVoJ9XKMeNxlrFSzTshZ5wn7cuo9-i5c7GHxRE
Message-ID: <CAAAx-8L8Vp4=JrBLGtLe=_038OsFFqA462MUxnz_u2vDVtPxyg@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] virtio-blk: do not merge writes across a zone
 boundary
To: Niklas Cassel <cassel@kernel.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 dlemoal@kernel.org, qemu-block@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102a.google.com
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

On Fri, Jun 26, 2026 at 1:44=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello Sam,
>
> On Tue, Jun 23, 2026 at 08:48:28PM +0200, Sam Li wrote:
> > virtio_blk_submit_multireq() fuses adjacent in-zone writes into a
> > single request. On a zoned backend, a merged zone append request
> > that straddles a zone boundary is rejected by the device because
> > each write must stay within a single zone.
> >
> > Add a bail condition to the merge coalescer: if combining the
> > candidate request into the current batch would cross a zone
> > boundary, flush the current batch and start a new one.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/block-backend.c             | 11 +++++++++++
> >  hw/block/virtio-blk.c             | 22 +++++++++++++++++++++-
> >  include/system/block-backend-io.h |  1 +
> >  3 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index 37ba7e9fc4..049e70ddcb 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -2326,6 +2326,17 @@ uint32_t blk_get_request_alignment(BlockBackend =
*blk)
> >      return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
> >  }
> >
> > +/*
> > + * Returns the zone size in bytes for a zoned backend, or 0 if @blk do=
es
> > + * not present zoned geometry.
> > + */
> > +uint64_t blk_get_zone_size(BlockBackend *blk)
> > +{
> > +    BlockDriverState *bs =3D blk_bs(blk);
> > +    IO_CODE();
> > +    return bs ? bs->bl.zone_size : 0;
> > +}
>
> Personally, I would add this new API in a separate patch, but either way
> is fine with me.
>
>
> > +
> >  /* Returns the optimal write zeroes alignment, in bytes; guaranteed no=
nzero */
> >  uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
> >  {
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 6b92066aff..39750fa1c0 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -294,6 +294,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock =
*s, MultiReqBuffer *mrb)
> >      int i =3D 0, start =3D 0, num_reqs =3D 0, niov =3D 0, nb_sectors =
=3D 0;
> >      uint32_t max_transfer;
> >      int64_t sector_num =3D 0;
> > +    uint64_t zone_size =3D blk_get_zone_size(s->blk);
> > +    bool zone_cross;
> > +    int64_t zone_sector, end_sector;
> >
> >      if (mrb->num_reqs =3D=3D 1) {
> >          submit_requests(s, mrb, 0, 1, -1);
> > @@ -309,17 +312,34 @@ static void virtio_blk_submit_multireq(VirtIOBloc=
k *s, MultiReqBuffer *mrb)
> >      for (i =3D 0; i < mrb->num_reqs; i++) {
> >          VirtIOBlockReq *req =3D mrb->reqs[i];
> >          if (num_reqs > 0) {
> > +            zone_cross =3D false;
> > +
> > +            /*
> > +             * On zoned backends, a single backend write must not span=
 a zone
> > +             * boundary. Bail out of merging if combining req into the=
 current
> > +             * batch would straddle a zone.
> > +             */
>
> Like Stefan said in v11, as per the virtio spec, this applies to both
> reads and writes. The code is doing the right thing, but the comment
> should probably be updated to reflect that.

Ok, thanks! I'll add the reads to the comment.

>
>
> Kind regards,
> Niklas

