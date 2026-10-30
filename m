Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uo9NAvbP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMksX-0007LN-Ja; Fri, 30 Oct 2026 07:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMksW-0007LA-Gs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMksU-0003yW-QA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793360074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PA7QgeyqO3bIRNByJCyKedWVJFy5AFQnlmIm7X/wLY=;
 b=Uo9NAvbP6fGeQLjDQSceVdg7WXEsyaswecevJFic/7Aq0p4NeHQY4geEpuC/+4DChdv8RC
 omjkigYLj4Umx1ktI/M3n6gu/1xBkoD5Oy4cvp8aT+lPHjQrt5n2ZGRb0SOFyOMad1F7nL
 uyNADLNbH8buEXZ5r9CsQJMoM4qRK7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-Y7MVBkTwNomV0-k0C3oFVg-1; Fri,
 30 Oct 2026 07:34:32 -0400
X-MC-Unique: Y7MVBkTwNomV0-k0C3oFVg-1
X-Mimecast-MFC-AGG-ID: Y7MVBkTwNomV0-k0C3oFVg_1793360071
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D1E180061E; Fri, 30 Oct 2026 11:34:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3031D1800444; Fri, 30 Oct 2026 11:34:30 +0000 (UTC)
Date: Fri, 30 Oct 2026 11:34:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block: fix leak of block histogram data
Message-ID: <auSAw9AeacgMmTUj@redhat.com>
References: <20261012114400.206772-1-berrange@redhat.com>
 <auR_UmSm3nRM_07u@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auR_UmSm3nRM_07u@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:28:18PM +0100, Kevin Wolf wrote:
> Am 12.10.2026 um 13:43 hat Daniel P. Berrangé geschrieben:
> > The block_acct_cleanup method failed to release memory associated
> > with block histograms.
> > 
> > Fixes: b741ae7417 (block/accounting: introduce latency histogram)
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/accounting.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/block/accounting.c b/block/accounting.c
> > index 038af370170..40ed70782b4 100644
> > --- a/block/accounting.c
> > +++ b/block/accounting.c
> > @@ -80,6 +80,13 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
> >  void block_acct_cleanup(BlockAcctStats *stats)
> >  {
> >      BlockAcctTimedStats *s, *next;
> > +    size_t i;
> > +    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
> > +        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
> > +        g_free(hist->bins);
> > +        g_free(hist->boundaries);
> > +    }
> > +
> 
> This seems to duplicate block_latency_histograms_clear(). Should we just
> call it here?

Yes, that sounds sensible, I'll repost.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


