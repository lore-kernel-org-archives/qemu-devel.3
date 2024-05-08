Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B42C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 20:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4oAs-0001Y0-IO; Wed, 08 May 2024 16:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4oAq-0001IZ-69
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:46:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4oAk-00034o-Dj
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:45:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A79020768;
 Wed,  8 May 2024 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715201151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZBv2sz+Sb3v0GHAcH6sDybfNL3i/XT8c2jqP5iXrf4=;
 b=mkuFBhiKhOzNHvBUbJ+HqzAedSY9V/Ijmdt1+SnSyKq6cdYPrlZ6kJlNXrXlVIEw+stt8g
 uI9HRvrDHm4EdIkZBgPhmpv7hc1FWwcTwIcLlSFWorP53LYYXEDhR1nNUQu8QiZSYA6bNk
 KYlgQ59EMaDD+3mSHCtsoMJeCTckgLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715201151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZBv2sz+Sb3v0GHAcH6sDybfNL3i/XT8c2jqP5iXrf4=;
 b=/dPkqrgMz6SUZrELmtnzffxP2aJzs0t5rNrK1PkQckG1hVajMo5wOc/yP3Esk30I5DStD7
 3aH3bYC/oJ7v+ZAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mkuFBhiK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/dPkqrgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715201151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZBv2sz+Sb3v0GHAcH6sDybfNL3i/XT8c2jqP5iXrf4=;
 b=mkuFBhiKhOzNHvBUbJ+HqzAedSY9V/Ijmdt1+SnSyKq6cdYPrlZ6kJlNXrXlVIEw+stt8g
 uI9HRvrDHm4EdIkZBgPhmpv7hc1FWwcTwIcLlSFWorP53LYYXEDhR1nNUQu8QiZSYA6bNk
 KYlgQ59EMaDD+3mSHCtsoMJeCTckgLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715201151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZBv2sz+Sb3v0GHAcH6sDybfNL3i/XT8c2jqP5iXrf4=;
 b=/dPkqrgMz6SUZrELmtnzffxP2aJzs0t5rNrK1PkQckG1hVajMo5wOc/yP3Esk30I5DStD7
 3aH3bYC/oJ7v+ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87FEB1386E;
 Wed,  8 May 2024 20:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fja2E37kO2aOagAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 20:45:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
In-Reply-To: <ZjsxE9p4CsfZQK8Y@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de> <ZjsxE9p4CsfZQK8Y@redhat.com>
Date: Wed, 08 May 2024 17:45:47 -0300
Message-ID: <87a5l0kp6s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A79020768
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
>> When the migration using the "file:" URI was implemented, I don't
>> think any of us noticed that if you pass in a file name with the
>> format "/dev/fdset/N", this allows a file descriptor to be passed in
>> to QEMU and that behaves just like the "fd:" URI. So the "file:"
>> support has been added without regard for the fdset part and we got
>> some things wrong.
>>=20
>> The first issue is that we should not truncate the migration file if
>> we're allowing an fd + offset. We need to leave the file contents
>> untouched.
>>=20
>> The second issue is that there's an expectation that QEMU removes the
>> fd after the migration has finished. That's what the "fd:" code
>> does. Otherwise a second migration on the same VM could attempt to
>> provide an fdset with the same name and QEMU would reject it.
>>=20
>> We can fix the first issue by detecting when we're using the fdset
>> vs. the plain file name. This requires storing the fdset_id
>> somewhere. We can then use this stored fdset_id to do cleanup at the
>> end and also fix the second issue.
>
> The use of /dev/fdset is supposed to be transparent to code in
> QEMU, so modifying migration to learn about FD sets to do manual
> cleanup is breaking that API facade.
>
> IMHO the transparency of the design points towards the mgmt app
> calling 'remove-fd' set after migration has started, in order
> that a later migraiton can use the same fdset name.

I got this slightly wrong, QEMU doesn't reject the creation of the
fdset, it just reuses the old one and adds the new fd to it. That is
somewhat worse because then we'd choose the wrong fd when migrating. But
I guess we could just require the management layer to do proper
management of the fds/fdset.

>
> Ideally the truncation issue needs to be transparent too.
>
> Rather than detecting use of fdset, we can not use O_TRUNC
> at all. Instead we can call ftruncate(fd, offset), which
> should work in both normal and fdset scenarios.
>

Good idea.

>>=20
>> Fixes: 385f510df5 ("migration: file URI offset")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/file.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 46 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/migration/file.c b/migration/file.c
>> index ab18ba505a..8f30999400 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -10,6 +10,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>> +#include "qapi/qapi-commands-misc.h"
>>  #include "channel.h"
>>  #include "file.h"
>>  #include "migration.h"
>> @@ -23,6 +24,7 @@
>>=20=20
>>  static struct FileOutgoingArgs {
>>      char *fname;
>> +    int64_t fdset_id;
>>  } outgoing_args;
>>=20=20
>>  /* Remove the offset option from @filespec and return it in @offsetp. */
>> @@ -44,10 +46,39 @@ int file_parse_offset(char *filespec, uint64_t *offs=
etp, Error **errp)
>>      return 0;
>>  }
>>=20=20
>> +static void file_remove_fdset(void)
>> +{
>> +    if (outgoing_args.fdset_id !=3D -1) {
>> +        qmp_remove_fd(outgoing_args.fdset_id, false, -1, NULL);
>> +        outgoing_args.fdset_id =3D -1;
>> +    }
>> +}
>> +
>> +static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
>> +                             Error **errp)
>> +{
>> +    const char *fdset_id_str;
>> +
>> +    *fdset_id =3D -1;
>> +
>> +    if (!strstart(filename, "/dev/fdset/", &fdset_id_str)) {
>> +        return true;
>> +    }
>> +
>> +    *fdset_id =3D qemu_parse_fd(fdset_id_str);
>> +    if (*fdset_id =3D=3D -1) {
>> +        error_setg_errno(errp, EINVAL, "Could not parse fdset %s", fdse=
t_id_str);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  void file_cleanup_outgoing_migration(void)
>>  {
>>      g_free(outgoing_args.fname);
>>      outgoing_args.fname =3D NULL;
>> +    file_remove_fdset();
>>  }
>>=20=20
>>  bool file_send_channel_create(gpointer opaque, Error **errp)
>> @@ -81,11 +112,24 @@ void file_start_outgoing_migration(MigrationState *=
s,
>>      g_autofree char *filename =3D g_strdup(file_args->filename);
>>      uint64_t offset =3D file_args->offset;
>>      QIOChannel *ioc;
>> +    int flags =3D O_CREAT | O_WRONLY;
>>=20=20
>>      trace_migration_file_outgoing(filename);
>>=20=20
>> -    fioc =3D qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O=
_TRUNC,
>> -                                     0600, errp);
>> +    if (!file_parse_fdset(filename, &outgoing_args.fdset_id, errp)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Only truncate if it's QEMU opening the file. If an fd has been
>> +     * passed in the file will already contain data written by the
>> +     * management layer.
>> +     */
>> +    if (outgoing_args.fdset_id =3D=3D -1) {
>> +        flags |=3D O_TRUNC;
>> +    }
>> +
>> +    fioc =3D qio_channel_file_new_path(filename, flags, 0600, errp);
>>      if (!fioc) {
>>          return;
>>      }
>> --=20
>> 2.35.3
>>=20
>
> With regards,
> Daniel

