Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54054106704F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0i5R-0004Vp-VI; Thu, 12 Mar 2026 11:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0i5Q-0004Vb-Sl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0i5O-0006sz-Jn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773329789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1eoVE5aK+jBUHDSJTotkCCILzNHwQpZY1aj6EQSqBs=;
 b=PHMixJ9TqZ8LdANDWnZqJUTRqdAp+mwxECxSOLI7Q1YUTlvVmLUlkD8XRVirQDpwWp1HKe
 tCAV3VyrX40VdEjXSLWEtoKvfleDu1d+Gg2Ka2xdbI65JmOiDFBandBgGd4EbAH2qmVJQI
 InNcGAwo6ySze2xDr5Lf0cTIjw94hsg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-w2DYXKW4Phawhn7x8eWpSA-1; Thu,
 12 Mar 2026 11:36:26 -0400
X-MC-Unique: w2DYXKW4Phawhn7x8eWpSA-1
X-Mimecast-MFC-AGG-ID: w2DYXKW4Phawhn7x8eWpSA_1773329784
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D26194510D
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:36:24 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.215])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7BCA180035F; Thu, 12 Mar 2026 15:36:22 +0000 (UTC)
Date: Thu, 12 Mar 2026 15:36:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] qga: rework slog to support multiple severity levels
Message-ID: <abLdcy6eoedHgeSV@redhat.com>
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <abLVj2eLZmKbPs9J@redhat.com>
 <CAPMcbCq4i8DhwRqPkJxywt6H==NRW=3_7NA0ZQhe8cMFtVGRCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCq4i8DhwRqPkJxywt6H==NRW=3_7NA0ZQhe8cMFtVGRCA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 12, 2026 at 05:15:05PM +0200, Kostiantyn Kostiuk wrote:
> On Thu, Mar 12, 2026 at 5:02 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Thu, Mar 12, 2026 at 04:16:57PM +0200, Elizabeth Ashurov wrote:
> > > ga_log() forwarded all "syslog" domain messages unconditionally,
> > > bypassing the log level filter. Furthermore, slog() hardcoded
> > > all messages to G_LOG_LEVEL_INFO, causing log spam from frequent
> > > guest-ping calls.
> > >
> > > - Split slog() into slog_error() (WARNING), slog() (MESSAGE), and
> > slog_trace() (INFO)
> > > - Apply s->log_level filtering to "syslog" in ga_log()
> > > - Move guest-ping to slog_trace()
> > > - Move error messages to slog_error()
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3214
> > >
> > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > ---
> > >  qga/commands-linux.c   |  6 ++++--
> > >  qga/commands-posix.c   | 13 +++++++------
> > >  qga/commands-win32.c   | 34 +++++++++++++++++-----------------
> > >  qga/commands.c         | 30 ++++++++++++++++++++++++------
> > >  qga/guest-agent-core.h |  2 ++
> > >  qga/main.c             |  6 +++++-
> > >  6 files changed, 59 insertions(+), 32 deletions(-)
> > >
> >
> > > diff --git a/qga/commands.c b/qga/commands.c
> > > index 5f20af25d3..ed52a7d3c2 100644
> > > --- a/qga/commands.c
> > > +++ b/qga/commands.c
> > > @@ -38,6 +38,24 @@ void slog(const gchar *fmt, ...)
> > >  {
> > >      va_list ap;
> > >
> > > +    va_start(ap, fmt);
> > > +    g_logv("syslog", G_LOG_LEVEL_MESSAGE, fmt, ap);
> > > +    va_end(ap);
> > > +}
> > > +
> > > +void slog_error(const gchar *fmt, ...)
> > > +{
> > > +    va_list ap;
> > > +
> > > +    va_start(ap, fmt);
> > > +    g_logv("syslog", G_LOG_LEVEL_WARNING, fmt, ap);
> > > +    va_end(ap);
> > > +}
> > > +
> > > +void slog_trace(const gchar *fmt, ...)
> > > +{
> > > +    va_list ap;
> > > +
> > >      va_start(ap, fmt);
> > >      g_logv("syslog", G_LOG_LEVEL_INFO, fmt, ap);
> > >      va_end(ap);
> >
> > This is really the wrong approach IMHO.
> >
> > It is bad practice for the call sites to be declaring what log
> > output they are targetting.
> >
> > Also the first parameter of g_log call is supposed to be the
> > "domain" which is a name that identicates the *source* of the
> > error message. For code in a library it would be the library
> > name, or a module name within the library. For applications
> > it would usually be the application name.
> >
> > Passing the name of a desired log target "syslog" is really
> > a misuse of the logging framework.
> >
> > IMHO the existing usage of "slog" should be replaced by
> > calls to g_error() (for the cases which are reporting error
> > messages) and g_info() (for the cases which are reporting the
> > names of commands being executed).
> >
> > Then, we should offer better command line control over the
> > usage of logging
> >
> >  "verbose" should enable g_info() or higher
> >  "debug" should enable g_debug() or higher
> >
> > The log file (if configured) should receive *all* messages
> > per the verbose/debug flag settings. (currently it misses
> > any messages that get sent to syslog which is bad as it
> > makes the logfile incomplete.
> >
> > The syslog output should also receive all messages at
> > "info" level of higher (provided the verbose flag is
> > set). It shouldn't get debug messages, even if 'debug'
> > flag is set.
> >
> > We should not specialcase the "ping" command either IMHO,
> > it should remain "info" like the other commands. Per that
> > bug, users can exclude ping messages via a log filter on
> > the systemd service config.
> >
> 
> What to do with Windows? We definitely want to see a freeze/thaw event in
> Event Viewer, but ping is also redundant there.

If we think of the recording of commands as more of an "audit" task,
we could expose an "audit" argument to control this. It would take
a list of command names, optionally with wildcards, and optionally
with negation

   audit = *

    => current default - all commands at "info" level

   audit = "!guest-ping,*"

    => a new default - all commands at "info" level, except ping

   audit = "!guest-ssh-get*,guest-ssh*"

    => a restrictive audit, only commands which modify ssh
       setup

anything not matched by the audit setting, would be logged at
g_debug instead of g_info


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


