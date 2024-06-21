Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfoH-00068e-3J; Fri, 21 Jun 2024 11:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKfoC-00065v-Mg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:04:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKfoA-0005RU-T3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:04:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FCA5219BF;
 Fri, 21 Jun 2024 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718982247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xic1wB1oKldeehkD+pnDZ/ToS39BJT8Um+qH7V37syg=;
 b=N1xeRHNhj0HphzFSHOmF64T+GCFKGy9cvMr/2NvqR8QEnLu7oL0echgbg/mHoQSeDNRtF4
 G8nHDvSVLtnv+c7+qQdRK+2lmYDKQVYLTcerOl+l4FnB8SzuS/Y2i0GbMwJwoBPUWkGmKq
 PqUQhe908Huf8MfkwDmTeprP2vEW3aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718982247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xic1wB1oKldeehkD+pnDZ/ToS39BJT8Um+qH7V37syg=;
 b=ZFtNZQ8s+DTYYMgK1TF3RGISUvNL6qSHdsJcp1XuuU3ICzMlKiuRoQJGdu08mO/vBQQODM
 0ZSSA+/EttmJd0BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718982246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xic1wB1oKldeehkD+pnDZ/ToS39BJT8Um+qH7V37syg=;
 b=aRB5vKez07t7c6XyjyZ0VfPmcKeGOicvkDwyEsjVE0XBxzxGGJamh/WBhiTAfdqs6fgq/i
 i/YZGB/ZiwXoZKOPp6vfsbukLOKPMqxdSB07CQmJxXpWzdSpqANenUJt7Jr4pQr3B4MscY
 TlOTXj2EpEq2J1/ErfzTbeUjrQCVfgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718982246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xic1wB1oKldeehkD+pnDZ/ToS39BJT8Um+qH7V37syg=;
 b=qnbHdMD2tF6dxxNab4ZQPC+DtT8lgGNb4KYWsfITGvyLG4veDxqxDcozS9Rqqsc4DczbaY
 eqkdBZuPKDohzhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFF813ABD;
 Fri, 21 Jun 2024 15:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rdsLKGWWdWb0NQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 15:04:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
In-Reply-To: <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
References: <20240620212111.29319-1-farosas@suse.de>
 <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
Date: Fri, 21 Jun 2024 12:04:03 -0300
Message-ID: <87v822ibh8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, szmigiero.name:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> Hi Fabiano,
>
> On 20.06.2024 23:21, Fabiano Rosas wrote:
>> Hi folks,
>> 
>> First of all, apologies for the roughness of the series. I'm off for
>> the next couple of weeks and wanted to put something together early
>> for your consideration.
>> 
>> This series is a refactoring (based on an earlier, off-list
>> attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
>> the multifd core. If we're going to add support for more data types to
>> multifd, we first need to clean that up.
>> 
>> This time around this work was prompted by Maciej's series[1]. I see
>> you're having to add a bunch of is_device_state checks to work around
>> the rigidity of the code.
>> 
>> Aside from the VFIO work, there is also the intent (coming back from
>> Juan's ideas) to make multifd the default code path for migration,
>> which will have to include the vmstate migration and anything else we
>> put on the stream via QEMUFile.
>> 
>> I have long since been bothered by having 'pages' sprinkled all over
>> the code, so I might be coming at this with a bit of a narrow focus,
>> but I believe in order to support more types of payloads in multifd,
>> we need to first allow the scheduling at multifd_send_pages() to be
>> independent of MultiFDPages_t. So here it is. Let me know what you
>> think.
>
> Thanks for the patch set, I quickly glanced at these patches and they
> definitely make sense to me.
>
> I guess its latest version could be found in the repo at [2] since
> that's where the CI run mentioned below took it from?

Yes

>
>> (as I said, I'll be off for a couple of weeks, so feel free to
>> incorporate any of this code if it's useful. Or to ignore it
>> completely).
>
> I guess you are targeting QEMU 9.2 rather than 9.1 since 9.1 has
> feature freeze in about a month, correct?
>

For general code improvements like this I'm not thinking about QEMU
releases at all. But this series is not super complex, so I could
imagine we merging it in time for 9.1 if we reach an agreement.

Are you thinking your series might miss the target? Or have concerns
over the stability of the refactoring? We can within reason merge code
based on the current framework and improve things on top, we already did
something similar when merging zero-page support. I don't have an issue
with that.


>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1340992028
>> 
>> 0- https://github.com/farosas/qemu/commits/multifd-packet-cleanups/
>> 1- https://lore.kernel.org/r/cover.1718717584.git.maciej.szmigiero@oracle.com
>
> [2]: https://gitlab.com/farosas/qemu/-/commits/multifd-pages-decouple
>
> Thanks,
> Maciej

