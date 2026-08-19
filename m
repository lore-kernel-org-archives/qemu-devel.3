Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF2C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfim-0006fI-J1; Wed, 19 Aug 2026 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfiX-0006XM-JZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:48:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfiU-0006u6-Qh
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:48:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso11746666b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143704; cv=none;
 d=google.com; s=arc-20260327;
 b=hCb9ipuxAIpKlBlI9XSuA4VVz04rfbVlJ0JRq9jTo7qlIfstm60JpUSwlxZ8/4I5R+
 D524i0d4vopvLIMB2KjWJVlJBhWF9Pkt7S8UQV1J6A/NfG/EYrdaz9Vx2ho82VyV7Ij3
 fJFTjDLnqQAUeEDzHxyeE4KpP1a1XGTyoW5XL3kSxkOtpHhlqzWfvWWoMknTTiwIN0Lb
 4ZMKzP7i1VN/faarakz7AXDOk5gzkzvEoe9nxh8jPOkYQ/WIvp14wfrxxyXVMzwABpBh
 Qny4zz9MaIgaPG0b3UUhrXbZpFjMwP5JvAaXv8oVZHWNKmrk1aiZ7f0RaaXHsDQyFvwT
 jXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1fEquTl80bteh0ZQ1FXpM1aOxlvF0foisn6zSN6B4pY=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=Knz+lH098+6XZmduRY6w4wJYaRH5xk0Pyj0L5C5pjWS73QC/+J7Az53CZX9SKQkjG6
 os3fZ+PmO/nibXXXoGB9jDz8dcgRQ+77XpYvz36IR7MlvqlBrhqSo1U9SG9SZauaRead
 meu6SL9JePfLiaJ38qylv5W/rxAgQbuwtsoGRBzXwWkqsrbzCCEttF3nWv1n3MkTrmFa
 N47px63oOgsuKnAfN4i8/kTpyoNKdsN70rflCxMxUnPQza4EvRWbvLZpovc9f5nEV1rH
 AMrJmYV6jYTCKu3nfB8YQ9FtvZf7s5WGlyFEwFS+1+LbJ9g9nz1yN03UsQhRtm6LcdNV
 hpAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787143704; x=1787748504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1fEquTl80bteh0ZQ1FXpM1aOxlvF0foisn6zSN6B4pY=;
 b=KcASC3Woleey2dhoiK/18j2HM621NRFjVMYMM4L2/o2V5kIg+CLUcUF3q7Bx5c7IvN
 ugbLam2u3mmTu2EnM19Zl72aWzbpBZmHZ8nYlhj+nJwURg+NXz3cip7AAWYsV93SEgOx
 EmEr7a11iKpEjKdmwx+AlfpzDMdJYb2KEfN273PAEUt8fxjj/AUYS/T56M8DQ3AAued0
 Er1Pud1vrSvtSEiNQuFvNJKQAAVvLbIcFrqSX1onGtyNmReA3OZY40iHH980Ao5oEOFG
 a30NpVxcpzv9FFKubnua+LKdFO8ofJhahSZRa4ePFAxFs9jItYoYyy9lwIoa/WkSIWX6
 j7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143704; x=1787748504;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1fEquTl80bteh0ZQ1FXpM1aOxlvF0foisn6zSN6B4pY=;
 b=gSNXX2MaRAM3uNs285SAOSaMHISMwbBlSvO94OX9lYTFe3ZXCnvdpaxVRS/3PqTKS8
 Rqq4MP58ku8g58z9u2ngntT13gV51OdWBymSRJ25BLzFDPNYlrmLZHxcClOAMlocFCol
 crQSTUoqTboRxF/oWANeFZti/gSp3CsBtWWsbSSJ4PRyiWc29sc9eWnbyeaAJX4xBict
 AbswcqxCUNZgfpamXD6wsheIwljaF+K0JLz56QKRnJM+NAbd9v1RCiUMcBhPRzenGAwo
 RzMa0IIK9IXbq54OCXs0EZ+zmwjBZOMrXMyBWGXC7iqp+7iB1ZpPocUDRCtI3dfMaCQP
 q/1w==
X-Gm-Message-State: AOJu0YyDOg3KnpHDekuPDISsQBaOyQaeKlIjA33YWZ0LlV6Jerq2ecUB
 +nCLyKF/00Md/c+SuYO4tgHpD3KaCCcPIlgOGwgCMTj+uOmQ/8MIwQOiihdWIGU98NLS1Lk6bFL
 DF8/q1313NCbSGnUPozKSuP0YNofNErimL3A3Ri/xUg==
