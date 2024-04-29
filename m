Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2C6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Qip-0006KU-9S; Mon, 29 Apr 2024 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1Qin-0006JS-Je
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:07:05 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1Qic-0001ky-82
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:07:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A8681F399;
 Mon, 29 Apr 2024 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714396010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNqVF9yl3HXbcIwERsuoumRuvmZPEI8Y3OH/oIxkeGE=;
 b=mK+DSzmJdqKl9l1iWkjvOKS8tjN58bbv9yKAxYGnaRHsJh6mItxjff6iNjCZDsPfCfcQYt
 hM1YtrZgJPX2u1/vufj7NGRnJXpAvtteR43fh5Fm1/U0d3rMFIgORD7OStViNFOSlEJju9
 zpBy4hCEKKUiFUILzmMMyv4EjSXRE8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714396010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNqVF9yl3HXbcIwERsuoumRuvmZPEI8Y3OH/oIxkeGE=;
 b=dqILF/Far6JDHaO+6J56hJPOH+ib95IjIr+Is1y3SiglhOvZLDjL9KAgJFoM31Jnp+rK9z
 mEcyLn64X0g/XXCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714396010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNqVF9yl3HXbcIwERsuoumRuvmZPEI8Y3OH/oIxkeGE=;
 b=mK+DSzmJdqKl9l1iWkjvOKS8tjN58bbv9yKAxYGnaRHsJh6mItxjff6iNjCZDsPfCfcQYt
 hM1YtrZgJPX2u1/vufj7NGRnJXpAvtteR43fh5Fm1/U0d3rMFIgORD7OStViNFOSlEJju9
 zpBy4hCEKKUiFUILzmMMyv4EjSXRE8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714396010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNqVF9yl3HXbcIwERsuoumRuvmZPEI8Y3OH/oIxkeGE=;
 b=dqILF/Far6JDHaO+6J56hJPOH+ib95IjIr+Is1y3SiglhOvZLDjL9KAgJFoM31Jnp+rK9z
 mEcyLn64X0g/XXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC860138A7;
 Mon, 29 Apr 2024 13:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aIGyK2mbL2a2agAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Apr 2024 13:06:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v3 4/4] qapi: introduce exit-on-error parameter for
 migrate-incoming
In-Reply-To: <3b6fe3da-04df-4cd1-a428-4b5cae11510a@yandex-team.ru>
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
 <20240425181551.1465739-5-vsementsov@yandex-team.ru>
 <87r0etgp7e.fsf@suse.de>
 <3b6fe3da-04df-4cd1-a428-4b5cae11510a@yandex-team.ru>
Date: Mon, 29 Apr 2024 10:06:47 -0300
Message-ID: <87bk5s71y0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.16 / 50.00]; BAYES_HAM(-2.86)[99.38%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 25.04.24 23:30, Fabiano Rosas wrote:
>>> @@ -797,13 +801,18 @@ fail:
>>>                         MIGRATION_STATUS_FAILED);
>>>       migration_incoming_state_destroy();
>>>   
>>> -    if (migrate_has_error(s)) {
>>> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>> -            error_report_err(s->error);
>>> +    if (mis->exit_on_error) {
>>> +        if (migrate_has_error(s)) {
>>> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>> +                error_report_err(s->error);
>> error_report_err(error_copy(s->error))
>> 
>> ...because later on you're reading from s->error at
>> fill_destination_migration_info.
>
> No, we immediately do exit() instead. That's just a preexisting behavior, moved into "if (mis->exit_on_error)"

I meant later in the patch, not later in the execution. Can't
query-migrate be called during process_incoming_migration_co?

