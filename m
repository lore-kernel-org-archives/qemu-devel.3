Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA87C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Ei-0007cS-PQ; Mon, 03 Jun 2024 08:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE7Ef-0007am-Q4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE7Ee-00026H-0E
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=56bE5cEwr1EKc5PfG8m648V0GQhkuijgoV5TkXqj/I8=;
 b=G03wCkijrJny7ygtB/dG2wBkVcL+0anESuzXHsfzjdktY0mTkdDCgwHvJQIjAgBZVSlRmJ
 /AzURQ4XyuC4sEaAd46m4qwDGYbeIS9cdFm+fc+svIJMNcXxXCBL0/xeL+gx5Q0mLShq7s
 z5PqxFxHqnhO1pJgsyo2QRJMrqIKSTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-yaFiz5ZUOK6b9z1dqMO24Q-1; Mon, 03 Jun 2024 08:56:18 -0400
X-MC-Unique: yaFiz5ZUOK6b9z1dqMO24Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BDA281101B;
 Mon,  3 Jun 2024 12:56:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16BA1402EB1;
 Mon,  3 Jun 2024 12:56:16 +0000 (UTC)
Date: Mon, 3 Jun 2024 13:56:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
Message-ID: <Zl29b8osUIBUICSm@redhat.com>
References: <20240531175153.2716309-1-tavip@google.com>
 <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 03, 2024 at 01:23:00PM +0100, Peter Maydell wrote:
> On Fri, 31 May 2024 at 22:21, Octavian Purdila <tavip@google.com> wrote:
> >
> > Add path option to the pty char backend which will create a symbolic
> > link to the given path that points to the allocated PTY.
> >
> > Based on patch from Paulo Neves:
> >
> > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/
> >
> > Tested with the following invocations that the link is created and
> > removed when qemu stops:
> >
> >   qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
> >   -chardev pty,path=test,id=compat_monitor0
> >
> >   qemu-system-x86_64 -nodefaults -monitor pty:test
> >
> > Also tested that when a link path is not passed invocations still work, e.g.:
> >
> >   qemu-system-x86_64 -monitor pty
> 
> Could we have some justification here for why the new
> functionality is useful, please? (e.g. what new use cases
> it permits).

The PTY paths are dynamically allocated so you can't predict them
as an app launching QEMU. You need to connect to the monitor and
interogate QEMU to find the path. So supporting a symlink simplifies
usage.

This was explained in the original patches' commit message, and
that description should have been kept.

> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -509,7 +509,7 @@
> >  ##
> >  # @ChardevHostdevWrapper:
> >  #
> > -# @data: Configuration info for device and pipe chardevs
> > +# @data: Configuration info for device, pty and pipe chardevs
> >  #
> >  # Since: 1.4
> >  ##
> > @@ -650,7 +650,7 @@
> >              'pipe': 'ChardevHostdevWrapper',
> >              'socket': 'ChardevSocketWrapper',
> >              'udp': 'ChardevUdpWrapper',
> > -            'pty': 'ChardevCommonWrapper',
> > +            'pty': 'ChardevHostdevWrapper',
> >              'null': 'ChardevCommonWrapper',
> >              'mux': 'ChardevMuxWrapper',
> >              'msmouse': 'ChardevCommonWrapper',
> 
> Does this break QAPI compatibility?

No, what matters for compatibility is the *contents* of the
struct, not the particular struct names. Since ChardevHostdevWrapper
is a superset of of ChardevCommonWrapper we are fine with back compat.

> 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 8ca7f34ef0..5eec194242 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
> >      "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> >      "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> >  #else
> > -    "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> > +    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> >      "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
> >  #endif
> >  #ifdef CONFIG_BRLAPI
> > @@ -3808,12 +3808,16 @@ The available backends are:
> >
> >      ``path`` specifies the name of the serial device to open.
> >
> > -``-chardev pty,id=id``
> > +``-chardev pty,id=id[,path=path]``
> >      Create a new pseudo-terminal on the host and connect to it. ``pty``
> >      does not take any options.
> 
> We just added an option, so we should delete the line saying
> that it doesn't take any options :-)


> 
> >
> >      ``pty`` is not available on Windows hosts.
> >
> > +    ``path`` specifies the symbolic link path to be created that
> > +    points to the pty device.
> 
> I think we could usefully make this a little less terse. Perhaps
>    If ``path`` is specified, QEMU will create a symbolic link at
>    that location which points to the new PTY device.
> ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


