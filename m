Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67450CAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ks6-0005n9-2G; Wed, 24 Sep 2025 04:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v1Ks2-0005l2-HX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v1Krv-0005Or-E0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758702534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qPpQ8yoMPPLG2xx9wdIYSUU76pjXAmLIwF4KciPl55A=;
 b=fyaGrvpke11T9lmZQxyC0vfBIr/P4iz3e3wQIVsrvivOTgHSVV9GVTaUKAMnQKl4n7G2PI
 +juYNdMatpfb7SNHjTdjFbYr/V/cJrZ+uVmlSUplF7SBsIPi7mb/CczabP2WTCD7OZvBJq
 SwYKSdKktzd9w5C4o3WjTrweLicD8PM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-G8l7j7OuMVyExCwaA9N8SQ-1; Wed,
 24 Sep 2025 04:28:50 -0400
X-MC-Unique: G8l7j7OuMVyExCwaA9N8SQ-1
X-Mimecast-MFC-AGG-ID: G8l7j7OuMVyExCwaA9N8SQ_1758702529
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFDCF1956050; Wed, 24 Sep 2025 08:28:49 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E1119560BB; Wed, 24 Sep 2025 08:28:47 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:28:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] qemu-img info: Optionally show block limits
Message-ID: <aNOrvWSQMlNMH6q3@redhat.com>
References: <20250923163735.378254-1-kwolf@redhat.com>
 <20250923163735.378254-3-kwolf@redhat.com>
 <xsupfh7ch565s7tmiq5r4u7zwc2nui7grdrt4dliqodaujvn5z@d3u7as7xqwhx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xsupfh7ch565s7tmiq5r4u7zwc2nui7grdrt4dliqodaujvn5z@d3u7as7xqwhx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.09.2025 um 20:09 hat Eric Blake geschrieben:
> On Tue, Sep 23, 2025 at 06:37:35PM +0200, Kevin Wolf wrote:
> > Add a new --limits option to 'qemu-img info' that displays the block
> > limits for the image and all of its children, making the information
> > more accessible for human users than in QMP. This option is not enabled
> > by default because it can be a lot of output that isn't usually relevant
> > if you're not specifically trying to diagnose some I/O problem.
> > 
> > This makes the same information automatically also available in HMP
> > 'info block -v'.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  docs/tools/qemu-img.rst |  6 +++++-
> >  include/block/qapi.h    |  2 +-
> >  block/qapi.c            | 34 ++++++++++++++++++++++++++++++++--
> >  qemu-img.c              | 15 ++++++++++++---
> >  qemu-img-cmds.hx        |  4 ++--
> >  5 files changed, 52 insertions(+), 9 deletions(-)
> > 
> 
> > +++ b/qemu-img.c
> 
> > @@ -3119,6 +3123,8 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
> >  "     display information about the backing chain for copy-on-write overlays\n"
> >  "  -U, --force-share\n"
> >  "     open image in shared mode for concurrent access\n"
> > +"  --limits\n"
> > +"     show detected block limits (may depend on options, e.g. cache mode)\n"
> 
> I'm trying to figure out how the parenthetical helps the --help
> message.  The fact that it is detected limits already implies that
> anything else (like cache mode) that can change what gets detected
> would have an impact.  So I think it would be fine to just use " show
> detected block limits\n".

Yes, other options can influence the limits, too. I just thought that
the most common pitfall for users will be that they actually want to
know the limits for cache=none because that's what their VM uses, but
'qemu-img info' returns them for cache=writeback. So it felt helpful to
add the note. But if you think that we'd better leave it out, I can
remove it.

Actually, this reminds me that I wanted to add a -t <cache_mode> option
to 'qemu-img info', too, so that you can actually get the interesting
information without using --image-opts. That will be something for a
separate patch, though.

Kevin


