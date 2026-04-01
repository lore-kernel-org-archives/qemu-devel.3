Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92039D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7uGa-0003gA-MR; Wed, 01 Apr 2026 08:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7uGN-0003bf-5b
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7uGJ-00028F-CZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775044889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUHqyMXx1DSG4MgHFGeromjSXqrQDq9VMgdJ1F2E85U=;
 b=O8TvhE118qiipV1myJKK01VJwq2hPBE+Os2ho0FFHbl8QrIXbMNqaC6M7g+vmCCPelrRG/
 vyu/U5DYQfiMo6zUrDbM2wKX5BkjmAhoXMJT9eX1rUXZV2Pr3uvXYjeDaabae41Cxw04hO
 jlpkjoY/3wzUcvpuIc8SA9VVSLd8qwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-kzILfA7bPxiweIchpEFuDg-1; Wed,
 01 Apr 2026 08:01:27 -0400
X-MC-Unique: kzILfA7bPxiweIchpEFuDg-1
X-Mimecast-MFC-AGG-ID: kzILfA7bPxiweIchpEFuDg_1775044886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2121D1964CDB; Wed,  1 Apr 2026 12:01:24 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BBBF30002DA; Wed,  1 Apr 2026 12:01:22 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:01:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
Message-ID: <ac0JDzYAs1_w2ofK@redhat.com>
References: <20260331110135.92883-1-machadovilaca@gmail.com>
 <871pgy3otf.fsf@pond.sub.org>
 <CAPMcbCpE3mGRhRBoMUqU7rW8jX0xv0zHSvyK+FMemAg5BNQqJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCpE3mGRhRBoMUqU7rW8jX0xv0zHSvyK+FMemAg5BNQqJg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On Wed, Apr 01, 2026 at 02:50:31PM +0300, Kostiantyn Kostiuk wrote:
> On Wed, Apr 1, 2026 at 2:25 PM Markus Armbruster <armbru@redhat.com> wrote:
> 
> > You neglected to cc: me.  We recommend to use scripts/get_maintainer.pl
> > to find all the maintainers, then use common sense to trim.
> >
> > João Vilaça <machadovilaca@gmail.com> writes:
> >
> > The commit message needs to explain why and how the patch is useful.
> >
> > For a patch adding a command to qemu-ga, like this one, it needs to
> > state the command's anticipated use cases.
> >
> > > ---
> > >  qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
> > >  qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
> > >  qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 187 insertions(+)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index 837be51c40..631a8a9ee6 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)
> > >      return ret;
> > >  }
> > >  #endif
> > > +
> > > +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
> > > +{
> > > +    const gchar *argv[] = {
> > > +        "nvidia-smi",
> > > +        "--query-gpu=index,name,driver_version,"
> > > +            "temperature.gpu,utilization.gpu,utilization.memory,"
> > > +            "memory.total,memory.free,memory.used",
> > > +        "--format=csv,noheader,nounits",
> > > +        NULL
> > > +    };
> > > +    g_autofree gchar *stdout_buf = NULL;
> > > +    g_autofree gchar *stderr_buf = NULL;
> > > +    gint exit_status;
> > > +    GError *gerr = NULL;
> > > +    GuestNvidiaGpuList *head = NULL, **tail = &head;
> > > +
> > > +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
> > > +                      G_SPAWN_SEARCH_PATH,
> > > +                      NULL, NULL,
> > > +                      &stdout_buf, &stderr_buf,
> > > +                      &exit_status, &gerr)) {
> >
> > Why not ga_run_command()?  Hmm, it throws away the command's output on
> > success.
> >
> > Kostiantyn, should ga_run_command() be rewritten on top of
> > g_spawn_sync()?
> >
> 
> The idea of ga_run_command was different.
> Now, we can improve it if we see new use cases.

It looks pretty simple to modify the existing ga_run_command to
return stdout &stderr as buffers, rather than discarding on
success.

Re-writing to use g_spawn_sync would not be required for that,
though it might be a nice thing todo at some point for platform
portability.


> > > +#
> > > +# Since: 10.1
> > > +##
> > > +{ 'command': 'guest-get-nvidia-smi',
> > > +  'returns': ['GuestNvidiaGpu'] }
> > > +
> > >  ##
> > >  # @GuestNetworkRoute:
> > >  #
> >
> > Why not use existing guest-exec, and leave the parsing to the client?
> >
> 
> I agree with Daniel that guest-exec is a command that should not exist.
> For example, in RHEL/CentOS, this command is disabled by default, and
> we recommend using SSH over VSock to run any command.
> We have seen the problem several times with guest-exec. Also, we have an
> upstream patch
> for guest-exec + SELinux support to try to workaround a security issue.
> Maybe we should discuss marking guest-exec as deprecated.
> 
> So, I agree with the author to add a separate command instead.

I'm somewhat sceptical that any of this should be in scope for the
QEMU agent, as opposed to being left as a job for an existing
general purpose monitoring agent.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


