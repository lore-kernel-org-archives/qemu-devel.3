Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A7C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlok6-0004XC-Ds; Mon, 20 Jul 2026 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlok5-0004X2-PJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlok3-0000K0-Kl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784556790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amn6kDIT0WP5ybt8VbJ5VW8vOOWsBH/TSBn2QO9H038=;
 b=GvIrEnx6zPicgD/bU3WPKbv5fwowcvL4VqsZ7zo0hCJaqmE62BvE3BsiroeD45S4m6MMTs
 R/g1XXqXSBKcQb04EzbEw6gVtRVz2hDwS34ntn590AVr1m0LEyMiiDVaIynreLVn81mepf
 XfQkxgtV4Q6d6YpCMxN+J/ZF/5JW/z0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-YtxNytSYPh651Zi2gCUL6w-1; Mon, 20 Jul 2026 10:13:09 -0400
X-MC-Unique: YtxNytSYPh651Zi2gCUL6w-1
X-Mimecast-MFC-AGG-ID: YtxNytSYPh651Zi2gCUL6w_1784556789
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930a098ea19so606988085a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784556789; x=1785161589; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=amn6kDIT0WP5ybt8VbJ5VW8vOOWsBH/TSBn2QO9H038=;
 b=XQ7GS9CD6cz1e7lhB6emjQakVV2qR9h5e7OkXbUIEEPYyi+NSaw6LSqP0HPWTNkiKd
 evdJq9HfLie+G9lQ2Fwx2wGMv2F5n7TuLivgJG2Mg5yeY7Nk+W/7tO7Mrsuj4/TrVNLy
 bsD/KIgufJBZOfLgLlzhoHJcRWRyPQmGc5tbAaIu7xlmFdiwpoxoavNNuecWnboBFwyU
 Jm4CKnBBzwUX/hy+0huw+oLbzHlrpejLq4W1B3tKeejVh2KRA7WYKlTiw5s1kjFTyIBo
 UHI+iPzy08MML51Juy7Ah43Q1W6dDyJF8pxxFpgqpqvgWDZ6dwcsj5lmZPGYHLlqpgV7
 f/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556789; x=1785161589;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=amn6kDIT0WP5ybt8VbJ5VW8vOOWsBH/TSBn2QO9H038=;
 b=flXomci5QAnErc7eyXRcA1Gei14E0zwozPBpqHQP8TYYOoM9IZUmwjidGmAGXTv0Ug
 L4aF6mBCVL248SeplfMqfGwTIcyQkwV2PuYASgh+5G8frUBob3xB384KuL6XO6AJoRtN
 o/MFLb/KxJELjhv5uQDBdNZTBKviuKkgasjw2cNKGZOodOqs/q9+svxQcCqRYTT2KVQh
 P4zjcvv1n6gKOCNwBkCdxJ3kxzZphfUg0BYAnxpahgcfFqfOZvgjjOCcPV15uRevzYnL
 KjOemzaJCu2w3I6aWq+DSOCUxIreV+LXiRIfwij69//UhvYXMdlpVyv0aUUZHhfDvtqe
 bGeg==
X-Gm-Message-State: AOJu0Yz36qZR61yBGj8ScwJ9JmQAnhhRDhm7lnM0+Y5D3tuDFYe3GjDy
 4uL7ngb/Hd+MGZP0b8fRt6aGzf6uKPfP5fxVk2Y7Few5CuOxqGe5xZ+nj0HkCJqc2LNcoda3SYJ
 DbUm02WHvMp4f9rrf3ct/urPXV6KYkc0CLta3JhAeMEonkX9M0VmSLlEU
X-Gm-Gg: AfdE7cn08NWjjlG7bSZ1rnVM3BZvN2zaqwS4a83Vt5XVCHyU1XcllphEFJtUNrY4qA5
 QKnuHaBloZXs3vb3sth3TvYRgXcMKbP28YpAbAzo5gQacF2wn8ZU4yTOVqdyzPsFKqFSI7f+Dbt
 0R2U4j6kXQ3eo7dImBoMOlgsFAtn7tMcGz/ofbh0l0iRdxZutynrPIMIQRMxPj/RGDRdGPIJQUW
 aYh9Jlf8FE6s5qSJIHQrEoX0zScFVUvv5L49rxpIDm1mlflJXDad6TMmZBXo3ZLUZ4N5WO7D5iL
 /rnDC27tCTQTFa0+N8h6BPzoK0N0c9kb+oWkSPvSS3bDuAy+PKDXnaf+9XomtnIGEFV6
X-Received: by 2002:a05:620a:3708:b0:92e:e695:d622 with SMTP id
 af79cd13be357-930b3ea8f77mr1401548885a.28.1784556788440; 
 Mon, 20 Jul 2026 07:13:08 -0700 (PDT)
X-Received: by 2002:a05:620a:3708:b0:92e:e695:d622 with SMTP id
 af79cd13be357-930b3ea8f77mr1401540785a.28.1784556787735; 
 Mon, 20 Jul 2026 07:13:07 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077856348esm91631706d6.12.2026.07.20.07.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:13:07 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:13:03 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 8/8] migration/rdma: annotate and simplify
 wait_comp_channel()
Message-ID: <al4s77A0rlX0_PQc@x1.local>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-8-fabb4db3c204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-co-v1-8-fabb4db3c204@redhat.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 11:55:37AM +0400, Marc-André Lureau wrote:
> The function calls yield_until_fd_readable() (coroutine_fn) when in
> coroutine context, and polls with qemu_poll_ns() otherwise.
> 
> Replace the migration-state proxy check with qemu_in_coroutine(),
> which directly tests what matters.
> 
> Fixes: 2da776db4846 ("rdma: core logic")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Just to say we can also drop the var.  I have a patch did it already but I
didn't get chance to revisit the series:

https://lore.kernel.org/qemu-devel/20251022192612.2737648-5-peterx@redhat.com/

So we can also pick that single patch up, then this patch can be
annotation-only.  I'll leave it to you.

Thanks,

> ---
>  migration/rdma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3e37a1d4401..438419d1894 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1348,17 +1348,13 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
>  /* Wait for activity on the completion channel.
>   * Returns 0 on success, none-0 on error.
>   */
> -static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
> -                                       struct ibv_comp_channel *comp_channel)
> +static int coroutine_mixed_fn
> +qemu_rdma_wait_comp_channel(RDMAContext *rdma,
> +                            struct ibv_comp_channel *comp_channel)
>  {
>      struct rdma_cm_event *cm_event;
>  
> -    /*
> -     * Coroutine doesn't start until migration_fd_process_incoming()
> -     * so don't yield unless we know we're running inside of a coroutine.
> -     */
> -    if (rdma->migration_started_on_destination &&
> -        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
> +    if (qemu_in_coroutine()) {
>          yield_until_fd_readable(comp_channel->fd);
>      } else {
>          /* This is the source side, we're in a separate thread
> 
> -- 
> 2.55.0
> 

-- 
Peter Xu


