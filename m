Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1VqT-0000jY-W5; Mon, 29 Apr 2024 14:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1VqP-0000jE-5L
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:35:17 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1VqF-0006SK-RP
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:35:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36AD133A12;
 Mon, 29 Apr 2024 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714415705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKdIkJCXaGnMblPPMNglH+OdR20ooNcSe8XhQ3vW+fA=;
 b=QaujFFMMIncHNqBqOsnhQDqgOUDbWPMg4mK/8if/tNUZfk6b4YiaZXJNrgGbXFpYPCqXSz
 XeIDmu2qmWtL+/4IEjbGOQgtfLBK90XwuYipEPOTq28AIaUXRp4cFuRQ39AJO4J+eUodQ8
 0mQLzzbfUgZ3WdaiIOGjyqiiMnzOWKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714415705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKdIkJCXaGnMblPPMNglH+OdR20ooNcSe8XhQ3vW+fA=;
 b=HQd6yZs+nN8QoK/GaSellCRMuDaX1Pnzc/oI02QKFUiSrY/5/IdteoHYByqk5p/1L7efgQ
 uzCwk0Pq171qlaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714415705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKdIkJCXaGnMblPPMNglH+OdR20ooNcSe8XhQ3vW+fA=;
 b=QaujFFMMIncHNqBqOsnhQDqgOUDbWPMg4mK/8if/tNUZfk6b4YiaZXJNrgGbXFpYPCqXSz
 XeIDmu2qmWtL+/4IEjbGOQgtfLBK90XwuYipEPOTq28AIaUXRp4cFuRQ39AJO4J+eUodQ8
 0mQLzzbfUgZ3WdaiIOGjyqiiMnzOWKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714415705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKdIkJCXaGnMblPPMNglH+OdR20ooNcSe8XhQ3vW+fA=;
 b=HQd6yZs+nN8QoK/GaSellCRMuDaX1Pnzc/oI02QKFUiSrY/5/IdteoHYByqk5p/1L7efgQ
 uzCwk0Pq171qlaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEA95139DE;
 Mon, 29 Apr 2024 18:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aQETHVjoL2Y9WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Apr 2024 18:35:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 devel@lists.libvirt.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer
 dos Santos Moschetta <wainersm@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Remove 'blk/-b' option from migrate
 commands
In-Reply-To: <Zi_mmpmW4XIKpXmo@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-4-farosas@suse.de> <Zi_CNIYAi6UbxJ0j@x1n>
 <875xw0f5oe.fsf@suse.de> <Zi_mmpmW4XIKpXmo@x1n>
Date: Mon, 29 Apr 2024 15:35:02 -0300
Message-ID: <8734r4f25l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, Apr 29, 2024 at 02:18:57PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Apr 26, 2024 at 10:14:05AM -0300, Fabiano Rosas wrote:
>> >> @@ -2003,21 +1997,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
>> >>          }
>> >>      }
>> >>  
>> >> -    if (blk) {
>> >> -        if (migrate_colo()) {
>> >> -            error_setg(errp, "No disk migration is required in COLO mode");
>> >> -            return false;
>> >> -        }
>> >> -        if (migrate_block()) {
>> >> -            error_setg(errp, "Command options are incompatible with "
>> >> -                       "current migration capabilities");
>> >> -            return false;
>> >> -        }
>> >> -        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
>> >> -            return false;
>> >> -        }
>> >> -        s->must_remove_block_options = true;
>> >> -    }
>> >> +    s->must_remove_block_options = true;
>> >
>> > Can we drop this var too?  Perhaps with block_cleanup_parameters()?
>> 
>> Yes, Markus mentioned it in v1 already. Take a look there. There's
>> several other declarations I missed. v3 is coming soon.
>
> Right, noticed that it's removed actually in the next patch.
>
> But iiuc it can already been removed in this patch.  If we want to remove
> it in the next, logically we should set must_remove_block_options=false
> here, though..  So maybe easier to just drop it here.

Ah I see what you mean. I thought you're just asking for the removal
overall.

But block_cleanup_parameters sets the block capability to false and the
whole block migration only goes away in the next patch. I think we need
to keep this as true to preserve behavior. In theory, after this patch
people could still use the block migration just fine by setting the cap.

