Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0E4C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWBz-0007Zu-VJ; Thu, 01 May 2025 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAWBz-0007Zi-67
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAWBu-0000LE-Bq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746114671;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MSmlu/d5rYJXimGs8kb3DWK6gqhuMhHK+Sbmoz3ELww=;
 b=HjDxbXdD2Zrn2aiCWAPn3+RzpNxl9MlJvg2iFX9zGNu1GP9OFjFhWF9Tn+z2FpDO2jnrAY
 xvUnQrbRyr/AZIC89um3NUtjAV5ovx7g6IcOzg3mp3AuAM+iky+6SLIVAZpAJJ1aZzqMai
 w4LAVEprpNrL4iCuKVePWlL+Tm/vpNQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-xWlXv_srMHWXyELe63ibRg-1; Thu,
 01 May 2025 11:51:08 -0400
X-MC-Unique: xWlXv_srMHWXyELe63ibRg-1
X-Mimecast-MFC-AGG-ID: xWlXv_srMHWXyELe63ibRg_1746114667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EBE4195608C; Thu,  1 May 2025 15:51:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB95C180045B; Thu,  1 May 2025 15:51:05 +0000 (UTC)
Date: Thu, 1 May 2025 16:51:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: OSUOSL in trouble
Message-ID: <aBOYZsfT0retojQf@redhat.com>
References: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
 <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 01, 2025 at 11:43:28AM -0400, Stefan Hajnoczi wrote:
> On Thu, May 1, 2025, 01:11 Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > From LWN
> >
> > > Lance Albertson writes that the Oregon State University Open Source Lab,
> > the home of many prominent free-software projects over the years, has run
> > into financial trouble:
> > >
> > > I am writing to inform you about a critical and time-sensitive situation
> > facing the Open Source Lab. Over the past several years, we have been
> > operating at a deficit due to a decline in corporate donations. While OSU's
> > College of Engineering (CoE) has generously filled this gap, recent changes
> > in university funding have led to a significant reduction in CoE's budget.
> > As a result, our current funding model is no longer sustainable and CoE
> > needs to find ways to cut programs.
> > > Earlier this week, I was informed that unless we secure $250,000 in
> > committed funds, the OSL will be forced to shut down later this year.
> >
> > I propose migrating the two VMs we have to Digital Ocean and scrapping the
> > DO Kubernetes cluster. However that means we need to move CI to Amazon in
> > the next 1-2 months, before the Microsoft credits expire.
> >
> 
> I agree. I will also apply for the next round of Amazon funding.
> 
> Paolo, please let me know how I can help with migrating VMs or setting up a
> CI Kubernetes cluster on Amazon.

Please ensure the any new CI machines for gitlab have persistent cache
enabled. Our functional test jobs are still downloading images on every
run due to lack of configured cache, which makes them unreliable when
sites have transient outages, as well as making jobs slower.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


