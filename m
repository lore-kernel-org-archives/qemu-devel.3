Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3600606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ff9Hm2ZL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkmd-00063a-4p; Fri, 30 Oct 2026 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkmb-00062p-5B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMkmZ-0003EA-Rp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793359707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vDvmddJueHz5MyIsnfJv6AIJjlqnobf/0W6bEp47B0=;
 b=Ff9Hm2ZLjtI6XipEiDt6Duc5r9uUgzY7qMx8tmbRmCKlMn/igiRVwfwIQkYSOtztVaIbgG
 G0mSIiimao/SutVdHZq7DJ+N6fU0crGcshefGyN+1bFY/Kq5ixplZdzcKgwdkwFr0vonSR
 dTwmIdqoXIdm0NseH/8qqmhXtjoWdoM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-HOLkOVbENT-QJ-B7QmC08Q-1; Fri,
 30 Oct 2026 07:28:23 -0400
X-MC-Unique: HOLkOVbENT-QJ-B7QmC08Q-1
X-Mimecast-MFC-AGG-ID: HOLkOVbENT-QJ-B7QmC08Q_1793359703
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 887471955D97; Fri, 30 Oct 2026 11:28:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C07926C; Fri, 30 Oct 2026 11:28:20 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:28:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block: fix leak of block histogram data
Message-ID: <auR_UmSm3nRM_07u@redhat.com>
References: <20261012114400.206772-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012114400.206772-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.10.2026 um 13:43 hat Daniel P. Berrangé geschrieben:
> The block_acct_cleanup method failed to release memory associated
> with block histograms.
> 
> Fixes: b741ae7417 (block/accounting: introduce latency histogram)
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block/accounting.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/accounting.c b/block/accounting.c
> index 038af370170..40ed70782b4 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -80,6 +80,13 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
>  void block_acct_cleanup(BlockAcctStats *stats)
>  {
>      BlockAcctTimedStats *s, *next;
> +    size_t i;
> +    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
> +        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
> +        g_free(hist->bins);
> +        g_free(hist->boundaries);
> +    }
> +

This seems to duplicate block_latency_histograms_clear(). Should we just
call it here?

Kevin


