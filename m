Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E1AF9B5F3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFgLQ-0008Jk-Ub; Wed, 22 Apr 2026 18:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFgLP-0008Hg-Vy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:46:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFgLN-0000T9-Pe
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:46:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB9EB5BD50;
 Wed, 22 Apr 2026 22:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776898011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UEehTvoLjVcQYrJzHBh93pibFc6gJJA+Gqlu+mdIKw=;
 b=gbkiZg2Yx9fr2NpOtm9zT++OBHiqK/WOLLkuPm7uxfEKrsmSCCgqeNNAVuH9fW4IhkG1A3
 8I+ogpo0vymw+2XBZ0qHpHrBNJVnKqC/cGd1rf9maaainqEz7TXm2w/yZdMMMBZp9ChSoz
 tc8vW24VPgRUdAQm6fvUccwPi7P36iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776898011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UEehTvoLjVcQYrJzHBh93pibFc6gJJA+Gqlu+mdIKw=;
 b=acsclhN9UdubOKodUbGZBCta3zUrMbM+Um6LXNdWpwY9nOU8jcblOEKadXygHIYKpQHEJ/
 hCeK7LA/LUx1RZBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gbkiZg2Y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=acsclhN9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776898011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UEehTvoLjVcQYrJzHBh93pibFc6gJJA+Gqlu+mdIKw=;
 b=gbkiZg2Yx9fr2NpOtm9zT++OBHiqK/WOLLkuPm7uxfEKrsmSCCgqeNNAVuH9fW4IhkG1A3
 8I+ogpo0vymw+2XBZ0qHpHrBNJVnKqC/cGd1rf9maaainqEz7TXm2w/yZdMMMBZp9ChSoz
 tc8vW24VPgRUdAQm6fvUccwPi7P36iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776898011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UEehTvoLjVcQYrJzHBh93pibFc6gJJA+Gqlu+mdIKw=;
 b=acsclhN9UdubOKodUbGZBCta3zUrMbM+Um6LXNdWpwY9nOU8jcblOEKadXygHIYKpQHEJ/
 hCeK7LA/LUx1RZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B369593AF;
 Wed, 22 Apr 2026 22:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id he46C9tP6Wm6RQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Apr 2026 22:46:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org, Jim Fehlig
 <jfehlig@suse.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
In-Reply-To: <ad1a9GaGQFHS4UHx@x1.local>
References: <20260405152612.93027-1-viking4@gmail.com>
 <878qb05gq7.fsf@suse.de> <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de> <ad1a9GaGQFHS4UHx@x1.local>
