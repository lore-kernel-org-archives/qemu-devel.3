Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51014C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHn4J-0008Or-CN; Thu, 13 Jun 2024 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHn4G-0008Nb-Nl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHn4E-00015g-Ea
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718295169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V8kSWuKMRK0fpURoZ8jTcBnFyKoHrheYTuCO+wGXGS4=;
 b=bNZPE33G0pmavbJFIXIQw0ZnfMy/iJsAo4bJBgb3NlU2/xwabngC/eq1NE4ooLBDW31LV5
 blOfcxAQy6PFULrFnoYZefTvg9KhiDtW/DcHEx9EkadiS5NY5F38OZvckeHYuz4/fBslcp
 SPBKGyaQ8Rbor/CKZkcx72NQjulgKuA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-V1wxmZdqM1yJGv965IDpoQ-1; Thu,
 13 Jun 2024 12:12:46 -0400
X-MC-Unique: V1wxmZdqM1yJGv965IDpoQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F58195608F
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 16:12:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 889FB1956050; Thu, 13 Jun 2024 16:12:43 +0000 (UTC)
Date: Thu, 13 Jun 2024 17:12:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>
Subject: Re: Historical QAPI schema parser, "compiled schema", and
 qapi-schema-diff
Message-ID: <Zmsad48PjR66xpA3@redhat.com>
References: <CAFn=p-ZmjLKRN1kKo1iM_tiijYbOEqt5=vRg7WoAXuQ6E8Rm+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-ZmjLKRN1kKo1iM_tiijYbOEqt5=vRg7WoAXuQ6E8Rm+A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 13, 2024 at 02:13:15AM -0400, John Snow wrote:
> Hi, recently I've been working on overhauling our QMP documentation; see
> https://jsnow.gitlab.io/qemu/qapi/index.html for a recent work-in-progress
> page showcasing this.
> 
> As part of this project, Markus and I decided it'd be nice to be able to
> auto-generate "Since" information. The short reason for 'why' is because
> since info hard-coded into doc comments may not be accurate with regards to
> the wire protocol availability for a given field when a QAPI definition is
> shared or inherited by multiple sources. If we can generate it, it should
> always be accurate.
> 
> So, I've prototyped three things:
> 
> (1) An out-of-tree fork of the QAPI generator that is capable of parsing
> qemu-commands.hx, qmp-commands.hx, and all versions of our qapi-schema.json
> files going all the way back to v0.12.0.
> 
> It accomplishes this with some fairly brutish hacks that I never expect to
> need to check in to qemu.git.
> 
> (2) A schema "compiler", a QAPI generator module that takes a parsed Schema
> and produces a single-file JSON Schema document that describes every
> command and event as it exists on the wire without using type names or any
> information not considered to be "API".
> 
> This part *would* need to be checked in to qemu.git (if we go in this
> direction.)
> The compiled historical schema would also get checked in, for the QAPI
> parser to reference against to generate the since information.

The upside with checking in every historical schema is that we
have a set of self-contained schemas where you can see everything
at a glance for each version.

The downside with checking in every historical schema is that between
any adjacent pair of schemas 99% of the content is identical. IOW we
are very wasteful of storage.

Looking at your other mail about schema diffs, I wonder if we the
diff format you show there can kill two birds with one stone.

  https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02398.html

In my reply I had illustrated a variant of your format:

 - x-query-rdma
 -     returns.human-readable-text: str
 . blockdev-backup
 +     arguments.discard-source: Optional<boolean>
 . migrate
 -    arguments.blk: Optional<boolean>
 -    arguments.inc: Optional<boolean>
 . object-add
 .    arguments.qom-type: enum
 +        'sev-snp-guest'
 +    arguments[sev-guest].legacy-vm-type: Optional<boolean>
 +    arguments[sev-snp-guest].author-key-enabled: Optional<boolean>
 +    arguments[sev-snp-guest].cbitpos: Optional<integer>


Where '.' is just pre-existing context, and +/- have the obvious
meaning for the 2 given versions.

What if, we append a version number to *every* line, and exclusively
use +/-.

