Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A66606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LyE2O3Qz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWEk-0005xl-Vi; Fri, 20 Nov 2026 16:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUWEh-0005xB-Jc
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUWEf-00032I-OG
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795210412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mc3w1/0nmC1wVcZpGJQLb7IU0H/4fLeNFsO9TUOqRyo=;
 b=LyE2O3Qz2riEE0p0bTUYATGz+uLzNwDqdx+cPEoDER56UmXvAIAIj/9Q7RwapFd6K6lB4U
 /zdq+VZGiMeWsam6kVGpKjOV/eDrWcMIwc2AoHRNUrDRA+xIlm2ogZEqli4WWO15MWF6aH
 xkJgIVwNQKgXvLTG5BETEqgIV1tzQo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-55J6EoKbNW2Tj7MYkkTGWg-1; Fri,
 20 Nov 2026 21:33:30 +0000
X-MC-Unique: 55J6EoKbNW2Tj7MYkkTGWg-1
X-Mimecast-MFC-AGG-ID: 55J6EoKbNW2Tj7MYkkTGWg_1795210409
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4261800545; Fri, 20 Nov 2026 21:33:29 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C1341956088; Fri, 20 Nov 2026 21:33:27 +0000 (UTC)
Date: Fri, 20 Nov 2026 15:33:24 -0600
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com
Subject: Re: [PATCH v3 0/2] block/mirror: fix assertion failure upon
 duplicate complete for job using 'replaces'
Message-ID: <awC8Z36NE0t7ZUwY@redhat.com>
References: <20260325111140.347421-1-f.ebner@proxmox.com>
 <1edb7531-1294-486c-bbd4-bea0f74e08ae@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edb7531-1294-486c-bbd4-bea0f74e08ae@proxmox.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Jun 10, 2026 at 12:35:02PM +0200, Fiona Ebner wrote:
> Ping

Crawling through older mails in my inbox. I don't think this series
was applied at the time; is is still worth having? If so, I'll add it
to my NBD queue for 12.0.

> 
> Am 25.03.26 um 12:11 PM schrieb Fiona Ebner:
> > Changes in v3:
> > * In the first test, avoid testing that all requests complete in a
> >   given time. This is prone to flakiness. Instead, complete the job
> >   under throttle.
> > 
> > Changes in v2:
> > * Drop already applied patch, only the tests remain to be added.
> > * Use throttle limits and issue requests in a way, that actually makes
> >   throttling take effect.
> > * Use a second VM instance for the NBD export target rather than
> >   qemu-storage-daemon, since qtest is needed for stepping the clock.
> > 
> > Fiona Ebner (2):
> >   iotests/041: add test for mirror with throttled NBD export as target
> >   iotests/041: add test for duplicate job-complete with throttled target
> > 
> >  tests/qemu-iotests/041     | 177 +++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/041.out |   4 +-
> >  2 files changed, 179 insertions(+), 2 deletions(-)
> > 
> 
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


