Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21315C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 19:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSM7l-0007EX-87; Tue, 23 Jan 2024 14:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rSM7f-0007EA-0j
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 14:07:47 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rSM7c-0007Bf-5M
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 14:07:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE72F1F79C;
 Tue, 23 Jan 2024 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706036860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmGG+cmKaSegHcY7WzY5LUArbMnAIv0v0NYYR5pxXpA=;
 b=J3wYqcEEFyVQXD3Tv6nEpFjDzerlBkMVoaNCBURzAoyp538mD4W2kID4EkRpHOXS8CVnZe
 A8NT+kIzL5sHTaRMUZZhh3tk1gNgzV4zZR+RxEXrQQk0R8omCcdWHq3A0KpPh0/vjEJ+zx
 lhkvWhrz85m+ZvC6TLUJz/CluP59u8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706036860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmGG+cmKaSegHcY7WzY5LUArbMnAIv0v0NYYR5pxXpA=;
 b=9WmxwriJBnouU+NTEc251GH36XgcHPXgES2DDG5UpaWTFJLVc9tWseAIp7+4RErx7DPHbm
 zoe0fkKHpfIzRwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706036860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmGG+cmKaSegHcY7WzY5LUArbMnAIv0v0NYYR5pxXpA=;
 b=J3wYqcEEFyVQXD3Tv6nEpFjDzerlBkMVoaNCBURzAoyp538mD4W2kID4EkRpHOXS8CVnZe
 A8NT+kIzL5sHTaRMUZZhh3tk1gNgzV4zZR+RxEXrQQk0R8omCcdWHq3A0KpPh0/vjEJ+zx
 lhkvWhrz85m+ZvC6TLUJz/CluP59u8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706036860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmGG+cmKaSegHcY7WzY5LUArbMnAIv0v0NYYR5pxXpA=;
 b=9WmxwriJBnouU+NTEc251GH36XgcHPXgES2DDG5UpaWTFJLVc9tWseAIp7+4RErx7DPHbm
 zoe0fkKHpfIzRwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C53613786;
 Tue, 23 Jan 2024 19:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sZBJCXwOsGWzOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Jan 2024 19:07:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 07/30] migration: Add fixed-ram URI compatibility
 check
In-Reply-To: <ZaT0h7wnXDc-5K4-@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-8-farosas@suse.de> <ZaT0h7wnXDc-5K4-@x1n>
Date: Tue, 23 Jan 2024 16:07:37 -0300
Message-ID: <87wmrzeume.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Mon, Nov 27, 2023 at 05:25:49PM -0300, Fabiano Rosas wrote:
>> The fixed-ram migration format needs a channel that supports seeking
>> to be able to write each page to an arbitrary offset in the migration
>> stream.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>> - avoided overwriting errp in compatibility check
>> ---
>>  migration/migration.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 28a34c9068..897ed1db67 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -135,10 +135,26 @@ static bool transport_supports_multi_channels(Sock=
etAddress *saddr)
>>             saddr->type =3D=3D SOCKET_ADDRESS_TYPE_VSOCK;
>>  }
>>=20=20
>> +static bool migration_needs_seekable_channel(void)
>> +{
>> +    return migrate_fixed_ram();
>> +}
>> +
>> +static bool transport_supports_seeking(MigrationAddress *addr)
>> +{
>> +    return addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_FILE;
>> +}
>
> What about TYPE_FD?  Is it going to be supported later?
>

Sorry, I missed this one.

Yes, and thanks for asking because I just remembered I have code for
this lost in a git stash somewhere. I'll include it in v4.

>> +
>>  static bool
>>  migration_channels_and_transport_compatible(MigrationAddress *addr,
>>                                              Error **errp)
>>  {
>> +    if (migration_needs_seekable_channel() &&
>> +        !transport_supports_seeking(addr)) {
>> +        error_setg(errp, "Migration requires seekable transport (e.g. f=
ile)");
>> +        return false;
>> +    }
>> +
>>      if (migration_needs_multiple_sockets() &&
>>          (addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_SOCKET) &&
>>          !transport_supports_multi_channels(&addr->u.socket)) {
>> --=20
>> 2.35.3
>>=20

