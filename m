Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6EFC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6Rl-0003dS-B8; Fri, 15 Mar 2024 08:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rl6Rk-0003cx-Gk
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:14:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rl6Ri-0002vP-Mb
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:14:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27FA21FB61;
 Fri, 15 Mar 2024 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710504835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy0sgdFPSVM5nwCoFFi9SS1dsRIcbeUvlDJB2vFLPdI=;
 b=XIxQUVLXuMew4j/goR6vCX5nNXWIuFUXcu6OqfM5ZPQhtTv8Psoj4Uc0m2NPLztXN3PCUp
 B4btSDxrHiX9Zqw4QuRSudClBwK0qaxANP9STPdNwW8EHI81IHWm9PEhg/Wqe+uPnlU0CO
 wYrNVIrA9g1kL/lTguxTn9btvEUdLjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710504835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy0sgdFPSVM5nwCoFFi9SS1dsRIcbeUvlDJB2vFLPdI=;
 b=nj1rOGIPrLYnu5+cVXJb/MVZGAYaD6U/Q1gAnpYFCqJcOE6OoNwF4AACUehrr+gc7q9OyU
 Men3ZmiR5LyPvDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710504835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy0sgdFPSVM5nwCoFFi9SS1dsRIcbeUvlDJB2vFLPdI=;
 b=XIxQUVLXuMew4j/goR6vCX5nNXWIuFUXcu6OqfM5ZPQhtTv8Psoj4Uc0m2NPLztXN3PCUp
 B4btSDxrHiX9Zqw4QuRSudClBwK0qaxANP9STPdNwW8EHI81IHWm9PEhg/Wqe+uPnlU0CO
 wYrNVIrA9g1kL/lTguxTn9btvEUdLjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710504835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qy0sgdFPSVM5nwCoFFi9SS1dsRIcbeUvlDJB2vFLPdI=;
 b=nj1rOGIPrLYnu5+cVXJb/MVZGAYaD6U/Q1gAnpYFCqJcOE6OoNwF4AACUehrr+gc7q9OyU
 Men3ZmiR5LyPvDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A57FD13460;
 Fri, 15 Mar 2024 12:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B7saG4I79GVtEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 12:13:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
In-Reply-To: <ZfQNDv--4BnN5zYx@redhat.com>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de> <ZfQNDv--4BnN5zYx@redhat.com>
Date: Fri, 15 Mar 2024 09:13:52 -0300
Message-ID: <875xxn8zgf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XIxQUVLX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nj1rOGIP
X-Rspamd-Queue-Id: 27FA21FB61
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Mar 15, 2024 at 12:20:40AM -0300, Fabiano Rosas wrote:
>> The fd: URI has supported migration to a file or socket since before
>> QEMU 8.2. In 8.2 we added the file: URI that supported migration to a
>> file. So now we have two ways (three if you count exec:>cat) to
>> migrate to a file. Fine.
>>=20
>> However,
>>=20
>> In 8.2 we also added the new qmp_migrate API that uses a JSON channel
>> list instead of the URI. It added two migration transports SOCKET and
>> FILE. It was decided that the new API would classify the fd migration
>> as a type of socket migration, neglecting the fact that the fd.c code
>> also supported file migrations.
>>=20
>> In 9.0 we're adding support for fd + multifd + mapped-ram, which is
>> tied to the file migration. This was implemented in fd.c, which is
>> only reachable when the SOCKET address type is used.
>>=20
>> The result of this is that we're asking users of the new API to create  =
 (1)
>> something called a "socket" to perform migration to a plain file. And
>> creating something called a "file" provides no way of passing in a
>> file descriptor. This is confusing.
>
> The 'file:' protocol eventually calls into qemu_open, and this
> transparently allows for FD passing using /dev/fdset/NNN syntax
> to pass in FDs.=20
>

Ok, that's technically correct. But it works differently from
fd:fdname.

/dev/fdset requires the user to switch from getfd to add-fd and it
requires QEMU and libvirt/user to synchronize on the open() flags being
used. QEMU cannot just receive any fd, it must be an fd that matches the
flags QEMU passed into qio_channel_file_new_path().

Users will have to adapt to the new API anyway, so it might be ok to
require these changes around it as well.

To keep compatibility, we'd continue to accept the fd that comes from
"fd:" or SOCKET_ADDRESS_TYPE_FD. But we'd be making it harder for users
of the fd: syntax to move to the new API.

I also don't know how we would deal with fdset when (if) we add support
for passing in more channels in the new API. It supports multiple fds,
but how do we deal with something like:

"[ { 'channel-type': 'main',"
"    'addr': { 'transport': 'file',"
"              'filename': '/dev/fdset/1' } },
"  { 'channel-type': 'second',"
"    'addr': { 'transport': 'file',"
"              'filename': '/dev/fdset/2' } } ]",

Maybe that's too far ahead for this discussion.

>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index aa1b39bce1..37f4b9c6fb 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1656,13 +1656,20 @@
>>  #
>>  # @filename: The file to receive the migration stream
>>  #
>> +# @fd: A file descriptor name or number.  File descriptors must be
>> +#     first added with the 'getfd' command. (since 9.0).
>> +#
>>  # @offset: The file offset where the migration stream will start
>>  #
>> +# Since 9.0, all members are optional, but at least one of @filename
>> +# or @fd are required.
>> +#
>>  # Since: 8.2
>>  ##
>>  { 'struct': 'FileMigrationArgs',
>> -  'data': { 'filename': 'str',
>> -            'offset': 'uint64' } }
>> +  'data': { '*filename': 'str',
>> +            '*fd': 'str',
>> +            '*offset': 'uint64' } }
>
> Adding 'fd' here is not desirable, because 'filename' is
> resolved via qemu_open which allows for FD passing without
> introducing any new syntax in interfaces which take filenames.
>
> With regards,
> Daniel

