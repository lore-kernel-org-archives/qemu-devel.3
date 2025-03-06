Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45DAC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBb3-000478-Jf; Thu, 06 Mar 2025 08:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqBb1-00046s-Kp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:49:08 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqBay-0006Ad-Cq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:49:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A688D211CD;
 Thu,  6 Mar 2025 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741268939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPAT4g6NHqVdnUCwope0dxqYQd8GSVk1fhZ35uxuT+I=;
 b=Rb3Ee/NYSCWYou79rVSymilyqDHkeGT9h55Ty/UkrSGR/XikzfbAJvu99tUbzpeyprGHCj
 IK+/WoUTbvN+z0vFES+3rnoNcx2sKnhycyO7uascHJMPQKfwpdI9ra9DWTCYXt7HMEGtGn
 4ip0+Ev8G96jWM9l+Ps4rGuACtpZA7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741268939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPAT4g6NHqVdnUCwope0dxqYQd8GSVk1fhZ35uxuT+I=;
 b=zc8+JH15RPW9aAqQXC44UV/XBH9hKoIF/fmepKz8Vs7riVMWK90PiYYodgTVioO0EYshfK
 1tSL0qa2dGPkDKDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Rb3Ee/NY";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zc8+JH15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741268939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPAT4g6NHqVdnUCwope0dxqYQd8GSVk1fhZ35uxuT+I=;
 b=Rb3Ee/NYSCWYou79rVSymilyqDHkeGT9h55Ty/UkrSGR/XikzfbAJvu99tUbzpeyprGHCj
 IK+/WoUTbvN+z0vFES+3rnoNcx2sKnhycyO7uascHJMPQKfwpdI9ra9DWTCYXt7HMEGtGn
 4ip0+Ev8G96jWM9l+Ps4rGuACtpZA7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741268939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPAT4g6NHqVdnUCwope0dxqYQd8GSVk1fhZ35uxuT+I=;
 b=zc8+JH15RPW9aAqQXC44UV/XBH9hKoIF/fmepKz8Vs7riVMWK90PiYYodgTVioO0EYshfK
 1tSL0qa2dGPkDKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DB8813A61;
 Thu,  6 Mar 2025 13:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8FdUM8qnyWe4bgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Mar 2025 13:48:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOxEXLnUxhJCr7T0nVozZcLSb1WaKNfzZhrig2zYkGMktw@mail.gmail.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
 <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
 <Z8cRYO1Kacl7vl-I@x1.local>
 <CAE8KmOyrSidELiHAtegX16gYbW6jWKL7m9YGJKzfmLbZ9x8Xaw@mail.gmail.com>
 <878qpjvaw5.fsf@suse.de>
 <CAE8KmOxEXLnUxhJCr7T0nVozZcLSb1WaKNfzZhrig2zYkGMktw@mail.gmail.com>
Date: Thu, 06 Mar 2025 10:48:56 -0300
Message-ID: <875xkmuv5j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A688D211CD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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
> On Wed, 5 Mar 2025 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
>> Note that none of this is out of the ordinary, you'll find such
>> discussions in any thread on this community. It may feel arbitrary to
>> you because that's tacit knowledge we gathered along the years.
>
> * I understand. I don't find it arbitrary.
>
>> We need an extra patch that reads:
>>
>>  migration: Refactor channel discovery mechanism
>>
>>  The various logical migration channels don't have a standardized way of
>>  advertising themselves and their connections may be seen out of order
>>  by the migration destination. When a new connection arrives, the
>>  incoming migration currently make use of heuristics to determine which
>>  channel it belongs to.
>>
>>  The next few patches will need to change how the multifd and postcopy
>>  capabilities interact and that affects the channel discovery heuristic.
>>
>>  Refactor the channel discovery heuristic to make it less opaque and
>>  simplify the subsequent patches.
>>
>>  <some description of the new code which might be pertinent>
>>  ---
>>
>> You'd move all of the channel discovery code into this patch. Some of it
>> will be unreacheable because multifd is not yet allowed with postcopy,
>> but that's fine. You can mention it on the commit message.
>
> Please see:
>     -> https://privatebin.net/?dad6f052dd986f9f#FULnfrCV29NkQpvsQyvWuU4HdYjDwFbUPbDtvLro7mwi
>
> * Does this division look okay?
>

Yes.

>> About moving the code out of migration.c, it was a suggestion that
>> you're free to push back. Ideally, doing the work would be faster than
>> arguing against it on the mailing list. But that's fine.
>
> * Same here, I'm not against moving that code part to connection.c OR
> doing the work. My suggestion has been to do that movement in another
> series and not try to do everything in this one series.
>
>> About the hang in the test. It doesn't reproduce often, but once it
>> does, it hangs forever (although I haven't waited that long).
>
> * Okay, I'm not seeing it or able to reproduce it across 3 different
> machines. One is my laptop and the other 2 are servers wherein I'm
> testing migrations of guests with 64G/128G of RAM and guest dirtying
> memory to the tune of 68M/128M/256M bytes. I'll keep an eye on it if I
> find something.

Usually a loaded (or slow) machine is needed to reproduce multifd
synchronization issues. Sometimes running the test in a loop in parallel
with some other workload helps to uncover them. The CI also tends to
have slower machines that hit these problems.

