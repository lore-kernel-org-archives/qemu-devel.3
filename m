Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E85E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyQs-0005Ji-7L; Wed, 18 Dec 2024 13:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dsterba@suse.cz>) id 1tNyIW-0003N3-32
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:57:24 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dsterba@suse.cz>) id 1tNyIU-0002hD-Fm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:57:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69D3F1F396;
 Wed, 18 Dec 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734544639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
 b=IO77DBBmmo5IO25PJrBaW1lyPFyCmVO8hLEPKALr12BYpfqkYO/bb3vgdMywsPBXup+xBP
 FJLnDqac5cvPRZX4/MEL8vT5n51dlT8En9MGRZ17P+ITF34jzEpJ1qjTNyrlyd+QatfYF1
 K1vqsXLNAa5VaP25DnSEQOVuBbX3UH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734544639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
 b=HOAdHZ33gN4tFOuq97/OBFU7nh4aGK0FWIMyPlAAfa4KRFs8PB4Gs7sgZN6ccOmhUTtfOz
 66iKvb1mJbGUceCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734544638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
 b=nB1BKta+MmBC9c0Kpsz50liSlps+HsuojVZC0wflIhcBOXENIN0L/Oejmg0NzoeyFe9b1L
 iubN0btzwaaHrtJQNK+PM5wib5PXgOpsSagwv7R6ZpupWea6dR+CjuWtoCo5NL8k+lyvQI
 1qPESaLcXU2nHwf8vO1tSkmC6flNVf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734544638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyqu7+5hM/O675sj05pWPBOwQ7+qTbm8DFtagxH8B5Q=;
 b=P9IEKNc38XOWAd9vPBDvgmOteNTo+CrsYoclclFQc9IPKjDX/l7EZyaF0+APk1SH+/UQR2
 I0LDEo23Ur7WD8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 479AC137CF;
 Wed, 18 Dec 2024 17:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hXXuEP4MY2e/ZAAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 17:57:18 +0000
Date: Wed, 18 Dec 2024 18:57:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: qemu-devel@nongnu.org, open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Linux btrfs <linux-btrfs@vger.kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Qu Wenruo <wqu@suse.com>,
 David Sterba <dsterba@suse.com>
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
Message-ID: <20241218175716.GD31418@twin.jikos.cz>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=dsterba@suse.cz;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Dec 2024 13:05:48 -0500
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
Reply-To: dsterba@suse.cz
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 18, 2024 at 09:22:26PM +0530, Naresh Kamboju wrote:
> On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The following kernel crash noticed on qemu-arm64 while running the
> > Linux next-20241210 tag (to next-20241218) kernel built with
> >  - CONFIG_ARM64_64K_PAGES=y
> >  - CONFIG_ARM64_16K_PAGES=y
> > and running LTP smoke tests.
> >
> > First seen on Linux next-20241210.
> >   Good: next-20241209
> >   Bad:  next-20241210 and next-20241218
> >
> > qemu-arm64: 9.1.2
> >
> > Anyone noticed this ?
> >
> 
> Anders bisected this reported regression and found,
> # first bad commit:
>   [9c1d66793b6faa00106ae4c866359578bfc012d2]
>   btrfs: validate system chunk array at btrfs_validate_super()

Thanks, I'll drop the patch from linux-next for now.

