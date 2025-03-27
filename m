Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41131C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoKK-00052s-4f; Thu, 27 Mar 2025 10:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoKH-00052V-Aj
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:35:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoKF-0005Gm-Am
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:35:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7EAE211A2;
 Thu, 27 Mar 2025 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqoQzbD/0qsorJFQ+gmmbyCGOnRknTzGSVySyVHezLQ=;
 b=DEVOlkbjV4GwWayuiXbMPfHs0slPy60LiqIrmlviMddbli5xUi2kpvzqIXNJlTpFiFSpf+
 qbUaJFpMojdqmtnN1CEuDYFR9G2nuAX+PNDHrnsTtpMBLTMUCyhduuatBZ20Q32+NgMNqJ
 +H+3TzDmftbAggX2t0k83Jq+t1HBWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqoQzbD/0qsorJFQ+gmmbyCGOnRknTzGSVySyVHezLQ=;
 b=MriXHdrFRFgw+qY9FuZVKk6WTLOCfFcfC+D2AK1j12q0ntN27DtgpXCX6KCtYa755/PPCn
 peqhDklnWx1SJkCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqoQzbD/0qsorJFQ+gmmbyCGOnRknTzGSVySyVHezLQ=;
 b=DEVOlkbjV4GwWayuiXbMPfHs0slPy60LiqIrmlviMddbli5xUi2kpvzqIXNJlTpFiFSpf+
 qbUaJFpMojdqmtnN1CEuDYFR9G2nuAX+PNDHrnsTtpMBLTMUCyhduuatBZ20Q32+NgMNqJ
 +H+3TzDmftbAggX2t0k83Jq+t1HBWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqoQzbD/0qsorJFQ+gmmbyCGOnRknTzGSVySyVHezLQ=;
 b=MriXHdrFRFgw+qY9FuZVKk6WTLOCfFcfC+D2AK1j12q0ntN27DtgpXCX6KCtYa755/PPCn
 peqhDklnWx1SJkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21FEC139D4;
 Thu, 27 Mar 2025 14:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pNh+NCRi5We9ZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:35:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOwiyboWwyjV=gA=GqJSQxQKwm7uG=Jxh3Y1xnJEarYD=g@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <CAE8KmOwiyboWwyjV=gA=GqJSQxQKwm7uG=Jxh3Y1xnJEarYD=g@mail.gmail.com>
Date: Thu, 27 Mar 2025 11:35:13 -0300
Message-ID: <87friya6e6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello Fabiano,
>
> On Tue, 18 Mar 2025 at 18:10, Prasad Pandit <ppandit@redhat.com> wrote:
>> * This series (v8) splits earlier patch-2 which enabled multifd and
>>   postcopy options together into two separate patches. One modifies
>>   the channel discovery in migration_ioc_process_incoming() function,
>>   and second one enables the multifd and postcopy migration together.
>>
>>   It also adds the 'save_postcopy_prepare' savevm_state handler to
>>   enable different sections to take an action just before the Postcopy
>>   phase starts. Thank you Peter for these patches.
>> ===
>> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             152.66s   81 subtests passed
>> ===
>>
>
> Ping..! Did you have chance to review this (v8) series. (just checking)
>

I'll get to it soon. I need to send a PR for the recent SNP breakage and
also check Li Zhijian's RDMA series first.

