Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B17C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfv2-0000Rf-S7; Wed, 19 Aug 2026 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfuo-0000Od-1d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:01:10 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwfuj-0001Ku-5n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:01:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso175151a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144462; cv=none;
 d=google.com; s=arc-20260327;
 b=g9HprsutKbghix4oEosgU03f839O/Ehtlsxv2yfPngcVBmFsv2fK51Q9XjXIzcFm0M
 YtI2+vjUonjJnzRHx2ePKnsZ9Vvcbf5XukEuBPyVcLWUyHTYWo3zXRgvQp8sMpZwajSI
 L2fTrYoviw835GGHLH+Z3D842HJUo9D0oNi0KgjqcnP6LPUHARQrfoh3ktbsyccyKiqI
 Qov1+l9lBDv+r2k5lQ9guzEmyHiiVzKONIdTBnkZKqm8knHRuKGplHLCqnAk01DrqR87
 U6olA3dw8rsd7Jwj7SKMqGrrp9uaQrn2fPZgZkMWzqPh0TgqqvPi+8eNy8GySU3fgoY8
 x2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oJl/Slh2Cff000xLIdIxbQVt+o3GQDjjThwSSBPrncU=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=TWF8Nt1wENyVXKzvyrKk/nPcn+tVQ/cdfeC1ifySWqh4YbHa6ksHVIBNNJxCyVxsEZ
 J8AUmC1JApNEi9A7+sj4VSY9V+ITwPOozfz2xSM4RsNfbvrGJXKHqwdgfCHbQRgMVaPe
 0CANsHbLmBFlna66NTbU5xxZVzWST1RoM+rwSU4zPfQbBWMXOmTwDFzMOKi769QSy6Pr
 C6F4dIBke8WnlE4ffFax+vwcySAjarab4xFldkviU1s0UVTiMcQArkxo5U9ntsdpDNYo
 s9bzDxM/XISqg/5McLb0hiA/SwrzboM3hW3CgEmmZ10pm4b51BgFSL3Um8SDy3bvd5+5
 lFGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787144462; x=1787749262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oJl/Slh2Cff000xLIdIxbQVt+o3GQDjjThwSSBPrncU=;
 b=NEBH3D2bQ1LKSXKUeQYYL1+ktEfrpUt2xMOpIau7ATNQ9yl2kwm9mPQhdZf/QGH6kA
 /PgNnHJo7whV6spCYdIqGJC3NLmSTcJUshbNL10XqirbQco6DmvqiaZfEVz51ueWNf/5
 HlIWygViH3vWC5zt9se1yyxWIqlgdNyPLRndcgbYuZUlj0Cbe+3aWNaYVND9yLJp6RON
 UfabZ6l/y99BIvSOy2Q5Wft0+I+iPIfQYI+WUXP2EtpWZjs2unjmsE7EelsHtdc55+jv
 a2LbjMFYCQrkBFGtxCdeh5r3mPJl/ouunkGhKV+iHrmRDap+7DkNx3p7onvYoVQ/nqK1
 /WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144462; x=1787749262;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oJl/Slh2Cff000xLIdIxbQVt+o3GQDjjThwSSBPrncU=;
 b=GPPg0um/yQls0gnA7SuyPPUxnq+sCAi9qhaQRFNEqJpEWH5BNZeB9XGacocMloMabU
 gWEL1UQ1NUDvWyVUz6kt04KEEI/izT1uoKKrwJfqRhascD66EZcktjEbN9ELZ62nBtd4
 8ek8DRzRksEV81V+RuhxdsaXBrwPj3AdBtbDAkZTmvP4Fxl0iMkw+Sd/SARNbCH71mV8
 wYn2pCOG3fEMe3Ux5qszFyAux7mKXu492SOoAo7bkKyNdFM6zm7pxEs9xPcJIncezBPB
 ws6XDdbUBX+8+OoC18pau1ToRZ+PDC0+JkM89RwCt9xjlBdlPvD2yrtzz/Y9GyAB8Wp5
 GbiA==
X-Gm-Message-State: AOJu0YxIpOIll0XiBQXxvig9eTUAAdPqC5dN2cD5mWuHU0X4X9Xn8CLL
 pQGdx+y0zmEEg2qQGWsoHFHtyizqC3LioP1HiAGLg7pciUoRgCe8ziQ8uAEReOk1XmKI3+vEBFW
 xgjoNsKxFA8tINEo8qdE8gxN64JZD6qt5GBDtyGR5PA==
X-Gm-Gg: AR+sD11RQQN/vC3Ei/P3IeBMYQ6Jt9Nul+cqD4MKmdhtP9EJQW/TCJZv5Xv/zF7D4Kg
 f6dOH7ifn0qKks0a/qLBg+bXaQe2U5kJSSsxnLuoc6H1GED/DlysF0v5Q9NmvIuEQgHixsk6om7
 RDOicQYhu3yFFd2ESkzyfjbnprmHw67qA35hUbK2XPK3/6HYhWkIOqhuPmKTU5hWNKRDaumD59z
 w9Hq30keWdftEtsMs6mFdmrOgDZMB4+B2zrrkKQbRBsX33lY/XbjmAV7738ivjWNDUtosShQzOi
 /QrXJnDmnO1pMGGdlNgwTuScsLj5bYpLE8GT7vk0fPWK
X-Received: by 2002:a17:907:960b:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c242e36cb2dmr154700366b.4.1787144462228; Wed, 19 Aug 2026
 06:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-9-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-9-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 15:00:51 +0200
X-Gm-Features: AcwNN1Vryx97H10kvJQvwNfwM015hJM4YsZnUy_6gTuZ9sENo8EhkNQcLu0GdRE
Message-ID: <CAMGffEkzdOna79f561r6bMF3wgZw4h5LwHXhC3KBx_FqLNz+wQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> The value received on wire for head.chunks when registering new RDMA
> regions is not correctly checked.  Logically the value can still make
> ram_chunk_start() (of ram_chunk_end()) to overflow, having a result point=
er
> very small, smaller than RDMALocalBlock.local_host_addr.
>
> Add the sanity check.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 5ce8b06818..bbbc40ea3b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3401,6 +3401,13 @@ int rdma_registration_handle(QEMUFile *f)
>                  chunk =3D ram_chunk_index(block->local_host_addr,
>                                          (uint8_t *) host_addr);
>                  chunk_start =3D ram_chunk_start(block, chunk);
> +                if (chunk + reg->chunks > block->nb_chunks) {
> +                    error_report("%s: head.chunks contains illegal value=
"
> +                                 " (chunk=3D%"PRIu64", chunks=3D%"PRIu64=
", "
> +                                 "nb_chunks=3D%d)", __func__, chunk,
> +                                 reg->chunks, block->nb_chunks);
> +                    goto err;
> +                }
safer to do this instead, as reg->chunks is from wire:
uint64_t chunk_sum;
if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
    chunk_sum > block->nb_chunks) {
    error_report(...);
    goto err;
}
>                  chunk_end =3D ram_chunk_end(block, chunk + reg->chunks);
>                  /* avoid "-Waddress-of-packed-member" warning */
>                  uint32_t tmp_rkey =3D 0;
> --
> 2.54.0
>

