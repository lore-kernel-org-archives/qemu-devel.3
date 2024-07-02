Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21803C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYZi-0004IZ-Pj; Tue, 02 Jul 2024 04:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOYZg-0004GZ-6b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:09:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sOYZe-0003kC-BO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:09:15 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 11A921FB8E;
 Tue,  2 Jul 2024 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719907749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhAn2Q5AIYGvUS54A7dLYPFEJO9dOZJ2l+Had+N9ZfM=;
 b=tTebhrZZtsz5R1mgePKtutV1OjPdDaoUN15u8mHRFXKyjgqxvERBsUor1qGxbDmfSIAzAO
 ADYeYu28wOoxCfSKupZJ6jxko+pXM409fb/ex32OeB7jaTUZt+pYdF/TAxC8v07ada7OCb
 8AfqjRDWwDtt7gbJ+Jj7itwXoeSLXOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719907749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhAn2Q5AIYGvUS54A7dLYPFEJO9dOZJ2l+Had+N9ZfM=;
 b=rJP66zbT1QtbSa59uEcm+wsVWUQtMxOXsd7lCdtIJ/ujjuMFZ20lE6/Z7j9VrAVxQWNBjV
 cTC4EpJdy3N80ZAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719907748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhAn2Q5AIYGvUS54A7dLYPFEJO9dOZJ2l+Had+N9ZfM=;
 b=SJV0u2JAmzCbJzSdwMU/t6Ioiy9LvIeidud40X+iwy/AG9MAc8Zt6HeoIR2MNppvq2ZzN3
 eCAapZapOMGZbnSSyOymAkQZlbbkH2HQaPDh8xtrdPYuFfeDkvXZc5VoVn8nVnllrN7HDF
 vtCKvMJqehWdyUlP6tx6r6uvLnQjUSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719907748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhAn2Q5AIYGvUS54A7dLYPFEJO9dOZJ2l+Had+N9ZfM=;
 b=gUXGKP0DaHMKkVX1r8jKad1xpxvEkUcKdfab2ZHzVi4+xh6B7g8jefkaEhoO0/+2mq2Eaj
 10sm8+99FpONyRDA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 063A64A0550; Tue,  2 Jul 2024 10:09:08 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
In-Reply-To: <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org> (Richard
 Henderson's message of "Mon, 1 Jul 2024 09:05:13 -0700")
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de>
 <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
X-Yow: Okay, BARBRA STREISAND, I recognize you now!!  Also EFREM ZIMBALIST,
 JUNIOR!!  And BEAUMONT NEWHALL!!  Everybody into th' BATHROOM!
Date: Tue, 02 Jul 2024 10:09:08 +0200
Message-ID: <mvm7ce4jjvf.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.19 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.961]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[hawking.nue2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Jul 01 2024, Richard Henderson wrote:

> With -d page, I get
>
> Locating guest address space @ 0x3f4000

Why do you get a different address?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

