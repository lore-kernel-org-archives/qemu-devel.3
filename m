Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456BC197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 19:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnjPh-0002ax-ET; Thu, 27 Feb 2025 14:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnjPW-0002ZL-07
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 14:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tnjPN-0002n4-1z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 14:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740683933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OgvhNxw26j5W+7YxZ3jOwBZRNFzwBjk4Uop0C9Cs2ik=;
 b=WEoKStZNoBTrIXaTTNVMv0bkOI44Uh6HFsQrPyUdQ8OlT/KQubXbg0toy6V7QbUyJfsOzk
 L0A0MZI59ZigXibYUX5vbO3ezDWjc7ZwaeCZcX3tnUsmsDUiAueYRt7/+iAYKbOaZf66oT
 DCoRL+tsV//a9JkArcuDdABa4TQLyRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-wYrxeYiAMxyCW_TsIiyjjw-1; Thu,
 27 Feb 2025 14:18:50 -0500
X-MC-Unique: wYrxeYiAMxyCW_TsIiyjjw-1
X-Mimecast-MFC-AGG-ID: wYrxeYiAMxyCW_TsIiyjjw_1740683929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E51251800877; Thu, 27 Feb 2025 19:18:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7627E300019E; Thu, 27 Feb 2025 19:18:46 +0000 (UTC)
Date: Thu, 27 Feb 2025 13:18:43 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Problem with iotest 233
Message-ID: <ezl4qpizzprfy74idos2dytp7jdrutmpzhyrb4bnrfqmelhmgx@diz2t47zfbdt>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
 <Z72XfP8gI9-SB4B9@redhat.com>
 <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
 <574cdf2e-6b8c-4ff3-9a2b-a7d00c92a788@redhat.com>
 <Z74En98KD0v11X8w@redhat.com>
 <84a51a63-50f7-4592-ba75-5e3234571987@redhat.com>
 <7a81b491-d982-4a5b-b250-f7b772f64eb4@redhat.com>
 <4dbc253d-fd6c-4feb-9597-81afbfa8d670@redhat.com>
 <5eb59c74-f426-4bee-a854-08c7a5f5050d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb59c74-f426-4bee-a854-08c7a5f5050d@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 26, 2025 at 09:55:18AM +0100, Thomas Huth wrote:
> > > Though, that does not look like the thread from the simpletrace, but
> > > the the QEMU RCU thread instead ... so no clue where that writer
> > > thread might have gone...
> > 
> > OK, I think I now understood the problem: qemu-nbd is calling
> > trace_init_backends() first, which creates the simpletrace threads and
> > installs the atexit() handler. Then it is calling fork() since the test
> > uses the --fork command line option. But fork() does not clone the
> > simpletrace thread into the new process, only the main thread (see
> > man-page of fork, the new process starts single-threaded). So when the
> > new child process exits, the exit handler calls the simple trace flush
> > function which tries to wait for a thread that has never been created in
> > that process.

That definitely explains the symptoms.

> > 
> > The test works when I move the trace_init_backends() behind the fork()
> > in the main function... but I am not sure if we would miss some logs
> > this way, so I don't know whether that's the right solution. Could a
> > qemu-nbd expert please have a look at this?

I'm also thinking about ways to avoid it.

> 
> After pondering about it for a while, maybe the best solution is to handle
> it within the simpletrace backend itself, by using pthread_atfork() :
> 
>  https://lore.kernel.org/qemu-devel/20250226085015.1143991-1-thuth@redhat.com/

pthread_atfork() is an odd function - POSIX itself says it is
unreliable, because there is NO sane way you can possibly know every
action that any library you call into that might possibly need
protection before fork.  That doesn't mean we can't try it, just that
we can't expect it to solve every fork-related problem we might
encounter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


