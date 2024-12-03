Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E361BE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXBI-0007ju-I8; Tue, 03 Dec 2024 12:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIXBA-0007jc-V3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:59:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIXB9-0007ln-1v
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:59:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1471421166;
 Tue,  3 Dec 2024 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733248756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SnSkBMdWleG2EPCq5vyT3CvZtilUWyabqhGSu6C5lk=;
 b=Cmnk+rNaM9ufq7Huip1mOq6FOIPyNziYJLRaNEjZoUCM4+PdiWE7aWJEYjwuV0Q2by9Ov+
 WZR4BtotvtQej2NaL9qLWEAcXEveqIbuScXnlNW7x93DZ8spzxgShftQ7OtsNKM6hQfesZ
 wt1936wCPLBIKhDCUmVj7RQ9/t0e7Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733248756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SnSkBMdWleG2EPCq5vyT3CvZtilUWyabqhGSu6C5lk=;
 b=VKtN+DZJEO75klYxOOMJu9ytVk1qIYv/cIgfPEPlpB92PKrbB8ED5RqnFgdjf4vK4B51uv
 5ed2QxqZ+1nkocDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cmnk+rNa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VKtN+DZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733248756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SnSkBMdWleG2EPCq5vyT3CvZtilUWyabqhGSu6C5lk=;
 b=Cmnk+rNaM9ufq7Huip1mOq6FOIPyNziYJLRaNEjZoUCM4+PdiWE7aWJEYjwuV0Q2by9Ov+
 WZR4BtotvtQej2NaL9qLWEAcXEveqIbuScXnlNW7x93DZ8spzxgShftQ7OtsNKM6hQfesZ
 wt1936wCPLBIKhDCUmVj7RQ9/t0e7Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733248756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SnSkBMdWleG2EPCq5vyT3CvZtilUWyabqhGSu6C5lk=;
 b=VKtN+DZJEO75klYxOOMJu9ytVk1qIYv/cIgfPEPlpB92PKrbB8ED5RqnFgdjf4vK4B51uv
 5ed2QxqZ+1nkocDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F33613A15;
 Tue,  3 Dec 2024 17:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3UgaFfNGT2eLdwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Dec 2024 17:59:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, linuxarm@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH] migration/multifd: Fix compile error caused by
 page_size usage
In-Reply-To: <Z09AZ06nSg2R_TIZ@x1n>
References: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
 <87zflcj485.fsf@suse.de> <Z09AZ06nSg2R_TIZ@x1n>
Date: Tue, 03 Dec 2024 14:59:12 -0300
Message-ID: <87ttbkir67.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1471421166
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Dec 03, 2024 at 10:17:14AM -0300, Fabiano Rosas wrote:
>> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
>> 
>> > From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
>> > page_count") onwards page_size is not part of MutiFD*Params but uses
>> > an inline constant instead.
>> >
>> > However, it missed updating an old usage, causing a compile error.
>> >
>> > Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
>> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> Wanna pick this up for your qtest pull for 10.0 altogether?

Yep

