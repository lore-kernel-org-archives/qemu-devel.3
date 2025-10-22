Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72896CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 21:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBgTs-0005Fn-S8; Wed, 22 Oct 2025 17:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBgTo-0005Em-AL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:34:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBgTl-0002Tv-K7
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:34:48 -0400
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A1E23F66E
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761168881;
 bh=KscooOBUypvsd6gT0C1jrBO2M4d+EScrwhkXdwNY9So=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=gTSFL5APdHJFPxlviNkhJTYX3IMp4LtFax8MCDQI+to9Rx76VMFdvuKtChXnv/Mon
 o0n1bP0bMi4c9VOJxixbePA18X4TyF9kQNmsq6LD8/K1pjvvfpaHMQJGo6BOjxv/41
 GPVTlnecVYm547llv+072wQumiQMy6eQ++FScTVXXxlpCPYY9MNaH3szgNCR7OxdeV
 /XeEvrTkKBxZN6GN9m1yn11Q9OyxA3ksLj24COr4uZWjHZQUD8YtFj0pA2iRh2SVuy
 S4MqNVgRfqRWTWJEjiaGLbVYfDvBbd9ispOdEhgts+iXwsrTanLJ7Dbpk2oESfZmgr
 fF1c7XpFEf4ftTaM723n75PUlyGKyPM7vpTLMmjiVuNqNaT7ESZgxzy9HavSTFpib3
 DEgwl/PJnBzvoaWXKkG9H8dxDOFsrdnfZHVIKuTx9SYkDQlQLHPr21z99Di6hZ1gLY
 wyPI5SeEGFXyAYLWULnHeqXwRC2ED1GwrwHHr/VFvxuMOkLYPUbXf44aE6RaLMUwda
 BaxCqUnXTtpbDlByDEE91eyDKDD0eqEaRDYVvzt+69s282QLItMz8/Rti2LupU43c6
 leT2WA6tj/ZT+vC6TFNTMo37i3ASHvnaTnEUntk7osdx3tL9hljcy6+rXqK/KXzLiJ
 RKxin1cY+TT8DOXWxr7BAQqQ=
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7837171db88so796357b3.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 14:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761168880; x=1761773680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KscooOBUypvsd6gT0C1jrBO2M4d+EScrwhkXdwNY9So=;
 b=JPywRVhHSx9hh2lBFX7PWhK5fSeu+DIbJibaDTd2iug4Et6g/0Cm+YztDYIGdEVj9J
 GvbE9Oz21KjiGp3TLPXKLteBwybomZE3ZDK7rZyVjLKJKm6AaeV4CIAuyOORFBCAwUAt
 WC5PW8glEN2b8VtpCSeJywYMORXxvE7U6n2y0NaqjHj9CcLtadhu2M2SVN6+BUFDe18/
 6Km2tClgM7iAMjLs18Bsb3VsrW2yzgVM1Y5onnxcyESP7/hhWzkbBE6JKfG1zf3LBImC
 BkQkwM2F0lf0SBBybbhzj/lYpR5VkveM/jhDYmQ8wzv5BP2UxRB5+ZzPEpXcTJ99vYN3
 H32Q==
X-Gm-Message-State: AOJu0YzY1JUmOBFKiTNPzY9kCtGpsbthpV+FreE7W06jU8nS6Ctdx5sx
 3N+zjClNff25hWUknb+1RerX268Jnpu3XjdzBkgFbyUBrbC59rIP9Q2DxKp8D4q3zvSZrdW48IV
 y043P31h11jb1XNV89okDZSFRmwJa9onTXDXsBdJK8cqsTCbFQ6LVPoZRSaGe+6zc5zG0Je/aua
 sK0SWBMMk5cvq4w9zs+uryfIe7EKrfvaIaSiwxpEUlEkt/sZ8=
X-Gm-Gg: ASbGnctu1y0WF8LpsHZ00IuNEgZ/GlyOnNzbUDvFpV+gnVZ07auuhTovMPbi0uF+AXS
 xW7up/QbwdzNRgTTCBKPVc827SeGUPLZP9QVnuVobvEu2CchfV3ooT47bZx6e7YA+M8z9S93Q6o
 ZNc7cBJaHZAZ1WkqV4VORVA+LBa3A2jb4OPsITQeqmZ+YhC8vOaUyzAQWNrkyQO7ejCYKah60B6
 f5IgZ11Rmw7Kw==
X-Received: by 2002:a05:690c:680b:b0:77d:fbf5:8dad with SMTP id
 00721157ae682-7836d1fc0d3mr202901167b3.24.1761168880365; 
 Wed, 22 Oct 2025 14:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7o9TPlsypXNfBFy0+KW7AbFGR/YByc4LBT5mfTFXv3/ZE+hwMEMQWZiLYW+iwRqLsetqsXmDl0DX9whQZGbM=
