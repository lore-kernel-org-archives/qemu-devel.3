Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8C7-0000PW-AL; Mon, 04 Mar 2024 08:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh8C5-0000PM-FU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:17:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh8C3-0004QZ-Fw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:17:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DA7A4E714;
 Mon,  4 Mar 2024 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709558240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZwknmPTFAdbziKcSQ5GWP4E/v/fvj4pXj6MbfZHjWU=;
 b=xx+b8HnSy/t3r4WXkr9RrYXy2z9GnMr0z9Bp9RxVUfzebH7aXCBCamgxyIb8gGwPs4WOSg
 8Uwej/eC0FX0NJQOztKNDwKUCLo5tY7S+v3eqXQG+PH/3Eas4rIJuoOq1JJ9JJKYHpBRKN
 iOvJoN063Dd8t3kmd6NFvlaI0JE2k2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709558240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZwknmPTFAdbziKcSQ5GWP4E/v/fvj4pXj6MbfZHjWU=;
 b=PKqN/4CeeWwrUm4cQeDicwTgrC9CYLJZ/xkFOOVr4zpPVtoI0gWVijwOhhpgg7cYSnZJyA
 sis/ZKf5Me8kaGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709558240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZwknmPTFAdbziKcSQ5GWP4E/v/fvj4pXj6MbfZHjWU=;
 b=xx+b8HnSy/t3r4WXkr9RrYXy2z9GnMr0z9Bp9RxVUfzebH7aXCBCamgxyIb8gGwPs4WOSg
 8Uwej/eC0FX0NJQOztKNDwKUCLo5tY7S+v3eqXQG+PH/3Eas4rIJuoOq1JJ9JJKYHpBRKN
 iOvJoN063Dd8t3kmd6NFvlaI0JE2k2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709558240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZwknmPTFAdbziKcSQ5GWP4E/v/fvj4pXj6MbfZHjWU=;
 b=PKqN/4CeeWwrUm4cQeDicwTgrC9CYLJZ/xkFOOVr4zpPVtoI0gWVijwOhhpgg7cYSnZJyA
 sis/ZKf5Me8kaGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D1DA13A5B;
 Mon,  4 Mar 2024 13:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dgHJMd/J5WVpQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 13:17:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <ZeV1TrOvERHN_LOo@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com> <ZeV1TrOvERHN_LOo@x1n>
Date: Mon, 04 Mar 2024 10:17:17 -0300
Message-ID: <878r2ynnky.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xx+b8HnS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="PKqN/4Ce"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.52 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9pwd6yriz4g6gm1w7u8hak7u)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-0.51)[80.16%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 8DA7A4E714
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Fri, Mar 01, 2024 at 02:28:24AM +0000, Hao Xiang wrote:
>> -GlobalProperty hw_compat_8_2[] = {};
>> +GlobalProperty hw_compat_8_2[] = {
>> +    { "migration", "zero-page-detection", "legacy"},
>> +};
>
> I hope we can make it for 9.0, then this (and many rest places) can be kept
> as-is.  Let's see..  soft-freeze is March 12th.
>
> One thing to mention is I just sent a pull which has mapped-ram feature
> merged.  You may need a rebase onto that, and hopefully mapped-ram can also
> use your feature too within the same patch when you repost.

The key points are:

- The socket migration is under "use_packets", the mapped-ram is under
"!use_packets" always.

- mapped-ram doesn't trasmit zero-pages, it just clears the
corresponding bit in block->file_bmap.

> https://lore.kernel.org/all/20240229153017.2221-1-farosas@suse.de/
>
> That rebase may or may not need much caution, I apologize for that:
> mapped-ram as a feature was discussed 1+ years, so it was a plan to merge
> it (actually still partly of it) into QEMU 9.0.

I started doing that rebase last week and saw issues with a sender
thread always getting -EPIPE at the sendmsg() on the regular socket
migration. Let's hope it was just me being tired. I'll try to get
something ready this week.

