Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4313D3EE67
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 14:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vivVX-0004g3-2F; Thu, 22 Jan 2026 09:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivVE-0004Mk-T2
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:17:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vivVD-000405-40
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 09:17:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B35BB5BCEC;
 Thu, 22 Jan 2026 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SD5tATpztieU1hcSqlFuNy8BLw0znzD4nUk4jxNq6rA=;
 b=YXsy93jKWd2VJF3bYJZFFqDDQO4bkZsG5SJ3MZumTciajcP1cQf657HPsOEXYxSCDuadaD
 R9M3tkLJFq3SmZwZWa+EZj1F9b5SG6iNYD79E7GT9pAaH0+VviTeIj13TT38PEchRAUCYY
 2nf/JZnf9EWAjP2ObIb/2KYhCgGcVl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SD5tATpztieU1hcSqlFuNy8BLw0znzD4nUk4jxNq6rA=;
 b=U4D8WwEp5+jBh5MOcL+ujw7FT11yeKDw30Q3z8EB685pn0D9wOhIdDXUKZ+zXa5xulzlDj
 R0cw8fF/lnLKz4Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YXsy93jK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U4D8WwEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769091457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SD5tATpztieU1hcSqlFuNy8BLw0znzD4nUk4jxNq6rA=;
 b=YXsy93jKWd2VJF3bYJZFFqDDQO4bkZsG5SJ3MZumTciajcP1cQf657HPsOEXYxSCDuadaD
 R9M3tkLJFq3SmZwZWa+EZj1F9b5SG6iNYD79E7GT9pAaH0+VviTeIj13TT38PEchRAUCYY
 2nf/JZnf9EWAjP2ObIb/2KYhCgGcVl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769091457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SD5tATpztieU1hcSqlFuNy8BLw0znzD4nUk4jxNq6rA=;
 b=U4D8WwEp5+jBh5MOcL+ujw7FT11yeKDw30Q3z8EB685pn0D9wOhIdDXUKZ+zXa5xulzlDj
 R0cw8fF/lnLKz4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 252841395E;
 Thu, 22 Jan 2026 14:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RzB8NYAxcmmDHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Jan 2026 14:17:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
In-Reply-To: <CAE8KmOzokNWorvOXfWXxib-YhhUXgncZtBHR+-u8sa81VxPvXg@mail.gmail.com>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOwKaETNiiin6JATUFzRt=DxtaXVaoTw3EgvGe-N+6qWhw@mail.gmail.com>
 <877btallqy.fsf@suse.de>
 <CAE8KmOzokNWorvOXfWXxib-YhhUXgncZtBHR+-u8sa81VxPvXg@mail.gmail.com>
Date: Thu, 22 Jan 2026 11:17:34 -0300
Message-ID: <87tswdk9z5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B35BB5BCEC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Thu, 22 Jan 2026 at 02:35, Fabiano Rosas <farosas@suse.de> wrote:
>> > On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
>> >>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> >> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> >>              migrate_get_current()->has_block_bitmap_mapping = true;
>> >>          }
>> >>
>> >> -        migrate_params_apply(params);
>> >> +        migrate_params_apply(&tmp);
>> >
>> > * This change looks unrelated to the rest of this patch. I see it is
>> > done in another [PATCH 5/5] ... QAPI_MERGE patch, we should move this
>> > there.
>> >
>>
>> This is the only reason we can use QAPI_CLONE_MEMBERS. The params
>> contain only the information that came from QAPI. What we really want to
>> apply is what's in tmp. I refer to it in the commit message:
>>
>> "use the temporary object, which already contains the current migration
>> parameters plus the new ones and was just validated by
>> migration_params_check"
>
> * Yes, here we are changing from params to &tpm. And the other [PATCH
> 5/5] changes the same from
>
>      void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>               ...
>      -        migrate_params_apply(&tmp);
>     +        migrate_params_apply(tmp);
>
> along with other related changes. I was thinking we change
> 'migrate_params_apply' in [PATCH 2/5] and 'qmp_migrate_set_parameters'
> in [PATCH 5/5].
>

No, because then this patch breaks entirely. This patch can only exist
if tmp is being used. Or maybe I'm not following...

> Thank you.
> ---
>   - Prasad

