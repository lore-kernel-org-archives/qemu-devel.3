Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FBDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC14b-0002y6-LW; Mon, 05 May 2025 15:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC14Z-0002x5-LG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:01:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uC14X-0008GF-DH
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:01:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1F621F391;
 Mon,  5 May 2025 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746471706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53VaswUpLaxSS9BW7TwiPgWAO2zbfb3x34REQ7Mugtg=;
 b=USsKccZwXBmAr7ADasdF59Xsq6WLpL6b8dlqbUso8k0HDDIyKp5Evx6QWj0+tnHUoXBXmZ
 yFxBBxWOrMhaxQNtFt5TlAX2IfcLz3kSVxar3WR+darcFoJdEobRn+HihfsoJ6pRhU0Eeb
 NjvbIsppiLOSeFTCHJTJPW8OH7LJee8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746471706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53VaswUpLaxSS9BW7TwiPgWAO2zbfb3x34REQ7Mugtg=;
 b=6ceVhfVZ31puOg+GigtCdoe8M92cICbLyzTWFswoemFMFO3GPo9gs5S/Q1vWP/U1WJPpJF
 boGPGRgkIMfdKbAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DsbkeBYv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cwY7qyyV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746471705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53VaswUpLaxSS9BW7TwiPgWAO2zbfb3x34REQ7Mugtg=;
 b=DsbkeBYvgCYRTNLq9PuVvCZrBSxI/6Nb/VokgZ7muazYdbfpHBAN8laZYxT9wIwLlDbPUO
 wXpsxY7upUWmyTO9vQ1CZ19TsS05p2m4oGAVL1UPdaNnwp5hEPiIwEe2YHV1Hev1pBug4x
 Rhabw895WatRpQiLhOltupHEhIQk4Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746471705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53VaswUpLaxSS9BW7TwiPgWAO2zbfb3x34REQ7Mugtg=;
 b=cwY7qyyVW4IHEITtuY7rmoaJcaFK0yQs1R5ksX4yyWfPPehuwZSdG2LSglw5PKnf29Y90j
 Nc0tvfIWG4lOwVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B26F1372E;
 Mon,  5 May 2025 19:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EwtUCxkLGWh8GAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 19:01:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
 <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
Date: Mon, 05 May 2025 16:01:42 -0300
Message-ID: <87y0vag9ux.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: F1F621F391
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Tue, 29 Apr 2025 at 18:34, Peter Xu <peterx@redhat.com> wrote:
>> I think that's what Fabiano mentioned, but ultimately we need to verify it
>> on a reproducer to know.
> ...
>> Looks ok, but please add some comments explain why postcopy needs to do it,
>> and especially do it during precopy phase.
>>
>> I'd use migrate_postcopy_ram() instead.
>
> * Okay. It should be '||' instead of '&&' in the first conditional I
> think, we want to write zeropage when postcopy is enabled.
> ===
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index dbc1184921..4d6677feab 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -85,9 +85,11 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
>          void *page = p->host + p->zero[i];
> -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> +        if (migrate_postcopy_ram() ||
> +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              memset(page, 0, multifd_ram_page_size());
> -        } else {
> +        }
> +        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
>          }
>      }
> ===

I applied this diff and I'm not seeing the hang anymore.


