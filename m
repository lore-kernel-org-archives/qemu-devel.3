Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B07C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfeI-00007n-Uw; Wed, 19 Aug 2026 08:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfeH-00005j-F3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:44:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfeF-0006NF-Dd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:44:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso11256066b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143441; cv=none;
 d=google.com; s=arc-20260327;
 b=foytF234FvDPIBpfvEX6T98rUOowgoE4AijbEvTe+tCmhuHPy0G8xqNDVYvULBJJmG
 xnmqKyTwMwawGWfrqHNquXv/bOE7MS+1l/rlengQYPHkF2AlWzBzin9x6ht8tTaGriCO
 1xHQLKYEWpgweXNCDOPDgJAEwavTP/qsgp4CD06EI9TgrP4SO7FLF/CRUPjQiPQRb/Sw
 wIYeBeKPoIRfLSsJ9wgYKhka2UBQKxfGcMSjP8Rdyi+Z3GeralUHV4IMfvnDi7Y23Vbl
 14mvmyz0106GscPzCh8Jwu+j0QQXvG0nnx7YVJEGcI+nDDh0508p9bOJf+Bx/657z35N
 PnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w5ca02jWoLIYSkdhuYI793adoSE4GtTujEGUxgHGH8A=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=i7g00qx3fLzknhzdR7WVHXwylegcO3KD+j4YPqFlNuuS8fFFO92Pk1GcDMvWyBz9TM
 RwVvWPm1wkGdXJfeZgjCw7p5K56DTYn3kk1mJUTaMIFzIqqNsTAz25qfo3w5ip9CvWXB
 91kAAHtOqqD2JWZwC0fo+hjM5Gu6PE4f7QIQq7Z1qLd0GqarTMlAw0naD9nBYqPQUyoK
 roqtdw+Y8IwPVSzXfyS0zJUR0MBL8tpotvsOzF0cJnBvgodFgRlz/hsfsJ5FNXrB8nTS
 QQmeFD+TMD5W2pvqlgBoEvyooPuntV7O6hHyN1gJZ5fOzVr/037+gQrQgFFGqw8kk4nE
 xdBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787143441; x=1787748241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w5ca02jWoLIYSkdhuYI793adoSE4GtTujEGUxgHGH8A=;
 b=idlUaEYuivz+3bl5Hps757RYnl0+SVh7uXqqvf/Z5zcG20zrisFSTqC/JeOVL7E9Px
 xrAEyQAFhDZ+65eQTu5ddN6Zxrr78GmLU/TMHTdzY6tc1j60eFPl8I2YOBx545K8l/Sx
 oFlIHb1DHlSSEVp/tTxdlhoQCMN0WpsbOF9XFwhj6GaDEOMywiHc0OBPbnD1XMmXI7Dd
 5/tr+TteWxYLOVQeYT12/m2VVPQNWKsNsJLyJ4/LFmKlSJ+6ABsS4y+l9/dnkpEM/mhv
 oXUa8Uu/zq+grivK7q85JtMDoBwzMgaOmIRoe3uoNjUeN9GQkhm4sOMTyLD/UQVdA/UH
 3oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143441; x=1787748241;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w5ca02jWoLIYSkdhuYI793adoSE4GtTujEGUxgHGH8A=;
 b=euHt8+IAeoruQHyLbm6laUvWg7qzDTSPGu2Ufnz+/kfF0HFdF/FIVg9nxws++Bl+pn
 PsenNNoAWAibAoXNQo9vvdtIDOxCrs/kN8O+WBOoWQ9wKHZyGTjKT1M2+gnkb6crctnw
 FXozWvvu0Vy1ume3vlUK5nnTb0eLjq96BColuUc/aNYUZxi139WJlS2E+8PEoqrNz637
 auMuU3GoXs2MKUzbfRMsAdsMugYM6OJnlhghXcaK655oY70ISzc0yq6MS/8l+4METSgX
 euSevFwkDEvg+6aeoEKmG3gMJBH4rBr/v8neQU1MgVqntkJgxJiALKXJ8K5faLe+OCzg
 eQyg==
