Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02688C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9Ls-0000YS-O4; Mon, 04 Mar 2024 09:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh9Lq-0000Y1-QA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:31:34 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh9Lo-0003XV-Su
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:31:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CF694E98A;
 Mon,  4 Mar 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709562690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKN3NsGHf5x59NDkBJJbHMmTHkccdDpuCXthsoSXTjI=;
 b=M8Ejpu9R8GpWjq8if+pvurdU5vlr9ZwqzoE12iOU7WcSINX7Jhk89LiUnZXNWzClXZ4mcq
 V3bUB0+s6JEI/QvbVkvO4+UlAIz9xImOT/c3+u9r8aFTlfeZ927GnjpbNqt+JShhfc57Sb
 B3VMjDfr2o+GWRyg5UuXpGTKr49m/Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709562690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKN3NsGHf5x59NDkBJJbHMmTHkccdDpuCXthsoSXTjI=;
 b=BowAOVDzngtWPFPL8ytwksn9Adr4OspZ0zX+VLOJLxzAiu1W/iWgc9L/ymDbMNhfOBxL1B
 Z7t0hvNnXLHLeCDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709562690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKN3NsGHf5x59NDkBJJbHMmTHkccdDpuCXthsoSXTjI=;
 b=M8Ejpu9R8GpWjq8if+pvurdU5vlr9ZwqzoE12iOU7WcSINX7Jhk89LiUnZXNWzClXZ4mcq
 V3bUB0+s6JEI/QvbVkvO4+UlAIz9xImOT/c3+u9r8aFTlfeZ927GnjpbNqt+JShhfc57Sb
 B3VMjDfr2o+GWRyg5UuXpGTKr49m/Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709562690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKN3NsGHf5x59NDkBJJbHMmTHkccdDpuCXthsoSXTjI=;
 b=BowAOVDzngtWPFPL8ytwksn9Adr4OspZ0zX+VLOJLxzAiu1W/iWgc9L/ymDbMNhfOBxL1B
 Z7t0hvNnXLHLeCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA66E13A5B;
 Mon,  4 Mar 2024 14:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W1wyKEHb5WVZWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 14:31:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <878r2ynnky.fsf@suse.de>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com> <ZeV1TrOvERHN_LOo@x1n>
 <878r2ynnky.fsf@suse.de>
Date: Mon, 04 Mar 2024 11:31:27 -0300
Message-ID: <875xy2nk5c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M8Ejpu9R;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BowAOVDz
X-Spamd-Result: default: False [-1.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 R_RATELIMIT(0.00)[to_ip_from(RL9pwd6yriz4g6gm1w7u8hak7u)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[14];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5CF694E98A
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, Mar 01, 2024 at 02:28:24AM +0000, Hao Xiang wrote:
>>> -GlobalProperty hw_compat_8_2[] = {};
>>> +GlobalProperty hw_compat_8_2[] = {
>>> +    { "migration", "zero-page-detection", "legacy"},
>>> +};
>>
>> I hope we can make it for 9.0, then this (and many rest places) can be kept
>> as-is.  Let's see..  soft-freeze is March 12th.
>>
>> One thing to mention is I just sent a pull which has mapped-ram feature
>> merged.  You may need a rebase onto that, and hopefully mapped-ram can also
>> use your feature too within the same patch when you repost.
>
> The key points are:
>
> - The socket migration is under "use_packets", the mapped-ram is under
> "!use_packets" always.
>
> - mapped-ram doesn't trasmit zero-pages, it just clears the
> corresponding bit in block->file_bmap.
>
>> https://lore.kernel.org/all/20240229153017.2221-1-farosas@suse.de/
>>
>> That rebase may or may not need much caution, I apologize for that:
>> mapped-ram as a feature was discussed 1+ years, so it was a plan to merge
>> it (actually still partly of it) into QEMU 9.0.
>
> I started doing that rebase last week and saw issues with a sender
> thread always getting -EPIPE at the sendmsg() on the regular socket
> migration. Let's hope it was just me being tired. I'll try to get
> something ready this week.

This was just a rebase mistake.

While debugging it I noticed that migration-test doesn't really test
zero page code properly. The guest workload dirties all memory right
away, so I'm not sure we ever see a zero page. A quick test with
multifd, shows p->zero_num=0 all the time.

Any ideas on how to introduce some holes for zero page testing?

