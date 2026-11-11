Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC43606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AT1zG055
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRF0Q-0003U1-7k; Wed, 11 Nov 2026 15:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRF06-0003SS-Ke
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRF04-0002ta-Se
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794429176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Nn5PKezC60mpmb4sWR2PgSRQ77ntVcUvzWbphhoHTU=;
 b=AT1zG055MHqxIML9RcARs04RAEpbqT5pRW+49LVW4TAHnFYRH8X9vZh1aNPq9mCGzyS9G8
 NuFRV3k2ZghDWqAFf4AKddqjAbwfgNyhzPuqPENrQBpfEk+ph/PzRzOfBOoi0LC2XjhMmz
 iCn5b2LU1iZ1WaFCCs//1SNHoUX2Qnc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-WO3LBcISN-mUZ8dKZPr6qw-1; Wed,
 11 Nov 2026 15:32:52 -0500
X-MC-Unique: WO3LBcISN-mUZ8dKZPr6qw-1
X-Mimecast-MFC-AGG-ID: WO3LBcISN-mUZ8dKZPr6qw_1794429171
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1C8D180060C; Wed, 11 Nov 2026 20:32:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E7FF1800543; Wed, 11 Nov 2026 20:32:49 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:32:46 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/vhdx: Add alignment checks for region tables
Message-ID: <avTQnxm1bMJ6WbDQ@redhat.com>
References: <20261111161442.329763-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111161442.329763-1-thuth@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 05:14:42PM +0100, Thomas Huth wrote:
> According to the VHDX specification:
> 
>  "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
>   byte length of the object within the file. The values must be a multiple of
>   1 MB, and FileOffset must be at least 1 MB."
> 
> Thus let's add a sanity check to avoid that bad things could happen later.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
> Reported-by: Daniel Wade <danjwade95@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vhdx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 8013a90a1a4..f5beace56f5 100644
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
> +        if ((rt_entry.file_offset & (MiB - 1)) ||
> +            (rt_entry.length & (MiB - 1)) || rt_entry.length < MiB) {

Would QEMU_IS_ALIGNED() be better than open-coding the math here?
Also, the 'rt_entry.length < MiB' clause could be simplified to
'rt_entry.length == 0', since all other values less than MiB fail the
earlier alignment clause.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


