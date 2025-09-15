Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18E6CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDXt-0005Kv-64; Mon, 15 Sep 2025 14:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDXr-0005Kg-58
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDXa-0006IP-7A
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757959372;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW7+y71ntLhdOZVN1JF67BElrzB0DGLMNIH8cbSKxcc=;
 b=a8EsGlRnZIb75Zij6bPNuX/oJdc/BQSIldxvxuoac9McRUeRbISW/mEEom0S0YPSxVlWXp
 11nr4Re1ms8IZRCB1kXHHQqWmhNT1zVhj+qnqq/BNqR6Z3BscVwgJrEZIv+FJJc0NGIH8P
 DaXZMXyN3VbdiS8c4/GTF2DAEPjcTL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-T0ZEF0-UOiqByJfN5VM9vw-1; Mon,
 15 Sep 2025 14:02:50 -0400
X-MC-Unique: T0ZEF0-UOiqByJfN5VM9vw-1
X-Mimecast-MFC-AGG-ID: T0ZEF0-UOiqByJfN5VM9vw_1757959370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D039B18004D8
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 18:02:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDF19180035E; Mon, 15 Sep 2025 18:02:48 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:02:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Abuse of warnings for unhandled errors and programming errors
Message-ID: <aMhUxTLiKorN5tjf@redhat.com>
References: <87h5yijh3b.fsf@pond.sub.org> <aKRuXq0_5ULf5yp-@redhat.com>
 <87frcupny3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frcupny3.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 10, 2025 at 01:05:40PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> > On Fri, Aug 08, 2025 at 11:30:32AM +0200, Markus Armbruster wrote:
> >
> > I don't see 'warnings' as something directly actionable for a user.
> > Rather they are messages that I would want to see included in a log
> > file that a user attaches to a bug report if they find some behavioural
> > problem. If the user understands the warning great, but that isn't a
> > requirement.
> >
> > IOW, while informative warnings is of course better than not, as long
> > as the warning message contains sufficient info for the maintainer to
> > understand what happened the minimum quality bar is satisfied IMHO.
> 
> That's a low quality bar indeed.  Here's mine:
> 
> 1. A warning should make perfectly clear whether this is a bug that
> should be reported, or an issue with usage, resources, etc. that can be
> ignored, but may help understand future trouble, if any (typically an
> ordinary error that wasn't fully handled).  Our errors make bug
> vs. ordinary error clear.
> 
> 2. A warning of the former kind (bug) should provide information
> developers need to start debugging.  For errors, we give them a core
> dump, source file and line number.  For warnings, we currently give them
> grep and warm wishes.

Don't understate the value of "grep"  :-)

It is my #1 tool when I see a string mentioned in bug report, whether
that's from error_report or warn_report.

What annoys/frustrates me is when the message (whether an eror or
warning) lacks the technical details of exactly what failed.

ie if the message doesn't substitute in either the errno value, or the
strerror string, or equivalent, then it massively reduces the chances
of diagnosis unless the bug is easily reproducible.

> 3. A warning of the latter kind (not a bug) should at least try to
> provide hints that help users diagnose and correct / work around what's
> wrong.  "warning: failed to WSAEventSelect()" doesn't.  "warning:
> trouble initializing slirp for user mode networking" might.

I agree that the latter is more informative for users, though for
developers it might be worse as such a generic message may provide
cover for several different low level problems. 

Neither help me diagnose the problem though if I see them in a bug
report though, because neither include the "WSAGetLastError()" value
(or its string equivalent).

Probably we deserve both. In the case of "Error" objects, we have
error_prepend so code can do

  error_setg(errp, "failed to WSAEventSelect: %s", WSAGetLastError())

and then the caller one or more levels up the stack can do

  error_prepend(errp, "unable to initialize slirp user mode networking")

which becomes useful when we see the final error_report() or equiv.

We don't have an error_prepend concept for warnings 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


