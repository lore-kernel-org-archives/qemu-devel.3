Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD591062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IGo-0002Wu-Df; Wed, 11 Mar 2026 08:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0IGa-0002Hu-Fy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0IGY-0005dz-6Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773230536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoYZSMUXLiKFO9q3cK1qRXf0gZW5P67gqip9HXFZRJ4=;
 b=WRCGEac6cEAKYY5YJsSx5T0HBsQg8t8qN3PFGhGZwLktuCA9BgS3HuwVUbl6HipgWevlDQ
 1VVDT0KQE3qxlUcP+b/E4JDD5KgItzSsW1mL319oJwkrwz8hsncA0oXMsMAdwXkmbbTzjv
 +MloXQlJLAMicCHpp2mtRO6ARfbhBg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-i43VzrgzNz6S52z33yy1bQ-1; Wed,
 11 Mar 2026 08:02:13 -0400
X-MC-Unique: i43VzrgzNz6S52z33yy1bQ-1
X-Mimecast-MFC-AGG-ID: i43VzrgzNz6S52z33yy1bQ_1773230532
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 512391955F39; Wed, 11 Mar 2026 12:02:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5770195410D; Wed, 11 Mar 2026 12:02:09 +0000 (UTC)
Date: Wed, 11 Mar 2026 12:02:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <abFZvUoinIjfMlNX@redhat.com>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
 <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com> <aa8Pvd5O-OLKIXam@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8Pvd5O-OLKIXam@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 02:21:49PM -0400, Peter Xu wrote:
> On Mon, Mar 09, 2026 at 05:51:29PM +0000, Daniel P. Berrangé wrote:
> > On Mon, Mar 09, 2026 at 05:42:08PM +0000, Tejus GK wrote:
> > > 
> > > 
> > > > On 9 Mar 2026, at 10:47 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > 
> > > > !-------------------------------------------------------------------|
> > > >  CAUTION: External Email
> > > > 
> > > > |-------------------------------------------------------------------!
> > > > 
> > > > On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> > > >> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > > >>>> @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > > >>>>         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > > >>>> 
> > > >>>>         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > > >>>> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > >>>> -            sioc->new_zero_copy_sent_success = true;
> > > >>>> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > > >>>> +            sioc->zero_copy_fallback++;
> > > >>> 
> > > >>> ...this is counting the number of MSG_ERRQUEUE items, which is not
> > > >>> the same as the number of IO requests. That's why we only used it
> > > >>> as a boolean marker originally, rather than making it a counter.
> > > >> 
> > > >> Would the logic still work and better than before?  Say, it's a counter of
> > > >> "messages" rather than "IOs" then.
> > > > 
> > > > IIUC it is a counter of processing notifications which is not directly
> > > > correlated to any action by QEMU - neither bytes nor syscalls.
> > > 
> > > Please correct me if I'm wrong about this, isn’t each notification an information 
> > > about what happened to an individual IO?
> > 
> > If userspace hasn't read a queued notification yet, the kernel will
> > merge new notifications with the existing queued one.
> > 
> > The line above your change
> > 
> >   serr->ee_data - serr->ee_info + 1;
> > 
> > records how many notifications were merged, so we now how many
> > syscalls were processed.
> > 
> > If ee_code is  SO_EE_CODE_ZEROCOPY_COPIED though it means at least
> > one syscall resulted in a copy, but that doesn't imply that *all*
> > syscalls resulted in a copy.
> > 
> > AFAICT, it could be 1 out of a 1000 syscalls resulted in a copy,
> > or it could be 1000 out of 1000 resulted in a copy. We don't know.
> > 
> > IIUC the kernel's merging of notifications appears lossy wrt this
> > information. It could be partially mitigated by doing a flush for
> > notifications really really frequently but that feels like it would
> > have its own downsides
> 
> IMHO what this change does is removing the false negatives.
> 
> Before this patch, if QEMU reports fallback=0, it doesn't mean all the
> MSG_ZEROCOPY requests were all fulfilled by zerocopy.  It's because we
> justify it with one boolean over "a period of time" between two flushes, we
> set the boolean to TRUE as long as there is _one_ successful report of
> MSG_ZEROCOPY.  So even if every flush reports TRUE it only means "there is
> at least one MSG_ZEROCOPY request that didn't fallback".  It has no
> implication of whether a fallback happened.
> 
> Hence, before this v2 patch, there can be false negative reported by QEMU,
> assuming there's no fallback (reflected in stats) but it actually happened.
> 
> After this patch, if QEMU reports fallback=0, it guarantees that _all_
> MSG_ZEROCOPY requests are fulfilled with zerocopy.  It's because we monitor
> all messages and accumulate any fallback cases.  Even if the messages can
> be merged, when "fallback" shows anything non-zero would imply some
> fallback happened.  Here, the counter value doesn't really matter much
> IMHO, as long as it becomes non-zero.

AFAICT, the v1 of this patch was sufficient to address the original
bug and maintain the current intended semantics of the migration
counter. This v2 is mixing a bug fix with functional change in
behaviour and I don't think the latter is justified.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


