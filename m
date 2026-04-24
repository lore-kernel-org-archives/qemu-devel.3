Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E538FF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGP0y-0001gG-2C; Fri, 24 Apr 2026 18:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wGP0w-0001ft-2J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:28:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wGP0u-0008PA-Ck
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:28:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62DDB5BD7A;
 Fri, 24 Apr 2026 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777069721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2GKZgVTjuPGuWJRSTRyiniZD959Bff0LMg4PSsbrCc=;
 b=SD7RuVaJcCnfaXUDndV20EVEHvIHAzEfcFxCPsCHjzkSAgQyiN3lE+kKQu+SgEEzrJLTax
 K+cRpVy38Xj35fHpnMgIpTXIej2yWLGbUi0HWfB63Ev/5skoDrY9LECyxbuL5dybN8cR5P
 c3HrsVYA3h4yx7RW5RXI/koSz7oqSMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777069721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2GKZgVTjuPGuWJRSTRyiniZD959Bff0LMg4PSsbrCc=;
 b=+4U4DYhIx7BMQHeGSm4azHDx+R0EOfUsJqqvYuDnsAkE/1EV8wyzZuxh5dd1fh3hNUfigF
 jneqq4ejXK6A90Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SD7RuVaJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+4U4DYhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777069721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2GKZgVTjuPGuWJRSTRyiniZD959Bff0LMg4PSsbrCc=;
 b=SD7RuVaJcCnfaXUDndV20EVEHvIHAzEfcFxCPsCHjzkSAgQyiN3lE+kKQu+SgEEzrJLTax
 K+cRpVy38Xj35fHpnMgIpTXIej2yWLGbUi0HWfB63Ev/5skoDrY9LECyxbuL5dybN8cR5P
 c3HrsVYA3h4yx7RW5RXI/koSz7oqSMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777069721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2GKZgVTjuPGuWJRSTRyiniZD959Bff0LMg4PSsbrCc=;
 b=+4U4DYhIx7BMQHeGSm4azHDx+R0EOfUsJqqvYuDnsAkE/1EV8wyzZuxh5dd1fh3hNUfigF
 jneqq4ejXK6A90Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00D87593A4;
 Fri, 24 Apr 2026 22:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o9efMJju62mnQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Apr 2026 22:28:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell
 <peter.maydell@linaro.org>, Elisey Konstantinov
 <elisey.konstantinov@gmail.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
In-Reply-To: <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
 <aes4kEdQ_x8eI-m6@redhat.com>
 <4FFF1823-815E-4956-9C80-9C62A98033B0@gmail.com>
 <CAFEAcA_gX4N6YrhQBTi-YDvkafJXWEkkDU8Y9vz5nYce9OrHwQ@mail.gmail.com>
 <a4fd79f8-43fa-4894-80d3-ed31ffec1ff6@ilande.co.uk>
Date: Fri, 24 Apr 2026 19:28:38 -0300
Message-ID: <87a4usdmcp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[ilande.co.uk,linaro.org,gmail.com];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 62DDB5BD7A
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 24/04/2026 12:51, Peter Maydell wrote:
>
>> The "New World" and "Old World" machines are listed in our
>> MAINTAINERS file as "Odd Fixes", which means:
>> 
>> "It has a maintainer but they don't have time to do
>>   much other than throw the odd patch in."
>> 
>> In other words, there is no active development work ongoing,
>> and nobody with time and interest to investigate complex bugs.
>> If it happens to work for people, that's great. If it doesn't
>> work and somebody proposes a patch then we can review the patch
>> (as we have done for this one). If it doesn't work and nobody
>> proposes a satisfactory patch then it will likely remain broken.
>
> I'm around to do various small bits and pieces, but at least for the short term it's 
> fairly hard to find the extended time that bugs like these require.
>
> Note that MacOS X before 10.2 (including MacOS 9) appear to be timing sensitive to 
> the CUDA interrupts, so that might be another explanation. You could try 
> experimenting with increasing the delay at 
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/misc/macio/cuda.c?ref_type=heads#L537 
> to see if that helps?
>

Hi, just to let you all know I cannot reproduce this.

MacOS X boots past the initial screen, the installer comes up and
clicking around works fine. With both QEMU 10.0.0 and current master.

