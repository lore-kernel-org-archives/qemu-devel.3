Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903ACC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIOb-0008Dh-Cl; Wed, 28 May 2025 11:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uKIOY-0008DL-AY
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:08:42 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uKIOW-0005Il-Gh
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=A444BULaFGdGRdAIQzV8pqnVG/O4oosLAevwi537/wk=; b=kNzdNRRs/Pf2x7Ux
 KJQ+xAWdF7Cs4fKhy2YV3aADt9v73GeTUJE1MLqTfyzZaytYyU2ZFiUJZe5peCANDF6i+Yx32Anjc
 s+BQM4TlSJRRswdN1fSWXC3S59WazRLnqRiDXpttR/KX31KtdMff/MkrG+k49fPv0sUx+nj1v16ZI
 WsIhL2KnAgozBHxaWG60YLxcJWius4lSDs1yq9gMYY5EulGeKoZvBPiy2UOfduasARgzqQgGfTNlo
 wYeI6SUXYNCl7sAU8g4Q8Voj9hWXw+SdJ7YJZu8T0WFgKZba36X2/uAWwDgZucM7AujXKtclfSTXM
 toH2CgMC0oZh6+RfHQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uKIOU-006Dk0-28;
 Wed, 28 May 2025 15:08:38 +0000
Date: Wed, 28 May 2025 15:08:38 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alexey Perevalov <a.perevalov@samsung.com>
Subject: Re: [PATCH 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
Message-ID: <aDcm9turgPlQ75BO@gallifrey>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-3-peterx@redhat.com>
 <878qmhjlma.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <878qmhjlma.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 15:08:12 up 30 days, 23:21, 1 user, load average: 0.03, 0.02, 0.00
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
> Peter Xu <peterx@redhat.com> writes:
> 
> > Unfortunately, it was never correctly shown..
> >
> > This is only found when I started to look into making the blocktime feature
> > more useful (so as to avoid using bpftrace, even though I'm not sure which
> > one will be harder to use..).
> >
> > So the old dump would look like this:
> >
> >   Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59
> >
> > Even though there're actually 40 vcpus, and the string will merge same
> > elements and also sort them.
> >
> > To fix it, simply loop over the uint32List manually.  Now it looks like:
> >
> >   Postcopy vCPU Blocktime (ms):
> >    [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
> >     33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
> >     40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
> >     22, 3, 0, 0, 0, 0, 0, 0, 0, 0]
> >
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Cc: Alexey Perevalov <a.perevalov@samsung.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration-hmp-cmds.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index 367ff6037f..3cf890b887 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -208,15 +208,20 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> >      }
> >  
> >      if (info->has_postcopy_vcpu_blocktime) {
> > -        Visitor *v;
> > -        char *str;
> > -        v = string_output_visitor_new(false, &str);
> > -        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
> > -                              &error_abort);
> > -        visit_complete(v, &str);
> > -        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
> > -        g_free(str);
> > -        visit_free(v);
> > +        uint32List *item = info->postcopy_vcpu_blocktime;
> > +        int count = 0;
> > +
> > +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> > +
> > +        while (item) {
> > +            monitor_printf(mon, "%"PRIu32", ", item->value);
> > +            item = item->next;
> > +            /* Each line 10 vcpu results, newline if there's more */
> 
> The list can be arbitrarily long?

One per vCPU, so a small arbitrary.

> > +            if ((++count % 10 == 0) && item) {
> > +                monitor_printf(mon, "\n  ");
> > +            }
> > +        }
> > +        monitor_printf(mon, "\b\b]\n");
> 
> Uh, backspace?

Agreed!

Dave

> I usually do something like
> 
>     sep = "";
>     for (...) {
>         printf("%s...", sep, ...);
>         sep = ", "
>     }
> 
> To add line breaks, I'd use something like
> 
>         sep = ... ? ", " : ",\n";
> 
> >      }
> >  
> >  out:
> 
> The less the string visitors are used, the happier I am.
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

