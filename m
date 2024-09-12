Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B6EED60A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokos-0004Bt-4q; Thu, 12 Sep 2024 10:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokoi-0004BA-9v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:29:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokoX-0005sh-9H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:28:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1199521AF6;
 Thu, 12 Sep 2024 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726151331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2y8nHnoOvadOR8RkA6QN75stcmY3OY4Df7HDEkxBDI=;
 b=cAS2huPenATV01k4ChgAi+lo/OjVXc648mXuyzn9Me4ou8V1QJu7sbXL83U1R5TD+LtB+f
 h9LKZ7OsOZ3zt1/k0N3+lpN5dLfYg4pBimM7/2I2LT2CofgHB3utt+B1XPOuG0MZfbJ4ir
 TEqAxBKZhvyBE9Xfu5SwqwjSqqPgNXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726151331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2y8nHnoOvadOR8RkA6QN75stcmY3OY4Df7HDEkxBDI=;
 b=gjLal4D+Sd/GU+8gfQtwAofOyLySTInIS1lhJXKtmoxTRawnD5QQdxOf0rcWqfdOtSq/Y0
 P7dtoqtFRfM4zzBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726151331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2y8nHnoOvadOR8RkA6QN75stcmY3OY4Df7HDEkxBDI=;
 b=cAS2huPenATV01k4ChgAi+lo/OjVXc648mXuyzn9Me4ou8V1QJu7sbXL83U1R5TD+LtB+f
 h9LKZ7OsOZ3zt1/k0N3+lpN5dLfYg4pBimM7/2I2LT2CofgHB3utt+B1XPOuG0MZfbJ4ir
 TEqAxBKZhvyBE9Xfu5SwqwjSqqPgNXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726151331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2y8nHnoOvadOR8RkA6QN75stcmY3OY4Df7HDEkxBDI=;
 b=gjLal4D+Sd/GU+8gfQtwAofOyLySTInIS1lhJXKtmoxTRawnD5QQdxOf0rcWqfdOtSq/Y0
 P7dtoqtFRfM4zzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 901D013AD8;
 Thu, 12 Sep 2024 14:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EfeVFaL64mbZBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Sep 2024 14:28:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <CAFEAcA8Xrgf3nYYaOjaV_2+rtnLahMOdcBGReXpLKxyPm4u_pQ@mail.gmail.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <87wmjhvv7e.fsf@suse.de>
 <CAFEAcA8Xrgf3nYYaOjaV_2+rtnLahMOdcBGReXpLKxyPm4u_pQ@mail.gmail.com>
Date: Thu, 12 Sep 2024 11:28:48 -0300
Message-ID: <87a5gdgd3z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 12 Sept 2024 at 14:48, Fabiano Rosas <farosas@suse.de> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > For some examples from this week:
>> >
>> > https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
>> > https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
>> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
>> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
>>
>> About these:
>>
>> There are 2 instances of plain-old-SIGSEGV here. Both happen in
>> non-x86_64 runs and on the /multifd/tcp/plain/cancel test, which means
>> they're either races or memory ordering issues. Having i386 crashing
>> points to the former. So having the CI loaded and causing timeouts is
>> probably what exposed the issue.
>
> They're also both TCI. Would these tests be relying on
> specific atomic-access behaviour in the guest code that's
> running, or is all the avoidance-of-races in the migration
> code in QEMU itself?

I misspoke about memory ordering, this is all just the x86 host and the
multifd threads in QEMU having synchronization issues.

>
> (I don't know of any particular problems with TCI's
> implementation of atomic accesses, so this is just a stab
> in the dark.)
>
> thanks
> -- PMM

