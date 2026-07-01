Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18035C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevH2-0006Ab-Fc; Wed, 01 Jul 2026 09:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wevH1-0006AQ-45
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wevGz-0007dO-C4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782913600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auohRCKWWACf8rRt+/wnNjayZU1Vlic1YoDPcquU/4Y=;
 b=dQxWwRThcrsN8MNuaLG/iWQh58wZsmmh+egFFGtHuJWvnElZxU/5SbaiLXe3jByEKKdajQ
 z+W2BZrbnl5PdrSsmaf5yqmHGZ3rntlHu/Rk4yJue7PX8zwGCqFwZx+weBnbdLzTTUsY/Y
 ImYP+unleYV3YQu2FFVt5DixULXQ3LM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-W0zH4Q5oOemPI6D5ay-fVQ-1; Wed,
 01 Jul 2026 09:46:36 -0400
X-MC-Unique: W0zH4Q5oOemPI6D5ay-fVQ-1
X-Mimecast-MFC-AGG-ID: W0zH4Q5oOemPI6D5ay-fVQ_1782913595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4B41933F8F; Wed,  1 Jul 2026 13:46:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D453E18007E7; Wed,  1 Jul 2026 13:46:31 +0000 (UTC)
Date: Wed, 1 Jul 2026 14:46:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v5 00/35] monitor: turn QMP and HMP into QOM objects
Message-ID: <akUaNF4DeBrbPMNO@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <87fr236t9v.fsf@pond.sub.org> <akTOGzFdz3_0Np-U@redhat.com>
 <87ik6y4yk9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik6y4yk9.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 01, 2026 at 03:41:26PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jul 01, 2026 at 09:52:44AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > Conceptually -object and object_add/object_del should be sufficient
> >> > for essentially all QEMU configuration....if only we ported all our
> >> > internal custom backends/devices/etc to QOM. That is of course a big
> >> > job which is why it hasn't happened.
> >> >
> >> > This series started with the premise that the monitor is one of the
> >> > easier areas to convert since we have no more than three classes,
> >> > a common base, and QMP and HMP subclasses[1]. So why not give it a
> >> > go and thus unlock the ability to dynamically create/delete monitors
> >> > in QMP/HMP.
> >> >
> >> > This series does the conversion in a great many small steps to better
> >> > understand the implications at each stage.
> >> >
> >> > The high level outcome of this series is
> >> >
> >> >  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
> >> >    'monitor-qmp' respectively
> >> >
> >> >  * Both can be cold plugged and hot plugged. QMP only, can
> >> >    also be hot unplugged.
> >> >
> >> >  * '-mon' is obsolete, deprecated and replaced by '-object',
> >> >    but -monitor, -qmp and kept  as high level syntax sugar
> >> 
> >> Possible additional work: change monitor_parse() to build a
> >> MonitorOptions instead of a QemuOpts, so it call monitor_new() directly
> >> instead of via monitor_new_opts().  Observation, not a demand.
> >> 
> >> >
> >> >  * QMP gains a concept of "close-action" which makes it
> >> >    possible to mark a monitor for auto-delete.
> >> 
> >> I'm not quite convinced this is warranted.  I'd like to hear more about
> >> use cases.
> >
> > Replied about that inline to the patch. IMHO without this facility
> > the series does not fully address the needs of systemd that motivated
> > the original patches:
> >
> >   https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html
> >
> >> Is libvirt going to make use of it?
> >
> > This wasn't motivated by libvirt's needs, but indeed it could be
> > useful for libvirt. Currently if apps want to access QMP, they
> > need to use libvirt's QMP passthrough, which means they need
> > special client code to talk to libvirt APIs.
> >
> > With this libvirt could dynamically add a monitor, with auto
> > close, open it and pass the open FD back to the client app.
> > libvirt would not need to watch for when the client app is
> > gone as dropping the FD would cleanup the monitor.
> 
> Alright, that's fair.  The management application doesn't spawn
> something that wants a dedicated monitor, it makes one for a client.
> 
> Would this fit into a commit message somewhere?

Sure, it fits in the commit message for the auto-delete patch.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


