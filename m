Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D37DCAC5A0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 11:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzwBE-0002RE-Nr; Sat, 20 Sep 2025 07:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uzwB4-0002Qn-AT; Sat, 20 Sep 2025 07:54:55 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uzwB1-0001Lq-W2; Sat, 20 Sep 2025 07:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=j8oX7mOlUQucL1r/ErQ+BdaybDE6MMjmvLB3+widkis=; b=H2jvEiZkeulkgcgU
 jNcgwy+3rSBjDO02ydkDgXLwQ/jNXd9bUGcio7O0W4HU7JJS0ZWevl1tb6hGFuS/maw+mGL4DQmeK
 1jjh5R/0CVyTXgaTb4OWfC0Q8NnCxKvdcRQu4scYPxVt8G6E26ci1DW6LcWDHn6VllJXhdcy4xOD3
 j7wG5lexY+QCJwouwuZnkq+HlQQivXN6ah5xQ1nplFfCGJuoSurYZUL8v7sgX+8HCEZNAhv+hbZlf
 jkbkYN/ARZQWc6DAuMzTKd9/8nnl5sxc072ZcmYdpuNfhaeWdz5hG9A2A5rkFGr/5Y4mL4uQ1iW6o
 mdbwo99TJhtMIqWfGA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uzwAx-00CHSs-2U;
 Sat, 20 Sep 2025 11:54:47 +0000
Date: Sat, 20 Sep 2025 11:54:47 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
Message-ID: <aM6WB4c1sMtfqM9p@gallifrey>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
 <87zfaqwr2a.fsf@pond.sub.org> <aM1aq1HNV7qJdrqI@redhat.com>
 <87ldm9txg0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldm9txg0.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:52:27 up 145 days, 20:06,  1 user,  load average: 0.06, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Sep 19, 2025 at 02:43:41PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().
> >> 
> >> "A number of"?  I can see just one:
> >> 
> >>     int error_vprintf(const char *fmt, va_list ap)
> >>     {
> >>         Monitor *cur_mon = monitor_cur();
> >> 
> >>         if (cur_mon && !monitor_cur_is_qmp()) {
> >>             return monitor_vprintf(cur_mon, fmt, ap);
> >>         }
> >>         return vfprintf(stderr, fmt, ap);
> >>     }
> >
> > Opps, that'll be referring to the other use of monitor_cur() in my
> > patches that I then removed when I re-ordered the series.
> >
> >> 
> >> > This is undesirable because monitor_cur_is_qmp() will itself call
> >> > monitor_cur() again, and monitor_cur() must acquire locks and do
> >> > hash table lookups. Introducing a monitor_cur_hmp() helper will
> >> > combine the two operations into one reducing cost.
> 
> I think the actual interface flaw is having monitor_cur_is_qmp().
> 
> In master, monitor_cur_is_qmp() is only used in monitor/monitor.c.  Both
> call sites have the value of monitor_cur() available as @cur_mon.
> They'd be better off calling monitor_is_qmp(cur_mon).
> 
> Note that in master nothing outside monitor/ cares whether a monitor is
> QMP or HMP.  I like that.
> 
> Your series doesn't preserve this property.
> 
> You move the first call site error_vprintf() from monitor/monitor.c to
> util/error-report.c in PATCH 11.  QMP vs. HMP is no longer encapsulated.
> Slighly irksome.

How about a slightly simpler approach, looking above we have:

> >>         if (cur_mon && !monitor_cur_is_qmp()) {
> >>             return monitor_vprintf(cur_mon, fmt, ap);
> >>         }
> >>         return vfprintf(stderr, fmt, ap);

I think we could replace this with:

  ret = monitor_vprintf(cur_mon, fmt, ap);
  if (ret == -1) {
       ret = vfprintf(stderr, fmt, ap);
  }
  return ret;

monitor_vprintf already -1 exits if !mon or monitor_is_qmp(mon)

Keeps the encapsulation, and is now 'print via the monitor but if it
can't do it, use printf'

Dave


