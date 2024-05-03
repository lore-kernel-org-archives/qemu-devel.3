Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 20:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2z8f-0007iP-QM; Fri, 03 May 2024 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2z8e-0007iF-4J
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:04:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2z8b-0001vb-6w
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:04:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6E32073C;
 Fri,  3 May 2024 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714766647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spYlMQ62M2+tL4SmlIZaGWZVEXLliOljz+NLm8Q8oW0=;
 b=VmIobldQf8IT2vrGT5l39OIunF7hGH4gNYNmAng3aAkQeMmWkVs82depUYYByRxsVtjZNS
 4v9ln7nCEq1Xxzcmq/IUD3wLKollI9AzLCGuQCz553d4kVs3orPJ17Sh6Ium/il8skVSXA
 mz4p7BnS2TMuIe6+iAubGOCzIfvLwT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714766647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spYlMQ62M2+tL4SmlIZaGWZVEXLliOljz+NLm8Q8oW0=;
 b=qL75QNpiBukgIWbiWBFoEhprwRGEtoLZoloVlNxINpsI3jipbbpQqgQU5GdRC/b8knmuRb
 znp7PTil0Yx9suAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VmIobldQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qL75QNpi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714766647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spYlMQ62M2+tL4SmlIZaGWZVEXLliOljz+NLm8Q8oW0=;
 b=VmIobldQf8IT2vrGT5l39OIunF7hGH4gNYNmAng3aAkQeMmWkVs82depUYYByRxsVtjZNS
 4v9ln7nCEq1Xxzcmq/IUD3wLKollI9AzLCGuQCz553d4kVs3orPJ17Sh6Ium/il8skVSXA
 mz4p7BnS2TMuIe6+iAubGOCzIfvLwT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714766647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spYlMQ62M2+tL4SmlIZaGWZVEXLliOljz+NLm8Q8oW0=;
 b=qL75QNpiBukgIWbiWBFoEhprwRGEtoLZoloVlNxINpsI3jipbbpQqgQU5GdRC/b8knmuRb
 znp7PTil0Yx9suAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0E21139CB;
 Fri,  3 May 2024 20:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TX0SGjZDNWYNfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 20:04:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Steven Sistare
 <steven.sistare@oracle.com>, QEMU Devel Mailing List
 <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Het Gala <het.gala@nutanix.com>
Subject: Re: More doc updates needed for new migrate argument @channels
In-Reply-To: <ZjU26faJBrt9Gb-G@x1n>
References: <87ttjf1jk8.fsf@pond.sub.org> <87fruznjqf.fsf@suse.de>
 <31a8bb06-5270-4fbb-b8f1-39cd06687c34@oracle.com> <ZjU26faJBrt9Gb-G@x1n>
