Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A930C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3iV-00050l-AR; Fri, 31 May 2024 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD3iT-00050I-EN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:58:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD3iR-0003HV-FT
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:58:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC0321C4B;
 Fri, 31 May 2024 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717167521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfBEd/tMTRG355dJgplNPGVpnvLH9hQcgSrSLWEzVjM=;
 b=UAvJRbDusSbgVVpOZu/JwP6+oUldGV43ITFKUhJj0UW2QkduQ3b65D6s/ZokTv/p0xK8p/
 IKcQNMA1eteL4M5Cl4kKxV66LxI550Gn4ncqVvrhra1e1PN/MHGsEBizSisV0DEZPzUWB1
 di8BsTIgvvzt7ehE5GVxd0PWceEb31A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717167521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfBEd/tMTRG355dJgplNPGVpnvLH9hQcgSrSLWEzVjM=;
 b=VbEnApPkytK1MLtTZKyybs3WtWbdamGBwlVm4TkLXX6lvkm3u8EgFx4gZobzgr3fiog0D8
 +MuF1EwntDDy5yCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UAvJRbDu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VbEnApPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717167521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfBEd/tMTRG355dJgplNPGVpnvLH9hQcgSrSLWEzVjM=;
 b=UAvJRbDusSbgVVpOZu/JwP6+oUldGV43ITFKUhJj0UW2QkduQ3b65D6s/ZokTv/p0xK8p/
 IKcQNMA1eteL4M5Cl4kKxV66LxI550Gn4ncqVvrhra1e1PN/MHGsEBizSisV0DEZPzUWB1
 di8BsTIgvvzt7ehE5GVxd0PWceEb31A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717167521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfBEd/tMTRG355dJgplNPGVpnvLH9hQcgSrSLWEzVjM=;
 b=VbEnApPkytK1MLtTZKyybs3WtWbdamGBwlVm4TkLXX6lvkm3u8EgFx4gZobzgr3fiog0D8
 +MuF1EwntDDy5yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02930137C3;
 Fri, 31 May 2024 14:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wm6NLqDlWWbwAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 14:58:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 01/18] migration: Fix file migration with fdset
In-Reply-To: <ZlilFQYVvHWRCABb@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-2-farosas@suse.de> <ZlilFQYVvHWRCABb@x1n>
Date: Fri, 31 May 2024 11:58:38 -0300
Message-ID: <87ttiekoyp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7BC0321C4B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 23, 2024 at 04:05:31PM -0300, Fabiano Rosas wrote:
>> When the "file:" migration support was added we missed the special
>> case in the qemu_open_old implementation that allows for a particular
>> file name format to be used to refer to a set of file descriptors that
>> have been previously provided to QEMU via the add-fd QMP command.
>>=20
>> When using this fdset feature, we should not truncate the migration
>> file because being given an fd means that the management layer is in
>> control of the file and will likely already have some data written to
>> it. This is further indicated by the presence of the 'offset'
>> argument, which indicates the start of the region where QEMU is
>> allowed to write.
>>=20
>> Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
>> call, which will take the offset into consideration.
>>=20
>> Fixes: 385f510df5 ("migration: file URI offset")
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks

>
> Right below the change, did we forget to free the ioc if
> qio_channel_io_seek() failed?
>

Yep, looks like it. I'll fix it.

>> ---
>>  migration/file.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/migration/file.c b/migration/file.c
>> index ab18ba505a..ba5b5c44ff 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -84,12 +84,19 @@ void file_start_outgoing_migration(MigrationState *s,
>>=20=20
>>      trace_migration_file_outgoing(filename);
>>=20=20
>> -    fioc =3D qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O=
_TRUNC,
>> -                                     0600, errp);
>> +    fioc =3D qio_channel_file_new_path(filename, O_CREAT | O_WRONLY, 06=
00, errp);
>>      if (!fioc) {
>>          return;
>>      }
>>=20=20
>> +    if (ftruncate(fioc->fd, offset)) {
>> +        error_setg_errno(errp, errno,
>> +                         "failed to truncate migration file to offset %=
" PRIx64,
>> +                         offset);
>> +        object_unref(OBJECT(fioc));
>> +        return;
>> +    }
>> +
>>      outgoing_args.fname =3D g_strdup(filename);
>>=20=20
>>      ioc =3D QIO_CHANNEL(fioc);
>> --=20
>> 2.35.3
>>=20

