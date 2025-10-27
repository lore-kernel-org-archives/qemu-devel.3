Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F4CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNh2-0006VB-In; Mon, 27 Oct 2025 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDNgx-0006Uv-9Y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:55:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDNgl-0000ZL-3j
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:55:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 828C221A92;
 Mon, 27 Oct 2025 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761573302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pyeJYXHGaSqkeZZ0wF0DOcwPh7gNuUyrXP+8J1n79Y=;
 b=nN4FIgs991zejoYf/BZFalKzxm0FSKVhZHj3tUIcifB8KZ4o1iPUSlhv+EW4iOdPQoumCa
 xPk18tsHRGzTeE0/QGYgi4sC1tE4hYEFsxLNQktEmFaBh3P8fDwzBSAzz7IK/FdeAdhovN
 dT8OBjxEg+XAupvag1Rt8MKG+y+G2IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761573302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pyeJYXHGaSqkeZZ0wF0DOcwPh7gNuUyrXP+8J1n79Y=;
 b=5vpekhlgj7+6V0QzKBQSXStvG/vIN3IcoPuCKiF/YTS6Gxv0LpzXuLx/Dpbr+9S8VVyTMe
 Olfw1yWGjI2jWvDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nN4FIgs9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5vpekhlg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761573302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pyeJYXHGaSqkeZZ0wF0DOcwPh7gNuUyrXP+8J1n79Y=;
 b=nN4FIgs991zejoYf/BZFalKzxm0FSKVhZHj3tUIcifB8KZ4o1iPUSlhv+EW4iOdPQoumCa
 xPk18tsHRGzTeE0/QGYgi4sC1tE4hYEFsxLNQktEmFaBh3P8fDwzBSAzz7IK/FdeAdhovN
 dT8OBjxEg+XAupvag1Rt8MKG+y+G2IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761573302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pyeJYXHGaSqkeZZ0wF0DOcwPh7gNuUyrXP+8J1n79Y=;
 b=5vpekhlgj7+6V0QzKBQSXStvG/vIN3IcoPuCKiF/YTS6Gxv0LpzXuLx/Dpbr+9S8VVyTMe
 Olfw1yWGjI2jWvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07FFB136CF;
 Mon, 27 Oct 2025 13:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5+4gL7V5/2i+awAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Oct 2025 13:55:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Bin Guo <guobin@linux.alibaba.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <87ecqomsnt.fsf@pond.sub.org>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
 <aPumkKBx4PoGSwNv@x1.local> <aPup9BzTf-uk8cUf@redhat.com>
 <87a51gdv4m.fsf@suse.de> <aP9IqYzAea1DUjqp@redhat.com>
 <87ecqomsnt.fsf@pond.sub.org>
Date: Mon, 27 Oct 2025 10:54:58 -0300
Message-ID: <874irke9fx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 828C221A92
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Fri, Oct 24, 2025 at 03:15:05PM -0300, Fabiano Rosas wrote:
>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>> > IMHO we should not even be using an Error object for the the blocker.
>>> > AFAICT, internally all we care about is the formatted string. The main
>>> > reason for using an Error object appears to be to have a convenient
>>> > pointer to use as an identifier to later pass to del_blocker.
>>> >
>>> > I'd be inclined to just have passed in a fixed string, and return an
>>> > integer identifier for the blocker. eg
>>> >
>>> >     int64 migrate_add_blocker(const char *reason, Error **errp);
>>> >
>>> >     void migrate_del_blocker(int64 blockerid);
>>> >
>>> > The migrate_add_blocker method would strdup(reason) to keep its own
>>> > copy.
>>> >
>>> > The usage would thus be clear & simple:
>>> >
>>> >     int64 blockerid =3D migrate_add_blocker("cannot migrate vfio", er=
rp);
>>> >     if (!blockerid) {
>>> >          return;
>>> >     }
>>> >
>>> >     ... some time later...
>>> >
>>> >     migrate_del_blocker(blockerid);
>>> >
>>> >
>>> > In some cases we needed dynamically formatted strings, which could ha=
ve
>>> > been achieved thus:
>>> >
>>> >     g_autofree char *msg =3D g_strdup_printf("cannot migrate vfio %d"=
, blah);
>>> >     int64 blockerid =3D migrate_add_blocker(msg, errp);
>>> >     ...the rest as above...
>>> >
>>> > yes, this costs an extra strdup(), but that is an acceptable & neglig=
ible
>>> > overhead in the context in which we're doing this.
>>> >
>>>=20
>>> Hmm, I must disagree. This is more complex than what we have
>>> today. Calling error_setg(err, "msg") is pretty standard, already gives
>>> us formatting and keeps all (potentially) user-facing messages uniform.
>>
>> IMHO this usage in migration is not really about error reporting
>> though, and the lifecycle ownership of the Error objects in this
>> migration usage is very diferent from the typical lifecycle
>> ownership of Error objects used in reporting errors, which I think
>> leads to a surprising / unusual API.

The blocker does eventually show up to the user via
migration_is_blocked().

I get that there is an initial surprise to passing an Error around for
something that is not strictly an error, but IMO this is just a small
idiosyncrasy. For the lifecycle point, we could probably simplify what
we're doing in migration, I don't see why the Error ** needs to be
cleared in case the blocker cannot be installed.

>
> I think a blocker interface where you pass the error to use when the
> blocker blocks something is defensible.
>
> Passing an error message or even a text snippet to be interpolated into
> the error message would also be defensible.
>
> We're using the former, and it has turned out to be confusing.  Less so
> in the block layer, where we sensibly pass Error *.  More so in
> migration, where we pass Error **.  Error ** is almost always used to
> receive an error, so when we use it for something else, we risk
> confusion.
>

I don't understand exactly why we need the Error **, it looks like we're
just storing that error twice, once via the device's migration_blocker
and another via the migration core's GSList
*migration_blockers.

The block layer doesn't have the use case of blocking the blocker like
migration does, but it still looks like the two are doing pretty much
the same, with the block "op" being analogous to the migration "mode".

>>> Asking for people to deal with strings and storing an int64 in their
>>> code is not improving the situation. Besides, the Error is already used
>>> by the block layer when blocking operations, for instance. If anything
>>> we should be integrating the two usages instead of inventing yet another
>>> for the migration code. See:
>>
>> Yes, having a common API for these two similar use cases would be
>> a useful thing. I'm just not convinced we should be (mis|re)using
>> the Error object for either of these two situations.
>
> I guess we could have a generic Blocker object instead of using Error
> for the purpose.
>
> In addition to an error message, an Error object has an error class
> (rarely used remnant of the past), where in the source code the Error
> object was created (reported to the user when handling &error_abort),
> and an optional hint.  Is any of this useful for blockers?
>

I haven't found the need for those.

>>> replication.c:
>>>   error_setg(&s->blocker,
>>>              "Block device is in use by internal backup job");
>>>   ...
>>>   bdrv_op_block_all(top_bs, s->blocker);
>>>=20
>>> block.c:
>>>   void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reaso=
n)
>>>   {
>>>       BdrvOpBlocker *blocker;
>>>       assert((int) op >=3D 0 && op < BLOCK_OP_TYPE_MAX);
>>>=20
>>>       blocker =3D g_new0(BdrvOpBlocker, 1);
>>>       blocker->reason =3D reason;
>>>       QLIST_INSERT_HEAD(&bs->op_blockers[op], blocker, list);
>>> }
>>
>>
>> With regards,
>> Daniel

