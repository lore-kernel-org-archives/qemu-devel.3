Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38ECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyzCr-0001uA-4S; Wed, 17 Sep 2025 16:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzCp-0001tg-Pk
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:56:47 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzCn-0007qa-RP
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:56:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A96D202E1;
 Wed, 17 Sep 2025 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758142604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H03nvG6g1zlrdaFrTU4zcr0FMERafy8pbqxxeieWAJY=;
 b=nN6DnSVu9nHk0rKU0GdXW/3mljjPs3STe0iGUUV26r+FSbG8ZHvIvRgSwAc4Mtfv35q/2+
 Hg2HlAddQ3JIqCFhGVgsP6l2c3pFOEIDUBqbsfns6L6uHUCJgeuT4NOIYoyweqaXIHXr1u
 tcNu64y3C/z5AvfqmGxEh5dPWGqc/UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758142604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H03nvG6g1zlrdaFrTU4zcr0FMERafy8pbqxxeieWAJY=;
 b=Ofwuxrk9EPtBazpvtYHshY/Qrzkt+s385J1tQqMTPl8BuiL4uoCEI6wHhbnYE7iZ8lCHGJ
 riDTKVOzmOHWvlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758142604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H03nvG6g1zlrdaFrTU4zcr0FMERafy8pbqxxeieWAJY=;
 b=nN6DnSVu9nHk0rKU0GdXW/3mljjPs3STe0iGUUV26r+FSbG8ZHvIvRgSwAc4Mtfv35q/2+
 Hg2HlAddQ3JIqCFhGVgsP6l2c3pFOEIDUBqbsfns6L6uHUCJgeuT4NOIYoyweqaXIHXr1u
 tcNu64y3C/z5AvfqmGxEh5dPWGqc/UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758142604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H03nvG6g1zlrdaFrTU4zcr0FMERafy8pbqxxeieWAJY=;
 b=Ofwuxrk9EPtBazpvtYHshY/Qrzkt+s385J1tQqMTPl8BuiL4uoCEI6wHhbnYE7iZ8lCHGJ
 riDTKVOzmOHWvlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74E51368D;
 Wed, 17 Sep 2025 20:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U/SwKIsgy2gTfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 20:56:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] migration/tls: Graceful shutdowns for main and
 postcopy channels
In-Reply-To: <aMLK5nT4CVPrcZCB@x1.local>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <aMLK5nT4CVPrcZCB@x1.local>
Date: Wed, 17 Sep 2025 17:56:40 -0300
Message-ID: <87tt10vlvb.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Wed, Sep 10, 2025 at 12:01:41PM -0400, Peter Xu wrote:
>> Fabiano fixed graceful shutdowns for multifd channels previously:
>> 
>> https://lore.kernel.org/qemu-devel/20250206175824.22664-1-farosas@suse.de/
>> 
>> However we likely forgot the rest channels.  Do it the same for the main
>> and postcopy channels.  This fixes a warning message when running unit test
>> /ARCH/migration/postcopy/preempt/tls/psk.
>> 
>> Thanks,
>> 
>> Peter Xu (3):
>>   migration/tls: Gracefully shutdown main and preempt channels
>>   migration: Make migration_has_failed() work even for CANCELLING
>>   migration/multifd: Use the new graceful termination helper
>
> Please hold off the review on this one.  Juraj reported the issue wasn't
> resolved by the changes, and I can also reproduce.  I'll have a look and
> repost..

I'm wondering if the assumption that only succeeded migrations should
gracefully exit is correct. My understanding is that we need to always
exit gracefully, but after failure, the channel might not be there, so
we ignore failures. But that does not seem to mean a failed migration
can simply not exit gracefully.