X-Gm-Message-State: AOJu0YzcZBNQPBe5E25ko6/7epKMA799CBeep0i0Ra1tCr6o/FtoqIXU
 WbnPFTw6TSosRIhj5ztOI6GV6tXw1mgF5twraJEzY+G2Yv7/W9xZZTKmDrR8HqsYlEqJk0i9UNw
 J+U9pjz3GoFIclH+dwE8kMXcjHuJ4nCE0vm0HSc+uTQ==
X-Gm-Gg: AR+sD1175A4jJE9uEnjbU2ydgmV5ItLSO3+Yb1JLwrfniE2n+dC6T5RGsa/302xHcwv
 fsoAb1sVYlFX5EbZvKIVt5vvy11NhOQGjNop0xpmg3go3QO9scey6naW7XZNp6BzrfiGj3Dri3A
 sLLjYSZxTOEZZWNDtinvutn2TCWDZ/RFZx4ocP1041CBSI8dqygBoo+Y+OxDPNo+GIJmWQPLBah
 rDM2/g1ukj54FYxcUClH12VDGNo6VFxVxkkTG+Z/Cva2WytDKqQIYPb9hqOhh4cynL6PTKDIGDD
 BmlTlQOfIIO3PFMBj9wWP0rVdpkQHWDMD9cTzzdX5sQo
X-Received: by 2002:a17:907:d21:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c242e206169mr152454466b.2.1787143441353; Wed, 19 Aug 2026
 05:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-5-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-5-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 14:43:47 +0200
