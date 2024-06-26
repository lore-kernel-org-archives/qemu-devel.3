Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5583C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRdg-0003dc-J2; Wed, 26 Jun 2024 08:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMRde-0003d9-CD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMRdb-0004qn-D7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719404433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fUBakjLTQPkSGn5Z6zK8SbfgIplgj1ZAGjc7ngQQ3Q=;
 b=IygizeZl4cCpplOVEhjsGEAwNkOaCFOsoVpZZLddc/8Lewp5o/jbJobU76lc6WipFRFxx2
 /iJB3uomgSFS+K/KX520qnnwQv+4Syk+Gx28jtCpElxpHAjDtHt/jhPBT9e7U5OCBG0NeG
 8/fc0ybv198m98rDwYsJLAIFDfWeX1I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-GQIs5U0XMM6ZuHAO4nlUZA-1; Wed,
 26 Jun 2024 08:20:28 -0400
X-MC-Unique: GQIs5U0XMM6ZuHAO4nlUZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E8C31956094; Wed, 26 Jun 2024 12:20:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A38B1956051; Wed, 26 Jun 2024 12:20:22 +0000 (UTC)
Date: Wed, 26 Jun 2024 13:20:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Peter Xu <peterx@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnwHgi0i6vqdrXfT@redhat.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n> <ZnsOdiHACtL90f3J@redhat.com>
 <9b6c50d2-5c42-48b2-8e0b-b6304f225679@oracle.com>
 <Znv81nAGJRb85wBs@redhat.com>
 <32366d3f-453e-4f34-98e6-70cbf83f0490@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32366d3f-453e-4f34-98e6-70cbf83f0490@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 26, 2024 at 01:12:15PM +0100, Joao Martins wrote:
> On 26/06/2024 12:34, Daniel P. Berrangé wrote:
> > On Wed, Jun 26, 2024 at 12:29:41PM +0100, Joao Martins wrote:
> >> On 25/06/2024 19:37, Daniel P. Berrangé wrote:
> >>> On Tue, Jun 25, 2024 at 10:53:41AM -0400, Peter Xu wrote:
> >>>> Then the question is how should we suggest the user to specify these two
> >>>> parameters.
> >>>>
> >>>> The cover letter used:
> >>>>
> >>>>   migrate_set_parameter downtime-limit 300
> >>>>   migrate_set_parameter switchover-limit 10
> >>>
> >>> What this means is that in practice the total downtime limit
> >>> is 310 ms, however, expressing this as two parameters is
> >>> incredibly inflexible.
> >>>
> >>> If the actual RAM transfer downtime only took 50 ms, then why
> >>> should the switchover downtime still be limited to 10ms, when
> >>> we've still got a budget of 250 ms that was unused.
> >>>
> >>
> >> The downtime limit is 300, it's more than you are giving something *extra* 10ms
> >> when you switchover regardless of where that's spent.
> >>
> >> If it makes it easier to understand you could see this parameter as:
> >>
> >> 'downtime-limit-max-error' = 10 ms
> >>
> >> The name as proposed by the RFC was meant to honor what the error margin was
> >> meant for: to account for extra time during switchover. Adding this inside
> >> downtime-limit wouldn't work as it otherwise would be used solely for RAM
> >> transfer during precopy.
> >>
> >>> IOW, if my VM tolerates a downtime of 310ms, then I want that
> >>> 310ms spread across the RAM transfer downtime and switchover
> >>> downtime in *any* ratio. ALl that matters is the overall
> >>> completion time.
> >>>
> >> That still happens with this patches, no specific budget is given to each.
> > 
> > If no specific budget is given to each, then IMHO adding the second
> > parameter is pointless & misleading. 
> 
> That is contradictory with your earlier statement.

I don't think it is.

> You redacted the part where I describe how this works in *the worst case* if the
> entire downtime-limit is used for RAM transfer then the switchover-limit might
> *implicitly* act as an budget:
> 
> | Though implicitly if downtime-limit captures only RAM transfer, then in theory
> | if you're migrating a busy guest that happens to meet the SLA say
> | expected-downtime=290, then you have a total of 20 for switchover (thanks to
> | the extra 10 used in switchover-limit/downtime-limit-max-error 10).
> 
> I am confused with what to make here. If budget is bad because any ratio should
> be used if available, but then the added parameter doesn't care about ratios
> specifically but *can* act as switchover ratio when RAM dominates
> downtime-limit. But now no budget is associated is also bad ... then what's your
> middle ground from your point of view to tackle switchover downtime being
> somehow accounted?

The pre-existing 'downtime-limit' value should apply to anything that
happens between src CPUs stopping, and dst CPUs starting. If we were
not correctly accounting for some parts, we just need to fix that
accounting, without adding extra time parameters.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


