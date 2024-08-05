Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDC2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 19:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb37T-0000bg-Kr; Mon, 05 Aug 2024 15:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sb37Q-0000b8-AT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 15:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sb37N-00070y-Rh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 15:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722885096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NmpwurY+z2jdD7QxEAs+TkKoZjjq7/n++wmhSjJ0V9k=;
 b=KhNsMCqNebGhZ+JR71x72FrqEOjlKxT+yrbgsWpbu3u0wJ5kuLgQIdaNvRmeOmSeOFA4Xw
 IDJUb2Dfk0oGdcHm/2SJb/5EwoY2H2oYxig52UoOvZ85WlQmReJtanz6mBipxYfijfx6Cd
 zKc5Ox95V3ya0q9km3VSHusQIhuwhDI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-VejAoECSOGaRXE1XrE-1yA-1; Mon,
 05 Aug 2024 15:11:35 -0400
X-MC-Unique: VejAoECSOGaRXE1XrE-1yA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97B391955D56; Mon,  5 Aug 2024 19:11:33 +0000 (UTC)
Received: from localhost (unknown [10.42.28.4])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3838C1955D45; Mon,  5 Aug 2024 19:11:32 +0000 (UTC)
Date: Mon, 5 Aug 2024 20:11:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH for-9.1 0/2] NBD: don't print raw server error text to
 terminal
Message-ID: <20240805191131.GE1450@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <dkp3je5pohqlrxqrbzwd7maxgljr4gknhlmorae6ihi3vx2t4u@z3vvc5ml7vwj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dkp3je5pohqlrxqrbzwd7maxgljr4gknhlmorae6ihi3vx2t4u@z3vvc5ml7vwj>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 05, 2024 at 01:48:12PM -0500, Eric Blake wrote:
> On Fri, Aug 02, 2024 at 02:26:04PM GMT, Eric Blake wrote:
> > I've requested a CVE from Red Hat, and hope to have an assigned number
> > soon.  Meanwhile, we can get review started, to make sure this is
> > ready to include in 9.1.  'qemu-img info' should never print untrusted
> > data in a way that might take over a user's terminal.
> > 
> > There are probably other spots where qemu-img info is printing
> > untrusted data (such as filenames), where we probably ought to use the
> > same sanitization tactics as shown here.  Identifying those spots
> > would be a useful part of this review, and may mean a v2 that is even
> > more extensive in the number of patches.
> 
> In fact, should we insist that 'qemu-img info XXX' refuse to accept
> any control characters on any command-line filename, and that it
> reject any backing file name with control characters as a malformed
> qcow2 file?  For reference, we JUST fixed qemu-img info to change
> qcow2 files with a claimed backing file of json:... to favor the local
> file ./json:... over the potentially dangerous user-controlled
> format/protocol description, so we are _already_ changing how strict
> qemu-img is for 9.1, and adding one more restriction to avoid
> escape-sequence madness makes sense.
> 
> Note that with:
> 
> touch $'\e[m' && qemu-img info --output=json $'\e[m'
> 
> we already escape our output, but without --output=json, we are
> vulnerable to user-controlled ESC leaking through to stdout for more
> than just the NBD server errors that I addressed in v1 of this patch
> series.  Hence my question on whether v2 of the series should touch
> more places in the code, and whether doing something like flat-out
> refusing users stupid enough to embed control characters in their
> filenames is a safe change this close to release.

You could say if someone gives you a "malicious" text file which you
cat to stdout, it could change your terminal settings.  I don't think
therefore any of this is very serious.  We should probably fix any
obvious things, but it doesn't need to happen right before 9.1 is
released, we can take our time.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


