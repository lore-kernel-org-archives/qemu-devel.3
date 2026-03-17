Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB76F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QGF-0006oU-Vb; Tue, 17 Mar 2026 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2QFx-0006VI-0z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2QFv-0007zO-4M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fbkddmCJ6j6UpG7Gm4YZeU2ZLwOO0/XjzuWz6Ta0IiU=;
 b=e0y770ykX0HFe37ndzthGnA/nYB0rdBdaz+mIraiEhkl0qrC39rQkyg3GRkp+9W6IarM/Y
 dun1uFDscVQJPSDalIf4gblHRUwR73QpYYUdVbatW638TA7HdpD5JhA8HJgO7u5bpPnwTf
 9ZYnKwHswGL1c8PVfz1PpQNkvC7OYL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-XeyHh2S0OB65guQ8TNfLaw-1; Tue,
 17 Mar 2026 04:58:22 -0400
X-MC-Unique: XeyHh2S0OB65guQ8TNfLaw-1
X-Mimecast-MFC-AGG-ID: XeyHh2S0OB65guQ8TNfLaw_1773737901
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27FCF180034E; Tue, 17 Mar 2026 08:58:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 747AD19560B1; Tue, 17 Mar 2026 08:58:18 +0000 (UTC)
Date: Tue, 17 Mar 2026 08:58:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Message-ID: <abkXhC1OJF21RZTL@redhat.com>
References: <20260316084618.52-1-junjie.cao@intel.com>
 <abhq9BzuP2bZPLBg@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abhq9BzuP2bZPLBg@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 16, 2026 at 04:41:24PM -0400, Peter Xu wrote:
> On Mon, Mar 16, 2026 at 04:46:18PM +0800, Junjie Cao wrote:
> > multifd_file_recv_data() stores the return value of qio_channel_pread()
> > (ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
> > to SIZE_MAX, producing a nonsensical read size in the error message.
> > 
> > More critically, a short read (0 <= ret < data->size) is possible when
> > the migration file is truncated.  In that case qio_channel_pread()
> > returns a non-negative value without setting *errp.  The function then
> > calls error_prepend(errp, ...) which dereferences *errp -- a NULL
> > pointer -- crashing QEMU.
> > 
> > Fix both issues by changing ret to ssize_t and splitting the error
> > handling: use error_prepend() only when qio_channel_pread() itself
> > has populated *errp (ret < 0), and error_setg() for the short-read
> > case where *errp has not been set.  Add ERRP_GUARD() so that
> > error_prepend() works correctly even when errp is &error_fatal or
> > NULL.
> 
> Indeed, this seems problematic.
> 
> But is it possible to get partial reads?  I don't see why it won't happen..
> do we need to fix it too (e.g. introduce qio_channel_pread_all_eof())?

It is wise to assume a short read is possible. Even if it might be
safe today, based on assumptions of the callers, future refactoring
may change things.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


