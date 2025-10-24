Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C2DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMK3-0006dK-Sb; Fri, 24 Oct 2025 14:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vCMJo-0006Yu-6D
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:15:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vCMJl-0007X1-UT
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:15:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE84821194;
 Fri, 24 Oct 2025 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761329708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUWl+ahxUk2/TUUb5JMw46znij/g3/nkZULBxB0Xa1U=;
 b=iTfxXY7CSeEbTBxCNhY51MCOxT60UtZY8hTRpy2xH75Bru3E+qm+WXtx4kEPHPoYREPDt/
 jhgKTsQ8Gtb6SYyDhsf5BNXwWgP9Se++idug0h0EY+GtgJT9vfSq1t+q8s7Iw2e6SuNID5
 HrjsS0HdA/db6nLUx0Nda1FTOZNtuCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761329708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUWl+ahxUk2/TUUb5JMw46znij/g3/nkZULBxB0Xa1U=;
 b=hjXHlzNQZRtsyU7CLxvKW9ebEqU7UicN6/0GQZrh1Tq0Wfeb9yn3hFxanG4uoo29SP13Ri
 S7jK09/iuCpl1CDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iTfxXY7C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hjXHlzNQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761329708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUWl+ahxUk2/TUUb5JMw46znij/g3/nkZULBxB0Xa1U=;
 b=iTfxXY7CSeEbTBxCNhY51MCOxT60UtZY8hTRpy2xH75Bru3E+qm+WXtx4kEPHPoYREPDt/
 jhgKTsQ8Gtb6SYyDhsf5BNXwWgP9Se++idug0h0EY+GtgJT9vfSq1t+q8s7Iw2e6SuNID5
 HrjsS0HdA/db6nLUx0Nda1FTOZNtuCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761329708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUWl+ahxUk2/TUUb5JMw46znij/g3/nkZULBxB0Xa1U=;
 b=hjXHlzNQZRtsyU7CLxvKW9ebEqU7UicN6/0GQZrh1Tq0Wfeb9yn3hFxanG4uoo29SP13Ri
 S7jK09/iuCpl1CDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B70013693;
 Fri, 24 Oct 2025 18:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8tAONivC+2jyGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Oct 2025 18:15:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Bin Guo
 <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <aPup9BzTf-uk8cUf@redhat.com>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
 <aPumkKBx4PoGSwNv@x1.local> <aPup9BzTf-uk8cUf@redhat.com>
Date: Fri, 24 Oct 2025 15:15:05 -0300
Message-ID: <87a51gdv4m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AE84821194
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 24, 2025 at 12:17:20PM -0400, Peter Xu wrote:
>> On Fri, Oct 24, 2025 at 04:08:39PM +0200, Markus Armbruster wrote:
>> > Markus Armbruster <armbru@redhat.com> writes:
>> >=20
>> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >=20
>> > [...]
>> >=20
>> > >> But wow, the migrate_add_blocker API design is unpleasant with its
>> > >> pair of "Error **" parameters - it is practically designed to
>> > >> maximise confusion & surprise.
>> > >
>> > > It's quite a sight, isn't it?
>> > >
>> > > I'll give it a quick Friday afternoon try.
>> >=20
>> > Alright, my confusion has been maximised.  Giving up on this.
>>=20
>> Besides the use of two Error** that might be confusing, what is more
>> confusing (if not wrong..): migrate_add_blocker() will take ownership of
>> the 1st Error**, no matter whether the helper succeeded or not. However,=
 it
>> only resets the first Error** if failed.
>>=20
>> I think it means if migrate_add_blocker() succeeded, the caller will hav=
e a
>> non-NULL pointer, even if it has lost the ownership of that pointer.
>>=20
>> I'm guessing it never caused issue only because we don't usually
>> error_free() the migration blocker anywhere.. but I think maybe we should
>> at least do an error_copy() in add_blockers()..
>
> IMHO we should not even be using an Error object for the the blocker.
> AFAICT, internally all we care about is the formatted string. The main
> reason for using an Error object appears to be to have a convenient
> pointer to use as an identifier to later pass to del_blocker.
>
> I'd be inclined to just have passed in a fixed string, and return an
> integer identifier for the blocker. eg
>
>     int64 migrate_add_blocker(const char *reason, Error **errp);
>
>     void migrate_del_blocker(int64 blockerid);
>
> The migrate_add_blocker method would strdup(reason) to keep its own
> copy.
>
> The usage would thus be clear & simple:
>
>     int64 blockerid =3D migrate_add_blocker("cannot migrate vfio", errp);
>     if (!blockerid) {
>          return;
>     }
>
>     ... some time later...
>
>     migrate_del_blocker(blockerid);
>
>
> In some cases we needed dynamically formatted strings, which could have
> been achieved thus:
>
>     g_autofree char *msg =3D g_strdup_printf("cannot migrate vfio %d", bl=
ah);
>     int64 blockerid =3D migrate_add_blocker(msg, errp);
>     ...the rest as above...
>
> yes, this costs an extra strdup(), but that is an acceptable & negligible
> overhead in the context in which we're doing this.
>

Hmm, I must disagree. This is more complex than what we have
today. Calling error_setg(err, "msg") is pretty standard, already gives
us formatting and keeps all (potentially) user-facing messages uniform.

Asking for people to deal with strings and storing an int64 in their
code is not improving the situation. Besides, the Error is already used
by the block layer when blocking operations, for instance. If anything
we should be integrating the two usages instead of inventing yet another
for the migration code. See:

replication.c:
  error_setg(&s->blocker,
             "Block device is in use by internal backup job");
  ...
  bdrv_op_block_all(top_bs, s->blocker);

block.c:
  void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason)
  {
      BdrvOpBlocker *blocker;
      assert((int) op >=3D 0 && op < BLOCK_OP_TYPE_MAX);

      blocker =3D g_new0(BdrvOpBlocker, 1);
      blocker->reason =3D reason;
      QLIST_INSERT_HEAD(&bs->op_blockers[op], blocker, list);
}


> With regards,
> Daniel