Taking just one small command:

 + 6.2.0: x-query-rdma
 + 6.2.0:    returns.human-readable-text: str
 - 9.1.0: x-query-rdma

This tell us 'x-query-rdma' was added in 6.2.0, the
'human-readable-text' parameter arrived at the same
time, and the whole command was then deleted in 9.1.0
That has implicit property deletion, but for completeness
we could be explicit about each property when deleting
a command:

 + 6.2.0: x-query-rdma
 + 6.2.0:    returns.human-readable-text: str
 - 9.1.0:    returns.human-readable-text: str
 - 9.1.0: x-query-rdma

Taking the more complex 'object-add' command

 +  2.0.0: object-add
 +  2.0.0:   arguments.qom-type: enum
 +  2.0.0:     '....'
 + 2.11.0:     'sev-guest'
 +  9.1.0:     'sev-snp-guest'
 + 2.11.0:   arguments[sev-guest].policy: uint32
 + 2.11.0:   arguments[sev-guest].session-file: str
 + 2.11.0:   arguments[sev-guest].dh-cert: str
 +  9.1.0:   arguments[sev-guest].legacy-vm-type: Optional<boolean>
 +  9.1.0:   arguments[sev-snp-guest].author-key-enabled: Optional<boolean>
 +  9.1.0:   arguments[sev-snp-guest].cbitpos: Optional<integer>


IOW, object-add was introduced in 2.0.0. The 'sev-guest' enum
variant was added in 2.11.0 with various fields at the same
time. The 'sev-guest' enum variant got an exctra field in 9.1.0
The 'sev-snp-guest' enum variant was added in 9.1.0 with some
fields.


For fields which change from Optional <-> Required, that could
be modelled simply as parameter deletion + addition in the
same version eg hypothetically lets say the 'sev-guest' field
'policy' had changed, we would see:

 +  2.0.0: object-add
 +  2.0.0:   arguments.qom-type: enum
 +  2.0.0:     '....'
 + 2.11.0:     'sev-guest'
 +  9.1.0:     'sev-snp-guest'
 + 2.11.0:   arguments[sev-guest].policy: uint32
 -  6.2.0:   arguments[sev-guest].policy: uint32
 +  6.2.0:   arguments[sev-guest].policy: Optional<uint32>
 + 2.11.0:   arguments[sev-guest].session-file: str
 + 2.11.0:   arguments[sev-guest].dh-cert: str
 +  9.1.0:   arguments[sev-guest].legacy-vm-type: Optional<boolean>
 +  9.1.0:   arguments[sev-snp-guest].author-key-enabled: Optional<boolean>
 +  9.1.0:   arguments[sev-snp-guest].cbitpos: Optional<integer>


Incidentally, if going down this route, I think I would NOT
have 1 file with the whole schema history, but have 1 file
per command / event. eg qapi/history/object-add.txt,
qapi/history/x-query-rdma.txt, qapi/history/VFIO_MIGRATION.txt,
etc. This will make it trivial for a person to focus in on
changes in the command they care about, likely without even
needing a schema diff tool much of the time, as the per-command
files will often be concise enough you can consider the full
history without filtering.


> (3) A script that can diff two compiled schema, showing a change report
> between two versions. (I sent an email earlier today/yesterday showing
> example output of this script.) This one was more for "fun", but it helped
> prove all the other parts were working correctly, and it might be useful in
> the future when auditing changes during the RC phase. We may well decide to
> commit this script upstream, or one like it.

With a single file containing all deltas, where each line is
version annotated, the "diff" tool becomes little more than
something which can 'grep' for lines in the file which have
a version number within the desired range. In fact it can also
optionally offer something better than a diff, as instead of
showing you only the orignal state and result state, it
can trivially shows you any intermediate changes and what
version they happened with. 

eg if you asked for a diff between 2.0.0 and 9.1.0, and there
was a command or property that was added in 4.0.0 and deleted
in 6.0.0, a traditional diff will not tell you about this. You'll
never notice it ever existed. 

A "history grep" showing the set of changes between 2 versions
will highlight things that come + go, which can be quite
useful for understanding API evolution I think.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


