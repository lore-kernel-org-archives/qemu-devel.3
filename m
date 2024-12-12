Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDDE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 10:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLgRQ-00087O-7V; Thu, 12 Dec 2024 05:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tLgRO-00085w-If
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tLgRM-0008EX-Qs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733999341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UVWFK8+giHWHC5O8eXA/GmAqNahAI8HMKXjLKWZDSI=;
 b=MSEWgm9kG9Yfroucv9SwHp954QvB0o2ehWeg4G54D0T4cfs8mEmIfLWplBA0brBm88dJf9
 SHUVAbP5PxXRGB1p9WzkqMpAh7Dk+H/6WL8mMyJgIFcdSpY95vaQmEge5MnfWudbNymS1Z
 +mUn3PPqV+ksGtfFiZdlk5bX8hilEJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-0EULsf3QNH-qzYVBLFO88g-1; Thu,
 12 Dec 2024 05:28:58 -0500
X-MC-Unique: 0EULsf3QNH-qzYVBLFO88g-1
X-Mimecast-MFC-AGG-ID: 0EULsf3QNH-qzYVBLFO88g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 783581955F45; Thu, 12 Dec 2024 10:28:57 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1087C1955F41; Thu, 12 Dec 2024 10:28:54 +0000 (UTC)
Date: Thu, 12 Dec 2024 11:28:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, s_sourceforge@nedprod.com
Subject: Re: [PATCH 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
Message-ID: <Z1q65CpTxqRtMes_@redhat.com>
References: <20241211201739.1380222-1-peterx@redhat.com>
 <87pllyezmh.fsf@suse.de> <Z1oGrWlUaB5O3n5X@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1oGrWlUaB5O3n5X@x1n>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 11.12.2024 um 22:39 hat Peter Xu geschrieben:
> On Wed, Dec 11, 2024 at 05:25:10PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > Coroutines are used in many cases in block layers. It's also used in live
> > > migration when on destination side, and it'll be handy to diagnose crashes
> > > within a coroutine when we want to also know what other coroutines are
> > > doing.
> > 
> > Not sure if you've seen this message on the list:
> > 
> > https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net

Let me add Niall to this thread.

> No I didn't.  I only started looking at this because I got a bug a few days
> ago that I need to look at the main coroutine where dest crashed, then
> Stefan told me this script and also told me it only works with live session.
> Ideally I'll need coredump debug-ability, then I figured it isn't too hard.

I agree this is useful at least in the current state of things, and
possibly in the future for QEMUs built without support for new gdb
magic.

> I saw that it didn't yet land gdb, and it's much more involved even if it
> could be more generic.  Not sure how the block developers think, personally
> I prefer this much smaller change because it works on old systems, where I
> can easily install gdb with package managers.

I don't think this is a question of preferring one or the other! Your
simple change works today with existing QEMU builds and has fewer
requirements, but it's also more limited in functionality.

The gdb changes look really nice at the first sight, debugging
coroutines as if they were threads is exactly what you want in most
cases. So I'd love to see this. Of course, someone would have to first
understand what needs to be done in detail and then implement the QEMU
side of it once the gdb side is merged.

Kevin


