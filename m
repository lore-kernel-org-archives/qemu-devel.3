Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF90EC19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MQO-0006CQ-VG; Fri, 26 Apr 2024 10:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MQN-0006CH-CZ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:19:39 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0MQL-0000fw-R1
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:19:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2418920E43;
 Fri, 26 Apr 2024 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGDfxGXjzqJg/tllnkPADSvJKZ5rYeGbLQLsK1v2qVI=;
 b=fubHVWjIknAijORBCYyob1X/pR5t0ahYyix+AOpaHAxlyxkszSqxHH4Rs+AyT+ZmMYiZdE
 eo5uk3QYVoHwt6Dm4jC8c8b17bUq5WXfJpkbh92urwDUhE8JKzq79UMmVOgEH69GkSM4QY
 1kAYFONzObDjR14fwKJKrAE2HUjNaUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGDfxGXjzqJg/tllnkPADSvJKZ5rYeGbLQLsK1v2qVI=;
 b=dyI94UWY/GVU+bHBz4hmOLZ6fMDLjPSpL+8zz58Z6p9HCBrCXXvmw2SvNzsLF4scBO/Uky
 VFupFMiBdqWd9QDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714141174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGDfxGXjzqJg/tllnkPADSvJKZ5rYeGbLQLsK1v2qVI=;
 b=fubHVWjIknAijORBCYyob1X/pR5t0ahYyix+AOpaHAxlyxkszSqxHH4Rs+AyT+ZmMYiZdE
 eo5uk3QYVoHwt6Dm4jC8c8b17bUq5WXfJpkbh92urwDUhE8JKzq79UMmVOgEH69GkSM4QY
 1kAYFONzObDjR14fwKJKrAE2HUjNaUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714141174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGDfxGXjzqJg/tllnkPADSvJKZ5rYeGbLQLsK1v2qVI=;
 b=dyI94UWY/GVU+bHBz4hmOLZ6fMDLjPSpL+8zz58Z6p9HCBrCXXvmw2SvNzsLF4scBO/Uky
 VFupFMiBdqWd9QDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA66136DB;
 Fri, 26 Apr 2024 14:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wxqxGPW3K2aqbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 14:19:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 devel@lists.libvirt.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer
 dos Santos Moschetta <wainersm@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 3/6] migration: Remove 'blk/-b' option from migrate
 commands
In-Reply-To: <87o79wrzgx.fsf@pond.sub.org>
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-4-farosas@suse.de> <87y190s1a1.fsf@pond.sub.org>
 <87o79wrzgx.fsf@pond.sub.org>
Date: Fri, 26 Apr 2024 11:19:31 -0300
Message-ID: <87mspg6wb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> The block migration is considered obsolete and has been deprecated in
>>> 8.2. Remove the migrate command option that enables it. This only
>>> affects the QMP and HMP commands, the feature can still be accessed by
>>> setting the migration 'block' capability. The whole feature will be
>>> removed in a future patch.
>>>
>>> Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
>>> option is deprecated.").
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I think you missed the update to hmp-commands.hx.  I almost missed it,
> too :)

Nice catch, it was bound to happen. There's approximately 9000 instances
of 'blk' in this project.