Date: Fri, 03 May 2024 17:03:52 -0300
Message-ID: <877cgaoe6v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C6E32073C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 03, 2024 at 09:13:27AM -0400, Steven Sistare wrote:
>> On 5/3/2024 8:49 AM, Fabiano Rosas wrote:
>> > Markus Armbruster <armbru@redhat.com> writes:
>> > 
>> > > Commit 074dbce5fcce (migration: New migrate and migrate-incoming
>> > > argument 'channels') and its fixup commit 57fd4b4e1075 made command
>> > > migrate argument @uri optional and mutually exclusive with @channels.
>> > > 
>> > > But documentation still talks about "the migration URI" in several
>> > > places.
>> > > 
>> > > * MigrationCapability @mapped-ram:
>> > > 
>> > >      # @mapped-ram: Migrate using fixed offsets in the migration file for
>> > >      #     each RAM page.  Requires a migration URI that supports seeking,
>> > >      #     such as a file.  (since 9.0)
>> > > 
>> > >    I guess it requires the migration destination (@uri or @channels) to
>> > >    support seeking.
>> > 
>> > This is ambiguous. The migration destination is usually the VM at the
>> > end of the migration, not the medium to where the migration stream is
>> > written to.
>> > 
>> > One option is to just add the mention to channel all around: "Requires a
>> > migration URI or channel that supports seeking".
>> > 
>> > > 
>> > > * MigMode @cpr-reboot:
>> > > 
>> > >      # @cpr-reboot: The migrate command stops the VM and saves state to the
>> > >      #     URI.  After quitting QEMU, the user resumes by running QEMU
>> > >      #     -incoming.
>> > >      #
>> > >      #     This mode allows the user to quit QEMU, optionally update and
>> > >      #     reboot the OS, and restart QEMU.  If the user reboots, the URI
>> > >      #     must persist across the reboot, such as by using a file.
>> > > 
>> > >    I guess this saves to the migration destination (@uri or @channels).
>> > > 
>> > > * Migration Parameter @tls-hostname and its two buddies
>> > > 
>> > >      # @tls-hostname: migration target's hostname for validating the
>> > >      #     server's x509 certificate identity.  If empty, QEMU will use the
>> > >      #     hostname from the migration URI, if any.  A non-empty value is
>> > >      #     required when using x509 based TLS credentials and the migration
>> > >      #     URI does not include a hostname, such as fd: or exec: based
>> > >      #     migration.  (Since 2.7)
>> > >      #
>> > >      #     Note: empty value works only since 2.9.
>> > > 
>> > >    What's the default when we're using @channels instead of @uri?
>> > 
>> > The same, both URI and channels get put in the same structure before
>> > taking the hostname.
>> > 
>> > > 
>> > > * migrate-recover
>> > > 
>> > >      ##
>> > >      # @migrate-recover:
>> > >      #
>> > >      # Provide a recovery migration stream URI.
>> > >      #
>> > >      # @uri: the URI to be used for the recovery of migration stream.
>> > > 
>> > >    Should this command be extended to accept @channels?
>> > 
>> > Yes.
>> > 
>> > > 
>> > > * docs/devel/migration/CPR.rst
>> > > 
>> > >    Didn't look closely.  Let's discuss the others first, then come back
>> > >    to this one.
>> > > 
>> > > * HMP migrate
>> > > 
>> > >    Fine, because this still only supports URI syntax.
>> > > 
>> > > * CLI option "-incoming defer"
>> > > 
>> > >          "-incoming defer\n" \
>> > >          "                wait for the URI to be specified via migrate_incoming\n",
>> > > 
>> > >    and
>> > > 
>> > >      ``-incoming defer``
>> > >          Wait for the URI to be specified via migrate\_incoming. The monitor
>> > >          can be used to change settings (such as migration parameters) prior
>> > >          to issuing the migrate\_incoming to allow the migration to begin.
>> > > 
>> > >    I figure we should call it "the migration source" instead of "the URI"
>> > >    here.
>> > 
>> > I think it's worse. We need a proper way to refer exclusively to "the
>> > thing that the user passes as an argument to the migrate command".
>> 
>> Agreed.  My thoughts:
>> 
>> "migration URI" -> "migration URI/channel"
>> or
>> "migration URI" -> "migration stream"
>
> "stream" might imply more on the protocol itself to me, e.g. how the
> migration headers are defined, rather than the entity / fabric we use to
> send the data stream?
>
> Maybe we can simply do s/URI/channel/? As "channel" can also imply the URI
> in this case as yet another (old) format to specify the migration channels.
> It's like we always use QIOChannels underneath whatever way we specify the
> channels (either URI or the new "channels" API).

I'm fine with just "channel". "URI/channel" is ok as well.

Do we intend to deprecate the URI usage via QMP? Or are going to support
the two ways indefinitely? Keep URI for HMP-only?

If the MigrationAddress API ends up being the only one, then maybe it
makes sense to stop using URI all over.

>
> I also copied qemu-devel starting from now.
>
> Thanks,

