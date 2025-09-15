Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F932CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDxz-00052A-S3; Mon, 15 Sep 2025 14:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDxw-00051R-Ao
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyDxf-0001x4-I5
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757960993;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=javCo2oY4lRHPdznIcRhxSGGhF7ygsi1nCpJaV6eUAk=;
 b=hV99Ylnfq5hVVT0fmtbR5Y5UHlfy1qv6mrlG3bTMyDKgFk1oNeqIoz2Eqr/lD3lsnUzK5S
 6gmakr1ZpEAG0SziVAyD3uysb3HhLjr25UzO9VOYAJFjAxe7O62UKlLbo1BExveKt/cNZy
 ACTB36LYtnOqajL8XO54vzVQK5qBgII=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-4H3oEWa8PYWn6VJYuDnzYA-1; Mon,
 15 Sep 2025 14:29:50 -0400
X-MC-Unique: 4H3oEWa8PYWn6VJYuDnzYA-1
X-Mimecast-MFC-AGG-ID: 4H3oEWa8PYWn6VJYuDnzYA_1757960989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 094C11956056; Mon, 15 Sep 2025 18:29:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05D87180044F; Mon, 15 Sep 2025 18:29:45 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:29:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, leiyang@redhat.com,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 04/13] util/error: add &error_reporter
Message-ID: <aMhbFcvItNMBtQhN@redhat.com>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-5-vsementsov@yandex-team.ru>
 <aMg0l0xgq3hdiDnh@x1.local>
 <c1907e57-d279-40fa-b181-3b54441c49d7@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1907e57-d279-40fa-b181-3b54441c49d7@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 15, 2025 at 09:14:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.09.25 18:45, Peter Xu wrote:
> > On Mon, Sep 15, 2025 at 04:22:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Add a pair to &error_warn helper, to reduce the pattern like
> > > 
> > >      Error *local_err = NULL;
> > > 
> > >      ...
> > > 
> > >      if (!foo(..., &local_err)) {
> > >          error_report_err(local_err);
> > >          return false;
> > >      }
> > > 
> > > to simply
> > > 
> > >      if (!foo(..., &error_reporter)) {
> > >          return false;
> > >      }
> > > 
> > > Of course, for new interfaces, it's better to always support and handle
> > > errp argument. But when have to rework the old ones, it's not always
> > > feasible to convert everything to support/handle errp.
> > > 
> > > The new helper is used in following commits.
> > Could we add some explanation of why we need this if we already have
> > error_warn?
> > 
> > I don't see much difference except error_warn will prepend it with
> > "warning: ", but that doesn't sound like a real problem..
> 
> Yes, seems it's the only difference.
> 
> For me it seems strange to call it "warning", when we actually go to failure branch of the code logic.
> Finally, we do have error_report() and warn_report(). Seems not a problem to have corresponding "magic" variables.
> 
> If have only one special error variable to simply report the error, I'd prefer it not have "warning: " prefix.
> I.e. drop error_warn, and keep only error_reporter (or some better name?).

FWIW, this whole debate is liable to be a bit of a can of worms that
will delay your series from getting merged.

Can I suggest you repost this without &error_reporter usage, and then
have a separate standalone series that proposes error_report, and
converts a handful of files to demonstrate its usage.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


