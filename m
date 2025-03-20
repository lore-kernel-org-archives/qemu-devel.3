Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA1C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvG78-0006Zp-JH; Thu, 20 Mar 2025 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvG75-0006ZN-7t
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:39:12 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvG6y-0004RX-Rc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:39:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EC7A21CBF;
 Thu, 20 Mar 2025 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742477930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAmNtGIdRDlZpkP7X+kwadQFkRWIn0L8T1bDc7wClz4=;
 b=Xm7DzY57cF6+cjzx7MIhabssEN1DZRA5cXmYKTL6UKms4nveSBUp9m1Lw1POu/xcEPhV0A
 w81EBcQCOUxucgv/JMi8tM2rGsw+20DzUFEeSvXBNwB13nADqWE2VuKPdOipySMFRCAroP
 3Kuxsl96PRcaEDJtcQ6SaQEBXfaAFZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742477930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAmNtGIdRDlZpkP7X+kwadQFkRWIn0L8T1bDc7wClz4=;
 b=OTmQrPbIS7OARZKdYl3LnmTucYAkX6ndbSdY72xkoHtIfsYVaQHUSUcVQjQrOIl1oORCaz
 woXxnIFSO6JkpGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742477930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAmNtGIdRDlZpkP7X+kwadQFkRWIn0L8T1bDc7wClz4=;
 b=Xm7DzY57cF6+cjzx7MIhabssEN1DZRA5cXmYKTL6UKms4nveSBUp9m1Lw1POu/xcEPhV0A
 w81EBcQCOUxucgv/JMi8tM2rGsw+20DzUFEeSvXBNwB13nADqWE2VuKPdOipySMFRCAroP
 3Kuxsl96PRcaEDJtcQ6SaQEBXfaAFZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742477930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAmNtGIdRDlZpkP7X+kwadQFkRWIn0L8T1bDc7wClz4=;
 b=OTmQrPbIS7OARZKdYl3LnmTucYAkX6ndbSdY72xkoHtIfsYVaQHUSUcVQjQrOIl1oORCaz
 woXxnIFSO6JkpGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF2F313757;
 Thu, 20 Mar 2025 13:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2BxbH2ka3GceTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Mar 2025 13:38:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
In-Reply-To: <CAE8KmOwkLoPB=wLuE5WC0HERzmUqAqjP9ZECTvxBELaN31yBVQ@mail.gmail.com>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de> <Z8ssc0NETt9KJjTG@x1.local>
 <87tt84u0d2.fsf@suse.de> <Z8tv53G5s9MLYv6f@x1.local>
 <87o6y9t14g.fsf@suse.de> <Z88DmvrNrW5Q1n7y@x1.local>
 <87ecz4adoi.fsf@suse.de>
 <CAE8KmOwkLoPB=wLuE5WC0HERzmUqAqjP9ZECTvxBELaN31yBVQ@mail.gmail.com>
Date: Thu, 20 Mar 2025 10:38:47 -0300
Message-ID: <878qozbz4o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Tue, 11 Mar 2025 at 00:59, Fabiano Rosas <farosas@suse.de> wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> > To me, this is a fairly important question to ask.  Fundamentally, the very
>> > initial question is why do we need periodic flush and sync at all.  It's
>> > because we want to make sure new version of pages to land later than old
>> > versions.
> ...
>> > Then v1 and v2 of the page P are ordered.
>> > If without the message on the main channel:
>> > Then I don't see what protects reorder of arrival of messages like:
> ...
>> That's all fine. As long as the recv part doesn't see them out of
>> order. I'll try to write some code to confirm so I don't waste too much
>> of your time.
>
> * Relying on this receive order seems like a passive solution. On one
> side we are saying there is no defined 'requirement' on the network or
> compute capacity/quality for migration. ie. compute and network can be
> as bad as possible, yet migration shall always work reliably.
>
> * When receiving different versions of pages, couldn't multifd_recv
> check the latest version present in guest RAM and accept the incoming
> version only if it is fresher than the already present one? ie. if v1
> arrives later than v2 on the receive side, the receive side
> could/should discard v1 because v2 is already received.
>

"in guest RAM" I don't think so, the performance would probably be
affected. We could have a sequence number that gets bumped per
iteration, but I'm not sure how much of a improvement that would be.

Without a sync, we'd need some sort of per-page handling*. I have a gut
feeling this would get costly.

*- maybe per-iovec depending on how we queue pages to multifd.

> Thank you.
> ---
>   - Prasad

