Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1F0C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NnQ-0003Ya-Q3; Mon, 14 Apr 2025 13:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4NnN-0003Y9-AF
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:40:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4NnK-0000zm-EA
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:40:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8151F851;
 Mon, 14 Apr 2025 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744652428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wpf9GDFolEONtE7wc+07dSzKoHsikWEyNWsvNmgpO4=;
 b=yOsb0PHmMCMYubZ5aSaSfceDjCF7n6m4wZ3HWJzhi/1rRdqVuEP+r6j+e8jJtQvS+fc3kS
 Bjc0ieoLUxo8Um6AciqijQWr5rv79Q9bRLPPeVx/Irya/i8S/4j/qt7K+/pVw829tSxyOr
 53f/Gen0fcwj5aTFFkktHMR58O4Luvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744652428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wpf9GDFolEONtE7wc+07dSzKoHsikWEyNWsvNmgpO4=;
 b=VrgwNoVZLeW1zxjXZ/TydR5llrLJxNPkiy/944pN4CrqKy6xGpD6yFEUrb6YW10Ay/licH
 UJFMwfwXUmLxmMAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yOsb0PHm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VrgwNoVZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744652428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wpf9GDFolEONtE7wc+07dSzKoHsikWEyNWsvNmgpO4=;
 b=yOsb0PHmMCMYubZ5aSaSfceDjCF7n6m4wZ3HWJzhi/1rRdqVuEP+r6j+e8jJtQvS+fc3kS
 Bjc0ieoLUxo8Um6AciqijQWr5rv79Q9bRLPPeVx/Irya/i8S/4j/qt7K+/pVw829tSxyOr
 53f/Gen0fcwj5aTFFkktHMR58O4Luvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744652428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wpf9GDFolEONtE7wc+07dSzKoHsikWEyNWsvNmgpO4=;
 b=VrgwNoVZLeW1zxjXZ/TydR5llrLJxNPkiy/944pN4CrqKy6xGpD6yFEUrb6YW10Ay/licH
 UJFMwfwXUmLxmMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C64136A7;
 Mon, 14 Apr 2025 17:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fwy7KotI/WeRRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 14 Apr 2025 17:40:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
In-Reply-To: <Z_1DzDB8v6FOT9TG@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com> <87v7r6fz0c.fsf@suse.de>
 <Z_1DzDB8v6FOT9TG@redhat.com>
Date: Mon, 14 Apr 2025 14:40:25 -0300
Message-ID: <87semafxpy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F8151F851
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Mon, Apr 14, 2025 at 02:12:35PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
>> >> Open questions:
>> >> ---------------
>> >>=20
>> >> - Deprecations/compat?
>> >>=20
>> >> I think we should deprecate migrate-set/query-capabilities and everyt=
hing to do
>> >> with capabilities (specifically the validation in the JSON at the end=
 of the
>> >> stream).
>> >>=20
>> >> For migrate-set/query-parameters, we could probably keep it around in=
definitely,
>> >> but it'd be convenient to introduce new commands so we can give them =
new
>> >> semantics.
>> >>=20
>> >> - How to restrict the options that should not be set when the migrati=
on is in
>> >> progress?
>> >>=20
>> >> i.e.:
>> >>   all options can be set before migration (initial config)
>> >>   some options can be set during migration (runtime)
>> >>=20
>> >> I thought of adding another type at the top of the hierarchy, with
>> >> just the options allowed to change at runtime, but that doesn't really
>> >> stop the others being also set at runtime. I'd need a way to have a
>> >> set of options that are rejected 'if migration_is_running()', without
>> >> adding more duplication all around.
>> >>=20
>> >> - What about savevm?
>> >>=20
>> >> None of this solves the issue of random caps/params being set before
>> >> calling savevm. We still need to special-case savevm and reject
>> >> everything. Unless we entirely deprecate setting initial options via
>> >> set-parameters (or set-config) and require all options to be set as
>> >> savevm (and migrate) arguments.
>> >
>> > I'd suggest we aim for a world where the commands take all options
>> > as direct args and try to remove the global state eventually.
>> >
>>=20
>> Well, except the options that are adjusted during migration. But yes, I
>> agree. It all depends on how we proceed with keeping the old commands
>> around and for how long. If they're still around we can't stop people
>> from using them and later invoking "savevm" for instance.
>>=20
>> > For savevm/loadvm in particular it is very much a foot-gun that
>> > 'migrate-set-*' will affect them, because savevm/loadvm aren't
>> > obviously connected to 'migrate-*' commands unless you're aware
>> > of how QEMU implements savevm internally.
>> >
>>=20
>> Yes, I could perhaps reset all options once savevm is called, maybe that
>> would be acceptable, then we don't need to check and block every single
>> one. Once we add support to migration options to savevm, then they'd be
>> set in the savevm command-line from day 1 and those wouldn't be
>> reset. We could also keep HMP restricted to savevm without any migration
>> options. That's be easy to enforce. If the user wants fancy savevm, they
>> can invoke via QMP.
>
> Can we make the two approaches mutually exclusive ? Taking your
> 'migrate' command example addition:
>
>   { 'command': 'migrate',
>     'data': {'*uri': 'str',
>              '*channels': [ 'MigrationChannel' ],
>   +          '*config': 'MigrationConfig',
>              '*detach': 'bool', '*resume': 'bool' } }
>
> if 'migrate' is invoked with the '*config' data being non-nil,
> then we should ignore *all* global state previously set with
> migrate-set-XXXX, and exclusively use '*config'.
>
> That gives a clean semantic break between old and new approaches,
> without us having to worry about removing the existing commands
> quickly.
>

Good idea. I will need to do something about the -global options because
they also set the defaults for the various options. But we should be
able to decouple setting defaults from -global. Or I could just apply
-global again on top of what came in '*config'.

>
>> >> - incoming defer?
>> >>=20
>> >> It seems we cannot do the final step of removing
>> >> migrate-set-capabilites before we have a form of handshake
>> >> implemented. That would take the config from qmp_migrate on source and
>> >> send it to the destination for negotiation.
>> >
>> > I'm not sure I understand why the QAPI design changes are tied
>> > to the new protocol handshake ? I guess you're wanting to avoid
>> > updating 'migrate_incoming' to accept the new parameters directly ?
>> >
>>=20
>> Yes, without migrate-set-capabilities, we'd need to pass an enormous
>> command line to -incoming defer to be able to enable capabilities on the
>> destination. With the handshake, we could transfer them over the wire
>> somehow. Does that make sense?
>
> '-incoming defer' still gets paired with 'migrate-incoming' on the
> target, so no matter what, there's no reason to ever pass parameters
> on the CLI with '-incoming defer'.
>

Oops, I misread the strcmp in vl.c. I mean -incoming uri is the one
that'll need a huge cmdline.

But if we follow your suggestion above we could just tie -incoming URI
to the existing commands and make the new format require defer.

>
> With regards,
> Daniel

