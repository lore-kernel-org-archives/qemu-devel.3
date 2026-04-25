Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDBFFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 05:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGVr0-0008Bi-N6; Sat, 25 Apr 2026 01:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGVqz-0008BZ-HC
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 01:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGVqx-0004ER-Gd
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 01:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777096013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OEMHJEnh7ykjTSp2XI5JG6YmW1fT0QxZhvhH0/aBwE=;
 b=H9dG1RDlnYLySL4Abi/WCYlF2a0vlmNvavcjBJpYAnlCjh42iN25QR0imLX7y+O5aWg7Fe
 AG0vcLQteawu9T3SV89PXsAbVANfi/jZujSd6A7/l368yXX41JlOQryUs4RjO/8on6zmvP
 /kQcmLFubGhX+PURj+jOVylSulkvPzY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-0WWexd5lMuCQ0Krn0QT1Mw-1; Sat,
 25 Apr 2026 01:46:51 -0400
X-MC-Unique: 0WWexd5lMuCQ0Krn0QT1Mw-1
X-Mimecast-MFC-AGG-ID: 0WWexd5lMuCQ0Krn0QT1Mw_1777096010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D9E18003FC; Sat, 25 Apr 2026 05:46:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A011180057E; Sat, 25 Apr 2026 05:46:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B3C921E6A28; Sat, 25 Apr 2026 07:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Avihai Horon
 <avihaih@nvidia.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,  Kirti Wankhede <kwankhede@nvidia.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v2 14/16] migration/qapi: Introduce system-wise
 "remaining" reports