X-Received: by 2002:a05:690c:680b:b0:77d:fbf5:8dad with SMTP id
 00721157ae682-7836d1fc0d3mr202900967b3.24.1761168879912; Wed, 22 Oct 2025
 14:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251021-fix-3149-v2-1-5ffbe701e964@canonical.com>
 <01ae19a1-61e5-499b-bb6c-0cc480f220fb@yandex-team.ru>
In-Reply-To: <01ae19a1-61e5-499b-bb6c-0cc480f220fb@yandex-team.ru>
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Wed, 22 Oct 2025 16:34:29 -0500
X-Gm-Features: AS18NWC2NvHpGdHkSNgZV8irDkhBAG-alnPCaSaEEHsxJzWiPN9ieMuR94dZp38
Message-ID: <CADzzt1DQbdA23W8dKTf9V0va7b6DhtWncQCbCGeevNuaGkTh0Q@mail.gmail.com>
Subject: Re: [PATCH v2] stream: Remove bdrv from job in .clean()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 22, 2025 at 1:57=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> If my assumptions match, they should be mentioned in commit message.

This is my understanding of the problem. I'll try to be more clear in
the next submission.

> Ok, so, the commit make a work-around: avoid listing the invalid node
> in query-named-block-nodes by removing it earlier (after the commit,
> the node will be removed on final bdrv_unref() in bdrv_cor_filter_drop().
>
> This doesn't seem safe: what if someone else have another reference on
> the filter node? Or will have in future? The bug will raise again.
>
> More correct would be fix the core problem: bdrv_refresh_filename()
> crashes for detached implicit filters.
>
> Could you check, will something like this fix the reproducer:

I tested this patch last week and again today:

diff --git a/block.c b/block.c
index 8848e9a7ed..a0246a65a5 100644
--- a/block.c
+++ b/block.c
@@ -8067,6 +8067,12 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     }

     if (bs->implicit) {
+        /* Avoid races where an implicit node is removed from the graph bu=
t
+         * not yet unrefed/closed */
+        if (QLIST_EMPTY(&bs->children)) {
+            return;
+        }
+
         /* For implicit nodes, just copy everything from the single child =
*/
         child =3D QLIST_FIRST(&bs->children);
         assert(QLIST_NEXT(child, next) =3D=3D NULL);

This resolves the first segfault, but it produces another one in
bdrv_co_get_allocated_file_size. Here's the trace from
query-named-block-nodes:

qmp_query_named_block_nodes
bdrv_named_nodes_list
bdrv_block_device_info (block/qapi.c L44)
bdrv_query_image_info (block/qapi.c L336)
bdrv_do_query_node_info (block/qapi.c L238)
bdrv_get_allocated_file_size (include/block/block-io.h L90)
bdrv_co_get_allocated_file_size (block.c L6011) (called through
co_wrapper_bdrv_lock)

And the bt from gdb:
#0  bdrv_co_get_allocated_file_size (bs=3D<optimized out>)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2+test8/b/qemu/block.c:6018
#1  0x0000631d078522be in bdrv_co_get_allocated_file_size_entry
    (opaque=3D0x7ffd375c5dd0) at block/block-gen.c:288
#2  0x0000631d07929ec2 in coroutine_trampoline
    (i0=3D<optimized out>, i1=3D<optimized out>) at util/coroutine-ucontext=
.c:175
#3  0x0000772778862f60 in ?? ()
    at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from
target:/lib/x86_64-linux-gnu/libc.so.6
#4  0x00007ffd375c5ae0 in ?? ()
#5  0x0000000000000000 in ?? ()

I need to spend a little more time getting this reproduced properly
using a debug build; it's not clear to me (yet) what is actually
causing the segfault here. I'll work on putting together another patch
to fix this too.

> Other ideas:
>
> Maybe, when removing the filter child, we should set its bs->drv to NULL,
> as filter node becomes nonfunctional.

Based on a quick look through of the code, this would cause
query-named-block-nodes to either return nothing or fail outright; it doesn=
't
seem like the right solution.

> Or, set bs->implicit to false, which will activate generic path in
> bdrv_refresh_filename (I'm not sure it will work good for the detached
> filter node)

This will run into the same second segfault as above; it also feels like
a workaround instead of a real fix :/

> Hmm, I also think that mentioned
> bdc4c4c5e372756a "backup: Remove nodes from job in .clean()" is
> at least incomplete.
>
> In block-layer, having reference counters in bs, we can't rely on
> "hmm, let's just drop this one reference, and hope, that after next
> function, the node will be completely removed".
>
> So, we either need a guarantee, that filter node is completely removed
> when we detach it (OK, detaching should just fail if it doesn't lead
> to complete removal), or we should be prepared to existing detached
> filters, and handle them correctly.

Thanks, this is helpful. I originally wrote off this approach due to the se=
cond
segfault but I'll revisit it. I think I'll submit a new series instead
of a v3 of this
patch unless you'd prefer a v3.

Thanks for your help!
~Wesley

