Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6307606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q77X6tMk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU829-0005XG-2q; Thu, 19 Nov 2026 14:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU823-0005Wi-I3
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU821-00042u-SC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795117372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dw2Rpeftq6YhVLewKa1VUMtSovMkE532/O+h1M6xwPs=;
 b=Q77X6tMkl7l7JuawqO1dMwsVSprCLksMENroAGFVeMTQotyym3gdUBzVcwsdFHQA393Tke
 hctjjH+sJs8wALJFWL3NDPt3tvN1mfx4HAf3vW0D8C2ggwEuzEWYFq7W7HCmFegrcZrgWP
 Y5iYYLYK1EYiCuv2KgpuV9sf3biPnPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-_4BaqNKXPQKrIwdI0lmewA-1; Thu,
 19 Nov 2026 14:42:48 -0500
X-MC-Unique: _4BaqNKXPQKrIwdI0lmewA-1
X-Mimecast-MFC-AGG-ID: _4BaqNKXPQKrIwdI0lmewA_1795117368
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6DA719539BB; Thu, 19 Nov 2026 19:42:47 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FCB330000D3; Thu, 19 Nov 2026 19:42:46 +0000 (UTC)
Date: Thu, 19 Nov 2026 13:42:43 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH for-11.2 1/2] block/qcow2: Detect corrupt images where
 first refcount block is empty
Message-ID: <av9RFfYVm0_IvKu6@redhat.com>
References: <20261119140338.2918386-1-peter.maydell@linaro.org>
 <20261119140338.2918386-2-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119140338.2918386-2-peter.maydell@linaro.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:03:37PM +0000, Peter Maydell wrote:
> In a QCOW2 image, the header is always cluster zero, and so that
> cluster must have a non-zero refcount.  This means that an image
> where the first entry in the refcount table is zero, or where it
> points to a refblock which is empty, must be corrupt.  Detect this in
> alloc_refblock().
> 
> This fixes a bug where 'qemu-img amend -o refcount_bits=...' would
> crash on a corrupted image where the entire refcount table was empty.
> The crash happened because walk_over_reftable() would return with
> new_reftable_size == 0 and new_reftable == NULL.
> qcow2_change_refcount_table() updated s->refcount_table and
> s->refcount_table_size with these bogus values, and
> update_max_refcount_table_index() would crash trying to dereference
> NULL[UINT_MAX]. We add a defensive assertion here that the
> new refcount table isn't zero-sized; this can't be reached because
> it only happens in the corruption case that we now detect.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 791c9a004efbcff ("qcow2: Add function for refcount order amendment")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3690
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/qcow2-refcount.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


