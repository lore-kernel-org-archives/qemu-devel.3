Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A18CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpSh-0003L7-3j; Wed, 03 Jun 2026 13:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUpSg-0003Kr-3S
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:33:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUpSe-0002rA-CJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:33:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06C076AD79;
 Wed,  3 Jun 2026 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780507978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwlB57GarVaQuFijV91gpUruWafSHy9HvKq1bHIOGKg=;
 b=zuFtdE0LX26/h9x6E8N8qm5kQbSWLarb/CNxlwDRVku9QVJFD0owa0FfCQe1X1Gmbe9NgD
 hOs9Sw1Es+rUUSlxFlIc03TtO4aQ3VUP0/Wz5mw0ne1HVYSEVLZ5h+UnbH4tr1D6UXNCkY
 z9D8OgkLKeu/kh8Q0fqd201X0eCrBu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780507978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwlB57GarVaQuFijV91gpUruWafSHy9HvKq1bHIOGKg=;
 b=7nnJ4TmCXDUupnSVhtvMNxZw3tIx/E7ocPbIYgHQgC+zbbLSw2MDNVS5a9wl9YNre5cyLx
 8ugmmC177rBPjvDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780507978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwlB57GarVaQuFijV91gpUruWafSHy9HvKq1bHIOGKg=;
 b=zuFtdE0LX26/h9x6E8N8qm5kQbSWLarb/CNxlwDRVku9QVJFD0owa0FfCQe1X1Gmbe9NgD
 hOs9Sw1Es+rUUSlxFlIc03TtO4aQ3VUP0/Wz5mw0ne1HVYSEVLZ5h+UnbH4tr1D6UXNCkY
 z9D8OgkLKeu/kh8Q0fqd201X0eCrBu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780507978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RwlB57GarVaQuFijV91gpUruWafSHy9HvKq1bHIOGKg=;
 b=7nnJ4TmCXDUupnSVhtvMNxZw3tIx/E7ocPbIYgHQgC+zbbLSw2MDNVS5a9wl9YNre5cyLx
 8ugmmC177rBPjvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9219D779A7;
 Wed,  3 Jun 2026 17:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kEPZGEllIGqMLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 03 Jun 2026 17:32:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>, Jason Wang
 <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
In-Reply-To: <10e159ec-3ead-4297-a24a-8e6f6029afb6@nutanix.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <10e159ec-3ead-4297-a24a-8e6f6029afb6@nutanix.com>
Date: Wed, 03 Jun 2026 14:32:51 -0300
Message-ID: <87qzmn7cn0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 29/05/2026 15:15, Peter Xu wrote:
>
> (cut)
>
>>> I like the idea overall.
>>>
>>>> With this series, we should be able to drop "incoming-fds" TAP property
>>>> from the other series, instead relying on the existing "local" parameters
>>>> both in migration core and in TAP's property should suffice.
>>>>
>>>> One thing to mention is I didn't further make only-migratable into a
>>>> migration parameter.  Logically it will also work now with only-migratable,
>>>> but it then also means I'll need to convert it to a parameter, which will
>>>> be mutable even after VM started.  It will change how only-migratable used
>>>> to work, hence I skipped.
>>>>
>>>> After this, we also almost have no reason to use -global for migration
>>>> parameters.  Capabilities are still not supported in -incoming cmdline,
>>>> though.
>>>>
>>>
>>> Will we still merge capabilities and parameters? Then it would be a free
>>> upgrade.
>> 
>> Yes!  /me waiting for your patches.
>
> Is this related to the series posted at 
> https://patchew.org/QEMU/20251215220041.12657-1-farosas@suse.de/? What's 
> the current status with this work?
>

Yes, the plan is still to merge parameters and capabilities into a
single 'options' term. This is largely about internal abstractions. I
plan to get back to that part of the work as soon as I find some cycles.

The further changes involving deprecations and adding the 'config'
parameter to migration commands have encountered some push-back, so I
don't think we'll get back to them at least before the above is all
finished. I still think those changes are worthwhile, but we need to
find consensus.

>
> ATB,
>
> Mark.

