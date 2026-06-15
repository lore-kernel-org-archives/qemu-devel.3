Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DACCD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2lz-0003dv-D6; Mon, 15 Jun 2026 04:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZ2lw-0003cu-4Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZ2lt-00088H-JC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781512455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=faojN6cEMj7aLwdFTy6B0EDUbyohNWsHwTvMNUPkUqs=;
 b=Pk/rtgDFl5ZXTQPMpvD0xGwffJHRlHRLZtpl0kwFM5EIFr3yCvxpXVcTqhOWBjgZmKtz0q
 bow8bzxdFWVEbE5CkyvH9ij+1KXxXKzRNMDBkDPoJ6hKBZbcgbuwbTEZPldFHIhLnEnLsp
 yAiv0ZuqpKrsmeJz0jNkiRcYLab469g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-QA5RrbrRPbGZinKlZhb2vA-1; Mon,
 15 Jun 2026 04:34:12 -0400
X-MC-Unique: QA5RrbrRPbGZinKlZhb2vA-1
X-Mimecast-MFC-AGG-ID: QA5RrbrRPbGZinKlZhb2vA_1781512451
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BFFF1955F26; Mon, 15 Jun 2026 08:34:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7073180049F; Mon, 15 Jun 2026 08:34:06 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:34:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] qom: Reject temporary object resurrection
Message-ID: <ai-4-0UkH0uCZwYS@redhat.com>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 15.06.2026 um 06:11 hat Akihiko Odaki geschrieben:
> If object_ref() is called during finalization, it will temporarily
> "resurrect" the object. Although object_finalize() asserts that no
> resurrecting reference remains before freeing the object, the assertion
> cannot catch the case where the resurrecting reference is dropped before
> freeing the object.

Ok, and why is that a problem?

In the cover letter, you referred to an earlier patch you had posted:

    The temporary object resurrection patch originated from:
    https://lore.kernel.org/qemu-devel/20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp/
    ("[PATCH v2 1/3] qom: Do not finalize twice")

From that patch, it's clear that one problem is that .finalize() can be
called multiple times, which you probably don't want. But what is the
reason for switching from just ignoring the second .finalize() like in
the old patch to completely forbidding a temporary refcount increase?

> One way to catch this would be to add a check in object_ref() to reject
> resurrecting references before they are created. However, object_ref()
> is frequently called so it is better to minimize the overhead.

We're talking about a single comparison with zero here. So if that's the
worse alternative, the other one can't have any drawbacks.

> To avoid adding the overhead, change how the reference count is
> represented and let an existing assertion detect resurrection. More
> concretely, obj->ref now stores the current reference count minus 1. The
> stored count is therefore 0 after object_initialize(), and the final
> object_unref() decrements it from 0 to UINT32_MAX and starts
> finalization. A resurrecting object_ref() will then trip the existing
> obj->ref < INT_MAX assertion.

A refcount field where 0 means that a last reference is still remaining
is highly confusing. If we do want to forbid taking a temporary new
reference in .finalize() for some reason, the explicit check in
object_ref() sounds much better to me.

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/qom/object.h            |  4 ++--
>  block/throttle-groups.c         |  2 +-
>  qom/object.c                    | 15 ++++++---------
>  tests/unit/check-qom-proplist.c |  8 ++++----
>  4 files changed, 13 insertions(+), 16 deletions(-)

Kevin


