Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A465D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 15:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOeAA-0003la-4p; Thu, 27 Nov 2025 10:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOe9r-0003jx-UF
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:43:50 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOe9p-0003iq-ST
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:43:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D82621EEC;
 Thu, 27 Nov 2025 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764258223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbALgHgddKsvHQ+glNR/DhXvkPFuN53VgRnNJc9gipo=;
 b=lZonWMzRr0dvyaUNdY6eUTEMWR4QAd3NMw0hFKw9x2HaM+1gGwmLphfRGtX7ngn6mQzlgK
 mvD8n6qcHWn1cZzENNGrs4xZRRplDP4480+x4A2x+QAbvpYxpuAzJl+8pnmrANDwb21jok
 y+LEEi25nMIQ/CaL5Xv6r3eIyTYhs2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764258223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbALgHgddKsvHQ+glNR/DhXvkPFuN53VgRnNJc9gipo=;
 b=0BKqSfvly7xNqB45NoVScT9cuHerkgjB7jqrtZwsfOC+AuqOuTfYbj+sZRSjlnXzQ8NS+l
 t7F7yy2kyMwxLIBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lZonWMzR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0BKqSfvl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764258223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbALgHgddKsvHQ+glNR/DhXvkPFuN53VgRnNJc9gipo=;
 b=lZonWMzRr0dvyaUNdY6eUTEMWR4QAd3NMw0hFKw9x2HaM+1gGwmLphfRGtX7ngn6mQzlgK
 mvD8n6qcHWn1cZzENNGrs4xZRRplDP4480+x4A2x+QAbvpYxpuAzJl+8pnmrANDwb21jok
 y+LEEi25nMIQ/CaL5Xv6r3eIyTYhs2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764258223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbALgHgddKsvHQ+glNR/DhXvkPFuN53VgRnNJc9gipo=;
 b=0BKqSfvly7xNqB45NoVScT9cuHerkgjB7jqrtZwsfOC+AuqOuTfYbj+sZRSjlnXzQ8NS+l
 t7F7yy2kyMwxLIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B0623EA63;
 Thu, 27 Nov 2025 15:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KM7xFq5xKGkQVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Nov 2025 15:43:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Pawe=C5=82_Zmarz=C5=82y?=
 <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix writing mapped_ram + ignore_shared
 snapshots
In-Reply-To: <aShoe8cgDyFxbfOr@x1.local>
References: <20251126154734.940066-1-pzmarzly0@gmail.com>
 <aSd0ROg_3snWMuCB@x1.local>
 <CAEZNvsuV=++SxRhSXe__zSCO7ShyQheL8yHVsbeAH2J4ReJ08Q@mail.gmail.com>
 <aShoe8cgDyFxbfOr@x1.local>
Date: Thu, 27 Nov 2025 12:43:39 -0300
Message-ID: <87ikeveb10.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[redhat.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D82621EEC
X-Rspamd-Action: no action
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

> On Thu, Nov 27, 2025 at 11:35:06AM +0000, Pawe=C5=82 Zmarz=C5=82y wrote:
>> On Wed, 26 Nov 2025 at 21:42, Peter Xu <peterx@redhat.com> wrote:
>> > Now I start to question whether I should have that other fix of yours =
to be
>> > for this release or next.
>> >
>> > If this use case is completely broken, we shouldn't need to rush -rc
>> > window, now I plan to merge all these fixes later when 11.0 dev window
>> > opens.  Let me know if you, or Fabiano, has any comments.
>>=20
>> It is broken if you set ignore-shared and actually have any shared
>> block, but what could work today is if you just toggle the
>> ignore-shared flag on without setting up any shared blocks. In that
>> case, writing will work fine, but reading will crash. That's how I
>
> Yep, I suppose either side of reliable failure means it's completely
> broken. :(
>
> That's IMHO an important evaluation because we could modify the image
> layout without worrying breaking others only if it's completely broken..
>
>> stumbled upon this rabbithole in the first place: I forgot to unset
>> the flag and was surprised by parsing error. Whether it is worth
>> fixing now - I don't know, setting ignore-shared when there are no
>> shared blocks doesn't really make sense, so most likely nobody does it
>> on purpose.
>>=20
>> In either case, I need to stop working on this for now, I thought this
>> will be a tiny side project that'll help me get my first patches in
>> (and get used to collaborating over email), but now it's growing in
>> complexity and I have other things that I need to prioritize.
>> Hopefully I'll come back to this within 11.x window. Thanks for all
>> the help so far, Peter, Fabiano!
>
> Don't worry, thanks for all the contributions even so far!
>
> Your patch actually looks pretty good already and mergeable, I just
> nitpicked things here and there as I want to double check on things I
> stated, and make it slow to get thoroughly discussed.
>
> Personally, I think it's ok we queue this one already into -next together
> with the other one, then we clean things on top.
>
> Fabiano, sounds good to you?  PS: take your time reading, as long as you
> agree we put it in -next only, then there's no rush. :)

Yep, that's fine.

>
> Thanks,

