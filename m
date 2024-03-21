Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5C7C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 12:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnHQn-0004Jm-RK; Thu, 21 Mar 2024 08:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rnHQm-0004JL-6i
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rnHQk-0000ef-IU
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711023715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6se4CDp8h70BmZ1U6kGDLvwRISNEpWizbtokJPzYwsk=;
 b=iOVgifyl6AvO5vGHjJqCL/tzjrLeRe8KU1OdyUj/0e2C9FykYx8QFoUyHBWH2CAU0Eu1S6
 kgSc3674qV4vT3QMLjJDPhH06rbTBaA1AHmVd/mslYWifmdVCRSZucgsBWh/6BfET5gSXZ
 3IAgzRUyeiOjGox/pWqrQ+DS5EKaIv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-FBj7t3QnNLO6JM3KUp79ZQ-1; Thu, 21 Mar 2024 08:21:53 -0400
X-MC-Unique: FBj7t3QnNLO6JM3KUp79ZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 430388007AD
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:21:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0774C2166B4F;
 Thu, 21 Mar 2024 12:21:51 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:21:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfwmWmwI_ApQSdNi@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com> <20240319175510.GA1127203@fedora>
 <ZfnxSd4lseZuWoQ5@redhat.com> <20240320133539.GA1190824@fedora>
 <ZfruHHh9tEr-1zI6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfruHHh9tEr-1zI6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 20.03.2024 um 15:09 hat Daniel P. Berrangé geschrieben:
> On Wed, Mar 20, 2024 at 09:35:39AM -0400, Stefan Hajnoczi wrote:
> > On Tue, Mar 19, 2024 at 08:10:49PM +0000, Daniel P. Berrangé wrote:
> > > On Tue, Mar 19, 2024 at 01:55:10PM -0400, Stefan Hajnoczi wrote:
> > > > On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrangé wrote:
> > > > > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > > > > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > > > > index 5fd2dbaf8b..2790959eaf 100644
> > > > > > --- a/util/qemu-coroutine.c
> > > > > > +++ b/util/qemu-coroutine.c
> > > > > 
> > > > > > +static unsigned int get_global_pool_hard_max_size(void)
> > > > > > +{
> > > > > > +#ifdef __linux__
> > > > > > +    g_autofree char *contents = NULL;
> > > > > > +    int max_map_count;
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Linux processes can have up to max_map_count virtual memory areas
> > > > > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> > > > > > +     * must limit the coroutine pool to a safe size to avoid running out of
> > > > > > +     * VMAs.
> > > > > > +     */
> > > > > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> > > > > > +                            NULL) &&
> > > > > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> > > > > > +        /*
> > > > > > +         * This is a conservative upper bound that avoids exceeding
> > > > > > +         * max_map_count. Leave half for non-coroutine users like library
> > > > > > +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> > > > > > +         * halve the amount again.
> > > 
> > > Leaving half for loaded libraries, etc is quite conservative
> > > if max_map_count is the small-ish 64k default.
> > > 
> > > That reservation could perhaps a fixed number like 5,000 ?
> > 
> > While I don't want QEMU to abort, once this heuristic is in the code it
> > will be scary to make it more optimistic and we may never change it. So
> > now is the best time to try 5,000.
> > 
> > I'll send a follow-up patch that reserves 5,000 mappings. If that turns
> > out to be too optimistic we can increase the reservation.
> 
> BTW, I suggested 5,000, because I looked at a few QEM processes I have
> running on Fedora and saw just under 1,000 lines in /proc/$PID/maps,
> of which only a subset is library mappings. So multiplying that x5 felt
> like a fairly generous overhead for more complex build configurations.

On my system, the boring desktop VM with no special hardware or other
advanced configuration takes ~1500 mappings, most of which are
libraries. I'm not concerned about the library mappings, it's unlikely
that we'll double the number of libraries soon.

But I'm not sure about dynamic mappings outside of coroutines, maybe
when enabling features my simple desktop VM doesn't even use at all. If
we're sure that nothing else uses any number worth mentioning, fine with
me. But I couldn't tell.

Staying the area we know reasonably well, how many libblkio bounce
buffers could be in use at the same time? I think each one is an
individual mmap(), right?

Kevin