X-Gm-Gg: AR+sD12WW+JpBaRBrP4xkE5X/fO39zls48ztWXzrOV7HNpFnHLcX+sHhE1TVFX8DxQN
 mw8xnc11nUHl1fDQtv5MV76X5I20qRJSaVg+iPBEjz2Cm4GPSRqC1wWfYORDwUS5Wy66OmEKdYC
 ONvc395T2KEGj9saYXtWynGPZvHdx+SvAAaKDg8LwgrbkwH+yLm0f5Z15K5k7oxtW1PjJ3HYaCL
 mSMF0LDGPq7c8eyd+JRQOdesp030PlAAEMnstvXtNtNOp7f6XSmQBOTwFIDJ2fgNDN6NM3cPxWY
 zSuM/2Nfu2sNRhYYduRu1Uzmgt9nSlFmp39HbdrxPB8q
X-Received: by 2002:a17:907:3e9a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c242e23c7a1mr152596166b.3.1787143703690; Wed, 19 Aug 2026
 05:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-7-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-7-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 14:48:12 +0200
X-Gm-Features: AcwNN1VV3_X0u-f8HO61TJ2Q79cRvJ1gQ-KJmVbS_XabQxXi_I923qJ4kyXySgs
Message-ID: <CAMGffE=tiog=Qo2f+_bvN5iqY2BJ=ZEZGZ8Q9da6LmhSCtf+yA@mail.gmail.com>
Subject: Re: [PATCH 06/10] migration/rdma: Drop RDMARegister.key.chunk
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62d;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62d.google.com
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> Not used anymore.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index c06395a51a..f64bcee418 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -415,10 +415,7 @@ static void network_to_control(RDMAControlHeader *co=
ntrol)
>   * the actual RDMA operation.
>   */
>  typedef struct QEMU_PACKED {
> -    union QEMU_PACKED {
> -        uint64_t current_addr;  /* offset into the ram_addr_t space */
> -        uint64_t chunk;         /* chunk to lookup if unregistering */
> -    } key;
> +    uint64_t current_addr;  /* offset into the ram_addr_t space */
>      uint32_t current_index; /* which ramblock the chunk belongs to */
>      uint32_t padding;
>      uint64_t chunks;            /* how many sequential chunks to registe=
r */
> @@ -443,16 +440,16 @@ static void register_to_network(RDMAContext *rdma, =
RDMARegister *reg)
>       * current_addr as passed in is an address in the local ram_addr_t
>       * space, we need to translate this for the destination
>       */
> -    reg->key.current_addr -=3D local_block->offset;
> -    reg->key.current_addr +=3D rdma->dest_blocks[reg->current_index].off=
set;
> -    reg->key.current_addr =3D htonll(reg->key.current_addr);
> +    reg->current_addr -=3D local_block->offset;
> +    reg->current_addr +=3D rdma->dest_blocks[reg->current_index].offset;
> +    reg->current_addr =3D htonll(reg->current_addr);
>      reg->current_index =3D htonl(reg->current_index);
>      reg->chunks =3D htonll(reg->chunks);
>  }
>
>  static void network_to_register(RDMARegister *reg)
>  {
> -    reg->key.current_addr =3D ntohll(reg->key.current_addr);
> +    reg->current_addr =3D ntohll(reg->current_addr);
>      reg->current_index =3D ntohl(reg->current_index);
>      reg->chunks =3D ntohll(reg->chunks);
>  }
> @@ -1833,7 +1830,7 @@ retry:
>               * Otherwise, tell other side to register.
>               */
>              reg.current_index =3D current_index;
> -            reg.key.current_addr =3D current_addr;
> +            reg.current_addr =3D current_addr;
>              reg.chunks =3D chunks;
>
>              trace_rdma_write_one_sendreg(chunk, sge.length, current_inde=
x,
> @@ -3375,7 +3372,7 @@ int rdma_registration_handle(QEMUFile *f)
>                  reg_result =3D &results[count];
>
>                  trace_rdma_registration_handle_register_loop(count,
> -                         reg->current_index, reg->key.current_addr, reg-=
>chunks);
> +                         reg->current_index, reg->current_addr, reg->chu=
nks);
>
>                  if (reg->current_index >=3D rdma->local_ram_blocks.nb_bl=
ocks) {
>                      error_report("rdma: 'register' bad block index %u (v=
s %d)",
> @@ -3384,15 +3381,15 @@ int rdma_registration_handle(QEMUFile *f)
>                      goto err;
>                  }
>                  block =3D &(rdma->local_ram_blocks.block[reg->current_in=
dex]);
> -                if (block->offset > reg->key.current_addr) {
> +                if (block->offset > reg->current_addr) {
>                      error_report("rdma: bad register address for block %=
s"
>                          " offset: %" PRIx64 " current_addr: %" PRIx64,
>                          block->block_name, block->offset,
> -                        reg->key.current_addr);
> +                        reg->current_addr);
>                      goto err;
>                  }
>                  host_addr =3D (block->local_host_addr +
> -                            (reg->key.current_addr - block->offset));
> +                            (reg->current_addr - block->offset));
>                  chunk =3D ram_chunk_index(block->local_host_addr,
>                                          (uint8_t *) host_addr);
>                  chunk_start =3D ram_chunk_start(block, chunk);
> --
> 2.54.0
>

