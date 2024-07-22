Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B76C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzKS-0008Up-8z; Mon, 22 Jul 2024 16:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzKK-0007ry-Aj
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:08:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVzKH-0002LF-GO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:08:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2ABC21AE1;
 Mon, 22 Jul 2024 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721678881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu6pGruPExKVg1q1KTuY/IiIkTxiz5Z1RUwysDqLGA4=;
 b=Vam74ID5zle5JuaHNJI4DbR4gzPGsBSdu22i5aiE0hcM9ynFA4Ik78oe4iKuqWVX3JGZli
 sWr4o3uG4qcyyLBgu/vi2AdGZeQbP0KI2x5LNW+RMBERruQhnal2u0TXATAzVmBQZmGS5p
 jeVyLjrt4L1ORa7RrpB8/y/Q15BOydE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721678881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu6pGruPExKVg1q1KTuY/IiIkTxiz5Z1RUwysDqLGA4=;
 b=I325XBdAVkfSaQu9KYalVdJrB6hejA/2qDeSY07AQjX0XVGagLavicxgwjFNbEQXg/q208
 2rC+bttutclKwUBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mrZgkRwR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vuzoe3tm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721678880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu6pGruPExKVg1q1KTuY/IiIkTxiz5Z1RUwysDqLGA4=;
 b=mrZgkRwR8U6VXJcjxm/uWuRBjZtq93rzXhLZDGFbcNv9qlEFQK5ltvDDNtgFB30M7SQVGa
 yr1DrmUWhRNuFOUPDcMBYEksc61fAwlMbvQlQ+JXnS506HEucRmS6LnkCUY7sU9xWONywE
 xbgZ+YAhqSX03cQVulMB+6/+/yX/LDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721678880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu6pGruPExKVg1q1KTuY/IiIkTxiz5Z1RUwysDqLGA4=;
 b=vuzoe3tmpFP3Pd4JNvTDYEmbDwItiPwWhRpvUmQE03cPLHF1JapP+dlVSz35K6Cj/8wLeH
 UMbOIFyYnh5T/GBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 589B9138A7;
 Mon, 22 Jul 2024 20:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L6xXCCC8nmYzKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 20:08:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 6/9] migration/multifd: Move pages accounting
 into multifd_send_zero_page_detect()
In-Reply-To: <Zp6zF2oOHJMixISu@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-7-farosas@suse.de> <Zp6zF2oOHJMixISu@x1n>
Date: Mon, 22 Jul 2024 17:07:57 -0300
Message-ID: <87plr5yyua.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.31 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D2ABC21AE1
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Mon, Jul 22, 2024 at 02:59:11PM -0300, Fabiano Rosas wrote:
>> All references to pages are being removed from the multifd worker
>> threads in order to allow multifd to deal with different payload
>> types.
>> 
>> multifd_send_zero_page_detect() is called by all multifd migration
>> paths that deal with pages and is the last spot where zero pages and
>> normal page amounts are adjusted. Move the pages accounting into that
>> function.
>
> True, but it's a bit hackish to update (especially, normal) page counters
> in a zero page detect function.

Hm, that's the one place in the code that actually sets
normal_num. Seems adequate to me.

> I understand you want to move pages out of the thread function, that's
> fair. How about put it in your new multifd_ram_fill_packet()?
>

That one is skipped when mapped-ram is in use. I could move it to
nocomp_send_prepare() after the zero_page_detect. It seems we're moving
towards changing nocomp -> ram at some point anyway. Would that be
better? It would duplicate the call due to the compression code.


