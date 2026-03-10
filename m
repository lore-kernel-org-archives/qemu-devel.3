Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5DFFD4F19
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w024J-0005pQ-VD; Tue, 10 Mar 2026 14:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w024G-0005pC-Fu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:44:32 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w024E-0001Pm-WA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:44:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 281DE4D236;
 Tue, 10 Mar 2026 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773168269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afIZgvxP4XH78iMWp87hKVM7R3PaxJ6goaZUPkmafUI=;
 b=jhK0wnnX00nVG8r2B9fy1SbErHgbGrusXYOoESK+Axh8GaldPmQ1H+UhF0m1occXu5FeKq
 N88WE+7ol0BGtveES3CvF5tTXfKt0xLtCwxZN8zQkQYGfD29dG3nCLGIgnbyN0CoYXUIah
 Na+x6htyiKFxQSmJ6Q0CGEf5n0ZS564=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773168269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afIZgvxP4XH78iMWp87hKVM7R3PaxJ6goaZUPkmafUI=;
 b=ggl5HHwMDSymfHWqkYLXkwfgNdaYn2w/NLJrrdgVuPJiDcDchxYu/8TNh9vmqQUMQHhc/M
 i+6/WgQQsbyP4MBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jhK0wnnX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ggl5HHwM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773168269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afIZgvxP4XH78iMWp87hKVM7R3PaxJ6goaZUPkmafUI=;
 b=jhK0wnnX00nVG8r2B9fy1SbErHgbGrusXYOoESK+Axh8GaldPmQ1H+UhF0m1occXu5FeKq
 N88WE+7ol0BGtveES3CvF5tTXfKt0xLtCwxZN8zQkQYGfD29dG3nCLGIgnbyN0CoYXUIah
 Na+x6htyiKFxQSmJ6Q0CGEf5n0ZS564=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773168269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afIZgvxP4XH78iMWp87hKVM7R3PaxJ6goaZUPkmafUI=;
 b=ggl5HHwMDSymfHWqkYLXkwfgNdaYn2w/NLJrrdgVuPJiDcDchxYu/8TNh9vmqQUMQHhc/M
 i+6/WgQQsbyP4MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A79053F5D4;
 Tue, 10 Mar 2026 18:44:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VqF+G4xmsGkEIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 18:44:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com
Subject: Re: [PATCH] vmstate: assert that VMStateDescription::fields is not
 NULL
In-Reply-To: <abBHWwiqu59wCAOY@x1.local>
References: <20260309223116.3233668-1-rkir@google.com>
 <abBHWwiqu59wCAOY@x1.local>
Date: Tue, 10 Mar 2026 15:44:26 -0300
Message-ID: <87zf4fzfqt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 281DE4D236
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> On Mon, Mar 09, 2026 at 10:31:16PM +0000, Roman Kiryanov wrote:
>> The vmstate_save_state_v() function does not
>> support NULL in VMStateDescription::fields
>> and will crash if one is provided.
>> 
>> Signed-off-by: Roman Kiryanov <rkir@google.com>
>
> Thanks for the patch.
>
> Yeah I think assert it is fine, but maybe unnecessary, because we have a
> lot of such in QEMU (and IIUC in most userspace apps, likely even kernel is
> the same..) where we assert by directly reference it as a pointer..
>
> Here, the assert() only helps to crash slightly earlier, rather than the
> field->name reference later..  While in both cases it'll be crystal clear
> on what has happened when a QEMU coredump is generated, either at assert(),
> or a few instructions later.
>
> PS: please always copy Fabiano when sending migration patches.
>

I'd rather have a (vmsd->fields || vmsd->unmigratable) check when
registering.


