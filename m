Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A2FC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwk6p-00037X-4B; Wed, 19 Aug 2026 13:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwk6o-00037P-4g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:29:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwk6m-0008Ob-4c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:29:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso17440166b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 10:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787160586; cv=none;
 d=google.com; s=arc-20260327;
 b=Lq8VubNnoVchHSSEHXsxx0kmQG5UxQYZracTYTdIScN2VfC9EzU+PB5sDh2lhcSK8Y
 uy9gHEmfuz2vU/vcM7T6rrDfgU25d1YTCBkXqJ4OzsoE65onF9VE/+G0Vfba3ncw/8Y+
 aRt5O04K0Kn/GHtKxQ3FzJYu4e1AVkTfVDPmd5FbvKxPT3foZf7gzP0UjFmcxyjxynAy
 c9xADY+jD3IBPtFlRSavqiHKgp8EbCpEHkq8UFHr5Zej9xPrYnExuv3yCfOUzr9mPUjd
 NgLfAmeJDPnbxGavPSNabjF9V/s08BXkx9qxNOW8x5GZQQUSU1WZyk7nJdUVXEao3yXu
 mswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQYWwBRYlv1mQNc/UJxEEsINb7/o3fw4nFM8bBK1n+w=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=jrN1N9mGMWVMaOYfA10tnUpmul7wMNtiDX+iCrzQiT5ZM5SZojuIWrcMxvfo3vT+BA
 RoLrqfYQWwdA54xQ7QP/8Q0OiLMu0zLlV8zUp5V2vWbBNGZjANWuKhMREZxNenrfedO3
 8TAMKIbmNqQmsCz2kfidlUJ5gAc9BpT7axv9Mx4X+UeLmcyjBIlyh7seqX3ufSIA02jT
 ykPkv9fAj616fjpOQer6GHspRRzBBDlWt+eF+POH9T4ioUF9idb+VPdGgJw7Tc03Jfnu
 TyVdc4QaMk/6RAOTS/ZfVWhvVbpGrwd39GGsMcP02MQvSxiw4WxTR4PaqzN0kZShj3RY
 bLXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787160586; x=1787765386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jQYWwBRYlv1mQNc/UJxEEsINb7/o3fw4nFM8bBK1n+w=;
 b=iuHNcV11P+FfzwGKRxFUcYMpAIJyTH/LYvmzVXrabFK0FxzdRXF6PglRCSfJRPi7x6
 M92vx05jffhwM3CHb5UBvOrzuPh057bv8i/n/SuB7hhR5iiat4gbYs64nTx3GV9eJlpx
 9bZtyr+4PhssLsmk28oiCYpijN3V7doSMu2bxpfmwolgRxJFZdajV4JeE9h5xBRlttbG
 DmgMb1IBvNeUi3IUIDoUx2cpBilMN4CmjLyfizDI2yJrERZxGCxFWXOR+RC4FPiJUlYR
 29+fX2HubqmiSOE7xiIpy/9zjXb1AaNqGoms7Ov6IGKkvDHNRh3Se/qsOKLKCUiBbDsd
 Qehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787160586; x=1787765386;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQYWwBRYlv1mQNc/UJxEEsINb7/o3fw4nFM8bBK1n+w=;
 b=Gm3Lc1ennUYg59uh6ly/gaSV520DoS6rkKnTlrRgGjuZe7NBOERJ5jA+ixiRlu3puf
 dJv57f8qLAE3tz9rBZn0M1fXoOcstNkuK4QveliN7yBAstrJXHXhuqZpmWfURn7twD6P
 EZh8x0oFwQfpS9g68CWHlcBc794wL1box1l+jaILqlcE9El6H0tvDiF5gr+rYc2VU8pM
 btzbB8eVlTl+NND25i8PGnSMYornZb05wL/V0pgXIWzSV32Uq12yWYpGP7oYME0NwNub
 WY59BTpr0tFMKMTz7CuwtzDZ7ZM8SDK1jWw+TMpM1Bd8I4ZkAJrUUSWZ70YyBVZ9JCLj
 Hfrg==
X-Gm-Message-State: AOJu0YzREGctr8xyIgUfEb0hTJ7DYSgD9XZ9MkTfJct/RrRCzKBbkqnp
 39/tRyJkd3478R70DaX6iS3nFplr1bLm7zh56IVHjFQOm/W8d5unD/8gVd8f7pE5T3EsS0Vba0X
 mxK9CyE8fh33YYt06iwsmwbPv2iADPIlaTQLbxOZaOw==
