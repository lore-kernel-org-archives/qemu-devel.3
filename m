Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0832D59D71
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgTS-0003iA-B5; Mon, 25 Nov 2024 16:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFgTP-0003hx-Fg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:18:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFgTN-0000fr-Qz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:18:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EE721F453;
 Mon, 25 Nov 2024 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732569498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgBveMF9V33fYL0Yl98VcKJcYih5k3Sud0sO4XAM5t8=;
 b=GNg5g/0Qza1Ogc7jREbOisCuWJO3/pDnT1snJALDZaIz08qNcMH5rF3gkcUhe0L+Wb4Pjt
 SCSZrMeV8yyQavyVvHSe7X0FjH9V30hUwfRq4BZeKJHsIrTZ0uvfpNbpd2khWZLFLIqoGa
 DJbI11++A4UwxEDU43nJCc5xNIaM0F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732569498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgBveMF9V33fYL0Yl98VcKJcYih5k3Sud0sO4XAM5t8=;
 b=wUJtnjRa3ZanJUqoomrRxRbnJypn5RNcobqzf1AFBX5PchlVpO3ttzVu46T8PtXV3w3yF9
 H4sJysQmBnxuA2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732569498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgBveMF9V33fYL0Yl98VcKJcYih5k3Sud0sO4XAM5t8=;
 b=GNg5g/0Qza1Ogc7jREbOisCuWJO3/pDnT1snJALDZaIz08qNcMH5rF3gkcUhe0L+Wb4Pjt
 SCSZrMeV8yyQavyVvHSe7X0FjH9V30hUwfRq4BZeKJHsIrTZ0uvfpNbpd2khWZLFLIqoGa
 DJbI11++A4UwxEDU43nJCc5xNIaM0F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732569498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YgBveMF9V33fYL0Yl98VcKJcYih5k3Sud0sO4XAM5t8=;
 b=wUJtnjRa3ZanJUqoomrRxRbnJypn5RNcobqzf1AFBX5PchlVpO3ttzVu46T8PtXV3w3yF9
 H4sJysQmBnxuA2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BE38137D4;
 Mon, 25 Nov 2024 21:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLFGGJnpRGfNRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 21:18:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 00/22] tests/qtest: migration-test refactoring
In-Reply-To: <Z0TlE9PNsTR5CWKO@x1n>
References: <20241113194630.3385-1-farosas@suse.de> <Z0TlE9PNsTR5CWKO@x1n>
Date: Mon, 25 Nov 2024 18:18:15 -0300
Message-ID: <874j3vnhbc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Wed, Nov 13, 2024 at 04:46:08PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas (22):
>>   tests/qtest/migration: Fix indentations
>>   tests/qtest/migration: Standardize hook names
>>   tests/qtest/migration: Stop calling everything "test"
>>   tests/migration: Disambiguate guestperf vs. a-b
>>   tests/qtest/migration: Move bootfile code to its own file
>>   tests/qtest/migration: Move qmp helpers to a separate file
>>   tests/qtest/migration: Rename migration-helpers.c
>>   tests/qtest/migration: Move ufd_version_check to utils
>>   tests/qtest/migration: Move kvm_dirty_ring_supported to utils
>>   tests/qtest/migration: Isolate test initialization
>>   tests/qtest/migration: Move common test code
>>   tests/qtest/migration: Split TLS tests from migration-test.c
>>   tests/qtest/migration: Split compression tests from migration-test.c
>>   tests/qtest/migration: Split postcopy tests
>>   tests/qtest/migration: Split file tests
>>   tests/qtest/migration: Split precopy tests
>>   tests/qtest/migration: Split CPR tests
>>   tests/qtest/migration: Split validation tests + misc
>
> I'm not sure whether the above chunk could affect people reading the last
> four, which is the real meat.
>
> One thing we could do (but you can decide which you prefer..) is you can
> respin with the initial 18 patches, then we may get it in in the 1st 10.0
> pull.  It may conflict with some other series for sure, but it's
> unavoidable with such changes one way or another..

I can put them on top of migration-next, sure. As I said previously,
just point me at any conflicting series and I can provide a rebase.

> then when it's there we could repost the last four separately, so it
> can have a higher chance of getting some comments.  So I'll leave that
> to you to decide.

That's fine.

>
> I also wonder whether we could already move migration-test*.c into
> tests/qtest/migration/ too.

I'll look into it.

