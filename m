Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76CEC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11BD-0005Qw-0J; Mon, 31 Aug 2026 08:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x11Az-0005G7-PA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x11Aw-0006Co-SA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788179505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5917Mb2STngAWHYQwpIU8NLC3/0kHzX1fDaNi5/1+E=;
 b=feMEscKYkPPmb3EgT7rITlwmzRTjfH2W4H6cewhgDJY2bH9Birbu22CdaBOrCM82oFOPnO
 8zcoeqh1Ba2KJf91wHB6Mp6MnR51N7CneY7Vu98V8UImI0McoR0kQ/UWBPRG2ovsyRDwdP
 zBFXav/tGpfS3rGShf8GQ0mFMREx5Pg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-ZDqsdRh4NCadxLruj3iNaw-1; Mon,
 31 Aug 2026 08:31:42 -0400
X-MC-Unique: ZDqsdRh4NCadxLruj3iNaw-1
X-Mimecast-MFC-AGG-ID: ZDqsdRh4NCadxLruj3iNaw_1788179500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F4EF195DE29; Mon, 31 Aug 2026 12:31:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F77E18005BB; Mon, 31 Aug 2026 12:31:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE3EB21E6832; Mon, 31 Aug 2026 14:31:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
In-Reply-To: <aacf393c-2688-47b4-a507-18119dc6d199@virtuozzo.com> (Denis
 V. Lunev's message of "Thu, 27 Aug 2026 18:06:23 +0200")
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org>
 <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
 <8733w0j45n.fsf@pond.sub.org>
 <0880ebd0-d548-496a-9832-eb4e58c46594@virtuozzo.com>
 <87fqzzgc13.fsf@pond.sub.org>
 <aacf393c-2688-47b4-a507-18119dc6d199@virtuozzo.com>
Date: Mon, 31 Aug 2026 14:31:36 +0200
Message-ID: <87ik4qfp3r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 8/27/26 11:15, Markus Armbruster wrote:

[...]

>> We must not (re)open a dirty image read/write without cleaning it,
>> because writing to risks corruption, i.e. data loss.
>>
>> When we open a dirty image read/write, we can clean it without
>> inconveniencing the guest, because the guest cannot access it until
>> after open completes and we connect the newly open image.  Correct?
> correct.
>
>> When we reopen a read/only dirty image read/write, cleaning it *can*
>> affect the guest, as discussed above.
>>
>> As far as I can tell, all the trouble discussed above ultimately comes
>> from letting the guest work with read-only dirty images.  Why is that
>> useful?
>>
>> What are the use cases for opening dirty images read-only?
> Read only images usually comes in image chains (snapshots, backing
> stores). How RO image becomes dirty is very good question. May
> be this was due to QEMU stop/node crash during running commit.
>
> Why this is needed? VM should continue to start with dirty
> RO image. Doing maintenance at start? That is also problematic.
> At this moment we can face shared lock on base image (so called
> golden image scenario).

We can "do maintenance" during initial open proactively, or during
reopen read/write as needed.

In both cases, we risk delays that can make the guest hang.

Cleaning as needed might avoid some delays.  It can also shift delays
from QEMU startup (sometimes bad) to guest operation (commonly worse).

Cleaning as needed in its current state appears to violate
blockdev-reopen's contract: it breaks the transaction.  This feels like
a regression.

I think cleaning as needed poses challenges to management applications.
I figure sophisticated ones can make a reasonable choice between "clean
offline before you pass to QEMU" and "don't, and manage the delay on
reopen".  For less sophisticated ones, and also human users, all this
feels like a trap.

Have we considered dirty image open to require an "I'm sophisticated"
flag?

Anyway, this is how far I can take this.  Now the block layer
maintainers need to chime in.

[...]


