Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FE1C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JAe-0002q4-9C; Thu, 17 Sep 2026 16:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x7JAc-0002pv-DE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:57:26 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x7JAa-00005g-6r
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=P5ZjY01EgPSYmgWfZZ272FJ1p54AnWlNzDDqUbfXwSI=; b=ZREwSM3IXsWV/wrT
 lqY5K0PAhyjdOYmRP21w5BBxV0K/6fNVLbpo3ZUq3IF3fzgXGwT1NecEldhTTLQ06gjowxNmkkspI
 7D+qjOy8iuNs+O8xzcuwChkRzCzY5phtM5W7qhO2zIRNJvmkAjNJfmTt+Jy8TGQnyOEt0VY+ho4tU
 oSzRuG3ujNeLlFFdo/q2A/rO5NrN3KhfMnb//WfRR7AuvjAgRzPqGCE/vDEjtph2JQpNY3c1DRLbn
 6kwBmXdlKkCQsGlGZ5zl7Mu2PiWKK8FBJfQkVX631s7jfOHdKvkFgmtzw/SG11Sjtrb6ezFLCfI0x
 k9Fb4PUqlptJukkW/g==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x7JAW-00000001iMI-3zew;
 Thu, 17 Sep 2026 20:57:20 +0000
Date: Thu, 17 Sep 2026 20:57:20 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 14/20] migration: Use output visitor in info command
Message-ID: <aqxUMH9Q3OtkV9oW@gallifrey>
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-15-farosas@suse.de>
 <87zexg2ix9.fsf@pond.sub.org>
 <aqw0anGmdLfHtv3q@zhexu-thinkpadt14gen5.rmtcaon.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aqw0anGmdLfHtv3q@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 20:55:48 up 5 days, 8:41, 2 users, load average: 0.04, 0.04, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Sep 17, 2026 at 01:53:22PM +0200, Markus Armbruster wrote:
> > Fabiano Rosas <farosas@suse.de> writes:
> > 
> > > The hmp_info_migrate_parameters function currently open-codes the
> > > mon_printf calls for each migration parameter. As with the set command
> > > in the last patch, this should not be necessary as the QAPI
> > > infrastructure already has generated code that takes type and struct
> > > member names into account, including converting _ from C into the '-'
> > > character as part of parameter names strings.
> > >
> > > The current code is also quite painful to rebase if a series has been
> > > carried for a long time while parameters have been added in master.
> > >
> > > Replace all of this with a conversion from MigrationParameters to
> > > QDict using an output visitor and a loop over the QDict that prints
> > > per-QAPI-type formatted strings.
> > >
> > > Modelled after block/qapi.c:dump_qobject, but with some changes to
> > > keep the migration command output formatting.
> > >
> > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > 
> > Old output of info migrate_parameters for me:
> > 
> >     announce-initial: 50
> >     announce-max: 550
> >     announce-rounds: 5
> >     announce-step: 100
> >     throttle-trigger-threshold: 50
> >     cpu-throttle-initial: 20
> >     cpu-throttle-increment: 10
> >     cpu-throttle-tailslow: off
> >     max-cpu-throttle: 99
> >     tls-creds: 
> >     tls-hostname: 
> >     tls-authz: 
> >     max-bandwidth: 134217728
> >     avail-switchover-bandwidth: 0
> >     max-postcopy-bandwidth: 0
> >     downtime-limit: 300
> >     x-checkpoint-delay: 20000
> >     multifd-channels: 2
> >     multifd-compression: none
> >     zero-page-detection: multifd
> >     xbzrle-cache-size: 67108864
> >     x-vcpu-dirty-limit-period: 1000
> >     vcpu-dirty-limit: 1
> >     mode: normal
> >     direct-io: off
> >     x-rdma-chunk-size: 1048576
> >     cpr-exec-command:
> > 
> > New output:
> > 
> >     cpu-throttle-tailslow: off
> >     xbzrle-cache-size: 67108864
> >     cpu-throttle-initial: 20
> >     announce-max: 550
> >     direct-io: off
> >     avail-switchover-bandwidth: 0
> >     local: off
> >     zero-page-detection: multifd
> >     multifd-qatzip-level: 1
> >     x-rdma-chunk-size: 1048576
> >     multifd-channels: 2
> >     mode: normal
> >     multifd-zstd-level: 1
> >     announce-initial: 50
> >     downtime-limit: 300
> >     tls-authz: 
> >     cpr-exec-command:
> > 
> >     vcpu-dirty-limit: 1
> >     multifd-compression: none
> >     announce-rounds: 5
> >     announce-step: 100
> >     tls-creds: 
> >     x-vcpu-dirty-limit-period: 1000
> >     multifd-zlib-level: 1
> >     max-cpu-throttle: 99
> >     max-postcopy-bandwidth: 0
> >     tls-hostname: 
> >     throttle-trigger-threshold: 50
> >     max-bandwidth: 134217728
> >     x-checkpoint-delay: 20000
> >     cpu-throttle-increment: 10
> > 
> > New output has an unwanted blank line after "cpr-exec-command:".
> > 
> > New output adds @local, @multifd-qatzip-level, @multifd-zlib-level,
> > @multifd-zstd-level.  Commit message should point that out.
> > 
> > Order of parameters changes, and not for the better.  Hmm.
> 
> Good point.. it might start to be awkward to users looking for tls-*,
> multifd-*, announce-* or cpu-throttle*, etc. after this change, expecting
> them grouped.
> 
> Maybe we can sort them by name with inserting top level to a QList first
> from the QDict.

Are there any filter visitors in qemu's visitor system - e.g. something that
sorts?

Dave

> We won't be able to keep all relevant fields together, for example, we used
> to have max-cpu-throttle together with cpu-throttle-*, now also separate
> even with alphabetical order, but it's a special case of bad name since the
> start.. where it could have been "cpu-throttle-max".  Meanwhile, as another
> good side effect, we can finally have max-* fields together too.
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

