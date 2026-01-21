Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF40C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vifOv-0006Ht-8M; Wed, 21 Jan 2026 16:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vifOe-0006GG-8B
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:05:48 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vifOc-0000tH-N8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:05:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1C75BD2B;
 Wed, 21 Jan 2026 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769029544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Qj2cRKKHRXzBZGYBj8PGdetS7Zrf0qzWA4wvLBPBmg=;
 b=IQoKEwML7XDoJQG4NTG+I7wyd3YHDpD6qA639AejSKWK/BLtEvpgo9w4Jgt8QSGkvWqR9l
 pulUHLS+tm98wm2M3hsasrLwC1HWYjt460biLzbUEERjP0+9fwDdSQ/M8NySxe1RAzH9oB
 p7Zu1WyKYGqNiI9eCgCO2riKW+Wywno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769029544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Qj2cRKKHRXzBZGYBj8PGdetS7Zrf0qzWA4wvLBPBmg=;
 b=zgOHpDnuToCchgSrd+fljy5LOJQw6hs6VpLZsHUA7iEnigvN8qU6K6opMprIVUb8DBXCA3
 1AUrrPIIiIwCQaAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769029544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Qj2cRKKHRXzBZGYBj8PGdetS7Zrf0qzWA4wvLBPBmg=;
 b=IQoKEwML7XDoJQG4NTG+I7wyd3YHDpD6qA639AejSKWK/BLtEvpgo9w4Jgt8QSGkvWqR9l
 pulUHLS+tm98wm2M3hsasrLwC1HWYjt460biLzbUEERjP0+9fwDdSQ/M8NySxe1RAzH9oB
 p7Zu1WyKYGqNiI9eCgCO2riKW+Wywno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769029544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Qj2cRKKHRXzBZGYBj8PGdetS7Zrf0qzWA4wvLBPBmg=;
 b=zgOHpDnuToCchgSrd+fljy5LOJQw6hs6VpLZsHUA7iEnigvN8qU6K6opMprIVUb8DBXCA3
 1AUrrPIIiIwCQaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961813EA63;
 Wed, 21 Jan 2026 21:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GZ6oFqc/cWmDawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Jan 2026 21:05:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
In-Reply-To: <CAE8KmOwKaETNiiin6JATUFzRt=DxtaXVaoTw3EgvGe-N+6qWhw@mail.gmail.com>
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOwKaETNiiin6JATUFzRt=DxtaXVaoTw3EgvGe-N+6qWhw@mail.gmail.com>
Date: Wed, 21 Jan 2026 18:05:41 -0300
Message-ID: <877btallqy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

> On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
>>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>              migrate_get_current()->has_block_bitmap_mapping = true;
>>          }
>>
>> -        migrate_params_apply(params);
>> +        migrate_params_apply(&tmp);
>
> * This change looks unrelated to the rest of this patch. I see it is
> done in another [PATCH 5/5] ... QAPI_MERGE patch, we should move this
> there.
>

This is the only reason we can use QAPI_CLONE_MEMBERS. The params
contain only the information that came from QAPI. What we really want to
apply is what's in tmp. I refer to it in the commit message:

"use the temporary object, which already contains the current migration
parameters plus the new ones and was just validated by
migration_params_check"

> Thank you.
> ---
>   - Prasad

