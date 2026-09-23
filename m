Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD3C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OJD-0007XA-Lr; Wed, 23 Sep 2026 10:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9OIj-0007Ef-N8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9OIg-0001M6-G3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790175011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f97IEyRjAnLvn6hoLL6tqGRvTg2c/nkT5NL2mKTwvk=;
 b=aTYl1FRDt8DKAeyhKAJ1zJp3F8PQVgRvr7zNdB8GdC8QEbYME7G2EOVe92Oo8lHA8sw3Fk
 MTDdYb9H/k9pM40+mvVjwROR2Mi9vZN6UNrEh+XCTpE3sQcHUdv5V2CEaW4mUEBHa5KpIr
 uaqj6gj/8IJneCaZ9A1ZoqUh4sz4Q54=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-4IwIAShxMRet9A5fbOVHCg-1; Wed,
 23 Sep 2026 10:50:07 -0400
X-MC-Unique: 4IwIAShxMRet9A5fbOVHCg-1
X-Mimecast-MFC-AGG-ID: 4IwIAShxMRet9A5fbOVHCg_1790175006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3572B180ACCE; Wed, 23 Sep 2026 14:50:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840AF195604B; Wed, 23 Sep 2026 14:50:03 +0000 (UTC)
Date: Wed, 23 Sep 2026 16:50:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <arPnGOoK2CvIR5Sq@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora>
 <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.09.2026 um 12:48 hat Hanna Czenczek geschrieben:
> > > > When an I/O request hangs for a long time, the management tool will be
> > > > unable to detect that the threshold has been exceeded in a timely
> > > > manner.
> > > Yes. But why would that be a real problem?
> > > 
> > > Given the request so far is only to notify users of their storage block
> > > showing problematic latencies at all, there is no need to provide the alerts
> > > in actual real time.
> > What does the current approach solve that is not already possible with
> > the block latency histogram?
> 
> See what I linked above. Apparently having to repeatedly query the histogram
> repeatedly is not deemed nice enough.

It's the difference between an event and active polling. I would agree
that active polling isn't the right answer in most cases.

Kevin


