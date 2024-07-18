Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF75C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYf8-0002HF-K9; Thu, 18 Jul 2024 17:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUYf6-0002GO-WD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:27:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUYf5-0003uH-Fx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:27:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26FC5219FF;
 Thu, 18 Jul 2024 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721338056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0452bmVJHuAVdmWsqEsVP8xd2q0VLE8V30T2FTdSOE=;
 b=at5v7ugq3Xa2MoyiUJMNTANINP70m/KC+mwl8eZMLLX8/QAPCgMg5e+kAymgmRq0yknLuK
 lCuNKD7PwG3GYDH6ZlVjyXzZfmjhOsDXHZUpsRZBvNk34rwZ/KR/tiBhjhbktkY6qwMsLW
 eWIZy+fSiHKi4mcK1AXqsleo9KakEHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721338056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0452bmVJHuAVdmWsqEsVP8xd2q0VLE8V30T2FTdSOE=;
 b=7BtCKmVPKw1WHaW+laJ6ag2meIz5olWT2RXooW2Qoi5f1TXoedEWBl+FL8nTLuqFtvt5Gn
 RzsSC7Q6dig4ekBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721338055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0452bmVJHuAVdmWsqEsVP8xd2q0VLE8V30T2FTdSOE=;
 b=nCXLFB3nWnmNGqRbPS9B9thzoLkbuVx0c9cuD4Z/V1LT1BEHtzxtG7G2ahAJNq42eMUs4p
 Z2G85K/admFzcvELWZ2OgK/qEwL+2/tVS0lNk9in2dr7y5O5hXl5K3FrkGGFKyWZivDIfE
 sam71bIh7ukOpDSrSVBB9gqCc0nnv6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721338055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0452bmVJHuAVdmWsqEsVP8xd2q0VLE8V30T2FTdSOE=;
 b=Z7dYgKuUmcMMfHwDk6erDOpwaj6CLpdPlx85cJmLyoUAormVVNhriBlxbr3SpKfLRZiVAP
 SGtjyFzWQzaYYeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1B08136F7;
 Thu, 18 Jul 2024 21:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zw7vGcaImWaWDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jul 2024 21:27:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpmFT9O-UN30i1F1@x1n>
References: <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com> <Zn15y693g0AkDbYD@x1n>
 <877cdtfcsi.fsf@suse.de> <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n>
 <87jzhi1odn.fsf@suse.de> <ZpmFT9O-UN30i1F1@x1n>
Date: Thu, 18 Jul 2024 18:27:32 -0300
Message-ID: <87frs61jcr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[4]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
>> v2 is ready, but unfortunately this approach doesn't work. When client A
>> takes the payload, it fills it with it's data, which may include
>> allocating memory. MultiFDPages_t does that for the offset. This means
>> we need a round of free/malloc at every packet sent. For every client
>> and every allocation they decide to do.
>
> Shouldn't be a blocker?  E.g. one option is:
>
>     /* Allocate both the pages + offset[] */
>     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
>                                       sizeof(ram_addr_t) * n, 1);
>     pages->allocated = n;
>     pages->offset = &pages[1];
>
> Or.. we can also make offset[] dynamic size, if that looks less tricky:
>
> typedef struct {
>     /* number of used pages */
>     uint32_t num;
>     /* number of normal pages */
>     uint32_t normal_num;
>     /* number of allocated pages */
>     uint32_t allocated;
>     RAMBlock *block;
>     /* offset of each page */
>     ram_addr_t offset[0];
> } MultiFDPages_t;

I think you missed the point. If we hold a pointer inside the payload,
we lose the reference when the other client takes the structure and puts
its own data there. So we'll need to alloc/free everytime we send a
packet.

