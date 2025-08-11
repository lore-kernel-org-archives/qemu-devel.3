Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB56FC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSxu-00017r-2T; Mon, 11 Aug 2025 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ulSxq-00017Q-0m
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:53:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ulSxm-0000rQ-Jn
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:53:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19C5B1F80C;
 Mon, 11 Aug 2025 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754920395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmCkRlPyO1+weS4Lqpe0jb7RXmAeuTNc+9th6GZ7i0Q=;
 b=bYmRPsN4XH5om3wudQE3FlOlQOvcAhmo724GFa2cdWJgAWVbqSBMUHNhYHu2msJymDi5UV
 jbH/Fihc5bsrUiKGcu5xo8OHkqBGnEwFHL7FlNjl7mM+SmRdaJ2vAXjS+lw8XrwT2YFDRV
 SiwY2VbXOMxIqqmwSJqaDb8TlJkooI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754920395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmCkRlPyO1+weS4Lqpe0jb7RXmAeuTNc+9th6GZ7i0Q=;
 b=4zOXbVm2YZQRH2s0Jvbu8cOSSP+WyTgAPv75nWzLvfi14Oz/BPEz/ES/GYjdcepQfT6VD4
 ZJGIYzFQJkZlAbCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754920395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmCkRlPyO1+weS4Lqpe0jb7RXmAeuTNc+9th6GZ7i0Q=;
 b=bYmRPsN4XH5om3wudQE3FlOlQOvcAhmo724GFa2cdWJgAWVbqSBMUHNhYHu2msJymDi5UV
 jbH/Fihc5bsrUiKGcu5xo8OHkqBGnEwFHL7FlNjl7mM+SmRdaJ2vAXjS+lw8XrwT2YFDRV
 SiwY2VbXOMxIqqmwSJqaDb8TlJkooI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754920395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmCkRlPyO1+weS4Lqpe0jb7RXmAeuTNc+9th6GZ7i0Q=;
 b=4zOXbVm2YZQRH2s0Jvbu8cOSSP+WyTgAPv75nWzLvfi14Oz/BPEz/ES/GYjdcepQfT6VD4
 ZJGIYzFQJkZlAbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E38113A55;
 Mon, 11 Aug 2025 13:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /zMlFMr1mWhqSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Aug 2025 13:53:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
In-Reply-To: <20250811090345.4360fec4@penguin>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
 <20250811090345.4360fec4@penguin>
Date: Mon, 11 Aug 2025 10:53:11 -0300
Message-ID: <878qjq0xtk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[web.de,redhat.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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

Lukas Straub <lukasstraub2@web.de> writes:

> On Fri, 8 Aug 2025 11:37:23 -0400
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:
>> > Please work with Lukas to figure out whether yank can be used here. I
>> > think that's the correct approach. If the main loop is blocked, then
>> > some out-of-band cancellation routine is needed. migrate_cancel() could
>> > be it, but at the moment it's not. Yank is the second best thing.  
>> 
>> I agree.
>> 
>> migrate_cancel() should really be an OOB command..  It should be a superset
>> of yank features, plus anything migration speficic besides yanking the
>> channels, for example, when migration thread is blocked in PRE_SWITCHOVER.
>
> Hmm, I think the migration code should handle this properly even if the
> yank command is used. From the POV of migration, it sees that the
> connection broke with connection reset. That is the same error as if the
> other side crashes/is killed or a NAT/stateful firewall in between
> reboots.
>

That should all work just fine. After yank or after a detectable network
failure. The issue here seems to be that the destination recv is hanging
indefinitely. I don't think we ever played with socket timeout
configurations, or even switching to non-blocking during the sync. This
is actually (AFAIK) the first time we get a hang that's not "just" a
synchronization issue in the migration code.

>> 
>> I'll add this into my todo; maybe I can do something with it this release.
>> I'm happy if anyone would beat me to it.
>> 
>> > 
>> > The need for a timeout is usually indicative of a design issue. In this
>> > case, the choice of a coroutine for the incoming side is the obvious
>> > one. Peter will tell you all about it! =)  
>> 
>> Nah. :)
>> 

