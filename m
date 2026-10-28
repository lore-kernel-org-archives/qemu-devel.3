Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59986606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hfpz1mBC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4Wd-0002I7-VJ; Wed, 28 Oct 2026 10:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM4Wa-0002Ep-An
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM4WY-0003NB-C3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793197264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32PlixOOU21kAZg/ZLuCIC9+XzCl2FK9R5+FHHF6vdk=;
 b=hfpz1mBCB0WvozjIfBYb7GT7sdcojUfY1QKALQY2ebkcCPA6ZrbkZ0dyXhi84qtG0zqp4r
 7M2nu+Xr4DJiKGFGCltgJNpQwuQ6HFIR5IXKXkWiI0ijNZnXOpTIlgMfkz9tVBolMQM2ln
 Ix8S9XMCy1A7cqiRFvMQgnUKihTKJTE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-iiNr8A6QN0GV9XwHMlEkWg-1; Wed,
 28 Oct 2026 10:21:02 -0400
X-MC-Unique: iiNr8A6QN0GV9XwHMlEkWg-1
X-Mimecast-MFC-AGG-ID: iiNr8A6QN0GV9XwHMlEkWg_1793197261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0925A18021EB; Wed, 28 Oct 2026 14:21:01 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A340A18002B1; Wed, 28 Oct 2026 14:20:58 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:20:56 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v3 0/9] block: cheaper zero handling in backup and commit
Message-ID: <auIEdrOAXTdGM-TM@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <127bf797-defd-46bf-9aa2-063f15152cfc@virtuozzo.com>
 <asQeay3yVze-ELxa@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asQeay3yVze-ELxa@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 05:04:22PM -0500, Eric Blake wrote:
> On Mon, Oct 05, 2026 at 10:59:11AM +0200, Denis V. Lunev wrote:
> > On 9/29/26 17:51, Denis V. Lunev wrote:
> > > This email originated from an IP that might not be authorized by the domain it was sent from.
> > > Do not click links or open attachments unless it is an email you expected to receive.
> > > Backup and commit re-query the source block status for every task and
> > > size a task by the copy buffer, so a long run of zeroes turns into a
> > > crowd of small write-zeroes requests. This series reuses what the
> > > up-front scan already learned and lets one write-zeroes task cover a
> > > whole run.
> > >
> > > Backup of a 16G qcow2 image holding 1G of data, the rest never
> > > allocated, sync=full to a raw target on ext4:
> > >
> > >                tasks    time
> > >     before     16384    1.6s
> > >     after       1088    1.0s
> > >
> > > Such an image is the normal case rather than a corner one: a guest with
> > > discard enabled on a disk which is mostly free leaves exactly this
> > > shape behind.
> 
> > ping
> 
> It looks like this series is fully reviewed; I also took a look at it
> and didn't spot anything to add. I plan on queueing into a pull
> request shortly.

After I posted this, Vladimir mentioned some possible changes. Should
I do a pull request with this series as-is, or should I wait for a v4
and/or followup patches?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


