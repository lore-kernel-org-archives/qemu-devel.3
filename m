Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90331D44171
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 09:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDhAL-00081V-Di; Wed, 20 Nov 2024 04:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDhAJ-000816-Ej
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDhAH-00041k-Ks
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732095503;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fZrImjEDk9x0Vg9FIldThZ8P2z5Iai8/bcbQRjENZ6k=;
 b=bMKANmbinWuVKdz3ujGQ44Ye4Q+WHrVngz49PIKQZYJb7r6W1tsH7YLNk8fTZG4tL/aZju
 WqX1jNNYsALNNz+wd4vH3c7H2Fl8mgWEVgy36bAVY3BXwgS+CniaJ4TSA1bUpM8lBcOLxb
 DVrkxUSd1KQb4vRJZV+2TAJaq4Rgx2A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-DRPHrZ9qOyS1UNUjOarG2A-1; Wed,
 20 Nov 2024 04:38:19 -0500
X-MC-Unique: DRPHrZ9qOyS1UNUjOarG2A-1
X-Mimecast-MFC-AGG-ID: DRPHrZ9qOyS1UNUjOarG2A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 522B3195419F; Wed, 20 Nov 2024 09:38:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6527030000DF; Wed, 20 Nov 2024 09:38:13 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:38:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <Zz2uAWLAhaf2TQ01@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
> On 11/19/2024 3:16 PM, Peter Xu wrote:
> > On Tue, Nov 19, 2024 at 02:50:40PM -0500, Steven Sistare wrote:
> > > On 11/14/2024 2:04 PM, Peter Xu wrote:
> > > > On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
> > > > > On 11/13/2024 4:58 PM, Peter Xu wrote:
> > > > > > On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
> > > > > > > Add the cpr-transfer migration mode.  Usage:
> > > > > > >      qemu-system-$arch -machine anon-alloc=memfd ...
> > > > > > > 
> > > > > > >      start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
> > > > > > > 
> > > > > > >      Issue commands to old QEMU:
> > > > > > >      migrate_set_parameter mode cpr-transfer
> > > > > > >      migrate_set_parameter cpr-uri <uri-2>
> > > > > > >      migrate -d <uri-1>
> > > > > > 
> > > > > > QMP command "migrate" already allows taking MigrationChannel lists, cpr can
> > > > > > be the 2nd supported channel besides "main".
> > > > > > 
> > > > > > I apologize on only noticing this until now.. I wished the incoming side
> > > > > > can do the same already (which also takes 'MigrationChannel') if monitors
> > > > > > init can be moved earlier, and if precreate worked out.  If not, we should
> > > > > > still consider doing that on source, because cpr-uri isn't usable on dest
> > > > > > anyway.. so they need to be treated separately even now.
> > > > > > 
> > > > > > Then after we make the monitor code run earlier in the future we could
> > > > > > introduce that to incoming side too, obsoleting -cpr-uri there.
> > > > > 
> > > > > I have already been shot down on precreate and monitors init, so we are
> > > > > left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
> > > > > on the incoming side.  That will confuse users, will require more implementation
> > > > > and specification work than you perhaps realize to explain this to users,
> > > > 
> > > > What is the specification work?  Can you elaborate?
> > > > 
> > > > > and only gets us halfway to your desired end point of specifying everything
> > > > > using channels.  I don't like that plan!
> > > > > 
> > > > > If we ever get the ability to open the monitor early, then we can implement
> > > > > a complete and clean solution using channels and declare the other options
> > > > > obsolete.
> > > > 
> > > > The sender side doesn't need to wait for destination side to be ready?
> > > > Dest side isn't a reason to me on how we should make sender side work if
> > > > they're totally separate anyway.  Dest requires -cpr-uri because we don't
> > > > yet have a choice.
> > > > 
> > > > Is the only concern about code changes?  I'm expecting this change is far
> > > > less controversial comparing to many others in this series, even if I
> > > > confess that may still contain some diff. They should hopefully be
> > > > straightforward, unlike many of the changes elsewhere in the series.
> > > > 
> > > > If you prefer not writting that patch, I am OK, and I can write one patch
> > > > on top of your series after it lands if that is OK for you. I still want to
> > > > have this there when release 10.0 if I didn't misunderstood anything, so
> > > > I'll be able to remove cpr-uri directly in that patch too.
> > > 
> > > I made the changes:
> > >    * implementation
> > >    * documentation in CPR.rst and QAPI
> > >    * convert sample code in CPR.rst, commit messages, and cover letter to QMP,
> > >      because a channel cannot be specified using HMP.
> > 
> > Yeah we can leave HMP as of now; it can easily be added on top with
> > existing helpers like migrate_uri_parse().
> 
> This begs the question, should we allow channels to be specified in hmp migrate
> commands and for -incoming, in a very simple way?  Like with a prefix naming
> the channel.  And eliminate the -cpr-uri argument. Examples:
> 
> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
> 
> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
> qemu -incoming main:defer,cpr:unix:cpr.sock

As a general rule, if you ever find yourself asking "should we add more
magic parsing logic" to the command line argv, the answer should always
be 'no'.

Any command line args where we need to have more expressive formatting
are getting converted to accept JSON syntax, backed by QAPI modelling.
We were anticipating that '-incoming' should ideally end up deprecated
except for the plain "defer" option, on the expectation that any non-
trivial use of migration needs HMP/QMP regardless. If there's a vaild
use case for something other than 'defer', then we need to QAPI-ify
-incoming with JSON syntax IMHO.

Yes, there's still the question of HMP, but personally I'm fine with
leaving feature gaps in HMP and expecting people to use QMP. HMP shares
all the same flaws as our old approach to the CLI, of needing to invent
arbitrary magic syntaxes which has proved to be an undesirble path to
take in general. I see HMP as being there for the 80% common / simple
cases, and if you need to go beyond that, then QMP is there for you.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


