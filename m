Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF1D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkS8B-0002gv-OQ; Mon, 26 Jan 2026 14:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkS8A-0002gj-Tp
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:20:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkS89-0001hK-AB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:20:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26AE233790;
 Mon, 26 Jan 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769455208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7laPPT6nZP51j8E/mvwv7If7TxxoQtGRYeixrGRMGU=;
 b=lz40dn6aULAw3Vjo+1G0mG1qjKxPw9PKVXehGsky64TnAHwio3+zAiAX06c3hxosB+bLR1
 0HKL7Bp3YTLd6AhagdigVCTl+FWyIl6AfLVkAXVtvg6VpcdC8UovtLObpozrSaoefHjcl4
 yYmncafE5aKs5mZyEqh+8eOjvq9BmH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769455208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7laPPT6nZP51j8E/mvwv7If7TxxoQtGRYeixrGRMGU=;
 b=ymh9PFfgEO2YuT37oDTyP8p/TgNBcnevbNUz+60L/L8RNgFqpQaOt7BEW117klor/qF1mD
 VVulXiMxW+d7sNCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lz40dn6a;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ymh9PFfg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769455208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7laPPT6nZP51j8E/mvwv7If7TxxoQtGRYeixrGRMGU=;
 b=lz40dn6aULAw3Vjo+1G0mG1qjKxPw9PKVXehGsky64TnAHwio3+zAiAX06c3hxosB+bLR1
 0HKL7Bp3YTLd6AhagdigVCTl+FWyIl6AfLVkAXVtvg6VpcdC8UovtLObpozrSaoefHjcl4
 yYmncafE5aKs5mZyEqh+8eOjvq9BmH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769455208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7laPPT6nZP51j8E/mvwv7If7TxxoQtGRYeixrGRMGU=;
 b=ymh9PFfgEO2YuT37oDTyP8p/TgNBcnevbNUz+60L/L8RNgFqpQaOt7BEW117klor/qF1mD
 VVulXiMxW+d7sNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C0A1139E9;
 Mon, 26 Jan 2026 19:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A0wuE2e+d2k1QwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 19:20:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/5] migration: Notify migration FAILED before starting VM
In-Reply-To: <aXeGYwSleEXznWJh@x1.local>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-4-peterx@redhat.com> <874iocjxhk.fsf@suse.de>
 <aXOWgOAWqjy7rHV7@x1.local> <87sebwgrj7.fsf@suse.de>
 <aXeGYwSleEXznWJh@x1.local>
Date: Mon, 26 Jan 2026 16:20:04 -0300
Message-ID: <87bjiggp0b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 26AE233790
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 23, 2026 at 02:36:28PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Jan 23, 2026 at 09:59:35AM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > Devices may opt-in migration FAILED notifiers to be invoked when migration
>> >> > fails.  Currently, the notifications happen in migration_cleanup().  It is
>> >> > normally fine, but maybe not ideal if there's dependency of the fallback
>> >> > v.s. VM starts.
>> >> >
>> >> > This patch moves the FAILED notification earlier, so that if the failure
>> >> > happened during switchover, it'll notify before VM restart.
>> >> >
>> >> 
>> >> The change to FAILED in patch 2 should come to this patch to avoid
>> >> having a window where the notification only happens at the end.
>> >
>> > Hmm.. Isn't that expected?  Even after patch 2, we still notify FAILED at
>> > the end for precopy.  It's the same for postcopy.
>> >
>> 
>> Sorry, I meant: s/at the end/after vm_start/.
>> 
>> > For a failed postcopy we have following behavior:
>> >
>> > Before patch 2
>> > ==============
>> >
>> >   - notify FAILED (during switchover)
>> >   - vm_start()
>> >   - notify FAILED (during migration_cleanup)
>> >
>> > After patch 2 
>> > =============
>> >
>> >   - vm_start()
>> >   - notify FAILED (during migration_cleanup)
>> >
>> > So patch 2 fixes the duplicate issue, and only fixes that.
>> >
>> > After patch 3
>> > =============
>> >
>> >   - notify FAILED (during migration_iteration_finish)
>> >   - vm_start()
>> >
>> > Patch 3 changes the place of FAILED notification so that it happens always
>> > before vm_start(), for both precopy and postcopy.
>> 
>> Right, my point is that with patch 3 we're establishing that the correct
>> place to notify is before vm_start().
>
> Yep, likely not strictly correctness in terms of current notifiers, but
> since Stefan may have yet another use case that may require a notifier to
> be done before vm_start(), it makes more sense for us to move, IMHO.
>
>> But after patch 2, *if* any driver actually depends on being informed of
>> failure *before* starting the VM, that will not happen. I think both
>> changes could be made at once so that this intermediate state never
>> exists.
>
> I see what you meant. I think there should have no such user.
>
> It's because we always notify FAILED at migration_cleanup() for precopy, or
> even postcopy before the cpr-exec work (before QEMU 9.0).
>
> That behavior of "notify FAILED before vm_start() for postcopy" is very
> specific and only added after commit 4af667f87c ("migration: notifier error
> checking").  IOW, before QEMU 9.0, for both precopy and postcopy we always
> notify FAILED in migration_cleanup(), never before vm_start().
>
> I mentioned this in the commit log of previous patch too, where I bet the
> additional FAILED notification added in 4af667f87c for postcopy path is an
> accident (to make it pairing with the "reused DONE", however it turns out
> we likely shouldn't do either of them..).  So I don't expect anything will
> depend on that behavior, and only for postcopy.
>
> The benefit of splitting this patch and previous one is, the previous one
> is a "fix" of duplicated notifications, hence if we need a backport that
> can be done without this one.  Said that, I don't think one should need
> it..  It should also make each commits slightly easier to follow, because
> they're fundamentally two changes.
>
> Let me know what you think after reading my explanations above.  I prefer
> the split like as-is, but I can still squash it to close the trivially
> small window that you described.  I'll make sure if merged the commit
> message contains separate discussions on two problems.

Ok, fair points.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

