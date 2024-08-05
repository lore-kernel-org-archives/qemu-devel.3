Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02B9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb2l2-00028R-Pk; Mon, 05 Aug 2024 14:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb2kr-00027G-JF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb2kp-0003j4-AW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722883700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EutI4nq971z0jsL6uFk5/bEEy0f/g8+Ra6cwZ2H0UCM=;
 b=R7dQ/fdM9fJNEL/JpvRykgWax68mB3h/9xxL2kbOh9Ux2MYgWJS9bmwq2uj5DCJ9gqDcE/
 CKPNnBzvSDlXa6rn2s6cog8C9y2VmuS6AeyxbRmAsl6Qa6rzZ4wqrmLULjUTODrveCPb/N
 7W4yDuD3RdYn9nMGLRlYXdoSEEC9/QI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-zxN15EGYNPy1XTQ8U6FAAQ-1; Mon,
 05 Aug 2024 14:48:19 -0400
X-MC-Unique: zxN15EGYNPy1XTQ8U6FAAQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 543CB1955D54; Mon,  5 Aug 2024 18:48:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1175119560AA; Mon,  5 Aug 2024 18:48:14 +0000 (UTC)
Date: Mon, 5 Aug 2024 13:48:12 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH for-9.1 0/2] NBD: don't print raw server error text to
 terminal
Message-ID: <dkp3je5pohqlrxqrbzwd7maxgljr4gknhlmorae6ihi3vx2t4u@z3vvc5ml7vwj>
References: <20240802194156.2131519-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802194156.2131519-4-eblake@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Aug 02, 2024 at 02:26:04PM GMT, Eric Blake wrote:
> I've requested a CVE from Red Hat, and hope to have an assigned number
> soon.  Meanwhile, we can get review started, to make sure this is
> ready to include in 9.1.  'qemu-img info' should never print untrusted
> data in a way that might take over a user's terminal.
> 
> There are probably other spots where qemu-img info is printing
> untrusted data (such as filenames), where we probably ought to use the
> same sanitization tactics as shown here.  Identifying those spots
> would be a useful part of this review, and may mean a v2 that is even
> more extensive in the number of patches.

In fact, should we insist that 'qemu-img info XXX' refuse to accept
any control characters on any command-line filename, and that it
reject any backing file name with control characters as a malformed
qcow2 file?  For reference, we JUST fixed qemu-img info to change
qcow2 files with a claimed backing file of json:... to favor the local
file ./json:... over the potentially dangerous user-controlled
format/protocol description, so we are _already_ changing how strict
qemu-img is for 9.1, and adding one more restriction to avoid
escape-sequence madness makes sense.

Note that with:

touch $'\e[m' && qemu-img info --output=json $'\e[m'

we already escape our output, but without --output=json, we are
vulnerable to user-controlled ESC leaking through to stdout for more
than just the NBD server errors that I addressed in v1 of this patch
series.  Hence my question on whether v2 of the series should touch
more places in the code, and whether doing something like flat-out
refusing users stupid enough to embed control characters in their
filenames is a safe change this close to release.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


