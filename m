Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F1606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nk6zr9oc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSTa-0004Is-Ku; Fri, 20 Nov 2026 12:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUSTN-0004Fo-P5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUSTJ-00052w-Nk
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795195943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fElqSp1vAUcgSjEpNDOQ/dOrEPJcPZHYi33A71fhB6A=;
 b=Nk6zr9ocl2eybPNaQ58RI6JcbsfE/0VL6WkBEqkJmsfoyGPqw5cp1SWa8am0QPOYS+Q26Y
 h7TAiaApWwTCLNQpeeIuCAz8ivXW4vuUxWIWq5mAq5WrLIFGsqirAe36SWuVmpy4vYzVC9
 I9xckHaeZHtfSkJDWVPL15imqJkZ7dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-5p69pvlWO7qGK4_JrnC1Rg-1; Fri,
 20 Nov 2026 17:32:18 +0000
X-MC-Unique: 5p69pvlWO7qGK4_JrnC1Rg-1
X-Mimecast-MFC-AGG-ID: 5p69pvlWO7qGK4_JrnC1Rg_1795195936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 768AB18011CC; Fri, 20 Nov 2026 17:32:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83ABD1956049; Fri, 20 Nov 2026 17:32:14 +0000 (UTC)
Date: Fri, 20 Nov 2026 18:32:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH for-11.2 0/2] block/qcow2: Avoid crash in qemu-img amend
 when reftable is empty
Message-ID: <awCEHC5U3sy1B0CN@redhat.com>
References: <20261119140338.2918386-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119140338.2918386-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.2026 um 15:03 hat Peter Maydell geschrieben:
> In a QCOW2 image, the header is always cluster zero, and so that
> cluster must have a non-zero refcount.  This means that an image where
> the first entry in the refcount table is zero, or where it points to a
> refblock which is empty, must be corrupt.
> 
> In the "qemu-img amend -o refcount_bits=..." codepath, we were
> implicitly relying on the image not being corrupted in this way.  If
> the entire refcount table was zero, our "walk the table to see how big
> the new reftable size is" loop would say "zero", and we would then not
> allocate any memory for s->refcount_table, and
> update_max_refcount_table_index() would underflow when calculating
> s->refcount_table_size - 1 and then crash.
> 
> This patchset fixes that bug, and adds a test case for it.
> 
> It would also be possible to refuse to open an image for some of the
> more obvious cases of this corruption (e.g. "on open,
> refcount_table[0] is 0"), but checking the actual refcount of cluster
> 0 is a bit trickier as we only read in that refblock on demand. Plus
> some of the existing iotests (060, 098) rely on corrupted images of
> that kind only being detected later.  So I have stuck to fixing the
> immediate bug.
> 
> NB: this isn't a security issue because the crash can only be
> provoked for this specific qemu-img amend codepath, so it's a
> self-DoS.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>   block/qcow2: Detect corrupt images where first refcount block is empty
>   tests/qemu-iotest: Add test for qcow2 image with empty reftable

Thanks, applied to the block branch.

Kevin


