Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1028CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgVf-0002j8-3I; Thu, 11 Sep 2025 08:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwgVd-0002iu-T4
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwgVX-0002ps-Aw
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757594070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ii7DpwrLzvm8SB/UD+grgd7m4GFe0HuWo9yd6BKLhdY=;
 b=YKilQmmI2Re6O4jXM5BjyNLq+GNzMjfYCdAJd6Q2iI5pay8pt/fkG+MtiqHrEW+rr1ZzSU
 difgWcxhtnz+9vQXI23vIBCU+RsR6zV2+K0vs9115pG/X5D1/Bv2Id2sucWDS5lDvtczYm
 ssUN3ef3SWAYcqFY4aB0yfKGQFY6PLY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-HMMWVYyIMz-10L4N7fXFsw-1; Thu,
 11 Sep 2025 08:34:27 -0400
X-MC-Unique: HMMWVYyIMz-10L4N7fXFsw-1
X-Mimecast-MFC-AGG-ID: HMMWVYyIMz-10L4N7fXFsw_1757594066
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AE271955EA8; Thu, 11 Sep 2025 12:34:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.221])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D751800446; Thu, 11 Sep 2025 12:34:22 +0000 (UTC)
Date: Thu, 11 Sep 2025 13:34:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: Re: The different ways QEMU logs stuff
Message-ID: <aMLByxJvls-SfG5y@redhat.com>
References: <87bjnhgpg8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjnhgpg8.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 02:10:15PM +0200, Markus Armbruster wrote:
> I fell into another rabbit hole: logging.  Here's my trip report.
> 
> We have:
> 
> * util/error-report.c
> 
>   - To stderr (or current monitor, but that's not relevant here)
> 
>   - Format:
>         [TIME ][GUEST-NAME ]PROGNAME:LOCATION: (|warning: |info: )MESSAGE
>     where the optional parts are controlled by -msg
> 
>   - Maintained: see MAINTAINERS "Error reporting"
> 
> * util/log.c
> 
>   - Control:
> 
>     · Some logging is always on
> 
>     · Some logging is off by default, enabled per "log item" with -d
> 
>     · Some can additionally be limited to address ranges with -dfilter
> 
>   - To the file given by -D (default stderr), or with -d tid to files
>     with names derived from the pattern given by -D (%d is replaced by
>     the thread ID)
> 
>   - Format:
>         [TIME ]MESSAGE
>     where the optional part is controlled by -msg timestamp (-msg
>     guest-name has no effect here)
> 
>   - Not covered by MAINTAINERS
> 
> * Tracing
> 
>   - Control: off by default, enabled with -trace per trace point (and
>     also -d trace: --- I find that duplication bizarre)
> 
>   - Run time control with HMP commands trace-event, trace-file, QMP
>     commands trace-event-get-state, trace-event-set-state
> 
>   - To whatever backends are compiled in:
> 
>     · "log" wraps around util/log.c's always-on logging
> 
>     · "simple" logs to a binary file given by -trace file=
> 
>     · "syslog" logs to POSIX syslog
> 
>     · "ftrace", "dtrace", "ust" integrate with Linux ftrace, DTrace /
>       SystemTap, and LTTng userspace tracing, respectively
> 
>   - Maintained: see MAINTAINERS "Traicing"
> 
> * Unstructured ad hoc printing to stdout or stderr
> 
> I think that's it.
> 
> Observations:
> 
> * Mixing logs with different formats in one destination makes them
>   needlessly hard to read and parse.
> 
>   Daniel's "util: sync error_report & qemu_log output more closely"
>   series makes util/error-report.c and util/log.c use a common message
>   prefix
> 
>       [TIME ][GUEST-NAME ]PROGNAME\(THREAD-NAME\):...
> 
>   where the optional parts are controlled by -msg.  Continues prior work
>   in that direction: commit 012842c0755 (log: make '-msg timestamp=on'
>   apply to all qemu_log usage).
> 
> * Spreading logs over multiple destinations can make the order hard to
>   determine.
> 
>   -D splits util/log.c from util/error-report.c.
> 
>   -d tid further splits per thread.
> 
>   Splitting per thread feels fairly redundant once the prefix includes
>   the thread name.  Thread names is easier to make sense of than numeric
>   thread IDs in the split filenames.

Also gives you a chronological record of the log across all threads
if we have it in one file avoiding cross-correlation needs.

> 
>   To keep the complete log in one place, avoid -D, and enable trace
>   backend "log".
> 
> * In my view, util/log.c consists of three layers.  Form bottom to top:
> 
>   * Logging messages: qemu_log()
> 
>   * Control of what to log ("log items"): qemu_log_mask()
> 
>   * Address filtering: qemu_log_in_addr_range()
> 
>   The bottom layer is also used by trace backend "log".
> 
> * Tracing vs. "log items"
> 
>   Tracing and "log items" both provide opt-in logging.
> 
>   Why do we have two?  Feels like an accident to me.
> 
>   When to use which?  I guess people pick whatever they're familiar
>   with.
> 
>   Would we be better off with just one?  I wish...
> 
>   Which one?  Clearly tracing, because tracing backends provide plenty
>   of useful functionality "log items" lack.
> 
>   "Log items" support per-thread log files.  With tracing, you could
>   instead split by thread names once Daniel's series is in.
> 
>   Address range filtering is only used with "log items".  It could just
>   as easily be used with tracing.

There is another trap door (or perhaps better described as back door).

qemu_log_trylock() returns the raw FILE * handle, which the callers
will directly write to. This is used instead of qemu_log() in a number
of places, and often has large data dumps written to it. This bypasses
any prefixes like timestamps, thread id, etc.  This direct FILE usage
would not map well over to tracing.

Also tracing wouldn't  allow qemu-user to provide its '-strace' CLI
arg, because we can't guarantee that QEMU is built with a trace
backend that will print to the console.

This makes it challenging (impossible) to entirely replace qemu_log
with tracing.


The other thing I find slightly wierd is 'info_report'. error vs
warning is clear - one is fatal, one is not, but the warning vs
info distinction is far from clearcut.

So warn_report vs info_report, also involves a choice of qemu_log(),
error_[v]printf(), fprintf(stderr, ...), g_printerr,  g_message,
g_critical, g_warning, g_info, and g_debug

... all of them are used somewhere in QEMU :-)

I feel like qemu_log ought to be obsoleted by glib's logging APIs,
but again we have the problem with the the raw FILE* usage for
large data dumps. Some glib APIs we use will already be using
glib's logging APIs, and we wire upa  custom backend for glib
to call into  info_report/warn_report/error_report, with glib's
DEBUG level squashed into info_report

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