X-Gm-Gg: AR+sD108So9/i6Loq1V883bHa4l/k5zJeYBQi26qE0oh+ORxcKke6q//9z1IXN7gGIA
 N2mV+MGwzsw1Ip2PvKTpzRcBmkdQrzura3DY/dCvf1Q3dcA2/sjuKqBK7+D4ntPkZwlzBc3p7YW
 P5T9J+qdIOtxsbMN1O1/S3HpBzHHcHraVcOu/H6doVqaUheOxWRq2Vu8FpIv+V1DJuvb/X2SLUp
 /ZzK2desr9gk02nn2KJ/wcXrMg4lye8e3Blvm8TOtP/TDKJAwtAwXsqEkgbhNFZydY5f9vrRXDk
 m427FabMgYQn4pNlCfiS1SYcDpdt24cQlQMyPbWenZHcbl4B+pskJ6/Vqjh85Y4kgD3DOlpKs/c
 eXg==
X-Received: by 2002:a17:907:3e9a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c242e23c7a1mr233283866b.3.1787160585906; Wed, 19 Aug 2026
 10:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-9-peterx@redhat.com>
 <CAMGffEkzdOna79f561r6bMF3wgZw4h5LwHXhC3KBx_FqLNz+wQ@mail.gmail.com>
 <aoXJ1k8N_bzfXs5u@x1.local>
In-Reply-To: <aoXJ1k8N_bzfXs5u@x1.local>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 19:29:34 +0200
X-Gm-Features: AcwNN1UXolVCvYVr6JKHvVeTi6majltnLvdttCoTAL5TmPHCdwrElC1z3C3QR8A
Message-ID: <CAMGffE=nd=R98vKQEnxWJUGpvXZYz0gx4bXe1sM84piQUYzuRw@mail.gmail.com>
Subject: Re: [PATCH 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::629;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x629.google.com
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

On Wed, Aug 19, 2026 at 5:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 19, 2026 at 03:00:51PM +0200, Jinpu Wang wrote:
> > On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > The value received on wire for head.chunks when registering new RDMA
> > > regions is not correctly checked.  Logically the value can still make
> > > ram_chunk_start() (of ram_chunk_end()) to overflow, having a result p=
ointer
> > > very small, smaller than RDMALocalBlock.local_host_addr.
> > >
> > > Add the sanity check.
> > >
> > > Reported-by: Tristan (@TristanInSec)
> > > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/rdma.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > index 5ce8b06818..bbbc40ea3b 100644
> > > --- a/migration/rdma.c
> > > +++ b/migration/rdma.c
> > > @@ -3401,6 +3401,13 @@ int rdma_registration_handle(QEMUFile *f)
> > >                  chunk =3D ram_chunk_index(block->local_host_addr,
> > >                                          (uint8_t *) host_addr);
> > >                  chunk_start =3D ram_chunk_start(block, chunk);
> > > +                if (chunk + reg->chunks > block->nb_chunks) {
> > > +                    error_report("%s: head.chunks contains illegal v=
alue"
> > > +                                 " (chunk=3D%"PRIu64", chunks=3D%"PR=
Iu64", "
> > > +                                 "nb_chunks=3D%d)", __func__, chunk,
> > > +                                 reg->chunks, block->nb_chunks);
> > > +                    goto err;
> > > +                }
> > safer to do this instead, as reg->chunks is from wire:
> > uint64_t chunk_sum;
> > if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
> >     chunk_sum > block->nb_chunks) {
> >     error_report(...);
> >     goto err;
> > }
>
> I thought I covered that, I even mentioned the overflow in the commit log=
,
> but I didn't really do anything..
>
> When looking at this again, I found reg->chunks is defined in a weird way=
,
> instead of "number of chunks", it's off-by-one...
>
> qemu_rdma_write_one():
>     chunks =3D length / chunk_size;
>     if (chunks && ((length % chunk_size) =3D=3D 0)) {
>         chunks--;
>     }
>
> So I think I should check it with "chunk_sum >=3D block->nb_chunks" to be
> accurate.  Diff attached to be squashed when repost, please help double
> check:
Yes, looks indeed.
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6384306ead..e976739fad 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3393,7 +3393,7 @@ int rdma_registration_handle(QEMUFile *f)
>              }
>
>              for (int count =3D 0; count < head.repeat; count++) {
> -                uint64_t chunk;
> +                uint64_t chunk, chunk_sum;
>                  uint8_t *chunk_start, *chunk_end;
>
>                  reg =3D &registers[count];
> @@ -3424,7 +3424,8 @@ int rdma_registration_handle(QEMUFile *f)
>                  chunk =3D ram_chunk_index(block->local_host_addr,
>                                          (uint8_t *) host_addr);
>                  chunk_start =3D ram_chunk_start(block, chunk);
> -                if (chunk + reg->chunks > block->nb_chunks) {
> +                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
> +                    chunk_sum >=3D block->nb_chunks) {
>                      error_report("%s: head.chunks contains illegal value=
"
>                                   " (chunk=3D%"PRIu64", chunks=3D%"PRIu64=
", "
>                                   "nb_chunks=3D%d)", __func__, chunk,
>
lgtm.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Thanks for the careful review,
Thank you for taking care.
>
> --
> Peter Xu
>

