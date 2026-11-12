Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GsICYibV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUFT-0000U1-1u; Thu, 12 Nov 2026 07:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUFP-0000TC-A0
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUFN-0000Ep-HZ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794487777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KsOwVVEF6XL+PxTrAUIx+7C2haN8MDl3n2mnSDG+piI=;
 b=GsICYibVqiBbj7xmjPwzwZySJJ88kcgU3Zml825mfF6MfNYB/AFXFAQWEncMPX33MBx9tn
 Rjzx1J7lpMD5EdOaPWulKyEVrH7k4QerggIW/5/tUv3imLrOR1etiG8JCDz4dbjeZLjVQl
 LOuhuZDRDzlq+bI/fRKGNhpmaFIe+Z0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-STqH7ZjCNgK0zHBzP4IpwQ-1; Thu,
 12 Nov 2026 07:49:36 -0500
X-MC-Unique: STqH7ZjCNgK0zHBzP4IpwQ-1
X-Mimecast-MFC-AGG-ID: STqH7ZjCNgK0zHBzP4IpwQ_1794487775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A3F31954237; Thu, 12 Nov 2026 12:49:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F29151956086; Thu, 12 Nov 2026 12:49:32 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:49:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] block/vhdx: Add alignment checks for region tables
Message-ID: <avW12msUi9dongBJ@redhat.com>
References: <20261112092201.74651-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112092201.74651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.11.2026 um 10:22 hat Thomas Huth geschrieben:
> According to the VHDX specification:
> 
>  "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
>   byte length of the object within the file. The values must be a multiple of
>   1 MB, and FileOffset must be at least 1 MB."

This requires that the offset (not length) is at least 1 MB...

> Thus let's add a sanity check to avoid that bad things could happen later.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
> Reported-by: Daniel Wade <danjwade95@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use QEMU_IS_ALIGNED() as suggested by Eric
> 
>  block/vhdx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 8013a90a1a4..21270988b5a 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -566,6 +566,16 @@ vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
>  
>          vhdx_region_entry_le_import(&rt_entry);
>  
> +        /*
> +         * According to the VHDX spec, offset and length must be multiple
> +         * of 1 MiB and length must be at least 1 MiB.
> +         */
> +        if (!QEMU_IS_ALIGNED(rt_entry.file_offset, MiB) ||
> +            !QEMU_IS_ALIGNED(rt_entry.length, MiB) || !rt_entry.length) {

...but the comment and code do the opposite and check only that the
length is at least 1 MB, leaving FileOffset (which was the actual
requirement) unchecked.

>
> +            ret = -EINVAL;
> +            goto fail;
> +        }
> +
>          /* check for region overlap between these entries, and any
>           * other memory regions in the file */
>          ret = vhdx_region_check(s, rt_entry.file_offset, rt_entry.length);

I'm also wondering if the check shouldn't be in vhdx_region_check()
instead, which we're already calling here.

Kevin


