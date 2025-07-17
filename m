Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D4FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucOUr-0004Rd-DP; Thu, 17 Jul 2025 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ucNpW-00070E-FU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:35:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ucNpU-0006TX-2T
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:35:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6807F218E8;
 Thu, 17 Jul 2025 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752755712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvUa9b3PDMy+TN1SCGGgbPkgPl4be6d25QEq9+U/TKQ=;
 b=PFQv3590uTMhAO9BLcYY5xOzd/YQAQKgOAvbuRBLce+LQqz1t6qGLPCY9W/xjKNFx5c6sT
 OLwZ7B9csiCJ8PiGv/cj+vj5AcgFj1R2glXT6h3XN3tk0v9DMDRN7NsmcxHd1glIIkgy/p
 qfCtwREprSU6ELbPcs5MpUyPqyZ2Gmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752755712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvUa9b3PDMy+TN1SCGGgbPkgPl4be6d25QEq9+U/TKQ=;
 b=eD5BVaWq2JCfNHSPir9DzLjW+PjTt3RKdtJyIpRckRrVbs6XhdMj9FNspKQVWQDeWsglaL
 pvu4NDmPPjBnV/CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PFQv3590;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eD5BVaWq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752755712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvUa9b3PDMy+TN1SCGGgbPkgPl4be6d25QEq9+U/TKQ=;
 b=PFQv3590uTMhAO9BLcYY5xOzd/YQAQKgOAvbuRBLce+LQqz1t6qGLPCY9W/xjKNFx5c6sT
 OLwZ7B9csiCJ8PiGv/cj+vj5AcgFj1R2glXT6h3XN3tk0v9DMDRN7NsmcxHd1glIIkgy/p
 qfCtwREprSU6ELbPcs5MpUyPqyZ2Gmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752755712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvUa9b3PDMy+TN1SCGGgbPkgPl4be6d25QEq9+U/TKQ=;
 b=eD5BVaWq2JCfNHSPir9DzLjW+PjTt3RKdtJyIpRckRrVbs6XhdMj9FNspKQVWQDeWsglaL
 pvu4NDmPPjBnV/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D81FB1392A;
 Thu, 17 Jul 2025 12:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lPV4Jf/teGhWEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Jul 2025 12:35:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
In-Reply-To: <CAE8KmOxPLS9Zd+_uGRSBJwxDb6NcqOnLK7bTLeJ0mKKUs+gMxg@mail.gmail.com>
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
 <CAE8KmOzrFF79P4qUOxH4UtzuymGUWTcSLQan-ee=+EaVwv2dBQ@mail.gmail.com>
 <8734awmf5m.fsf@suse.de>
 <CAE8KmOxPLS9Zd+_uGRSBJwxDb6NcqOnLK7bTLeJ0mKKUs+gMxg@mail.gmail.com>
Date: Thu, 17 Jul 2025 09:35:09 -0300
Message-ID: <87tt3bknb6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6807F218E8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Wed, 16 Jul 2025 at 19:06, Fabiano Rosas <farosas@suse.de> wrote:
>> The condition should be >=.
>
> * I'm thinking of doing away with the loop and the string array. The
> array has 3 values of which only one gets used due to conversion to
> seconds.

The point is not to convert to seconds, but to fit the number of
microseconds in a range. Take a look at the output of 'info migrate -a'
with postcopy-blocktime capability enabled.

>
>> But then that's "0 sec" for 1000000 us.
>
> #define US  (MS * 1000) => 1000000
>
> When us = 1000000,  us / US should return "1 sec", no?
>

Sorry, I meant when the number of microseconds is smaller than a second.

> Thank you.
> ---
>   - Prasad

