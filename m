Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E6EC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfdr-0004JX-70; Wed, 21 May 2025 05:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHfdl-0004Em-6i
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHfdi-0007o1-Nb
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747819287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYfMj5TI3dULmWSb+lgdwwHSl5Dx/PEBOcEAgDYpkSU=;
 b=g4aJgoAkw2lSgmWoP/fhiGjGAJWEL0VpwQ0vEZuCnzgOmOF38mB7q+Ty73inxKEunvzc/k
 C14//ACThvmkdzvQViyKQTVD2oUsz+Dvk8KVAplnpaz2E1gShwJkzWm7q7nFYJ8bRQzrak
 3t5o9OCWXXp1QfMIucPG7V1Il3cG0WY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-os8aqRapNn6MISpTjkp7EA-1; Wed,
 21 May 2025 05:21:24 -0400
X-MC-Unique: os8aqRapNn6MISpTjkp7EA-1
X-Mimecast-MFC-AGG-ID: os8aqRapNn6MISpTjkp7EA_1747819283
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1519A195608E; Wed, 21 May 2025 09:21:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6E7A19560AD; Wed, 21 May 2025 09:21:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 311C521E6757; Wed, 21 May 2025 11:21:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
In-Reply-To: <aC2OIhz7-9-AWE9P@angien.pipo.sk> (Peter Krempa's message of
 "Wed, 21 May 2025 10:26:10 +0200")
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-3-armbru@redhat.com>
 <aC2EwjHq82ANZ83J@angien.pipo.sk> <aC2OIhz7-9-AWE9P@angien.pipo.sk>
Date: Wed, 21 May 2025 11:21:20 +0200
Message-ID: <87seky1fqn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Wed, May 21, 2025 at 09:46:10 +0200, Peter Krempa via Devel wrote:
>> On Wed, May 21, 2025 at 08:37:09 +0200, Markus Armbruster via Devel wrote:
>> > Argument @detach has always been ignored.  Start the clock to get rid
>> > of it.
>> > 
>> > Cc: Peter Xu <peterx@redhat.com>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  docs/about/deprecated.rst |  5 +++++
>> >  qapi/migration.json       | 18 +++++++++---------
>> >  2 files changed, 14 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> > index 9665bc6fcf..ef4ea84e69 100644
>> > --- a/docs/about/deprecated.rst
>> > +++ b/docs/about/deprecated.rst
>> > @@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
>> >  
>> >  Use ``job-finalize`` instead.
>> >  
>> > +``migrate`` argument ``detach`` (since 10.1)
>> > +''''''''''''''''''''''''''''''''''''''''''''
>> > +
>> > +This argument has always been ignored.
>> 
>> Huh; libvirt is actually always specifying it for some reason.
>> 
>> I'll post patches shortly getting rid of it completely in libvirt
>
> Patch 2/2 of
>
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/VPMPVPG5DSFORQODG4JGMZ2MTOJDQPPF/
>
> addresses the above. I noticed that 'dump-guest-memory' does also have
> 'detach' option but that one at least has effect, even when it's not
> really useful (blocking monitor if not used).

Another long-running task that should be a job...

> On behalf of libvirt:
>
> Series:
>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>

Thanks!


