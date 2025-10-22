Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9B6CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBUGv-0006o6-DG; Wed, 22 Oct 2025 04:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vBUGu-0006ny-G4
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vBUGr-0005KU-04
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761121952;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NPc5sPRQt+VyFRPvA/dGHGyCqhvYyKSF25Z+40XDgVI=;
 b=aTNoIjdj6Odreu+dbPZBeDKTxWEU657JCCZZVxOtr/0tXpAo0iP1wHVPyWVHBQS6ZL4JS0
 ZRydmzs2tP4caHMA3knz7m8EtsEetHEw98ZAR+wqgc2hZo3SRhW4NHeOA+MobvNyxHTmUS
 kbX96RD2BOfI2wuPTdVl8dx6YkOl6w8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-a6hdSdoqOUyvS-Xlz8HAvQ-1; Wed,
 22 Oct 2025 04:32:30 -0400
X-MC-Unique: a6hdSdoqOUyvS-Xlz8HAvQ-1
X-Mimecast-MFC-AGG-ID: a6hdSdoqOUyvS-Xlz8HAvQ_1761121949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC45195422B; Wed, 22 Oct 2025 08:32:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB05819560B2; Wed, 22 Oct 2025 08:32:26 +0000 (UTC)
Date: Wed, 22 Oct 2025 09:32:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Dhruv Choudhary <dhruv.choudhary@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Improve error propagation via return path
Message-ID: <aPiWl39eLOfBJQ1n@redhat.com>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
 <aPeaBNIzrq0Ni4IM@x1.local>
 <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
 <aPelsAunpYhiQJ0h@x1.local> <87tszst2so.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tszst2so.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:31:19PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Oct 21, 2025 at 05:54:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> On 21.10.25 17:34, Peter Xu wrote:
> >> > On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
> >> > > Use the return-path thread to send error details from the
> >> > > destination to the source on a migration failure. Management
> >> > > applications can then query the source QEMU for errors, as
> >> > > the single source of truth, making failures easy to trace.
> >> > > 
> >> > > Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
> >> > 
> >> > +Vladimir, Dan
> >> > 
> >> > IIUC we may still need to know whether the src QEMU supports this message
> >> > or not.
> >> > 
> >> > OTOH, we have introduced exit-on-error since 9.1:
> >> > 
> >> > # @exit-on-error: Exit on incoming migration failure.  Default true.
> >> > #     When set to false, the failure triggers a :qapi:event:`MIGRATION`
> >> > #     event, and error details could be retrieved with `query-migrate`.
> >> > #     (since 9.1)
> >> > 
> >> > This patch is going the other way.  That feature suggests the mgmt query
> >> > the error from dest directly.
> >> > 
> >> > We should stick with one plan rather than doing both.
> >> > 
> >> 
> >> Why?
> >> 
> >> exit-on-error=false is good anyway: when QMP connection is established, the
> >> management of target QEMU process is the same: we do call qmp commands to
> >> add devices, etc. We get QMP events. Actually, exiting is unexpected, better
> >> to fit into QMP protocol, continuing to send events and wait for qmp quit
> >> to exit.
> >> 
> >> Passing error back to the source simply improves error message on source,
> >> which otherwise is often confusing.
> >> 
> >> Using both, we of course see same error in two places.. But we do have two
> >> QEMU processes, which both handled by on-host managing services. We should
> >> correctly report error on both parts anyway.
> >> 
> >> Improving error messages on source is just and improvement, which makes
> >> current behavior better (with or without exit-on-error=false).
> >> 
> >> Removing exit-on-error=false semantics (with or without passing errors back)
> >> would be a step backward, to violating of QMP protocol by unexpected exits.
> >
> > I didn't mean to propose removing exit-on-error, what I meant is when with
> > it this patch doesn't look like helpful.
> >
> > Has libvirt been integrated with exit-on-error?  If so, IMHO we don't need
> > this patch anymore.  To me it's not an improvement when with exit-on-error,
> > because duplicating the error from dest to src makes it harder to know
> > where the error happened.
> 
> Yeah, this does introduce some complexity of the "whose error is this?"
> kind. I can imagine future users of migrate_has_error() having to handle
> the error differently whether it came from this machine or the remote
> one. Maybe with current code there's no issue, but we need to think from
> a design perspective. Another point is whether the source machine is
> always prepared to see an error that has nothing to do with its own
> operation as it usually gets to know about a destination error only when
> TCP connections start to fail.
> 
> That said, from a usability perspective, I'm in favor of having the
> source machine be able to inform the user about the destination
> machine's error. It goes in the direction of relying less on the
> management layer, which we already agree might be a good idea.

Should we neccessarily assume that target machine's error is the "best"
error message ?  Failures can result in errors being raised on both the
source and dest, and it is not clearcut which side will have the root
cause error, and which will just have a side effect error. If we pass
the target error back to the source, we need to ensure that we don't
replace a better error that the source already has.

Allowing use of 'query-migrate' to fetch errors on both the source and
dest means mgmt apps have both errors available, but that does then
mean the mgmt app needs to decide which error is "best".

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


