Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F97C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfAp-0007RU-7Q; Mon, 09 Jun 2025 12:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOfAM-0007N0-0O
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOfAH-00041a-5M
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbT53elsD8+UxF8iZrU3sTV5Ox2WXHgVAWG0UpMmMDc=;
 b=eS6taHGcskZ1a/mV2yN6Uj0w0FDxqAbwwJlQ9wAmnrfn9vcOkbFw6z55qOmg/lQYK227Ne
 JAHk0tGxyEwgILiILKVkspBgVPFQz7TugCTQ4TE1Jzhs7zc9XIq90OEn8AgA04xyPcEUPb
 4dSfL8raXWtG0UqnlnB/AIlK7h4Svvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-ZCYhbjq9Nyee3ISrWI752A-1; Mon,
 09 Jun 2025 12:15:50 -0400
X-MC-Unique: ZCYhbjq9Nyee3ISrWI752A-1
X-Mimecast-MFC-AGG-ID: ZCYhbjq9Nyee3ISrWI752A_1749485749
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25C52180029D; Mon,  9 Jun 2025 16:15:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A8F3180045C; Mon,  9 Jun 2025 16:15:46 +0000 (UTC)
Date: Mon, 9 Jun 2025 17:15:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcIr2Xjv__M_J0O@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <aEb3pRkQK30JBf04@redhat.com>
 <aEb-umgh0VP2sKGW@x1.local> <aEcBLLwB9vZ33k8Q@redhat.com>
 <aEcDi6Z7pDeiRqDe@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEcDi6Z7pDeiRqDe@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 09, 2025 at 11:53:47AM -0400, Peter Xu wrote:
> On Mon, Jun 09, 2025 at 04:43:40PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jun 09, 2025 at 11:33:14AM -0400, Peter Xu wrote:
> > > 
> > > Now I think I know part of what I've missed: I used to think the "config"
> > > of per-QMP-migrate-command can be totally temporary for a specific
> > > migration request, but then we need another MigrationState.parameters_2 to
> > > cache the old or vice versa; that's probably not necessary.  Now I think it
> > > makes sense to overwrite any settings directly, hence I think I changed my
> > > mind on question (1), YES is fine here.
> > > 
> > > For (2), why it would introduce any uncertainty for mgmt?
> > > 
> > > If the mgmt app can both: (1) query from qapi schema knowing all the
> > > parameters supported, then (2) specify all the parameters in QMP migrate's
> > > "option" parameter.  Then it's literally overwritting all the parameters,
> > > so it's predictable with or without completely removing global settings as
> > > an idea?
> > 
> > That is relying on the mgmt app specifiying absolutely every config
> > parameter that exists. If they miss anything, then the behaviour is
> > not well defined, as external global state still affects things.
> > 
> > This is the same situation we already have with migrate-set-parameter,
> > where mgmt apps have to know to call migrate-set-parameter over & over
> > with every possible parameter to get back to a well known starting point.
> > 
> > The command needs to run with the parameters provided in 'config' and
> > no external global state, whether from -global or any prior call of
> > migrate-set-parameter
> 
> So libvirt does not probe the qapi schema for all possible parameters?  Why
> not do that once on QEMU boot up, then when migration is needed use a
> sequence of commands to make sure everything will be setup before
> "migrate"?  It'll definitely take a few rounds of QMP commands, but the
> core issue is whether there can be any real atomic issues of that.

Probing the QAPI schema tells you what parameters exist. It does not tell
you what values you should set for parameters, if you don't already know
what the semantics of that parameter are. Such a requirement to probe
all parameters & set them all manually is again making migration into a
special case that is not following the normal QMP design, and there's
no justification for that other than the historical design mistakes in
migration QMP which were copied from HMP.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


