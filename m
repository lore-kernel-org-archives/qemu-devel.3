Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB3C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcod7-0000eF-KT; Wed, 21 Feb 2024 10:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcobq-0004L0-KE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcmzh-0003n1-Id
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708523439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=q0oJPdp7KJG9iICmxtDb8fNTPiI3XlaixFOHizf6src=;
 b=HNgTtS58pyYZNdFhnhmLqu+h8j2DJrARI4qbkFkRxdxGX9MQkPSL0ldzb+8Nnb6swKOFWg
 qgLpj13BcxTbkYyjPbBHXrnk4Vxj3BhFzprXlC02LdX+6jOrm+jG6LmuywLnP4L7AqocYg
 jawUhwbDwd3e9cUN3TkYD7tkEEdOSG0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-A-81EIaIMUuWNP5QSi8X0w-1; Wed,
 21 Feb 2024 08:50:36 -0500
X-MC-Unique: A-81EIaIMUuWNP5QSi8X0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1878B3816440;
 Wed, 21 Feb 2024 13:50:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2ACB2866;
 Wed, 21 Feb 2024 13:50:34 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:50:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
Message-ID: <ZdX_qV6BfEmresiL@redhat.com>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-12-farosas@suse.de>
 <87o7caxl97.fsf@pond.sub.org> <87sf1mar2i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf1mar2i.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 10:24:05AM -0300, Fabiano Rosas wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Fabiano Rosas <farosas@suse.de> writes:
> >
> >> Add a new migration capability 'fixed-ram'.
> >>
> >> The core of the feature is to ensure that each RAM page has a specific
> >> offset in the resulting migration stream. The reasons why we'd want
> >> such behavior are:
> >>
> >>  - The resulting file will have a bounded size, since pages which are
> >>    dirtied multiple times will always go to a fixed location in the
> >>    file, rather than constantly being added to a sequential
> >>    stream. This eliminates cases where a VM with, say, 1G of RAM can
> >>    result in a migration file that's 10s of GBs, provided that the
> >>    workload constantly redirties memory.
> >>
> >>  - It paves the way to implement O_DIRECT-enabled save/restore of the
> >>    migration stream as the pages are ensured to be written at aligned
> >>    offsets.
> >>
> >>  - It allows the usage of multifd so we can write RAM pages to the
> >>    migration file in parallel.
> >>
> >> For now, enabling the capability has no effect. The next couple of
> >> patches implement the core functionality.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > [...]
> >
> >> diff --git a/qapi/migration.json b/qapi/migration.json
> >> index 5a565d9b8d..3fce5fe53e 100644
> >> --- a/qapi/migration.json
> >> +++ b/qapi/migration.json
> >> @@ -531,6 +531,10 @@
> >>  #     and can result in more stable read performance.  Requires KVM
> >>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >>  #
> >> +# @fixed-ram: Migrate using fixed offsets in the migration file for
> >> +#     each RAM page.  Requires a migration URI that supports seeking,
> >> +#     such as a file.  (since 9.0)
> >> +#
> >>  # Features:
> >>  #
> >>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> >> @@ -555,7 +559,7 @@
> >>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >>             'validate-uuid', 'background-snapshot',
> >>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> >> -           'dirty-limit'] }
> >> +           'dirty-limit', 'fixed-ram'] }
> >>  
> >>  ##
> >>  # @MigrationCapabilityStatus:
> >
> > Can we find a better name than @fixed-ram?  @fixed-ram-offsets?
> > @use-seek?
> 
> I have no idea how we came to fixed-ram. The archives don't provide any
> clarification. I find it confusing at first glance as well.
> 
> A little brainstorming on how fixed-ram is different from exiting
> migration:
> 
> Fixed-ram:
>   uses a file, like the 'file:' migration;
> 
>   needs a seeking medium, such as a file;
> 
>   migrates ram by placing a page always in the same offset in the
>   file, contrary to normal migration which streams the page changes
>   continuously;
> 
>   ensures a migration file of size bounded to VM RAM size, contrary to
>   normal 'file:' migration which creates a file with unbounded size;
> 
>   enables multi-threaded RAM migration, even though we only use it when
>   multifd is enabled;
> 
>   uses scatter-gatter APIs (pwritev, preadv);
> 
> So a few options:
> 
> (disconsidering use-seek, it might be even more generic/vague)
> 
> - fixed-ram-offsets
> - non-streaming (or streaming: false)
> - ram-scatter-gather (ram-sg)
> - parallel-ram (even with the slight inaccuracy that we sometimes do it single-threaded)

I could add 'mapped-ram', as an alternative to 'fixed-ram'.

The key distinguishing & motivating feature here is that
RAM regions are mapped directly to file regions, instead
of just being streamed at arbitrary points.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


