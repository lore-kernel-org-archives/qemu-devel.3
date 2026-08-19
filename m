Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04809C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwffB-0004Qh-TX; Wed, 19 Aug 2026 08:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwff8-0004D8-ES
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:44:59 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwff6-0006R7-Td
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:44:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso11823166b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143495; cv=none;
 d=google.com; s=arc-20260327;
 b=d5MnbUACsdHQcQNQkhBggoZv2WTTNkojhqMD5lRXrvuS3CLn/Od3cakeBSKdVz8y+i
 TML7Wf9KyfqKKfo7PsHVIkvWw8ukbgVGOeGdBr2wNvJkbrOU1GEM38ua2tOcPn/yasG+
 oqskcYoRKZbTZ4JdyPw3c2qGPxZE8O6c7JbRmBD9Qd26NY0761lemJAnwve5CbrN85MM
 2PGrTPhzhbU8MfZbrMcZ+GYKzkKyM+pfbiQRYwRv1rR2cI8S6mpoUlBGYHkG2cp8MY6u
 Asm2D1XkDisAoo7UaQm8RM09hxyC0J+xQhuINoQy9mMuSxmJieH5wgWUSP22kHnF3jkm
 Ed6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rPWPTlNzbV0nJkFtvzKn24FsJcdwYbo6+2AjU/lDM4Q=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=h5BYGYuAOcI852/qQoN2cZkmhJyQtzI3GF8irwqzJ1mf2o02+40VBI0ReV6l7B3Pv4
 587n8d8olsWQ/Ks7Q9p52UWaEdvEg1xL1l8c2g3/RpfM8pxM++EgxCrOAHkDJQ1ttw83
 bNvJB/K2NAYxhA1DZH7VfXYgCAwg2eKF7H/os1kP1alTr7GIHFXT4sJfY+uqUg5ExpjT
 1KMwv8848Cr6q34pkzyYiIcu0yMzIeKqDXA6HPy/HZRYqhDd+VxXXWUPvARnJAv+gjEM
 Uy0U8KJ/vksUZn2i2dnQXz+gRLNsaY2pi2P8IXxxog2GG7Z+ew+IalL/dejTjRmpUoZm
 zIpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787143495; x=1787748295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rPWPTlNzbV0nJkFtvzKn24FsJcdwYbo6+2AjU/lDM4Q=;
 b=SwuHfyE24dZcUoLGvZZWE9130WUPwY75XPTLhI7awTOqkBz8xL8lNWeANJZHrAmTsD
 80KArwxF2U3k+eqZyVo+9ktUXCvykhstzwT29HMcsQeMujB07lMkHV8n38rAGkvRHre1
 fylmP4/ANixnTVDxnBUu42owpzXJeJpEf6PojZrIhw+s0sh/j4Sw0WKPvYdWMTxnrqQ3
 vrkLD6sQahnUsrUnxlizw8sYYLhD8NRWugARK0sIOI1WIBQM2/YdgPFRQdrLrnY9BS3B
 1lGkv+RnGATouXw2kgeebCXNhEnfPTj424OohU/4e788u1c4qwYN0sngjZqtb/KimLdg
 MJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787143495; x=1787748295;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rPWPTlNzbV0nJkFtvzKn24FsJcdwYbo6+2AjU/lDM4Q=;
 b=k7Vn52RuY6BKoPaahGAuuorr0yV2CGOjHLicQAv7X8abUcSqaofYo7tVHq1bCD90J4
 SOxDhQhalqQzRLwl5gH2QFbbTH8C7rdwra81zAi8Z31PEzu3KtB1GO1XylEvXJZBgxHu
 JJQIqLvspFBsGd4iW2TZCfkA5KIqlyMObQBnPJouLb0TSwDSrxjRVOYYAcnyFSbGnKha
 1BC6haBgrfX8ogzZQmoU5SeJZ1odJTHGPrQdpRt8Dp41SMgIrlmapCnxo0OVJOijuNvc
 bT/BMxPeT0SysgrLCGsW0MbYvXpu0jbrq+0g/JO8LHGu44qvEauYglX4vhw9aQ/Cmq/y
 vIAA==
X-Gm-Message-State: AOJu0YzcwSZbsBMfaJRqHdcc1dLzOWbN8BFohvdOsZ9QwaQYOkcjpBGA
 lVcuE+CylJalkZ29fn/r1bySoioiIQJ620pm4o0B7nkwY4X4u40J+2JpI3+1M3Tf+SMvjTYzKFg
 P/f0U2+HfMF6Lxy7lHmy0WgJUfMfX9OQ2zqMp8vCx5L1H1PuQYJ7Ee3Q=
X-Gm-Gg: AR+sD10YtbOFjger58aHAJZV6rkMf0W6b2dclRpSUZrDfn7De9wAGQGwimGTNygHEHC
 0sEb0YQHqpSdE22DsntcKKJVXSutYXPf6kcfQ6MMspFBCsydyUjqD+3ct478bV0V4ne4S3MbmsC
 QBPowy9QvCPmJXEs9HLXv8asFK0XFf6qQCtlhSOlgnPUT3EklvtkIpSAcESC6sGSCbOqY9uukDV
 tsjT/IlxsvsqOKRIWoXcSGrfU+rE3VpK6+UVe7EC7XtWAPbiJvawvbiKTWrZpa44tO9QqKghQ78
 Gqpqn5fU8uFvRH3jhyxezlVsLCECGIPwUemmd3ohsBkJ
X-Received: by 2002:a17:907:3e9a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c242e23c7a1mr151561066b.3.1787143495409; Wed, 19 Aug 2026
 05:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-6-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-6-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 14:44:43 +0200
X-Gm-Features: AcwNN1VlBRuPth-qFYOVbojur1_38HKW49argEWqU9gm4W4RkQNeNB60RhRh1i4
Message-ID: <CAMGffE=4QqAR7s0=VmjLoevF+-k2+CGT8GEmSTMq_ytMbC98zQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] migration/rdma: Drop
 RDMALocalBlock.unregister_bitmap
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::636;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x636.google.com
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
>  migration/rdma.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 354935433c..c06395a51a 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -198,7 +198,6 @@ typedef struct RDMALocalBlock {
>      unsigned int   src_index;       /* (Only used on dest) */
>      int            nb_chunks;
>      unsigned long *transit_bitmap;
> -    unsigned long *unregister_bitmap;
>  } RDMALocalBlock;
>
>  /*
> @@ -578,8 +577,6 @@ static void rdma_add_block(RDMAContext *rdma, const c=
har *block_name,
>      block->nb_chunks =3D ram_chunk_index(host_addr, host_addr + length) =
+ 1UL;
>      block->transit_bitmap =3D bitmap_new(block->nb_chunks);
>      bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
> -    block->unregister_bitmap =3D bitmap_new(block->nb_chunks);
> -    bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
>      block->remote_keys =3D g_new0(uint32_t, block->nb_chunks);
>
>      if (rdma->blockmap) {
> @@ -665,9 +662,6 @@ static void rdma_delete_block(RDMAContext *rdma, RDMA=
LocalBlock *block)
>      g_free(block->transit_bitmap);
>      block->transit_bitmap =3D NULL;
>
> -    g_free(block->unregister_bitmap);
> -    block->unregister_bitmap =3D NULL;
> -
>      g_free(block->remote_keys);
>      block->remote_keys =3D NULL;
>
> --
> 2.54.0
>

