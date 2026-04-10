Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043B8F459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEgI-0001KC-16; Fri, 10 Apr 2026 12:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEgD-0001Jt-Ty
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEgB-0004hY-C4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775838357;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B80+ptspUNmcChHxTEZ62OeTsDOdbGlVshBRS3l5X+0=;
 b=TtzCl5XK8EgCudT65L5N3igo/WgNx/e3/2XRWCwarFD/9uw/fJOjXG7uIUh4n/E6wDDwZH
 CD+MR7KhM3nq7lq0xG18GvZFkBVkb5fIEgT16ombyFk6OR9KmNkmEYWC/3S9YLW39ZpEi6
 i91y3TmKE5N6XEin5y0KBEHCfw0fgSg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-DtlTV85MPVmdjgRLFh2HEA-1; Fri,
 10 Apr 2026 12:25:53 -0400
X-MC-Unique: DtlTV85MPVmdjgRLFh2HEA-1
X-Mimecast-MFC-AGG-ID: DtlTV85MPVmdjgRLFh2HEA_1775838352
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388261954235; Fri, 10 Apr 2026 16:25:52 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D13619560AB; Fri, 10 Apr 2026 16:25:45 +0000 (UTC)
Date: Fri, 10 Apr 2026 17:25:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <adkkhkMdJxHY8rh-@redhat.com>
References: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
 <adgBbHDDcEhh9LpQ@redhat.com>
 <20260410-kupfer-rosten-9d08af140e1a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-kupfer-rosten-9d08af140e1a@brauner>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Apr 10, 2026 at 09:36:02AM +0200, Christian Brauner wrote:
> On Thu, Apr 09, 2026 at 08:43:40PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Apr 09, 2026 at 09:18:17AM +0200, Christian Brauner wrote:
> > > QEMU supports runtime hotplug for chardevs, devices, block backends,
> > > and netdevs. Monitors are the only major subsystem that lacks this --
> > > all QMP monitors must be configured at launch via -mon or -qmp CLI
> > > options.
> > > 
> > > This series adds monitor-add, monitor-remove, and query-monitors QMP
> > > commands so that management tools can create independent QMP sessions
> > > on demand at runtime.
> > 
> > There's nothing inherently wrong with your proposal. It is following
> > the standard historical design practice we've taken for enabling
> > hotplug/unplug of all the other backend types. Conceptually though
> > our historical practice is more of an accident of evolution rather
> > than an ideal state.
> > 
> > By this I mean we have a general purpose object framework
> > internally and commands '-object', and 'object_add' / 'object_del'
> > for hotplug/unplug in QMP and HMP. Conceptually these could handle
> > all of our objects, devices, netdev chardevs, monitors, etc, etc,
> > removing the need for the specialized add/remove QMP commands for
> > each backend type, and the specialized CLI argsf. 
> 
> If you actually plan on converting old types you're now left with two
> ways of adding objects. And if you plan on ultimately deprecating the
> old format it's going to be very annoying to fade those out.

We have two ways to dealing with this.

A formal deprecation & removal process which lets us fully
kill off the old way of doing things across 3 releases (1
year).

  https://www.qemu.org/docs/master/about/deprecated.html

We use that alot, but for something as fundamental as the
monitor I don't think we would take that route as the
impact on users is too great. Instead we would follow the
approach of preserving the existing CLI arg and internally
rewriting it to the new syntax. So we only have one (new)
code path internally, except for a thin shim as the CLI
layer for conversion which has minimal long term burden on
maintainers.

Eventually we're likely to have a clean compat back with
new binaries, where we can drop all the legacy cruft from
the CLI.

> > The blocker has been lack of time to convert everything/anything,
> > since while the conversions are not especially difficult they are
> > certainly time consuming due to the sheer number of types that
> > exist in many cases.
> > 
> > 
> > I'm thinking the monitor, however, is a decent opportunity to
> > "do the right thing" from a design POV. We only have three classes
> > needed in QOM, the monitor generic base class, a HMP subclass and
> > a QMP subclass.
> > 
> > If we convert QMP/HMP into QOM objects, we could then use the
> > pre-existing object_add/object_del commands in both HMP and QMP.
> > 
> > I'm not asking you to do that conversion work though. I've
> > been doing some experimentation myself today to test the
> > viability of this idea and it looks promising.
> 
> How difficult is this to do? I've had bad experiences with projects
> promising to do it all very differently and taking the patch away from
> me and then not following through or like 2 years later or the feature
> just vanished into nothing. I'm not saying this is the case here but I'm
> a bit weary of not having any way to move this forward myself other than
> "any news on this?" mails. It's frustrating for both sides.
> 
> So if this is doable just give me what you got and let me see whether I
> can take it over the finish line.

I've just posted a series which gets it as far as being able to
use -object and object_add.  I don't want your use case to be
delayed indefinitely - whichever design & impl, I'd want something
to be mergeable for the next schedule release. 

> Also, I really dislike spending a lot of time understanding something
> and it all working and then being told "actually, let me do this". I
> avoid this like the plague doing this to developers in the kernel.

I'm sorry I didn't notice your series when it was the v1 posting,
as I would have liked to raise this idea earlier. It is delicate
balancing act between being accessible to new contributions, vs
trying to align with longer term design preferences.

> > Given we've got an entire 4 month dev cycle before these
> > proposed monitor-add/remove commands could get into a QEMU
> > release, I think it is worth trialling the QOM conversion
> > for a short while.
> 
> I'm not sure what your governance model is so I'm just going to ask: Is
> this just a review or is this a project level decision?

This is just my design opinion as one of many QEMU maintainers,
albeit informed by many historical discussions on this topic.

Ultimately nothing is final until a patch series is accepted
and queued by a maintainer.

Hopefully others will give some input - I'm especialy looking
at Markus (CCd) for this as our QAPI & QMP design expert/maintainer.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