Date: Wed, 22 Apr 2026 19:46:45 -0300
Message-ID: <87ldeeehpm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,suse.com,redhat.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BB9EB5BD50
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Apr 09, 2026 at 12:08:34PM +0200, Claudio Fontana wrote:
>> On 4/8/26 22:04, Peter Xu wrote:
>> > On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
>> >> Trieu Huynh <vikingtc4@gmail.com> writes:
>> >>
>> >>> From: Trieu Huynh <vikingtc4@gmail.com>
>> >>>
>> >>> When query-migrate is called on the *destination* QEMU after a preco=
py
>> >>> migration completes it returns only {"status": "completed"} =E2=80=
=94 no timing,
>> >>> no RAM statistics.  The source correctly returns total-time, downtim=
e,
>> >>> setup-time, and full ram stats.
>> >>>
>> >>> This series fixes the gap in two commits:
>> >>>
>> >>> * commit 1: Track start/end timestamps and per-page-type counters in
>> >>>   MigrationIncomingState, recorded in the receive path.
>> >>>
>> >>> * commit 2: Make source-only MigrationStats fields optional in the Q=
API
>> >>>   schema so the destination can populate info->ram with only the fie=
lds
>> >>>   that are meaningful on the receive side.  Fields computed from tra=
cked
>> >>>   counters (transferred, normal, duplicate, mbps, pages-per-second) =
are
>> >>>   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) =
are
>> >>>   absent.
>> >>>
>> >>> The QAPI change (commit 2) is ABI-compatible: optional fields that a=
re
>> >>> not set are simply absent from the output.  Source-side callers are
>> >>> unaffected because populate_ram_info() sets all optional fields via
>> >>> has_* setters, so the source output is identical to before.
>> >>>
>> >>> On dst, {"execute":"query-migrate"}
>> >>> * As-is:
>> >>> {
>> >>>     "return": {
>> >>>         "status": "completed"
>> >>> }
>> >>> * To-be:
>> >>> {
>> >>>     "return": {
>> >>>         "status": "completed",
>> >>>         "total-time": 94,
>> >>>         "ram": {
>> >>>             "total": 554508288,
>> >>>             "pages-per-second": 1440234,
>> >>>             "page-size": 4096,
>> >>>             "remaining": 0,
>> >>>             "mbps": 97.955404255319152,
>> >>>             "transferred": 1150976,
>> >>>             "duplicate": 135101,
>> >>>             "normal-bytes": 1150976,
>> >>>             "normal": 281
>> >>>         }
>> >>>     }
>> >>> }
>> >>>
>> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
>> >>>
>> >>> Trieu Huynh (2):
>> >>>   migration: track timing and received pages in MigrationIncomingSta=
te
>> >>>   migration: expose RAM stats and timing on destination via
>> >>>     query-migrate
>> >>>
>> >>>  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>> >>>  migration/migration.h | 17 +++++++++++++++++
>> >>>  migration/ram.c       |  3 +++
>> >>>  qapi/migration.json   | 14 +++++++-------
>> >>>  4 files changed, 64 insertions(+), 7 deletions(-)
>> >>
>> >> Hi, remember to copy the interested people in your series. Using
>> >> get_maintainers is correct, but when there's already a discussion abo=
ut
>> >> the topic it's good to add some CCs manually.
>> >>
>> >> +CC Daniel and Claudio
>> >=20
>> > The request is a valid one.  Said that, redo accounting on both sides =
seem
>> > to be a duplicated work and overkill to me, if src has everything.
>> >=20
>> > Is there a way we can make Libvirt always query the results before src=
 dies
>> > and report it somewhere?  I recall these info were captured somewhere,=
 do
>> > we at least dump them into logs?
>> >=20
>> > Thanks,
>> >=20
>>=20
>> I am interested in the outcome, but I think the approach shown here is f=
ine, the amount of duplication seems minimal to me.
>>=20
>> That said if we _have_ to keep libvirt in the picture, I think I see a p=
ossible alternative, but then the feature is not available to anyone that d=
oes not use libvirt. At the same time, if libvirt is not used, one is free =
to keep source QEMU alive and query the stats, like I think Proxmox does.
>
> The problem is here from QEMU's perspective we have all the information,
> and "not quit" is the default behavior for src QEMU.  It means by default
> all info is available.. this is true for no matter what upper mgmt is in
> use.
>
>>=20
>> So with libvirt, I think we need a way to tell libvirt to keep the sourc=
e QEMU alive before the actual switchover and the source QEMU is destroyed,
>> so that we can do everything that needs to be done from the platform lay=
er before the source QEMU is lost.
>> It might go beyond querying for stats using QEMU and libvirt.
>>=20
>> Something similar to (and potentially combined with) virDomainMigrateFla=
gs VIR_MIGRATE_PAUSE, for example:
>>=20
>> VIR_MIGRATE_NO_SOURCE_SHUTOFF
>>=20
>> So one might say:
>>=20
>> flags =3D VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDE=
FINE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
>> new_domain =3D virDomainMigrate3(old_domain, conn, params, nparams, flag=
s)
>>=20
>> and then we could do everything that needs to be done from the platform =
layer,
>> then issue a virDomainResume to start the domain on destination,
>> and maybe a virDomainDestroyFlags on the original domain to terminate it=
 on the source.
>>=20
>> But I would still favor the simplicity and the overall applicability of =
this series from Trieu Huynh.
>
> I still think it'll be great we only do accounting once, and above sounds
> like a libvirt question that I don't know the answer. Adding Jiri and
> libvirt list in case we can collect some inputs.
>
> If you're looking for this feature, IMHO it'll be great if you can have a
> look at least from libvirt side to see if there's any blocker for
> collecting this info from src, then we can evaluate the rest. E.g. there's
> at least another option to forward statistic data from src to dest.  Then
> we don't worry on mismatched accounting, or when fixing / add new
> accounting we don't need to do it both sides, which will be awkward.

I came to the thread to suggest this, but I see you already mentioned
it. I'm not sure what you mean by "forward", but I was actually thinking
"migrate". Do we have precedent for migrating a QAPI object? Do we want
to have it? =3D) Put that MigrationInfo at the end of the stream and we'd
have a nice symmetric interface for query-migrate in both src and dst.

(we have plans to deal with QEMU_VM_VMDESCRIPTION at some point anyway,
we could maybe rework that end section into something useful)

>
> Thanks,
>
>>=20
>> Thanks,
>>=20
>> Claudio
>>=20