In-Reply-To: <aeuJCI0OCW-ohJih@x1.local> (Peter Xu's message of "Fri, 24 Apr
 2026 11:15:20 -0400")
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-15-peterx@redhat.com>
 <87cxzovncu.fsf@pond.sub.org> <aeuJCI0OCW-ohJih@x1.local>
Date: Sat, 25 Apr 2026 07:46:45 +0200
Message-ID: <87jytvoam2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Apr 24, 2026 at 09:17:21AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Currently, mgmt can only query for remaining RAM,
>> 
>> Remind me: how?
>
> It is the same command, as mentioned in [1] below.  I'll enrich the commit
> message here to explain.
>
>> 
>> >                                                   not system-wise remaining
>> > data.  It was not a problem before, because for a very long time RAM was
>> > the only part that matters.
>> >
>> > After VFIO migrations landed upstream, it may not be true anymore
>> > especially considering that there can be GPU devices that contain GBs of
>> > device states.
>> >
>> > Add a new "remaining" field in query-migrate results, reflecting
>> > system-wise remaining data, which will include everything (e.g. VFIO).
>> 
>> "system-wise"?  Do you mean "system-wide"?  Maybe "total"?
>
> Since "total" has been used elsewhere, I'll use "system-wide", hoping
> that's easier to digest.

Which "total" do you mean?  Perhaps MigrationStats member

    # @total: total amount of bytes involved in the migration process

What does this @total count?  RAM only?  If yes, the description is
misleading and needs fixing.  Separate patch, followup fine.

>> > This information will be useful for mgmt to implement generic way of stall
>> > detection that covers all system resources.  Say, when system remaining
>> > data does not decrease anymore for a relatively long period of time, then
>> > it may mean that there is a challenge of converging, so mgmt can act based
>> > on how this value changes over time (especially if sampled after each
>> > migration iteration).
>> >
>> > Before this patch, "expected_downtime" almost played this role. For
>> > example, by monitoring "expected_downtime" at the beginning of each
>> > iteration can in most cases also reflect the progress of migration
>> > system-wise.  Said that, "expected_downtime" was always calculated based on
>> > a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
>> > not used. This new "remaining" field will remove that part of uncertainty
>> > for mgmt.
>> >
>> > With the new field, HMP "info migrate" now reports this:
>> >
>> > (qemu) info migrate
>> > Status:                 active
>> > Time (ms):              total=12080, setup=14, exp_down=300

"exp_down" isn't nice for humans.  I *guess* it's for "expected
downtime".  Could use "expected_downtime=300" instead.  Not this patch's
problem, of course.

>> > Remaining:              1.36 GiB        <------------------- newline
>> 
>> "Newline" is ASCI character '\n'.  I guess you mean "this is the new
>> line".
>
> Yes.  I'll remove this "<----..." if it causes any confusion.

Annotating output like you did feels just fine, only the word you chose
makes it mildly confusing.  Perhaps

     Remaining:              1.36 GiB        <--- this is the new line

would be clearer.

>> > RAM info:
>> >   Throughput (Mbps):    840.50
>> >   Sizes:                pagesize=4 KiB, total=4.02 GiB
>> >   Transfers:            transferred=1.18 GiB, remain=1.36 GiB
>> >     Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
>> >     Page Types:         normal=307923, zero=388148
>> >   Page Rates (pps):     transfer=25660
>> >   Others:               dirty_syncs=1
>> >
>> > It should be the same value as RAM's remaining report when VFIO is not
>> > involved, and it should report more than that when VFIO is involved.
>> 
>> "RAM's remaining report" is the "remain=1.36 GiB" part, isn't it?
>
> [1]
>
> Correct.

Thanks.  Could be a bit more explicit.  Up to you.

>> > Cc: Markus Armbruster <armbru@redhat.com>
>> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
>> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  qapi/migration.json            | 4 ++++
>> >  migration/migration-hmp-cmds.c | 5 +++++
>> >  migration/migration.c          | 7 +++++++
>> >  3 files changed, 16 insertions(+)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index e3ad3f0604..a6e24b5685 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -300,6 +300,9 @@
>> >  #     average memory load of the virtual CPU indirectly.  Note that
>> >  #     zero means guest doesn't dirty memory.  (Since 8.1)
>> >  #
>> > +# @remaining: amount of bytes remaining to be migrated system-wise,
>> > +#     includes both RAM and all devices (like VFIO).  (Since 11.1)
>> > +#
>> >  # Features:
>> >  #
>> >  # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
>> > @@ -310,6 +313,7 @@
>> >  ##
>> >  { 'struct': 'MigrationInfo',
>> >    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
>> > +           '*remaining': 'uint64',
>> 
>> It's a byte count, so let's make it 'size'.
>
> Will do.
>
> Since this will be the last functional change so far on the whole series,
> and the update seems to be pretty under control (say, qapi schema.py
> generates same c code for both "size" and "uint64"),

Yes, 'size' is almost exactly the same as 'uint64'.  If I remember
correctly, the one difference is the use of visit_type_size() instead of
visit_type_uint64().  visit_type_size() recognizes additional syntax
with "human" visitors: qobject keyval, string input, and opts visitor.

>                                                      could I request an ACK
> on this one with a short diff below, instead of reposting the whole series?
>
> The diff attached here (I'll also fix the commit messages on
> e.g. system-wide wordings if I'll not repost):
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7518b29c6..c701ef1cf5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -300,7 +300,7 @@
>  #     average memory load of the virtual CPU indirectly.  Note that
>  #     zero means guest doesn't dirty memory.  (Since 8.1)
>  #
> -# @remaining: amount of bytes remaining to be migrated system-wise,
> +# @remaining: amount of bytes remaining to be migrated system-wide,
>  #     includes both RAM and all devices (like VFIO).  (Since 11.1)
>  #
>  # Features:
> @@ -313,7 +313,7 @@
>  ##
>  { 'struct': 'MigrationInfo',
>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
> -           '*remaining': 'uint64',
> +           '*remaining': 'size',
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
>
> ===8<====
>
> The complete new version of patch is here (I updated quite a few places on
> the commit message):
>
> https://gitlab.com/peterx/qemu/-/commit/86d973360890cecc564a4a5bcf9a01b9efde368a
>
> Thanks,

I read the commit message.  No surprises except

    It should be the same value as RAM's remaining report when VFIO is not
    involved, and it should report more than that when VFIO is involved.

    One note is that this field will be an estimate and may not be sampled the
    exact same time versus the RAM remaining section.  So it may report
    slightly different values even if only RAM is involved.  The difference
    shouldn't matter though to mgmt to make correct decisions.

The second paragraph is new.  The first paragraph says they "should be
the same", the second that they "may [be] slightly different".
Suboptimal.

Here's my try:

    It should be approximately the same value ...

    Only approximately, because this field will be ...

It's just a commit message, though.  Up to you.

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


