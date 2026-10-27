Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtuGhn94
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmb8-0006je-RA; Tue, 27 Oct 2026 15:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLmb7-0006iB-8m
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLmb5-0000rw-6k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793128353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIwG66A/6gWapUL/+NY/bVexNO0HZJb2n+kex1xv1do=;
 b=gtuGhn947yNo/wuqIa4hhCJJFush/y1iIu9Y72lDdC10rO0kos/dD3cmsdb5Gt5EEQ92TP
 5mB9LblBxsKJ8I8ZemJM4pVmwgwbXJEX9lC5HTLN2o2sqkQHzeFIFDboPKxWJXx66lQkVA
 JoWFGPxTKS6HRvuJ61Ms3e9NdwuDTz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-l3eAGWQ0NialdtQjdPIlcQ-1; Tue,
 27 Oct 2026 15:12:29 -0400
X-MC-Unique: l3eAGWQ0NialdtQjdPIlcQ-1
X-Mimecast-MFC-AGG-ID: l3eAGWQ0NialdtQjdPIlcQ_1793128347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B8B61800BEC; Tue, 27 Oct 2026 19:12:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 328AA1800257; Tue, 27 Oct 2026 19:12:24 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:12:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Gomez <da.gomez@kernel.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
Message-ID: <20261027191223.GA933537@shajnocz.csb>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <20261026-align-nvme-mdts-with-linux-v3-4-a33bd7c32df9@samsung.com>
 <20261026201126.GD629414@shajnocz.csb>
 <at-1FYnLI6_MUWiX@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at-1FYnLI6_MUWiX@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:16:21PM -0600, Keith Busch wrote:
> On Mon, Oct 26, 2026 at 04:11:26PM -0400, Stefan Hajnoczi wrote:
> > What happens when two large writes to the same sector run concurrently?
> > Before, the result was either write A or write B. Now it's possible to
> > get an interleaving of write A and B's data. 
> 
> That result is consistent with the storage hardware specs, too.

I double-checked the SCSI SBC spec and you're right.

> 
> > I think this violates block device semantics and corrupts data. A
> > serialization mechanism is needed if you want to do this.
> 
> Seems like overkill and you still don't get a deterministic outcome: you
> get either A or B, but you the host doesn't know which. If you need
> deterministic data, then the onus is usually on the host side to not
> send overlapping writes.

Yes, QEMU only needs to implement the hardware semantics and doing more
here is not necessary.

Stefan