> PATCH 13 replaces monitor_cur_is_qmp() by monitor_cur_hmp() there, and
> PATCH 14 adds a second use.
> 
> The second call site error_vprintf() gets inlined into ui/vnc.c by PATCH
> 10.  QMP vs. HMP leaks into ui/.  Again, only slighly irksome.
> 
> We could instead preserve the status quo: error_vprintf() stays put in
> monitor.c, error_printf_unless_qmp() stays around.
> 
> Independently, I feel we should drop monitor_cur_is_qmp() and not
> introduce monitor_cur_hmp().  Just use monitor_cur() and
> monitor_is_qmp().  Move monitor_is_qmp() from monitor-internal.h to
> monitor.h if it's needed outside the monitor.  Have to make it not
> inline then.
> 
> >> This made me expect the patch replaces the undesirable uses.  It does
> >> not; the new function remains unused for now.
> >> 
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  include/monitor/monitor.h      |  1 +
> >> >  monitor/monitor.c              | 14 ++++++++++++++
> >> >  stubs/monitor-core.c           |  5 +++++
> >> >  tests/unit/test-util-sockets.c |  1 +
> >> >  4 files changed, 21 insertions(+)
> >> >
> >> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> >> > index 296690e1f1..c3b79b960a 100644
> >> > --- a/include/monitor/monitor.h
> >> > +++ b/include/monitor/monitor.h
> >> > @@ -14,6 +14,7 @@ typedef struct MonitorOptions MonitorOptions;
> >> >  extern QemuOptsList qemu_mon_opts;
> >> >  
> >> >  Monitor *monitor_cur(void);
> >> > +Monitor *monitor_cur_hmp(void);
> >> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
> >> >  bool monitor_cur_is_qmp(void);
> >> >  
> >> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> > index e1e5dbfcbe..cff502c53e 100644
> >> > --- a/monitor/monitor.c
> >> > +++ b/monitor/monitor.c
> >> > @@ -84,6 +84,20 @@ Monitor *monitor_cur(void)
> >> >      return mon;
> >> >  }
> >> >  
> >> > +Monitor *monitor_cur_hmp(void)
> >> > +{
> >> > +    Monitor *mon;
> >> > +
> >> > +    qemu_mutex_lock(&monitor_lock);
> >> > +    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> >> > +    if (mon && monitor_is_qmp(mon)) {
> >> > +        mon = NULL;
> >> > +    }
> >> > +    qemu_mutex_unlock(&monitor_lock);
> >> > +
> >> > +    return mon;
> >> > +}
> >> > +
> >> >  /**
> >> >   * Sets a new current monitor and returns the old one.
> >> >   *
> >> > diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> >> > index b498a0f1af..1e0b11ec29 100644
> >> > --- a/stubs/monitor-core.c
> >> > +++ b/stubs/monitor-core.c
> >> > @@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
> >> >      return NULL;
> >> >  }
> >> >  
> >> > +Monitor *monitor_cur_hmp(void)
> >> > +{
> >> > +    return NULL;
> >> > +}
> >> > +
> >> >  bool monitor_cur_is_qmp(void)
> >> >  {
> >> >      return false;
> >> > diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> >> > index bd48731ea2..d40813c682 100644
> >> > --- a/tests/unit/test-util-sockets.c
> >> > +++ b/tests/unit/test-util-sockets.c
> >> > @@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >> >   * otherwise we get duplicate syms at link time.
> >> >   */
> >> >  Monitor *monitor_cur(void) { return cur_mon; }
> >> > +Monitor *monitor_cur_hmp(void) { return cur_mon; }
> >> 
> >> @cur_mon is a fake here.  Why do you make this fake monitor HMP?  If we
> >> somehow call error_vprintf(), it'll call monitor_vprintf(), which will
> >> dereference the fake monitor.  Best possible outcome would be an
> >> immediate crash.
> >
> > Current code has 'monitor_cur' return 'cur_mon', and 'monitor_cur_is_qmp'
> > (below)  return 'false'. IOW, the current behaviour of the stubs is that
> > 'cur_mon' is HMP, so I just maintained those semantics.
> 
> monitor_cur_is_qmp() below is from your PATCH 11, though.
> 
> > We've stubbed monitor_vprintf() too so it'll abort() no matter what, as
> > we don't expect that code path to be triggered from this test suite.
> 
> Point!  Nevermind :)
> 
> >> >  bool monitor_cur_is_qmp(void) { return false; }
> >> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> >> >  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> >
> >
> > With regards,
> > Daniel
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

