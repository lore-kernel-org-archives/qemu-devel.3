Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB7C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sez0s-0007O9-FM; Fri, 16 Aug 2024 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sez0r-0007N3-80
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sez0p-00023q-CG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723822628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AvvrFVsdOg9uRM0iTO/AB1LG3//W4g3kxWvbRksjHXY=;
 b=AT7enmihCRWwDVVA79UdPUgjJCnFSyYFhyoZRnfBhs8DIFLHwqd3r/ngyhLvR2QgIl3u6w
 FD3hBpBKYkPls00x6QVLN1GQ+a3f3trHzra0QdlgeWsAJ5M7ZByzWV5J31CI+iN2Z66tTP
 NUBAFJuE5pO9UwpTcZD2+Wy3/SObjUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-XQvVMK0LM3Kyys3h8muuIA-1; Fri,
 16 Aug 2024 11:37:05 -0400
X-MC-Unique: XQvVMK0LM3Kyys3h8muuIA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE40B195422E; Fri, 16 Aug 2024 15:37:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACF0B1956052; Fri, 16 Aug 2024 15:37:01 +0000 (UTC)
Date: Fri, 16 Aug 2024 16:36:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr9yGoXBpHIzrDak@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
 <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr9u1YV4m9Uzvj7Z@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 16, 2024 at 11:23:01AM -0400, Peter Xu wrote:
> On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
> > On 8/15/2024 4:28 PM, Peter Xu wrote:
> > > On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > > > > The new user-visible interfaces are:
> > > > > >     * cpr-transfer (MigMode migration parameter)
> > > > > >     * cpr-uri (migration parameter)
> > > > > 
> > > > > I wonder whether this parameter can be avoided already, maybe we can let
> > > > > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > > > > in the same channel?
> > > > 
> > > > You saw the answer in another thread, but I repeat it here for others benefit:
> > > > 
> > > >    "CPR state cannot be sent over the normal migration channel, because devices
> > > >     and backends are created prior to reading the channel, so this mode sends
> > > >     CPR state over a second migration channel that is not visible to the user.
> > > >     New QEMU reads the second channel prior to creating devices or backends."
> > > 
> > > Today when looking again, I wonder about the other way round: can we make
> > > the new parameter called "-incoming-cpr", working exactly the same as
> > > "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> > > be reused for migration incoming ports?
> > > 
> > > After all, cpr needs to happen already with unix sockets.  Having separate
> > > cmdline options grants user to make the other one to be non-unix, but that
> > > doesn't seem to buy us anything.. then it seems easier to always reuse it,
> > > and restrict cpr-transfer to only work with unix sockets for incoming too?
> > 
> > This idea also occurred to me, but I dislike the loss of flexibility for
> > the incoming socket type.  The exec URI in particular can do anything, and
> > we would be eliminating it.
> 
> Ah, I would be guessing that if Juan is still around then exec URI should
> already been marked deprecated and prone to removal soon.. while I tend to
> agree that exec does introduce some complexity meanwhile iiuc nobody uses
> that in production systems.
> 
> What's the exec use case you're picturing?  Would that mostly for debugging
> purpose, and would that be easily replaceable with another tunnelling like
> "ncat" or so?

Conceptually "exec:" is a nice thing, but from a practical POV it
introduces difficulties for QEMU. QEMU doesn't know if the exec'd
command will provide a unidirectional channel or bidirectional
channel, so has to assume the worst - unidirectional. It also can't
know if it is safe to run the exec multiple times, or is only valid
to run it once - so afgai nhas to assume once only.

We could fix those by adding further flags in the migration address
to indicate if its bi-directional & multi-channel safe.

Technically "exec" is obsolete given "fd", but then that applies to
literally all protocols. Implementing them in QEMU is a more user
friendly thing.

Exec was more compelling when QEMU's other protocols were less
mature, lacking TLS for example, but I still find it interesting
as a facility.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