X-Gm-Features: AcwNN1UILXXHuHnQiTdFQJJoEfV-tWHA31yzdhSJaggVGjdiAIWwoD-MsQXyeCU
Message-ID: <CAMGffE=uzpHKCo+s36jmW3GVU3ELnprB2nSNOTrsBN742r9VsQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] migration/rdma: Drop RDMALocalBlock.is_ram_block
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62a;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62a.google.com
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
> This is guaranteed to be true.  There seems to have support for some
> dynamically allocated buffers but it was never really supported.  Remove
> dead code.
>
> As a side effect, this patch closes a report by removing the buggy code
> completely.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4006
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 73 ++++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 52 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index ffae0a887f..354935433c 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -196,7 +196,6 @@ typedef struct RDMALocalBlock {
>      uint32_t       remote_rkey;     /* rkeys for non-chunk-level registr=
ation */
>      int            index;           /* which block are we */
>      unsigned int   src_index;       /* (Only used on dest) */
> -    bool           is_ram_block;
>      int            nb_chunks;
>      unsigned long *transit_bitmap;
>      unsigned long *unregister_bitmap;
> @@ -441,14 +440,12 @@ static void register_to_network(RDMAContext *rdma, =
RDMARegister *reg)
>      RDMALocalBlock *local_block;
>      local_block  =3D &rdma->local_ram_blocks.block[reg->current_index];
>
> -    if (local_block->is_ram_block) {
> -        /*
> -         * current_addr as passed in is an address in the local ram_addr=
_t
> -         * space, we need to translate this for the destination
> -         */
> -        reg->key.current_addr -=3D local_block->offset;
> -        reg->key.current_addr +=3D rdma->dest_blocks[reg->current_index]=
.offset;
> -    }
> +    /*
> +     * current_addr as passed in is an address in the local ram_addr_t
> +     * space, we need to translate this for the destination
> +     */
> +    reg->key.current_addr -=3D local_block->offset;
> +    reg->key.current_addr +=3D rdma->dest_blocks[reg->current_index].off=
set;
>      reg->key.current_addr =3D htonll(reg->key.current_addr);
>      reg->current_index =3D htonl(reg->current_index);
>      reg->chunks =3D htonll(reg->chunks);
> @@ -585,8 +582,6 @@ static void rdma_add_block(RDMAContext *rdma, const c=
har *block_name,
>      bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
>      block->remote_keys =3D g_new0(uint32_t, block->nb_chunks);
>
> -    block->is_ram_block =3D local->init ? false : true;
this local->init is only used here, can be removed too.
> -
>      if (rdma->blockmap) {
>          g_hash_table_insert(rdma->blockmap, (void *)(uintptr_t)block_off=
set, block);
>      }
> @@ -1767,19 +1762,10 @@ retry:
>      chunk =3D ram_chunk_index(block->local_host_addr,
>                              (uint8_t *)(uintptr_t)sge.addr);
>      chunk_start =3D ram_chunk_start(block, chunk);
> +    chunks =3D length / chunk_size;
>
> -    if (block->is_ram_block) {
> -        chunks =3D length / chunk_size;
> -
> -        if (chunks && ((length % chunk_size) =3D=3D 0)) {
> -            chunks--;
> -        }
> -    } else {
> -        chunks =3D block->length / chunk_size;
> -
> -        if (chunks && ((block->length % chunk_size) =3D=3D 0)) {
> -            chunks--;
> -        }
> +    if (chunks && ((length % chunk_size) =3D=3D 0)) {
> +        chunks--;
>      }
>
>      trace_rdma_write_one_top(chunks + 1,
> @@ -1804,7 +1790,7 @@ retry:
>          }
>      }
>
> -    if (!rdma->pin_all || !block->is_ram_block) {
> +    if (!rdma->pin_all) {
>          if (!block->remote_keys[chunk]) {
>              /*
>               * This chunk has not yet been registered, so first check to=
 see
> @@ -1853,11 +1839,7 @@ retry:
>               * Otherwise, tell other side to register.
>               */
>              reg.current_index =3D current_index;
> -            if (block->is_ram_block) {
> -                reg.key.current_addr =3D current_addr;
> -            } else {
> -                reg.key.chunk =3D chunk;
> -            }
> +            reg.key.current_addr =3D current_addr;
>              reg.chunks =3D chunks;
>
>              trace_rdma_write_one_sendreg(chunk, sge.length, current_inde=
x,
> @@ -3408,30 +3390,17 @@ int rdma_registration_handle(QEMUFile *f)
>                      goto err;
>                  }
>                  block =3D &(rdma->local_ram_blocks.block[reg->current_in=
dex]);
> -                if (block->is_ram_block) {
> -                    if (block->offset > reg->key.current_addr) {
> -                        error_report("rdma: bad register address for blo=
ck %s"
> -                            " offset: %" PRIx64 " current_addr: %" PRIx6=
4,
> -                            block->block_name, block->offset,
> -                            reg->key.current_addr);
> -                        goto err;
> -                    }
> -                    host_addr =3D (block->local_host_addr +
> -                                (reg->key.current_addr - block->offset))=
;
> -                    chunk =3D ram_chunk_index(block->local_host_addr,
> -                                            (uint8_t *) host_addr);
> -                } else {
> -                    chunk =3D reg->key.chunk;
> -                    host_addr =3D block->local_host_addr +
> -                        (reg->key.chunk * migrate_rdma_chunk_size());
> -                    /* Check for particularly bad chunk value */
> -                    if (host_addr < (void *)block->local_host_addr) {
> -                        error_report("rdma: bad chunk for block %s"
> -                            " chunk: %" PRIx64,
> -                            block->block_name, reg->key.chunk);
> -                        goto err;
> -                    }
> +                if (block->offset > reg->key.current_addr) {
> +                    error_report("rdma: bad register address for block %=
s"
> +                        " offset: %" PRIx64 " current_addr: %" PRIx64,
> +                        block->block_name, block->offset,
> +                        reg->key.current_addr);
> +                    goto err;
>                  }
> +                host_addr =3D (block->local_host_addr +
> +                            (reg->key.current_addr - block->offset));
> +                chunk =3D ram_chunk_index(block->local_host_addr,
> +                                        (uint8_t *) host_addr);
>                  chunk_start =3D ram_chunk_start(block, chunk);
>                  chunk_end =3D ram_chunk_end(block, chunk + reg->chunks);
>                  /* avoid "-Waddress-of-packed-member" warning */
> --
> 2.54.0
>
other than the leftover above. lgtm.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>

