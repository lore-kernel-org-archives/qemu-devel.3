Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4717606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ODZOcqoX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1XY-000154-ME; Thu, 19 Nov 2026 07:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xU1XT-000149-WA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xU1XR-0005CL-RT
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795092412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NswvIrfxCltBvcWTz79Drx/XQHk0NSefOifBPnJABSg=;
 b=ODZOcqoXtHRj+wInYuXSUQuIQSlOC02YG0ylNDJVrh2YIGe0OK2V9kGexc+WBNeEYUjfgi
 tT5C6QXgYg6/1ssOKEzaCVEFiwLJgzAWEVkfswCziQWKK9Mn3rZ7y+sboKugDYn1Q2HfNO
 QUyZxgt5W+/w+ab1BKgC6NC303cpSnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Jh34J3F1NRuS2F1JAZ--6w-1; Thu,
 19 Nov 2026 07:46:49 -0500
X-MC-Unique: Jh34J3F1NRuS2F1JAZ--6w-1
X-Mimecast-MFC-AGG-ID: Jh34J3F1NRuS2F1JAZ--6w_1795092408
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DFA91800266; Thu, 19 Nov 2026 12:46:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A671C180055C; Thu, 19 Nov 2026 12:46:46 +0000 (UTC)
Date: Thu, 19 Nov 2026 07:46:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Maguire <jmaguire2013@gmail.com>, f.ebner@proxmox.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, t.lamprecht@proxmox.com
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20261119124645.GA2775795@shajnocz.csb>
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
 <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
 <20261118185617.GA670091@shajnocz.csb>
 <962d44d3-ca7b-4cc8-b0f7-77fb8d63cf41@kernel.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962d44d3-ca7b-4cc8-b0f7-77fb8d63cf41@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 12:51:21PM -0700, Jens Axboe wrote:
> On 11/18/26 11:56 AM, Stefan Hajnoczi wrote:
> > On Wed, Nov 18, 2026 at 08:58:11AM -0700, Jens Axboe wrote:
> >> On 11/15/26 4:05 PM, John Maguire wrote:
> >>> On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
> > Pushing the responsibility of deciding what counts as iowait to
> > userspace via IORING_FEAT_NO_IOWAIT means the decision is duplicated in
> > every application that uses io_uring. That only makes sense to me if
> > accounting should work differently on a per-application basis and
> > applications therefore need full control. I'm not aware of applications
> > actually wanting to do that? Or is iowait fundamentally incompatible
> > with io_uring so that applications are the only ones who can decide?
> 
> iowait is fundamentally incompatible with sane accounting in the first
> place, that is the problem. It really tells you nothing, and was
> deprecated since the days of uniprocessor systems. The problem here is
> not how iowait is done in the kernel, it's that people are using this
> metric in the first place. Which is why you just want to NOT do that,
> and do sane accounting on your disk drives, if you care about that kind
> of thing.
> 
> Which is why I refuse to cater to any kind of iowait accounting metrics,
> it's just adding overhead to support a metric that is largely
> nonsensical in the first place. It doesn't answer any questions that an
> application/tier owner would want to know. Those questions might be
> things like "am I I/O bound?" or "is the device I'm using being slow?".
> I wish people would realize that, rather than continue to place value in
> iowait as a metric for ANYTHING, and stop trying to work around it.

Okay.

Stefan


