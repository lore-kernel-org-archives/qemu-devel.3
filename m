Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDC3CD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpkp-0001fH-Ji; Wed, 03 Jun 2026 13:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUpkn-0001eY-SO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:51:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUpkl-0001BF-Vd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:51:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E220067B3E;
 Wed,  3 Jun 2026 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780509101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jILnN52HeJbupE5C6kcL6CuARq/krVTFt0OfzCCG1OY=;
 b=0npQYik2fb4h4uLixEyTA52F5Qss/SHlLxULJO72runp4WnXgm4r4HUrVoSnFLMix4+KlJ
 Ys8/MjN3saR6/8wWw9PoqD5BtKwfWU5Xd9JVumF1IeCX4hd7BdKMvV2iX5jpGvrlBvleQw
 DGNOXmzEajArnahgkwEA3sCyubQ84Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780509101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jILnN52HeJbupE5C6kcL6CuARq/krVTFt0OfzCCG1OY=;
 b=bXzxdMI8/deGUj5LQiVr1wt3R/9jwlpMamv7rkBdecUQ8q8y50bU8v9Qc5BKYqVM4N7Bmy
 dGtofVLUXT2g9qBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="B92X/HAu";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="c/zJUD5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780509096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jILnN52HeJbupE5C6kcL6CuARq/krVTFt0OfzCCG1OY=;
 b=B92X/HAukxfvdGXuxvrGW+QpveZJSUW5gi+J9rCa+FFG/cOIG+1tr+g/9DbH63oHZN45a/
 sWss0ibyTbw9CA99adtp3U61MyIS4ico7lN7bcSDYqUtl4Ode9La4fdItMHBYAUhMwxQtx
 60qOJ6sRI/ooD4S1Py3qUxE5sPBaUgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780509096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jILnN52HeJbupE5C6kcL6CuARq/krVTFt0OfzCCG1OY=;
 b=c/zJUD5q7jhUulUwm+axcDuV4958w0M5RYaaD5ulb+93fivdATMumcXl2qmOuM594cx8+S
 OcrBnUD/CqdWrNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1C7779A7;
 Wed,  3 Jun 2026 17:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHRaE6hpIGquPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 03 Jun 2026 17:51:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>, Jason Wang
 <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
In-Reply-To: <aiBhTTqSctU9lFsS@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com>
Date: Wed, 03 Jun 2026 14:51:30 -0300
Message-ID: <87o6hr7brx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E220067B3E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,gitlab.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 03, 2026 at 11:50:53AM -0400, Peter Xu wrote:
>> On Wed, Jun 03, 2026 at 10:48:54AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> > On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
>> > > On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
>> > > > Peter Xu <peterx@redhat.com> writes:
>> > > >=20
>> > > > > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
>> > > > >
>> > > > > This series introduces a generic way to specify migration parame=
ters that
>> > > > > can be used even during the early boot phase of QEMU.
>> > > > >
>> > > > > One example use case that already existed is CPR-transfer / CPR-=
exec.
>> > > > > currently QEMU has a temporary global variable (incoming_mode) t=
o achieve
>> > > > > this, but it's hard to understand and this hack bleeded into qui=
te a few
>> > > > > places that we could have avoided.  The lines in patch 2 touched=
 may
>> > > > > provide some idea.
>> > > > >
>> > > > > With a generic approach of setting migration parameters with cmd=
lines, we
>> > > > > can remove this hack meanwhile QEMU should be able to keep the C=
PR behavior
>> > > > > as before.  To CPR maintainers and reviewers: please have a clos=
er look,
>> > > > > even better if it can be smoke tested, to see if this works for =
Oracle's
>> > > > > environment, TIA.
>> > > > >
>> > > > > The 1st patch implemented that new semantics.  It is straightfor=
ward: now
>> > > > > we can setup any migration parameter using an extra line of:
>> > > > >
>> > > > >   -incoming config:key1=3Dvalue1,key2=3Dvalue2,...
>
> snip
>
>> > > > - using "config:"
>> > > >=20
>> > > > This makes it non-uniform with uri and channels which don't have a
>> > > > keyword in front of them. I guess I could live with it, but it see=
ms
>> > > > odd. I see that it makes parsing way easier.
>> > >=20
>> > > Yeah, having some identifier would be nice.  I wished channels also =
have
>> > > identifiers if we don't need to keep compatibility.
>> >=20
>> > IMHO having a magic "config:" prefix is an anti-pattern because it
>> > involves custom command line parsing logic.
>>=20
>> Yes, it's not elegant.  I wished we had something like this though when
>> introducing the cpr channels; right now anything wasn't "defer" or URI
>> implies it's a "channel"..
>>=20
>> I also wanted to avoid introducing new cmdline parameters, so migration
>> incoming cmdlines can stick with the same option.  If there's better
>> suggestion please shoot.
>>=20
>> >=20
>> > Does "-incoming config" imply '-incoming defer' semantics or is it
>> > independent ?=20=20
>>=20
>> They're independent.  Examples:
>>=20
>>  a) "-incoming config:* -incoming tcp:*", setup parameters for TCP incom=
ing
>>     migration without further deferral
>>=20
>>  b) "-incoming config:*" only, setup global parameters for a possible
>>     upcoming outgoing migration
>
> In that case they should definitely be independent command line
> options. The old "-incoming" design is already broken / limited
> in the non-'defer' case because it is hardcoded to use URI syntax
> which can't express all the address formats we accept in QAPI
> syntax. Adding more special cases onto -incoming just makes the
> bad situation even worse and is not a forward looking design.
>
> If we need the ability to specify migration parameters on the
> CLI, then as a starting point for the design, we should assume that
> -incoming does not exist, and design a complete solution from scratch
> that uses QAPI exclusively, both for addresses and configuration.
>
> As discussed before, IMHO the "migrate" and "migrate-incoming"
> commands need to accept both the address(s) and parameters/capabilities
> as inline data items rather than relying on pre-configured global state
> from the 'migrate-parameter' / 'migrate-capability' commands.
>
> If we did that modelling for 'migrate-incoming' then that modelling of
> command parmaeters could map directly to a new '-migrate-incoming'
> command line argument that accepted exactly the same data model.
>

Maybe a user creatable object would better fit this use case instead of
a new command. We could expose what is today MigrationParameters plus
the few compat options from migration_properties. It could work more or
less the same for the QMP migration commands, QMP set/get commands,
source and destination command lines, the compatibility use-case and the
debugging use-case.

